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

    return new Promise((resolve, reject) => {
      self.instance.setGuess(
        window.web3.utils.toHex(_title),
        _description,
        window.web3.utils.toHex(_topic),
        _finalDate,
        window.web3.utils.toHex(_option1),
        window.web3.utils.toHex(_option2),
        {from: self.address[0], gas: 600000} // TODO: Gas forced to high #WARNING
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
          window.web3.utils.hexToUtf8(guess[0]), // title
          guess[1], // description
          window.web3.utils.hexToUtf8(guess[2]), // topic
          guess[3], // creator
          guess[4].c[0], // votes it has
          new Date(guess[5].c[0] * 1000), // the day it started
          new Date(guess[6].c[0] * 1000) // the final date
        ])
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessOptions: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessOptions.call(
        index,
        {from: self.address}
      ).then(guess => {
        resolve([
          window.web3.utils.hexToUtf8(guess[0]), // option1
          window.web3.utils.hexToUtf8(guess[1]), // option2
          guess[2], // option1Votes
          guess[3], // option2Votes
          guess[4], // option1Validation
          guess[5] // option2Validation
        ])
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessOptionsProfits: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessOptionsProfits.call(
        index,
        {from: self.address}
      ).then(guess => {
        resolve([
          window.web3.utils.fromWei(guess[0].c[0].toString(), 'Kwei'), // amount of eth in the 1 option
          window.web3.utils.fromWei(guess[1].c[0].toString(), 'Kwei') // amount of eth in the 2 option
        ])
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessOfTheDay: function (topic) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getTodayGuess.call(
        window.web3.utils.toHex(topic),
        {from: self.address}
      ).then(_guessIndex => {
        resolve(_guessIndex)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessesByDate: function (index, topic, date) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessesByDate.call(
        index,
        window.web3.utils.toHex(topic),
        date,
        {from: self.address}
      ).then(_guessesIndex => {
        resolve(_guessesIndex)
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
  },

  voteGuess: function (_guessIndex, _option, ethAmount) { // Option has to be between 1 and 2
    let self = this

    ethAmount = 10 * (ethAmount / 10)
    return new Promise((resolve, reject) => {
      self.instance.voteGuess(
        _guessIndex,
        _option,
        {from: self.address[0], value: window.web3.utils.toWei(ethAmount.toString(), 'ether'), gas: 500000} // TODO: Gas forced
      ).then(() => {
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  validateGuess: function (_guessIndex, _option) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.validateGuess(
        _guessIndex,
        _option,
        {from: self.address[0], gas: 400000} // TODO: Gas forced again
      ).then(() => {
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessesToValidate: function (_index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessesToValidate.call(
        _index,
        {from: self.address}
      ).then(_guessesIndex => {
        resolve(_guessesIndex)
      }).catch(err => {
        reject(err)
      })
    })
  }
}

export default GuessHelper
