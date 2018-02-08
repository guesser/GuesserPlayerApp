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
    bytes32 _tc = "Crypto";
    bytes32 _tc2 = "Random";
    address _c = msg.sender;
    uint256 _fd = now;
    bytes32 _o1 = "yes";
    bytes32 _o2 = "no";
    bytes32 _o3 = "maybe";
    bytes32 _o4 = "no way";

    guessObject.setGuess(_t, _d, _tc, _fd, _o1, _o2);
    guessObject.setGuess(_t, _d, _tc2, _fd, _o1, _o2);
    guessObject.setGuess(_t, _d, _tc, _fd, _o1, _o2);
    uint256 length = guessObject.getGuessesLength();
    Assert.equal(length, 3, "Number of guesses is not 3");
  }

  function testGetGuess() public {
    var (_t, _d, _to, _c, _v, _firD, _finD) = guessObject.getGuess(0);
    Assert.equal(_t, "hola", "The first item is not hola");
  }

  function testGetGuessOptions() public {
    var (_1, _2, _1V, _2V, _1Val, _2Val) = guessObject.getGuessOptions(0);
    Assert.equal(_1, "yes", "The option is not 'yes'");
  }

  function testGetGuessOfTheDay() public {
    bytes32 _topic = "Crypto";
    uint256 _topGuess = guessObject.getTodayGuess(_topic);
    Assert.equal(_topGuess, 0, "The day is not the correct");
  }

  function testGetGuessOfTheDayUnique() public {
    bytes32 _topic = "Random";
    uint256 _topGuess = guessObject.getTodayGuess(_topic);
    Assert.equal(_topGuess, 1, "The day is not the correct");
  }

  function testGetGuessesOfTheDay() public {
    bytes32 _topic = "Crypto";
    uint256[10] memory _topGuess = guessObject.getTodayGuesses(0, _topic);
    Assert.equal(_topGuess[0], 0, "The guess is not the correct");
    Assert.equal(_topGuess[1], 2, "The guess is not the correct");
  }

}
