<template>
  <b-card border-variant="primary"
          header="Is this latin?"
          header-bg-variant="primary"
          header-text-variant="white"
          class="text-center">
    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <!--Progress Bar-->
    <b-progress class="mt-1" :max="max" show-value striped>
      <b-progress-bar :value="max*(3/10)" variant="pink">
      Yes - {{ max*(3/10) }}
      </b-progress-bar>
      <b-progress-bar :value="max*(7/10)" variant="magenta">
       No - {{ max*(7/10) }}
      </b-progress-bar>
    </b-progress>

      <br>
      <b-button variant="outline-pink" size="sm">Yes</b-button>
      <b-button variant="outline-magenta" size="sm">No</b-button>
    </div>
  </b-card>
</template>

<script>
export default {
  name: 'GuessOfTheDay',
  data () {
    return {
      max: 100
    }
  }
}
</script>

<style>
.card-link{
text-decoration: underline;
}
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
