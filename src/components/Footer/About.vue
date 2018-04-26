<template>
  <div>
    <!--Header-->
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

    <!--Body-content-->
    <b-row class="justify-content-md-center wrapper" style>
      <b-col cols="12" sm="11" md="8" lg="7">
        <div class="content-box">
          <div class="text-box">
            <p>Guesser is a game where you stake money on your prediction for an event’s final outcome. Anyone can create an event, anyone can play at an event. We’ve built a distributed app on top of the Ethereum blockchain and with the help of smart contracts we can allow anyone to play in a trustless, decentralized way.</p><br>
            <p>Our team is eager to explore what events people create, and which ones gather the most attention from players. We believe we can grow a community that creates endless fun: why would a fixed team of people be better at creating events than anyone on the internet?</p>
          </div>
          <div class="team-wrapper">
            <h2 id="header">Guesser Team</h2>
            <b-row class="justify-content-md-center">
              <b-col cols="4" sm="11" md="6" lg="4" style="padding: 1%">
                <div class="team-cards">
                  <b-img src="static/jose.png" fluid alt="responsive" style="border-radius: 50%; padding: 10px;"/>
                    <h4>Jose Garay</h4>
                    <p>Project Lead</p>
                </div>
                  </b-col>
                  <b-col cols="4" sm="11" md="6" lg="4" style="padding: 1%">
                    <div class="team-cards">
                      <b-img src="static/charlie.png" fluid alt="responsive" class="team-pictures"/>
                        <h4>Carlos González</h4>
                        <p>Tech Lead</p>
                    </div>
                      </b-col>
                      <b-col cols="4" sm="11" md="6" lg="4" style="padding: 1%">
                        <div class="team-cards">
                          <b-img src="static/pi.jpg" fluid alt="responsive" style="border-radius: 50%; padding: 10px;"/>
                            <h4>Uxío Piñeiro</h4>
                            <p>Developer</p>
                        </div>
                          </b-col>
                      </b-row>
          </div>
        </div>
                  </b-col>
              </b-row>
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
</style>
