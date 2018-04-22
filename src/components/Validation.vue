<template>
  <div class="wrapper">
    <b-row align-h="between" style="margin-bottom: 10px;">
      <b-col cols="8">
        <div v-if="totalGuesses != 0 || loadIndex != 0">
          <h2 style="font-size:calc(1em + 1vw);">Events to Validate:</h2>
        </div>
      </b-col>
      <b-col cols="4" align-self="center">
        <div v-if="(loadIndex == 0) || loadIndex != 0">
        <b-row align-v="center" align-h="center">
        <b-button-toolbar key-nav>
          <b-button @click="loadIndex--" variant="primary" class="nav-button">&laquo</b-button>
          <b-button @click="loadIndex++" variant="primary" class="nav-button">&raquo</b-button>
        </b-button-toolbar>
        </b-row>
        </div>
      </b-col>
    </b-row>

    <div v-if='!contentLoaded'>
      <Loading/>
    </div>

    <div v-if="totalGuesses > 0">
      <CardDeck :events="guesses"
         :mode='2'
         :maxCol='2'
         :descriptionAllow='true'
         :shareable='false'
         :headerBg='true'/>
    </div>

    <!--If no events-->
    <div v-else>
      <b-container class="" style="">
        <b-row align-h="between">
          <b-col>
            <b-container style="display: flex; justify-content: center; padding: 5%;">
              <b-col align-self="center">
                <h3 style="font-size:calc(1em + 1vw);">Looks there is no events to Validate right now</h3>
                <h3 style="font-size:calc(1em + 1vw);">Wait some time and try luck later!</h3>
              </b-col>
            </b-container>
          </b-col>
          <b-col lg="5" align-h="end">
            <img src="static/beard-hold.png" style="width: 70%;" alt=":'("/>
          </b-col>
        </b-row>
      </b-container>
    </div>

  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import NetworkHelper from '@/js/NetworkHelper'

import CardDeck from './Common/CardDeck.vue'
import Loading from './Loading.vue'

export default {
  name: 'guessesvalidation',
  components: {
    Loading,
    CardDeck
  },
  data () {
    return {
      guessesByNumber: [],
      totalGuesses: 0,
      guessIndex: null,
      guesses: [],
      contentLoaded: false,
      loadIndex: 0
    }
  },
  methods: {
    printGuesses () {
      for (var i = 0; i < this.guessesByNumber.length; i++) {
        console.log('Id:', this.guessesByNumber[i].c[0])
        let _index = this.guessesByNumber[i].c[0]
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            let guessTime = this.$moment(guess[5]).subtract(this.$moment(guess[5]).minute(), 'minutes')
            let _eventDuration = this.$moment(guess[6]).unix() - this.$moment(guess[5]).unix()
            if (guessTime.unix() < this.$moment().unix() &&
              guess[3] !== GuessHelper.address[0]) {
              this.guesses.push({
                'id': _index,
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
                'option1Validations': 0,
                'option2Validations': 0
              })
            }
          }).then(() => {
            this.totalGuesses += 1
            this.printGuessesOptions(_index, this.totalGuesses - 1)
            this.printEventState(_index, this.totalGuesses - 1)
          }).catch(err => {
            console.log(err)
          })
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
        self.guesses[_localIndex].option1 = guess[0]
        self.guesses[_localIndex].option2 = guess[1]
        self.guesses[_localIndex].option1Validations = guess[4].c[0]
        self.guesses[_localIndex].option2Validations = guess[5].c[0]
      }).catch(err => {
        console.log(err)
      })
    },
    getGuessesToValidate () {
      let self = this

      this.guesses = [] // Clean the array of showed Guesses
      GuessHelper.getGuessesToValidate(this.loadIndex, this.$moment().unix()).then((_guesses) => {
        self.guessesByNumber = _guesses
        // console.log(_guesses)
        self.printGuesses()
        self.contentLoaded = true
      }).catch(err => {
        console.log(err)
        self.contentLoaded = true
        return err
      })
    }
  },
  created: function () {
    let self = this
    GuessHelper.init().then(() => {
      this.getGuessesToValidate()
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
  beforeCreated: function () {
    this.contentLoaded = false
  },
  watch: {
    loadIndex: function () {
      this.totalGuesses = 0
      this.guessesByNumber = []
      this.guesses = []
      this.getGuessesToValidate()
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
.wrapper {
  margin: 0 15% 0 15%;
  padding: 0;
}
</style>
