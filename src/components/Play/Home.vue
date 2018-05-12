<template>
  <div>
    <div v-if='contentLoaded'>
      <Loading/>
    </div>

    <b-row align-h="between" style="margin-bottom: 10px;">
      <b-col cols="8">
        <div v-if="totalGuesses != 0">
          <h2 style="font-size:calc(1em + 1vw);">The Best Events of the Week</h2>
        </div>
      </b-col>
    </b-row>

    <div v-if="totalGuesses != 0">
      <CardDeck :events="guesses"
         :maxCol="2"
         :headerBg="true"
         :descriptionAllow="true"/>
    </div>

    <!--If no events-->
    <div v-else>
      <div v-if="totalGuesses == 0 && !contentLoaded">
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
import CardDeck from '../Common/SpecialCards.vue'

export default {
  name: 'homepage',
  components: {
    Loading,
    CardDeck
  },
  data () {
    return {
      contentLoaded: true,
      guesses: [],
      guessesByNumber: [],
      totalGuesses: 0,
      topics: ['Crypto', 'Celebrities', 'Entertainment', 'Gaming', 'Humor', 'News', 'Politics', 'Sports', 'Technology', 'Random']
    }
  },
  methods: {
    printGuesses () {
      this.guesses = []
      for (var i = 0; i < this.guessesByNumber.length; i++) {
        let _index = this.guessesByNumber[i]

        if (_index !== 0) { // 0 is empy, Highlighted is already shown
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
              this.contentLoaded = false
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

    getStarGuesses () {
      let self = this
      var _topics = 0

      for (var i = 0; i < this.topics.length; i++) {
        GuessHelper.getGuessOfTheWeek(this.topics[i]).then((_guessId) => {
          if (_guessId !== 0) {
            self.guessesByNumber.push(_guessId)
          }
          _topics += 1
          // console.log('Topicin:', _topics)
          if (_topics === 7) {
            self.printGuesses()
            self.contentLoaded = false
          }
        }).catch(err => {
          _topics += 1
          if (_topics === 7) {
            self.printGuesses()
          }
          // console.log(err)
          self.contentLoaded = false
          return err
        })
      }
    }
  },
  mounted: function () {
    GuessHelper.init().then(() => {
      this.contentLoaded = true
      this.getStarGuesses()
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
      this.getStarGuesses()
    },
    loadIndex: function () {
      this.totalGuesses = 0
      this.guessesByNumber = []
      this.guesses = []
      this.getStarGuesses()
    }
  }
}
</script>
<style>
<style>
