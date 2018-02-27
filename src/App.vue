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
  "success": lighten(green, 20%),
  "guesser": #ff0d73
);

// Bootstrap 4 breakpoints & gutter
$grid-breakpoints: (
    xs: 0,
    sm: 576px,
    md: 768px,
    lg: 992px,
    xl: 1200px
) !default;

$grid-gutter-width: 30px !default;

// number of cards per line for each breakpoint
$cards-per-line: (
    xs: 3,
    sm: 3,
    md: 3,
    lg: 3,
    xl: 3
) !default;

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

$humor: #FF00FF;
$humor-contrast: #CCFF99;

$news: #384F5D;
$news-contrast: lighten($news, 40%);

$politics: #000000;
$politics-contrast: #DCEBEF;

$sports: #EBB400;
$sports-contrast: #FFFFFF;

$technology-contrast: #BCBCBC;
$technology: #000000;

$random-contrast: #D9414C;
$random: lighten(#FDDF6D, 10%);

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

.bg-Humor{
  background-color: $humor-contrast !important;
  font-weight: bold;
  color: $humor !important;
  border-color: $humor !important;
}

.border-Humor{
  border-color: $humor !important;
}

.list-group-item-Humor{
  color: $humor !important;
  background-color: $humor-contrast !important;
}

.list-group-item-Humor:hover,
.list-group-item-Humor:focus{
  background-color: darken($humor-contrast, 5%) !important;
  color: darken($humor, 5%) !important;
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

.bg-Sports{
  background-color: $sports-contrast !important;
  font-weight: bold;
  color: $sports !important;
  border-color: $sports !important;
}

.border-Sports{
  border-color: $sports !important;
}

.list-group-item-Sports{
  color: $sports !important;
  background-color: $sports-contrast !important;
}

.list-group-item-Sports:hover,
.list-group-item-Sports:focus{
  background-color: darken($sports-contrast, 5%) !important;
  color: darken($sports, 5%) !important;
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
