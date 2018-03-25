<template>
  <div>
    <span v-for="n in counter1">
      <b-card-group deck class="mb-3">
        <b-card
                         v-for="j in counter2"
                         :key="j"
                         v-if="events[2*n + j]"
                         style="height: 100%;"
                         :border-variant="events[2*n + j].topic"
                         :header="events[2*n + j].title"
                         :header-border-variant="events[2*n +j].topic"
                         header-text-variant="black"
                         align="center">
          <p class="card-text">
          Created at: <b>{{events[2*n + j].startingDay}}</b>
          <br>
          Voting open until: <b>{{events[2*n + j].finishingDay}}</b>
          </p>

          <!--Number of people Progress Bar-->
          <div v-if="peopleBar">
            <br>
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

          <!--Amount of eth in each option-->
          <div v-if="ethBar">
            <br>
            <span>Eth staked on each outcome: </span>
            <b-progress class="mt-1" :max="10*(events[2*n + j].amountEth/10)" show-value striped>
              <b-progress-bar :value="10*(events[2*n + j].option1AmountEth/10)" variant="pink">
                {{events[2*n + j].option1}} - {{ events[2*n + j].option1AmountEth }}
              </b-progress-bar>
              <b-progress-bar :value="10*(events[2*n + j].option2AmountEth/10)" variant="magenta">
                {{events[2*n + j].option2}} - {{ events[2*n + j].option2AmountEth }}
              </b-progress-bar>
            </b-progress>
            <small>Total: {{events[2*n + j].amountEth}} ether</small>
          </div>

          <!-- Share button and ID -->
          <b-row align-h="end" align-v="end" style="color: #ff0d78">
            #{{events[2*n + j].id}}
            <b-btn id="idCopy" variant="link" size="sm"
                                              @click="show('copyAlert')"
                                              v-clipboard:copy="events[2*n +j].url">
              <img width="20px" src="../../assets/shareicon.png"/>
            </b-btn>
          </b-row>

          <!-- Votation buttons -->
          <div v-if="votationAllow">
            <b-button style="margin: 2px 20px"
                      @click="showPaymentModal(events[2*n + j].id, 1, 2*n +j)"
                      variant="outline-pink" size="sm">
              {{events[2*n +j].option1}}
            </b-button>
            <b-button style="margin: 2px 20px" @click="showPaymentModal(events[2*n + j].id, 2, 2*n + j)" variant="outline-magenta" size="sm">{{events[2*n +j].option2}}</b-button>
          </div>
          <div v-else>
            <b-button style="margin: 2px 20px" disabled
                      variant="outline-secondary" size="sm">
              {{events[2*n +j].option1}}
            </b-button>
            <b-button style="margin: 2px 20px" disabled
                      variant="outline-secondary"
                      size="sm">{{events[2*n +j].option2}}</b-button>
          </div>

        </b-card>
      </b-card-group>
    </span>

    <!-- Modal Payment -->
    <div v-if='events.length > 0'>
      <b-modal ref="paymentModal"
               centered
               title="Vote an event"
               hide-footer
               :header-bg-variant="events[arrayIndex].topic">
        <label>Title: {{events[arrayIndex].title}}</label>
        <br>

        <label>Description: {{events[arrayIndex].description}}</label>
        <br>

        <span>Votes for each outcome: </span>
        <b-progress class="mt-1" :max="10*(events[arrayIndex].votes/10)" show-value striped>
          <b-progress-bar :value="10*(events[arrayIndex].option1votes/10)" variant="pink">
            {{events[arrayIndex].option1}} - {{ events[arrayIndex].option1votes }}
          </b-progress-bar>
          <b-progress-bar :value="10*(events[arrayIndex].option2votes/10)" variant="magenta">
            {{events[arrayIndex].option2}} - {{ events[arrayIndex].option2votes }}
          </b-progress-bar>
        </b-progress>
        <small>Total: {{events[arrayIndex].votes}} people</small>
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
  props: ['events', 'peopleBar', 'ethBar', 'votationAllow'],
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
