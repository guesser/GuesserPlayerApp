<template>
  <div class="justify-content-md-center litle-margin">
    <!--Alert-->
    <b-alert variant="success"
             dismissible
             :show="guessCreatedAlert"
             @dismissed="showCreatedAlert=false">
      Event being created!
    </b-alert>

    <!--Form-->
    <b-form @submit="onSubmit">
      <h2 style="margin-bottom: 2%;"> Create an event </h2>
      <!--Title-->
      <b-form-group id="titleGroup"
                    label="Title:"
                    label-for="titleInput">
        <b-form-input id="titleInput"
                      type="text"
                      maxlength="31"
                      placeholder="Short and clear name of the event"
                      v-model="form.title"
                      required>
        </b-form-input>
      </b-form-group>

      <!--Description-->
      <b-form-group id="descriptionGroup"
                    label="Description:"
                    label-for="descriptionInput">
        <b-form-textarea id="descriptionInput"
                         maxlength="140"
                         placeholder="Tell people about what's happening in 140 characters"
                         v-model="form.description"
                         required>
        </b-form-textarea>
        <!--TODO: Update when change input-->
        <!--<span> {{ remchar }} characters remaining</span>-->
      </b-form-group>

      <!--Topics-->
      <p class='info-section'>Topic:</p>
      <div v-if="windowWidth >= 800">
        <b-form-radio-group id="btnradios2"
                            buttons
                            button-variant="outline-primary"
                            size="sm"
                            v-model="form.topic"
                            :options="topics"
                            name="radioBtnOutline" />
        </b-form-group>
      </div>
      <div v-else>
        <b-dropdown id="ddown-header" text="Select a topic" variant="primary" class="m-2">
          <b-form-radio-group id="btnradios3"
                              style="width: 100%"
                              buttons
                              stacked
                              button-variant="outline-primary"
                              v-model="form.topic"
                              :options="topics"
                              name="radioBtnOutline" />
          </b-form-group>
        </b-dropdown>
      </div>
    </b-form-group>

    <br>
    <br>
    <!--Outcomes-->
    <p class='info-section'>Outcomes:</p>
    <b-form inline>
      <label class="sr-only" for="option1Input" >Outcome1</label>
      <b-input class="mb-2 mr-sm-2 mb-sm-0"
               id="option1Input"
               v-model='form.option1'
               maxlength="31"
               placeholder="Outocome1"/>
        <label class="sr-only" for="option2Input">Outcome2</label>
        <b-input class="mb-2 mr-sm-2 mb-sm-0"
                 id="option2Input"
                 v-model='form.option2'
                 maxlength="31"
                 placeholder="Outcome2"/>
        </b-form>
        <div>
          <br>
          <span>Ending date and time: {{form.date}}</span>
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
        <br>
        <br>

        <b-button type="submit" variant="primary" size='lg'>Create</b-button>
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
      remchar: 140,
      hourValue: 1,
      windowWidth: window.innerWidth,
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
      self.form.date = startTime.add(hour, 'hours').format('MMMM D, YYYY [at] H[h]')
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
    GuessHelper.init().then(() => {
      // GuessHelper.CreatedGuessEvent()
    }).catch(err => {
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
  margin: 0% 10%;
  padding: 3% 0%;
  max-width: 800px;
}
</style>
