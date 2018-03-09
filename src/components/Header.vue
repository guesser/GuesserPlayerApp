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
          <!--<b-nav-item>-->
            <!--<form class="navbar-form" role="search">-->
              <!--<div class="input-group">-->
                <!--<input type="text" class="form-control" placeholder="Search" name="srch-term" id="srch-term">-->
                <!--<div class="input-group-btn">-->
                  <!--<button class="btn btn-default" type="submit"><i class="material-icons">search</i></button>-->
                <!--</div>-->
              <!--</div>-->
            <!--</form>-->
          <!--</b-nav-item>-->

        </b-navbar-nav>
        <b-navbar-nav class="ml-auto">
          <b-nav-item href="#home">Guesses</b-nav-item>
          <b-nav-item href="#create">Create</b-nav-item>
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
export default {
  name: 'TopBar',
  data: function () {
    return {
      fixedActive: false,
      networkStatus: 'Network is faster than ⚡'
    }
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
</style>

