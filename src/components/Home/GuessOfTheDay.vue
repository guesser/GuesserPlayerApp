<template>
  <b-card border-variant="primary"
          header="Is this latin?"
          header-bg-variant="primary"
          header-text-variant="white"
          class="text-center">
    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <!--Progress Bar-->
    <b-progress class="mt-1" :max="max" show-value striped>
      <b-progress-bar :value="max*(2/10)" variant="primary"></b-progress-bar>
      <b-progress-bar :value="max*(5/10)" variant="success"></b-progress-bar>
      <b-progress-bar :value="max*(2/10)" variant="warning"></b-progress-bar>
      <b-progress-bar :value="max*(1/10)" variant="danger"></b-progress-bar>
    </b-progress>

    <!--<div slot="footer">-->
      <!--<b-link href="#"-->
              <!--class="card-link">Yes-->
      <!--</b-link>-->
      <!--<b-link href="#"-->
              <!--class="card-link text-success">No-->
      <!--</b-link>-->
      <!--<b-link href="#"-->
              <!--class="card-link text-warning">Maybe-->
      <!--</b-link>-->
      <!--<b-link href="#"-->
              <!--class="card-link text-danger">3.1415-->
      <!--</b-link>-->

      <br>
      <b-button variant="outline-primary" size="sm">Yes</b-button>
      <b-button variant="outline-success" size="sm">No</b-button>
      <b-button variant="outline-warning" size="sm">Maybe</b-button>
      <b-button variant="outline-danger" size="sm">3.1415</b-button>
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
</style>
