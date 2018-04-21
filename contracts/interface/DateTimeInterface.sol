pragma solidity ^0.4.23;

contract DateTimeInterface {
  /* 
   * Interface to DateTime contract
   */
  function isLeapYear (uint16 year) constant returns (bool);
  function leapYearsBefore(uint256 year) public pure returns (uint);
  function getYear (uint256 timestamp) constant returns (uint16);
  function getMonth (uint256 timestamp) constant returns (uint8);
  function getDay (uint256 timestamp) constant returns (uint8);
  function getHour (uint256 timestamp) constant returns (uint8);
  function getMinute (uint256 timestamp) constant returns (uint8);
  function getSecond (uint timestamp) constant returns (uint8);
  function getWeekday (uint timestamp) constant returns (uint8);
  function toTimestamp (
    uint16 year,
    uint8 month,
    uint8 day
  ) constant returns (uint timestamp);
  function toTimestamp (
    uint16 year,
    uint8 month,
    uint8 day,
    uint8 hour
  ) constant returns (uint timestamp);
  function toTimestamp (
    uint16 year,
    uint8 month,
    uint8 day,
    uint8 hour,
    uint8 minute
  ) constant returns (uint timestamp);
  function toTimestamp (
    uint16 year,
    uint8 month,
    uint8 day,
    uint8 hour,
    uint8 minute,
    uint8 second
  ) constant returns (uint timestamp);
  function dateDue (uint256 _date) public view returns (bool);
}
