import contract from 'truffle-contract'
import EventContract from '@contracts/Event.json'

const Event = {

  contract: null,

  instance: null,

  init: function () {
    let self = this

    return new Promise(function (resolve, reject) {
      self.contract = contract(EventContract)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },
  setEventFront: function (_title, _description, _topic, _option1, _option2, _option3, _option4) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.setEvent(
        window.web3.fromAscii(_title),
        window.web3.fromAscii(_description),
        window.web3.fromAscii(_topic),
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

  // Event is splited in two functions
  // because of solidity reasons
  getEventFront: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getEvent.call(
        index,
        {from: window.web3.eth.accounts[0]}
      ).then(_event => {
        resolve([
          window.web3.toAscii(_event[0]).replace(/\u0000/g, ''), // title
          window.web3.toAscii(_event[1]).replace(/\u0000/g, ''), // description
          window.web3.toAscii(_event[2]).replace(/\u0000/g, ''), // topic
          window.web3.toAscii(_event[3]).replace(/\u0000/g, '') // date
        ])
      }).catch(err => {
        reject(err)
      })
    })
  },

  getEventOptionsFront: function (index) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getEventOptions.call(
        index,
        {from: window.web3.eth.accounts[0]}
      ).then(_event => {
        resolve([
          window.web3.toAscii(_event[0]).replace(/\u0000/g, ''), // Option 1
          window.web3.toAscii(_event[1]).replace(/\u0000/g, ''), // Option 2
          window.web3.toAscii(_event[2]).replace(/\u0000/g, ''), // Option 3
          window.web3.toAscii(_event[3]).replace(/\u0000/g, '') // Option 4
        ])
      }).catch(err => {
        reject(err)
      })
    })
  },
  getEventsNumber: function () {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.getEventsLength.call(
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

export default Event
