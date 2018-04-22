import contract from 'truffle-contract'
import GuesserInput from '@contracts/GuesserInput.json'

const GuesserInputHelper = {
  contract: null,

  instance: null,

  address: null,

  init: function (address) {
    this.address = address
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(GuesserInput)
      self.contract.deployed().then(instance => {
        self.instance = instance
      }).catch((err) => {
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
  }
}
export default GuesserInputHelper
