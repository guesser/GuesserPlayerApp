pragma solidity ^0.4.23;

import "./GuesserCore.sol";

contract GuesserPayments is GuesserCore {
  //Events
  event GuessVoted(uint256 index,
                   uint8 option,
                   string title,
                   string optionName,
                   uint256 value,
                   address user);
  event GuessValidated(uint256 guess, uint8 option, address sender);
  event ProfitsReturned(uint256 guess);

  uint256 votesEthAmount = 0;
  uint256 validationEthAmount = 0;

  // The current owners
  mapping(address => bool) accessAllowed;
  address[] access;

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
    votesEthAmount += msg.value;


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

    uint128 validations = guesserStorage.getGuessOptionValidation(_guess, 1) + guesserStorage.getGuessOptionValidation(_guess, 2);
    uint128 votes = guesserStorage.getGuessOptionVotes(_guess, 1) + guesserStorage.getGuessOptionVotes(_guess, 2);

    // Enough validations
    uint128 half = ((((votes * 10) / 2) - ((votes * 10) / 2) % 10) / 10) + 1; // Divide by 2
    require(validations < half);

    guesserStorage.setGuessValidatorOption(_guess, msg.sender, _option);
    guesserStorage.pushValidators(_guess, msg.sender);
    if (_option == 1) {
      guesserStorage.increaseValidation(_guess, 1, 1);
    } else {
      guesserStorage.increaseValidation(_guess, 2, 1);
    }
    validations += 1;
    validationEthAmount += msg.value;
    if (validations == half) {
      returnProfits(_guess);
    }
    emit GuessValidated(_guess, _option, msg.sender);
  }

  /**
  * @dev Function that returns the profit to the voters
  * @param _guess uint256 the event to ask for the profits of
    */
  function returnProfits (uint256 _guess) private {
    // Does the guess exists?
    require(_guess < guesserStorage.getGuessLength());
    // Is the date due?
    require(DateTime.dateDue(guesserStorage.getGuessFinalDate(_guess)) == true);
    // Has anybody voted in the guess?
    require(guesserStorage.getGuessVotersLength(_guess) > 0);
    // Has anybody validated the guess?
    require(guesserStorage.getGuessValidatorsLength(_guess) > 0);
    // Have the profits already been returned
    require(guesserStorage.getGuessProfitsReturned(_guess) == false);


    uint8 _winner = getGuessWinner(_guess);

    // If there is only one voter (even in both sides)
    if (guesserStorage.getGuessVotersLength(_guess) == 1) {
      returnProfitsOnlyOneVoter(_guess);
      return;
    } else {
      // If there is only one side of the votes, they are instantly the winners
      if (guesserStorage.getGuessOptionVotes(_guess, 2) == 0 ) {
        _winner = 1; // The winner is the first one
      } else if (guesserStorage.getGuessOptionVotes(_guess, 1) == 0) {
        _winner = 2; // The winner is the second one
      }

      uint128 _totalProfits = getGuessProfits(_guess);
      uint128 _totalWinnersProfits = getGuessProfitsByOption(_guess, _winner);
      for(uint256 _voterIndex = 0; _voterIndex < guesserStorage.getGuessVotersLength(_guess); _voterIndex++) {
        returnVoterProfits(_guess,
                           _voterIndex,
                           _totalProfits,
                           _totalWinnersProfits,
                           _winner);
      }

      guesserStorage.setGuessProfitsReturned(_guess, true);
      // Release the event
      emit ProfitsReturned(_guess);
    }
  }

  function returnVoterProfits (uint256 _guess,
                               uint256 _voterIndex,
                               uint128 _totalProfits,
                               uint128 _totalWinnersProfits,
                               uint8 _winner) private {
    uint256 percentage; // The percentage of the win a person has
    address person = guesserStorage.getGuessVoter(_guess, _voterIndex);
    uint128 _personOption = guesserStorage.getGuessVotersOption(
                                                                _guess,
                                                                person,
                                                                0);
    if (_personOption == uint128(_winner) || _personOption == uint128(3)) {
      uint256 index = 10;
      uint256 _precision = 0;
      while (_totalProfits*100 > index) {
        index = index * 10;
        _precision++;
      }
      // Check if the user voted the winner option or both options (3)
      // Get the percentage of the person in the winner option
      percentage = percent(
                           _personOption,
                           _totalWinnersProfits,
                           _precision
                           );
      uint256 _final = ((_totalProfits * 10) * percentage);
      // WARNING: Only will work with non contracts addresses
      guesserStorage.getGuessVoter(_guess, _voterIndex).transfer(_final/index); //Error
    }
  }

  function returnProfitsOnlyOneVoter (uint256 _guess) private {
    require(guesserStorage.getGuessVotersLength(_guess) == 1);

    address _onlyVoter = guesserStorage.getGuessVoter(_guess, 0);
    uint256 _profits = guesserStorage.getGuessVotersOption(_guess, _onlyVoter, 1) +
      guesserStorage.getGuessVotersOption(_guess, _onlyVoter, 2);

    _onlyVoter.transfer(_profits); //Error
    guesserStorage.setGuessProfitsReturned(_guess, true);
    emit ProfitsReturned(_guess);
  }

  //Withdrawing funds
  function withdrawVotesEth (uint256 _amount, uint256 _ownerIndex) isOwner public {
    require (votesEthAmount > _amount);

    access[_ownerIndex].transfer(_amount);
  }

  function withdrawValidationEth (uint256 _amount, uint256 _ownerIndex) isOwner public {
    require (validationEthAmount > _amount);

    access[_ownerIndex].transfer(_amount);
  }
}
