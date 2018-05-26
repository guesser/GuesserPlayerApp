const DateTime = artifacts.require("./DateTime.sol");
const GuesserStorage = artifacts.require("./GuesserStorage.sol");
const GuesserCore = artifacts.require("./GuesserCore.sol");
const GuesserGame = artifacts.require("./GuesserGame.sol");
const MyGuesses = artifacts.require("./MyGuesses.sol");
const GuesserInputs = artifacts.require("./GuesserInputs.sol");
const GuesserPayments = artifacts.require("./GuesserPayments.sol");

// Interfaces
// const GuesserStorageInterface = artifacts.require("./interface/GuesserStorageInterface.sol")

module.exports = async function(deployer, network) {
  return deployer.deploy(DateTime).then(() => {
    return deployer.deploy(GuesserStorage).then(() => {
      return deployer.deploy(GuesserCore, GuesserStorage.address).then(() => {
        return deployer.deploy(GuesserGame, GuesserStorage.address).then(() => {
          return deployer.deploy(MyGuesses, GuesserStorage.address).then(() => {
            return deployer.deploy(GuesserInputs, GuesserStorage.address).then(() => {
              return deployer.deploy(GuesserPayments, GuesserStorage.address).then(() => {
                return GuesserStorage.deployed().then(async GuesserStorageInstance => {
                  console.log('Setting the owners to the storage...')
                  await GuesserStorageInstance.setOwner(GuesserCore.address);
                  await GuesserStorageInstance.setOwner(GuesserGame.address);
                  await GuesserStorageInstance.setOwner(MyGuesses.address);
                  await GuesserStorageInstance.setOwner(GuesserInputs.address);
                  await GuesserStorageInstance.setOwner(GuesserPayments.address);
                  return deployer;
                });
              });
            });
          });
        });
      });
    });
  });
}
