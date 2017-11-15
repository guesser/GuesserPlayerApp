<template>
    <form novalidate>
        <h2> Create a Guess</h2>
        <md-input-container>
            <label>Title</label>
            <md-input v-model="title"></md-input>
        </md-input-container>

        <md-input-container>
            <label>Description</label>
            <md-textarea></md-textarea>
        </md-input-container>

        <md-button class="md-raised md-primary" @click="getTitle"><h3>Create</h3></md-button>
    </form>
</template>

<script>
import Guess from '@/js/Guess'

export default {
  name: 'Create',
  data () {
    return {
      title: '',
      description: ''
    }
  },
  methods: {
    getTitle () {
      Guess.setTitleFront(this.title).then((title) => {
        console.log(title)
      }).catch(err => {
        console.log(err)
      })
    }
  },
  beforeCreate: function () {
    Guess.init().then(() => {
      Guess.setTitleFront(window.web3.eth.accounts[0]).then((setTitleFront) => {
        console.log(setTitleFront)
      }).catch(err => {
        console.log(err)
      })
    }).catch(err => {
      console.log(err)
    })
  }

}
</script>
