<template>
  <div class='outside' style="">
    <!--Alert-->
    <notifications group="voteAlert"
                   position="top center"
                   classes="vue-notification voteAlert"
                   :max="2"
                   width="320px"
                   :speed="800"/>
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

    <div v-if='contentLoaded'>
      <Loading/>
    </div>
    <div v-if="guessExists" class='inside' style="">
      <SingleCard ref="singleCard" :eventItem="guess"/>
    </div>

    <!--If event doesn't exist-->
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
// Import section
import GuessHelper from '@/js/Guess'
import NetworkHelper from '@/js/NetworkHelper'

import Loading from '../components/Loading.vue'
import SingleCard from './Common/SingleCard.vue'

export default {
  name: 'Search',
  props: ['topic'],
  components: {
    Loading,
    SingleCard
  },
  data () {
    return {
      guessVotingAlert: false,
      guessVotingFailedAlert: false,
      contentLoaded: true,
      guess: {
        id: '0',
        url: '',
        title: 'Loading...',
        description: 'Loading...',
        topic: 'Crypto',
        creator: '0x00000000000000000000000000000000',
        votes: 0,
        startingDay: '10-10-10',
        finishingDay: '10-10-10',
        eventDuration: '',
        eventState: '',
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
  methods: {
    searchForGuess () {
      let self = this

      self.guessIndex = this.$route.params.id
      this.contentLoaded = false
      self.guess.id = self.guessIndex
      self.getGuess(self.guessIndex)
      self.getEventState(self.guessIndex)
      self.getOptions(self.guessIndex)
      self.getOptionsProfits(self.guessIndex)
    },
    generateEventUrl () {
      let _url = 'www.guesser.io/#/search/'
      this.guess.url = _url + this.guess.id
    },
    getGuess (_id) {
      let self = this

      GuessHelper.getGuessFront(_id).then((guessFound) => {
        // TODO: Solve this mess
        self.guess.url = window.location.href

        self.guess.title = guessFound[0]
        self.guess.description = guessFound[1]
        self.guess.topic = guessFound[2]
        self.guess.creator = guessFound[3]
        self.guess.startingDay = this.$moment(guessFound[4]).format('MMMM D, YYYY [at] H[h]')
        self.guess.finishingDay = this.$moment(guessFound[5]).format('MMMM D, YYYY [at] H[h]')
        self.guess.finishingDayUnformated = this.$moment(guessFound[5])

        let _eventDuration = this.$moment(guessFound[6]).unix() - this.$moment(guessFound[5]).unix()
        self.guess.eventDuration = this.$moment.duration(_eventDuration, 'seconds').humanize()
        self.guess.eventDurationUnformated = _eventDuration
        self.guessExists = true
        self.$refs.singleCard.setUsername(guessFound[3])
      }).catch(err => {
        return err
      })
    },
    getEventState (_id) {
      let self = this

      GuessHelper.getEventItemState(_id).then((eventItemState) => {
        console.log('EvenOfTheDay: ', eventItemState)
        self.guess.eventState = eventItemState
      }).catch(err => {
        console.log(err)
      })
    },
    getOptions (_id) {
      let self = this

      GuessHelper.getGuessOptions(_id).then((guessOptions) => {
        self.guess.option1 = guessOptions[0]
        self.guess.option2 = guessOptions[1]
        self.guess.option1votes = guessOptions[2].c[0]
        self.guess.option2votes = guessOptions[3].c[0]
        self.guess.votes = self.guess.option1votes + self.guess.option2votes
      }).catch(err => {
        self.guessExists = false
        return err
      })
    },
    getOptionsProfits (_id) {
      let self = this

      GuessHelper.getGuessOptionsProfits(_id).then((optionsAmount) => {
        self.guess.option1AmountEth = +(parseFloat(optionsAmount[0]) / 10).toFixed(4)
        self.guess.option2AmountEth = +(parseFloat(optionsAmount[1]) / 10).toFixed(4)
        self.guess.amountEth = +(parseFloat(optionsAmount[0]) / 10 +
          parseFloat(optionsAmount[1]) / 10).toFixed(5)
      }).catch(err => {
        return err
      })
    }
  },
  created: function () {
    let self = this

    GuessHelper.init().then(() => {
      self.contentLoaded = false
      self.searchForGuess()
    }).catch(err => {
      console.log(err)
    })
    NetworkHelper.init().then(() => {
      if (NetworkHelper.state === 'disconnected' ||
          NetworkHelper.state === 'locked') {
        self.$router.push('signup')
      }
    })
  },
  beforeUpdate: function () {
    let self = this

    if (!this.guessExists || this.$route.params.id !== this.guess.id) {
      self.searchForGuess()
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
  width:60%;
}
</style>
