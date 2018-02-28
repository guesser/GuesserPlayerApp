<template>
  <div>
    <full-page :options="options">
      <div class="section">
        First section ...
      </div>
      <div class="section">
        Second section ...
      </div>
    </full-page>
</div>

 </div>
</template>

<script>
import FullPage from 'vue-fullpage.js'

export default {
  name: 'Landing',
  components: {
    FullPage
  },
  data () {
    return {
      options: {
        paddingTop: '30px'
      }
    }
  }
}
</script>

<style lang="scss">
.absolute-position {
  position: absolute;
  margin: auto;
  top: 50%;
  width: 100%;
  /*height: 100%;
   */
}
</style>
