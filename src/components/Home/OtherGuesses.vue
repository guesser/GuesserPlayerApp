<template>
  <div>
    <b-card-group deck class="mb-3">
      <div style="margin-bottom: 1.5rem;" v-for='guess in guesses'>
        <b-card
                                    style="width: 20rem; height: 100%;"
                                    :border-variant="topic"
                                    :header="guess.title"
                                    :header-border-variant="topic"
                                    header-text-variant="black"
                                    align="center">
          <p class="card-text">
          From: <b>{{guess.startingDay}}</b>
          <br>
          To: <b>{{guess.finishingDay}}</b>
          </p>
          <b-button @click="voteGuess(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
          <b-button @click="voteGuess(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>

        </b-card>
      </div>
      <!--TODO: Make this more beautiful-->
      <h4 v-if='totalGuesses == 0'>There are no Guesses over here!</h4>
    </b-card-group>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'OtherGuesses',
  props: ['topic'],
  data () {
    return {
      guesses: [],
      guessesByNumber: [],
      totalGuesses: 0
    }
  },
  methods: {
    printGuesses () {
      for (var i = 0; i < 10; i++) {
        let _index = this.guessesByNumber[i].c[0]
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            console.log(guess)
            let month1 = parseInt(guess[5].getMonth()) + 1
            let month2 = parseInt(guess[6].getMonth()) + 1
            this.guesses.push({
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
            console.log(this.totalGuesses - 1)
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
        console.log(_localIndex)
        self.guesses[_localIndex].option1 = guess[0]
        self.guesses[_localIndex].option2 = guess[1]
      }).catch(err => {
        console.log(err)
      })
    },

    getGuessesOfTheDay () {
      let self = this

      this.guesses = [] // Clean the array of showed Guesses
      GuessHelper.getGuessesOfTheDay(0, this.topic).then((_guesses) => {
        console.log(_guesses)
        self.guessesByNumber = _guesses
        self.printGuesses()
      }).catch(err => {
        console.log(err)
      })
    }
  },

  created: function () {
    GuessHelper.init().then(() => {
      this.getGuessesOfTheDay()
    }).catch(err => {
      console.log(err)
    })
  },

  watch: {
    topic: function () {
      this.totalGuesses = 0
      this.getGuessesOfTheDay()
    }
  }
}
</script>

<style>

</style>
