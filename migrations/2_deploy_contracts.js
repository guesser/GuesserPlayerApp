const DateTime = artifacts.require("./DateTime.sol");
const Guesser = artifacts.require("./Guesser.sol");
const GuesserStorage = artifacts.require("./GuesserStorage.sol");

// Interfaces
const DateTimeInterface = artifacts.require("./interface/DateTimeInterface.sol")
const GuesserStorageInterface = artifacts.require("./interface/GuesserStorageInterface.sol")

module.exports = async function(deployer, network) {
  return deployer.deploy(GuesserStorage).then(() => {
    return deployer.deploy(DateTime).then(() => {
      return deployer.deploy(Guesser, GuesserStorage.address).then(() => {
        return GuesserStorage.deployed().then(async GuesserStorageInstance => {
          return Guesser.deployed().then(async GuesserInstance => {
            await GuesserStorage.setOwner(
              GuesserInstance.address
            )
            return deployer
          });
        });
      });
    });
  });
};
