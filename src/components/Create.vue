<template>
<div class="justify-content-md-center litle-margin">
  <!--Alert-->
  <notifications group="creation"
                 position="top center"
                 classes="vue-notification creation"
                 :max="2"
                 :speed="500" />

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
                  label-for="descriptionInput"
                  style="margin-bottom: 0">
      <b-form-textarea id="descriptionInput"
                       maxlength="140"
                       placeholder="Tell people about what's happening in 140 characters"
                       v-model="form.description"
                       required>
      </b-form-textarea>
      <b-row style="padding-top: 10px" align-h="center">
        <vue-twitter-counter :current-length="140 - remchar"
                             safe="#ff66ff"
                             :danger-at='140'
                             animate
                             round>
        </vue-twitter-counter>
      </b-row>
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
  <b-dropdown id="ddown" text="Select a topic" variant="primary" class="m-2">
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
  <span>Ending date and time: {{updateDate}}</span>
<br>
 <input
  id="sliderRange"
  type="text"
  data-provide="slider"
  data-slider-min="0"
  data-slider-max="119"
  data-slider-step="1"
  data-slider-value="0"
  data-slider-rangeHighlights='[{ "start": 0, "end": 24, "class": "primary-slider" },
                                   { "start": 24, "end": 47, "class": "secondary-slider" },
                                   { "start": 47, "end": 71, "class": "primary-slider"},
                                   { "start": 71, "end": 95, "class": "secondary-slider"},
                                   { "start": 95, "end": 119, "class": "primary-slider"}]'/>
<b-form-slider
  :v-model='hourValue'
  :value='0'
  :min='0'
  :max='119'
  :step='1'
  :rangeHighlights='highlights'
  @change="changeSlider"
  />

</div>
<br>
<br>
<b-button type="submit" variant="primary" size='lg'>Create</b-button>
</b-form>
</div>
</template>

<script>
import GuessHelper from '@/js/Guess'
// import ServerHelper from '@/js/ServerHelper'
import VueTwitterCounter from 'vue-twitter-counter'

export default {
  name: 'Create',
  data () {
    return {
      value: 0,
      highlights2: [{'start': 15, 'end': 47, 'class': 'primary-slider'}],
      highlights: [{ 'start': 0, 'end': 24, 'class': 'primary-slider' },
                   { 'start': 24, 'end': 47, 'class': 'secondary-slider' },
                   {'start': 47, 'end': 71, 'class': 'primary-slider'},
                   {'start': 71, 'end': 95, 'class': 'secondary-slider'},
                   {'start': 95, 'end': 119, 'class': 'primary-slider'}],

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
      updateDate: '',
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
    /*
     signData () {
      let msgParams = [
        {
          type: 'string',      // Any valid solidity type
          name: 'username',     // Any string label you want
          value: 'carlosgj94'  // The value to sign
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
        })
      })
    },
    retrieveData () {
      ServerHelper.getUsername(GuessHelper.address[0]).then((data) => {
        console.log(data)
      })
    }, */
    show (group, type = '') {
      var title = ''
      var text = ''
      if (type === 'success') {
        title = 'Creation success!'
        text = 'Your event has been pushed to the network'
      } else {
        title = 'Creation error!'
        text = 'Event creation failed, try again'
      }
      this.$notify({
        group,
        title,
        text,
        type
      })
    },
    onSubmit (evt) {
      evt.preventDefault()
      let self = this

      let finalDate = self.$moment().subtract(self.$moment().minute(), 'minutes').add(self.hourValue, 'hours').unix()
      GuessHelper.setGuessFront(
        this.form.title,
        this.form.description,
        this.form.topic,
        finalDate,
        this.form.option1,
        this.form.option2).then(() => {
          console.log('Transaction pending...')
          self.show('creation', 'success')
          self.form.title = ''
          self.form.description = ''
          self.form.topic = ''
          self.form.option1 = ''
          self.form.option2 = ''
        }).catch(err => {
          self.show('creation', 'error')
          console.log(err)
        })
    },
    changeSlider: function (value) {
      let self = this

      var startTime = self.$moment().subtract(self.$moment().minute(), 'minutes')
      self.form.date = startTime.add(value.newValue, 'hours').format('MMMM D, YYYY [at] H[h]')
      self.updateDate = self.form.date
    }
  },
  computed: {
    remchar () {
      let self = this

      var charactersremaining = 140 - self.form.description.length
      return charactersremaining
    }
  },
  beforeCreate: function () {
    GuessHelper.init().catch(err => {
      console.log(err)
    })
  },
  created: function () {
    let self = this

    var startTime = self.$moment().subtract(self.$moment().minute(), 'minutes')
    self.form.date = startTime.add(0, 'hours').format('MMMM D, YYYY [at] H[h]')
    self.updateDate = self.form.date
  },
  components: {
    VueTwitterCounter
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
.btn-primary.dropdown-toggle:focus {
    box-shadow: 0 0 0 0.2rem #ff0d73 !important;
}
.creation{
    margin: 5px;
    border-radius: 2px;
    border-left: 0px !important;
}

.d-inline-block {
    display: inline !important;
}
.slider.slider-horizontal {
    width: 100% !important;
}
.slider {
    width: 100% !important;
}
.slider-tick-label {
}

.primary-slider {
    background: purple;
}
.secondary-slider {
  background: pink;
}
.slider-handle {
  background: #EB3874;
}
</style>
