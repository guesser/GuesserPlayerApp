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
        window.web3.utils.asciiToHex(_title),
        window.web3.utils.asciiToHex(_description),
        window.web3.utils.asciiToHex(_topic),
        _finalDate,
        window.web3.utils.fromAscii(_option1),
        window.web3.utils.fromAscii(_option2),
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
        {from: window.web3.eth.accounts[0]}
      ).then(guess => {
        resolve([
          window.web3.toAscii(guess[0]).replace(/\u0000/g, ''), // title
          window.web3.toAscii(guess[1]).replace(/\u0000/g, ''), // description
          window.web3.toAscii(guess[2]).replace(/\u0000/g, ''), // topic
          guess[3], // creator
          guess[4], // votes it has
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
        {from: window.web3.eth.accounts[0]}
      ).then(number => {
        resolve(number)
      }).catch(err => {
        reject(err)
      })
    })
  }
}

export default GuessHelper
