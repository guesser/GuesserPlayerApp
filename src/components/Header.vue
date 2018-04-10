<template>
  <div>
    <!--Image and text -->
    <b-navbar type="light" variant="transparent" v-bind:class="{ fixed: fixedActive }" style="z-index: 2;" toggleable="md">
      <b-navbar-toggle target="nav_collapse"></b-navbar-toggle>
      <b-navbar-brand href="#/">
        <img src="../assets/beard.png" height="40" width="40" class="d-inline-block align-top" alt="BV">
        Guesser
      </b-navbar-brand>
      <b-collapse is-nav id="nav_collapse">
        <!--Ethereum speed tooltip-->
        <b-navbar-nav>
          <b-nav-item>
            <b-btn v-b-tooltip.hover id="eth-network" variant="outline-success">Network Speed</b-btn>
          </b-nav-item>

          <!--Search button-->
          <b-nav-item>
            <form class="navbar-form" role="search">
              <div class="input-group">
                <input type="text" class="form-control" placeholder="Search by ID" name="srch-term" id="srch-term" v-model="form._id">
                <div class="input-group-btn">
                  <button class="btn btn-default" @click="changeToSearched" type="submit"><i class="material-icons" >search</i></button>
                </div>
              </div>
            </form>
          </b-nav-item>

        </b-navbar-nav>
        <b-navbar-nav class="ml-auto">
          <b-nav-item href="#home">Play</b-nav-item>
          <b-nav-item v-if='userExists' href="#create">Create</b-nav-item>
          <b-nav-item v-else class="signup-header" href="#signup">SignUp</b-nav-item>
          <b-nav-item href="#validation">Validation</b-nav-item>
          <b-nav-item href="#myguesses">My Guesses</b-nav-item>
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
import GuessHelper from '@/js/Guess'
import ServerHelper from '@/js/ServerHelper'

export default {
  name: 'TopBar',
  data: function () {
    return {
      userExists: false,
      fixedActive: false,
      networkStatus: 'Network is faster than ⚡',
      form: {
        _id: ''
      }
    }
  },
  methods: {
    changeToSearched () {
      this.$router.push({
        // path: `/search/${this.form._id}`
        path: 'search', query: { _id: `${this.form._id}` }
      })
      console.log('Identifier: ', this.form._id)
    },
    checkIfUserExists () {
      ServerHelper.getUsername(GuessHelper.address[0]).then((data) => {
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
      self.checkIfUserExists()
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
</style>
