import axios from 'axios'

const ServerHelper = {
  url: 'https://li8ko64r87.execute-api.us-east-1.amazonaws.com/dev/',

  setUser: function (msgData, signedData) {
    return new Promise((resolve, reject) => {
      axios.post(this.url + 'user', JSON.stringify({
        signedData: signedData,
        msgData: msgData
      })).then((response) => {
        resolve(response.data)
      }).catch(err => {
        reject(err)
      })
    })
  },

  getUser: function (address) {
    return new Promise((resolve, reject) => {
      axios.get(this.url + 'user?address=' + address.toLowerCase()).then((response) => {
        resolve(response.data)
      }).catch(err => {
        reject(err)
      })
    })
  }
}
export default ServerHelper
