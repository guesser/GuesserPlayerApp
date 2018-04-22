import contract from 'truffle-contract'
import GuesserInput from '@contracts/GuesserInput.json'

const GuesserInputHelper = {
  contract: null,

  instance: null,

  address: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(GuesserInput)
      self.contract.deployed().then(instance => {
        self.instance = instance
      }).catch((err) => {
        reject(err)
      })
    })
  },
}
export default GuesserInputHelper
