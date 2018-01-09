<template>
  <div>
    <TopBar/>
    <main>
    <router-view></router-view>
    </main>

    <footer>
    </footer>

  </div>
</template>

<script>
// Vue components
  import TopBar from './components/Home/Header.vue'

  export default {
    name: 'app',
    components: {
      TopBar
    },
    data: function () {
      return {
      }
    },
    methods: {
      changeView (view) {
        this.$router.push('/' + view)
      }
    }
  }
</script>

<style lang="scss">
body{
  font-family: 'Josefin Sans', sans-serif;
}
</style>
