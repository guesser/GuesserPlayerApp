pragma solidity ^0.4.18;

 /**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract Guess {
  struct GuessStruct{
    bytes32 title;
    bytes32 description;
    bytes32 option1;
    bytes32 option2;
    bytes32 option3;
    bytes32 option4;
  }
  GuessStruct _guessTemp; // Temporary guess to store values
  GuessStruct[] guesses; // Data structure to store all the guesses in the platform

  /**
   * @dev Function that returns a Guess basic data.
   * @param index uint256 represents the index of the stored Guess in the
   * global array.
   * @return bytes32 The title of the Guess
   * @return bytes32 The description of the Guess
   * @return bytes32 The first option to vote on the Guess
   * @return bytes32 The first option to vote on the Guess
   * @return bytes32 The first option to vote on the Guess
   * @return bytes32 The first option to vote on the Guess
  */
  function getGuess(uint256 index) public view returns(bytes32, bytes32, bytes32, bytes32, bytes32, bytes32){
    return (guesses[index].title,
            guesses[index].description,
            guesses[index].option1,
            guesses[index].option2,
            guesses[index].option3,
            guesses[index].option4
           );
  }

  /**
   * @dev Function that creates a Guess.
   * @param _title bytes32 The title of the Guess.
   * @param _description bytes32 The description of the Guess
   * @param _option1 bytes32 The first option to vote on the Guess
   * @param _option2 bytes32 The first option to vote on the Guess
   * @param _option3 bytes32 The first option to vote on the Guess
   * @param _option4 bytes32 The first option to vote on the Guess
   * @return uint256 of the new Guess in the global array that stores them
  */
  function setGuess(
    bytes32 _title,
    bytes32 _description,
    bytes32 _option1,
    bytes32 _option2,
    bytes32 _option3,
    bytes32 _option4
  ) public returns (uint256){
    GuessStruct memory _guess = GuessStruct({
      title: _title,
      description: _description,
      option1: _option1,
      option2: _option2,
      option3: _option3,
      option4: _option4
    });

    guesses.push(_guess); // Adds the new struct
    return guesses.length-1; // Return the position of the element in the array
  }

  /**
   * @dev Returns the length of the guesses array.
   * @return A uint256 with the actual length of the array of guesses
  */
  function getGuessesLength() public view returns (uint256){
    return guesses.length;
  }
}
