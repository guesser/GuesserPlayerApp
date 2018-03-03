<template>
  <div>
    <!--<full-page :options="options" style="z-index: 0;">-->

      <!--Page 1-->
      <div class="section" style="">
        <div class="explainer" style="">
          <b-container class="" style="padding-top: 10%">
            <b-row align-h="between" style="">
              <b-col lg="8" align-self="end" style="margin-right: 5%;">
                <h1>Can you predict the outcome</h1>
                <h1>of the internet's hottest events?</h1>
                <h2 style="color: gray;">Probe it</h2>
              </b-col>
              <b-col style="">
                <b-container style="padding: 2%; display: flex; justify-content: center;">
                  <img src="../assets/magic-ball2.svg"
                       style="width: 100%; max-width: 30vw;"/>
                </b-container>
              </b-col>
            </b-row>
          </b-container>
        </div>
      </div>

      <!--Page 2-->
      <div class="section" style="background-color: #FFFF03;">
        <div class="explainer">
          <b-container class="" style="text-align: center">
            <b-row align-h="between" style="">
              <b-container style="padding: 2% 2% 2% 0; display: flex; justify-content: center;">
                <img src="/static/guesserTrans.png"
                     style="width: 35%; max-width: 40vh;"/>
              </b-container>
            </b-row>
            <h1>What is Guesser ?</h1>
            <br>
            <h3>Guesser is the DApp where you can dare other members of the net
              and probe that you can predict the future.<br>
              Become an expert guesser, the most famous events creator or empower yourself between the validators community.
            </h3>
          </b-container>
        </div>
      </div>

      <!--Page 3-->
      <div class="section tipe2">
        <div class="explainer">
          <b-container class="show" style="min-width: 80%">
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
                    From: <b>{{guess.startingDay}}</b>
                    <br>
                    To: <b>{{guess.finishingDay}}</b>
                    </p>
                    <br>
                    <span>Number of votes in each option: </span>
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
                    <span>Eth amout in each option: </span>
                    <b-progress class="mt-1" :max="10*(guess.amountEth/10)" style="font-size: 0.5rem" show-value striped>
                      <b-progress-bar :value="10*(guess.option1AmountEth/10)" variant="pink">
                        {{guess.option1}} - {{ guess.option1AmountEth }}
                      </b-progress-bar>
                      <b-progress-bar :value="10*(guess.option2AmountEth/10)" variant="magenta">
                        {{guess.option2}} - {{ guess.option2AmountEth }}
                      </b-progress-bar>
                    </b-progress>
                    <small>Total: {{guess.amountEth}} ether</small>
                    <div style="margin-top: 5%">
                      <b-button style="margin-right: 20px" @click="showPaymentModal(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
                      <b-button @click="showPaymentModal(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
                    </div>
                  </b-card>

                </b-container>
              </b-col>
              <b-col lg="6" align-self="center" style="text-align: right;">
                <b-row class="justify-content-md-center">
                  <b-col lg="10" style="">
                    <h1>Create your</h1>
                    <h1>dreamed event</h1>
                    <br>
                    <h3 style="color: gray;">
                      Easy, fast and clean.<br>
                      Ask the question and let the network do the rest
                    </h3>
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
        </div>
      </div>

      <!--Page 4-->
      <div class="section" style="background-color: #FFFF03;">
        <div class="explainer">
          <div class="" style="padding: 10% 0 10% 0">
            <b-row align-h="between" style="text-align: center;">
              <b-col lg="5" align-self="center" style="">
                <h1 style="color: blue; font-weight: bold; font-size: 50px">Vote</h1>
                <br>
                <h4>
                  With your ether and your intuition you can guess the future<br>
                  Risk has good rewards
                </h4>
              </b-col>
              <b-col align-self="center" style="">
                <img src="../assets/plus.svg"
                     style="width: 50%; max-width: 80px; margin: 5% 0 5% 0"/>
              </b-col>
              <b-col lg="5" align-self="center" style="">
                <h1 style="color: blue; font-weight: bold; font-size: 50px">Validation</h1>
                <br>
                <h4>
                  You are player and judge<br>
                  If you play fair you can earn fancy rewards
                </h4>
              </b-col>
            </b-row>
          </div>
        </div>
      </div>

      <!--Page 5-->
      <div class="section">
        <div class="explainer">
          <b-container class="" style="text-align: center;">
            <h1>
              Welcome to Guesser <img src="../assets/beard.png"
              class="d-inline-block align-top" style="width: 50px;" alt="BV">
            </h1>
            <br>
            <h3 style="color: gray">
              Guesser is one of the first games built in the ethereum blockchain technology.<br>
              You can create, vote and validate events with ethereum cryptocurrency, secured by the inmutable blockchain tracking.
            </h3>
            <b-container style="padding: 2%; margin-top: 10%; display: flex; justify-content: center;">
              <b-button href="#home" variant="outline-primary lg" style="padding-bottom: 0;">
                <h1>Start Guessing!</h1>
              </b-button>
            </b-container>
            <b-row align-h="between" style="">
            </b-row>
          </b-container>
        </div>
      </div>
    <!--</full-page>-->
  </div>

  </div>
</template>

<script>
import FullPage from 'vue-fullpage.js'

export default {
  name: 'Landing',
  components: {
    FullPage
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
        id: '0',
        title: 'Will Elon Musk colonize mars?',
        description: 'He wants, could he do it?',
        topic: 'Humor',
        creator: '0x00000000000000000000000000000000',
        votes: 666,
        startingDay: 'The beginning of time',
        finishingDay: 'The end of time',
        option1: 'Fuck yeah',
        option2: 'Wi\'ll die before',
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
  background-image: url("/static/beardground.png");
}
/*.section {
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content:center;
}*/
</style>
