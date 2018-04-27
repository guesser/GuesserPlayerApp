<template>
  <div>
    <b-row class="justify-content-md-center wrapper heading" align-v="center">
      <b-col cols="12" sm="11" md="8" lg="7">
        <b-row class="justify-content-md-center">
          <b-col cols="6" sm="6" md="5" lg="4">
            <a href="#about">
              <b-container class="header-cards" fluid>
                About
              </b-container>
            </a>
          </b-col>
          <b-col cols="6" sm="6" md="5" lg="4">
            <a href="#faqs">
              <b-container class="header-cards" fluid>
                FAQs
              </b-container>
            </a>
          </b-col>
          <b-col cols="6" sm="6" md="5" lg="4">
            <a href="#help">
              <b-container class="header-cards" fluid>
                Help & Support
              </b-container>
            </a>
          </b-col>
        </b-row>
      </b-col>
    </b-row>
    <b-row class="justify-content-md-center wrapper" style>
      <b-col cols="12" sm="11" md="8" lg="7">
        <div class="content-box">
          <div class="text-box">
            <h2>Getting Started</h2>
            <!--FAQ1-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.start1 class="collapse-header">What I need to start?</div>
              <b-collapse id="start1" class="collapse-text">
                <p>
                To start your journey in Guesser beta, you need three things:
                <br>
                <ul>
                  <li>Google Chrome or Firefox browser running on a PC/Cipher Browser mobile dapp browser running on your Android or iOS smartphone</li>
                  <li>MetaMask plugin that will act as a cryptocurrency wallet</li>
                  <li>Rinkeby Testnet faucet funds (virtual ether)</li>
                </ul>
                </p>
              </b-collapse>
            </div>
            <!--FAQ2-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.start2 class="collapse-header">Installing MetaMask on your PC browser</div>
              <b-collapse id="start2" class="collapse-text">
                <p>
                MetaMask is a browser extension that allows you to interact with Ethereum Dapps (like Guesser beta) directly from your Chrome, Firefox or Brave browser. More info and installation help can be found <a href="https://metamask.io/" target="_blank">here</a> and in the following video.
                </p>
                <b-embed type="iframe" aspect="16by9" src="https://www.youtube.com/embed/tfETpi-9ORs"></b-embed>
              </b-collapse>
            </div>
            <!--FAQ3--> <div> <hr>
              <div variant="outline-primary" v-b-toggle.start3 class="collapse-header">Installing Cipher Browser on your smartphone</div>
              <b-collapse id="start3" class="collapse-text">
                <p>
                Cipher Browser is a mobile dapp browser and wallet for the Ethereum blockchain. Cipher allows you to interact with dapps powered by Ethereum on your mobile device and makes it easy for you to securely store, send and receive Rinkeby faucet funds to play Guesser.
                </p>
                <p>
                <a href="https://www.cipherbrowser.com/" target="_blank">It's available on Android and iOS</a>
                </p>
              </b-collapse>
            </div>
            <!--FAQ4-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.start4 class="collapse-header">Getting faucet funds</div>
              <b-collapse id="start4" class="collapse-text">
                <p>
                Rinkeby Testnet is an Ethereum network built for testing purposes where the ether transacted is virtual; it doesn’t hold real value. Whether you’re using a PC or a smartphone, you need to get this faucet funds on your MetaMask wallet (Rinkeby Testnet tab) or Cipher Browser wallet following the instructions found <a href="https://faucet.rinkeby.io/" target="_blank">on this page</a> in order to play Guesser beta. 
                </p>
              </b-collapse>
            </div>
            <hr>
          </div>

          <br>
          <div class="text-box">
            <h2>Playing Guesser</h2>
            <!--FAQ5-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.play1 class="collapse-header">What is Guesser?</div>
              <b-collapse id="play1" class="collapse-text">
                <p>
                Guesser is a prediction game where players put their eth on one of two outcomes of a given event, and the winning side gets back all the money played in the event.<br>Events are created by players and are initially organized into 10 flexible topics: Crypto, Celebrities, Entertainment, Gaming, Humour, News, Politics, Sports, Technology and Random.
                </p>
              </b-collapse>
            </div>
            <!--FAQ6-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.play2 class="collapse-header">How can I guess?</div>
              <b-collapse id="play2" class="collapse-text">
                <p>
                If you think you know the outcome of a certain event, you can predict it by choosing one of the two outcomes and deciding how much ether you want to stake. If the event finishes and you were right, the Guesser smart contract will give you the % of the total ether played (proportional to the % of your outcome’s pool) that you get back.
                <br><br>
                Example:
                <ol>
                  <li>Player X stakes 0.3 ether to Outcome A</li>
                  <li>AOutcome A: 3 ether staked in total</li>
                  <li>Outcome B: 4 ether staked in total</li>
                  <li>Outcome A happens</li>
                  <li>Player X gets back (0.3 / 3 )*(3 + 4) = 0.7 ether</li>
                </ol>
                </p>
              </b-collapse>
            </div>
            <!--FAQ7-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.play3 class="collapse-header">How can I create an event?</div>
              <b-collapse id="play3" class="collapse-text">
                <p>
                Guesser is a prediction game where players put their eth on one of two outcomes of a given event, and the winning side gets back all the money played in the event.<br>Events are created by players and are initially organized into 10 flexible topics: Crypto, Celebrities, Entertainment, Gaming, Humour, News, Politics, Sports, Technology and Random.
                <ul>
                  <li>Title</li>
                  <li>Description</li>
                  <li>Topic</li>
                  <li>Outcome A</li>
                  <li>Outcome B</li>
                  <li>Event duration</li>
                  <li>Ending date & time</li>
                </ul>
                </p>
              </b-collapse>
            </div>
            <!--FAQ8-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.play4 class="collapse-header">What is this Guesser language everyone’s talking?</div>
              <b-collapse id="play4" class="collapse-text">
                <p>
                We have special language at Guesser for everyone to understand the game better. Here are some basic examples:
                <ul>
                  <li>Guesser: a player predicting the outcome of internet events</li>
                  <li>Event: something that’s happening on the internet</li>
                  <li>Outcome: one of the two options that can happen at an event</li>
                  <li>Topic: main theme of a group of events</li>
                  <li>Guess: your outcome of choice at a certain event</li>
                </ul>
                </p>
              </b-collapse>
            </div>
            <!--FAQ9-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.play5 class="collapse-header">Who validates the outcomes?</div>
              <b-collapse id="play5" class="collapse-text">
                <p>
                It’s quite important to know who says what happened at each event. What was the true outcome of the event I participated in? First of all, let’s make clear that validation does not rely on our core team.<br>
                On Guesser Beta v.0, all guessers can validate events by simply voting about the true outcome. This a very simple validation mechanism that we’ve implemented for the Testnet period, while we work on a decentralized and trustless mechanism for event validation for our mainnet release. 
                </p>
              </b-collapse>
            </div>
            <hr>
          </div>
          <br>
          <div class="text-box">
            <h2>Bonus</h2>
            <!--FAQ10-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.bonus1 class="collapse-header">How can I reach the guesser team?</div>
              <b-collapse id="bonus1" class="collapse-text">
                <p>
                If you have anything to tell us regarding the product, feedback, bugs, partnerships or other opportunities, please reach us at <a href="mailto:team@guesser.io" target="_blank">team@guesser.io</a>.
                </p>
              </b-collapse>
            </div>
            <!--FAQ11-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.bonus2 class="collapse-header">Can I use a credit card to get funds and play Guesser beta?</div>
              <b-collapse id="bonus2" class="collapse-text">
                <p>
                The only ways to get Rinkeby faucet funds to play Guesser beta are described on <a href="https://faucet.rinkeby.io/" target="_blank">this page</a>. 
                </p>
              </b-collapse>
            </div>
            <!--FAQ12-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.bonus3 class="collapse-header">Is Guesser a scam?</div>
              <b-collapse id="bonus3" class="collapse-text">
                <p>
                No. Guesser is a fun game built by a <a href="#about" target="_blank">fun team</a>. 
                </p>
              </b-collapse>
            </div>
            <!--FAQ13-->
            <div>
              <hr>
              <div variant="outline-primary" v-b-toggle.bonus4 class="collapse-header">Do I need to grow a beard before playing?</div>
              <b-collapse id="bonus4" class="collapse-text">
                <p>
                It doesn’t hurt to wear a pink beard, but it’s not necessary. We’re making stickers ;)
                </p>
              </b-collapse>
            </div>
          </div>
          <hr>
        </div>
      </b-col>
    </b-row>
  </div>
  </div>
</template>
<script>
</script>
<style scoped lang="scss">

$primary: #ff0d73;

#header {
  color: $primary;
}
.maket {
  background-color: #F333;
}
.wrapper {
  margin: 0;
  padding: 0;
}
.heading {
  height: 10rem;
  width: 100%;
  background-image: url("../../../static/beardground.png");
  background-size: 100%;
}
.header-cards {
  text-align: center;
  background: white;
  border-radius: 5px;
  padding: 10px 0;
  margin: 4px 0;
}
.content-box {
  background-color: #fff;
  padding: 10%;
}
.text-box {
  font-size: 1.1rem;
  text-align: justify;
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

.collapse-header {
  font-size: 1.3rem;
  width: 100%;
}
.collapse-header:hover {
  color: $primary;
}
.collapse-text {
  padding-top: 20px;
  padding-left: 10px;
  text-align: justify;
  color: gray !important;
}
.collapse-text li {
  margin: 10px 0;
}
.row {
  margin-left: 0 !important;
}
</style>
