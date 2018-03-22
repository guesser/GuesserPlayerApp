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
            <h1 style="font-size: calc(1em + 2vw);">How can I <b>Play</b>?</h1>
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
              <b-col lg="6" style="padding: 0 1% 0 1%;">
                <b-container style="display: flex; justify-content: center; padding: 5%;">

                  <!--Example Card-->
                  <b-card :border-variant="guess.topic"
                             style="width: 100%; height: 100%;"
                             :header="guess.title"
                             :header-bg-variant="guess.topic"
                             header-text-variant="white"
                             class="text-center">
                    <p class="card-text">
                    {{guess.description}}
                    </p>   
                    <p class="card-text">
                    Created at: <b>{{guess.startingDay}}</b>
                    <br>
                    Open until: <b>{{guess.finishingDay}}</b>
                    </p>
                    <br>
                    <span>Votes for each outcome: </span>
                    <b-progress class="mt-1" :max="10*(guess.votes/10)" style="font-size: 0.5em" show-value striped>
                      <b-progress-bar :value="10*(guess.option1votes/10)" variant="pink">
                        {{guess.option1}} - {{ guess.option1votes }}
                      </b-progress-bar>
                      <b-progress-bar :value="10*(guess.option2votes/10)" variant="magenta">
                        {{guess.option2}} - {{ guess.option2votes }}
                      </b-progress-bar>
                    </b-progress>
                    <small>Total: {{guess.votes}} people</small>
                    <br>
                    <span>Eth staked on each outcome: </span>
                    <b-progress class="mt-1" :max="10*(guess.amountEth/10)" style="font-size: 0.5rem" show-value striped>
                      <b-progress-bar :value="10*(guess.option1AmountEth/10)" variant="pink">
                        {{guess.option1}} - {{ guess.option1AmountEth }}
                      </b-progress-bar>
                      <b-progress-bar :value="10*(guess.option2AmountEth/10)" variant="magenta">
                        {{guess.option2}} - {{ guess.option2AmountEth }}
                      </b-progress-bar>
                    </b-progress>
                    <small>Total: {{guess.amountEth}} ether</small>
                    <b-row align-h="end" align-v="end" style="color: #ff0d78">
                      <span>#{{guess.id}}</span>
                      <b-btn id="idCopy" variant="link" href="http://lmgtfy.com/?s=d&q=Where+are+the+lambos%3F" target="_blank" size="sm">
                        <img width="20px" src="../assets/shareicon.png"/>
                      </b-btn>
                    </b-row>
                    <b-button style="margin: 2px 20px" @click="showPaymentModal(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
                    <b-button style="margin: 2px 20px" @click="showPaymentModal(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
                  </b-card>

                </b-container>
              </b-col>
              <b-col lg="6" align-self="center" style="text-align: right;">
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

export default {
  name: 'Landing',
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
        title: 'Will SpaceX recover the fairing?',
        description: 'They want, but can they do it?',
        topic: 'Humor',
        creator: '0x00000000000000000000000000000000',
        votes: 666,
        startingDay: 'Mar, 3 2018 at 16h',
        finishingDay: 'Mar, 20 2018 at 12h',
        option1: 'Fuck yeah',
        option2: 'We\'ll die before',
        option1votes: '266',
        option2votes: '400',
        option1AmountEth: '42040',
        option2AmountEth: '27009',
        amountEth: 69049
      }
    }
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
