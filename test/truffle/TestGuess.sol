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
}
