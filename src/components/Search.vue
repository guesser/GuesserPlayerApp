<template>
  <div class='outside' style="">
    <div v-if='contentLoaded'>
      <Loading/>
    </div>
    <div v-if="guessExists" class='inside' style="">
      <b-card :border-variant="guess.topic"
                                           :header="guess.title"
                                           :header-bg-variant="guess.topic"
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
        <br>
        <b-button style="margin-right: 20px" @click="showPaymentModal(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
        <b-button @click="showPaymentModal(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
      </b-card>
    </div>
    <div v-else>
      <b-row align-h="center">
        <img src="static/beard-hold.png" style="width: 30%; height: 30%;" alt=":'("/>         
      </b-row>
      <b-row align-h="center">
        <h3>Looks like this event doesn't exist</h3>
      </b-row>
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
// Import section
import Loading from '../components/Loading.vue'
import GuessHelper from '@/js/Guess'

export default {
  name: 'Search',
  props: ['topic'],
  components: {
    Loading
  },
  data: function () {
    return {
      form: {
        _id: ''
      },
      guess: {
        id: '0',
        title: 'Loading...',
        description: 'Loading...',
        topic: '',
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
      guessExists: null,
      optionVoted: null,
      ethAmountToVote: 0
    }
  },
  created: function () {
    this.searchForGuess()
  },
  beforeUpdate: function () {
    this.searchForGuess()
  },
  methods: {
    searchForGuess () {
      let self = this
      let _id = this.form._id
      _id = this.$route.query._id
      console.log('Identification in browser: ', _id)
      GuessHelper.getGuessOptions(_id).then((guessOptions) => {
        self.guess.option1 = guessOptions[0]
        self.guess.option2 = guessOptions[1]
        self.guess.option1votes = guessOptions[2].c[0]
        self.guess.option2votes = guessOptions[3].c[0]
      })
      GuessHelper.getGuessFront(_id).then((guessFound) => {
        self.guess.title = guessFound[0]
        self.guess.description = guessFound[1]
        self.guess.topic = guessFound[2]
        self.guess.votes = guessFound[4]
        self.guess.startingDay = this.$moment(guessFound[5]).format('MMMM Do YYYY, h a')
        self.guess.finishingDay = this.$moment(guessFound[6]).format('MMMM Do YYYY, h a')
        self.guessExists = true
      }).catch(err => {
        console.log(err)
      })
      GuessHelper.getGuessOptionsProfits(_id).then((optionsAmount) => {
        self.guess.option1AmountEth = parseInt(optionsAmount[0]) / 10
        self.guess.option2AmountEth = parseInt(optionsAmount[1]) / 10
        self.guess.amountEth = parseInt(optionsAmount[0]) / 10 + parseInt(optionsAmount[1]) / 10
      })
      console.log('Guess: ', self.guess)
      this.contentLoaded = false
    },
    showPaymentModal (_optionVoted) {
      this.optionVoted = _optionVoted
      this.$refs.paymentModal.show()
    },
    voteGuess () { // Option has to be 1 or 2
      // let self = this
      this.$refs.paymentModal.hide()
      GuessHelper.voteGuess(this.guessIndex, this.optionVoted, this.ethAmountToVote).then(() => {
        console.log('Transaction pending...')
        // TODO: Show alert of voting
        this.guessVotingAlert = true
      }).catch(err => {
        console.log(err)
        this.guessVotingFailedAlert = true
      })
    }
  }
}
</script>

<style>
.card-link{
  text-decoration: underline;
}
.outside {
  width:100%;

  /* Firefox */
  display:-moz-box;
  -moz-box-pack:center;
  -moz-box-align:center;

  /* Safari and Chrome */
  display:-webkit-box;
  -webkit-box-pack:center;
  -webkit-box-align:center;

  /* W3C */
  display:box;
  box-pack:center;
  box-align:center;

  margin-top: 2%;
}

.inside {
  width:50%;
}
</style>
