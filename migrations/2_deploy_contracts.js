var Guess = artifacts.require("./Guess.sol");

module.exports = function(deployer) {
  deployer.deploy(Guess);
};
