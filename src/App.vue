<template>
  <div id="app">
    <header>
    </header>
    
    <main>
      <router-view></router-view>
    </main>

    <footer>
    </footer>
  </div>
</template>

<script>
  // Vue components
  // import CreateAccount from './components/CreateAccount.vue'

  export default {
    name: 'app',
    components: {
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
</style>
