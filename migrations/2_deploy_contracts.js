var DateTime = artifacts.require("./library/DateTime.sol");
var Guess = artifacts.require("./Guess.sol");

module.exports = function(deployer) {
  deployer.deploy(DateTime);
  deployer.deploy(Guess);
};
