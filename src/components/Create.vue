<template>
    <form novalidate>
        <h2> Create a Guess</h2>
        <md-input-container>
            <label>Title</label>
            <md-input v-model="title"></md-input>
        </md-input-container>

        <md-input-container>
            <label>Description</label>
            <md-textarea v-model="description"></md-textarea>
        </md-input-container>

        <md-button class="md-raised md-primary" @click="setGuess"><h3>Create</h3></md-button>
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
    setGuess () {
      Guess.setGuessFront(this.title, this.description).then((title) => {
        console.log(title)
      }).catch(err => {
        console.log(err)
      })
    }
  },
  beforeCreate: function () {
    Guess.init().catch(err => {
      console.log(err)
    })
  }
}
</script>
