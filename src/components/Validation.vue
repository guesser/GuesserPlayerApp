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
    getGuessOptions (_index) {
      let self = this

      GuessHelper.getGuessOptions(_index).then((_guess) => {
        self.guesses[_index].option1 = _guess[0]
        self.guesses[_index].option2 = _guess[1]
        console.log('GuessOptions taken')
      }).catch(err => {
        console.log(err)
      })
    },

    getGuessData (_index) {
      let self = this

      GuessHelper.getGuessFront(_index).then((guess) => {
        console.log(guess)
        let _startingDay = guess[5].getDate() + '-' + guess[5].getMonth() + 1 + '-' + guess[5].getFullYear()
        let _finishingDay = guess[6].getDate() + '-' + guess[6].getMonth() + 1 + '-' + guess[6].getFullYear()
        self.guesses[_index].title = guess[0]
        self.guesses[_index].description = guess[1]
        self.guesses[_index].topic = guess[2]
        self.guesses[_index].startingDay = _startingDay
        self.guesses[_index].finishingDay = _finishingDay
        console.log('GuessData taken')
      }).catch(err => {
        console.log(err)
      })
    },

    initGuesses () {
      let self = this

      return new Promise((resolve, reject) => {
        for (var i = 0; i < self.totalguesses; i++) {
          self.guesses.push({
            'title': 'Probando, probando',
            'description': '',
            'topic': 'Crypto',
            'startingDay': '',
            'finishingDay': '',
            'option1': '',
            'option2': '',
            'option1Validation': '',
            'option2Validation': ''
          })
          resolve()
        }
      })
    },

    printGuesses () {
      let self = this

      this.guesses = [] // Clean the array
      this.initGuesses().then(() => {
        for (var _index = 0; _index < self.totalguesses; _index++) {
          this.getGuessData(_index)
          this.getGuessOptions(_index)
        }
      }).catch(err => {
        console.log(err)
      })
    },

    getGuesses () {
      let self = this

      GuessHelper.getGuessesNumber().then((_guessesnumber) => {
        self.totalguesses = _guessesnumber.c[0]
        self.printGuesses()
      }).catch(err => {
        console.log(err)
      })
    },

    validateGuess (_guessid, _option) {
      let self = this

      GuessHelper.validateGuess(self.guessIndex, _option).then(() => {
        console.log('Transaction pendding...')
        // TODO: Show validation confirmation
      }).catch(err => {
        console.log(err)
      })
    }
  },

  created: function () {
    GuessHelper.init().then(() => {
      this.totalguesses = 0
      this.getGuesses()
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
