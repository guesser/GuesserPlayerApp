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
            <h2>Common Issues</h2>
          <div class="text-box">
            <p>
              Nothing here yet
            </p>
          </div>
          <hr>
          <div class="text-box">
            <h4>You can report bugs <a href="https://github.com/carlosgj94/Guesser/issues">here</a></h4>
          </div>
        </div>
      </b-col>
    </b-row>
    <!--Tooltips-->
    <b-tooltip target="jose" placement="top">
      Libertarian to the end of the times
    </b-tooltip>
    <b-tooltip target="carlos" placement="top">
      Our 'evil like the most cute of the kitties' lead contractor.<br>He likes pink color, programming for 12 hours straight and torture his imaginary interns.
    </b-tooltip>
    <b-tooltip target="pi" placement="top">
      Pi is our fresh frontend dev who loves to learn, find bugs in Carlos' code and breed Dracula-looking cryptokitties.
    </b-tooltip>
    <b-tooltip target="pi.photo" placement="right">
      <p style="color: pink;">
      My last laptop was stolen and I had to work with a borrowed one. If you want to help me you can donate to the address by clicking. Enjoy the platform! 
      </p>
    </b-tooltip>

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
.row {
  margin-left: 0;
}
</style>
