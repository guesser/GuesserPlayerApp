<template>
  <b-row class="justify-content-md-center little-margin">
    <!--Alert-->
    <b-alert variant="success"
             dismissible
             :show="guessCreatedAlert"
             @dismissed="guessCreatedAlert=false">
      Guess being created!
    </b-alert>

    <!--Form-->
    <b-form @submit="onSubmit">
      <h2 style="margin-bottom: 2%;"> Create Guess </h2>
      <!--Title-->
      <b-form-group id="titleGroup"
                    label="Title:"
                    label-for="titleInput">
        <b-form-input id="titleInput"
                      type="text"
                      v-model="form.title"
                      required>
        </b-form-input>
      </b-form-group>

      <!--Description-->
      <b-form-group id="descriptionGroup"
                    label="Description:"
                    label-for="descriptionInput">
        <b-form-textarea id="descriptionInput"
                         v-model="form.description"
                         required>
        </b-form-textarea>
      </b-form-group>

      <!--Topics-->
      <p class='info-section'>Topics:</p>
      <b-form-radio-group id="btnradios2"
                          buttons
                          button-variant="outline-primary"
                          size="sm"
                          v-model="form.topic"
                          :options="topics"
                          name="radioBtnOutline" />
      </b-form-group>
    </b-form-group>

    <br>
    <br>
    <!--Options-->
    <p class='info-section'>Options:</p>
    <b-form inline>
      <label class="sr-only" for="option1Input">Option1</label>
      <b-input class="mb-2 mr-sm-2 mb-sm-0"
               id="option1Input"
               v-model='form.option1'
               placeholder="Option1"/>
        <label class="sr-only" for="option2Input">Option2</label>
        <b-input class="mb-2 mr-sm-2 mb-sm-0"
                 id="option2Input"
                 v-model='form.option2'
                 placeholder="Option2"/>
        </b-form>

        <br>

        <b-button type="submit" variant="primary">Create</b-button>
      </b-form>
    </b-row>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'Create',
  data () {
    return {
      guessCreatedAlert: false,
      topics: ['Crypto', 'eSports', 'Entertainment', 'Random'],
      form: {
        title: '',
        description: '',
        topic: '',
        option1: '',
        option2: ''
      }
    }
  },
  methods: {
    onSubmit (evt) {
      evt.preventDefault()

      let self = this
      // alert(JSON.stringify(this.form))
      let date = (new Date()).getSeconds()
      let birthDateInUnixTimestamp = date / 1000
      GuessHelper.setGuessFront(
        this.form.title,
        this.form.description,
        this.form.topic,
        birthDateInUnixTimestamp,
        this.form.option1,
        this.form.option2).then(() => {
          console.log('Transaction pending...')
          self.guessCreatedAlert = true
        }).catch(err => {
          console.log(err)
        })
    }
  },
  beforeCreate: function () {
    GuessHelper.init().catch(err => {
      console.log(err)
    })
  }
}
</script>

<style>
.info-section{
  margin-bottom: 3px;
}
.row{
  margin-left: 2% !important;
  margin-right: 2% !important;
}
.litle-margin{
  max-width: 500px;
}
</style>
