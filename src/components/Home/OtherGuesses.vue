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
          <b-button @click="showPaymentModal(guess.id, 1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
          <b-button @click="showPaymentModal(guess.id, 2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>

        </b-card>
      </div>
      <!--TODO: Make this more beautiful-->
      <h4 v-if='totalGuesses == 0'>There are no Guesses over here!</h4>
    </b-card-group>

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
      for (var i = 0; i < 10; i++) {
        let _index = this.guessesByNumber[i].c[0]
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
