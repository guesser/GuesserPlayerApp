<template>
  <div>

    <!--Page 1-->
    <div class="section" style="">
      <div class="explainer" style="">
        <b-row class="maket" align-h="center">
          <b-container class="" style="padding-top: 2%;">
            <b-row align-h="between" style="">
              <b-col lg="10" align-self="end" style="text-align: left;">
                <h2 style="font-size: calc(1em + 1.0vw); color: black;">Hi there!</h2>
                <h2 style="font-size: calc(1em + 0.4vw); color: gray;">
                  Welcome to the <a href='https://guesser.org'>Guesser</a> Proof-of-Concept, an interface where you’ll be able to create bets and play at those created by others. Keep in mind that <b style="color:black">this is an outdated PoC version</b> live on the Rinkeby testnet, so you might face bugs or errors that aren’t fixed.
               <br/>
               <br/>
               We are currently focused on building the peer to peer betting protocol and incentive network anyone will be able to use to play, create bets, curate bets, or build a betting product on Ethereum.  

               <br/>
               <br/>
               In this demo, you’ll be able to <b style="color:black">create </b>bets, <b style="color:black">explore</b> new betting topics, and <b style="color:black">play</b> with faucet funds in bets created by other peers. 
                </h2>
               <br/>
               <br/>
                <b-button size="large" variant="primary">
                <a style="font-size: calc(1em + 1.0vw); color: white;" href='/#/play/Home'>Try Guesser.io</a>
                </b-button>
              </b-col>
            </b-row>
          </b-container>
        </b-row>
      </div>
    </div>
  </div>
</template>

<script>
import SingleCard from './Common/SingleCard.vue'

export default {
  name: 'Landing',
  components: {
    SingleCard
  },
  data () {
    return {
      options: {
        autoScrolling: false,
        scrollBar: false,
        fitToSection: true
      },
      topics: ['Crypto', 'Celebrities', 'Entertainment', 'Gaming', 'Humor', 'News', 'Politics', 'Sports', 'Technology', 'Random'],
      guess: {
        id: '314',
        title: 'Will SpaceX launch the BFR?',
        description: 'They want, but can they do it?',
        topic: 'Humor',
        creator: '0x00000000000000000000000000000000',
        votes: 666,
        startingDay: this.$moment().subtract(1, 'day').format('MMMM D, YYYY [at] H[h]'),
        finishingDay: this.$moment().add(4, 'day').add(4, 'hours').format('MMMM D, YYYY [at] H[h]'),
        eventDuration: '3 days',
        eventState: 'voting',
        option1: 'Fuck yeah',
        option2: 'We\'ll die before',
        option1votes: 0,
        option2votes: 0,
        option1AmountEth: 0,
        option2AmountEth: 0,
        amountEth: 0
      }
    }
  },
  created: function () {
    this.guess.option1votes = Math.floor((Math.random() * 350) + 100)
    this.guess.option2votes = this.guess.votes - this.guess.option1votes
    this.guess.option1AmountEth = Math.floor((Math.random() * 1000) + 400)
    this.guess.option2AmountEth = Math.floor((Math.random() * 1000) + 400)
    this.guess.amountEth = this.guess.option1AmountEth + this.guess.option2AmountEth
  }
}
</script>

<style scope lang="scss">

$primary: #ff0d73;


#header {
  color: $primary;
}
.explainer {
  padding: 8% 10% 8% 10%;
  width: 100%;
}
.show {
  padding: 5% 3% 5% 2%;
  background-color: white;
  border-radius: 5px;
}
.tipe2 {
  background-color: pink;
  /* background-image: url("/static/beardground.png"); */
}
.team-wrapper {
  margin-top: 20%;
  text-align: center;
}
.team-pictures {
  width: 100%;
  padding: 10px;
  border-radius: 50%;
  padding: 10px;
}
.team-cards {
  margin: 5% 0 5% 0;
  border: 1px solid $primary;
  border-radius: 5px;
}
/*.maket {
  background-color: #F333;
}*/
/*.section {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content:center;
}*/
</style>
