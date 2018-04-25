<template>
  <div>

    <!--Page 1-->
    <div class="section" style="">
      <div class="explainer" style="">
        <b-row class="maket" align-h="center">
          <b-container class="" style="padding-top: 10%">
            <b-row align-h="between" style="">
              <b-col lg="8" align-self="end" style="text-align: left; margin-right: 5%;">
                <h1 style="font-size: calc(1em + 2vw);">Can you predict the outcome</h1>
                <h1 style="font-size: calc(1em + 2vw);"> of the internet's hottest events?</h1>
                <h2 style="font-size: calc(1em + 1.5vw); color: gray;">Prove it</h2>
              </b-col>
              <b-col>
                <b-container class="maket" style="padding: 2%; text-align: center;">
                  <img src="../assets/magic-ball2.svg"
                       style="width: 100%; max-width: 30vw;"/>
                </b-container>
              </b-col>
            </b-row>
          </b-container>
        </b-row>
      </div>
    </div>

    <!--Page 2-->
    <div class="section" style="background-color: #FFFF03;">
      <div class="explainer">
        <b-row class="maket" align-h="center">
          <b-container class="" style="text-align: center">
            <b-row align-h="between" style="">
              <b-container style="padding: 2% 2% 2% 2%; display: flex; justify-content: center;">
                <img src="static/guesserTrans.png"
                     style="width: 35%; height: 100%; max-width: 40vh;"/>
              </b-container>
            </b-row>
            <h1 style="font-size: calc(1em + 2vw);">What is Guesser?</h1>
            <br>
            <h4 style="font-size: calc(1em + 0.5vw);">
              Guesser is a prediction game built on top of Ethereum where players stake money among each other based on what outcome they believe will happen at a given event.
              <br>
              Are you a true Guesser?
            </h4>
          </b-container>
        </b-row>
      </div>
    </div>

    <!--Page 3-->
    <div class="section">
      <div class="explainer">
        <b-row class="maket" align-h="center">
          <b-container style="text-align: center;">
            <b-row align-h="between" style="">
            </b-row>
            <h1 style="font-size: calc(1em + 2vw);">How can I <b>Win</b>?</h1>
            <h4 style="font-size: calc(1em + 0.5vw); padding-top: 5%; color: gray;">
              To make a guess at a popular internet event you only have to choose one of the two outcomes available and select how much <img src="../assets/ethereum.png" class="d-inline-block align-top" style="width: 25px;" alt="|eth|">Ether you are willing to lose if you’re wrong. Guessers that vote the right outcome will get all Ether staked on the event (after fees) distributed proportionally to how much they risked.
            </h4>
          </b-container>
        </b-row>
      </div>
    </div>

    <!--Page 4-->
    <div class="section tipe2" style='background-image: url("static/beardground.png");'>
      <div class="explainer">
        <b-row class="maket" align-h="center">
          <b-container class="show" style="min-width: 80%; padding: 2rem 0.1rem">
            <b-row align-h="between" style="">
              <b-col lg="6" style="padding: 5% 5%; margin-bottom: 10px">
                <!--Example Card-->
                <SingleCard :eventItem="guess" :buttonsAllow="false"/>
              </b-col>
              <b-col lg="6" align-self="center" style="text-align: right; padding: 0 30px">
                <b-row class="justify-content-md-center">
                  <b-col lg="10" style="">
                    <h1 style="font-size:calc(1em + 2vw);"><b>Create</b> an Event!</h1>
                    <br>
                    <h4 style="font-size:calc(1em + 0.5vw); color: gray;">
                      You believe an event will get traction amongst the Guesser community?<br>
                      <br>Create it,<br>choose the possible outcomes and catch players’ attention in order to get a % fee of all the money players send when voting for an outcome.
                    </h4>
                    <br>
                    <b-container style="padding: 2%; margin-top: 10%; display: flex; justify-content: center;">
                      <b-button href="#create" variant="primary" style="padding-bottom: 0;">
                        <h2>Start Now!</h2></b-button>
                    </b-container>
                  </b-col>
                </b-row>
              </b-col>
            </b-row>
          </b-container>
        </b-row>
      </div>
    </div>

    <!--Page 5-->
    <div class="section" style="background-color: #FFFF03;">
      <div class="explainer">
        <b-row class="maket" align-h="center">
          <b-container class="" style="text-align: center">
            <h1 style="color: #ff0d73; font-weight: bold; font-size:calc(1em + 3vw);">Validate</h1>
            <h1 style="font-size:calc(1em + 2vw);">Who says what really happened?</h1>
            <br>
            <h4 style="font-size:calc(1em + 0.5vw);">
              Guesser relies on validators staking tokens in order to achieve consensus on what was the true outcome of an event. Validators will be financially rewarded for telling the truth, and punished for lying about a certain result.
            </h4>
          </b-container>
        </b-row>
      </div>
    </div>

    <!--Page 6-->
    <div class="section">
      <div class="explainer">
        <b-row class="maket" align-h="center">
          <b-container class="maket" style="text-align: center;">
            <h1 style="font-size:calc(1em + 2vw); margin-top: 5%;">
              Trust the Beard <img src="../assets/beard.png" class="d-inline-block align-top" style="width: calc(20px + 2vw);" alt="BV">
            </h1>
            <br>
            <h3 style="font-size:calc(1em + 0.75vw); color: gray">
              Guesser is one of the first games built on Ethereum technology.
              <br>We believe in the potential of the blockchain to change the way people have fun predicting the future.
              <br>Harnessing the power of smart contracts, Guesser lets anyone create fun events where others can play freely without trusting any central authority to manage their funds or dictate the truth.
              <br>
              <br>The house can’t always win if there isn’t one in the first place!
            </h3>
            <b-container style="margin-top: 9%; display: flex; justify-content: center;">
              <b-button href="#home" variant="outline-primary lg" style="padding-bottom: 0;">
                <h1 style="font-size:calc(1em + 2vw);">Start Guessing!</h1>
              </b-button>
            </b-container>
          </b-container>
        </b-row>
      </div>
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
