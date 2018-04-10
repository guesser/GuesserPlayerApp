import axios from 'axios'

const ServerHelper = {
  url: 'https://li8ko64r87.execute-api.us-east-1.amazonaws.com/dev/',

  setUsername: function (msgData, signedData) {
    return new Promise((resolve, reject) => {
      axios.post(this.url + 'username', JSON.stringify({
        signedData: signedData,
        msgData: msgData
      })).then((response) => {
        console.log(response.data)
        resolve(response.data)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getUsername: function (address) {
    return new Promise((resolve, reject) => {
      console.log(address.toLowerCase())
      console.log('username?address=' + address.toLowerCase().toString())
      axios.get(this.url + 'username?address=' + address.toLowerCase()).then((response) => {
        console.log(response.data)
        resolve(response.data)
      }).catch(err => {
        reject(err)
      })
    })
  }
}
export default ServerHelper
