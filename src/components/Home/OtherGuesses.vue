<template>
  <div>
    <div v-if='contentLoaded'>
      <Loading/>
    </div>

    <!--Alert-->
    <b-alert variant="success"
             dismissible
             :show="guessVotingAlert"
             @dismissed="showVotingAlert=false">
      Hang in there... Guess being voted.
    </b-alert>
    <b-alert variant="danger"
             dismissible
             :show="guessVotingFailedAlert"
             @dismissed="showVotingFailedAlert=false">
      It seems the voting failed...
    </b-alert>
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


    <div v-if="totalGuesses != 0">
      <h2>Events you may like:</h2>
      <span v-for="n in counter1">
        <b-card-group deck class="mb-3">
          <b-card
                           v-for="j in counter2"
                           :key="j"
                           v-if="guesses[2*n + j]"
                           style="width: 20rem; height: 100%;"
                           :border-variant="topic"
                           :header="guesses[2*n + j].title"
                           :header-border-variant="topic"
                           header-text-variant="black"
                           align="center">
            <p class="card-text">
            Created at: <b>{{guesses[2*n + j].startingDay}}</b>
            <br>
            Voting open until: <b>{{guesses[2*n + j].finishingDay}}</b>
            </p>
            <b-row align-h="end">
              <b-btn id="idCopy" variant="link" size="sm"
                     @click="show('copyAlert')"
                     v-clipboard:copy="guesses[2*n +j].url">
                <img width="20px" src="../../assets/shareicon.png"/>
              </b-btn>
            </b-row>
            <b-button style="margin: 2px 20px"
                      @click="showPaymentModal(guesses[2*n + j].id, 1, 2*n +j)"
                      variant="outline-pink" size="sm">
              {{guesses[2*n +j].option1}}
            </b-button>
            <b-button style="margin: 2px 20px" @click="showPaymentModal(guesses[2*n + j].id, 2, 2*n + j)" variant="outline-magenta" size="sm">{{guesses[2*n +j].option2}}</b-button>
          </b-card>
        </b-card-group>
      </span>

      <!-- Modal Payment -->
      <div v-if='guesses.length > 0'>
        <b-modal ref="paymentModal"
                 centered
                 title="Vote an event"
                 hide-footer
                 :header-bg-variant="topic">
          <label>Title: {{guesses[arrayIndex].title}}</label>
          <br>

          <label>Description: {{guesses[arrayIndex].description}}</label>
          <br>

          <span>Votes for each outcome: </span>
          <b-progress class="mt-1" :max="10*(guesses[arrayIndex].votes/10)" show-value striped>
            <b-progress-bar :value="10*(guesses[arrayIndex].option1votes/10)" variant="pink">
              {{guesses[arrayIndex].option1}} - {{ guesses[arrayIndex].option1votes }}
            </b-progress-bar>
            <b-progress-bar :value="10*(guesses[arrayIndex].option2votes/10)" variant="magenta">
              {{guesses[arrayIndex].option2}} - {{ guesses[arrayIndex].option2votes }}
            </b-progress-bar>
          </b-progress>
          <small>Total: {{guesses[arrayIndex].votes}} people</small>
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

          <b-button @click="voteGuess()" variant="primary" size="sm">Vote</b-button>
        </b-modal>

      </div>
    </div>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import Loading from '../Loading.vue'

export default {
  name: 'otherguesses',
  components: {
    Loading
  },
  props: ['topic'],
  data () {
    return {
      contentLoaded: true,
      guessVotingAlert: false,
      guessVotingFailedAlert: false,
      arrayIndex: 0, // The selected guess to vote
      guesses: [],
      guessesByNumber: [],
      counter1: [0, 1, 2, 3, 4, 5],
      counter2: [0, 1],
      totalGuesses: 0,
      optionVoted: 0,
      guessToVote: 0,
      ethAmountToVote: 0
    }
  },
  methods: {
    show (group) {
      this.$notify({
        group
      })
    },
    showPaymentModal (_guessId, _optionVoted, _arrayIndex) {
      this.arrayIndex = _arrayIndex
      this.optionVoted = _optionVoted
      this.guessToVote = _guessId
      this.$refs.paymentModal.show()
    },
    printGuesses () {
      this.guesses = []
      for (var i = 0; i < this.guessesByNumber.length; i++) {
        let _index = this.guessesByNumber[i].c[0]
        let _url = 'www.guesser.io/#/search?_id=' + _index
        if (_index !== 0) { // Guess 0 is the empty one
          GuessHelper.getGuessFront(_index).then((guess) => {
            if (this.$moment(guess[6]).subtract(this.$moment(guess[6]).minute(), 'minutes').unix() > this.$moment().unix()) {
              this.guesses.push({
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
                'option2votes': 'Loading...'
              })
              this.printGuessesOptions(_index, this.totalGuesses)
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

    printGuessesOptions (_index, _localIndex) {
      let self = this
      GuessHelper.getGuessOptions(_index).then((guess) => {
        if (self.$moment(self.guesses[_localIndex].finishingDayUnformated) > self.$moment().add(0, 'hours')) {
          self.guesses[_localIndex].option1 = guess[0]
          self.guesses[_localIndex].option2 = guess[1]
          self.guesses[_localIndex].option1votes = guess[2].c[0]
          self.guesses[_localIndex].option2votes = guess[3].c[0]
        }
      }).catch(err => {
        console.log(err)
      })
    },

    getGuessesByDate () {
      let self = this
      var finished = 0
      for (var i = 0; i < 7; i++) {
        GuessHelper.getGuessesByDate(0, this.topic, this.$moment().add(i, 'days').unix()).then((_guesses) => {
          self.guessesByNumber = self.guessesByNumber.concat(_guesses)
          finished++
          if (finished === 7) {
            self.printGuesses()
            self.contentLoaded = false
          }
        }).catch(err => {
          finished++
          if (finished === 7) {
            self.printGuesses()
            self.contentLoaded = false
          }
          // console.log(err)
          return err
        })
      }
    },
    voteGuess () { // Option has to be 1 or 2
      // let self = this
      this.$refs.paymentModal.hide()
      GuessHelper.voteGuess(this.guessToVote, this.optionVoted, this.ethAmountToVote).then(() => {
        console.log('Transaction pending...')
        // TODO: Show alert of voting
        this.guessVotingAlert = true
      }).catch(err => {
        console.log(err)
        this.guessVotingFailedAlert = true
      })
    }
  },

  created: function () {
    GuessHelper.init().then(() => {
      this.getGuessesByDate()
      this.contentLoaded = true
    }).catch(err => {
      console.log(err)
      this.contentLoaded = true
    })
  },

  watch: {
    topic: function () {
      this.contentLoaded = true
      this.totalGuesses = 0
      this.guessesByNumber = []
      this.getGuessesByDate()
      this.guesses = []
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
