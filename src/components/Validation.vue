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

      <MetamaskAlert v-if='showMetamask'/>

      <!-- Events notifications -->
      <notifications group="validatedEventAlert"
                   position="bottom center"
                   :max="1"
                   width="320px"
                   :speed="1000">
      <template slot="body" slot-scope="props">
        <a :href="validatedEventUrl" style="text-decoration:none">
          <div class="vue-notification">
            <h5>Event validated!</h5>
            <span>Event #{{validatedEventId}}: '{{validatedEventTitle}}'
              <br>You have staked {{validatedEventValue}} eth to Outcome: {{validatedEventOutcomeName}}
            </span>
          </div>
        </a>
      </template>
    </notifications>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import GuessPaymentsHelper from '@/js/GuesserPaymentsHelper'
// import NetworkHelper from '@/js/NetworkHelper'

import CardDeck from './Common/CardDeck.vue'
import Loading from './Loading.vue'
import MetamaskAlert from './Common/MetamaskAlert.vue'

export default {
  name: 'guessesvalidation',
  components: {
    Loading,
    MetamaskAlert,
    CardDeck
  },
  data () {
    return {
      showMetamask: false,
      userGuesses: [],
      guessesByNumber: [],
      totalGuesses: 0,
      guessIndex: null,
      guesses: [],
      contentLoaded: false,
      loadIndex: 0,
      // Event data
      validatedEventId: 0,
      validatedEventTitle: '',
      validatedEventUrl: '',
      validatedEventValue: '',
      validatedEventOutcomeName: ''
    }
  },
  methods: {
    printGuesses () {
      this.guesses = []
      for (var i = 0; i < this.guessesByNumber.length; i++) {
        let _index = this.guessesByNumber[i].c[0]
        if (_index !== 0 && this.userGuesses.indexOf(_index) === -1) { // Guess 0 is the empty one
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
        self.printGuesses()
        self.contentLoaded = true
      }).catch(err => {
        console.log(err)
        self.contentLoaded = true
        return err
      })
    },
    getUserVotedGuesses (votedIndex) {
      let self = this

      let endFound = false
      let called = false
      GuessHelper.getValidatingGuessesByAddress(votedIndex).then((_events) => {
        for (var item in _events) {
          if (_events[item].c[0] !== 0) {
            if (self.userGuesses.indexOf(_events[item].c[0]) === -1) {
              self.userGuesses.push(_events[item].c[0])
            }
          } else {
            endFound = true
            if (called === false) {
              called = true
              // self.getGuessesToValidate()
            }
          }
        }
        if (endFound === false) {
          self.getUserVotedGuesses(votedIndex + 1)
        }
      })

      // The guesses the user has already validated
      // TODO: Uncomment this
      GuessHelper.getValidatedGuessesByAddress(votedIndex).then((_events) => {
        for (var item in _events) {
          if (_events[item].c[0] !== 0) {
            if (self.userGuesses.indexOf(_events[item].c[0]) === -1) {
              self.userGuesses.push(_events[item].c[0])
            }
          } else {
            endFound = true
            if (called === false) {
              called = true
              // self.getGuessesToValidate()
            }
          }
        }
        if (endFound === false) {
          self.getUserVotedGuesses(votedIndex + 1)
        }
      })
    },
    showEventAlert (_group) {
      // TODO: Catch the id and the topic of the event
      this.$notify({
        group: _group
      })
    }
  },
  created: function () {
    let self = this

    GuessHelper.init().then(() => {
      GuessHelper.getAddressRefreshed().then((add) => {
        if (add === null ||
            add.length === 0) {
          self.showMetamask = true
          self.getGuessesToValidate()
        } else {
          window.web3.eth.net.getId().then(netId => {
            switch (netId) {
              case 4:
                break
              default:
                self.showMetamask = true
                self.getGuessesToValidate()
            }
            this.getUserVotedGuesses(0)
          })
        }

        // Event watcher
        GuessPaymentsHelper.init(add).then(() => {
          GuessPaymentsHelper.GuessValidated.watch(function (error, result) {
            if (!error) {
              self.validatedEventUrl = ''
              self.validatedEventId = result.args.guess.c[0]
              self.validatedEventTitle = 'The option voted was: ' + result.args.option.c[8]
              self.validatedEventUrl = self.shareUrl + self.validatedEventId

              if (self.validatedEventId !== self.lastValidatedEventId) {
                self.showEventAlert('validatedEventAlert')
                self.lastValidatedEventId = self.validatedEventId
              }
            } else {
              return error
            }
          })
        })
      })
    }).catch(err => {
      console.log(err)
    })

    /*
    NetworkHelper.init().then(() => {
      if (NetworkHelper.state === 'disconnected' ||
        NetworkHelper.state === 'locked') {
        self.$router.push('signup')
      }
    })
    */
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
  padding-top: 20px;
}
</style>
