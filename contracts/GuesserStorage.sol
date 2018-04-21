pragma solidity ^0.4.23;

import "./DateTime.sol";

contract GuesserStorage is DateTime{
  // Data structures
  struct GuessStruct {
    string title;
    string description;
    bytes32 topic;
    address creator;
    /* The voters and the option the voted
     * It will store an array which hasguessesByAddress
     * 0. The option voted as a first argument (1 or 2, or 3 if both options were voted by the address)
     * 1. The amount voted in the first option
     * 2. The amount voted in the second option
     */
    mapping (address => uint128[3]) votersOption;
    address[] voters;

    // About validatorsOption
    // Put it outside
    // address --> [guess, option]
    mapping (address => uint8) validatorsOption;
    address[] validators;
    uint32 startingDate;
    uint32 finalDate;
    uint32 validationDate;
    string option1; // Options to vote
    string option2;
    uint128 option1Votes; // Number of votes an option has
    uint128 option2Votes;
    uint64 option1Validation; // Number of validations an option has
    uint64 option2Validation;
    bool profitsReturned; // Has the guess returned the profits?
  }

  GuessStruct[] guesses; // Data structure to store all the guesses in the platform
  mapping (uint32 => uint256[]) guessesByDate; // Storing the guesses by their date
  // The dates are in this format: 0000:year, 00:month, 00:day
  // Example: 19940831
  mapping (address => uint256[]) guessesByAddress; // Storing the guesses by their voters
  mapping (address => uint256[]) guessesCreatedByAddress; // Storing the guesses by their creators

  // The current owners
  mapping(address => bool) accessAllowed;
  /**
   * @dev constructor. Creates the first Guess, empty
   * It also loades the first owner
   */
  constructor () public {
    // Setting the owner
    accessAllowed[msg.sender] = true;

    // Creating the initial guess
    address[] memory _voters;
    address[] memory _validators;
    GuessStruct memory _guess = GuessStruct({
      title: '',
          description: '',
          topic: '',
          creator: 0x00000000000000000000000000000000,
          voters: _voters,
          validators: _validators,
          startingDate: uint32(now),
          finalDate: 0,
          validationDate: 0,
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

  modifier isOwner () {
    require (accessAllowed[msg.sender] == true);
    _;
  }

  function setOwner (address _address) isOwner public {
    accessAllowed[_address] = true;
  }

  /**
   * Setters *
   */

  /**
  * @dev Function that creates a Guess.
  * @param _title string The title of the Guess.
  * @param _finalDate uint256 The final date of the Guess
  * @param _validationDate uint256 The final date of the Guess
  */
  function setGuess(
    string _title,
    uint32 _finalDate,
    uint32 _validationDate
                    ) isOwner external returns (uint256){
    address[] memory _voters;
    address[] memory _validators;

    GuessStruct memory _guess = GuessStruct({
      title: _title,
      description: "",
      topic: "",
      creator: msg.sender,
          voters: _voters,
      validators: _validators,
      startingDate: uint32(now),
      finalDate: _finalDate,
      validationDate: _validationDate,
      option1: "",
      option2: "",
      option1Votes: 0,
      option2Votes: 0,
      option1Validation: 0,
      option2Validation: 0,
      profitsReturned: false
    });
    uint256 _len = guesses.push(_guess) -1; // Adds the new struct and return its position
    uint32 _year = DateTime.getYear(_finalDate) * 10000;
    uint32 _month = DateTime.getMonth(_finalDate) * 100;
    uint32 _day = DateTime.getDay(_finalDate);
    guessesByDate[_year + _month + _day].push(_len);
    guessesCreatedByAddress[msg.sender].push(_len);
  }

  /**
   * @dev Function that creates a Guess.
  * @param _description string The description of the Guess
  * @param _topic bytes32 The topic of the Guess
  * @param _option1 string The first option to vote on the Guess
  * @param _option2 string The first option to vote on the Guess
  */
  function setGuessSecondOptions(
                                 uint256 _index,
                                 string _description,
                                 bytes32 _topic,
                                 string _option1,
                                 string _option2
                                 ) isOwner external {
    guesses[_index].description = _description;
    guesses[_index].topic = _topic;
    guesses[_index].option1 = _option1;
    guesses[_index].option2 = _option2;
  }
  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @param _option uint8 The description of the Guess
   * @param _amount uint256 The description of the Guess
   */
  function increaseVote (uint256 _index, uint8 _option, uint128 _amount) isOwner external {
    if (_option == 1)
      guesses[_index].option1Votes += _amount;
    else
      guesses[_index].option2Votes += _amount;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @param _option uint8 The description of the Guess
   * @param _amount uint256 The description of the Guess
   */
  function increaseValidation (uint256 _index, uint8 _option, uint64 _amount) isOwner external {
    if (_option == 1)
      guesses[_index].option1Validation += _amount;
    else
      guesses[_index].option2Validation += _amount;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @param _state bool The description of the Guess
   */
  function setGuessProfitsReturned (uint256 _index, bool _state) isOwner external {
    guesses[_index].profitsReturned = _state;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @param _address address The description of the Guess
   * @param _option uint8 The description of the Guess
   * @param _value uint256 The description of the Guess
   */
  function setGuessVoterOption(uint256 _index, address _address, uint8 _option, uint128 _value) isOwner external {
    guesses[_index].votersOption[_address][_option] = _value;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @param _address address The description of the Guess
   */
  function pushVoter(uint256 _index, address _address) isOwner external {
    guesses[_index].voters.push(_address);
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @param _address address The description of the Guess
   * @param _option uint8 The description of the Guess
   */
  function setGuessValidatorOption(uint256 _index, address _address, uint8 _option) isOwner external {
    guesses[_index].validatorsOption[_address] = _option;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @param _address address The description of the Guess
   */
  function pushValidators(uint256 _index, address _address) isOwner external {
    guesses[_index].validators.push(_address);
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _address address The description of the Guess
   * @param _index uint256 The description of the Guess
   */
  function pushGuessesByAddress(address _address, uint256 _index) isOwner external {
    guessesByAddress[_address].push(_index);
  }

  /**
   * Getters *
   */

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @return string The final date of the guess
   */
  function getGuessTitle (uint256 _index) isOwner external view returns (string) {
    return guesses[_index].title;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @return string The final date of the guess
   */
  function getGuessDescription (uint256 _index) isOwner external view returns (string) {
    return guesses[_index].description;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @return bytes32 The final date of the guess
   */
  function getGuessTopic (uint256 _index) isOwner external view returns (bytes32) {
    return guesses[_index].topic;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @return address The final date of the guess
   */
  function getGuessCreator (uint256 _index) isOwner external view returns (address) {
    return guesses[_index].creator;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @return uint128 The final date of the guess
   */
  function getGuessVotersOption (uint256 _index, address _address, uint8 _option) isOwner external view returns (uint128) {
    require (_option == 0 || _option == 1 || _option == 2);

    return guesses[_index].votersOption[_address][_option];
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @return uint256 The final date of the guess
   */
  function getGuessVotersLength (uint256 _index) isOwner external view returns (uint256) {
    return guesses[_index].voters.length;
  }

  /**
    * @dev Function that returns the final date of a guess
    * @param _index uint256 The description of the Guess
    * @param _index uint256 The description of the Guess
    * @return address The final date of the guess
    */
  function getGuessVoter (uint256 _index, uint256 _voterIndex) isOwner external view returns (address) {
    return guesses[_index].voters[_voterIndex];
  }

  /**
    * @dev Function that returns the final date of a guess
    * @param _index uint256 The description of the Guess
    * @return uint256 The final date of the guess
    */
  function getGuessStartingDate (uint256 _index) isOwner external view returns (uint32) {
    return guesses[_index].startingDate;
  }
  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @return uint256 The final date of the guess
   */
  function getGuessFinalDate (uint256 _index) isOwner external view returns (uint32) {
    return guesses[_index].finalDate;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The description of the Guess
   * @return uint256 The final date of the guess
   */
  function getGuessValidationDate (uint256 _index) isOwner external view returns (uint32) {
    return guesses[_index].validationDate;
  }

  /**
   * @dev Function that returns the option asked for
   * @param _index uint256 The guess your are asking about
   * @param _option uint8 the option you want
   * @return string the option you are asking for
   */
  function getGuessOption (uint256 _index, uint8 _option) isOwner external view returns (string) {
    uint8 first = 1;
    uint8 second = 2;
    require(_option == first || _option == second);

    if (_option == first)
      return guesses[_index].option1;
    else
      return guesses[_index].option2;
  }

  /**
   * @dev Function that returns the option asked for
   * @param _index uint256 The guess your are asking about
   * @param _option uint8 the option you want
   * @return uint256 the option you are asking for
   */
  function getGuessOptionVotes (uint256 _index, uint8 _option) isOwner external view returns (uint128) {
    uint8 first = 1;
    uint8 second = 2;
    require(_option == first || _option == second);

    if (_option == first)
      return guesses[_index].option1Votes;
    else
      return guesses[_index].option2Votes;
  }

  /**
   * @dev Function that returns the option asked for
   * @param _index uint256 The guess your are asking about
   * @return uint256 the option you are asking for
   */
  function getGuessOptionVotesTotal (uint256 _index) isOwner external view returns (uint128) {
    return guesses[_index].option1Votes + guesses[_index].option2Votes;
  }

  /**
   * @dev Function that returns the option asked for
   * @param _index uint256 The guess your are asking about
   * @param _option uint8 the option you want
   * @return uint256 the option you are asking for
   */
  function getGuessOptionValidation (uint256 _index, uint8 _option) isOwner external view returns (uint64) {
    uint8 first = 1;
    uint8 second = 2;
    require(_option == first || _option == second);

    if (_option == first)
      return guesses[_index].option1Validation;
    else
      return guesses[_index].option2Validation;
  }

  /**
    * @dev Function that returns the option asked for
    * @param _index uint256 The guess your are asking about
    * @return uint256 the option you are asking for
    */
  function getGuessOptionValidationTotal (uint256 _index) isOwner external view returns (uint128) {
    return guesses[_index].option1Validation + guesses[_index].option2Validation;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @param _index uint256 The guess your are asking about
   * @return bool The final date of the guess
   */
  function getGuessProfitsReturned (uint256 _index) isOwner external view returns (bool) {
    return guesses[_index].profitsReturned;
  }

  /**
   * @dev Function that returns the total num of Guesses
   * @return uint256 The total num of Guesses
   */
  function getGuessLength () isOwner external view returns (uint256) {
    return guesses.length;
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _day uint256 The guess your are asking about
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessByDayLength (uint32 _day) isOwner external view returns (uint256) {
    return guessesByDate[_day].length;
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _day uint256 The guess your are asking about
   * @param _index uint256 The guess your are asking about
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessByDay(uint32 _day, uint256 _index) isOwner external view returns (uint256) {
    return guessesByDate[_day][_index];
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _index uint256 The guess your are asking about
   * @param _address address The guess your are asking about
   * @return uint8 The id of the asked guess of the day
   */
  function getGuessValidatorsOption(uint256 _index, address _address) isOwner external view returns (uint8) {
    return guesses[_index].validatorsOption[_address];
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _index uint256 The guess your are asking about
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessValidatorsLength(uint256 _index) isOwner external view returns (uint256) {
    return guesses[_index].validators.length;
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _guess uint256 The guess your are asking about
   * @param _index uint256 The guess your are asking about
   * @return address  The id of the asked guess of the day
   */
  function getGuessValidator(uint256 _guess, uint256 _index) isOwner external view returns (address) {
    return guesses[_guess].validators[_index];
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _address address The guess your are asking about
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessesByAddressLength(address _address) isOwner external view returns (uint256) {
    return guessesByAddress[_address].length;
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _address address The guess your are asking about
   * @param _index uint256 The guess your are asking about
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessesByAddress(address _address, uint256 _index) isOwner external view returns (uint256) {
    return guessesByAddress[_address][_index];
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _address address The guess your are asking about
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessesCreatedByAddressLength(address _address) isOwner external view returns (uint256) {
    return guessesCreatedByAddress[_address].length;
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @param _address address The guess your are asking about
   * @param _index  uin256 The guess your are asking about
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessesCreatedByAddress(address _address, uint256 _index) isOwner external view returns (uint256) {
    return guessesCreatedByAddress[_address][_index];
  }

}
