pragma solidity ^0.4.23;

import "./GuesserCore.sol";

/**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract GuesserGame is GuesserCore {

  constructor (address _address) GuesserCore (_address) public {}

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
    uint256[] memory _guesses;
    uint256 j;
    for (uint256 i = 0; i < _guessesLength; i++) {
      uint256 _guess = guesserStorage.getGuessByDay(_year + _month + _day, i);
      if (guesserStorage.getGuessTopic(_guess) == _topic) {

        j = i;
        while (j > 0 && _guesses[j - 1] > _guess) {
          _guesses[j] = _guesses[j - 1];
          j--;
        }
        _guesses[j] = _guess;
      }
    }

    // Creating the returning array
    uint256[10] memory _finalGuesses;
    for (j = 0; j < 10; j++) {
      _finalGuesses[j] = _guesses[_index + j];
    }
    return _finalGuesses;
  }

  /**
  * @dev Returns the guesses of a topic of the next 7 days
  * @param _index uint256 the number of the index in the list of daily guesses. Goes from 10 to 10
  * @param _topic uint256 the genre of the guess we are looking for
  * @param _date uint256 the date of the guesses we want
  * @return A uint256[10] the top guesses of the next 7 days
  */
  function getGuessesByWeek(uint256 _index, bytes32 _topic, uint32 _date) public view returns(uint256[10]){
    uint32 _year;
    uint32 _month;
    uint32 _day;

    uint256[10] memory _weekGuesses;
    uint256 _guessesValid = 0;
    uint256 _guessesNumber = 0;

    for (uint32 d = 0 ; d < 6 ; d++) {
      _year = DateTime.getYear(_date + d * 86400) * 10000;
      _month = DateTime.getMonth(_date + d * 86400) * 100;
      _day = DateTime.getDay(_date + d * 86400);
      uint256 _guessesLength = guesserStorage.getGuessByDayLength(_year + _month + _day);

      for(uint256 i=0; i < _guessesLength && _guessesNumber < 10; i++) {
        uint256 _guess = guesserStorage.getGuessByDay(_year + _month + _day, i);
        if (guesserStorage.getGuessTopic(_guess) == _topic) {
            _guessesValid++;
          if(_guessesValid > _index*10) {
              _weekGuesses[_guessesNumber] = _guess;
              _guessesNumber++;
          }
        }
      }
    }

    return _weekGuesses;
   }

  /* @dev Function that returns a list of Guesses to validate
  * @param _index uint256 Index of the list, If you want the 10 last or the second 10 last Guesses
  * @return uint256[10] a list with the guesses to validate
  */
  function getGuessesToValidate (uint256 _index, uint32 _date) public view returns (uint256[10]) {
    // TODO: Control the date limits
    uint32 _year; 
    uint32 _month;
    uint32 _day;

    // Check the range is inside the length
    uint256[10] memory _validationGuesses;
    uint8 _guessNumber = 0;
    uint64 _guessesValid = 0;

    for (uint8 d = 8 ; d > 0 ; d--) {
      _year = DateTime.getYear(_date - (d - 1) * 86400) * 100000;
      _month = DateTime.getMonth(_date - (d - 1) * 86400) * 100000;
      _day = DateTime.getDay(_date - (d - 1) * 86400) * 100000;
      uint256 _guessesLength = guesserStorage.getGuessByDayLength(_year + _month + _day);

      for(uint64 i=0; i < _guessesLength && _guessNumber < 10; i++) {
        uint256 _guess = guesserStorage.getGuessByDay(_year + _month + _day, i);
        if (getEventItemState(_guess) == 'validating') {
          _guessesValid++;
          if(_guessesValid > _index*10) {
            _validationGuesses[_guessNumber] = _guess;
            _guessNumber++;
          }
        }
      }
    }

    return _validationGuesses;
  }
}
