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


          <!-- <b-row align-g="start" style="margin: 0 !important"> -->
          <!--   <b-col cols="12" sm="12" md="6" lg="4" style="padding-left: 0"> -->
          <!--     <h4 style="color: #ff0d73">@{{username}} </h4> -->
          <!--     <b-card-body class="address-holder" style="overflow:hidden"><small>{{address}}</small></b-card-body> -->
          <!--   </b-col> -->
          <!-- </b-row> -->

    <br>
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
  
    <div v-if="chartsShow" class="charts">
      <Charts/>
    </div>
  </div>

</template>

<script>
import NetworkHelper from '@/js/NetworkHelper'
import GuessHelper from '@/js/Guess'
import ServerHelper from '@/js/ServerHelper'

import CurrentGuesses from './MyGuesses/CurrentGuesses.vue'
import ValidatingGuesses from './MyGuesses/ValidatingGuesses.vue'
import PastGuesses from './MyGuesses/PastGuesses.vue'
import CreatedGuesses from './MyGuesses/CreatedGuesses.vue'
import Charts from './MyGuesses/Charts.vue'

export default {
  name: 'MyGuesses',
  data () {
    return {
      address: '0x0000000000000...',
      username: '',
      tabIndex: 0,
      chartsShow: false
    }
  },
  components: {
    CurrentGuesses,
    ValidatingGuesses,
    PastGuesses,
    CreatedGuesses,
    Charts
  },
  methods: {
    linkClass (idx) {
      if (this.tabIndex === idx) {
        return ['bg-primary', 'text-light']
      } else {
        return ['bg-light', 'text-info']
      }
    },
    getUserName () {
      ServerHelper.getUser(GuessHelper.address[0]).then((data) => {
        this.username = data.username
      }).catch((err) => {
        return err
      })
    }
  },
  created: function () {
    NetworkHelper.init().then(() => {
      if (NetworkHelper.state === 'disconnected' ||
          NetworkHelper.state === 'locked') {
        this.$router.push('signup')
      } else {
        GuessHelper.init().then(() => {
          this.address = GuessHelper.address[0]
          this.getUserName()
        })
      }
    })
  }
}
</script>

<style>
.margin{
  margin: 0% 10%;
  padding: 2% 0%;
}
.charts{
  padding: 3% 7%;
}
.address-holder{
  background-color: #a0a0a0;
  border-radius: 5px;
  padding: 0.6rem 0.6rem;
  text-align: center;
}
</style>
