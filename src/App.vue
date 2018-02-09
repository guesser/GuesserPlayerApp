<template>
  <div>
    <TopBar/>
    <main>
    <router-view></router-view>
    </main>

    <footer>
    </footer>

  </div>
</template>

<script>
// Vue components
import TopBar from './components/Header.vue'

export default {
  name: 'app',
  components: {
    TopBar
  },
  data: function () {
    return {
    }
  },
  methods: {
    changeView (view) {
      this.$router.push('/' + view)
    }
  }
}
</script>

<style lang="scss">

$primary: #ff0d73;

/*Here we can create any color that we want*/
$theme-colors: (
  "pink": lighten(magenta, 20%),
  "magenta": lighten(blue, 20%),
  "success": lighten(green, 20%)
);

@import "~bootstrap/scss/bootstrap";

body{
  font-family: 'Josefin Sans', sans-serif;
  height: 100%;
}
main{
  padding-top: 2%;
  height:100vh;
  min-height: 100vh;
  bottom:0;
}

.navbar-brand {
  margin-right: 0;
}

/*TOPIC STYLES*/

/*Colors*/
$crypto: #F29100;
$crypto-contrast: lighten(#F0D215, 25%);

$celebrities: #9D27B0;
$celebrities-contrast: lighten($celebrities, 40%);

$entertainment: #0086ED;
$entertainment-contrast: lighten($entertainment, 40%);

$gaming: #ED5565;
$gaming-contrast: #FFCE54;

$humour: #FF00FF;
$humour-contrast: #CCFF99;

$news: #384F5D;
$news-contrast: lighten($news, 40%);

$politics: #000000;
$politics-contrast: #DCEBEF;

$sport: #EBB400;
$sport-contrast: #FFFFFF;

$technology-contrast: #BCBCBC;
$technology: #000000;

$random-contrast: #FF0D73;
$random: invert($random-contrast);

/* == */

.bg-Crypto{
  background-color: $crypto-contrast !important;
  font-weight: bold;
  color: $crypto !important;
  border-color: $crypto !important;
}

.border-Crypto{
  border-color: $crypto !important;
}
.list-group-item-Crypto{
  background-color: $crypto-contrast !important;
  color: $crypto !important;
}

.list-group-item-Crypto:hover,
.list-group-item-Crypto:focus{
  background-color: darken($crypto-contrast, 5%) !important;
  color: darken($crypto, 5%) !important;
}

/* == */

.bg-Celebrities{
  background-color: $celebrities-contrast !important;
  font-weight: bold;
  color: $celebrities !important;
  border-color: $celebrities !important;
}

.border-Celebrities{
  border-color: $celebrities !important;
}

.list-group-item-Celebrities{
  color: $celebrities !important;
  background-color: $celebrities-contrast !important;
}

.list-group-item-Celebrities:hover,
.list-group-item-Celebrities:focus{
  background-color: darken($celebrities-contrast, 5%) !important;
  color: darken($celebrities, 5%) !important;
}

/* == */

.bg-Entertainment{
  background-color: $entertainment-contrast !important;
  font-weight: bold;
  color: $entertainment !important;
  border-color: $entertainment !important;
}

.border-Entertainment{
  border-color: $entertainment !important;
}

.list-group-item-Entertainment{
  color: $entertainment !important;
  background-color: $entertainment-contrast !important;
}

.list-group-item-Entertainment:hover,
.list-group-item-Entertainment:focus{
  background-color: darken($entertainment-contrast, 5%) !important;
  color: darken($entertainment, 5%) !important;
}

/* == */

.bg-Gaming{
  background-color: $gaming-contrast !important;
  font-weight: bold;
  color: $gaming !important;
  border-color: $gaming !important;
}

.border-Gaming{
  border-color: $gaming !important;
}

.list-group-item-Gaming{
  color: $gaming !important;
  background-color: $gaming-contrast !important;
}

.list-group-item-Gaming:hover,
.list-group-item-Gaming:focus{
  background-color: darken($gaming-contrast, 5%) !important;
  color: darken($gaming, 5%) !important;
}

/* == */

.bg-Humour{
  background-color: $humour-contrast !important;
  font-weight: bold;
  color: $humour !important;
  border-color: $humour !important;
}

.border-Humour{
  border-color: $humour !important;
}

.list-group-item-Humour{
  color: $humour !important;
  background-color: $humour-contrast !important;
}

.list-group-item-Humour:hover,
.list-group-item-Humour:focus{
  background-color: darken($humour-contrast, 5%) !important;
  color: darken($humour, 5%) !important;
}

/* == */

.bg-News{
  background-color: $news-contrast !important;
  font-weight: bold;
  color: $news !important;
  border-color: $news !important;
}

.border-News{
  border-color: $news !important;
}

.list-group-item-News{
  color: $news !important;
  background-color: $news-contrast !important;
}

.list-group-item-News:hover,
.list-group-item-News:focus{
  background-color: darken($news-contrast, 5%) !important;
  color: darken($news, 5%) !important;
}

/* == */

.bg-Politics{
  background-color: $politics-contrast !important;
  font-weight: bold;
  color: $politics !important;
  border-color: $politics !important;
}

.border-Politics{
  border-color: $politics !important;
}

.list-group-item-Politics{
  color: $politics !important;
  background-color: $politics-contrast !important;
}

.list-group-item-Politics:hover,
.list-group-item-Politics:focus{
  background-color: darken($politics-contrast, 5%) !important;
  color: darken($politics, 5%) !important;
}

/* == */

.bg-Sport{
  background-color: $sport-contrast !important;
  font-weight: bold;
  color: $sport !important;
  border-color: $sport !important;
}

.border-Sport{
  border-color: $sport !important;
}

.list-group-item-Sport{
  color: $sport !important;
  background-color: $sport-contrast !important;
}

.list-group-item-Sport:hover,
.list-group-item-Sport:focus{
  background-color: darken($sport-contrast, 5%) !important;
  color: darken($sport, 5%) !important;
}

/* == */

.bg-Technology{
  background-color: $technology-contrast !important;
  font-weight: bold;
  color: $technology !important;
  border-color: $technology !important;
}

.border-Technology{
  border-color: $technology !important;
}

.list-group-item-Technology{
  color: $technology !important;
  background-color: $technology-contrast !important;
}

.list-group-item-Technology:hover,
.list-group-item-Technology:focus{
  background-color: darken($technology-contrast, 5%) !important;
  color: darken($technology, 5%) !important;
}

/* == */

.bg-Random{
  background-color: $random-contrast !important;
  font-weight: bold;
  color: $random !important;
  border-color: $random !important;
}

.border-Random{
  border-color: $random !important;
}

.list-group-item-Random{
  color: $random !important;
  background-color: $random-contrast !important;
}

.list-group-item-Random:hover,
.list-group-item-Random:focus{
  background-color: darken($random-contrast, 5%) !important;
  color: darken($random, 5%) !important;
}
</style>
