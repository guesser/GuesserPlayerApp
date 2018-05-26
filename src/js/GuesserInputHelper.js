import contract from 'truffle-contract'
import GuesserInput from '@contracts/GuesserInputs.json'

const GuesserInputHelper = {
  contract: null,

  instance: null,

  address: null,

  GuessCreated: null,

  init: function (address) {
    this.address = address
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(GuesserInput)

      self.contract.setProvider(window.web3.currentProvider)
      self.contract.deployed().then(instance => {
        self.instance = instance

        // Events
        self.GuessCreated = self.instance.GuessCreated()
        self.TestValue = self.instance.test_value()
        resolve()
      }).catch((err) => {
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
    _validationDate,
    _option1,
    _option2) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.setGuess(
        _title,
        _description,
        window.web3.utils.asciiToHex(_topic),
        _finalDate,
        _validationDate,
        _option1,
        _option2,
        {from: self.address[0], gas: 600000} // TODO: Gas forced to high #WARNING
      ).then(() => {
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  }
}
export default GuesserInputHelper
