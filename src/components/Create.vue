<template>
  <div class="justify-content-md-center litle-margin">
    <!--Form-->
    <b-form @submit="onSubmit">
      <h2 style="margin-bottom: 2%;"> Create an event </h2>
      <!--Title-->
      <b-form-group id="titleGroup"
                    label="Title:"
                    label-for="titleInput"
                    style="margin-bottom: 0;">
        <b-form-input id="titleInput"
                      type="text"
                      maxlength="31"
                      placeholder="Short and clear name of the event"
                      v-model="form.title"
                      required>
        </b-form-input>
        <b-row style="padding-top: 3px" align-h="end">
          <vue-twitter-counter :current-length="31 - remchar2"
                                        safe="#ff66ff"
                                        :danger-at='31'
                                        :warnLength='5'
                                        animate
                                        round>
          </vue-twitter-counter>
        </b-row>
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
        <b-row style="padding-top: 3px" align-h="end">
          <vue-twitter-counter :current-length="140 - remchar"
                                        safe="#ff66ff"
                                        :danger-at='140'
                                        animate
                                        round>
          </vue-twitter-counter>
        </b-row>
      </b-form-group>

      <!--Topics-->
      <p class='info-section'>Topic:</p>
      <div v-if="windowWidth >= 800">
        <b-form-radio-group id="btnradios2"
                            buttons
                            button-variant="outline-primary"
                            required
                            size="sm"
                            v-model="form.topic"
                            :options="topics"
                            name="radioBtnOutline" />
        </b-form-radio-group>
      </div>
      <div v-else>
        <b-dropdown id="ddown" text="Select a topic" variant="primary" class="m-2">
          <b-form-radio-group id="btnradios3"
                              style="width: 100%"
                              buttons
                              stacked
                              required
                              button-variant="outline-primary"
                              v-model="form.topic"
                              :options="topics"
                              name="radioBtnOutline" />
          </b-form-radio-group>
        </b-dropdown>
      </div>
    </b-form-group>

    <br>
    <br>
    <!--Outcomes-->
    <p class='info-section'>Outcomes:</p>
    <b-row align-h="start" style="margin: 0 !important">
      <b-col style="padding-left: 0 !important">
        <label class="sr-only" for="option1Input" >Outcome1</label>
        <b-input class="mb-2 mr-sm-2 mb-sm-0"
                 id="option1Input"
                 v-model='form.option1'
                 maxlength="31"
                 required
                 placeholder="Outcome1"/>
        </b-col>
        <b-col style="padding-right: 0 !important">
          <label class="sr-only" for="option2Input">Outcome2</label>
          <b-input class="mb-2 mr-sm-2 mb-sm-0"
                   id="option2Input"
                   v-model='form.option2'
                   maxlength="31"
                   required
                   placeholder="Outcome2"/>
          </b-col>
        </b-row>

        <!--Times-->
        <br>
        <br>
        <span>Ending date and time: {{updateDate}}</span>
        <br>
        <b-form-slider
                   :v-model='hourValue'
                   :value='0'
                   :min='0'
                   :max='sliderMaxValue'
                   :step='1'
                   :ticks='sliderTicks'
                   :ticks-labels='sliderTicksLabels'
                   v-bind:rangeHighlights='highlights'
                   @change="changeSlider"
                   />
          <br>
          <br>
          <b-row align-h="start" style="margin: 0 !important">
            <b-col cols="12" sm="12" md="6" lg="6" style="padding-left: 0 !important">
              <p class="info-section">Waiting time until users can validate (hours):</p>
              <b-form-group id="durationTime"
                            label-for="durationTime">
                <b-form-input id="durationTime"
                              class="mb-2 mr-sm-2 mb-sm-0"
                              type="number"
                              step="0.1"
                              v-model="form.durationTime"
                              placeholder="Duration of the event"
                              required>
                </b-form-input>
              </b-form-group>
            </b-col>
            <small style="color:gray">Example: You can vote before a basketball game starts, and users can start validating two hours later, when the game has finished.</small>
            <small style="color:gray">Warning: Longer events than a week can't be validated</small>
          </b-row>

          <br>
          <b-button type="submit" variant="primary" size='lg'>Create</b-button>
        </b-form>
      <MetamaskAlert v-if='showMetamask'/>

  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'
// import ServerHelper from '@/js/ServerHelper'
import VueTwitterCounter from 'vue-twitter-counter'
import MetamaskAlert from './Common/MetamaskAlert.vue'

