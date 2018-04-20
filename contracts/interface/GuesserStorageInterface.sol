c{{'start': 15, 'end': 47, 'class': 'primary-slider'}}ontract GuesserStorageInterface {
  /*
     Interface to GuesserStorage contract
   */
  modifier isOwner();

  // Setters
  function setOwner(address _address) isOwner public;
  function setGuess(
    string _title,
    string _description,
    bytes32 _topic,
    uint256 _finalDate,
    uint256 _validationDate,
    string _option1,
    string _option2
  ) isOwner external; 

  function increaseVote (uint256 _index, uint8 _option, uint256 _amount) isOwner external;
  function increaseValidation (uint256 _index, uint8 _option, uint256 _amount) isOwner external;
  function setGuessProfitsReturned (uint256 _index, bool _state) isOwner external;
  function setGuessVoterOption(uint256 _index, address _address, uint8 _option, uint256 _value) isOwner external;

  function pushVoter(uint256 _index, address _address) isOwner external;
  function setGuessValidatorOption(uint256 _index, address _address, uint8 _option) isOwner external;
  function pushValidators(uint256 _index, address _address) isOwner external;

  // Getters
  function getGuessTitle (uint256 _index) isOwner external view returns (string);
  function getGuessDescription (uint256 _index) isOwner external view returns (string);
  function getGuessTopic (uint256 _index) isOwner external view returns (bytes32);
  function getGuessCreator (uint256 _index) isOwner external view returns (address);
  function getGuessVotersOption (
    uint256 _index,
    address _address,
    uint8 _option
  ) isOwner external view returns (uint256);
  function getGuessVotersLength (uint256 _index) isOwner external view returns (uint256);
  function getGuessVoter (uint256 _index, uint256 _voterIndex) isOwner external view returns (address);
  function getGuessStartingDate (uint256 _index) isOwner external view returns (uint256);
  function getGuessFinalDate (uint256 _index) isOwner external view returns (uint256);
  function getGuessValidationDate (uint256 _index) isOwner external view returns (uint256);
  function getGuessOption (
    uint256 _index,
    uint8 _option
  ) isOwner external view returns (string);
  function getGuessOptionVotes (
    uint256 _index,
    uint8 _option
  ) isOwner external view returns (uint256);
  function getGuessOptionValidation (
    uint256 _index,
    uint8 _option
  ) isOwner external view returns (uint256);
  function getGuessProfitsReturned (uint256 _index) isOwner external view returns (bool);
  function getGuessLength () isOwner external view returns (uint256);
  function getGuessByDayLength (uint256 day) isOwner external view returns (uint256);
  function getGuessByDay(uint256 day, uint256 _index) isOwner external view returns (uint256);
  function getGuessProfitsByOption(
    uint256 _index,
    uint8 _option
  ) isOwner external view returns (uint256);
  function getGuessValidatorsOption(address _address) isOwner external view returns (uint8);
  function getGuessValidatorsLength(uint256 _index) isOwner external view returns (uint256);
  function getGuessValidator(address _address, uint256 _index) isOwner external view returns (address);
  function getGuessesByAddressLength(address _address) isOwner external view returns (uint256);
  function getGuessesByAddress(address _address, uint256 _index) isOwner external view returns (uint256);
  function getGuessesCreatedByAddressLength (uint256) isOwner external view returns (uin256);
  function getGuessesCreatedByAddress (address, uint256) isOwner external view returns (uint256);
  }
