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
    // TODO: Save account
  },

  printAccountData: function () {
    console.log(this.account)
  }
}

export default Account
