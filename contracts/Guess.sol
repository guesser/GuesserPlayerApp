pragma solidity ^0.4.18;

 /**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract Guess {
  
  // Events 
  event GuessCreated(uint256 index, bytes32 title);
  event VoteDone(uint256 index, uint256 optionVoted);

  // Data structures
  struct GuessStruct{
    // Basic data of the Guess here
    bytes32 title;
    bytes32 description;
    bytes32 topic;
    address creator; // The user that created the event
    bytes32 eventVotes; // the number of votes it HAD when it was an event
    uint256 date;
    mapping (address => bool) voters;
    //Options to vote
    bytes32 option1;
    bytes32 option2;
    bytes32 option3;
    bytes32 option4;
    uint256 option1Votes;
    uint256 option2Votes;
    uint256 option3Votes;
    uint256 option4Votes;
  }
  GuessStruct[] guesses; // Data structure to store all the guesses in the platform

  /**
   * @dev Function that returns a Guess basic data.
   * @param _index uint256 represents the index of the stored Guess in the
   * global array.
   * @return bytes32 The title of the Guess.
   * @return bytes32 The description of the Guess.
   * @return bytes32 The topic of the Guess.
   * @return address The creator of the Event.
   * @return bytes32 The number of votes the Event had when it was only an
   * option. This is not the actual votes of the Guess.
   * @return uint256 The date when the Guess started.
  */
  function getGuess(uint256 _index) public view returns (bytes32, bytes32, bytes32, address, bytes32, uint256) {
    return (guesses[_index].title,
            guesses[_index].description,
            guesses[_index].topic,
            guesses[_index].creator,
            guesses[_index].eventVotes,
            guesses[_index].date
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
   * @return bytes32 The votes of the first option in the Guess
   * @return bytes32 The votes of the second option in the Guess
   * @return bytes32 The votes of the third option in the Guess
   * @return bytes32 The votes of the forth option in the Guess
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
   * @dev Function that creates a Guess.
   * @param _title bytes32 The title of the Guess.
   * @param _description bytes32 The description of the Guess
   * @param _topic bytes32 The topic of the Guess
   * @param _eventVotes bytes32 The number of votes the Event had when it was only an
   * option. This is not the actual votes of the Guess.
   * @param _option1 bytes32 The first option to vote on the Guess
   * @param _option2 bytes32 The first option to vote on the Guess
   * @param _option3 bytes32 The first option to vote on the Guess
   * @param _option4 bytes32 The first option to vote on the Guess
   * @return uint256 of the new Guess in the global array that stores them
  */
  function setGuess(
    bytes32 _title,
    bytes32 _description,
    bytes32 _topic,
    address _creator,
    bytes32 _eventVotes,
    bytes32 _option1,
    bytes32 _option2,
    bytes32 _option3,
    bytes32 _option4
  ) public { // This function will be private in the future after the UI testing
    GuessStruct memory _guess = GuessStruct({
      title: _title,
      description: _description,
      topic: _topic,
      creator: _creator,
      eventVotes: _eventVotes,
      date: now,
      option1: _option1,
      option2: _option2,
      option3: _option3,
      option4: _option4,
      option1Votes: 0,
      option2Votes: 0,
      option3Votes: 0,
      option4Votes: 0
    });
    uint256 _len = guesses.push(_guess) -1; // Adds the new struct and return its position
    GuessCreated(_len, _title);
  }

  /**
   * @dev Returns the length of the guesses array.
   * @return A uint256 with the actual length of the array of guesses
  */
  function getGuessesLength() public view returns (uint256){
    return guesses.length;
  }

  /**
   * @dev Function that votes an option in an event
   * @param _optId uint256 id of the option to vote in the event
   * @param _index uint256 the id of the event to vote
  */
  function voteOption(uint256 _optId, uint256 _index) public {
    require(guesses.length < _index);
    require(_optId < 4);
    require(guesses[_index].voters[msg.sender]);

    if(_optId == 0){
      guesses[_index].option1Votes += 1;
    } else if(_optId == 1){
      guesses[_index].option2Votes += 1;
    } else if(_optId == 2){
      guesses[_index].option3Votes += 1;
    } else if(_optId == 3){
      guesses[_index].option4Votes += 1;
    }
    guesses[_index].voters[msg.sender] = true;
    VoteDone(_index, _iptId);
  }
}
