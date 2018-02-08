<template>
  <b-card :border-variant="topic"
          :header="guess.title"
          :header-bg-variant="topic"
          header-text-variant="white"
          class="text-center">
    <p class="card-text">
    {{guess.description}}
    <br>
    {{guess.startingDay}} - {{guess.finishingDay}}
    </p>
    <!--Progress Bar-->
    <b-progress class="mt-1" :max="max" show-value striped>
      <b-progress-bar :value="max*(3/10)" variant="pink">
        Yes - {{ max*(3/10) }}
      </b-progress-bar>
      <b-progress-bar :value="max*(7/10)" variant="magenta">
        No - {{ max*(7/10) }}
      </b-progress-bar>
    </b-progress>

    <br>
    <b-button variant="outline-pink" size="sm">Yes</b-button>
    <b-button variant="outline-magenta" size="sm">No</b-button>
    </div>
  </b-card>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'GuessOfTheDay',
  props: ['topic'],
  data () {
    return {
      max: 100,
      guess: {
        id: '0',
        title: 'Test1',
        description: 'TestTestTestTest1',
        topic: 'esports',
        creator: '0x00000000000000000000000000000000',
        votes: 0,
        startingDay: '10-10-10',
        finishingDay: '10-10-10',
        option1: 'Yes',
        option2: 'No'
      }
    }
  },
  methods: {
    getGuessOfTheDay () {
      let self = this
      GuessHelper.getGuessFront(0).then((guess) => {
        console.log(guess)
        self.guess.title = guess[0]
        self.guess.description = guess[1]
        self.guess.topic = guess[2]
        self.guess.votes = guess[4]
        let _startingDay = guess[5].getDate() + '-' + guess[5].getMonth() + 1 + '-' + guess[5].getFullYear()
        self.guess.startingDay = _startingDay
        let _finishingDay = guess[6].getDate() + '-' + guess[6].getMonth() + 1 + '-' + guess[6].getFullYear()
        self.guess.finishingDay = _finishingDay
      }).catch(err => {
        console.log(err)
      })
    },
    getGuessOptionsOfTheDay (_index) {
      let self = this
      GuessHelper.getGuessOptionsFront(0).then((guess) => {
        console.log(guess)
        self.guess.title = guess[0]
      })
    }
  },
  beforeCreate: function () {
    let self = this
    GuessHelper.init().then(() => {
      self.getGuessOfTheDay()
      self.getGuessOptionsOfTheDay()
    }).catch(err => {
      console.log(err)
    })
  }
}
</script>

<style>
.card-link{
  text-decoration: underline;
}
</style>
