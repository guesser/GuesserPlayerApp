import contract from 'truffle-contract'
import GuessContract from '@contracts/Guess.json'

const Guess = {

  contract: null,

  instance: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(GuessContract)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance
        console.log(instance)
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  setGuessFront: function (newTitle, newDescription) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.setGuess(
        window.web3.fromAscii(newTitle),
        window.web3.fromAscii(newDescription),
        {from: window.web3.eth.accounts[0]}
      ).then(title => {
        resolve(window.web3.toAscii(title))
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
      ).then(title => {
        resolve([window.web3.toAscii(title[0]), window.web3.toAscii(title[1])])
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

export default Guess
