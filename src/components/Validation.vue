<template>
  <div class="wrapper">
    <div v-if='!contentLoaded'>
      <Loading/>
    </div>

    <CardDeck :events="guesses"
       :mode='2'
       :maxCol='1'
       :descriptionAllow='true'
       :shareable='false'
       :headerBg='true'/>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import NetworkHelper from '@/js/NetworkHelper'

import CardDeck from './Common/CardDeck.vue'
import Loading from './Loading.vue'

export default {
  name: 'guessesvalidation',
  components: {
    Loading,
    CardDeck
  },
  data () {
    return {
      guessesByNumber: [],
      totalGuesses: 0,
      guessIndex: null,
      guesses: [],
      contentLoaded: false
    }
  },
  methods: {
    printGuesses () {
      for (var i = 0; i < this.guessesByNumber.length; i++) {
        console.log(this.guessesByNumber[i].c[0])
        let _index = this.guessesByNumber[i].c[0]
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            let guessTime = this.$moment(guess[5]).subtract(this.$moment(guess[5]).minute(), 'minutes')
            if (guessTime.unix() < this.$moment().unix() &&
                guess[3] !== GuessHelper.address[0]) {
              this.guesses.push({
                'id': _index,
                'title': guess[0],
                'description': guess[1],
                'topic': guess[2],
                'votes': 0,
                'startingDay': this.$moment(guess[4]).format('MMMM D, YYYY [at] H[h]'),
                'finishingDay': this.$moment(guess[5]).format('MMMM D, YYYY [at] H[h]'),
                'eventState': '',
                'option1': 'Loading...',
                'option2': 'Loading...',
                'option1Validations': 0,
                'option2Validations': 0
              })
            }
          }).then(() => {
            this.totalGuesses += 1
            this.printGuessesOptions(_index, this.totalGuesses - 1)
            this.printEventState(_index, this.totalGuesses - 1)
          }).catch(err => {
            console.log(err)
          })
        }
      }
    },

    printEventState (_index, _localIndex) {
      let self = this

      GuessHelper.getEventItemState(_index).then((eventItemState) => {
        self.guesses[_localIndex].eventState = eventItemState
      }).catch(err => {
        console.log(err)
      })
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
      var finished = 0
      for (var i = 0; i < 7; i++) {
        GuessHelper.getGuessesToValidate(0, this.$moment().subtract(i, 'days').unix()).then((_guesses) => {
          self.guessesByNumber = self.guessesByNumber.concat(_guesses)
          console.log(_guesses)
          finished++
          if (finished === 7) {
            self.printGuesses()
            self.contentLoaded = true
          }
        }).catch(err => {
          finished++
          if (finished === 7) {
            self.printGuesses()
            self.contentLoaded = true
          }
          return err
        })
      }
    }
    /*
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
    */
  },
  created: function () {
    let self = this
    GuessHelper.init().then(() => {
      this.getGuessesToValidate()
    }).catch(err => {
      console.log(err)
    })

    NetworkHelper.init().then(() => {
      if (NetworkHelper.state === 'disconnected' ||
          NetworkHelper.state === 'locked') {
        self.$router.push('signup')
      }
    })
  },
  beforeCreated: function () {
    this.contentLoaded = false
  }
}
</script>

<style>
.absolute-center {
  margin: auto;
  text-align: center;
  position: relative;
}
.wrapper {
  margin: 0 15% 0 15%;
  padding: 0;
}
</style>
