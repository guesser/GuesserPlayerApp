import contract from 'truffle-contract'
import GuesserCore from '@contracts/GuesserCore.json'

const GuesserCoreHelper = {
  contract: null,

  instance: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract.setProvider(window.web3.currentProvider)

      self.contract = contract(GuesserCore)
      self.contract.deployed().then(instance => {
        self.instance = instance
      }).catch((err) => {
        reject(err)
      })
    })
  },

  getEventItemState: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getEventItemState.call(index).then((eventItemState) => {
        resolve(window.web3.utils.hexToUtf8(eventItemState)) // topic
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessesNumber: function () {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessesLength.call(
      ).then(number => {
        resolve(number)
      }).catch(err => {
        reject(err)
      })
    })
  }
}
export default GuesserCoreHelper
