<template>
  <div>
    <span v-for="n in counter1">
    <b-card-group deck class="mb-3">
      <b-card
                                    v-for="j in counter2"
                                    :key="j"
                                    v-if="guesses[2*n + j]"
                                    :border-variant="topic"
                                    :header="guesses[2*n + j].title"
                                    :header-border-variant="topic"
                                    header-text-variant="black"
                                    align="center">
        <p class="card-text">
        From: <b>{{guesses[2*n + j].startingDay}}</b>
        <br>
        To: <b>{{guesses[2*n + j].finishingDay}}</b>
        </p>
        <b-button style="margin-right: 10px" @click="showPaymentModal(guesses[2*n + j].id, 1)" variant="outline-pink" size="sm">{{guesses[2*n + j].option1}}</b-button>
        <b-button @click="showPaymentModal(guesses[2*n + j].id, 2)" variant="outline-magenta" size="sm">{{guesses[2*n + j].option2}}</b-button>
      </b-card>
    </b-card-group>
    </span>
    <h4 class="absolute-center" v-if='totalGuesses == 0'>There are no Guesses over here!</h4>

    <!-- Modal Payment -->
    <b-modal ref="paymentModal"
             centered
             title="Choose amount"
             hide-footer
             :header-bg-variant="topic">
      <b-form-group id="titleGroup"
                    label="Ether amount to send:"
                    label-for="amountInput">
        <b-form-input id="amountInput"
                      type="number"
                      v-model="ethAmountToVote"
                      required>
        </b-form-input>
      </b-form-group>

      <b-button @click="voteGuess()" variant="primary" size="sm">Vote</b-button>
    </b-modal>

  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'otherguesses',
  props: ['topic'],
  data () {
    return {
      guesses: [],
      guessesByNumber: [],
      counter1: [0, 1, 2, 3, 4, 5],
      counter2: [0, 1],
      totalGuesses: 0,
      optionVoted: 0,
      guessToVote: 0,
      ethAmountToVote: 0
    }
  },
  methods: {
    showPaymentModal (_guessId, _optionVoted) {
      this.optionVoted = _optionVoted
      this.guessToVote = _guessId
      this.$refs.paymentModal.show()
    },
    printGuesses () {
      this.guesses = []
      for (var i = 0; i < this.guessesByNumber.length; i++) {
        let _index = this.guessesByNumber[i].c[0]
        if (_index !== 0) { // Guess 0 is the empty one
          // TODO: Not show the guesses if the day is the same but the hour is lower
          GuessHelper.getGuessFront(_index).then((guess) => {
            if (this.$moment(guess[6]) > this.$moment().add(0, 'hour')) {
              this.guesses.push({
                'id': _index,
                'title': guess[0],
                'description': guess[1],
                'topic': guess[2],
                'votes': guess[4],
                'startingDay': this.$moment(guess[5]).format('MMMM Do YYYY, h a'),
                'finishingDay': this.$moment(guess[6]).format('MMMM Do YYYY, h a'),
                'finishingDayUnformated': this.$moment(guess[6]),
                'option1': 'Loading...',
                'option2': 'Loading...'
              })
            }
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
        console.log(self.guesses[_localIndex].finishingDay)
        if (self.$moment(self.guesses[_localIndex].finishingDayUnformated) > self.$moment().add(0, 'hours')) {
          self.guesses[_localIndex].option1 = guess[0]
          self.guesses[_localIndex].option2 = guess[1]
        }
      }).catch(err => {
        console.log(err)
      })
    },

    // getGuessesOfTheDay () {
    getGuessesByDate () {
      let self = this

      for (let i = 0; i < 6; i++) {
        GuessHelper.getGuessesByDate(0, this.topic, this.$moment().add(i, 'days').unix()).then((_guesses) => {
          console.log(_guesses)
          self.guessesByNumber = self.guessesByNumber.concat(_guesses)
          console.log('To show: ', self.guessesByNumber)
          self.printGuesses()
        }).catch(err => {
          console.log(err)
        })
      }
    },
    voteGuess () { // Option has to be 1 or 2
      // let self = this
      this.$refs.paymentModal.hide()
      GuessHelper.voteGuess(this.guessToVote, this.optionVoted, this.ethAmountToVote).then(() => {
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
      this.getGuessesByDate()
    }).catch(err => {
      console.log(err)
    })
  },

  watch: {
    topic: function () {
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
</style>
