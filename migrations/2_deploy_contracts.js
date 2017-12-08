var Guess = artifacts.require("./Guess.sol");
var User = artifacts.require("./User.sol");
var Event = artifacts.require("./Event.sol");

module.exports = function(deployer) {
  deployer.deploy(User);
  deployer.deploy(Guess);
  deployer.deploy(Event);
};
