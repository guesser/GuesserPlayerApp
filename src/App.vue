<template>
    <div id="app">
        <div id="inside">
            <router-view></router-view>
        </div>

            <footer>
                <md-bottom-bar md-type="shift">
                    <md-bottom-bar-item md-icon="home" md-active v-on:click="changeView('')">
                    </md-bottom-bar-item>
                    <md-bottom-bar-item md-icon="comment" v-on:click="changeView('event')">
                    </md-bottom-bar-item>
                    <md-bottom-bar-item md-icon="account_balance" v-on:click="changeView('bank')">
                    </md-bottom-bar-item>
                    <md-bottom-bar-item md-icon="face" v-on:click="changeView('profile')">
                    </md-bottom-bar-item>
                </md-bottom-bar>
            </footer>
    </div>
</template>

<script>
// Contract helpers
// import User from '@/js/User'

// Vue components
import CreateAccount from './components/CreateAccount.vue'

export default {
  name: 'app',
  components: {
    CreateAccount
  },
  data: function () {
    return {
      page: 'Top'
    }
  },
  methods: {
    changeView (view) {
      this.$router.push('/' + view)
    }
  }
}
</script>

<style lang="sass">
@import "~vue-material/dist/theme/engine"; // Import the theme engine

@include md-register-theme("default", (primary: #ff0d73, // The primary color of your brand
  accent: #ffff01)); // The secondary color of your brand

@import "~vue-material/dist/theme/all"; // Apply the theme
  
</style>
<style>
body{
    height: 100%;
    overflow-y: auto;
}
#app {
    font-family: 'Josefin Sans', sans-serif;

    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
}
#inside{
    position:absolute;
    height: 100%;
    width: 100%;
    background-color: #fefefe;
}
footer{
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    z-index: 10;
}
</style>
