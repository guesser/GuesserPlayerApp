const DateTime = artifacts.require("./DateTime.sol");
const Guesser = artifacts.require("./Guesser.sol");
const GuesserStorage = artifacts.require("./GuesserStorage.sol");

// Interfaces
// const GuesserStorageInterface = artifacts.require("./interface/GuesserStorageInterface.sol")

module.exports = async function(deployer, network) {
  await deployer.deploy(GuesserStorage);
  await deployer.deploy(DateTime);
  console.log('GuesserStorage address: ', GuesserStorage.address);
  await deployer.deploy(Guesser, GuesserStorage.address).catch((err) => {
    console.log(err)
  });
}

/*
  module.exports = async function(deployer, network) {
  return deployer.deploy(GuesserStorage).then(() => {
    return deployer.deploy(DateTime).then(() => {
      return GuesserStorage.deployed().then(async GuesserStorageInstance => {
        return deployer.deploy(Guesser, GuesserStorageInstance.address).then(() => {
          return Guesser.deployed().then(async GuesserInstance => {
            await GuesserStorage.setOwner(
              GuesserInstance.address
            )
            return deployer
          });
        })
      })
    });
  });
}; */
