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
        <br>
        <b-button @click="validateGuess(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
        <b-button @click="validateGuess(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
      </b-card>
    </div>
    <!--TODO: Make this more beautiful-->
    <h4 v-if='totalguesses == 0'>What a shame... !There are no Guesses to validate!</h4>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'guessesvalidation',
  data () {
    return {
      guesses: [],
      totalguesses: 0,
      guessIndex: null
    }
  },
  methods: {
    printGuesses () {
      for (var i = 0; i < 10; i++) {
        let _index = this.guessesByNumber[i].c[0]
        console.log(i, _index)
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            console.log(guess)
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
              'option2': 'Loading...'
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
        self.guesses[_localIndex].option1 = guess[0]
        self.guesses[_localIndex].option2 = guess[1]
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
    voteGuess (_index, _option) { // Option has to be 1 or 2
      // let self = this
      GuessHelper.voteGuess(_index, _option).then(() => {
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

</style>
