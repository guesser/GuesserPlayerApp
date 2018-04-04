<template>
  <div>
    <div v-if='contentLoaded'>
      <Loading/>
    </div>

    <!--Alert-->
    <notifications group="voteAlert"
                   position="top center"
                   classes="vue-notification voteAlert"
                   :max="2"
                   width="300px"
                   :speed="500"/>

    <notifications group="copyAlert"
                   position="bottom right"
                   width="120"
                   :speed="500">
      <template slot="body" slot-scope="props">
        <div class="copyAlert">
          <div class="copyAlert-content">
            Url copied!
          </div>
        </div>
      </template>
    </notifications>


    <div v-if="totalGuesses != 0">
      <h2 style="font-size:calc(1em + 1vw);">Events you may like:</h2>
      <CardDeck :events="guesses"
                :peopleBar="false"
                :ethBar="false"
                :votationAllow="true"/>
    </div>
    </div>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import Loading from '../Loading.vue'
import CardDeck from '../Common/CardDeck.vue'

export default {
  name: 'otherguesses',
  components: {
    Loading,
    CardDeck
  },
  props: ['topic'],
  data () {
    return {
      contentLoaded: true,
      guesses: [],
      guessesByNumber: [],
      totalGuesses: 0
    }
  },
  methods: {
    /*
    showVoteAlert (group, type = '') {
      var title = ''
      arrayIndex: 0, // The selected guess to vote
      var text = ''
      if (type === 'success') {
        title = 'Votation success!'
        text = 'Your prediction is being processed'
      } else {
        title = 'Votation error!'
        text = 'Your prediction process failed, try again'
      }
      this.$notify({
        group,
        title,
        text,
        type
      })
    },
    show (group) {
      this.$notify({
        group
      })
    },
    showPaymentModal (_guessId, _optionVoted, _arrayIndex) {
      this.arrayIndex = _arrayIndex
      this.optionVoted = _optionVoted
      this.guessToVote = _guessId
      this.$refs.paymentModal.show()
    },
    */
    printGuesses () {
      this.guesses = []
      for (var i = 0; i < this.guessesByNumber.length; i++) {
        let _index = this.guessesByNumber[i].c[0]
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            if (this.$moment(guess[5]).subtract(this.$moment(guess[5]).minute(), 'minutes').unix() > this.$moment().unix()) {
              let _url = 'www.guesser.io/#/search?_id=' + _index
              this.guesses.push({
                'id': _index,
                'url': _url,
                'title': guess[0],
                'description': guess[1],
                'topic': guess[2],
                'votes': 0,
                'startingDay': this.$moment(guess[4]).format('MMMM D, YYYY [at] H[h]'),
                'finishingDay': this.$moment(guess[5]).format('MMMM D, YYYY [at] H[h]'),
                'finishingDayUnformated': this.$moment(guess[5]),
                'option1': 'Loading...',
                'option2': 'Loading...',
                'option1votes': 'Loading...',
                'option2votes': 'Loading...',
                'option1amounteth': 'loading...',
                'option2amounteth': 'loading...',
                'amountEth': 'Loading...'
              })
              this.printGuessesOptions(_index, this.totalGuesses)
              this.printOptionsProfits(_index, this.totalGuesses)
              this.totalGuesses += 1
              this.contentLoaded = false
            }
          }).catch(err => {
            console.log(err)
            this.contentLoaded = false
          })
        } else {
          this.contentLoaded = false
        }
      }
    },

    printGuessesOptions (_index, _localIndex) {
      let self = this
      GuessHelper.getGuessOptions(_index).then((guess) => {
        if (self.$moment(self.guesses[_localIndex].finishingDayUnformated) > self.$moment().add(0, 'hours')) {
          self.guesses[_localIndex].option1 = guess[0]
          self.guesses[_localIndex].option2 = guess[1]
          self.guesses[_localIndex].option1votes = guess[2].c[0]
          self.guesses[_localIndex].option2votes = guess[3].c[0]
          self.guesses[_localIndex].votes = guess[2].c[0] + guess[3].c[0]
        }
      }).catch(err => {
        console.log(err)
      })
    },

    printOptionsProfits (_index, _localIndex) {
      let self = this

      GuessHelper.getGuessOptionsProfits(_index).then((guess) => {
        if (self.$moment(self.guesses[_localIndex].finishingDayUnformated) > self.$moment().add(0, 'hours')) {
          self.guesses[_localIndex].option1AmountEth = parseFloat(guess[0]).toFixed(4) / 10
          self.guesses[_localIndex].option2AmountEth = parseFloat(guess[1]).toFixed(4) / 10
          self.guesses[_localIndex].amountEth = parseFloat(guess[0]).toFixed(4) / 10 +
            parseFloat(guess[1]).toFixed(4) / 10
        }
      })
    },

    getGuessesByDate () {
      let self = this
      var finished = 0
      for (var i = 0; i < 7; i++) {
        GuessHelper.getGuessesByDate(0, this.topic, this.$moment().add(i, 'days').unix()).then((_guesses) => {
          self.guessesByNumber = self.guessesByNumber.concat(_guesses)
          finished++
          if (finished === 7) {
            self.printGuesses()
            self.contentLoaded = false
          }
        }).catch(err => {
          finished++
          if (finished === 7) {
            self.printGuesses()
            self.contentLoaded = false
          }
          // console.log(err)
          return err
        })
      }
    }
    /*
    voteGuess () { // Option has to be 1 or 2
      // let self = this
      this.$refs.paymentModal.hide()
      GuessHelper.voteGuess(this.guessToVote, this.optionVoted, this.ethAmountToVote).then(() => {
        console.log('Transaction pending...')
        this.showVoteAlert('voteAlert', 'success')
      }).catch(err => {
        console.log(err)
        this.showVoteAlert('voteAlert', 'error')
      })
    }
    */
  },

  created: function () {
    GuessHelper.init().then(() => {
      this.getGuessesByDate()
      this.contentLoaded = true
    }).catch(err => {
      console.log(err)
      this.contentLoaded = true
    })
  },

  watch: {
    topic: function () {
      this.contentLoaded = true
      this.totalGuesses = 0
      this.guessesByNumber = []
      this.getGuessesByDate()
      this.guesses = []
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
/*
.voteAlert {
    margin: 5px;
    border-radius: 2px;
    border-left: 0px !important;
}
*/
</style>
