<template>
  <div>
    <full-page :options="options" style="z-index: -1;">

      <!--Page 1-->
      <div class="section">
        <div class="explainer">
          <b-container class="" style="background-color: #F111">
            <b-row align-h="between" style="">
              <b-col lg="8" align-self="center" style="margin-right: 5%;">
                <h1>Can you predict the outcome</h1>
                <h1>of the internet's hottest events?</h1>
              </b-col>
              <b-col style="background-color: #F234;">
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
          <b-container class="" style="text-align: center; background-color: #F111">
            <b-row align-h="between" style="">
                <b-container style="padding: 2% 2% 2% 0; display: flex; justify-content: center;">
                  <img src="../assets/guesserTrans.png"
                       style="width: 35%; max-width: 30vw;"/>
                </b-container>
            </b-row>
            <h1>What is Guesser ?</h1>
            <br>
            <h3>Bla bla bla bla bla bla</h3>
            <h3>Bla bla Bla bla bla bla bla bla</h3>
            <h3>Bla bla bla bla bla bla</h3>
          </b-container>
        </div>
      </div>

      <!--Page 3-->
      <div class="section tipe2">
        <div class="explainer">
          <b-card class="show">
            <b-row align-h="between" style="">
              <b-col lg="6" style="">
                <b-container style="display: flex; justify-content: center;">

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
                    <span>Number of votes in each option: </span>
                    <b-progress class="mt-1" :max="10*(guess.votes/10)" show-value striped>
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
                    <b-progress class="mt-1" :max="10*(guess.amountEth/10)" show-value striped>
                      <b-progress-bar :value="10*(guess.option1AmountEth/10)" variant="pink">
                        {{guess.option1}} - {{ guess.option1AmountEth }}
                      </b-progress-bar>
                      <b-progress-bar :value="10*(guess.option2AmountEth/10)" variant="magenta">
                        {{guess.option2}} - {{ guess.option2AmountEth }}
                      </b-progress-bar>
                    </b-progress>
                    <small>Total: {{guess.amountEth}} ether</small>
                    <br>
                    <br>
                    <b-button style="margin-right: 20px" @click="showPaymentModal(1)" variant="outline-pink" size="sm">{{guess.option1}}</b-button>
                    <b-button @click="showPaymentModal(2)" variant="outline-magenta" size="sm">{{guess.option2}}</b-button>
                  </b-card>

                </b-container>
              </b-col>
              <b-col lg="6" align-self="center" style="text-align: center; background-color: #F323;">
                <h1>Create your dreamed event</h1>
                <h4>Bla bla bla bla bla bla bla</h4>
                <h4>Bla bla bla bla bla bla</h4>
                <h4>Bla bla bla bla bla bla bla</h4>
                <br>
                <br>
                <br>
                <b-container style="padding: 2%; display: flex; justify-content: center;">
                  <b-button href="#create" variant="primary" style=""><h3>Start Now !</h3></b-button>
                </b-container>

              </b-col>
            </b-row>
          </b-card>
        </div>
      </div>

      <!--Page 4-->
      <div class="section" style="background-color: #FFFF03;">
        <div class="explainer">
          <div class="" style="background-color: #F111">
            <b-row align-h="between" style="text-align: center;">
              <b-col lg="5" align-self="center" style="">
                <h1>Vote</h1>
                <br>
                <h4>Bla bla bla bla</h4>
                <h4>Bla bla bla bla bla bla bla</h4>
                <h4>Bla Bla bla bla bla</h4>
                <h4>Bla bla bla bla</h4>
              </b-col>
              <b-col align-self="center" style="background-color: #F234;">
                <img src="../assets/plus.svg"
                     style="width: 50%; max-width: 30vw;"/>
              </b-col>
              <b-col lg="5" align-self="center" style="">
                <h1>Validation</h1>
                <br>
                <h4>Bla bla bla bla</h4>
                <h4>Bla bla bla bla bla bla bla</h4>
                <h4>Bla Bla bla bla bla</h4>
                <h4>Bla bla bla bla</h4>
              </b-col>
            </b-row>
          </div>
        </div>
      </div>
      <div class="section">
        <div class="explainer">
          <b-container class="" style="text-align: center; background-color: #F111">
            <h1>Welcome to Guesser?</h1>
            <br>
            <h3>Bla bla bla bla bla bla</h3>
            <h3>Bla bla Bla bla bla bla bla bla</h3>
            <h3>Bla bla bla bla bla bla</h3>
            <b-row align-h="between" style="">
            </b-row>
          </b-container>
        </div>
      </div>
    </full-page>
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
        paddingTop: '30px'
      },
      topics: ['Crypto', 'Celebrities', 'Entertainment', 'Gaming', 'Humor', 'News', 'Politics', 'Sports', 'Technology', 'Random'],
      guess: {
        id: '0',
        title: 'Will Elon Musk colonize mars?',
        description: 'He wants, could he do it?',
        topic: 'Crypto',
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
  padding: 5%;
}
.show {
  padding: 5% 3% 5% 2%;
  margin: 6%;
  background-color: white;
}
.tipe2 {
  background-color: pink;
  background-image: url("../assets/beard-background.png");
  /*background-repeat: no-repeat;*/
}
</style>
