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
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  setGuessFront: function (newTitle, newDescription, _option1, _option2, _option3, _option4) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.setGuess(
        window.web3.fromAscii(newTitle),
        window.web3.fromAscii(newDescription),
        window.web3.fromAscii(_option1),
        window.web3.fromAscii(_option2),
        window.web3.fromAscii(_option3),
        window.web3.fromAscii(_option4),
        {from: window.web3.eth.accounts[0], gas: 400000} // Gas forced to high
      ).then(id => {
        resolve(id)
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
          window.web3.toAscii(guess[0]), // title
          window.web3.toAscii(guess[1]), // description
          window.web3.toAscii(guess[2]), // Option 1
          window.web3.toAscii(guess[3]), // Option 2
          window.web3.toAscii(guess[4]), // Option 3
          window.web3.toAscii(guess[5]) // Option 4
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
        console.log(number)
        resolve(number)
      }).catch(err => {
        reject(err)
      })
    })
  }
}

export default Guess
