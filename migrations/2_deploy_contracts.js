var Users = artifacts.require("./Users.sol");
var Guess = artifacts.require("./Guess.sol");

module.exports = function(deployer) {
  deployer.deploy(Users);
  deployer.deploy(Guess);
};
