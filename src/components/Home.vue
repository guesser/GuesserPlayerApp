<template>
  <div>
    <div class='topics'>
      <TopicList @topic-updated="updateTopic"/>
    </div>
    <div class='guesses'>
      <h2>The {{topic}} guess of the day!</h2>
      <GuessOfTheDay :topic="topic"/>
      <br>
      <h2>Other cool guesses:</h2>
      <OtherGuesses :topic="topic"/>
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
  },
  data () {
    return {
      topic: 'Crypto'
    }
  },
  methods: {
    updateTopic (_topic) {
      this.topic = _topic
    }
  }
}
</script>

<style>
.topics{
  width: 20%;
  display: inline-block;
  float: left;
  padding-right: 10px;
  padding-left: 1.5%;
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
