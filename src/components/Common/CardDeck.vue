<template>
  <div>
    <span v-for="n in counter1">
      <b-card-group deck class="mb-3">
        <b-card
                         v-for="j in counter2"
                         :key="j"
                         v-if="events[maxCol*n + j]"
                         style="height: 100%;"
                         :border-variant="events[maxCol*n + j].topic"
                         :header="events[maxCol*n + j].title"
                         :header-bg-variant="bgVariant(events[maxCol*n + j].topic)"
                         :header-border-variant="events[maxCol*n +j].topic"
                         header-text-variant="black"
                         @click="showPaymentModal(events[maxCol*n +j].id, maxCol*n+j)"
                         align="center">
          <p class="card-text">
          <span v-if="descriptionAllow">
            {{events[maxCol*n + j].description}}<br><br>
          </span>
          Created at: <b>{{events[maxCol*n + j].startingDay}}</b>
          <br>
          Voting open until: <b>{{events[maxCol*n + j].finishingDay}}</b>
          </p>

          <!--Number of people Progress Bar-->
          <div v-if="peopleBar">
            <br>
            <span>Votes for each outcome: </span>
            <b-progress class="mt-1" :max="10*(events[maxCol*n + j].votes/10)" show-value striped>
              <b-progress-bar :value="10*(events[maxCol*n + j].option1votes/10)" variant="pink">
                {{events[maxCol*n + j].option1}} - {{ events[maxCol*n + j].option1votes }}
              </b-progress-bar>
              <b-progress-bar :value="10*(events[maxCol*n + j].option2votes/10)" variant="magenta">
                {{events[maxCol*n + j].option2}} - {{ events[maxCol*n + j].option2votes }}
              </b-progress-bar>
            </b-progress>
            <small>Total: {{events[maxCol*n + j].votes}} people</small>
          </div>

          <!--Amount of eth in each option-->
          <div v-if="ethBar">
            <br>
            <span>Eth staked on each outcome: </span>
            <b-progress class="mt-1" :max="10*(events[maxCol*n + j].amountEth/10)" show-value striped>
              <b-progress-bar :value="10*(events[maxCol*n + j].option1AmountEth/10)" variant="pink">
                {{events[maxCol*n + j].option1}} - {{ events[maxCol*n + j].option1AmountEth }}
              </b-progress-bar>
              <b-progress-bar :value="10*(events[maxCol*n + j].option2AmountEth/10)" variant="magenta">
                {{events[maxCol*n + j].option2}} - {{ events[maxCol*n + j].option2AmountEth }}
              </b-progress-bar>
            </b-progress>
            <small>Total: {{events[maxCol*n + j].amountEth}} ether</small>
          </div>

          <!-- Share button and ID -->
          <b-row v-if="shareable" align-h="end" align-v="end" style="color: #ff0d78">
            #{{events[maxCol*n + j].id}}
            <b-btn id="idCopy" variant="link" size="sm"
                                              @click="show('copyAlert')"
                                              v-clipboard:copy="events[maxCol*n +j].url">
              <img width="20px" src="../../assets/shareicon.png"/>
            </b-btn>
          </b-row>

          <!-- Buuttons -->
          <div v-if="buttomsAllow">
            <div v-if="mode === 1">
              <b-button style="margin: 2px 20px"
                        @click="showPaymentModal(events[maxCol*n + j].id, maxCol*n +j)"
                        variant="outline-pink" size="sm">
                {{events[maxCol*n +j].option1}}
              </b-button>
              <b-button style="margin: 2px 20px"
                        @click="showPaymentModal(events[maxCol*n + j].id, maxCol*n + j)"
                        variant="outline-magenta" size="sm">
                {{events[maxCol*n +j].option2}}
              </b-button>
            </div>
            <div v-else>
              <br>
              <b-button style="margin: 2px 20px"
                        @click="validateGuess(events[maxCol*n + j].id, 1)"
                        variant="outline-pink" size="sm">
                {{events[maxCol*n + j].option1}}
              </b-button>
              <b-button style="margin: 2px 20px"
                        @click="validateGuess(events[maxCol*n + j].id, 2)"
                        variant="outline-magenta"
                        size="sm">
                {{events[maxCol*n + j].option2}}
              </b-button>
            </div>
          </div>
          <div v-else>
            <b-button style="margin: 2px 20px" disabled
                      variant="outline-secondary" size="sm">
              {{events[maxCol*n +j].option1}}
            </b-button>
            <b-button style="margin: 2px 20px" disabled
                      variant="outline-secondary"
                      size="sm">{{events[maxCol*n +j].option2}}</b-button>
          </div>

        </b-card>
      </b-card-group>
    </span>

    <!-- Modal Payment -->
    <div v-if='events.length > 0'>
      <b-modal ref="paymentModal"
               centered
               :title="events[arrayIndex].topic"
               hide-footer
               :header-bg-variant="events[arrayIndex].topic"
                align="center">
        <p>Description: <b>{{events[arrayIndex].description}}</b></p>
        <p class="card-text">
        Created at: <b>{{events[arrayIndex].startingDay}}</b>
        <br>
        Voting open until: <b>{{events[arrayIndex].finishingDay}}</b>
        </p>
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

          <!--Amount of eth in each option-->
            <br>
            <br>
            <span>Eth staked on each outcome: </span>
            <b-progress class="mt-1" :max="10*(events[arrayIndex].amountEth/10)" show-value striped>
              <b-progress-bar :value="10*(events[arrayIndex].option1AmountEth/10)" variant="pink">
                {{events[arrayIndex].option1}} - {{ events[arrayIndex].option1AmountEth }}
              </b-progress-bar>
              <b-progress-bar :value="10*(events[arrayIndex].option2AmountEth/10)" variant="magenta">
                {{events[arrayIndex].option2}} - {{ events[arrayIndex].option2AmountEth }}
              </b-progress-bar>
            </b-progress>
            <small>Total: {{events[arrayIndex].amountEth}} ether</small>
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
        <b-button style="margin: 2px 20px"
                  @click="voteGuess(1)"
                  variant="outline-pink" size="sm">
          {{events[arrayIndex].option1}}
        </b-button>
        <b-button style="margin: 2px 20px"
                  @click="voteGuess(2)"
                  variant="outline-magenta" size="sm">
          {{events[arrayIndex].option2}}
        </b-button>
        <br>
        <br>
      </b-modal>
    </div>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'CardDeck',
  props: {
    events: {
      default: [],
      type: Array
    },
    maxCol: {
      default: 2,
      type: Number
    },
    mode: {
      default: 1,
      type: Number
    },
    peopleBar: {
      default: false,
      type: Boolean
    },
    ethBar: {
      default: false,
      type: Boolean
    },
    descriptionAllow: {
      default: false,
      type: Boolean
    },
    shareable: {
      default: true,
      type: Boolean
    },
    buttomsAllow: {
      default: true,
      type: Boolean
    },
    headerBg: {
      default: false,
      type: Boolean
    }
  },
  data () {
    return {
      contentLoaded: true,
      arrayIndex: 0, // The selected event to vote
      counter1: [0, 1, 2, 3, 4, 5],
      counter2: [],
      optionVoted: null,
      eventToVote: null,
      ethAmountToVote: null
    }
  },
  methods: {
    bgVariant (topic) {
      if (this.headerBg) {
        return topic
      } else {
        return 'none'
      }
    },
    defineCols () {
      for (var i = 0; i < this.maxCol; i++) {
        this.counter2[i] = i
      }
    },
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
    showPaymentModal (_guessId, _arrayIndex) {
      this.arrayIndex = _arrayIndex
      this.eventToVote = _guessId
      this.$refs.paymentModal.show()
    },
    voteGuess (optionVoted) { // Option has to be 1 or 2
      // let self = this
      this.$refs.paymentModal.hide()
      GuessHelper.voteGuess(this.eventToVote, optionVoted, this.ethAmountToVote).then(() => {
        console.log('Transaction pending...')
        this.showVoteAlert('voteAlert', 'success', this.eventToVote, this.optionVoted, this.ethAmountToVote)
      }).catch(err => {
        console.log(err)
        this.showVoteAlert('voteAlert', 'error')
      })
    },
    validateGuess (_index, _option) { // Option has to be 1 or 2
      // let self = this
      console.log(_index)
      GuessHelper.validateGuess(_index, _option).then(() => {
        console.log('Transaction pending...')
      }).catch(err => {
        console.log(err)
      })
    }
  },
  created: function () {
    this.defineCols()
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
