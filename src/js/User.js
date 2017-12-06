import contract from 'truffle-contract'
import UserContract from '@contracts/User.json'

const User = {

  contract: null,

  instance: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(UserContract)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  setUserFront: function (nickname, imageUrl) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.setUser(
        window.web3.fromAscii(nickname),
        window.web3.fromAscii(imageUrl),
        {from: window.web3.eth.accounts[0]}
      ).then(
        resolve()
      ).catch(err => {
        reject(err)
      })
    })
  },

  getUserFront: function () {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getUser.call(
        {from: window.web3.eth.accounts[0]}
      ).then(user => {
        resolve([
          window.web3.toAscii(user[0]).replace(/\u0000/g, ''),
          window.web3.toAscii(user[1]).replace(/\u0000/g, '')
        ])
      }).catch(err => {
        reject(err)
      })
    })
  }
}

export default User
