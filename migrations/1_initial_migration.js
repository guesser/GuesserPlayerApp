var Migrations = artifacts.require("./Migrations.sol");
const Web3 = require('web3');

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
