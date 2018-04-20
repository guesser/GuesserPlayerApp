contract GuesserStorageInterface {
  /*
     Interface to GuesserStorage contract
   */
  modifier isOwner();
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
  function getGuessVoter (uint256 _index) isOwner external view returns (address);
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
  }
