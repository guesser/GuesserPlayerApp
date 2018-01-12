<template>
  <div>
    <div class='topics'>
      <TopicList/>
    </div>
    <div class='guesses'>
      <h2>Guess of the day!</h2>
      <GuessOfTheDay/>
      <br>
      <h2>Other cool guesses:</h2>
      <OtherGuesses/>
    </div>
  </div>
</template>

<script>
import TopicList from './Home/TopicList.vue'
import GuessOfTheDay from './Home/GuessOfTheDay.vue'
import OtherGuesses from './Home/OtherGuesses.vue'

export default {
  name: 'home',
  components: {
    TopicList,
    GuessOfTheDay,
    OtherGuesses
  }
}
</script>

<style>
.topics{
  width: 20%;
  display: inline-block;
  float: left;
  padding-right: 10px;
  padding-left: 15px;
}
.guesses{
  width: 78%;
  display: inline-block;
  float: left;
}
.pink{
  background-color: pink;
}

.container{
  margin:0;
  padding:0;
}
</style>
