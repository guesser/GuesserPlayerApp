<template>
  <div>
    <!--Image and text -->
    <b-navbar type="light" variant="transparent" v-bind:class="{ fixed: fixedActive }" style="z-index: 2;" toggleable="md">
      <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
      <b-navbar-brand href="#/">
        <img src="../assets/beard.png" height="40" width="40" class="d-inline-block align-top" alt="BV">
        Guesser
      </b-navbar-brand>
      <b-collapse is-nav id="nav_collapse" class="header-items">
        <!--Ethereum speed tooltip-->
        <b-navbar-nav>
          <b-nav-item class="eth-network">
            <b-btn v-b-tooltip.hover id="eth-network"  variant="outline-success">Network Speed</b-btn>
          </b-nav-item>
          <SearchInput/>
        </b-navbar-nav>
        <b-navbar-nav class="ml-auto" style="margin-top: 5px">
          <b-nav-item href="#play">Play</b-nav-item>
          <b-nav-item v-if='userExists' href="#create">Create</b-nav-item>
          <b-nav-item v-else class="signup-header" href="#signup">SignUp</b-nav-item>
          <b-nav-item href="#validation">Validation</b-nav-item>
          <b-nav-item href="#myguesses" v-if='userAddress'>My Guesses</b-nav-item>
        </b-navbar-nav>

      </b-collapse>

    </b-navbar>
    <!--Tooltips-->
    <b-tooltip target="eth-network" placement="bottom">
      {{networkStatus}}
    </b-tooltip>

  </div>
</template>

<script>
import GuessHelper from '@/js/Guess.js'
import ServerHelper from '@/js/ServerHelper.js'
import SearchInput from './Common/SearchInput.vue'

export default {
  name: 'TopBar',
  components: {
    SearchInput
  },
  data: function () {
    return {
      userExists: true,
      fixedActive: false,
      networkStatus: 'Network is faster than ⚡',
      userAddress: true
    }
  },
  methods: {
    checkIfUserExists () {
      ServerHelper.getUser(GuessHelper.address[0]).then((data) => {
        this.userExists = true
      }).catch((err) => {
        this.userExists = false
        return err
      })
    }
  },
  beforeCreate: function () {
    let self = this

    GuessHelper.init().then(() => {
      // Uncomment the next if login enabled
      // self.checkIfUserExists()
      GuessHelper.getAddressRefreshed().then((add) => {
        if (add === null ||
            add.length === 0) {
          self.userAddress = false
        }
      })
    })
  }
}
</script>

<style lang="scss">
.navbar-brand{
  font-size: 28px;
}
.bg-transparent{
  background-color: rgba(white, 0.5) !important;
}
.fixed {
  position: fixed !important;
  width: 100%;
}
.signup-header a {
  color: #ff0d73 !important;
}
.eth-network {
}
.header-items {
}
</style>
