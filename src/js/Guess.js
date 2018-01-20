import contract from 'truffle-contract'
import Guess from '@contracts/Guess.json'

const GuessHelper = {

  contract: null,

  instance: null,

  address: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(Guess)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance

        // Geting the accounts
        window.web3.eth.getAccounts(function (error, accounts) {
          if (error) {
            console.log(error)
          } else {
            self.address = accounts
          }
        })

        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  setGuessFront: function (
    _title,
    _description,
    _topic,
    _finalDate,
    _option1,
    _option2) {
    let self = this

    console.log(this.address)

    return new Promise((resolve, reject) => {
      self.instance.setGuess(
        window.web3.utils.toHex(_title),
        _description,
        window.web3.utils.toHex(_topic),
        _finalDate,
        window.web3.utils.toHex(_option1),
        window.web3.utils.toHex(_option2),
        {from: self.address[0], gas: 400000} // Gas forced to high #WARNING
      ).then(() => {
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessFront: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuess.call(
        index,
        {from: self.address}
      ).then(guess => {
        resolve([
          window.web3.utils.hexToUtf8(guess[0]).replace(/\u0000/g, ''), // title
          window.web3.utils.hexToUtf8(guess[1]).replace(/\u0000/g, ''), // description
          window.web3.utils.hexToUtf8(guess[2]).replace(/\u0000/g, ''), // topic
          guess[3], // creator
          window.web3.utils.hexToNumber(guess[4]), // votes it has
          guess[5], // the day it started
          guess[6] // the final date
        ])
      }).catch(err => {
        reject(err)
      })
    })
  },
  getGuessesNumber: function () {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessesLength.call(
        {from: self.address}
      ).then(number => {
        resolve(number)
      }).catch(err => {
        reject(err)
      })
    })
  }
}

export default GuessHelper
