<template>
  <div>
    <div v-if="account">
      <h1> Bank </h1>
  <!-- <Chest/> -->
    </div>
    <div v-else>
    </div>
  </div>
</template>

<script>
import Account from '@/js/Account'

export default{
  name: 'Bank',
  data () {
    return {
      account: ''
    }
  },
  methods: {
    createAccount () {
      console.log('Hola')
    }
  },
  mounted: function () {
    Account.loadAccountData()
  }
}
</script>

<style>
.primary{
    color: #ff0d73;
}
</style>
