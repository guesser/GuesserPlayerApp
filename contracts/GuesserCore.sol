pragma solidity ^0.4.23;

import "./DateTime.sol";
import "./GuesserStorage.sol";

/**
 * @title GuesserCore
 * @dev GuessCore contract to vote and create events in the Guesser platform.
 */
contract GuesserCore is DateTime {
  GuesserStorage guesserStorage;

  /**
   * @dev constructor. Sets the guesserStorage address for the
   * Eternal Storage Pattern
   */
  constructor (address _guesserStorageAddress) public {
    guesserStorage = GuesserStorage(_guesserStorageAddress);
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
            _validations < _half && _votes != 0)
            _state = "validating";
            else if((DateTime.dateDue(guesserStorage.getGuessValidationDate(_index)) == true &&
            _validations >= _half) ||
                    (DateTime.dateDue(guesserStorage.getGuessFinalDate(_index)) && _votes == 0))
      _state = "passed";

    return _state;
  }

  function percent(uint numerator, uint denominator, uint precision) public pure returns(uint quotient) {

    // TODO: caution, check safe-to-multiply here
    uint _numerator  = numerator * 10 ** (precision+1);
    // with rounding of last digit
    uint _quotient =  ((_numerator / denominator) + 5) / 10;
    return ( _quotient);
  }

  /**
   * @dev Returns the length of the guesses array.
   * @return A uint256 with the actual length of the array of guesses
   */
  function getGuessesLength() public view returns (uint256){
    return guesserStorage.getGuessLength();
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

  function getGuessWinner (uint256 _guess) public view returns (uint8) {
    if (guesserStorage.getGuessOptionValidation(_guess, 1) > guesserStorage.getGuessOptionValidation(_guess, 2)) {
      return 1; // The winner is the first one
    } else {
      return 2; // The winner is the second one
    }
  }
}
