<template>
  <div>
    <span v-for="n in counter1">
      <b-card-group deck class="mb-3">
        <b-card
                         v-for="j in counter2"
                         :key="j"
                         v-if="guesses[2*n + j]"
                         style="height: 100%;"
                         :border-variant="guesses[0].topic"
                         :header="guesses[2*n + j].title"
                         :header-border-variant="guesses[0].topic"
                         header-text-variant="black"
                         align="center">
          <p class="card-text">
          Created at: <b>{{guesses[2*n + j].startingDay}}</b>
          <br>
          Voting open until: <b>{{guesses[2*n + j].finishingDay}}</b>
          </p>
          <div v-if="peopleBar">
            <!--Number of people Progress Bar-->
            <span>Votes for each outcome: </span>
            <b-progress class="mt-1" :max="10*(events[2*n + j].votes/10)" show-value striped>
              <b-progress-bar :value="10*(events[2*n + j].option1votes/10)" variant="pink">
                {{events[2*n + j].option1}} - {{ events[2*n + j].option1votes }}
              </b-progress-bar>
              <b-progress-bar :value="10*(events[2*n + j].option2votes/10)" variant="magenta">
                {{events[2*n + j].option2}} - {{ events[2*n + j].option2votes }}
              </b-progress-bar>
            </b-progress>
            <small>Total: {{events[2*n + j].votes}} people</small>
          </div>
          <b-row align-h="end" align-v="end" style="color: #ff0d78">
            #{{guesses[2*n + j].id}}
            <b-btn id="idCopy" variant="link" size="sm"
                                              @click="show('copyAlert')"
                                              v-clipboard:copy="guesses[2*n +j].url">
              <img width="20px" src="../../assets/shareicon.png"/>
            </b-btn>
          </b-row>
          <b-button style="margin: 2px 20px"
                    @click="showPaymentModal(guesses[2*n + j].id, 1, 2*n +j)"
                    variant="outline-pink" size="sm">
            {{guesses[2*n +j].option1}}
          </b-button>
          <b-button style="margin: 2px 20px" @click="showPaymentModal(guesses[2*n + j].id, 2, 2*n + j)" variant="outline-magenta" size="sm">{{guesses[2*n +j].option2}}</b-button>
        </b-card>
      </b-card-group>
    </span>

    <!-- Modal Payment -->
    <div v-if='guesses.length > 0'>
      <b-modal ref="paymentModal"
               centered
               title="Vote an event"
               hide-footer
               :header-bg-variant="guesses[arrayIndex].topic">
        <label>Title: {{guesses[arrayIndex].title}}</label>
        <br>

        <label>Description: {{guesses[arrayIndex].description}}</label>
        <br>

        <span>Votes for each outcome: </span>
        <b-progress class="mt-1" :max="10*(guesses[arrayIndex].votes/10)" show-value striped>
          <b-progress-bar :value="10*(guesses[arrayIndex].option1votes/10)" variant="pink">
            {{guesses[arrayIndex].option1}} - {{ guesses[arrayIndex].option1votes }}
          </b-progress-bar>
          <b-progress-bar :value="10*(guesses[arrayIndex].option2votes/10)" variant="magenta">
            {{guesses[arrayIndex].option2}} - {{ guesses[arrayIndex].option2votes }}
          </b-progress-bar>
        </b-progress>
        <small>Total: {{guesses[arrayIndex].votes}} people</small>
        <br>
        <br>

        <b-form-group id="titleGroup"
                      label="Amount of ether you want to send:"
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
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'carddeck',
  props: ['guesses', 'peopleBar'],
  data () {
    return {
      contentLoaded: true,
      arrayIndex: 0, // The selected guess to vote
      counter1: [0, 1, 2, 3, 4, 5],
      counter2: [0, 1],
      totalGuesses: 0,
      optionVoted: 0,
      guessToVote: 0,
      ethAmountToVote: 0
    }
  },
  methods: {
    showVoteAlert (group, type = '') {
      var title = ''
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
  }
}
</script>
<style>
.absolute-center {
  margin: auto;
  text-align: center;
  position: relative;
}
.voteAlert {
  margin: 5px;
  border-radius: 2px;
  border-left: 0px !important;
}
</style>
