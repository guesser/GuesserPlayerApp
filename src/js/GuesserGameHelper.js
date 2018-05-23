import contract from 'truffle-contract'
import GuesserGame from '@contracts/GuesserGame.json'

const GuesserGameHelper = {
  contract: null,

  instance: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(GuesserGame)

      self.contract.setProvider(window.web3.currentProvider)
      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch((err) => {
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
          new Date(guess[5].c[0] * 1000), // the final voting date
          new Date(guess[6].c[0] * 1000) // the validation start date
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

  getGuessOfTheWeek: function (topic) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getWeekGuess.call(
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

  getGuessesByWeek: function (index, topic, date) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getGuessesByWeek.call(
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
  getValidationsByAddress: function (address) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getValidationsByAddress.call(
        address
      ).then(validatedGuesses => {
        resolve(validatedGuesses)
      }).catch(err => {
        reject(err)
      })
    })
  }
}
export default GuesserGameHelper
