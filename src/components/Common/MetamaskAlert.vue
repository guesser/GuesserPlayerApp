<template>
<b-row align-h="center" align-v="center" class="metamask-alert">
  <b-alert show variant="primary" dismissible>
    <h4 class="alert-heading">You need to install Metamask extension</h4>
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
export default {
  name: 'MetamaskAlert'
}
</script>

<style>
  .metamask-alert {
    position: fixed; 
    bottom: 0;
    left: 10%;
    right: 10%;
  }
</style>
