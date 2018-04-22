pragma solidity ^0.4.23;

import "./GuesserCore.sol";

/**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract GuesserInputs is GuesserCore {
  // Events
  event GuessCreated(uint256 index, string title, bytes32 topic);
  event GuessVoted(uint256 index,
                   uint8 option,
                   string title,
                   string optionName,
                   uint256 value,
                   address user);
  event GuessValidated(uint256 guess, uint8 option, address sender);
  event ProfitsReturned(uint256 guess);
  event test_value(uint256 indexed value1);

  constructor (address _address) GuesserCore (_address) public {}

/**
  * @dev Function that creates a Guess.
  * @param _title string The title of the Guess.
    * @param _description string The description of the Guess
  * @param _topic bytes32 The topic of the Guess
  * @param _finalDate uint256 The final date of the Guess
  * @param _option1 string The first option to vote on the Guess
  * @param _option2 string The first option to vote on the Guess
  */
  function setGuess(
    string _title,
    string _description,
    bytes32 _topic,
    uint32 _finalDate,
    uint32 _validationDate,
    string _option1,
    string _option2
  ) public {
    // TODO: Make the require for the input variables
    guesserStorage.setGuess(
                            _title,
                            _finalDate,
                            _validationDate
                            );
    uint256 _len = guesserStorage.getGuessLength();
    guesserStorage.setGuessSecondOptions(
                                         _len,
                                         _description,
                                         _topic,
                                         _option1,
                                         _option2
                                         );
    emit GuessCreated(_len, _title, _topic);
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
  function validateGuess(uint256 _guess, uint8 _option) public {
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

    uint256 validations = guesserStorage.getGuessOptionValidation(_guess, 1) + guesserStorage.getGuessOptionValidation(_guess, 2);
    uint256 votes = guesserStorage.getGuessOptionVotes(_guess, 1) + guesserStorage.getGuessOptionVotes(_guess, 2);

    // Enough validations
    uint256 half = ((((votes * 10) / 2) - ((votes * 10) / 2) % 10) / 10) + 1; // Divide by 2
    require(validations < half);

    guesserStorage.setGuessValidatorOption(_guess, msg.sender, _option);
    guesserStorage.pushValidators(_guess, msg.sender);
    if (_option == 1) {
      guesserStorage.increaseValidation(_guess, 1, 1);
    } else {
      guesserStorage.increaseValidation(_guess, 2, 1);
    }
    emit GuessValidated(_guess, _option, msg.sender);
    validations += 1;
    if(validations == half) {
      returnProfits(_guess);
    }
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


    uint8 _winner;
    if (guesserStorage.getGuessOptionValidation(_guess, 1) > guesserStorage.getGuessOptionValidation(_guess, 2)) {
      _winner = 1; // The winner is the first one
    } else {
      _winner = 2; // The winner is the second one
    }

    // If there is only one voter (even in both sides)
    if (guesserStorage.getGuessVotersLength(_guess) == 1) {
      address _onlyVoter = guesserStorage.getGuessVoter(_guess, 0);
      uint256 _profits = guesserStorage.getGuessVotersOption(_guess, _onlyVoter, 1);
      _profits += guesserStorage.getGuessVotersOption(_guess, _onlyVoter, 2);

      guesserStorage.getGuessVoter(_guess, _voterIndex).transfer(_profits); //Error
      return;
    }
    // If there is only one side of the votes, they are instantly the winners
    if ((guesserStorage.getGuessOptionVotes(_guess, 1) > 0 && guesserStorage.getGuessOptionVotes(_guess, 2) == 0) ||
        (guesserStorage.getGuessOptionVotes(_guess, 2) > 0 && guesserStorage.getGuessOptionVotes(_guess, 1) == 0)) {
      if (guesserStorage.getGuessOptionVotes(_guess, 1) > guesserStorage.getGuessOptionVotes(_guess, 2)) {
        _winner = 1; // The winner is the first one
      } else {
        _winner = 2; // The winner is the second one
      }
    }

    uint256 percentage; // The percentage of the win a person has

    uint256 _totalProfits = getGuessProfits(_guess);
    uint256 _totalWinnersProfits = getGuessProfitsByOption(_guess, _winner);
    for(uint256 _voterIndex = 0; _voterIndex < guesserStorage.getGuessVotersLength(_guess); _voterIndex++) {
      // WARNING: Only will work with non contracts addresses
      uint256 index = 10;
      uint256 _precision = 0;
      while (_totalProfits*100 > index) {
        index = index * 10;
        _precision++;
      }

      address person = guesserStorage.getGuessVoter(_guess, _voterIndex);

      // Check if the user voted the winner option or both options (3)
      if (guesserStorage.getGuessVotersOption(_guess, person, _winner) == _winner ||
          guesserStorage.getGuessVotersOption(_guess, person, _winner) == 3) {
        // Get the percentage of the person in the winner option
        percentage = percent(
                             guesserStorage.getGuessVotersOption(_guess, person, _winner),
                             _totalWinnersProfits,
                             _precision
                             );
        uint256 _final = ((_totalProfits * 10) * percentage);
        guesserStorage.getGuessVoter(_guess, _voterIndex).transfer(_final/index); //Error
      }
    }

    guesserStorage.setGuessProfitsReturned(_guess, true);

    // Release the event
    emit ProfitsReturned(_guess);
  }
}
