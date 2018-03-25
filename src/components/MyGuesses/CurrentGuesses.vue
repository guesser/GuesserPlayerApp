<template>
  <div>
    <div v-if="totalEvents > 0">
      <CardDeck :events="events"
         :peopleBar="true"
         :ethBar="true"
         :votationAllow="false"/>
    </div>
    <div v-else>
      <b-container class="" style="">
        <b-row align-h="between">
          <b-col align-self="center">
            <h3>Looks like you haven't participated in any current event yet!</h3>
            <h5>Feel like taking a guess?</h5>
          </b-col>
          <b-col>
            <img src="static/beard-hold.png" style="width: 70%;" alt=":'("/>         
          </b-col>
        </b-row>
        <b-row>
          <b-button href="#home" variant="primary" size="lg">Guess events</b-button>
        </b-row>    
      </b-container>

    </div>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import CardDeck from '../Common/CardDeck.vue'

export default {
  name: 'ActualGuesses',
  components: {
    CardDeck
  },
  data () {
    return {
      counter1: [0, 1, 2, 3, 4, 5],
      counter2: [0, 1],
      currentEvents: [],
      events: [],
      totalEvents: 0
    }
  },
  methods: {
    printEvents () {
      for (var i in this.currentEvents) {
        let _index = this.currentEvents[i].c[0]
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            let _url = 'www.guesser.io/#/search?_id=' + _index
            this.events.push({
              'id': _index,
              'url': _url,
              'title': guess[0],
              'description': guess[1],
              'topic': guess[2],
              'votes': guess[4],
              'startingDay': this.$moment(guess[5]).format('MMMM D, YYYY [at] H[h]'),
              'finishingDay': this.$moment(guess[6]).format('MMMM D, YYYY [at] H[h]'),
              'finishingDayUnformated': this.$moment(guess[6]),
              'option1': 'Loading...',
              'option2': 'Loading...',
              'option1votes': 'Loading...',
              'option2votes': 'Loading...',
              'option1amounteth': 'loading...',
              'option2amounteth': 'loading...',
              'amountEth': 'Loading...'
            })
            this.printEventsOptions(_index, this.totalEvents)
            this.getOptionsProfits(_index, this.totalEvents)
            this.totalEvents++
          }).catch((err) => {
            return err
          })
        }
      }
    },

    printEventsOptions (eventIndex, arrIndex) {
      let self = this
      GuessHelper.getGuessOptions(eventIndex).then((event) => {
        self.events[arrIndex].option1 = event[0]
        self.events[arrIndex].option2 = event[1]
        self.events[arrIndex].option1votes = event[2].c[0]
        self.events[arrIndex].option2votes = event[3].c[0]
      }).catch(err => {
        console.log(err)
      })
    },

    getOptionsProfits (eventIndex, arrIndex) {
      let self = this

      GuessHelper.getGuessOptionsProfits(eventIndex).then((optionsAmount) => {
        self.events[arrIndex].option1AmountEth = parseFloat(optionsAmount[0]) / 10
        self.events[arrIndex].option2AmountEth = parseFloat(optionsAmount[1]) / 10
        self.events[arrIndex].amountEth = parseFloat(optionsAmount[0]) / 10 + parseFloat(optionsAmount[1]) / 10
      })
    },

    getCurrentGuessesByAddress () {
      GuessHelper.getCurrentGuessesByAddress(0).then((_events) => {
        this.currentEvents = _events
        this.printEvents()
      }).catch((err) => {
        return err
      })
    }
  },
  beforeCreate: function () {
    let self = this
    GuessHelper.init().then(() => {
      self.getCurrentGuessesByAddress()
    }).catch(err => {
      console.log(err)
    })
  }
}
</script>

<style>

</style>
