pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/Event.sol";

contract TestEvent {
  Event eventObject = Event(DeployedAddresses.Event());
  
  function testGetZeroNotes() public {
    Event eventObject1 = new Event();
    uint256 length = eventObject1.getEventsLength();
    Assert.equal(length, 0, "Number of notes is not 0.");
  }
}
