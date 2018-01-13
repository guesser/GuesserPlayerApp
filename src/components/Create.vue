<template>
    <b-row class="justify-content-md-center little-margin">
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
                          v-model="selected"
                          :options="topics"
                          name="radioBtnOutline" />
      </b-form-group>
    </b-form-group>

    <br>
    <br>
    <!--Options-->
    <p class='info-section'>Options:</p>
    <b-form inline>
      <label class="sr-only" for="inlineFormInputName2">Option1</label>
      <b-input class="mb-2 mr-sm-2 mb-sm-0" id="inlineFormInputName2" placeholder="Option1"/>
        <label class="sr-only" for="inlineFormInputName2">Option2</label>
        <b-input class="mb-2 mr-sm-2 mb-sm-0" id="inlineFormInputName2" placeholder="Option2"/>
        </b-form>

        <br>

        <b-button type="submit" variant="primary">Create</b-button>
      </b-form>
    </b-row>
</template>

<script>
export default {
  name: 'Create',
  data () {
    return {
      topics: ['Crypto', 'eSports', 'Entertainment', 'Random'],
      form: {
        title: '',
        description: ''
      }
    }
  },
  methods: {
    onSubmit (evt) {
      evt.preventDefault()
      alert(JSON.stringify(this.form))
    }
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
