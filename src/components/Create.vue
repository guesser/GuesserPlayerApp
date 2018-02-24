<template>
  <div class="justify-content-md-center litle-margin">
    <!--Alert-->
    <b-alert variant="success"
             dismissible
             :show="guessCreatedAlert"
             @dismissed="showCreatedAlert=false">
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
        <div>
          <br>
          <span>End date: {{form.date}}</span>
          <V<VueSlideBar
                 v-model="hourValue"
                 :min="1"
                 :max="168"
                 :processStyle="slider.processStyle"
                 :lineHeight="slider.lineHeight"
                 :tooltipStyles="{ backgroundColor: '#ff0d73', borderColor: '#ff0d73',
                 color: '#ff0d73'}">
          </VueSlideBar>
        </div>
        <br>

        <b-button type="submit" variant="primary">Create</b-button>
      </b-form>
    </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
import VueSlideBar from 'vue-slide-bar'

export default {
  name: 'Create',
  data () {
    return {
      guessCreatedAlert: false,
      topics: ['Crypto', 'Celebrities', 'Entertainment', 'Gaming', 'Humor', 'News', 'Politics', 'Sports', 'Technology', 'Random'],
      form: {
        title: '',
        description: '',
        topic: '',
        date: null,
        option1: '',
        option2: ''
      },
      hourValue: 1,
      slider: {
        lineHeight: 10,
        processStyle: {
          backgroundColor: '#ff0d73'
        }
      }
    }
  },
  methods: {
    updateDate (hour) {
      let self = this

      var startTime = self.$moment()
      self.form.date = startTime.add(hour, 'hours').format('dddd, D [at] hA')
    },
    onSubmit (evt) {
      evt.preventDefault()

      let self = this
      let finalDate = self.$moment().add(self.hourValue, 'hours').unix()
      GuessHelper.setGuessFront(
        this.form.title,
        this.form.description,
        this.form.topic,
        finalDate,
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
  },
  watch: {
    hourValue: function (hourValue) {
      this.updateDate(hourValue)
    }
  },
  components: {
    VueSlideBar
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
  margin: 5% 10%;
  max-width: 800px;
}
</style>