export default {
  name: 'Create',
  data () {
    return {
      showMetamask: false,
      value: 0,
      sliderMaxValue: 120,
      sliderTicks: [],
      sliderTicksLabels: [],
      highlights: [{ 'start': 0, 'end': 24, 'class': 'color-slider' },
                   { 'start': 24, 'end': 47, 'class': 'color1-slider' },
                   {'start': 47, 'end': 71, 'class': 'color2-slider'},
                   {'start': 71, 'end': 95, 'class': 'color3-slider'},
                   {'start': 95, 'end': 120, 'class': 'color4-slider'}],

      topics: ['Crypto', 'Celebrities', 'Entertainment', 'Gaming', 'Humor', 'News', 'Politics', 'Sports', 'Technology', 'Random'],
      form: {
        title: '',
        description: '',
        topic: '',
        date: null,
        durationTime: 1,
        option1: '',
        option2: ''
      },
      hourValue: 0,
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
    updateHighlights () {
      // TODO: Test org mode
      let endDay = 23 - this.$moment().format('H')
      this.highlights = []
      this.sliderTicks = []
      this.sliderTicksLabels = []
      var color = 'color-slider'

      this.sliderTicks.push(0)
      this.sliderTicksLabels.push('Today')
      this.highlights.push({'start': 0, 'end': endDay, 'class': color})
      let previous = endDay
      let actual = endDay + 24
      this.sliderTicks.push(endDay)
      this.sliderTicksLabels.push('Tomorrow')
      for (let i = 0; i < 5; i++) {
        color = 'color' + (i + 1) + '-slider'
        this.highlights.push({'start': previous, 'end': actual, 'class': color})
        previous = actual
        this.sliderTicks.push(actual)
        this.sliderTicksLabels.push('In ' + (i + 2) + ' days')
        actual += 24
        this.sliderMaxValue = actual - 24
      }
    },
    show (group, type = '') {
      var title = ''
      var text = ''
      if (type === 'success') {
        title = 'Data ready to be sent!'
        text = 'Ready to send your event, waiting for confirmation!'
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

      let finalDate = self.$moment().subtract(self.$moment().minute(), 'minutes').add(self.hourValue + 1, 'hours')
      let _durationTime = Math.ceil(self.form.durationTime)

      var validationDate = self.$moment(finalDate).add(_durationTime, 'hours')
      self.show('creation', 'success')
      // window.location.href = '#/play/' + this.form.topic
      GuessHelper.setGuessFront(
        this.form.title,
        this.form.description,
        this.form.topic,
        finalDate.unix(),
        validationDate.unix(),
        this.form.option1,
        this.form.option2).then(() => {
          console.log('Transaction pending...')
          /*
          self.form.title = ''
          self.form.description = ''
          self.form.topic = ''
          self.form.option1 = ''
          self.form.option2 = ''
          */
        }).catch(err => {
          self.show('creation', 'error')
          console.log(err)
        })
    },
    changeSlider: function (value) {
      let self = this

      self.hourValue = value.newValue // This is necesary becouse the v-model doesn't work
      var startTime = self.$moment().subtract(self.$moment().minute(), 'minutes').add(1, 'hours')
      self.form.date = startTime.add(self.hourValue, 'hours').format('MMMM D, YYYY [at] H[h]')
      self.updateDate = self.form.date
    }
  },
  computed: {
    remchar () {
      let self = this

      var charactersremaining = 140 - self.form.description.length
      return charactersremaining
    },
    remchar2 () {
      let self = this

      var charactersremaining = 31 - self.form.title.length
      return charactersremaining
    }
  },
  beforeCreate: function () {
    let self = this
    GuessHelper.init().then(() => {
      GuessHelper.getAddressRefreshed().then((add) => {
        if (add === null ||
            add.length === 0) {
          self.showMetamask = true
        } else {
          window.web3.eth.net.getId().then(netId => {
            switch (netId) {
              case 4:
                break
              default:
                self.showMetamask = true
            }
          })
        }
      })
    }).catch(err => {
      console.log(err)
    })
  },
  created: function () {
    let self = this

    var startTime = self.$moment().subtract(self.$moment().minute(), 'minutes').add(1, 'hours')
    self.form.date = startTime.format('MMMM D, YYYY [at] H[h]')
    self.updateDate = self.form.date
    this.updateHighlights()
  },
  components: {
    VueTwitterCounter,
    MetamaskAlert
  }
}
</script>

<style lang="scss">

$slider: #ff0d73;

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
.slider-tick {
  display: none;
}
.slider-tick-label {
}

.color-slider {
  background: $slider !important;
}
.color1-slider {
  background: lighten($slider, 10%) !important;
}
.color2-slider {
  background: lighten($slider, 16%) !important;
}
.color3-slider {
  background: lighten($slider, 24%) !important;
}
.color4-slider {
  background: lighten($slider, 32%) !important;
}
.color5-slider {
  background: lighten($slider, 40%) !important;
}
/*
.color1-slider {
  background: mix(#3200E8, #ff0d73, 100%);
}
.color2-slider {
  background: mix(#00DAFF, #ff0d73, 100%);
}
.color3-slider {
  background: mix(#00B208, #ff0d73, 100%);
}
.color4-slider {
  background: mix(#FFE800, #ff0d73, 100%);
}
.color5-slider {
  background: mix(#E86C00, #ff0d73, 100%);
}
 */
.slider-handle {
  background: #EB3874 !important;
}
.slider.slider-horizontal .slider-tick-label-container .slider-tick-label {
  color: gray !important;
}
.slider-selection.tick-slider-selection{
  background: lighten($slider, 30%) !important;
}
@media only screen and (max-width: 768px) {
  .slider.slider-horizontal .slider-tick-label-container .slider-tick-label {
    display: none !important;
  }
}
</style>
