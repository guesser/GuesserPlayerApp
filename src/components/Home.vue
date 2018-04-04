<template>
  <div>
    <div class='topics'>
      <TopicList/>
    </div>
    <div class='guesses'>
      <h2 style="font-size:calc(1em + 2vw);">The <b>{{topic}}</b> event of the day!</h2>
      <GuessOfTheDay :topic="topic"/>
      <br>
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
      topic: ''
    }
  },
  watch: {
    '$route': function () {
      this.topic = this.$route.params.topic
    }
  },
  created: function () {
    if (this.$route.params.topic) {
      this.topic = this.$route.params.topic
    } else {
      this.topic = 'Crypto'
    }
  }
}
</script>

<style>
.topics{
    width: 20%;
    float: left;
    padding-right: 10px;
    padding-left: 1.5%;
    position: -webkit-sticky;
    position: sticky;
    top: 5px;
}
.guesses{
    width: 60%;
    min-width: 220px;
    margin-left: 25%;
    position: relative;
}

@media screen and (max-width: 600px) {
    .topics {
    }
    .guesses {
        margin-left:20%;
        width: 77%; 
    }
}

.pink{
  background-color: pink;
}
.container{
  margin:0;
  padding:0;
}
</style>
