import contract from 'truffle-contract'
import GuesserCore from '@contracts/GuesserCore.json'

const GuesserCoreHelper = {
  contract: null,

  instance: null,

  address: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(GuesserCore)
      self.contract.deployed().then(instance => {
        self.instance = instance
      }).catch((err) => {
        reject(err)
      })
    })
  },
}
export default GuesserCoreHelper
