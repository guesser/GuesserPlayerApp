module.exports = {
    networks: {
        development: {
            host: "localhost",
            port: 8545,
            network_id: "*", // Match any network id
            gas: 4600000
        },
        rinkeby: {
          host: "localhost", // Connect to geth on the specified
          port: 8545,
          from: "0xe91Bb93e33BCc765f9e3Ac268E9eA0aC505341c9", // default address to use for any transaction Truffle makes during migrations
          network_id: 4,
          gas: 4612388 // Gas limit used for deploys
        }
    }
};

