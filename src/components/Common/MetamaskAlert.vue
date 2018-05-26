<template>
<b-row align-h="center" align-v="center" class="metamask-alert">
  <b-alert show variant="primary" dismissible>
    <h4 class="alert-heading">You need to
      <span v-if="locked"> unlock </span>
      <span v-else-if="notRinkeby"> select Rinkeby net in </span>
      <span v-else> install </span>
      Metamask extension</h4>
    <p>
      You’ll need a safe place to store all of your wins! The perfect place is in a secure wallet like MetaMask. This will also act as your login to the game (no extra password needed).
    </p>
    <hr>
    <b-button href="https://metamask.io" size="lg" variant="primary">
      INSTALL METAMASK
    </b-button>
  </b-alert>
</b-row>

</template>

<script>
import NetworkHelper from '@/js/NetworkHelper'

export default {
  name: 'MetamaskAlert',
  data () {
    return {
      locked: false,
      notRinkeby: false
    }
  },
  created: function () {
    let self = this
    NetworkHelper.init().then(() => {
      if (NetworkHelper.state === 'locked') {
        self.locked = true
      } else {
        // Checking if the user is connected to the right network
        window.web3.eth.net.getId().then(netId => {
          switch (netId) {
            case 4:
              break
            default:
              self.notRinkeby = true
          }
        })
      }
    })
  }
}
</script>

<style>
  .metamask-alert {
    z-index: 10;
    position: fixed; 
    bottom: 0;
    left: 10%;
    right: 10%;
  }
</style>
