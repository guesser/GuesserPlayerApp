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

  sendEther: function (_value, _to) {
    var _address = window.localStorage.getItem('address')
    window.web3.eth.sendTransaction({from: _address, to: _to, value: window.web3.utils.toWei(_value, 'ether')
    }).on('transactionHash', function (hash) {
      console.log(hash)
    }).on('confirmation', function (confirmationNumber, receipt) {
      console.log(confirmationNumber)
      console.log(receipt)
    }).on('error', console.error)
  },

  // WARNING: This deletes the whole account, and you wont be able to get it back
  deleteAccountData: function () {
    window.localStorage.setItem('address', null)
    window.localStorage.setItem('privateKey', null)
    this.account = null
  }
}

export default Account
