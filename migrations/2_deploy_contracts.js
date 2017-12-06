var Users = artifacts.require("./Users.sol");
var Guess = artifacts.require("./Guess.sol");
var User = artifacts.require("./User.sol");

module.exports = function(deployer) {
  deployer.deploy(Users);
  deployer.deploy(User);
  deployer.deploy(Guess);
};
