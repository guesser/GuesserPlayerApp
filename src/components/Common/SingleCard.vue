<template>
  <div>
    <b-card :border-variant="eventItem.topic"
                   :header="eventItem.title"
                   :header-bg-variant="eventItem.topic"
                   header-text-variant="white"
                   class="text-center">
      <p class="card-text">
      {{eventItem.description}}
      </p>
      <p class="card-text">
      Created at: <b>{{eventItem.startingDay}}</b>
      <br>
      Open until: <b>{{eventItem.finishingDay}}</b>
      <br>
      <span v-if="eventItem.eventState == 'voting'">
        <small>Validation starts after: <b>{{eventItem.eventDuration}}</b></small>
      </span>

      <!--Waiting time bar-->
      <span v-if="eventItem.eventState == 'waiting'">
        <small>Waiting: <b>{{eventItem.eventDuration}}</b></small>
        <b-row align-h="center">
          <b-progress class="w-50" :max="waitingTime()" striped>
            <b-progress-bar :value="waitingDone()" :variant="eventItem.topic.toLowerCase()">
            </b-progress-bar>
          </b-progress>
        </b-row>
      </span>

      <span v-if="eventItem.eventState == 'passed'">
        Passed event
      </span>
      </p>

      <div v-if="eventItem.eventState != 'validating'">
        <!--Number of people Progress Bar-->
        <div v-if="peopleBar">
          <br>
          <span>Votes for each outcome: </span>
          <b-progress class="mt-1" :max="10*(eventItem.votes/10)" show-value striped>
            <b-progress-bar :value="10*(eventItem.option1votes/10)" variant="pink">
              {{eventItem.option1}} - {{ eventItem.option1votes }}
            </b-progress-bar>
            <b-progress-bar :value="10*(eventItem.option2votes/10)" variant="magenta">
              {{eventItem.option2}} - {{ eventItem.option2votes }}
            </b-progress-bar>
          </b-progress>
          <small>Total: {{eventItem.votes}} people</small>
        </div>

        <!--Amount of eth in each option-->
        <div v-if="ethBar">
          <br>
          <span>Eth staked on each outcome: </span>
          <b-progress class="mt-1" :max="10*(eventItem.amountEth/10)" show-value striped>
            <b-progress-bar :value="10*(eventItem.option1AmountEth/10)" variant="pink">
              {{eventItem.option1}} - {{ eventItem.option1AmountEth }}
            </b-progress-bar>
            <b-progress-bar :value="10*(eventItem.option2AmountEth/10)" variant="magenta">
              {{eventItem.option2}} - {{ eventItem.option2AmountEth }}
            </b-progress-bar>
          </b-progress>
          <small>Total: {{eventItem.amountEth}} ether</small>
        </div>
      </div>

      <!--If event is beeing validating-->
      <div v-else>
        <div class="warnVal">
          VALIDATION PROCESS
        </div>
      </div>

      <!--Address-->
      <b-row align-v="end" align-h="between">
        <b-col v-if="creatorUserName" align-self="end" align-h="start" style="text-align: left">
          By: <span style="color: #ff0d78;">@{{ creatorUserName }}</span>
          <b-btn id="" variant="link" size="sm">
          </b-btn>
        </b-col>

        <!--Share button and ID-->
        <b-col v-if="shareable" align-self="end" style="color: #ff0d78">
          <b-row align-v="end" align-h="end">
            #{{eventItem.id}}
            <b-btn id="idCopy"
                   variant="link"
                   size="sm"
                   @click="show('copyAlert')"
                   v-clipboard:copy="eventItem.url">
              <img width="20px" src="../../assets/shareicon.png"/>
            </b-btn>
          </b-row>
        </b-col>
      </b-row>

      <!--Buttons-->
      <div v-if="buttonsAllow && eventItem.eventState != 'validating' && eventItem.eventState != 'passed'">
        <div v-if="mode === 1">
          <b-button style="margin: 2px 20px"
                    @click="showPaymentModal(1)"
                    variant="outline-pink"
                    size="sm">
            {{eventItem.option1}}
          </b-button>
          <b-button style="margin: 2px 20px"
                    @click="showPaymentModal(2)"
                    variant="outline-magenta"
                    size="sm">
            {{eventItem.option2}}
          </b-button>
        </div>
      </div>
      <div v-else>
        <b-button style="margin: 2px 20px"
                  disabled
                  variant="outline-pink"
                  size="sm">
          {{eventItem.option1}}
        </b-button>
        <b-button style="margin: 2px 20px"
                  disabled
                  variant="outline-magenta"
                  size="sm">
          {{eventItem.option2}}
        </b-button>
      </div>
    </b-card>

    <!-- Modal Payment -->
    <b-modal ref="paymentModal"
             centered
             title="Choose amount:"
             hide-footer
             :header-bg-variant="eventItem.topic">
      <b-form @submit="voteGuess()">
      <b-form-group id="titleGroup"
                    label="Amount of other you want to sent:"
                    label-for="amountInput">
        <b-form-input id="amountInput"
                      type="number"
                      step="0.0001"
                      v-model="ethAmountToVote"
                      required>
        </b-form-input>
      </b-form-group>
      <b-button type="submit" variant="primary" size="sm">Vote</b-button>
      </b-form>
    </b-modal>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import ServerHelper from '@/js/ServerHelper'

