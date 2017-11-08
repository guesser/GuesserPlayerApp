<template>
    <div class="cards">
        <GuessCard/>
        <GuessCard/>
        <GuessCard/>
        <GuessCard/>
        <GuessCard/>
        <GuessCard/>
        <GuessCard/>
    </div>
</template>

<script>
import GuessCard from './GuessCard.vue'

export default {
  name: 'my-guesses',
  components: {
    GuessCard
  }
}
</script>

<style>
.cards{
 padding-left: 10px;
 padding-right: 10px;
}

</style>
