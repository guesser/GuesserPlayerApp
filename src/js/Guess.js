import contract from 'truffle-contract'
import Guess from '@contracts/Guess.json'

const GuessHelper = {

  contract: null,

  instance: null,

  address: null,

  GuessCreated: null,

  GuessVoted: null,

  GuessValidated: null,

  ProfitsReturned: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(Guess)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance

        // Getting the accounts
        window.web3.eth.getAccounts(function (error, accounts) {
          // Getting events
          self.GuessCreated = self.instance.GuessCreated()
          self.GuessVoted = self.instance.GuessVoted()
          self.GuessValidated = self.instance.GuessValidated()
          self.ProfitsReturned = self.instance.ProfitsReturned()
          self.TestValue = self.instance.test_value()

          if (error) {
            console.log(error)
          } else {
            self.address = accounts
            resolve()
          }
        })
      }).catch(err => {
        reject(err)
      })
    })
  },

  CreatedGuessEvent: function () {
    this.GuessCreated.watch(function (error, result) {
      if (!error) {
        console.log('No error on creating guess event catcher! See: ', result)
      } else {
        console.log(error)
      }
    })
  },

  VotedGuessEvent: function () {
    this.GuessVoted.watch(function (error, result) {
      if (!error) {
        console.log('No error on voting guess event catcher! See: ', result)
      } else {
        console.log(error)
      }
    })
  },

  ValidatedGuessEvent: function () {
    this.GuessValidated.watch(function (error, result) {
      if (!error) {
        console.log('No error on validating guess event catcher! See: ', result)
      } else {
        console.log(error)
      }
    })
  },

  ReturnedProfitsEvent: function () {
    this.ProfitsReturned.watch(function (error, result) {
      if (!error) {
        console.log('No error on returning profit event catcher! See: ', result)
      } else {
        console.log(error)
      }
    })
  },

  TestValue: function () {
    this.TestValue.watch(function (error, result) {
      if (!error) {
        console.log('Test Value: ', result)
      } else {
        console.log(error)
      }
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
        _title,
        _description,
        window.web3.utils.asciiToHex(_topic),
        _finalDate,
        _option1,
        _option2,
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
        index
      ).then(guess => {
        resolve([
          guess[0], // title
          guess[1], // description
          window.web3.utils.hexToUtf8(guess[2]), // topic
          guess[3], // creator
          new Date(guess[4].c[0] * 1000), // the day it started
          new Date(guess[5].c[0] * 1000) // the final date
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
        {from: self.address[0]}
      ).then(guess => {
        resolve([
          guess[0], // option1
          guess[1], // option2
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
        {from: self.address[0]}
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
        window.web3.utils.toHex(topic)
      ).then(_guessIndex => {
        resolve(_guessIndex.c[0])
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
        date
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
      console.log(self.address[0])
      self.instance.voteGuess(
        _guessIndex,
        _option,
        {from: self.address[0],
          value: window.web3.utils.toWei(ethAmount.toString(), 'ether'),
          gas: 6385875} // TODO: Gas forced
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
        {from: self.address[0], gas: 6385876} // TODO: Gas forced again
      ).then(() => {
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  getGuessesToValidate: function (index, date) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessesToValidate.call(
        index,
        date
      ).then(guessesIndex => {
        resolve(guessesIndex)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getCurrentGuessesByAddress: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      console.log(self.address[0])
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

  getCreatedGuessesByAddress (index) {
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
  }
}

export default GuessHelper
