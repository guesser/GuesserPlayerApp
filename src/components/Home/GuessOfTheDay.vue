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
    <b-progress class="mt-1" :max="10*(guess.votes/10)" show-value striped>
      <b-progress-bar :value="10*(guess.option1votes/10)" variant="pink">
        {{guess.option1}} - {{ guess.option1votes }}
      </b-progress-bar>
      <b-progress-bar :value="10*(guess.option2votes/10)" variant="magenta">
        {{guess.option2}} - {{ guess.option2votes }}
      </b-progress-bar>
    </b-progress>

    <br>
    <b-button @click="voteGuess(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
    <b-button @click="voteGuess(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
  </b-card>
    </div>
  <div v-else style="text-center">
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
        title: 'Loading...',
        description: 'Loading...',
        topic: 'Crypto',
        creator: '0x00000000000000000000000000000000',
        votes: 0,
        startingDay: '10-10-10',
        finishingDay: '10-10-10',
        option1: 'Loading...',
        option2: 'Loading...',
        option1votes: '0',
        option2votes: '0'
      },
      guessIndex: null
    }
  },
  methods: {
    getGuess () {
      let self = this

      GuessHelper.getGuessFront(this.guessIndex).then((guessDay) => {
        console.log(guessDay)

        let month1 = parseInt(guessDay[5].getMonth()) + 1
        let month2 = parseInt(guessDay[6].getMonth()) + 1
        self.guess.title = guessDay[0]
        self.guess.description = guessDay[1]
        self.guess.topic = guessDay[2]
        self.guess.votes = guessDay[4]
        let _startingDay = guessDay[5].getDate() + '-' + month1 + '-' + guessDay[5].getFullYear()
        self.guess.startingDay = _startingDay
        self.guess.finishingDay = guessDay[6].getDate() + '-' + month2 + '-' + guessDay[6].getFullYear()
      }).catch(err => {
        console.log(err)
      })
    },
    getGuessOfTheDay () {
      let self = this
      GuessHelper.getGuessOfTheDay(this.topic).then((guessNumber) => {
        self.guessIndex = guessNumber.c[0]
        self.getGuess()
        self.getOptions()
      }).catch(err => {
        console.error(err)
      })
    },
    voteGuess (_option) { // Option has to be 1 or 2
      // let self = this
      GuessHelper.voteGuess(this.guessIndex, _option).then(() => {
        console.log('Transaction pending...')
        // TODO: Show alert of voting
        // self.guessCreatedAlert = true
      }).catch(err => {
        console.log(err)
      })
    },
    getOptions () {
      let self = this

      GuessHelper.getGuessOptions(this.guessIndex).then((guessOptions) => {
        self.guess.option1 = guessOptions[0]
        self.guess.option2 = guessOptions[1]
        self.guess.option1votes = guessOptions[2].c[0]
        self.guess.option2votes = guessOptions[3].c[0]
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
