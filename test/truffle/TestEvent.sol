pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/Event.sol";

contract TestEvent {
  Event eventObject = Event(DeployedAddresses.Event());

  function testGetZeroEvent() public {
    Event eventObject1 = new Event();
    uint256 length = eventObject1.getEventsLength();
    Assert.equal(length, 0, "Number of events is not 0.");
  }
  function testCreateEvent() public {
    bytes32 _t = "hola";
    bytes32 _d = "holahola";
    bytes32 _to = "crypto";
    bytes32 _1 = "yes";
    bytes32 _2 = "no";
    bytes32 _3 = "maybe";
    bytes32 _4 = "no way";
    eventObject.setEvent(_t, _d, _to, _1, _2, _3, _4);
    uint256 length = eventObject.getEventsLength();
    Assert.equal(length, 1, "Number of events is not 1.");
  }

  function testGetEvent() public {
    var (_t, _d, _to, _da, _v, _i) = eventObject.getEvent(0);
    Assert.equal(_t, "hola", "First item is not hola");
  }
}
