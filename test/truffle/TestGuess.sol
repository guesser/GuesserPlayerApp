pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/Guess.sol";

contract TestGuess {
  Guess guessObject = Guess(DeployedAddresses.Guess());

  function testGetZeroGuess() public {
    guessObject = new Guess();
    uint256 length = guessObject.getGuessesLength();
    Assert.equal(length, 0, "Number of guesses is not 0.");
  }

  function testSetGuess() public {
    bytes32 _t = "hola";
    string memory _d = "holahola";
    bytes32 _tc = "crypto";
    address _c = msg.sender;
    uint256 _fd = now;
    bytes32 _o1 = "yes";
    bytes32 _o2 = "no";
    bytes32 _o3 = "maybe";
    bytes32 _o4 = "no way";

    guessObject.setGuess(_t, _d, _tc, _c, _fd, _o1, _o2, _o3, _o4);
    uint256 length = guessObject.getGuessesLength();
    Assert.equal(length, 1, "Number of guesses is not 1");
  }

  function testGetGuess() public {
    var (_t, _d, _to, _c, _v, _firD, _finD) = guessObject.getGuess(0);
    Assert.equal(_t, "hola", "The first item is not hola");
  }

  function testGetGuessOptions() public {
    var (_1, _2, _3, _4) = guessObject.getGuessOptions(0);
    Assert.equal(_1, "yes", "The option is not 'yes'");
  }

  function testGetGuessDay() public {
    uint _day = guessObject.getTodayGuesses(0);
    Assert.equal(_day, 6, "The day is not the correct");
  }
}
