<template>
  <div>
  <div v-if='guessIndex != null'>
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
  </b-card>
    </div>
  <div v-else>
    HolaMundo
    </div>
    </div>
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
        title: 'TheBestGuess',
        description: 'TestTestTestTest1',
        topic: 'Crypto',
        creator: '0x00000000000000000000000000000000',
        votes: 0,
        startingDay: '10-10-10',
        finishingDay: '10-10-10',
        option1: 'Yes',
        option2: 'No'
      },
      guessIndex: null
    }
  },
  methods: {
    getGuess () {
      let self = this

      GuessHelper.getGuessFront(this.guessIndex).then((guessDay) => {
        console.log(guessDay)
        self.guess.title = guessDay[0]
        self.guess.description = guessDay[1]
        self.guess.topic = guessDay[2]
        self.guess.votes = guessDay[4]
        let _startingDay = guessDay[5].getDate() + '-' + guessDay[5].getMonth() + 1 + '-' + guessDay[5].getFullYear()
        self.guess.startingDay = _startingDay
        self.guess.finishingDay = guessDay[6].getDate() + '-' + guessDay[6].getMonth() + 1 + '-' + guessDay[6].getFullYear()
      }).catch(err => {
        console.log(err)
      })
    },
    getGuessOfTheDay () {
      let self = this
      GuessHelper.getGuessOfTheDay(this.topic).then((guessNumber) => {
        console.log(guessNumber.c[0])
        self.guessIndex = guessNumber.c[0]
        self.getGuess()
      }).catch(err => {
        console.error(err)
      })
    }
  },
  created: function () {
    let self = this

    GuessHelper.init().then(() => {
      self.getGuessOfTheDay()
    }).catch(err => {
      console.log(err)
    })
  },
  watch: {
    topic: function () {
      this.getGuessOfTheDay()
      this.guessIndex = null
    }
  }
}
</script>

<style>
.card-link{
  text-decoration: underline;
}
</style>
