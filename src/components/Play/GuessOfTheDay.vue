<template>
  <div>
    <!--If events-->
    <div v-if='guessIndex != null'>
      <SingleCard :eventItem="guess" :buttonsAllow="buttonsAllow"/>
    </div>

    <!--If no events-->
    <div v-else>
      <b-container class="" style="">
        <b-row align-h="between">
          <b-col>
          <b-container style="display: flex; justify-content: center; padding: 5%;">
            <b-col align-self="center">
              <h3 style="font-size:calc(1em + 1vw);">Looks like today there are no events for this topic!</h3>
              <h3 style="font-size:calc(1em + 1vw);">Feel like creating one?</h3>
            </b-col>
          </b-container>
          </b-col>
          <b-col lg="5">
              <img src="static/beard-hold.png" style="width: 70%;" alt=":'("/>
          </b-col>
        </b-row>
        <b-row>
          <b-container style="padding: 6%; display: flex; justify-content: left;">
            <b-button href="#create" variant="primary" size="lg">Create</b-button>
          </b-container>
        </b-row>
      </b-container>
    </div>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import SingleCard from '../Common/SingleCard.vue'

export default {
  name: 'GuessOfTheDay',
  props: ['topic'],
  components: {
    SingleCard
  },
  data () {
    return {
      buttonsAllow: true,
      showMetamask: false,
      guessVotingAlert: false,
      guessVotingFailedAlert: false,
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
      let _url = 'www.guesser.io/#/event/'
      this.guess.url = _url + this.guess.id
    },
    getGuess () {
      let self = this

      GuessHelper.getGuessFront(this.guessIndex).then((guessDay) => {
        // console.log(guessDay)

        self.guess.title = guessDay[0]
        self.guess.description = guessDay[1]
        self.guess.topic = guessDay[2]
        self.guess.creator = guessDay[3]
        self.guess.startingDay = this.$moment(guessDay[4]).format('MMMM D, YYYY [at] H[h]')
        self.guess.finishingDay = this.$moment(guessDay[5]).format('MMMM D, YYYY [at] H[h]')

        let _eventDuration = this.$moment(guessDay[6]).unix() - this.$moment(guessDay[5]).unix()
        self.guess.eventDuration = this.$moment.duration(_eventDuration, 'seconds').humanize()
      }).catch(err => {
        console.log(err)
      })
    },
    getEventState () {
      let self = this

      GuessHelper.getEventItemState(this.guessIndex).then((eventItemState) => {
        self.guess.eventState = eventItemState
      }).catch(err => {
        console.log(err)
      })
    },
    getGuessOfTheDay () { // It's a trap (GuessOfTheWeek)
      let self = this
      GuessHelper.getGuessOfTheWeek(this.topic).then((guessNumber) => {
        if (guessNumber !== 0) {
          self.guessIndex = guessNumber
          self.guess.id = self.guessIndex
          self.getGuess()
          self.getOptions()
          self.getOptionsProfits()
          self.generateEventUrl()
          self.getEventState()
        }
      }).catch(err => {
        console.log(err)
        return err
      })
    },
    voteGuess () { // Option has to be 1 or 2
      // let self = this
      this.$refs.paymentModal.hide()
      GuessHelper.voteGuess(this.guessIndex, this.optionVoted, this.ethAmountToVote).then(() => {
        console.log('Transaction pending...')
        this.showVoteAlert('voteAlert', 'success')
      }).catch(err => {
        console.log(err)
        this.showVoteAlert('voteAlert', 'error')
      })
    },
    getOptions () {
      let self = this

      GuessHelper.getGuessOptions(this.guessIndex).then((guessOptions) => {
        self.guess.option1 = guessOptions[0]
        self.guess.option2 = guessOptions[1]
        self.guess.option1votes = guessOptions[2].c[0]
        self.guess.option2votes = guessOptions[3].c[0]
        self.guess.votes = self.guess.option1votes + self.guess.option2votes
      })
    },
    getOptionsProfits () {
      let self = this

      GuessHelper.getGuessOptionsProfits(this.guessIndex).then((optionsAmount) => {
        self.guess.option1AmountEth = +(parseFloat(optionsAmount[0]) / 10).toFixed(4)
        self.guess.option2AmountEth = +(parseFloat(+optionsAmount[1]) / 10).toFixed(4)
        self.guess.amountEth = +(parseFloat(optionsAmount[0]) / 10 +
                                 parseFloat(optionsAmount[1]) / 10).toFixed(5)
      })
    }
  },

  created: function () {
    let self = this

    GuessHelper.init().then(() => {
      window.web3.eth.getBalance('0xe817dedf69b016cd321cfad479f272bf0cbad24d', function (error, result) {
        if (error) {
          console.log(error)
        } else {
          console.log(window.web3.utils.fromWei(result))
        }
      })

      GuessHelper.getAddressRefreshed().then((add) => {
        if (add === null ||
            add.length === 0) {
          self.showMetamask = true
          self.buttonsAllow = false
        } else {
          // Checking if the user is connected to the right network
          window.web3.eth.net.getId().then(netId => {
            switch (netId) {
              case 4:
                break
              default:
                self.showMetamask = true
            }
          })
        }
      })
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