export default {
  name: 'SingleCard',
  props: {
    eventItem: {
      type: Object
    },
    mode: {
      default: 1,
      type: Number
    },
    peopleBar: {
      default: true,
      type: Boolean
    },
    ethBar: {
      default: true,
      type: Boolean
    },
    descriptionAllow: {
      default: true,
      type: Boolean
    },
    shareable: {
      default: true,
      type: Boolean
    },
    buttonsAllow: {
      default: true,
      type: Boolean
    },
    headerBg: {
      default: true,
      type: Boolean
    }
  },
  data () {
    return {
      optionVoted: null,
      eventToVote: null,
      ethAmountToVote: null,
      creatorUserName: '',
      currentUsername: null
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
    parser (value, event) {
      return value.toLowerCase()
    },
    waitingTime () {
      let self = this

      var waitingTimeTotal = self.eventItem.eventDurationUnformated
      waitingTimeTotal = waitingTimeTotal / 60
      // console.log('Total', waitingTimeTotal)

      return waitingTimeTotal
    },
    waitingDone () {
      let self = this

      var waitingTimeDone = self.$moment().unix() - self.eventItem.finishingDayUnformated.unix()
      waitingTimeDone = Math.round(waitingTimeDone / 60)

      return waitingTimeDone
    },

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
    voteGuess () { // Option has to be 1 or 2
      // let self = this
      this.$refs.paymentModal.hide()
      console.log(this.ethAmountToVote)
      this.showVoteAlert('voteAlert', 'success')
      GuessHelper.voteGuess(this.eventItem.id, this.optionVoted, this.ethAmountToVote).then(() => {
        console.log('Transaction pending...')
      }).catch(err => {
        console.log(err)
        this.showVoteAlert('voteAlert', 'error')
      })
    },
    getUsername (address) {
      return new Promise((resolve, reject) => {
        ServerHelper.getUser(address).then((data) => {
          resolve(data.username)
        }).catch((err) => {
          reject(err)
        })
      })
    },
    setUsername (address) {
      ServerHelper.getUser(address).then((data) => {
        this.creatorUserName = data.username
      }).catch((err) => {
        this.creatorUserName = address.substring(0, 8) + '...'
        return (err)
      })
    }
  },
  beforeCreate: function () {
    let self = this

    GuessHelper.init().then(() => {
      // Redo this, this is not asyncronous
      self.getUsername(this.eventItem.creator).then((username) => {
        this.creatorUserName = username
      }).catch((err) => {
        this.creatorUserName = this.eventItem.creator.substring(0, 8) + '...'
        return err
      })
      self.getUsername(GuessHelper.address[0]).catch((err) => {
        self.buttonsAllow = false
        return err
      })
    })
  }
}
</script>
<style>
.card-link{
  text-decoration: underline;
}
.voteAlert {
  margin: 5px;
  border-radius: 2px;
  border-left: 0px !important;
}
.warnVal {
  display: inline-block;
  padding: 5px 10px;
  border-style: solid;
  border-color: gray;
  border-radius: 5px;
  font-weight: bold;
  color: gray;
  margin: 4%;
}
</style>
