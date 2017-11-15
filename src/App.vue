<template>
    <div id="app">
        <div id="inside">
            <router-view></router-view>
        </div>

        <footer>
            <md-bottom-bar md-shift>
                <md-bottom-bar-item md-icon="grade" md-active v-on:click="changeView('')">
                    Top
                </md-bottom-bar-item>
                <md-bottom-bar-item md-icon="books" v-on:click="changeView('my-guesses')">
                    Gusessing
                </md-bottom-bar-item>
                <md-bottom-bar-item md-icon="create" v-on:click="changeView('create')">
                    Create
                </md-bottom-bar-item>
                <md-bottom-bar-item md-icon="face" v-on:click="changeView('profile')">
                    Profile
                </md-bottom-bar-item>
            </md-bottom-bar>
        </footer>
    </div>
</template>

<script>
export default {
  name: 'app',
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

<style>
body{
    background-color: #ffff01;
    height: 100%;
    overflow-y: auto;
}
#app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
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
