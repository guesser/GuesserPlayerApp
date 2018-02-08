<template>
  <div>
  <b-card-group deck class="mb-3">
    <b-card :border-variant="topic"
            header="GuessTitle"
            :header-border-variant="topic"
            header-text-variant="black"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
    <!--TODO: Load Dinamically-->
     <b-card :border-variant="topic"
            header="GuessTitle2"
            :header-border-variant="topic"
            header-text-variant="black"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
    <b-card :border-variant="topic"
            header="GuessTitle3"
            :header-border-variant="topic"
            header-text-variant="black"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
  </b-card-group>  <b-card-group deck class="mb-3">
    <b-card :border-variant="topic"
            header="GuessTitle4"
            :header-border-variant="topic"
            header-text-variant="black"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
    <!--TODO: Load Dinamically-->
     <b-card :border-variant="topic"
            header="GuessTitle5"
            :header-border-variant="topic"
            header-text-variant="black"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
    <b-card :border-variant="topic"
            header="GuessTitle6"
            :header-border-variant="topic"
            header-text-variant="black"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
  </b-card-group>
  </div>
</template>

<script>
export default {
  name: 'OtherGuesses',
  props: ['topic']
}
</script>

<style>

</style>
