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
    uint256 votes;
    // The voters and the option the voted
    mapping (address => uint256) votersOption;
    uint256 firstDate;
    uint256 finalDate;
    // Options to vote
    bytes32 option1;
    bytes32 option2;
    bytes32 option3;
    bytes32 option4;
    // Number of votes an option has
    uint256 option1Votes;
    uint256 option2Votes;
    uint256 option3Votes;
    uint256 option4Votes;
    // Number of validations an option has
    uint256 option1Validation;
    uint256 option2Validation;
    uint256 option3Validation;
    uint256 option4Validation;
  }
  GuessStruct[] guesses; // Data structure to store all the guesses in the platform

  //Store the day mapped with an array of the id's of the guess created that day

  /**
   * @dev Function that creates a Guess.
   * @param _title bytes32 The title of the Guess.
   * @param _description string The description of the Guess
   * @param _topic bytes32 The topic of the Guess
   * @param _creator bytes32 The topic of the Guess
   * option. This is not the actual votes of the Guess.
   * @param _option1 bytes32 The first option to vote on the Guess
   * @param _option2 bytes32 The first option to vote on the Guess
   * @param _option3 bytes32 The first option to vote on the Guess
   * @param _option4 bytes32 The first option to vote on the Guess
   */
  function setGuess(
    bytes32 _title,
    string _description,
    bytes32 _topic,
    address _creator,
    uint256 _finalDate,
    bytes32 _option1,
    bytes32 _option2,
    bytes32 _option3,
    bytes32 _option4
  ) public {
    GuessStruct memory _guess = GuessStruct({
      title: _title,
      description: _description,
      topic: _topic,
      creator: _creator,
      votes: 1,
      firstDate: now,
      finalDate: _finalDate,
      option1: _option1,
      option2: _option2,
      option3: _option3,
      option4: _option4,
      option1Votes: 0,
      option2Votes: 0,
      option3Votes: 0,
      option4Votes: 0,
      option1Validation: 0,
      option2Validation: 0,
      option3Validation: 0,
      option4Validation: 0
    });
    uint256 _len = guesses.push(_guess) -1; // Adds the new struct and return its position
    // Add creator to the voters
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
   * option. This is not the actual votes of the Guess.
   * @return uint256 The date when the Guess started.
   * @return uint256 The date when the Guess finish.
   */
  function getGuess(uint256 _index) public view returns (bytes32, string, bytes32, address, uint256, uint256, uint256) {
    return (guesses[_index].title,
            guesses[_index].description,
            guesses[_index].topic,
            guesses[_index].creator,
            guesses[_index].votes,
            guesses[_index].firstDate,
            guesses[_index].finalDate
           );
  }

  /**
   * @dev Function that returns the options to vote a Guess has.
   * @param _index uint256 represents the index of the stored Guess in the
   * global array.
   * @return bytes32 The first option to vote on the Guess
   * @return bytes32 The second option to vote on the Guess
   * @return bytes32 The third option to vote on the Guess
   * @return bytes32 The forth option to vote on the Guess
   */
  function getGuessOptions(uint256 _index) public view returns (bytes32, bytes32, bytes32, bytes32) {
    return (
      guesses[_index].option1,
      guesses[_index].option2,
      guesses[_index].option3,
      guesses[_index].option4
    );
  }

  /**
   * @dev Function that returns the votes of the options a Guess has.
   * @param _index uint256 represents the index of the stored Guess in the
   * global array.
   * @return uint256 The votes of the first option in the Guess
   * @return uint256 The votes of the second option in the Guess
   * @return uint256 The votes of the third option in the Guess
   * @return uint256 The votes of the forth option in the Guess
  */
  function getGuessOptionsVotes(uint256 _index) public view returns (uint256, uint256, uint256, uint256) {
    return (
            guesses[_index].option1Votes,
            guesses[_index].option2Votes,
            guesses[_index].option3Votes,
            guesses[_index].option4Votes
    );
  }

  /**
   * @dev Function that returns the number of validations each option of a Guess has.
   * @param _index uint256 represents the index of the stored Guess in the
   * global array.
   * @return uint256 The number of validations for the first option
   * @return uint256 The number of validations for the second option
   * @return uint256 The number of validations for the third option
   * @return uint256 The number of validations for the fourth option
  */
  function getGuessValidations(uint256 _index) public view returns (uint256, uint256, uint256, uint256) {
    return (
            guesses[_index].option1Validation,
            guesses[_index].option2Validation,
            guesses[_index].option3Validation,
            guesses[_index].option4Validation
    );
  }

  /**
   * @dev Returns the length of the guesses array.
   * @return A uint256 with the actual length of the array of guesses
   */
  function getGuessesLength() public view returns (uint256){
    return guesses.length;
  }

  function getTodayGuesses(uint256 _index) public view returns(uint8){
    return DateTime.getDay(guesses[_index].finalDate);
  }

}
