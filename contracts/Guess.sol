pragma solidity ^0.4.17;

import "./library/DateTime.sol";

/**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract Guess is DateTime{
  // Events
  event GuessCreated(uint256 index, bytes32 title);
  event GuessVoted(uint256 guess, uint8 option);
  event GuessValidated(uint256 guess, uint8 option, address sender);
  event ProfitsReturned(uint256 guess);

  // Data structures
  struct GuessStruct {
    bytes32 title;
    string description;
    bytes32 topic;
    address creator;
    /* The voters and the option the voted
     * It will store an array which has:
     * 1. The option voted as a first argument (0 or 1)
     * 2. The amount voted as a second argument
     */
    mapping (address => uint256[2]) votersOption;
    address[] voters;

    // About validatorsOption
    // Put it outside
    // address --> [guess, option]
    mapping (address => uint8) validatorsOption;
    address[] validators;
    uint256 firstDate;
    uint256 finalDate;
    // Options to vote
    bytes32 option1;
    bytes32 option2;
    // Number of votes an option has
    uint256 option1Votes;
    uint256 option2Votes;
    // Number of validations an option has
    uint256 option1Validation;
    uint256 option2Validation;
    // Has the guess returned the profits?
    bool profitsReturned;
  }
  GuessStruct[] guesses; // Data structure to store all the guesses in the platform
  mapping (uint256 => uint256[]) guessesByDate; // Storing the guesses by their date
  // The dates are in this format: 0000:year, 00:month, 00:day
  // Example: 19940831
  mapping (address => uint256[]) guessesByAddress; // Storing the guesses by their voters

  // Constructor
  function Guess () public {
    address[] memory _voters; // TODO: Be sure this has to be memory and not internal
    address[] memory _validators; // TODO: Be sure this has to be memory and not internal
    GuessStruct memory _guess = GuessStruct({
      title: '',
      description: '',
      topic: '',
      creator: 0x00000000000000000000000000000000,
      voters: _voters,
      validators: _validators,
      firstDate: now,
      finalDate: 0,
      option1: '',
      option2: '',
      option1Votes: 0,
      option2Votes: 0,
      option1Validation: 0,
      option2Validation: 0,
      profitsReturned: false
    });
    guesses.push(_guess);
  }

  /**
  * @dev Function that creates a Guess.
  * @param _title bytes32 The title of the Guess.
    * @param _description string The description of the Guess
  * @param _topic bytes32 The topic of the Guess
  * @param _finalDate uint256 The final date of the Guess
  * @param _option1 bytes32 The first option to vote on the Guess
  * @param _option2 bytes32 The first option to vote on the Guess
  */
  function setGuess(
    bytes32 _title,
    string _description,
    bytes32 _topic,
    uint256 _finalDate,
    bytes32 _option1,
    bytes32 _option2
  ) public {
    address[] memory _voters; // TODO: Be sure this has to be memory and not internal
    address[] memory _validators; // TODO: Be sure this has to be memory and not internal

    GuessStruct memory _guess = GuessStruct({
      title: _title,
      description: _description,
      topic: _topic,
      creator: msg.sender,
      voters: _voters,
      validators: _validators,
      firstDate: now,
      finalDate: _finalDate,
      option1: _option1,
      option2: _option2,
      option1Votes: 0,
      option2Votes: 0,
      option1Validation: 0,
      option2Validation: 0,
      profitsReturned: false
    });
    uint256 _len = guesses.push(_guess) -1; // Adds the new struct and return its position
    uint256 _year = DateTime.getYear(_finalDate) * 10000;
    uint256 _month = DateTime.getMonth(_finalDate) * 100;
    uint256 _day = DateTime.getDay(_finalDate);
    guessesByDate[_year + _month + _day].push(_len);
    GuessCreated(_len, _title);
  }

  /**
  * @dev Function that returns a Guess basic data.
  * @param _index uint256 represents the index of the stored Guess in the
  * global array.
    * @return bytes32 The title of the Guess.
    * @return string The description of the Guess.
    * @return bytes32 The topic of the Guess.
    * @return address The creator of the Event.
    * @return uint256 The number of votes the Guess has.
    * @return uint256 The date when the Guess started.
    * @return uint256 The date when the Guess finish.
    */
  function getGuess(uint256 _index) public view returns (bytes32, string, bytes32, address, uint256, uint256, uint256) {
    return (guesses[_index].title,
            guesses[_index].description,
            guesses[_index].topic,
            guesses[_index].creator,
            guesses[_index].option1Votes + guesses[_index].option2Votes,
            guesses[_index].firstDate,
            guesses[_index].finalDate
           );
  }

  /**
  * @dev Function that returns the options to vote a Guess has,
  * its votes and validations.
    * @param _index uint256 represents the index of the stored Guess in the
  * global array.
    * @return bytes32 The first option to vote on the Guess
  * @return bytes32 The second option to vote on the Guess
  * @return uint256 The votes of the first option in the Guess
  * @return uint256 The votes of the second option in the Guess
  * @return uint256 The number of validations for the first option
    * @return uint256 The number of validations for the second option
      */
  function getGuessOptions (uint256 _index) public view returns (bytes32, bytes32, uint256, uint256,uint256, uint256) {
    return (
      guesses[_index].option1,
      guesses[_index].option2,
      guesses[_index].option1Votes,
      guesses[_index].option2Votes,
      guesses[_index].option1Validation,
      guesses[_index].option2Validation
    );
  }

  /* @dev Function that returns the eth in each option of a guess
  * @param _index uint256 the index of the guess you want to know about
  * @return uint256 the amount of eth in the first option
  * @return uint256 the amount of eth in the second option
  */
  function getGuessOptionsProfits (uint256 _index) public view returns (uint256, uint256) {
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
    return guesses.length;
  }

  /**
  * @dev Returns the top Guess of the actual day by topic
  * @param _topic uint256 the genre of the guess we are looking for
    * @return uint256 with top guess of the day
  */
  function getTodayGuess(bytes32 _topic) public view returns(uint256){
    uint256 _year = DateTime.getYear(now) * 10000;
    uint256 _month = DateTime.getMonth(now) * 100;
    uint256 _day = DateTime.getDay(now);
    uint256 _hour = DateTime.getHour(now);
    uint256[] storage _guesses = guessesByDate[_year + _month + _day];

    require(_guesses.length > 0);

    // Search by the _topic (filter)
    bool found = false;
    uint256 _choosen = 0;
    uint256 _choosenVotes = 0;
    uint256 _guessHour;
    for (uint256 i = 0; i<_guesses.length; i++) {
      _guessHour = DateTime.getHour(guesses[_guesses[i]].finalDate);
      if(guesses[_guesses[i]].topic == _topic && _guessHour > _hour) { // Same topic and in the correct time
        // It returns the last best guess
        if (_choosenVotes < (guesses[_guesses[i]].option1Votes + guesses[_guesses[i]].option2Votes) || found==false) {
          _choosen = i;
          _choosenVotes = guesses[_guesses[i]].option1Votes + guesses[_guesses[i]].option2Votes;
          found = true;
        }
      }
    }
    require(found==true);
    return _guesses[_choosen];
  }

  /**
  * @dev Returns the guesses of a topic by a date
  * @param _index uint256 the number of the index in the list of daily guesses. Goes from 10 to 10
  * @param _topic uint256 the genre of the guess we are looking for
    * @param _date uint256 the date of the guesses we want
  * @return A uint256[10] the top guesses of the day
  */
  function getGuessesByDate(uint256 _index, bytes32 _topic, uint256 _date) public view returns(uint256[10]){
    // TODO: Control the date limits
    uint256 _year = DateTime.getYear(_date) * 10000;
    uint32 _month = DateTime.getMonth(_date) * 100;
    uint32 _day = DateTime.getDay(_date);
    uint256[] memory _guesses = guessesByDate[_year + _month + _day];

    require(_guesses.length > _index*10);

    uint256 _todayGuess = getTodayGuess(_topic);

    // Check the range is inside the length
    uint8 _guessNumber = 0;
    uint256[10] memory _todayGuesses;
    uint256 i = _index * 10;
    while (_guessNumber<10 && i<_guesses.length) {
      if (guesses[_guesses[i]].topic == _topic && _guesses[i] != _todayGuess) {
        _todayGuesses[_guessNumber] = _guesses[i];
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
    require(_guess < guesses.length);
    // Has the voter already voted?
    require(guesses[_guess].votersOption[msg.sender][0] == uint8(0x0));
    // TODO: Do we have a minimum bet?
    //require(msg.value > 0);
    // Is the option valid?
    require(_option == 1 || _option == 2);
    // Is the date due?
    require(dateDue(guesses[_guess].finalDate) == false);

    guesses[_guess].votersOption[msg.sender][0] = _option;
    guesses[_guess].votersOption[msg.sender][1] = msg.value;
    guesses[_guess].voters.push(msg.sender);

    // uint256 _guessByAddressLength = guessesByAddress[msg.sender].length++; // Saving the voter
    // guessesByAddress[msg.sender][_guessByAddressLength - 1] = _guess;
    guessesByAddress[msg.sender].push(_guess);

    if (_option == 1) {
      guesses[_guess].option1Votes++;
    } else {
      guesses[_guess].option2Votes++;
    }
    GuessVoted(_guess, _option);
  }

  /* @dev Function to validate the guesses
  * @param _guess uint256 the guess the validator is validating
  * @param _option uint8 the option the validator thinks is the correct
  */
  function validateGuess(uint256 _guess, uint8 _option) public {
    // Does the guess exists?
    require(_guess <= guesses.length-1);
    // Has the validator already choose?
    require(guesses[_guess].validatorsOption[msg.sender] == uint8(0x0));
    // Is the option valid?
    require(_option == 1 || _option == 2);
    // Is the date due?
    require(dateDue(guesses[_guess].finalDate) == true);
    uint256 validations = guesses[_guess].option1Validation + guesses[_guess].option2Validation;
    uint256 votes = guesses[_guess].option1Votes + guesses[_guess].option2Votes;

    // Enoguh votes to start the validation
    require(guesses[_guess].option1Votes > 0 && guesses[_guess].option2Votes > 0);

    // Enough validations
    uint256 half = ((((votes * 10) / 2) - ((votes * 10) / 2) % 10) / 10) + 1; // Divide by 2
    require(validations < half);

    guesses[_guess].validatorsOption[msg.sender] = _option;
    guesses[_guess].validators.push(msg.sender);
    if (_option == 1) {
      guesses[_guess].option1Validation++;
    } else {
      guesses[_guess].option2Validation++;
    }
    GuessValidated(_guess, _option, msg.sender);

    validations = guesses[_guess].option1Validation + guesses[_guess].option2Validation;
    if(validations == half) {
      returnProfits(_guess);
    }
  }

  /**
  * @dev Function that returns the profit to the voters
  * @param _guess uint256 the event to ask for the profits of
    */
  function returnProfits (uint256 _guess) public {
    // Does the guess exists?
    require(_guess <= guesses.length-1);
    // Is the date due?
    require(dateDue(guesses[_guess].finalDate) == true);
    // Has anybody voted in the guess?
    require(guesses[_guess].voters.length > 0);
    // Has anybody validated the guess?
    require(guesses[_guess].validators.length > 0); // TODO: Change to the minimun validation number
    // Have the profits already been returned
    require(guesses[_guess].profitsReturned == false);

    uint8 _winner;
    if (guesses[_guess].option1Validation > guesses[_guess].option2Validation) {
      _winner = 0; // The winner is the first one
    } else {
      _winner = 1; // The winner is the second one
    }

    uint256 percentage; // The percentage of the win a person has

    uint256 _totalProfits = getGuessProfits(_guess);
    uint256 _totalWinnersProfits = getGuessProfitsByOption(_guess, _winner);
    for(uint256 _voterIndex = 0; _voterIndex < guesses[_guess].voters.length; _voterIndex++) {
      // WARNING: Only will work with non contracts addresses
      uint256 index = 10;
      uint256 _precision = 0;
      while (_totalProfits*100 > index) {
        index = index * 10;
        _precision++;
      }

      address person = guesses[_guess].voters[_voterIndex];
      percentage = percent(guesses[_guess].votersOption[person][1], _totalWinnersProfits, _precision);

      uint256 _final = ((_totalProfits * 10) * percentage);
      guesses[_guess].voters[_voterIndex].transfer(_final / index);
    }

    guesses[_guess].profitsReturned = true;

    // Release the event
    ProfitsReturned(_guess);
  }

  /* @dev Function that tells you the profits a Guess has
  * @dev Get the profits a guess has in its vault
  * @param _guess uint256 the event to ask for the profits of
    * @return bool the profits the guess asked has
  */
  function getGuessProfits (uint256 _guess) public view returns (uint256) {
    // Does the guess exists?
    require(_guess <= guesses.length-1);

    if (guesses[_guess].voters.length == 0) {
      return 0;
    }

    uint256 _profits = 0;
    for(uint256 _voterIndex = 0; _voterIndex < guesses[_guess].voters.length; _voterIndex++) {
      _profits += guesses[_guess].votersOption[guesses[_guess].voters[_voterIndex]][1];
    }

    return _profits;
  }

  /* @dev Function that tells you the profits of an option in a guess
  * @dev Get the profits a guess has in its vault
  * @param _guess uint256 the event to ask for the profits of
    * @param _option uint256 the option you want to check
  * @return bool the profits the guess asked has
  */
  function getGuessProfitsByOption (uint256 _guess, uint256 _option) public view returns (uint256) {
    // Does the guess exists?
    require(_guess <= guesses.length-1);

    // Is the option valid?
    require(_option == 1 || _option == 2);

    if (guesses[_guess].voters.length == 0) {
      return 0;
    }

    uint256 _profits = 0;
    for(uint256 _voterIndex = 0; _voterIndex < guesses[_guess].voters.length; _voterIndex++) {
      if(guesses[_guess].votersOption[guesses[_guess].voters[_voterIndex]][0] == _option)
        _profits += guesses[_guess].votersOption[guesses[_guess].voters[_voterIndex]][1];
    }

    return _profits;
  }

  /* @dev Function that returns a list of Guesses to validate
  * @param _index uint256 Index of the list, If you want the 10 last or the second 10 last Guesses
  * @return uint256[10] a list with the guesses to validate
  */
  function getGuessesToValidate (uint256 _index, uint256 _date) public view returns (uint256[10]) {
    require(dateDue(_date) == true);
    // TODO: Control the date limits
    uint256 _year = DateTime.getYear(_date) * 10000;
    uint32 _month = DateTime.getMonth(_date) * 100;
    uint32 _day = DateTime.getDay(_date);
    uint256[] memory _events = guessesByDate[_year + _month + _day];

    require(_events.length > _index*10);


    //Check the range is inside the length
    uint8 _eventNumber = 0;
    uint256[10] memory _dateEvents;
    uint i = _index * 10;
    while (_eventNumber < 10 && i < _events.length) {
      // Does it has enough votes?
      uint256 _votes = guesses[_events[i]].option1Votes + guesses[_events[i]].option2Votes;
      uint256 _validations = guesses[_events[i]].option1Validation + guesses[_events[i]].option2Validation;
      uint256 _half = ((((_votes * 10) / 2) - ((_votes * 10) / 2) % 10) / 10) + 1; // Divide by 2
      if (guesses[_events[i]].option1Votes > 0 && guesses[_events[i]].option2Votes > 0)
      if (_validations < _half) { // Does it has enough validations?
        _dateEvents[_eventNumber] = _events[i];
        _eventNumber++;
      }
      i++;
    }

  }



  /* @dev Function that returns the events voted by a person
   * @param _index uint256 the 'page' of the events you want. The first 10, the second 10th, the third...
   * @param _address address the person from whom you want the events
   * @return uint256[10] array of the events of the person
   */
  function getCurrentGuessesByAddress (uint256 _index, address _address) public view returns (uint256[10]) {
    _index = _index * 10;

    uint8 _eventNumber = 0;
    uint256[10] memory _firstEvents; // Array to return
    while (_index < guessesByAddress[_address].length && _eventNumber < 10) {
      uint256 _eventIndex = guessesByAddress[_address][_index];
      if(dateDue(guesses[_eventIndex].finalDate) == false) {
        _firstEvents[_eventNumber] = guessesByAddress[_address][_index];
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
    while (_index < guessesByAddress[_address].length && _eventNumber < 10) {
      uint256 _eventIndex = guessesByAddress[_address][_index];
      // Does it has enough validations to count as a Past event?
      uint256 _votes = guesses[_eventIndex].option1Votes + guesses[_eventIndex].option2Votes;
      uint256 _validations = guesses[_eventIndex].option1Validation + guesses[_eventIndex].option2Validation;
      uint256 _half = ((((_votes * 10) / 2) - ((_votes * 10) / 2) % 10) / 10) + 1; // Divide by 2
      if(dateDue(guesses[_eventIndex].finalDate) == true && _validations < _half) {
        _firstEvents[_eventNumber] = guessesByAddress[_address][_index];
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
    while (_index < guessesByAddress[_address].length && _eventNumber < 10) {
      uint256 _eventIndex = guessesByAddress[_address][_index];
      // Does it has enough validations to count as a Past event?
      uint256 _votes = guesses[_eventIndex].option1Votes + guesses[_eventIndex].option2Votes;
      uint256 _validations = guesses[_eventIndex].option1Validation + guesses[_eventIndex].option2Validation;
      uint256 _half = ((((_votes * 10) / 2) - ((_votes * 10) / 2) % 10) / 10) + 1; // Divide by 2
      if(dateDue(guesses[_eventIndex].finalDate) == true && _validations >= _half) {
        _firstEvents[_eventNumber] = guessesByAddress[_address][_index];
        _eventNumber ++;
      }
      _index++;
    }

    return _firstEvents;
  }

  /****** Private functions ******/

  /* @dev Function that tells you if a date is due
   * @param _date uint256 the date you want to check with the current date.
   * The minutes and seconds are not being checked.
   * @return bool if the date is due then will return true
   */
  function dateDue (uint256 _date) private view returns (bool) {
    uint256 _currentYear = DateTime.getYear(now);
    uint256 _currentMonth = DateTime.getMonth(now);
    uint256 _currentDay = DateTime.getDay(now);
    uint256 _currentHour = DateTime.getHour(now);

    uint256 _year = DateTime.getYear(_date);
    uint256 _month = DateTime.getMonth(_date);
    uint256 _day = DateTime.getDay(_date);
    uint256 _hour = DateTime.getHour(_date);

    // Comparing the dates
    if (_currentYear == _year) { // Is it the same year?
      if (_currentMonth == _month) { // Is it the same month?
        if (_currentDay == _day) { // Is it the same day?
          if (_currentHour < _hour) { // is the current hour higher?
            return false;
          } else {
            return true;
          }
        } else if (_currentDay < _day) {
          return false;
        } else {
          return true;
        }
      } else if(_currentMonth < _month) {
        return false;
      } else {
        return true;
      }
    } else if(_currentYear < _year){
      return false;
    } else {
      return true;
    }
  }

  function percent(uint numerator, uint denominator, uint precision) public pure returns(uint quotient) {

    // TODO: caution, check safe-to-multiply here
    uint _numerator  = numerator * 10 ** (precision+1);
    // with rounding of last digit
    uint _quotient =  ((_numerator / denominator) + 5) / 10;
    return ( _quotient);
  }
}
