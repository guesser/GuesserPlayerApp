<template>
    <form class="create-event">
        <h2> Create a Event</h2>
        <md-input-container>
            <label>Title</label>
            <md-input v-model="title" required></md-input>
        </md-input-container>

        <md-input-container>
            <label>Description</label>
            <md-textarea v-model="description" required></md-textarea>
        </md-input-container>

        <!--Topics-->
    <md-input-container>
          <label for="topic">Topic</label>
          <md-select v-model="topic" name="topic" id="topic">
            <md-option value="crypto">Crypto</md-option>
            <md-option value="esports">Esports</md-option>
          </md-select>
    </md-input-container>

    <!--Option 1-->
    <md-input-container>
            <label>Option 1</label>
            <md-input v-model="option1" required></md-input>
    </md-input-container>

    <!--Option 2-->
    <md-input-container v-if="option1 != ''">
            <label>Option 2</label>
            <md-input v-model="option2" required></md-input>
    </md-input-container>

    <!--Option 3-->
    <md-input-container v-if="option2 != ''">
            <label>Option 3</label>
            <md-input v-model="option3"></md-input>
    </md-input-container>
    
    <!--Option 4-->
    <md-input-container v-if="option3 != ''">
            <label>Option 4</label>
            <md-input v-model="option4"></md-input>
    </md-input-container>


        <md-button class="md-raised md-primary" @click="setEvent"><h3>Create</h3></md-button>
    </form>
</template>

<script>
import EventHelper from '@/js/Event'

export default {
  name: 'CreateGuess',
  data () {
    return {
      title: '',
      description: '',
      topic: '',
      option1: '',
      option2: '',
      option3: '',
      option4: ''
    }
  },
  methods: {
    setEvent () {
      // let self = this
      EventHelper.setEventFront(
        this.title,
        this.description,
        this.topic,
        this.option1,
        this.option2,
        this.option3,
        this.option4,
      ).then((id) => {
        console.log(id)
        this.$router.push('/')
      }).catch(err => {
        console.log(err)
      })
    }
  },
  beforeCreate: function () {
    EventHelper.init().catch(err => {
      console.log(err)
    })
  }
}
</script>

<style>
.create-event{
    margin-bottom: 20%;
}

</style>
