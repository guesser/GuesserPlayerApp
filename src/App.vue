<template>
  <div>
    <TopBar/>
    <main>
    <br>
    <!--Alerts-->
    <notifications group="eventAlert"
                   position="bottom right"
                   :max="1"
                   width="300px"
                   :speed="1000">
    <template slot="body" slot-scope="props">
      <a :href="newEventUrl" style="text-decoration:none">
        <div class="vue-notification eventAlert">
          <h5>New Event has been created!</h5>
          <span>Event <a :href="newEventUrl">'{{newEventTitle}}'</a>
            <br>With id: #{{newEventId}} was created in {{newEventTopic}}</span>
        </div>
      </a>
    </template>
    </notifications>
    <notifications group="votedEventAlert"
                   position="bottom center"
                   :max="1"
                   width="320px"
                   :speed="1000">
    <template slot="body" slot-scope="props">
      <a :href="votedEventUrl" style="text-decoration:none">
        <div class="vue-notification votedAlert">
          <h5>Event Voted!</h5>
          <span>Event #{{votedEventId}}: '{{votedEventTitle}}'
            <br>You have staked {{votedEventValue}} eth to Outcome: {{votedEventOutcomeName}}
          </span>
        </div>
      </a>
    </template>
    </notifications>

    <router-view></router-view>
    </main>

    <footer>
    </footer>

  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

// Vue components
import TopBar from './components/Header.vue'

export default {
  name: 'app',
  components: {
    TopBar
  },
  data () {
    return {
      newEventId: '',
      newEventTitle: '',
      newEventTopic: '',
      newEventUrl: '',
      lastEventId: 0,
      votedEventId: '',
      votedEventTitle: '',
      votedEventOptionName: '',
      votedEventValue: '',
      votedEventUrl: '',
      lastVotedEventId: '',
      shareUrl: '#/search?_id='
    }
  },
  methods: {
    changeView (view) {
      this.$router.push('/' + view)
    },
    countDownChanged (dismissCountDown) {
      this.dismissCountDown = dismissCountDown
    },
    showAlert () {
      this.dismissCountDown = this.dismissSecs
    },
    showEventAlert (_group) {
      // TODO: Catch the id and the topic of the event
      this.$notify({
        group: _group
      })
    }
  },
  beforeCreate: function () {
    let self = this
    GuessHelper.init().then(() => {
      // Getting the events ready
      GuessHelper.GuessCreated.watch(function (error, result) {
        if (!error) {
          self.newEventUrl = ''
          self.newEventId = result.args.index.c[0]
          self.newEventTitle = result.args.title
          self.newEventTopic = window.web3.utils.hexToUtf8(result.args.topic)
          self.newEventUrl = self.shareUrl + self.newEventId

          if (self.newEventId !== self.lastEventId) {
            self.showEventAlert('eventAlert')
            self.lastEventId = self.newEventId
          }
        } else {
          console.log(error)
        }
      })

      GuessHelper.GuessVoted.watch(function (error, result) {
        if (!error) {
          if (GuessHelper.address[0].toUpperCase() === result.args.user.toUpperCase()) {
            self.votedEventId = result.args.index.c[0]
            self.votedEventTitle = result.args.title
            self.votedEventOutcomeName = result.args.optionName
            self.votedEventValue = result.args.value.c[0] / 10000
            self.votedEventUrl = self.shareUrl + self.votedEventId

            if (self.votedEventId !== self.lastVotedEventId) {
              self.showEventAlert('votedEventAlert')
              self.lastVotedEventId = self.votedEventId
            }
          }
        } else {
          console.log(error)
        }
      })

      GuessHelper.TestValue.watch(function (error, result) {
        if (!error) {
          console.log('Test Value:', result)
        } else {
          console.log(error)
        }
      })
    }).catch(err => {
      console.log(err)
    })
  }
}
</script>

<style lang="scss">

$primary: #ff0d73;

/*Here we can create any color that we want*/
$theme-colors: (
"pink": lighten(magenta, 20%),
"magenta": lighten(blue, 20%),
"success": lighten(green, 20%),
"guesser": #ff0d73,
"crypto": #F29100,
"crypto-contrast": lighten(#F0D215, 25%),
"celebrities": #9D27B0,
"celebrities-contrast": lighten(#9D27B0, 40%),
"entertainment": #0086ED,
"entertainment-contrast": lighten(#0086ED, 40%),
"gaming": #ED5565,
"gaming-contrast": #FFCE54,
"humor": #FF00FF,
"humor-contrast": #CCFF99,
"news": #384F5D,
"news-contrast": lighten(#384F5D, 40%),
"politics": #000000,
"politics-contrast": #DCEBEF,
"sports": #EBB400,
"sports-contrast": #FFFFFF,
"technology-contrast": #BCBCBC,
"technology": #000000,
"random-contrast": #D9414C,
"random": lighten(#FDDF6D, 10%),
);

@import "~bootstrap/scss/bootstrap";
@import "./css/TopicStyles";

body{
  font-family: 'Josefin Sans', sans-serif;
  height: 100%;
}
main{
  height:100vh;
  min-height: 100vh;
  bottom:0;
}

@include media-breakpoint-down(sm) {
  .toplist{
    display: none !important;
  }
}

h5{
  font-size: 1.4em;
}  .navbar-brand {
  margin-right: 0;
}
main{
  background: rgba(250, 250, 250, 0.6);
}
.copyAlert{
  display: flex;
  flex-direction: row;
  flex-wrap: nowrap;
  text-align: left;
  font-size: 1rem;
  text-align: center;
  margin: 5px;
  margin-top: 0;
  align-items: center;
  justify-content: center;
  background-color: darken(gray, 40);
  color: white;
  border: 0;
  border-radius: 3px;

  .copyAlert-content {
    padding: 5px;
    flex: 1 0 auto;
  }
}
.eventAlert{
  margin: 5px !important;
  font-size: 0.8rem;
  border-radius: 2px !important;
  color: #8a6d3b !important;
  background-color: #ffffc3 !important;
  border: 2px solid #E88E0C !important;
}
.votedAlert{
  margin: 5px !important;
  font-size: 0.8rem;
  border-radius: 2px !important;
  color: #ffffff !important;
  background-color: #0DAAFF !important;
  border: 2px solid #6C87E8 !important;
}
</style>
