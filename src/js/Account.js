/* Account functions to do whatever is needed */
// TODO:
// Check if the users is saved:
// ---- Load it
// Else:
// ---- Show a loading bar
// ---- Create the account
// ---- Load it
// ---- Save it
// ---- Stop loading bar

const Account = {

  account: null,

  createAccount: function () {
    this.account = window.web3.eth.accounts.create()

    // Save account
    window.localStorage.setItem('address', this.account.address)

    // The private key is being stored in the localstorage by the moment,
    // it will be change in the next release
    window.localStorage.setItem('privateKey', this.account.privateKey)

    window.web3.eth.accounts.wallet.add(window.localStorage.getItem('privateKey'))
  },

  getAccountAddress: function () {
    return this.account.address
  },

  // Call always this function it will create or load the info
  loadAccountData: function () {
    if (window.localStorage.getItem('privateKey') !== null) {
      this.account = {
        privateKey: window.localStorage.getItem('privateKey'),
        address: window.localStorage.getItem('address')
      }
      window.web3.eth.accounts.wallet.add(window.localStorage.getItem('privateKey'))
    } else {
      this.createAccount()
    }
  },

  isAccountCreated: function () {
    if (window.localStorage.getItem('privateKey') !== null) {
      return true
    }
  },

  getBalance: function async () {
    return window.web3.eth.getBalance(this.getAccountAddress())
  },

  // Checks if an account is unlocked
  isUnlocked: function async (web3, address) {
    try {
      web3.eth.sign('', address)
    } catch (e) {
      console.log(false)
      return false
    }
    console.log(true)
    return true
  },

  sendEther: function (_value, _to) {
    var web3 = window.web3
    var _address = window.localStorage.getItem('address')
    var _privateKey = window.localStorage.getItem('privateKey')

    var tx = {
      from: _address,
      to: _to,
      gas: 2000000
    }

    web3.eth.accounts.signTransaction(tx, _privateKey).then(signed => {
      var tran = web3.eth.sendSignedTransaction(signed.rawTransaction)

      tran.on('confirmation', (confirmationNumber, receipt) => {
        console.log('confirmation: ' + confirmationNumber)
      })

      tran.on('transactionHash', hash => {
        console.log('hash')
        console.log(hash)
      })

      tran.on('receipt', receipt => {
        console.log('receipt')
        console.log(receipt)
      })

      tran.on('error', console.error)
    }).catch(function (e) {
      console.log(e)
    })
  },

  // WARNING: This deletes the whole account, and you wont be able to get it back
  deleteAccountData: function () {
    window.localStorage.setItem('address', null)
    window.localStorage.setItem('privateKey', null)
    this.account = null
  }
}

export default Account
