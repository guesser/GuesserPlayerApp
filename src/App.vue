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
  import TopBar from './components/Header.vue'

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
  height: 100%;
}
main{
  padding-top: 2%;
  height:100vh;
  min-height: 100vh;
  bottom:0;
}
.btn-outline-primary{
  color: #ff0d73;
  background-color: transparent;
  background-image: none;
  border-color: #ff0d73;
}

.btn-primary{
  color: #fff;
  background-color: #ff0d73;
  border-color: #ff0d73;
}
.btn-outline-primary:hover{
  color: #fff;
  background-color: #ff0d73;
  border-color: #ff0d73;
}
.navbar-brand {
 margin-right: 0;
}
</style>
