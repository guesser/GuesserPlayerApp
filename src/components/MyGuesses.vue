<template>
  <div class="justify-content-md-center margin">

    <!--Alert-->
    <notifications group="copyAlert"
                   position="bottom right"
                   width="120"
                   :speed="500">
    <template slot="body" slot-scope="props">
      <div class="copyAlert">
        <div class="copyAlert-content">
          Url copied!
        </div>
      </div>
    </template>
    </notifications>



    <h2>Events I have participated in</h2>
    <br>
    <b-card no-body>
      <b-tabs card v-model="tabIndex">
        <b-tab title="Current Events" :title-link-class="linkClass(0)">
          <CurrentGuesses/>
        </b-tab>
        <b-tab title="Events being validated" :title-link-class="linkClass(1)">
          <ValidatingGuesses/>
        </b-tab>
        <b-tab title="Past events" :title-link-class="linkClass(2)">
          <PastGuesses/>
        </b-tab>
        <b-tab title="Created events" :title-link-class="linkClass(3)">
          <CreatedGuesses/>
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
</template>

<script>
import CurrentGuesses from './MyGuesses/CurrentGuesses.vue'
import ValidatingGuesses from './MyGuesses/ValidatingGuesses.vue'
import PastGuesses from './MyGuesses/PastGuesses.vue'
import CreatedGuesses from './MyGuesses/CreatedGuesses.vue'

export default {
  name: 'MyGuesses',
  data () {
    return {
      tabIndex: 0
    }
  },
  components: {
    CurrentGuesses,
    ValidatingGuesses,
    PastGuesses,
    CreatedGuesses
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
