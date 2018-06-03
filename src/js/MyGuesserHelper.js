import contract from 'truffle-contract'
import MyGuesses from '@contracts/MyGuesses.json'

const MyGuessesHelper = {
  contract: null,

  address: null,

  instance: null,

  init: function (address) {
    this.address = address
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(MyGuesses)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch((err) => {
        reject(err)
      })
    })
  },

  getCurrentGuessesByAddress: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getCurrentGuessesByAddress.call(
        index,
        self.address[0]
      ).then(addressEvents => {
        resolve(addressEvents)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getValidatingGuessesByAddress: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getValidatingGuessesByAddress.call(
        index,
        self.address[0]
      ).then(addressEvents => {
        resolve(addressEvents)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getPastGuessesByAddress: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getPastGuessesByAddress.call(
        index,
        self.address[0]
      ).then(addressEvents => {
        resolve(addressEvents)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getCreatedGuessesByAddress: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getCreatedGuessesByAddress.call(
        index,
        self.address[0]
      ).then(addressEvents => {
        resolve(addressEvents)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessProfitsReturned: function (event) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessAddressProfitsReturned.call(
        event
      ).then(profitsReturned => {
        resolve(profitsReturned)
      }).catch(err => {
        reject(err)
      })
    })
  }
}
export default MyGuessesHelper
