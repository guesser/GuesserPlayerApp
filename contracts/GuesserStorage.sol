pragma solidity ^0.4.22;

contract GuesserStorage {
  // Events
  event GuessCreated(uint256 index, string title, bytes32 topic);
  event GuessVoted(uint256 index,
                   uint8 option,
                   string title,
                   string optionName,
                   uint256 value,
                   address user);
  event GuessValidated(uint256 guess, uint8 option, address sender);
  event ProfitsReturned(uint256 guess);

  // Data structures
  struct GuessStruct {
    string title;
    string description;
    bytes32 topic;
    address creator;
    /* The voters and the option the voted
     * It will store an array which has:
     * 0. The option voted as a first argument (1 or 2, or 3 if both options were voted by the address)
     * 1. The amount voted in the first option
     * 2. The amount voted in the second option
     */
    mapping (address => uint256[3]) votersOption;
    address[] voters;

    // About validatorsOption
    // Put it outside
    // address --> [guess, option]
    mapping (address => uint8) validatorsOption;
    address[] validators;
    uint256 startingDate;
    uint256 finalDate;
    uint256 validationDate;
    string option1; // Options to vote
    string option2;
    uint256 option1Votes; // Number of votes an option has
    uint256 option2Votes;
    uint256 option1Validation; // Number of validations an option has
    uint256 option2Validation;
    bool profitsReturned; // Has the guess returned the profits?
  }

  GuessStruct[] guesses; // Data structure to store all the guesses in the platform
  mapping (uint256 => uint256[]) guessesByDate; // Storing the guesses by their date
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
          startingDate: now,
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
    * @param _description string The description of the Guess
  * @param _topic bytes32 The topic of the Guess
  * @param _finalDate uint256 The final date of the Guess
  * @param _option1 string The first option to vote on the Guess
  * @param _option2 string The first option to vote on the Guess
  */
  function setGuess(
    string _title,
    string _description,
    bytes32 _topic,
    uint256 _finalDate,
    uint256 _validationDate,
    string _option1,
    string _option2
  ) isOwner external {
    address[] memory _voters;
    address[] memory _validators;

    GuessStruct memory _guess = GuessStruct({
      title: _title,
      description: _description,
      topic: _topic,
      creator: msg.sender,
      voters: _voters,
      validators: _validators,
      startingDate: now,
      finalDate: _finalDate,
      validationDate: _validationDate,
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
    guessesCreatedByAddress[msg.sender].push(_len);
    GuessCreated(_len, _title, _topic);
  }


  /**
   * Getters *
   */

  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
   */
  function getGuessTitle (uint256 _index) isOwner external view returns (string) {
    return guesses[_index].title;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
   */
  function getGuessDescription (uint256 _index) isOwner external view returns (string) {
    return guesses[_index].description;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
   */
  function getGuessTopic (uint256 _index) isOwner external view returns (bytes32) {
    return guesses[_index].topic;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
   */
  function getGuessCreator (uint256 _index) isOwner external view returns (address) {
    return guesses[_index].creator;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
   */
  function getGuessVotersOption (uint256 _index, address _address, uint8 _option) isOwner external view returns (uint256) {
    require (_option == 0 || _option == 1 || _option == 2);

    return guesses[_index].votersOption[_address][_option];
  }

  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
   */
  function getGuessVotersLength (uint256 _index) isOwner external view returns (uint256) {
    return guesses[_index].voters.length;
  }

  /**
    * @dev Function that returns the final date of a guess
    * @return uint256 The final date of the guess
    */
  function getGuessVoter (uint256 _index) isOwner external view returns (address) {
    return guesses[_index].voters[_index];
  }

  /**
    * @dev Function that returns the final date of a guess
    * @return uint256 The final date of the guess
    */
  function getGuessStartingDate (uint256 _index) isOwner external view returns (uint256) {
    return guesses[_index].startingDate;
  }
  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
   */
  function getGuessFinalDate (uint256 _index) isOwner external view returns (uint256) {
    return guesses[_index].finalDate;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
   */
  function getGuessValidationDate (uint256 _index) isOwner external view returns (uint256) {
    return guesses[_index].validationDate;
  }

  /**
   * @dev Function that returns the option asked for
   * @param uint256 The guess your are asking about
   * @param uint8 the option you want
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
   * @param uint256 The guess your are asking about
   * @param uint8 the option you want
   * @return string the option you are asking for
   */
  function getGuessOptionVotes (uint256 _index, uint8 _option) isOwner external view returns (uint256) {
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
   * @param uint256 The guess your are asking about
   * @param uint8 the option you want
   * @return string the option you are asking for
   */
  function getGuessOptionValidation (uint256 _index, uint8 _option) isOwner external view returns (uint256) {
    uint8 first = 1;
    uint8 second = 2;
    require(_option == first || _option == second);

    if (_option == first)
      return guesses[_index].option1Validation;
    else
      return guesses[_index].option2Validation;
  }

  /**
   * @dev Function that returns the final date of a guess
   * @return uint256 The final date of the guess
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
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessByDayLength (uint256 day) isOwner external view returns (uint256) {
    return guessesByDate[day].length;
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessByDay(uint256 day, uint256 _index) isOwner external view returns (uint256) {
    return guessesByDate[day][_index];
  }

  /**
   * @dev Function that returns the guess of a day sorted by a number
   * @return uint256 The id of the asked guess of the day
   */
  function getGuessProfitsByOption(uint256 _index, uint8 _option) isOwner external view returns (uint256) {
    return guessesByDate[day][_index];
  }

}
