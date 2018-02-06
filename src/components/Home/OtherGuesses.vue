<template>
  <div>
  <b-card-group deck class="mb-3">
    <b-card :border-variant="topic"
            header="Primary"
            :header-border-variant="topic"
            header-text-variant="black"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
    <!--TODO: Load Dinamically-->
    <b-card border-variant="secondary"
            header="Secondary"
            header-border-variant="secondary"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
    <b-card border-variant="success"
            header="Success"
            header-border-variant="success"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
  </b-card-group>
  <b-card-group deck class="mb-3">
    <b-card border-variant="info"
            header="Info"
            header-border-variant="info"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
    <b-card border-variant="warning"
            header="Warning"
            header-border-variant="warning"
            align="center">
      <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    </b-card>
    <b-card border-variant="danger"
            header="Danger"
            header-border-variant="danger"
            header-text-variant="danger"
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
