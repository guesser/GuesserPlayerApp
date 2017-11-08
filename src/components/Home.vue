<template>
    <div class="container">
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
</template>

<script>
import SearchHeaderBar from './SearchHeaderBar.vue'
import GuessCard from './GuessCard.vue'

export default {
  name: 'home',
  components: {
    SearchHeaderBar,
    GuessCard
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
 padding-left: 10px;
 padding-right: 10px;
}
</style>
