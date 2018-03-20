<template>
  <div>
    <TopBar/>
    <main>
    <br>
    <notifications group="eventAlert"
                   position="bottom right"
                   :max="1"
                   width="350px"
                   :speed="1000">
      <template slot="body" slot-scope="props">
        <div class="vue-notification eventAlert">
          <h5>New Event has been created!</h5>
          <span>Event <a :href="newEventUrl">'{{newEventTitle}}'</a>
            <br>With id: #{{newEventId}} was created in {{newEventTopic}}</span>
        </div>
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
    showEventAlert () {
      // TODO: Catch the id and the topic of the event
      this.$notify({
        group: 'eventAlert'
      })
    }
  },
  beforeCreate: function () {
    let self = this
    GuessHelper.init().then(() => {
      GuessHelper.GuessCreated.watch(function (error, result) {
        if (!error) {
          self.newEventUrl = ''
          self.newEventId = result.args.index.c[0]
          self.newEventTitle = window.web3.utils.hexToUtf8(result.args.title)
          self.newEventTopic = window.web3.utils.hexToUtf8(result.args.topic)
          self.newEventUrl = self.shareUrl + self.newEventId

          if (self.newEventId !== self.lastEventId) {
            self.showEventAlert()
            // console.log(self.newEventTitle)
            // console.log(self.newEventTopic)
            // console.log(self.newEventId)
            self.lastEventId = self.newEventId
          }
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
  "guesser": #ff0d73
);

@import "~bootstrap/scss/bootstrap";

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

/*TOPIC STYLES*/
/*Colors*/
$crypto: #F29100;
$crypto-contrast: lighten(#F0D215, 25%);

$celebrities: #9D27B0;
$celebrities-contrast: lighten($celebrities, 40%);

$entertainment: #0086ED;
$entertainment-contrast: lighten($entertainment, 40%);

$gaming: #ED5565;
$gaming-contrast: #FFCE54;

$humor: #FF00FF;
$humor-contrast: #CCFF99;

$news: #384F5D;
$news-contrast: lighten($news, 40%);

$politics: #000000;
$politics-contrast: #DCEBEF;

$sports: #EBB400;
$sports-contrast: #FFFFFF;

$technology-contrast: #BCBCBC;
$technology: #000000;

$random-contrast: #D9414C;
$random: lighten(#FDDF6D, 10%);

/* == */

.bg-Crypto{
  background-color: $crypto-contrast !important;
  font-weight: bold;
  color: $crypto !important;
  border-color: $crypto !important;
}

.border-Crypto{
  border-color: $crypto !important;
}
.list-group-item-Crypto{
  background-color: $crypto-contrast !important;
  color: $crypto !important;
}

.list-group-item-Crypto:hover,
.list-group-item-Crypto:focus{
  background-color: darken($crypto-contrast, 5%) !important;
  color: darken($crypto, 5%) !important;
}

/* == */

.bg-Celebrities{
  background-color: $celebrities-contrast !important;
  font-weight: bold;
  color: $celebrities !important;
  border-color: $celebrities !important;
}

.border-Celebrities{
  border-color: $celebrities !important;
}

.list-group-item-Celebrities{
  color: $celebrities !important;
  background-color: $celebrities-contrast !important;
}

.list-group-item-Celebrities:hover,
.list-group-item-Celebrities:focus{
  background-color: darken($celebrities-contrast, 5%) !important;
  color: darken($celebrities, 5%) !important;
}

/* == */

.bg-Entertainment{
  background-color: $entertainment-contrast !important;
  font-weight: bold;
  color: $entertainment !important;
  border-color: $entertainment !important;
}

.border-Entertainment{
  border-color: $entertainment !important;
}

.list-group-item-Entertainment{
  color: $entertainment !important;
  background-color: $entertainment-contrast !important;
}

.list-group-item-Entertainment:hover,
.list-group-item-Entertainment:focus{
  background-color: darken($entertainment-contrast, 5%) !important;
  color: darken($entertainment, 5%) !important;
}

/* == */

.bg-Gaming{
  background-color: $gaming-contrast !important;
  font-weight: bold;
  color: $gaming !important;
  border-color: $gaming !important;
}

.border-Gaming{
  border-color: $gaming !important;
}

.list-group-item-Gaming{
  color: $gaming !important;
  background-color: $gaming-contrast !important;
}

.list-group-item-Gaming:hover,
.list-group-item-Gaming:focus{
  background-color: darken($gaming-contrast, 5%) !important;
  color: darken($gaming, 5%) !important;
}

/* == */

.bg-Humor{
  background-color: $humor-contrast !important;
  font-weight: bold;
  color: $humor !important;
  border-color: $humor !important;
}

.border-Humor{
  border-color: $humor !important;
}

.list-group-item-Humor{
  color: $humor !important;
  background-color: $humor-contrast !important;
}

.list-group-item-Humor:hover,
.list-group-item-Humor:focus{
  background-color: darken($humor-contrast, 5%) !important;
  color: darken($humor, 5%) !important;
}

/* == */

.bg-News{
  background-color: $news-contrast !important;
  font-weight: bold;
  color: $news !important;
  border-color: $news !important;
}

.border-News{
  border-color: $news !important;
}

.list-group-item-News{
  color: $news !important;
  background-color: $news-contrast !important;
}

.list-group-item-News:hover,
.list-group-item-News:focus{
  background-color: darken($news-contrast, 5%) !important;
  color: darken($news, 5%) !important;
}

/* == */

.bg-Politics{
  background-color: $politics-contrast !important;
  font-weight: bold;
  color: $politics !important;
  border-color: $politics !important;
}

.border-Politics{
  border-color: $politics !important;
}

.list-group-item-Politics{
  color: $politics !important;
  background-color: $politics-contrast !important;
}

.list-group-item-Politics:hover,
.list-group-item-Politics:focus{
  background-color: darken($politics-contrast, 5%) !important;
  color: darken($politics, 5%) !important;
}

/* == */

.bg-Sports{
  background-color: $sports-contrast !important;
  font-weight: bold;
  color: $sports !important;
  border-color: $sports !important;
}

.border-Sports{
  border-color: $sports !important;
}

.list-group-item-Sports{
  color: $sports !important;
  background-color: $sports-contrast !important;
}

.list-group-item-Sports:hover,
.list-group-item-Sports:focus{
  background-color: darken($sports-contrast, 5%) !important;
  color: darken($sports, 5%) !important;
}

/* == */

.bg-Technology{
  background-color: $technology-contrast !important;
  font-weight: bold;
  color: $technology !important;
  border-color: $technology !important;
}

.border-Technology{
  border-color: $technology !important;
}

.list-group-item-Technology{
  color: $technology !important;
  background-color: $technology-contrast !important;
}

.list-group-item-Technology:hover,
.list-group-item-Technology:focus{
  background-color: darken($technology-contrast, 5%) !important;
  color: darken($technology, 5%) !important;
}

/* == */

.bg-Random{
  background-color: $random-contrast !important;
  font-weight: bold;
  color: $random !important;
  border-color: $random !important;
}

.border-Random{
  border-color: $random !important;
}

.list-group-item-Random{
  color: $random !important;
  background-color: $random-contrast !important;
}

.list-group-item-Random:hover,
.list-group-item-Random:focus{
  background-color: darken($random-contrast, 5%) !important;
  color: darken($random, 5%) !important;
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
    margin: 5px;
    font-size: 1rem;
    border-radius: 2px;
    color: #8a6d3b; 
    background-color: #ffff03 !important;
    border: 2px solid #ffff03 !important;
}
</style>
