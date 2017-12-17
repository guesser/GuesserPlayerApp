<template>
  <div>
      <h1> Bank </h1>
      <h3>Receive</h3>
      <md-avatar class="md-large qr">
          <qrcode :foreground="foreground" :background="background" :size="size" :cls="qrCls" :value="address"></qrcode>
      </md-avatar>
      <small>{{address}}</small>
      <md-divider class='space'></md-divider>
      <h3>Send</h3>
      <md-input-container>
      <label>Address</label>
      <md-input v-model="form.address"></md-input>
      </md-input-container>

      <md-input-container>
      <label>Amount</label>
      <md-input v-model="form.amount"></md-input>
      </md-input-container>

       <md-button class="md-raised md-primary">Send</md-button>
  <!-- <Chest/> -->
  </div>
</template>

<script>
// External libraries
import Qrcode from 'v-qrcode/src/index'

// Helpers
import Account from '@/js/Account'

export default{
  name: 'Bank',
  components: {
    Qrcode
  },
  data () {
    return {
      address: '',
      qrCls: 'qrcode',
      size: 500,
      background: '#ffff01',
      foreground: '#ff0d73',
      form: {
        address: null,
        amount: null
      }
    }
  },
  methods: {
  },
  mounted: function () {
    Account.loadAccountData()
    this.address = Account.getAccountAddress()
  }
}
</script>

<style>
.primary{
    color: #ff0d73;
}

.qr{
    margin-left: 0 !important;
    width: 120px !important;
    height: 120px !important;
    border-radius: 5px !important;
}

.space{
    margin-top: 15px;
}
</style>
