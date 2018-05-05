<template>
  <div>
    <b-row align-h="between" style="margin: -10px 0 10px 0;">
      <b-col align-self="center">
        <div v-if="(totalEvents != 0 && loadIndex == 0) || loadIndex != 0">
          <b-row align-v="center" align-h="center">
            <b-button-toolbar key-nav>
              <b-button @click="loadIndex--" variant="primary" class="nav-button">&laquo</b-button>
              <b-button @click="loadIndex++" variant="primary" class="nav-button">&raquo</b-button>
            </b-button-toolbar>
          </b-row>
        </div>
      </b-col>
    </b-row>

    <div v-if="totalEvents > 0">
      <CardDeck :events="events"
         :peopleBar="true"
         :ethBar="true"
         :buttonsAllow="false"/>
    </div>
    <div v-else>
      <b-container class="" style="">
        <b-row align-h="between">
          <b-col align-self="center">
            <span v-if="loadIndex == 0">
              <h3>Looks like you haven't participated in any finished event!</h3>
            </span>
            <span v-else>
              <h3>Looks like you haven't participated in more finished events!</h3>
            </span>
            <h5>You could start guessing now</h5>
            <br>
            <b-button href="#home" variant="primary" size="lg">Guess events</b-button>
          </b-col>
          <b-col>
            <img src="static/beard-hold.png" style="width: 60%;" alt=":'("/>
          </b-col>
        </b-row>
        <b-row>
        </b-row>
      </b-container>

    </div>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import CardDeck from '../Common/CardDeck.vue'

export default {
  name: 'PastGuesses',
  components: {
    CardDeck
  },
  data () {
    return {
      counter1: [0, 1, 2, 3, 4, 5],
      counter2: [0, 1],
      currentEvents: [],
      events: [],
      totalEvents: 0,
      loadIndex: 0
    }
  },
  methods: {
    printEvents () {
      for (var i in this.currentEvents) {
        let _index = this.currentEvents[i].c[0]
        console.log('Id:', _index)
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            let _url = 'www.guesser.io/#/search?_id=' + _index
            this.events.push({
              'id': _index,
              'url': _url,
              'title': guess[0],
              'description': guess[1],
              'topic': guess[2],
              'votes': 0,
              'startingDay': this.$moment(guess[4]).format('MMMM D, YYYY [at] H[h]'),
              'finishingDay': this.$moment(guess[5]).format('MMMM D, YYYY [at] H[h]'),
              'finishingDayUnformated': this.$moment(guess[5]),
              'eventState': '',
              'option1': 'Loading...',
              'option2': 'Loading...',
              'option1votes': 'Loading...',
              'option2votes': 'Loading...',
              'option1AmountEth': 'loading...',
              'option2AmountEth': 'loading...',
              'amountEth': 'Loading...'
            })
            this.printEventsOptions(_index, this.totalEvents)
            this.getOptionsProfits(_index, this.totalEvents)
            this.printEventState(_index, this.totalEvents)
            this.totalEvents++
          }).catch((err) => {
            return err
          })
        }
      }
    },

    printEventState (_index, _localIndex) {
      let self = this

      GuessHelper.getEventItemState(_index).then((eventItemState) => {
        self.events[_localIndex].eventState = eventItemState
      }).catch(err => {
        console.log(err)
      })
    },

    printEventsOptions (eventIndex, arrIndex) {
      let self = this
      GuessHelper.getGuessOptions(eventIndex).then((event) => {
        self.events[arrIndex].option1 = event[0]
        self.events[arrIndex].option2 = event[1]
        self.events[arrIndex].option1votes = event[2].c[0]
        self.events[arrIndex].option2votes = event[3].c[0]
        self.events[arrIndex].votes = event[3].c[0] + event[2].c[0]
      }).catch(err => {
        console.log(err)
      })
    },

    getOptionsProfits (eventIndex, arrIndex) {
      let self = this

      GuessHelper.getGuessOptionsProfits(eventIndex).then((optionsAmount) => {
        self.events[arrIndex].option1AmountEth = +(parseFloat(optionsAmount[0]) / 10).toFixed(4)
        self.events[arrIndex].option2AmountEth = +(parseFloat(optionsAmount[1]) / 10).toFixed(4)
        self.events[arrIndex].amountEth = +(parseFloat(optionsAmount[0]) / 10 +
                                            parseFloat(optionsAmount[1]) / 10).toFixed(4)
      })
    },

    getPastGuessesByAddress () {
      GuessHelper.getPastGuessesByAddress(this.loadIndex).then((_events) => {
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
      self.getPastGuessesByAddress()
    }).catch(err => {
      console.log(err)
    })
  },
  watch: {
    loadIndex: function () {
      this.totalEvents = 0
      this.currentEvents = []
      this.events = []
      this.getPastGuessesByAddress()
    }
  }
}
</script>

<style>

</style>
