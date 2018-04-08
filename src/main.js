// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import Web3 from 'web3'
import router from './router'
// CSS
import BootstrapVue from 'bootstrap-vue'

// Libraries
import Qrcode from 'v-qrcode/src/index'
import VueClipboard from 'vue-clipboard2'
import moment from 'moment'
import Notifications from 'vue-notification'
import bFormSlider from 'vue-bootstrap-slider'
import 'bootstrap-slider/dist/css/bootstrap-slider.css'

// Server Libraries
import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.prototype.$moment = moment

Vue.use(BootstrapVue)
Vue.use(Qrcode)
Vue.use(VueClipboard)
Vue.use(Notifications)
Vue.use(bFormSlider)
Vue.use(VueAxios, axios)

Vue.config.productionTip = false

window.addEventListener('load', function () {
  if (typeof web3 !== 'undefined') {
    console.log('Web3 injected browser: OK.')
    window.web3 = new Web3(window.web3.currentProvider)
  } else {
    console.log('Web3 injected browser: Fail. You should consider trying MetaMask.')
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    window.web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'))
  }

  /* eslint-disable no-new */
  new Vue({
    el: '#app',
    router,
    template: '<App/>',
    components: { App }
  })
})

