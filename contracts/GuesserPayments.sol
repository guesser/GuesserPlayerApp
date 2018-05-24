pragma solidity ^0.4.23;

import "./GuesserCore.sol";

contract GuesserPayments is GuesserCore {
  // Semi Constants
  uint32 CREATOR_FEE = 100;
  uint32 VALIDATOR_FEE = 200;
  uint32 GUESSER_FEE = 100;

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
    if (_validations == _half) {
      returnProfits(_guess);
    }
    emit GuessValidated(_guess, _option, msg.sender);
  }

  /**
  * @dev Function that returns the profit to the voters
  * @param _guess uint256 the event to ask for the profits of
  */
  function returnProfits (uint256 _guess) private {
    uint256 _votersLength = guesserStorage.getGuessVotersLength(_guess);
    uint256 _validatorsLength = guesserStorage.getGuessValidatorsLength(_guess);
    // Does the guess exists?
    require(_guess < guesserStorage.getGuessLength());
    // Is the date due?
    require(DateTime.dateDue(guesserStorage.getGuessFinalDate(_guess)) == true);
    // Has anybody voted in the guess?
    require( _votersLength > 0);
    // Has anybody validated the guess?
    require(_validatorsLength > 0);
    // Have the profits already been returned
    require(guesserStorage.getGuessProfitsReturned(_guess) == false);


    uint8 _winner = getGuessWinner(_guess);
    uint128 _totalProfits = getGuessProfits(_guess);

    // If there is only one voter (even in both sides)
    if (_votersLength == 1) {
      // Return profits to voters
      guesserStorage.getGuessVoter(_guess, 0).transfer(
                                                       _totalProfits-(_totalProfits/(CREATOR_FEE + VALIDATOR_FEE + GUESSER_FEE))
                                                      );
      // Return Profits to validators
      guesserStorage.getGuessValidator(_guess, 0).transfer(
                                                           _totalProfits/VALIDATOR_FEE);
    } else { // More than one voter
      for(uint256 _voterIndex = 0; _voterIndex < _votersLength; _voterIndex++) {
        returnVoterProfits(_guess,
                           _voterIndex,
                           _totalProfits,
                           _winner);
      }
      for(uint256 _validatorIndex = 0; _validatorIndex < _validatorsLength; _validatorIndex++) {
        guesserStorage.getGuessValidator(_guess, _validatorIndex).transfer(_totalProfits/_validatorsLength);
      }
    }

    // Return common profits
    // Return profits to creator
    guesserStorage.getGuessCreator(_guess).transfer(
                                                    _totalProfits/CREATOR_FEE);

    //Guesser profit
    guesserFunds += _totalProfits/GUESSER_FEE;

    guesserStorage.setGuessProfitsReturned(_guess, true);
    // Release the event
    emit ProfitsReturned(_guess);
  }

  function returnVoterProfits (uint256 _guess,
                               uint256 _voterIndex,
                               uint128 _totalProfits,
                               uint8 _winner) private {
    address _person = guesserStorage.getGuessVoter(_guess, _voterIndex);
    uint128 _personOption = guesserStorage.getGuessVotersOption(
                                                                _guess,
                                                                _person,
                                                                0);
    if (_personOption == uint128(_winner) || _personOption == uint128(3)) {
      // Check if the user voted the winner option or both options (3)

      // Amount of eth the address has bet
      uint128 _addressAmount = guesserStorage.getGuessVotersOption(
                                                                   _guess,
                                                                   _person,
                                                                   _winner);
      uint256 _percentage = uint256((_totalProfits * 100) / _addressAmount) / 100;
      uint256 _final = (((_totalProfits-(_totalProfits/(CREATOR_FEE + VALIDATOR_FEE + GUESSER_FEE)))  * 10) * _percentage);
      // WARNING: Only will work with non contracts addresses
      // Return Profits to voters
      guesserStorage.getGuessVoter(_guess, _voterIndex).transfer(_final);
    }
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
