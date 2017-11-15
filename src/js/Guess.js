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

  setTitleFront: function (newTitle) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.setTitle(
        newTitle,
        {from: window.web3.eth.accounts[0]}
      ).then(title => {
        console.log(title)
        resolve(title)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getTitleFront: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getTitles.call(
        index,
        {from: window.web3.eth.accounts[0]}
      ).then(title => {
        console.log(title)
        resolve(title)
      }).catch(err => {
        reject(err)
      })
    })
  },
  getGuessesNumber: function () {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getTitlesLength.call(
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
