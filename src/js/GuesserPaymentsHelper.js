import contract from 'truffle-contract'
import GuesserPayments from '@contracts/GuesserPayments.json'

const GuesserPaymentsHelper = {
  contract: null,

  instance: null,

  address: null,

  GuessVoted: null,

  GuessValidated: null,

  ProfitsReturned: null,

  init: function (address) {
    this.address = address
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(GuesserPayments)

      self.contract.setProvider(window.web3.currentProvider)
      self.contract.deployed().then(instance => {
        self.instance = instance

        // Events
        self.GuessVoted = self.instance.GuessVoted()
        self.GuessValidated = self.instance.GuessValidated()
        self.ProfitsReturned = self.instance.ProfitsReturned()
        resolve()
      }).catch((err) => {
        reject(err)
      })
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

  voteGuess: function (_guessIndex, _option, ethAmount) { // Option has to be between 1 and 2
    let self = this

    ethAmount = 10 * (ethAmount / 10)
    return new Promise((resolve, reject) => {
      console.log(self.address[0])
      self.instance.voteGuess(
        _guessIndex,
        _option,
        {
          from: self.address[0],
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
  }
}
export default GuesserPaymentsHelper
