<template>
  <div class="justify-content-md-center margin">
    <h2>Events I have participated</h2>
    <br>
    <b-card no-body>
      <b-tabs card v-model="tabIndex">
        <b-tab title="Actual Events" :title-link-class="linkClass(0)">
          <ActualGuesses/>
        </b-tab>
        <b-tab title="Events being validated" :title-link-class="linkClass(1)">
          <ValidatingGuesses/>
        </b-tab>
        <b-tab title="Past events" :title-link-class="linkClass(2)">
          <PastGuesses/>
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
</template>

<script>
import ActualGuesses from './MyGuesses/ActualGuesses.vue'
import ValidatingGuesses from './MyGuesses/ValidatingGuesses.vue'
import PastGuesses from './MyGuesses/PastGuesses.vue'

export default {
  name: 'MyGuesses',
  data () {
    return {
      tabIndex: 0
    }
  },
  components: {
    ActualGuesses,
    ValidatingGuesses,
    PastGuesses
  },
  methods: {
    linkClass (idx) {
      if (this.tabIndex === idx) {
        return ['bg-primary', 'text-light']
      } else {
        return ['bg-light', 'text-info']
      }
    }
  }
}
</script>

<style>
.margin{
  margin: 0% 10%;
  padding: 2% 0%;
}
</style>
