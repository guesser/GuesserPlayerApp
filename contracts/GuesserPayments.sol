pragma solidity ^0.4.23;

import "./GuesserCore.sol";

contract GuesserPayments is GuesserCore {
  // Semi Constants
  uint32 CREATOR_FEE = 100;
  uint32 VALIDATOR_FEE = 50;
  uint32 GUESSER_FEE = 50;

  //Events
  event GuessVoted(uint256 index,
                   uint8 option,
                   string title,
                   string optionName,
                   uint256 value,
                   address user);
  event GuessValidated(uint256 guess, uint8 option, address sender);
  event ProfitsReturned(uint256 guess);

  // The current owners
  mapping(address => bool) accessAllowed;
  address[] access;

  // Guesser Funds
  uint128 guesserFunds = 0;

  constructor (address _address) GuesserCore (_address) public {
    accessAllowed[msg.sender] = true;
    access.push(msg.sender);
  }

  modifier isOwner () {
    require (accessAllowed[msg.sender] == true);
    _;
  }

  function setOwner (address _address) isOwner public {
    accessAllowed[_address] = true;
    access.push(msg.sender);
  }

  function getOwner (uint256 _ownerIndex) isOwner view public returns (address) {
    return access[_ownerIndex];
  }

  /* dev Voting a guess
  * @param _guess uint256 the guess the person is voting to
  * @param _option uint8 the option the person is voting to (1 or 2)
   */
  function voteGuess(uint256 _guess, uint8 _option) public payable {
    // Does the guess exists?
    require (_guess < guesserStorage.getGuessLength());
    // Is the option valid?
    require(_option == 1 || _option == 2);
    // Is the date due?
    require(DateTime.dateDue(guesserStorage.getGuessFinalDate(_guess)) == false);

    if (guesserStorage.getGuessVotersOption(_guess, msg.sender, 0) == uint8(0x0)) {
      guesserStorage.setGuessVoterOption(_guess, msg.sender, 0, _option);
      guesserStorage.pushVoter(_guess, msg.sender); // New Voter
    } else {
      guesserStorage.setGuessVoterOption(_guess, msg.sender, 0, 3);
    }
    // Option profits by address
    guesserStorage.setGuessVoterOption(_guess, msg.sender, _option, uint128(msg.value));

    guesserStorage.pushGuessesByAddress(msg.sender, _guess);

    if (_option == 1) {
      guesserStorage.increaseVote(_guess, 1, 1);
      emit GuessVoted(_guess,
                 _option,
                 guesserStorage.getGuessTitle(_guess),
                 guesserStorage.getGuessOption(_guess, 1),
                 msg.value,
                 msg.sender);
    } else {
      guesserStorage.increaseVote(_guess, 2, 1);
      emit GuessVoted(_guess,
                 _option,
                 guesserStorage.getGuessTitle(_guess),
                 guesserStorage.getGuessOption(_guess, 2),
                 msg.value,
                 msg.sender);
    }
  }

  /* @dev Function to validate the guesses
  * @param _guess uint256 the guess the validator is validating
  * @param _option uint8 the option the validator thinks is the correct
  */
  function validateGuess(uint256 _guess, uint8 _option) public payable {
    // Does the guess exists?
    require(_guess < guesserStorage.getGuessLength());
    // Has the validator already choose?
    require(guesserStorage.getGuessValidatorsOption(_guess, msg.sender) == uint8(0x0));
    // Is the option valid?
    require(_option == 1 || _option == 2);
    // Is the date due?
    require(DateTime.dateDue(guesserStorage.getGuessValidationDate(_guess)) == true);
    // Has the validator voted the guess?
    require(guesserStorage.getGuessVotersOption(_guess, msg.sender, 0) == uint256(0x0));

    uint128 _validations = guesserStorage.getGuessOptionValidation(_guess, 1) + guesserStorage.getGuessOptionValidation(_guess, 2);
    uint128 _votes = guesserStorage.getGuessOptionVotes(_guess, 1) + guesserStorage.getGuessOptionVotes(_guess, 2);

    // Enough validations
    uint128 _half = (_votes/2) + 1;
    require(_validations < _half);

    guesserStorage.setGuessValidatorOption(_guess, msg.sender, _option);
    guesserStorage.pushValidators(_guess, msg.sender);
    if (_option == 1) {
      guesserStorage.increaseValidation(_guess, 1, 1);
    } else {
      guesserStorage.increaseValidation(_guess, 2, 1);
    }
    _validations += 1;
    emit GuessValidated(_guess, _option, msg.sender);
  }

  /**
  * @dev Function that returns the profit to the voters
  * @param _guess uint256 the event to ask for the profits of
  */
  function returnProfits (uint256 _guess) external {
    // Does the guess exists?
    require(_guess < guesserStorage.getGuessLength());
    // Is the date due?
    require(getEventItemState(_guess) == "passed");
    // Have the profits already been returned to this address
    require(guesserStorage.getGuessProfitsReturned(_guess, msg.sender) == false);

    uint256 _amountToSend = 0;
    uint8 _winner = getGuessWinner(_guess);
    uint256 _totalProfits = getGuessProfits(_guess);

    uint128 _validationOption = guesserStorage.getGuessValidatorsOption(
                                                                        _guess,
                                                                        msg.sender
                                                                        );
    uint128 _votingOption = guesserStorage.getGuessVotersOption(_guess, msg.sender, 0);

    // Check if address voted the event
    if (_votingOption == _winner || _votingOption == 3) {
      uint256 _validatorsLength = guesserStorage.getGuessValidatorsLength(_guess);
      uint128 _totalWinnersProfits = getGuessProfitsByOption(_guess, _winner);
      uint128 _addressAmount = guesserStorage.getGuessVotersOption(
                                                                   _guess,
                                                                   msg.sender,
                                                                   _winner);
      uint256 _percentage = uint256((_totalWinnersProfits * 10) / _addressAmount) / 10;
      _amountToSend += uint256(_totalProfits-(
                                               (_totalProfits / CREATOR_FEE) +
                                               (_totalProfits / VALIDATOR_FEE) +
                                               (_totalProfits / GUESSER_FEE)
                                ) / _percentage);
    } else if (_validationOption == _winner) {
      // Check if address validated the event
      // Check if the address validated the correct option
      _amountToSend += _totalProfits/(_validatorsLength * VALIDATOR_FEE);
    }

    // Check if address created the event
    if (guesserStorage.getGuessCreator(_guess) == msg.sender) {
      _amountToSend += _totalProfits/CREATOR_FEE;
    }

    if (_amountToSend != 0) {
      msg.sender.transfer(_amountToSend);
    }
    guesserStorage.setGuessProfitsReturned(_guess, msg.sender, true);
  }


  //Withdrawing funds
  function withdrawValidationEth (uint256 _amount, uint256 _ownerIndex) isOwner public {
    access[_ownerIndex].transfer(_amount);
  }

  function getGuesserFunds () public view returns (uint128) {
    return guesserFunds;
  }


  // Change fees
  // Getters
  /*
  function getCreatorFee () public returns (uint32) {
    return CREATOR_FEE;
  }

  function getValidatorFee () public returns (uint32) {
    return VALIDATOR_FEE;
  }

  function getGuesserFee () public returns (uint32) {
    return GUESSER_FEE;
  }
  // Setters
  function setCreatorFee (uint32 _newFee) isOwner public {
    CREATOR_FEE = _newFee;
  }

  function setValidatorFee (uint32 _newFee) isOwner public {
    VALIDATOR_FEE = _newFee;
  }

  function setGuesserFee (uint32 _newFee) isOwner public {
    GUESSER_FEE = _newFee;
  }
    */
}
