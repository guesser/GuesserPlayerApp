const ServerHelper = {
  url: 'https://li8ko64r87.execute-api.us-east-1.amazonaws.com/dev/',

  setUser: function (param) {
    this.axios.get(this.url + 'setUser?param="' + param + '"').then((response) => {
      console.log(response.data)
    })
  }
}
export default ServerHelper
