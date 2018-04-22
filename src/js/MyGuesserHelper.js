import contract from 'truffle-contract'
import MyGuesses from '@contracts/MyGuesses.json'

const MyGuessesHelper = {
  contract: null,

  instance: null,

  address: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(MyGuesses)
      self.contract.deployed().then(instance => {
        self.instance = instance
      }).catch((err) => {
        reject(err)
      })
    })
  },
}
export default MyGuessesHelper
