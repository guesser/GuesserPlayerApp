<template>
<div>
  <div v-if="totalEvents > 0">
    <span v-for="n in counter1">
      <b-card-group deck class="mb-3">
        <b-card
          v-for="j in counter2"
          :key="j"
          v-if="events[2*n + j]"
          style="width: 20rem; height: 100%;"
          :border-variant="events[2*n + j].topic"
          :header="events[2*n + j].title"
          :header-border-variant="events[2*n + j].topic"
          header-text-variant="black"
          align="center">
          <p class="card-text">
            Created at: <b>{{events[2*n + j].startingDay}}</b>
            <br>
            Voting open until: <b>{{events[2*n + j].finishingDay}}</b>
          </p>

  <br>
        <!--Number of people Progress Bar-->
        <span>Votes for each outcome: </span>
        <b-progress class="mt-1" :max="10*(events[2*n + j].votes/10)" show-value striped>
          <b-progress-bar :value="10*(events[2*n + j].option1votes/10)" variant="pink">
            {{events[2*n + j].option1}} - {{ events[2*n + j].option1votes }}
          </b-progress-bar>
          <b-progress-bar :value="10*(events[2*n + j].option2votes/10)" variant="magenta">
            {{events[2*n + j].option2}} - {{ events[2*n + j].option2votes }}
          </b-progress-bar>
        </b-progress>
        <small>Total: {{events[2*n + j].votes}} people</small>

        <!--Amount of eth in each option-->
        <br>
        <br>
        <span>Eth staked on each outcome: </span>
        <b-progress class="mt-1" :max="10*(events[2*n + j].amountEth/10)" show-value striped>
          <b-progress-bar :value="10*(events[2*n + j].option1AmountEth/10)" variant="pink">
            {{events[2*n + j].option1}} - {{ events[2*n + j].option1AmountEth }}
          </b-progress-bar>
          <b-progress-bar :value="10*(events[2*n + j].option2AmountEth/10)" variant="magenta">
            {{events[2*n + j].option2}} - {{ events[2*n + j].option2AmountEth }}
          </b-progress-bar>
        </b-progress>
        <small>Total: {{events[2*n + j].amountEth}} ether</small>

<br>
<br>

          <b-button style="margin-right: 20px" disabled
                    variant="outline-secondary" size="sm">
            {{events[2*n +j].option1}}
          </b-button>
          <b-button disabled variant="outline-secondary" size="sm">{{events[2*n +j].option2}}</b-button>
        </b-card>
      </b-card-group>
    </span>
    
  </div>
  <div v-else>
    <b-container class="" style="">
      <b-row align-h="between">
        <b-col align-self="center">
          <h3>Looks like there are no events you voted in process!</h3>
          <h5>Is not the best time to try one?</h5>
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

export default {
  name: 'CreatedGuesses',
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
            let month1 = parseInt(guess[5].getMonth()) + 1
            let month2 = parseInt(guess[6].getMonth()) + 1
            this.events.push({
              'id': _index,
              'title': guess[0],
              'description': guess[1],
              'topic': guess[2],
              'votes': guess[4],
              'startingDay': guess[5].getUTCDate() + '-' + month1 + '-' + guess[6].getFullYear(),
              'finishingDay': guess[6].getUTCDate() + '-' + month2 + '-' + guess[5].getFullYear(),
              'finishingDayUnformated': this.$moment(guess[6]),
              'option1': 'Loading...',
              'option2': 'Loading...',
              'option1votes': 'Loading...',
              'option2votes': 'Loading...'
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
        self.events[arrIndex].option1AmountEth = parseInt(optionsAmount[0]) / 10
        self.events[arrIndex].option2AmountEth = parseInt(optionsAmount[1]) / 10
        self.events[arrIndex].amountEth = parseInt(optionsAmount[0]) / 10 + parseInt(optionsAmount[1]) / 10
      })
    },

    getCreatedGuessesByAddress () {
      GuessHelper.getCreatedGuessesByAddress(0).then((_events) => {
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
      self.getCreatedGuessesByAddress()
    }).catch(err => {
      console.log(err)
    })
  }
}
</script>

<style>

</style>
