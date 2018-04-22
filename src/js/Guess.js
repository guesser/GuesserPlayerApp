import GuessCore from './GuesserCoreHelper.js'
import GuessGame from './GuesserGameHelper.js'
import GuessInputs from './GuesserInputHelper.js'
import MyGuesses from './MyGuesserHelper.js'

const GuessHelper = {

  contract: null,

  instance: null,

  address: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      // Getting the accounts
      window.web3.eth.getAccounts(function (error, accounts) {
        if (error) {
          console.log(error)
          reject(error)
        } else {
          self.address = accounts
          resolve()
        }
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
    _validationDate,
    _option1,
    _option2) {
    return GuessInputs.init(this.address).then(() => {
      console.log('Title: ', _title)
      return GuessInputs.setGuessFront(
        _title,
        _description,
        _topic,
        _finalDate,
        _validationDate,
        _option1,
        _option2
      )
    })
  },

  getGuessFront: function (index) {
    return GuessGame.init().then(() => {
      return GuessGame.getGuessFront(index).catch((err) => {
        return err
      })
    })
  },

  getGuessOptions: function (index) {
    return GuessGame.init().then(() => {
      return GuessGame.getGuessOptions(index).catch((err) => {
        return err
      })
    })
  },

  getGuessOptionsProfits: function (index) {
    return GuessGame.init().then(() => {
      return GuessGame.getGuessOptionsProfits(index).catch((err) => {
        return err
      })
    })
  },

  getGuessOfTheDay: function (topic) {
    return GuessGame.init().then(() => {
      return GuessGame.getGuessOfTheDay(topic).catch((err) => {
        return err
      })
    })
  },

  getGuessOfTheWeek: function (topic) {
    return GuessGame.init().then(() => {
      return GuessGame.getGuessOfTheWeek(topic).catch((err) => {
        return err
      })
    })
  },

  getGuessesByDate: function (index, topic, date) {
    return GuessGame.init().then(() => {
      return GuessGame.getGuessesByDate(index, topic, date).catch((err) => {
        return err
      })
    })
  },

  getGuessesByWeek: function (index, topic, date) {
    return GuessGame.init().then(() => {
      return GuessGame.getGuessesByWeek(index, topic, date).catch((err) => {
        return err
      })
    })
  },

  getGuessesNumber: function () {
    return GuessCore.init().then(() => {
      return GuessGame.getGuessesNumber().catch((err) => {
        return err
      })
    })
  },

  voteGuess: function (_guessIndex, _option, ethAmount) { // Option has to be between 1 and 2
    return GuessInputs.init(this.address).then(() => {
      return GuessInputs.voteGuess(
        _guessIndex,
        _option,
        ethAmount
      )
    })
  },

  validateGuess: function (_guessIndex, _option) {
    return GuessInputs.init(this.address).then(() => {
      return GuessInputs.validateGuess(
        _guessIndex,
        _option
      )
    })
  },

  getGuessesToValidate: function (index, date) {
    return GuessGame.init().then(() => {
      return GuessGame.getGuessesToValidate(index, date).catch((err) => {
        return err
      })
    })
  },

  getCurrentGuessesByAddress: function (index) {
    return MyGuesses.init().then(() => {
      return MyGuesses.getCurrentGuessesByAddress(index).catch((err) => {
        return err
      })
    })
  },

  getValidatingGuessesByAddress: function (index) {
    return MyGuesses.init().then(() => {
      return MyGuesses.getValidatingGuessesByAddress(index).catch((err) => {
        return err
      })
    })
  },

  getPastGuessesByAddress: function (index) {
    return MyGuesses.init().then(() => {
      return MyGuesses.getPastGuessesByAddress(index).catch((err) => {
        return err
      })
    })
  },

  getCreatedGuessesByAddress: function (index) {
    return MyGuesses.init().then(() => {
      return MyGuesses.getCreatedGuessesByAddress(index).catch((err) => {
        return err
      })
    })
  },

  getEventItemState: function (index) {
    return GuessCore.init().then(() => {
      return GuessCore.getEventItemState(index).catch((err) => {
        return err
      })
    })
  },

  signMessage (msgParams) {
    let from = this.address[0]

    return new Promise((resolve, reject) => {
      window.web3.currentProvider.sendAsync({
        method: 'eth_signTypedData',
        params: [msgParams, from],
        from: from
      }, function (err, result) {
        if (err) reject(console.error(err))
        if (result.error) {
          reject(console.error(result.error.message))
        }
        resolve(result.result)
      })
    })
  }
}

export default GuessHelper
