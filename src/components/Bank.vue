<template>
  <div>
      <h1> Bank </h1>
      <md-avatar class="md-large qr">
          <qrcode :foreground="foreground" :background="background" :size="size" :cls="qrCls" :value="address"></qrcode>
      </md-avatar>
      <md-divider class='space'></md-divider>
      <h3>Receive</h3>
      <small>{{address}}</small>
      <h3>Send</h3>
      <md-field>
      <label>Address</label>
      <md-input v-model="initial"></md-input>
    </md-field>

    <md-field>
      <label>Value</label>
      <md-input v-model="initial"></md-input>
    </md-field>
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
      qrText: 'Read VueJS Feed daily',
      size: 500,
      background: '#ffff01',
      foreground: '#ff0d73'
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
    width: 120px !important;
    height: 120px !important;
    border-radius: 5px !important;
}

.space{
    margin-top: 15px;
}
</style>
