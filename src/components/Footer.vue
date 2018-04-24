<template>
  <div>
    <!-- Include Font Awesome Stylesheet in Header -->
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- // -->

    <div class="footer-div">
      <hr>
      <div class="text-center center-block">
        <a href="https://github.com/carlosgj94/Guesser" target="blank"><i id="social-gh" class="fab fa-github fa-social"></i></a>
        <a href="https://medium.com/@joselfgaray" target="blank"><i id="social-med" class="fab fa-medium-m fa-social"></i></a>
        <a href="https://twitter.com/GuesserIO" target="blank"><i id="social-tw" class="fab fa-twitter fa-social"></i></a>
        <a href="http://lmgtfy.com/?s=d&q=Telegram+of+the+coolest+DApp+in+history" target="blank"><i id="social-tel" class="fab fa-telegram-plane fa-social"></i></a>
      </div>
      <hr>
    </div>
    <div clas="footer-wrapper">
      <b-row class="center-block footer-wrapper">
        <b-col>
          <b-row align-h="center">
            <span class="footer-text">
              <a href="" target="blank">About</a><br>
              <a href="" target="blank">RoadMap</a><br>
              <a href="" target="blank">FAQs</a><br>
            </span>
          </b-row>
        </b-col>
        <b-col>
          <b-row align-h="center">
            <span class="footer-text">
              <a href="https://github.com/carlosgj94/Guesser" target="blank">Help & Support</a><br>
              <a href="" target="blank">Technical</a><br>
              <a href="" target="blank">Beardy Paper</a><br>
            </span>
          </b-row>
        </b-col>
        <b-col>
          <b-row align-h="center">
            <span class="footer-text">
              <a href="https://medium.com/@joselfgaray" target="blank" class="social-med">Press</a><br>
              <a href="https://twitter.com/GuesserIO" target="blank" class="social-tw">Twitter</a><br>
              <a href="http://lmgtfy.com/?s=d&q=Telegram+of+the+coolest+DApp+in+history" target="blank" class="social-tel">Telegram</a><br>
            </span>
          </b-row>
        </b-col>
      </b-row>
    </div>
  </div>
</template>
<script>
</script>
<style>
.fa-social:hover {
  -webkit-transform: scale(1.5);
  -moz-transform: scale(1.5);
  -o-transform: scale(1.5);
}
.fa-social {
  padding: 10px 5%;
  font-size: 2em;
  -webkit-transition-duration: 0.5s;
  -moz-transition-duration: 0.5s;
  -o-transition-duration: 0.5s;
}
.footer-wrapper{
  margin: 0;
  padding: 0 5% 1% 5%;
}
.footer-div{
  background: rgba(0, 0, 0, 0.05);
}
.footer-text{
  text-align: justify;
  font-size: 1em;
}
/*
Multicoloured Hover Variations
 */

.social-gh {
  color: #24292e;
}
#social-gh:hover {
  color: #24292e;
}
.social-tw {
  color: #4099FF;
}
#social-tw:hover {
  color: #4099FF;
}
.social-med{
  color: #292929;
}
#social-med:hover {
  color: #292929;
}
.social-tel {
  color: #32a9df;
}
#social-tel:hover {
  color: #32a9df;
}
</style>
