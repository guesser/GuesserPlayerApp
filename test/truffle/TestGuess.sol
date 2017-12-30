pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../../contracts/Guess.sol";

contract TestGuess {
  Guess guessObject = Guess(DeployedAddresses.Guess());

  function testGetZeroGuess() public {
    Guess guessObject1 = new Guess();
    uint256 length = guessObject1.getGuessesLength();
    Assert.equal(length, 0, "Number of guesses is not 0.");
  }

  function testCreateGuess() public {
    bytes32 _t = "hola";
    bytes32 _d = "holahola";
    bytes32 _tc = "crypto";
    address _c = msg.sender;
    bytes32 _eV = 30;
    bytes32 _o1 = "yes";
    bytes32 _o2 = "no";
    bytes32 _o3 = "maybe";
    bytes32 _o4 = "no way";

    guessObject.setGuess(_t, _d, _tc, _c, _eV, _o1, _o2, _o3, _o4);
    uint256 length = guessObject.getGuessesLength();
    Assert.equal(length, 1, "Number of guesses is not 1");
  }

  function testGetGuess() public {
    var (_t, _d, _to, _c, _eV, _da) = guessObject.getGuess(0);
    Assert.equal(_t, "hola", "The first item is not hola");
  }
}
