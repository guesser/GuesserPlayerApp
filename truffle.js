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
          network_id: '4',
          gas: 4700000 // Gas limit used for deploys
        }
    }
};

