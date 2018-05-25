<template>
  <div style="padding: 20px; margin-bottom: 200px">
    <!--Alert-->
    <MetamaskAlert v-if='showMetamask'/>
    <notifications group="voteAlert"
                   position="top center"
                   classes="vue-notification voteAlert"
                   :max="2"
                   width="320px"
                   :speed="800"/>

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

    <div class='topics'>
      <TopicList/>
    </div>
    <div class='guesses'>
      <div v-if="topic == 'Home'">
        <HomePage/>
      </div>
      <div v-else>
        <h2 style="font-size:calc(1em + 2vw);">The <b>{{topic}}</b> event of the week!</h2>
        <GuessOfTheDay :topic="topic"/>
        <br>
        <OtherGuesses :topic="topic"/>
      </div>
    </div>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import TopicList from './Play/TopicList.vue'
import GuessOfTheDay from './Play/GuessOfTheDay.vue'
import OtherGuesses from './Play/OtherGuesses.vue'
import HomePage from './Play/Home.vue'
import MetamaskAlert from './Common/MetamaskAlert.vue'
// import NetworkHelper from '@/js/NetworkHelper'

export default {
  name: 'play',
  components: {
    TopicList,
    HomePage,
    MetamaskAlert,
    GuessOfTheDay,
    OtherGuesses
  },
  data () {
    return {
      topic: '',
      showMetamask: false
    }
  },
  watch: {
    '$route': function () {
      this.topic = this.$route.params.topic
    }
  },

  created: function () {
    let self = this

    if (this.$route.params.topic) {
      this.topic = this.$route.params.topic
    } else {
      this.topic = 'Home'
    }

    GuessHelper.init().then(() => {
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
    }).catch(err => {
      console.log(err)
    })
    // Uncomment if login enabled
    /*
    NetworkHelper.init().then(() => {
      if (NetworkHelper.state === 'disconnected' ||
          NetworkHelper.state === 'locked') {
        self.$router.push('signup')
      }
    })
     */
  }
}
</script>

<style>
.topics{
  width: 20%;
  float: left;
  padding-right: 10px;
  padding-left: 1.5%;
  position: -webkit-sticky;
  position: sticky;
  top: 5px;
}
.guesses{
  width: 60%;
  min-width: 220px;
  margin-left: 25%;
  position: relative;
}

@media screen and (max-width: 600px) {
  .topics {
  }
  .guesses {
    margin-left:20%;
    width: 77%;
  }
}

.pink{
  background-color: pink;
}
.container{
  margin:0;
  padding:0;
}
.voteAlert {
  margin: 5px;
  font-size: 0.7rem;
  border-radius: 2px;
  border-left: 0px !important;
}
</style>
