pragma solidity ^0.4.22;

import "./DateTime.sol";
import "./interface/GuesserStorageInterface.sol";

/**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract Guesser is DateTime {
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

  GuesserStorageInterface  guesserStorage;

  /**
   * @dev constructor. Sets the guesserStorage address for the
   * Eternal Storage Pattern
   */
  constructor (address _guesserStorageAddress) public {
    guesserStorage = GuesserStorageInterface(_guesserStorageAddress);
  }
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
                            _description,
                            _topic,
                            _finalDate,
                            _validationDate,
                            _option1,
                            _option2
                            );
    uint256 _len = guesserStorage.getGuessLength();
    emit GuessCreated(_len, _title, _topic);
  }

  /**
  * @dev Function that returns a Guess basic data.
  * @param _index uint256 represents the index of the stored Guess in the
  * global array.
    * @return bytes32 The title of the Guess.
    * @return string The description of the Guess.
    * @return bytes32 The topic of the Guess.
    * @return address The creator of the Event.
    * @return uint256 The date when the Guess started.
    * @return uint256 The date when the Guess finish.
    */
  function getGuess(uint256 _index) public view returns (string, string, bytes32, address, uint32, uint32, uint32) {
    return (guesserStorage.getGuessTitle(_index),
            guesserStorage.getGuessDescription(_index),
            guesserStorage.getGuessTopic(_index),
            guesserStorage.getGuessCreator(_index),
            guesserStorage.getGuessStartingDate(_index),
            guesserStorage.getGuessFinalDate(_index),
            guesserStorage.getGuessValidationDate(_index)
            );
  }

  /**
  * @dev Function that returns the options to vote a Guess has,
  * its votes and validations.
  * @param _index uint256 represents the index of the stored Guess in the
  * global array.
  * @return string The first option to vote on the Guess
  * @return string The second option to vote on the Guess
  * @return uint256 The votes of the first option in the Guess
  * @return uint256 The votes of the second option in the Guess
  * @return uint256 The number of validations for the first option
  * @return uint256 The number of validations for the second option
  */
  function getGuessOptions (uint256 _index) public view returns (string, string, uint256, uint256,uint256, uint256) {
    uint256 _votes1 = guesserStorage.getGuessOptionVotes(_index, 1);
    uint256 _votes2 = guesserStorage.getGuessOptionVotes(_index, 2);
    uint128 _validation1 = uint128(guesserStorage.getGuessOptionValidation(_index, 1));
    uint128 _validation2 = uint128(guesserStorage.getGuessOptionValidation(_index, 2));

    if (DateTime.dateDue(guesserStorage.getGuessValidationDate(_index)) == true) {
      // Enough validations
      uint256 half = (((((_votes1 + _votes2) * 10) / 2) - (((_votes1 + _votes2) * 10) / 2) % 10) / 10) + 1; // Divide by 2
      if (_validation1 + _validation2 < half) {
        _votes1 = 0;
        _votes2 = 0;
        _validation1 = 0;
        _validation2 = 0;
      }
    }
    return (
            guesserStorage.getGuessOption(_index, 1),
            guesserStorage.getGuessOption(_index, 2),
            _votes1,
            _votes2,
            _validation1,
            _validation2
            );
  }

  /* @dev Function that returns the eth in each option of a guess
  * @param _index uint256 the index of the guess you want to know about
  * @return uint256 the amount of eth in the first option
  * @return uint256 the amount of eth in the second option
  */
  function getGuessOptionsProfits (uint256 _index) public view returns (uint256, uint256) {
    uint256 validations = guesserStorage.getGuessOptionValidation(_index, 1) +
      guesserStorage.getGuessOptionValidation(_index, 2);
    uint256 votes = guesserStorage.getGuessOptionVotes(_index, 1) +
      guesserStorage.getGuessOptionVotes(_index, 2);

    uint256 half = ((((votes * 10) / 2) - ((votes * 10) / 2) % 10) / 10) + 1; // Divide by 2
    if (DateTime.dateDue(guesserStorage.getGuessValidationDate(_index)) == true && validations < half) {
        return (
                0,
                0
                );
    }
    return (
            getGuessProfitsByOption(_index, 1),
            getGuessProfitsByOption(_index, 2)
            );
  }

  /**
  * @dev Returns the length of the guesses array.
  * @return A uint256 with the actual length of the array of guesses
  */
  function getGuessesLength() public view returns (uint256){
    return guesserStorage.getGuessLength();
  }

  /**
  * @dev Returns the top Guess of the actual day by topic
  * @param _topic uint256 the genre of the guess we are looking for
    * @return uint256 with top guess of the day
  */
  function getTodayGuess(bytes32 _topic) public view returns(uint256){
    uint32 _year = DateTime.getYear(now) * 10000;
    uint32 _month = DateTime.getMonth(now) * 100;
    uint32 _day = DateTime.getDay(now);
    uint256 _guessesLength = guesserStorage.getGuessByDayLength(_year + _month + _day);

    bool found = false;
    uint256 _choosen = 0;
    uint256 _choosenVotes = 0;
    bool _guessFinished;
    uint256 _guessIndex = 0;
    for (uint256 i = 0; i < _guessesLength; i++) {
      _guessIndex = guesserStorage.getGuessByDay(_year + _month + _day, i);
      _guessFinished = DateTime.dateDue(guesserStorage.getGuessFinalDate(_guessIndex));
      if(guesserStorage.getGuessTopic(_guessIndex) == _topic && _guessFinished == false) {
        // Same topic and in the correct time
        // It returns the last best guess
        uint256 _votes = guesserStorage.getGuessOptionVotes(_guessIndex, 1) +
          guesserStorage.getGuessOptionVotes(_guessIndex, 2);
        if (_choosenVotes < _votes || found==false) {
          _choosen = _guessIndex;
          _choosenVotes = _votes;
          found = true;
        }
      }
    }
      if (found == true && DateTime.dateDue(guesserStorage.getGuessFinalDate(_choosen)) == false) {
      return _choosen;
    } else {
      return 0;
    }
  }

  /**
  * @dev Returns the top Guess of the actual day by topic
  * @param _topic uint256 the genre of the guess we are looking for
    * @return uint256 with top guess of the day
  */
  function getWeekGuess(bytes32 _topic) public view returns(uint256){
    uint32 _year;
    uint32 _month;
    uint32 _day;
    
    bool found = false;
    uint256 _choosen = 0;
    uint128 _choosenVotes = 0;
    bool _guessFinished;

    for (uint256 d = 0 ; d < 6 ; d++) {
    _year = DateTime.getYear(now + d * 86400) * 10000;
    _month = DateTime.getMonth(now + d * 86400) * 100;
    _day = DateTime.getDay(now + d * 86400);
    uint256 _guessesLength = guesserStorage.getGuessByDayLength(_year + _month + _day);

      for (uint256 i = 0; i < _guessesLength; i++) {
        uint256 _guess = guesserStorage.getGuessByDay(_year + _month + _day, i);
        _guessFinished = DateTime.dateDue(guesserStorage.getGuessFinalDate(_guess));
        if(guesserStorage.getGuessTopic(_guess) == _topic && _guessFinished == false && 
           (_choosenVotes < (guesserStorage.getGuessOptionVotes(_guess, 1) + guesserStorage.getGuessOptionVotes(_guess, 2)) ||
            found==false)) {
          _choosen = _guess;
          _choosenVotes = guesserStorage.getGuessOptionVotes(_guess, 1) +
            guesserStorage.getGuessOptionVotes(_guess, 2);
          found = true;
        }
      }
    }
    if (found == true && DateTime.dateDue(guesserStorage.getGuessFinalDate(_choosen)) == false)
      return _choosen;
    else
      return 0;
  }

  /**
  * @dev Returns the guesses of a topic by a date
  * @param _index uint256 the number of the index in the list of daily guesses. Goes from 10 to 10
  * @param _topic uint256 the genre of the guess we are looking for
    * @param _date uint256 the date of the guesses we want
  * @return A uint256[10] the top guesses of the day
  */
  function getGuessesByDate(uint256 _index, bytes32 _topic, uint256 _date) public view returns(uint256[10]){
    uint32 _year = DateTime.getYear(_date) * 10000;
    uint32 _month = DateTime.getMonth(_date) * 100;
    uint32 _day = DateTime.getDay(_date);
    uint256 _guessesLength = guesserStorage.getGuessByDayLength(_year + _month + _day);

    require(_guessesLength > _index*10);

    // Check the range is inside the length
    uint8 _guessNumber = 0;
    uint256[10] memory _todayGuesses;
    uint256 i = _index * 10;
    while (_guessNumber<10 && i<_guessesLength) {
      uint256 _guess = guesserStorage.getGuessByDay(_year + _month + _day, i);
      if (guesserStorage.getGuessTopic(_guess) == _topic) {
        _todayGuesses[_guessNumber] = _guess;
        _guessNumber++;
      }
      i++;
    }

    return _todayGuesses;
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

  /* @dev Function that tells you the profits a Guess has
  * @dev Get the profits a guess has in its vault
  * @param _guess uint256 the event to ask for the profits of
    * @return bool the profits the guess asked has
  */
  function getGuessProfits (uint256 _guess) public view returns (uint256) {
    // Does the guess exists?
    require(_guess <= guesserStorage.getGuessLength() - 1);

    if (guesserStorage.getGuessVotersLength(_guess) == 0) {
      return 0;
    }

    uint256 _profits = 0;
    for(uint256 _voterIndex = 0; _voterIndex < guesserStorage.getGuessVotersLength(_guess); _voterIndex++) {
      // Adding to profits the amount of eth in the first option
      address _voter = guesserStorage.getGuessVoter(_guess, _voterIndex);
      _profits += guesserStorage.getGuessVotersOption(_guess, _voter, 1);
      // Adding to profits the amount of eth in the second option
      _profits += guesserStorage.getGuessVotersOption(_guess, _voter, 2);
    }

    return _profits;
  }

  /* @dev Function that tells you the profits of an option in a guess
  * @dev Get the profits a guess has in its vault
  * @param _guess uint256 the event to ask for the profits of
    * @param _option uint256 the option you want to check
  * @return bool the profits the guess asked has
  */
  function getGuessProfitsByOption (uint256 _guess, uint8 _option) public view returns (uint256) {
    // Does the guess exists?
    require(_guess <= guesserStorage.getGuessLength() - 1);
    // Is the option valid?
    require(_option == 1 || _option == 2);

    if (guesserStorage.getGuessVotersLength(_guess) == 0) {
      return 0;
    }

    uint256 _profits = 0;
    address _address;
    for(uint256 _voterIndex = 0; _voterIndex < guesserStorage.getGuessVotersLength(_guess); _voterIndex++) {
      // Option has to be the correct or 3, which means the user voted both options
      _address = guesserStorage.getGuessVoter(_guess, _voterIndex);
      if(guesserStorage.getGuessVotersOption(_guess, _address, 0) == _option ||
         guesserStorage.getGuessVotersOption(_guess, _address, 0) == 3) {
        _profits += guesserStorage.getGuessVotersOption(_guess, _address, _option);
      }
    }

    return _profits;
  }

  /* @dev Function that returns a list of Guesses to validate
  * @param _index uint256 Index of the list, If you want the 10 last or the second 10 last Guesses
  * @return uint256[10] a list with the guesses to validate
  */
  function getGuessesToValidate (uint256 _index, uint256 _date) public view returns (uint256[10]) {
    // TODO: Control the date limits
    uint32 _year = DateTime.getYear(_date) * 10000;
    uint32 _month = DateTime.getMonth(_date) * 100;
    uint32 _day = DateTime.getDay(_date);
    uint256 _guessesLength = guesserStorage.getGuessByDayLength(_year + _month + _day);

    require(_guessesLength > _index*10);

    // Check the range is inside the length
    uint8 _guessNumber = 0;
    uint256[10] memory _todayGuesses;
    uint256 i = _index * 10;
    while (_guessNumber < 10 && i < _guessesLength) {
      // Proper date
      uint256 _guess = guesserStorage.getGuessByDay(_year + _month + _day, i);
      if (DateTime.dateDue(guesserStorage.getGuessFinalDate(_guess)) == true) {
        uint128 _votes = guesserStorage.getGuessOptionVotes(_guess, 1) +
          guesserStorage.getGuessOptionVotes(_guess, 2);
        uint64 _validations = guesserStorage.getGuessOptionValidation(_guess, 1) +
          guesserStorage.getGuessOptionValidation(_guess, 2);
        uint256 _half = ((((_votes * 10) / 2) - ((_votes * 10) / 2) % 10) / 10) + 1; // Divide by 2

        if (_validations < _half && _votes > 0) { // Does it has enough validations and enough votes?
          _todayGuesses[_guessNumber] = _guess;
          _guessNumber++;
        }
      }
      i++;
    }
    return _todayGuesses;
  }



  /* @dev Function that returns the events voted by a person still open
   * @param _index uint256 the 'page' of the events you want. The first 10, the second 10th, the third...
   * @param _address address the person from whom you want the events
   * @return uint256[10] array of the events of the person
   */
  function getCurrentGuessesByAddress (uint256 _index, address _address) public view returns (uint256[10]) {
    _index = _index * 10;

    uint8 _eventNumber = 0;
    uint256[10] memory _firstEvents; // Array to return
    while (_index < guesserStorage.getGuessesByAddressLength(_address) && _eventNumber < 10) {
      uint256 _eventIndex = guesserStorage.getGuessesByAddress(_address, _index);
      if(getEventItemState(_eventIndex) == 'voting') {
        _firstEvents[_eventNumber] = guesserStorage.getGuessesByAddress(_address, _index);
        _eventNumber ++;
      }
      _index++;
    }

    return _firstEvents;
  }

  /* @dev Function that returns the events voted by a person that are being validated
   * @param _index uint256 the 'page' of the events you want. The first 10, the second 10th, the third...
   * @param _address address the person from whom you want the events
   * @return uint256[10] array of the events of the person
   */
  function getValidatingGuessesByAddress (uint256 _index, address _address) public view returns (uint256[10]) {
    _index = _index * 10;

    uint8 _eventNumber = 0;
    uint256[10] memory _firstEvents; // Array to return
    while (_index < guesserStorage.getGuessesByAddressLength(_address) && _eventNumber < 10) {
      uint256 _eventIndex = guesserStorage.getGuessesByAddress(_address, _index);
      // Does it has enough validations to count as a Past event?
      if(getEventItemState(_eventIndex) == 'validating') {
        _firstEvents[_eventNumber] = _eventIndex;
        _eventNumber ++;
      }
      _index++;
    }

    return _firstEvents;
  }

  /* @dev Function that returns the events voted by a person that have already passed
   * @param _index uint256 the 'page' of the events you want. The first 10, the second 10th, the third...
   * @param _address address the person from whom you want the events
   * @return uint256[10] array of the events of the person
   */
  function getPastGuessesByAddress (uint256 _index, address _address) public view returns (uint256[10]) {
    _index = _index * 10;

    uint8 _eventNumber = 0;
    uint256[10] memory _firstEvents; // Array to return
    while (_index < guesserStorage.getGuessesByAddressLength(_address) && _eventNumber < 10) {
      uint256 _eventIndex = guesserStorage.getGuessesByAddress(_address, _index);
      // Does it has enough validations to count as a Past event?
      if(getEventItemState(_eventIndex) == 'passed') {
        _firstEvents[_eventNumber] = _eventIndex;
        _eventNumber ++;
      }
      _index++;
    }

    return _firstEvents;
  }

  /* @dev Function that returns the events created by a person
   * @param _index uint256 the 'page' of the events you want. The first 10, the second 10th, the third...
   * @param _address address the person from whom you want the events
   * @return uint256[10] array of the events of the person
   */
  function getCreatedGuessesByAddress (uint256 _index, address _address) public view returns (uint256[10]) {
    _index = _index * 10;

    uint256[10] memory _firstEvents; // Array to return
    while (_index < guesserStorage.getGuessesCreatedByAddressLength(_index)) {
      uint256 _eventIndex = guesserStorage.getGuessesCreatedByAddress(_address, _index);
      _firstEvents[_index] = _eventIndex;
      _index++;
    }

    return _firstEvents;
  }

  /* @dev Function to get the actual state of a event
   * @param _index uint256 the 'page' of the events you want. The first 10, the second 10th, the third...
   * @param _address address the person from whom you want the events
   * @return bytes32 state of the event
   */
  function getEventItemState (uint256 _index) public view returns (bytes32) {
    bytes32 _state;
    uint256 _votes = guesserStorage.getGuessOptionVotes(_index, 1) +
      guesserStorage.getGuessOptionVotes(_index, 2);
    uint256 _validations = guesserStorage.getGuessOptionValidation(_index, 1) +
      guesserStorage.getGuessOptionValidation(_index, 2);
    uint256 _half = ((((_votes * 10) / 2) - ((_votes * 10) / 2) % 10) / 10) + 1; // Divide by 2

    if (DateTime.dateDue(guesserStorage.getGuessFinalDate(_index)) == false)
      _state = "voting";
    else if (DateTime.dateDue(guesserStorage.getGuessFinalDate(_index)) &&
             DateTime.dateDue(guesserStorage.getGuessValidationDate(_index)) == false &&
             _votes != 0)
      _state = "waiting";
    else if(DateTime.dateDue(guesserStorage.getGuessValidationDate(_index)) == true &&
            _validations < _half)
            _state = "validating";
            else if((DateTime.dateDue(guesserStorage.getGuessValidationDate(_index)) == true &&
            _validations >= _half) ||
                    (DateTime.dateDue(guesserStorage.getGuessFinalDate(_index)) && _votes == 0))
      _state = "passed";

    return _state;
  }

  function percent(uint numerator, uint denominator, uint precision) private pure returns(uint quotient) {

    // TODO: caution, check safe-to-multiply here
    uint _numerator  = numerator * 10 ** (precision+1);
    // with rounding of last digit
    uint _quotient =  ((_numerator / denominator) + 5) / 10;
    return ( _quotient);
  }
}
