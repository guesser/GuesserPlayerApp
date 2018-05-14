<template>
  <div>
    <div v-if='contentLoaded'>
      <Loading/>
    </div>

    <b-row align-h="between" style="margin-bottom: 10px;">
      <b-col cols="8">
        <div v-if="totalGuesses != 0 || loadIndex != 0">
          <h2 style="font-size:calc(1em + 1vw);">Events you may like:</h2>
        </div>
      </b-col>
      <b-col cols="4" align-self="center">
        <div v-if="(totalGuesses != 0 && loadIndex == 0) || loadIndex != 0">
        <b-row align-v="center" align-h="center">
        <b-button-toolbar key-nav>
          <b-button @click="loadIndex--" variant="primary" class="nav-button">&laquo</b-button>
          <b-button @click="loadIndex++" variant="primary" class="nav-button">&raquo</b-button>
        </b-button-toolbar>
        </b-row>
        </div>
      </b-col>
    </b-row>

    <div v-if="totalGuesses != 0">
      <CardDeck :events="guesses"
         :peopleBar="false"
         :ethBar="false"/>
    </div>

    <!--If no events-->
    <div v-else>
      <div v-if="loadIndex != 0 && contentLoaded == false">
      <b-container class="" style="">
        <b-row align-h="between">
          <b-col>
          <b-container style="display: flex; justify-content: center; padding: 5%;">
            <b-col align-self="center">
              <h3 style="font-size:calc(1em + 1vw);">Looks like today there are no more events for this topic!</h3>
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

  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import Loading from '../Loading.vue'
import CardDeck from '../Common/CardDeck.vue'

export default {
  name: 'otherguesses',
  components: {
    Loading,
    CardDeck
  },
  props: ['topic'],
  data () {
    return {
      contentLoaded: true,
      guesses: [],
      guessesByNumber: [],
      totalGuesses: 0,
      loadIndex: 0,
      guessStar: 0
    }
  },
  methods: {
    printGuesses () {
      this.guesses = []
      console.log(this.guessesByNumber)
      for (var i = 0; i < this.guessesByNumber.length; i++) {
        let _index = this.guessesByNumber[i].c[0]

        if (_index !== 0 && _index !== this.guessStar) { // 0 is empy, Highlighted is already shown
          GuessHelper.getGuessFront(_index).then((guess) => {
            if (this.$moment(guess[5]).subtract(this.$moment(guess[5]).minute(), 'minutes').unix() > this.$moment().unix()) {
              let _url = 'www.guesser.io/#/event/' + _index
              let _eventDuration = this.$moment(guess[6]).unix() - this.$moment(guess[5]).unix()
              this.guesses.push({
                'id': _index,
                'url': _url,
                'title': guess[0],
                'description': guess[1],
                'topic': guess[2],
                'votes': 0,
                'startingDay': this.$moment(guess[4]).format('MMMM D, YYYY [at] H[h]'),
                'finishingDay': this.$moment(guess[5]).format('MMMM D, YYYY [at] H[h]'),
                'finishingDayUnformated': this.$moment(guess[5]),
                'eventDuration': this.$moment.duration(_eventDuration, 'seconds').humanize(),
                'eventState': '',
                'option1': 'Loading...',
                'option2': 'Loading...',
                'option1votes': 'Loading...',
                'option2votes': 'Loading...',
                'option1amounteth': 'loading...',
                'option2amounteth': 'loading...',
                'amountEth': 'Loading...'
              })
              this.printGuessesOptions(_index, this.totalGuesses)
              this.printOptionsProfits(_index, this.totalGuesses)
              this.printEventState(_index, this.totalGuesses)
              this.totalGuesses += 1
            }
          }).catch(err => {
            console.log(err)
            this.contentLoaded = false
          })
        } else {
          this.contentLoaded = false
        }
      }
    },

    printEventState (_index, _localIndex) {
      let self = this

      GuessHelper.getEventItemState(_index).then((eventItemState) => {
        self.guesses[_localIndex].eventState = eventItemState
      }).catch(err => {
        console.log(err)
      })
    },

    printGuessesOptions (_index, _localIndex) {
      let self = this
      GuessHelper.getGuessOptions(_index).then((guess) => {
        if (self.$moment(self.guesses[_localIndex].finishingDayUnformated) > self.$moment().add(0, 'hours')) {
          self.guesses[_localIndex].option1 = guess[0]
          self.guesses[_localIndex].option2 = guess[1]
          self.guesses[_localIndex].option1votes = guess[2].c[0]
          self.guesses[_localIndex].option2votes = guess[3].c[0]
          self.guesses[_localIndex].votes = guess[2].c[0] + guess[3].c[0]
        }
        self.contentLoaded = false
      }).catch(err => {
        console.log(err)
      })
    },

    printOptionsProfits (_index, _localIndex) {
      let self = this

      GuessHelper.getGuessOptionsProfits(_index).then((guess) => {
        if (self.$moment(self.guesses[_localIndex].finishingDayUnformated) > self.$moment().add(0, 'hours')) {
          self.guesses[_localIndex].option1AmountEth = +(parseFloat(guess[0]) / 10).toFixed(4)
          self.guesses[_localIndex].option2AmountEth = +(parseFloat(guess[1]) / 10).toFixed(4)
          self.guesses[_localIndex].amountEth = +(parseFloat(guess[0]) / 10 +
                                                  parseFloat(guess[1]) / 10).toFixed(4)
        }
      })
    },

    getGuessStar () {
      let self = this

      GuessHelper.getGuessOfTheWeek(this.topic).then((_guessId) => {
        if (_guessId !== 0) {
          self.guessStar = _guessId
        }
      }).catch(err => {
        // console.log(err)
        return err
      })
    },

    getGuessesByWeek () {
      let self = this

      self.getGuessStar()
      GuessHelper.getGuessesByWeek(this.loadIndex, this.topic, this.$moment().unix()).then((_guesses) => {
        self.guessesByNumber = _guesses
        self.printGuesses()
        self.contentLoaded = false
      }).catch(err => {
        // console.log(err)
        self.contentLoaded = false
        return err
      })
    }
  },

  created: function () {
    GuessHelper.init().then(() => {
      this.getGuessesByWeek()
      this.contentLoaded = true
    }).catch(err => {
      // console.log(err)
      this.contentLoaded = true
      return err
    })
  },

  watch: {
    topic: function () {
      this.contentLoaded = true
      this.totalGuesses = 0
      this.loadIndex = 0
      this.guessesByNumber = []
      this.guesses = []
      this.getGuessesByWeek()
    },
    loadIndex: function () {
      this.totalGuesses = 0
      this.guessesByNumber = []
      this.guesses = []
      this.getGuessesByWeek()
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
</style>
