<template>
  <div>

    <!--Alert-->
    <b-alert variant="success"
             dismissible
             :show="guessVotingAlert"
             @dismissed="showVotingAlert=false">
      Hang in there... Guess being voted.
    </b-alert>
    <b-alert variant="danger"
             dismissible
             :show="guessVotingFailedAlert"
             @dismissed="showVotingFailedAlert=false">
      It seems the voting failed...
    </b-alert>
    <notifications group="copyalert"
                   position="bottom right"
                   width="120"
                   :speed="500">
      <template slot="body" slot-scope="props">
        <div class="copyalert">
          <div class="copyalert-content">
            url copied!
          </div>
        </div>
      </template>
    </notifications>

    <!--If events-->
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
        Created at: <b>{{guess.startingDay}}</b>
        <br>
        Open until: <b>{{guess.finishingDay}}</b>
        </p>
        <br>
        <!--Number of people Progress Bar-->
        <span>Votes for each outcome: </span>
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
        <span>Eth staked on each outcome: </span>
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
        <b-row align-h="end">
          <b-btn id="idCopy" variant="link" size="sm"
                 @click="show('copyAlert')"
                 v-clipboard:copy="guess.url">
            <img width="20px" src="../../assets/shareicon.png"/>
          </b-btn>
        </b-row>
        <b-button style="margin: 2px 20px" @click="showPaymentModal(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
        <b-button style="margin: 2px 20px" @click="showPaymentModal(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
      </b-card>
    </div>

    <!--If no events-->
    <div v-else>
      <b-container class="" style="">
        <b-row align-h="between">
          <b-col align-self="center">
            <h3>Looks like today there are no events for this topic!</h3>
            <h3>Feel like creating one?</h3>
          </b-col>
          <b-col>
              <img src="static/beard-hold.png" style="width: 70%;" alt=":'("/>         
          </b-col>
        </b-row>
        <b-row>
              <b-button href="#create" variant="primary" size="lg">Create</b-button>
        </b-row>    
        </b-container>
    </div>

    <!-- Modal Payment -->
    <b-modal ref="paymentModal"
             centered
             title="Choose amount"
             hide-footer
             :header-bg-variant="topic">
      <b-form-group id="titleGroup"
                    label="Amount of other you want to sent:"
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
      guessVotingAlert: false,
      guessVotingFailedAlert: false,
      guess: {
        id: '0',
        url: 'www.guesser.io/#/search?_id=',
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
    show (group) {
      this.$notify({
        group
      })
    },
    clean (group) {
      this.$notify({ group, clean: true })
    },
    showPaymentModal (_optionVoted) {
      this.optionVoted = _optionVoted
      this.$refs.paymentModal.show()
    },
    generateEventUrl () {
      this.guess.url += this.guess.id
    },
    getGuess () {
      let self = this

      GuessHelper.getGuessFront(this.guessIndex).then((guessDay) => {
        // console.log(guessDay)

        self.guess.title = guessDay[0]
        self.guess.description = guessDay[1]
        self.guess.topic = guessDay[2]
        self.guess.votes = guessDay[4]
        self.guess.startingDay = this.$moment(guessDay[5]).format('MMMM D, YYYY [at] H[h]')
        self.guess.finishingDay = this.$moment(guessDay[6]).format('MMMM D, YYYY [at] H[h]')
      }).catch(err => {
        console.log(err)
      })
    },
    getGuessOfTheDay () {
      let self = this
      GuessHelper.getGuessOfTheDay(this.topic).then((guessNumber) => {
        if (guessNumber !== 0) {
          self.guessIndex = guessNumber
          self.guess.id = self.guessIndex
          self.getGuess()
          self.getOptions()
          self.getOptionsProfits()
          self.generateEventUrl()
        }
      }).catch(err => {
        return err
      })
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
        // console.log(optionsAmount[0])

        self.guess.option1AmountEth = parseFloat(optionsAmount[0]) / 10
        self.guess.option2AmountEth = parseFloat(optionsAmount[1]) / 10
        self.guess.amountEth = parseFloat(optionsAmount[0]) / 10 + parseFloat(optionsAmount[1]) / 10
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
