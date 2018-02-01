pragma solidity ^0.4.17;

import "./library/DateTime.sol";

/**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract Guess is DateTime{
  // Events
  event GuessCreated(uint256 index, bytes32 title);

  // Data structures
  struct GuessStruct {
    bytes32 title;
    string description;
    bytes32 topic;
    address creator;
    // The voters and the option the voted
    mapping (address => uint256) votersOption;
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
  }
  GuessStruct[] guesses; // Data structure to store all the guesses in the platform
  mapping (uint256 => uint256[]) guessesByDate; // Storing the guesses by their date
  // The dates are in this format: 0000:year, 00:month, 00:day
  // Example: 19940831

  //Store the day mapped with an array of the id's of the guess created that day

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
    GuessStruct memory _guess = GuessStruct({
      title: _title,
      description: _description,
      topic: _topic,
      creator: msg.sender,
      firstDate: now,
      finalDate: _finalDate,
      option1: _option1,
      option2: _option2,
      option1Votes: 0,
      option2Votes: 0,
      option1Validation: 0,
      option2Validation: 0
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
  function getGuessOptions(uint256 _index) public view returns (bytes32, bytes32, uint256, uint256,uint256, uint256) {
    return (
      guesses[_index].option1,
      guesses[_index].option2,
      guesses[_index].option1Votes,
      guesses[_index].option2Votes,
      guesses[_index].option1Validation,
      guesses[_index].option2Validation
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
   * @dev Returns the top Guess of the actual day
   * @param _topic uint256 the genre of the guess we are looking for
   * @return A uint256 with top guess of the day
   */
  function getTodayGuess(uint256 _topic) public view returns(uint256){
    uint256 _year = DateTime.getYear(now) * 10000;
    uint256 _month = DateTime.getMonth(now) * 100;
    uint256 _day = DateTime.getDay(now);
    uint256[] _guesses = guessesByDate[_year + _month + _day];

    require(_guesses.length > 0);

    // Search by the _topic (filter)
    uint256 _choosen = 0;
    uint256 _choosenVotes = guesses[_guesses[0]].option1Votes + guesses[_guesses[0]].option1Votes;
    for (uint256 i = 0; i<_guesses.length; i++) {
      if (_choosenVotes < guesses[_guesses[i]].option1Votes + guesses[_guesses[i]].option1Votes) {
        _choosen = i;
        _choosenVotes = guesses[_guesses[i]].option1Votes + guesses[_guesses[i]].option1Votes;
      }
    }
    return _guesses[_choosen];

  }

  /**
   * @dev Returns the top Guess of the actual day
   * @param _index uint256 the number of the index in the list of daily guesses. Goes from 10 to 10
   * @param _topic uint256 the genre of the guess we are looking for
   * @return A uint256[10] the top guesses of the day
   */
  function getTodayGuesses(uint256 _index, uint256 _topic) public view returns(uint256[10]){
    uint256 _year = DateTime.getYear(now) * 10000;
    uint256 _month = DateTime.getMonth(now) * 100;
    uint256 _day = DateTime.getDay(now);
    uint256[] _guesses = guessesByDate[_year + _month + _day];

    require(_guesses.length > 0);

    uint256[] _todayGuesses;
    for (uint256 i = 0; i<_guesses.length; i++) {
      if(guesses[_guesses[i]].topic == _topic) {
        _todayGuesses.push(_guesses[i]);
        if(_todayGuesses.length == 10) {
          return _todayGuesses;
        }
      }
    }

    return _todayGuesses;
  }
}
