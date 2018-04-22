import contract from 'truffle-contract'
import GuesserGame from '@contracts/GuesserGame.json'

const GuesserGameHelper = {
  contract: null,

  instance: null,

  address: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(GuesserGame)
      self.contract.deployed().then(instance => {
        self.instance = instance
      }).catch((err) => {
        reject(err)
      })
    })
  },
}
export default GuesserGameHelper
