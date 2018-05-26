const NetworkHelper = {
  state: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.web3Connected = window.web3.currentProvider.connected
      if (window.web3.currentProvider.connected === undefined) {
        self.state = 'locked'
      } else {
        self.state = 'disconnected'
      }

      window.web3.eth.getAccounts((error, accounts) => {
        if (error) {
          resolve()
        } else if (accounts.length > 0) {
          self.state = 'connected'
        }
        resolve()
      })
    })
  }
}
export default NetworkHelper
