<template>
  <div class='bank'>
    <h1> Chest </h1>
    <h2 class='ether-header'> {{ balance }}<img src="../assets/ethereum.png" width='18px'/> </h2>

      <md-divider class='space'></md-divider>
      <h3 class='subtitle'>Receive</h3>

      <md-avatar class="md-large qr">
          <qrcode :foreground="foreground" :background="background" :size="size" :cls="qrCls" :value="address"></qrcode>
      </md-avatar>
      <div class='crop'>
              <md-icon style='font-size: 14px !important;'>content_copy</md-icon>{{address}}
      </div>
      <md-divider class='space'></md-divider>
      <h3>Send</h3>
 <md-field>
      <label>Address</label>
      <md-input v-model="form.address"></md-input>
 </md-field>

 <md-field>
      <label>Amount</label>
      <md-input v-model="form.amount"></md-input>
 </md-field>

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
      balance: '',
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
    let self = this
    Account.loadAccountData()
    this.address = Account.getAccountAddress()
    this.balance = Promise.resolve(Account.getBalance()).then((balance) => {
      self.balance = balance
    })
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

.bank{
    text-align: left;
    margin-left: 15px;
    margin-right: 15px;
}
.crop {
    width:50%;
    overflow:hidden;
    height:50px;
    line-height:50px;
    white-space: nowrap; /* Don't forget this one */
    text-overflow: ellipsis;
    margin-top: -15%;
    margin-left: 45%;
}
.ether-header{
    position: absolute;
    top: 0;
    right: 0;
}
</style>
