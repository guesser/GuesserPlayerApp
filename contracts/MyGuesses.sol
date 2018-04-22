pragma solidity ^0.4.23;

import "./GuesserCore.sol";

/**
 * @title Guess
 * @dev Guess contract to vote and create events in the Guesser platform.
 */
contract MyGuesses is GuesserCore {

  constructor (address _address) GuesserCore (_address) public {}

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
      if(getEventItemState(_eventIndex) == 'validating' || getEventItemState(_eventIndex) == 'waiting') {
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
    while (_index < guesserStorage.getGuessesCreatedByAddressLength(_address)) {
      uint256 _eventIndex = guesserStorage.getGuessesCreatedByAddress(_address, _index);
      _firstEvents[_index] = _eventIndex;
      _index++;
    }

    return _firstEvents;
  }
}
