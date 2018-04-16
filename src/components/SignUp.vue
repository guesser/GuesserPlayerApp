<template>
  <div>
    <b-row align-h="center" align-v="center" style="margin: 0% 0 4% 0" v-if="web3State == 'connected'">
      <div class="signup" align-self="center">
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
        <br>
        <label for="usernameInput" class="gray">Mail:</label>
        <b-row class="justify-content-md-center">
          <b-col cols="12">
            <b-form-input v-model="usermail"
                          id="usernameInput"
                          type="text"
                          size='lg'
                          placeholder="thisisaexample@guesser.io"></b-form-input>
          </b-col>
          <small class="gray">You won't receive spam (we promise)</small>
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

      </div>
    </b-row>
    <!-- User disconnected -->
      <div v-else-if="web3State == 'locked'">

<b-row style="margin-top:5%;">
  <b-col offset-md="1" md="auto">
      <h1>Your MetaMask is locked</h1>
      <br>
      <h4 style='color:gray'>Simply open MetaMask and follow the instructions to unlock it.</h4>
  </b-col>
  <b-col>
        <b-img src="http://www.emoji.co.uk/files/mozilla-emojis/objects-mozilla/11971-lock.png" fluid alt="Responsive image" />
  </b-col>
    </b-row>
      </div>

    <!-- User disconnected -->
    <div v-else-if="web3State == 'disconnected'">
    <b-row align-h="center" align-v="center">
      <h1><i>"Where are you?"</i></h1>
      <div>
        <b-img src="https://i.imgur.com/j51uHm1.gif" fluid alt="Responsive image" />
      </div>
    </b-row>
    <b-row align-h="center" align-v="center">
      <b-alert show variant="primary">
        <h4 class="alert-heading">You need to install Metamask</h4>
        <p>
          You’ll need a safe place to store all of your wins! The perfect place is in a secure wallet like MetaMask. This will also act as your login to the game (no extra password needed).
        </p>
        <hr>
        <b-button :size="lg" variant="primary">
          INSTALL METAMASK
        </b-button>
      </b-alert>
    </b-row>
    </div>
</div>
</template>

<script>
import ServerHelper from '@/js/ServerHelper'
import GuessHelper from '@/js/Guess'
import NetworkHelper from '@/js/NetworkHelper'

export default {
  name: 'SignUp',
  data () {
    return {
      address: '',
      username: '',
      usermail: '',
      web3State: null
    }
  },
  methods: {
    checkIfUserExists () {
      ServerHelper.getUser(GuessHelper.address[0]).then((data) => {
        console.log(data)
        this.userExists = true
        window.location.replace('/#/home')
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
          type: 'string',
          name: 'mail',
          value: this.usermail
        },
        {
          type: 'address',
          name: 'address',
          value: GuessHelper.address[0]
        }]

      GuessHelper.signMessage(msgParams).then((signedMsg) => {
        msgParams = JSON.stringify(msgParams)
        console.log(msgParams)
        console.log(signedMsg)
        ServerHelper.setUser(msgParams, signedMsg).then((data) => {
          window.location.reload()
        }).catch((err) => {
          console.log(err)
        })
      })
    }
  },
  mounted: function () {
    let self = this

    NetworkHelper.init().then(() => {
      if (NetworkHelper.state === 'disconnected') {
        self.web3State = 'disconnected'
      } else if (NetworkHelper.state === 'locked') {
        self.web3State = 'locked'
      } else {
        self.web3State = 'connected'
      }
    })
  },
  beforeCreate: function () {
    let self = this

    GuessHelper.init().then(() => {
      self.address = GuessHelper.address[0]
      self.checkIfUserExists()
    }).catch((err) => {
      return err
    })
  }
}

</script>

<style>
.gray {
  color: gray;
}

.signup {
  max-width: 800px;
  margin: 4% 15% 4% 15%;
  padding: 0 auto;
}
.mini-margin {
  margin-top: 40px;
}
</style>
