pragma solidity ^0.4.23;

import "./GuesserCore.sol";
import "./GuesserPayments.sol";

/**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract GuesserInputs is GuesserCore {
  // Events
  event GuessCreated(uint256 index, string title, bytes32 topic);
  event test_value(uint256 indexed value1);

  GuesserPayments guesserPayments;


  constructor (address _addressStorage) GuesserCore (_addressStorage) public {}

/**
  * @dev Function that creates a Guess.
  * @param _title string The title of the Guess.
    * @param _description string The description of the Guess
  * @param _topic bytes32 The topicguesserStorage.getGuessVoter(_guess, _voterIndex),
 of the Guess
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
    uint256 _len = guesserStorage.setGuess(
                            _title,
                            _finalDate,
                            _validationDate,
                            msg.sender
                            );
    guesserStorage.setGuessSecondOptions(
                                         _len,
                                         _description,
                                         _topic,
                                         _option1,
                                         _option2
                                         );
    emit GuessCreated(_len, _title, _topic);
  }
}
