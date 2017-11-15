<template>
    <div>
<vue-pull-refresh :on-refresh="onRefresh"></vue-pull-refresh>
    <!--Here ends the pull to refresh-->
    <div id='content' class="container">
        <SearchHeaderBar/>
        <div class='cards'>
            <GuessCard/>
            <GuessCard/>
            <GuessCard/>
            <GuessCard/>
            <GuessCard/>
            <GuessCard/>
            <GuessCard/>
        </div>
    </div>
    </div>
</template>

<script>
import SearchHeaderBar from './SearchHeaderBar.vue'
import GuessCard from './GuessCard.vue'
import VuePullRefresh from 'vue-pull-refresh'

export default {
  name: 'home',
  components: {
    SearchHeaderBar,
    GuessCard,
    VuePullRefresh
  },
  methods: {
    onRefresh: function () {
      return new Promise(function (resolve, reject) {
        setTimeout(function () {
          resolve()
        }, 1000)
      })
    }
  }
}
</script>

<style>
.md-accent{
    margin-bottom: 10px;
}
.md-card-header-text{
    text-align:left;
}
.container{
    padding-bottom: 60px;
}
.cards{
    padding-left: 3%;
    padding-right: 3%;
}
</style>
