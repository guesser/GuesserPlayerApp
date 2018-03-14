<template>
  <div class="container">
    <div v-for='guess in guesses'>
      <b-card
       :border-variant="guess.topic"
       :header="guess.title"
       :header-bg-variant="guess.topic"
       header-text-variant="white"
       class="text-center">
        <p class="card-text">
        {{guess.description}}
        <br>
        {{guess.startingDay}} - {{guess.finishingDay}}
        </p>
        <p class="card-text">
        Option 1 validations: {{guess.option1Validations}} <br>
        Option 2 validations: {{guess.option2Validations}}
        </p>
        <br>
        <b-button @click="validateGuess(guess.id, 1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
        <b-button @click="validateGuess(guess.id, 2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
      </b-card>
    </div>
    <div>
      <h4 class="absolute-center" v-if='totalGuesses == 0'>What a shame... There are no Guesses to validate!</h4>
    </div>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'guessesvalidation',
  data () {
    return {
      guesses: [],
      totalGuesses: 0,
      guessIndex: null
    }
  },
  methods: {
    printGuesses () {
      for (var i = 0; i < 10; i++) {
        let _index = this.guessesByNumber[i].c[0]
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            let month1 = parseInt(guess[5].getMonth()) + 1
            let month2 = parseInt(guess[6].getMonth()) + 1
            this.guesses.push({
              'id': _index,
              'title': guess[0],
              'description': guess[1],
              'topic': guess[2],
              'votes': guess[4],
              'startingDay': guess[5].getUTCDate() + '-' + month1 + '-' + guess[6].getFullYear(),
              'finishingDay': guess[6].getUTCDate() + '-' + month2 + '-' + guess[5].getFullYear(),
              'option1': 'Loading...',
              'option2': 'Loading...',
              'option1Validations': 0,
              'option2Validations': 0
            })
          }).then(() => {
            this.totalGuesses += 1
            this.printGuessesOptions(_index, this.totalGuesses - 1)
          }).catch(err => {
            console.log(err)
          })
        }
      }
    },

    printGuessesOptions (_index, _localIndex) {
      let self = this
      GuessHelper.getGuessOptions(_index).then((guess) => {
        console.log(guess)
        self.guesses[_localIndex].option1 = guess[0]
        self.guesses[_localIndex].option2 = guess[1]
        self.guesses[_localIndex].option1Validations = guess[4].c[0]
        self.guesses[_localIndex].option2Validations = guess[5].c[0]
      }).catch(err => {
        console.log(err)
      })
    },

    getGuessesToValidate () {
      let self = this

      this.guesses = [] // Clean the array of showed Guesses
      GuessHelper.getGuessesToValidate(0).then((_guesses) => {
        console.log(_guesses)
        self.guessesByNumber = _guesses
        self.printGuesses()
      }).catch(err => {
        console.log(err)
      })
    },
    validateGuess (_index, _option) { // Option has to be 1 or 2
      // let self = this
      console.log(_index)
      GuessHelper.validateGuess(_index, _option).then(() => {
        console.log('Transaction pending...')
        // TODO: Show alert of voting
        // self.guessCreatedAlert = true
      }).catch(err => {
        console.log(err)
      })
    }
  },

  created: function () {
    GuessHelper.init().then(() => {
      this.getGuessesToValidate()
    }).catch(err => {
      console.log(err)
    })
  },

  watch: {
    topic: function () {
      this.getGuesses()
    }
  }
}
</script>

<style>
.absolute-center {
  margin: auto;
  text-align: center;
  position: relative;
}
</style>
