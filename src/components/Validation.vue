<template>
  <div class="container">
    <b-card-group deck class="mb-3">
      <b-card :border-variant="guess.topic"
                       :header="guess.title"
                       :header-bg-variant="guess.topic"
                       header-text-variant="white"
                       class="text-center">
        <p class="card-text">
        {{guess.description}}
        <br>
        {{guess.startingDay}} - {{guess.finishingDay}}
        </p>
        <br>
        <b-button @click="validateGuess(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
        <b-button @click="validateGuess(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
      </b-card>

      <!--TODO: Make this more beautiful-->
      <h4 v-if='totalGuesses == 0'>What a shame... !There are no Guesses to validate!</h4>
    </b-card-group>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'GuessesValidations',
  data () {
    return {
      guesses: [],
      guessesByNumber: [], //Array of index
      this.guessIndex = Null,
      //WIP
      this.topic = 'Crypto'
    }
  },
  methods: {
    validateGuess(_guessid, _option) {
      let self = this

      self.guessIndex = guessesByNumber[_guessid]
      GuessHelper.validateGuess(self.guessIndex, _option).then(() => {
        console.log('Transaction pending...')
        // TODO: Show validation confirmation
      }).catch(err => {
        console.log(err)
      })
    },

    created: function () {
      GuessHelper.init().then(() => {
        //Functions
      }).catch(err => {
        console.log(err)
      })
    },

    watch: {
      topic: function () {
      }
    }
  }
</script>

<style>

</style>
