<template>
  <div>
    <b-container class="signup">
      <b-row class="justify-content-md-center">
        <b-col cols="12" md="auto">
          <h1>Welcome to Guesser</h1>
        </b-col>
      </b-row>
      <b-row class="justify-content-md-center">
        <b-col cols="12" md="auto">
        <br>
          <h5 class='gray'>To get started, please enter a nickname.</h5>
        </b-col>
      </b-row>
      <b-row class="justify-content-md-center">
      <b-col cols="12" md="auto">
        <img src="../assets/beard.png" height="60" width="60" class="d-inline-block align-top" alt="BV"/>
      </b-col>
      </b-row>

          <br>
<label class='mini-margin gray' for="addressInput">Address:</label>
      <b-row class="justify-content-md-center">
        <b-col cols="12">
          <b-form-input v-model="address"
                        id="addressInput"
                        type="text"
                        disabled
                        size='lg'
                        :placeholder="address"></b-form-input>
        </b-col>
      </b-row>
          <br>
<label for="usernameInput" class="gray">Username:</label>
      <b-row class="justify-content-md-center">
        <b-col cols="12">
          <b-form-input v-model="username"
                        id="usernameInput"
                        type="text"
                        size='lg'
                        placeholder="A name that rocks"></b-form-input>
        </b-col>
      </b-row>

<b-row class="justify-content-md-center mini-margin">
        <b-col cols="12">
          <b-alert show variant="primary">
Make sure to save your MetaMask login information and account recovery details! We can’t help you regain access if you lose it.
          </b-alert>
        </b-col>
      </b-row>

      <b-row class="justify-content-md-center">
        <b-col cols="12" md="auto">
          <b-button type="submit"
                    class='mini-margin'
                    variant="primary"
                    @click='submit()'
                    size='lg'>Submit</b-button>
        </b-col>
      </b-row>

    </b-container>
  </div>
</template>

<script>
import ServerHelper from '@/js/ServerHelper'
import GuessHelper from '@/js/Guess'

export default {
  name: 'SignUp',
  data () {
    return {
      address: '',
      username: ''
    }
  },
  methods: {
    checkIfUserExists () {
      ServerHelper.getUsername(GuessHelper.address[0]).then((data) => {
        console.log(data)
        this.userExists = true
      }).catch((err) => {
        this.userExists = false
        return err
      })
    },
    submit () {
      let msgParams = [
        {
          type: 'string',      // Any valid solidity type
          name: 'username',     // Any string label you want
          value: this.username // The value to sign
        },
        {
          type: 'address',
          name: 'address',
          value: GuessHelper.address[0]
        }]

      GuessHelper.signMessage(msgParams).then((signedMsg) => {
        msgParams = JSON.stringify(msgParams)
        console.log(msgParams)
        ServerHelper.setUsername(msgParams, signedMsg).then((data) => {
          console.log(data)
          // TODO: Launch the event of user created
        })
      })
    }
  },
  beforeCreate: function () {
    let self = this

    GuessHelper.init().then(() => {
      self.address = GuessHelper.address[0]
      self.checkIfUserExists()
    })
  }
}

</script>

<style>
.gray {
  color: gray;
}

.signup {
  margin-top: 4%;
  max-width: 800px;
}
.mini-margin {
  margin-top: 40px;
}
</style>
