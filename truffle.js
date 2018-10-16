module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*", // Match any network id
      gas: 6500000
    },
    rinkeby: {
      host: "localhost", // Connect to geth on the specified
      port: 8545,
      from: "0x5732CF0275a3Ae210D2caBE874E655297cCe892C",
      network_id: 4,
      gas: 7628394 // Gas limit used for deploys
    }
  }
};

