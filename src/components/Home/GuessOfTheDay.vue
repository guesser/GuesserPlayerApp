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
          </p>   
    <br>
 <p class="card-text">
          From: <b>{{guess.startingDay}}</b>
          <br>
          To: <b>{{guess.finishingDay}}</b>
    </p>
    <br>
    <!--Number of people Progress Bar-->
    <span>Number of votes in each option: </span>
    <b-progress class="mt-1" :max="10*(guess.votes/10)" show-value striped>
      <b-progress-bar :value="10*(guess.option1votes/10)" variant="pink">
        {{guess.option1}} - {{ guess.option1votes }}
      </b-progress-bar>
      <b-progress-bar :value="10*(guess.option2votes/10)" variant="magenta">
        {{guess.option2}} - {{ guess.option2votes }}
      </b-progress-bar>
    </b-progress>
    <small>Total: {{guess.votes}} people</small>

    <!--Amount of eth in each option-->
    <br>
    <br>
    <span>Eth amout in each option: </span>
    <b-progress class="mt-1" :max="10*(guess.amountEth/10)" show-value striped>
      <b-progress-bar :value="10*(guess.option1AmountEth/10)" variant="pink">
        {{guess.option1}} - {{ guess.option1AmountEth }}
      </b-progress-bar>
      <b-progress-bar :value="10*(guess.option2AmountEth/10)" variant="magenta">
        {{guess.option2}} - {{ guess.option2AmountEth }}
      </b-progress-bar>
    </b-progress>
    <small>Total: {{guess.amountEth}} ether</small>

    <br>
    <br>
    <b-button @click="showPaymentModal(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
    <b-button @click="showPaymentModal(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
  </b-card>
    </div>
  <div v-else style="text-center">
    There are no Guesses... :'(
    </div>

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
  name: 'GuessOfTheDay',
  props: ['topic'],
  data () {
    return {
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
        option2votes: '0',
        option1AmountEth: '0',
        option2AmountEth: '0',
        amountEth: 0
      },
      guessIndex: null,
      optionVoted: null,
      ethAmountToVote: 0
    }
  },
  methods: {
    showPaymentModal (_optionVoted) {
      this.optionVoted = _optionVoted
      this.$refs.paymentModal.show()
    },
    getGuess () {
      let self = this

      GuessHelper.getGuessFront(this.guessIndex).then((guessDay) => {
        console.log(guessDay)

        self.guess.title = guessDay[0]
        self.guess.description = guessDay[1]
        self.guess.topic = guessDay[2]
        self.guess.votes = guessDay[4]
        self.guess.startingDay = this.$moment(guessDay[5]).format('MMMM Do YYYY, h a')
        self.guess.finishingDay = this.$moment(guessDay[6]).format('MMMM Do YYYY, h a')
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
        self.getOptionsProfits()
      }).catch(err => {
        console.error(err)
      })
    },
    voteGuess () { // Option has to be 1 or 2
      // let self = this
      this.$refs.paymentModal.hide()
      GuessHelper.voteGuess(this.guessIndex, this.optionVoted, this.ethAmountToVote).then(() => {
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
    },
    getOptionsProfits () {
      let self = this

      GuessHelper.getGuessOptionsProfits(this.guessIndex).then((optionsAmount) => {
        self.guess.option1AmountEth = parseInt(optionsAmount[0]) / 10
        self.guess.option2AmountEth = parseInt(optionsAmount[1]) / 10
        self.guess.amountEth = parseInt(optionsAmount[0]) / 10 + parseInt(optionsAmount[1]) / 10
        console.log(self.guess.option1AmountEth)
        console.log(self.guess.option2AmountEth)
        console.log(self.guess.amountEth)
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
