<template>
  <div>
    <!-- Include Font Awesome Stylesheet in Header -->
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- // -->

    <div class="footer-div">
      <hr>
      <div class="text-center center-block">
        <a href=""><i id="social-gh" class="fab fa-github fa-social"></i></a>
        <a href=""><i id="social-med" class="fab fa-medium-m fa-social"></i></a>
        <a href=""><i id="social-tw" class="fab fa-twitter fa-social"></i></a>
        <a href="telegram"><i id="social-tel" class="fab fa-telegram-plane fa-social"></i></a>
      </div>
      <hr>
    </div>
    <div clas="footer-wrapper">
      <b-row class="center-block footer-wrapper">
        <b-col>
          <b-row align-h="center">
            <span class="footer-text">
              <a href="">About</a><br>
              <a href="">RoadMap</a><br>
              <a href="">FAQs</a><br>
            </span>
          </b-row>
        </b-col>
        <b-col>
          <b-row align-h="center">
            <span class="footer-text">
              <a href="">Help&Support</a><br>
              <a href="">Technical</a><br>
              <a href="">BeardPaper</a><br>
            </span>
          </b-row>
        </b-col>
        <b-col>
          <b-row align-h="center">
            <span class="footer-text">
              <a href="" class="social-med">Press</a><br>
              <a href="" class="social-tw">Twitter</a><br>
              <a href="" class="social-tel">Telegram</a><br>
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
  font-size: 2.6em;
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
