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
.btn-outline-primary{
  color: #ff0d73;
  background-color: transparent;
  background-image: none;
  border-color: #ff0d73;
}

.btn-primary{
  color: #fff;
  background-color: #ff0d73;
  border-color: #ff0d73;
}
.btn-outline-primary:hover{
  color: #fff;
  background-color: #ff0d73;
  border-color: #ff0d73;
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

$sport: #EBB400;
$sport-contrast: #FFFFFF;

$technology-contrast: #BCBCBC;
$technology: #000000;

$random-contrast: #FF0D73;
$random: invert($random-contrast);

/* == */

.bg-crypto{
  background-color: $crypto-contrast !important;
  color: $crypto !important;
  border-color: $crypto !important;
}

.border-crypto{
  border-color: $crypto !important;
}
.list-group-item-crypto{
  background-color: $crypto-contrast !important;
  color: $crypto !important;
}

.list-group-item-crypto:hover,
.list-group-item-crypto:focus{
  background-color: darken($crypto-contrast, 5%) !important;
  color: darken($crypto, 5%) !important;
}

/* == */

.bg-celebrities{
  background-color: $celebrities-contrast !important;
  color: $celebrities !important;
  border-color: $celebrities !important;
}

.border-celebrities{
  border-color: $celebrities !important;
}

.list-group-item-celebrities{
  color: $celebrities !important;
  background-color: $celebrities-contrast !important;
}

.list-group-item-celebrities:hover,
.list-group-item-celebrities:focus{
  background-color: darken($celebrities-contrast, 5%) !important;
  color: darken($celebrities, 5%) !important;
}

/* == */

.bg-entertainment{
  background-color: $entertainment-contrast !important;
  color: $entertainment !important;
  border-color: $entertainment !important;
}

.border-entertainment{
  border-color: $entertainment !important;
}

.list-group-item-entertainment{
  color: $entertainment !important;
  background-color: $entertainment-contrast !important;
}

.list-group-item-entertainment:hover,
.list-group-item-entertainment:focus{
  background-color: darken($entertainment-contrast, 5%) !important;
  color: darken($entertainment, 5%) !important;
}

/* == */

.bg-gaming{
  background-color: $gaming-contrast !important;
  color: $gaming !important;
  border-color: $gaming !important;
}

.border-gaming{
  border-color: $gaming !important;
}

.list-group-item-gaming{
  color: $gaming !important;
  background-color: $gaming-contrast !important;
}

.list-group-item-gaming:hover,
.list-group-item-gaming:focus{
  background-color: darken($gaming-contrast, 5%) !important;
  color: darken($gaming, 5%) !important;
}

/* == */

.bg-humor{
  background-color: $humor-contrast !important;
  color: $humor !important;
  border-color: $humor !important;
}

.border-humor{
  border-color: $humor !important;
}

.list-group-item-humor{
  color: $humor !important;
  background-color: $humor-contrast !important;
}

.list-group-item-humor:hover,
.list-group-item-humor:focus{
  background-color: darken($humor-contrast, 5%) !important;
  color: darken($humor, 5%) !important;
}

/* == */

.bg-news{
  background-color: $news-contrast !important;
  color: $news !important;
  border-color: $news !important;
}

.border-news{
  border-color: $news !important;
}

.list-group-item-news{
  color: $news !important;
  background-color: $news-contrast !important;
}

.list-group-item-news:hover,
.list-group-item-news:focus{
  background-color: darken($news-contrast, 5%) !important;
  color: darken($news, 5%) !important;
}

/* == */

.bg-politics{
  background-color: $politics-contrast !important;
  color: $politics !important;
  border-color: $politics !important;
}

.border-politics{
  border-color: $politics !important;
}

.list-group-item-politics{
  color: $politics !important;
  background-color: $politics-contrast !important;
}

.list-group-item-politics:hover,
.list-group-item-politics:focus{
  background-color: darken($politics-contrast, 5%) !important;
  color: darken($politics, 5%) !important;
}

/* == */

.bg-sport{
  background-color: $sport-contrast !important;
  color: $sport !important;
  border-color: $sport !important;
}

.border-sport{
  border-color: $sport !important;
}

.list-group-item-sport{
  color: $sport !important;
  background-color: $sport-contrast !important;
}

.list-group-item-sport:hover,
.list-group-item-sport:focus{
  background-color: darken($sport-contrast, 5%) !important;
  color: darken($sport, 5%) !important;
}

/* == */

.bg-technology{
  background-color: $technology-contrast !important;
  color: $technology !important;
  border-color: $technology !important;
}

.border-technology{
  border-color: $technology !important;
}

.list-group-item-technology{
  color: $technology !important;
  background-color: $technology-contrast !important;
}

.list-group-item-technology:hover,
.list-group-item-technology:focus{
  background-color: darken($technology-contrast, 5%) !important;
  color: darken($technology, 5%) !important;
}

/* == */

.bg-random{
  background-color: $random-contrast !important;
  color: $random !important;
  border-color: $random !important;
}

.border-random{
  border-color: $random !important;
}

.list-group-item-random{
  color: $random !important;
  background-color: $random-contrast !important;
}

.list-group-item-random:hover,
.list-group-item-random:focus{
  background-color: darken($random-contrast, 5%) !important;
  color: darken($random, 5%) !important;
}

/* == */

.bg-magenta{
  background-color: magenta !important;
  color: white !important;
}

.bg-pink{
  background-color: pink !important;
  color: white !important;
}

.btn-outline-magenta{
  color: magenta;
  background-color: transparent;
  background-image: none;
  border-color: magenta;
}
.btn-outline-magenta:hover{
  color: #fff;
  background-color: magenta;
  border-color: magenta;
}
.btn-outline-pink{
  color: pink;
  background-color: transparent;
  background-image: none;
  border-color: pink;
}
.btn-outline-pink:hover{
  color: #fff;
  background-color: pink;
  border-color: pink;
}
</style>
