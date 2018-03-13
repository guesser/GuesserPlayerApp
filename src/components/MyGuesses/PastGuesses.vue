<template>
  <div>
<b-card-group deck class="mb-3">
            <b-card border-variant="primary"
              header="Primary"
              header-bg-variant="primary"
              header-text-variant="black"
              align="center">
              <p class="card-text">
                From: <b>March 8th 2018, 1 pm</b>
                <br>
                To: <b>March 8th 2018, 10 pm</b>
              </p>
              <b-button style="margin-right: 20px" @click="showPaymentModal"
                variant="outline-pink" size="sm"> Vote1
              </b-button>
              <b-button  @click="showPaymentModal"
                variant="outline-magenta" size="sm"> Vote2
              </b-button>
            </b-card>

          </b-card-group>
          <!-- Modal Payment -->
          <div>
            <b-modal ref="paymentModal"
              centered
              title="Vote an event"
              hide-footer
              :header-bg-variant="pink">
              <label>Title: </label>
              <br>

              <label>Description: </label>
              <br>

              <span>Number of votes in each option: </span>
              <b-progress class="mt-1" :max="20" show-value striped>
                <b-progress-bar :value="10" variant="pink">
                </b-progress-bar>
                <b-progress-bar :value="10" variant="magenta">
                </b-progress-bar>
              </b-progress>
              <small>Total: 10 people</small>
              <br>
              <br>

              <b-form-group id="titleGroup"
                label="Ether amount to send:"
                label-for="amountInput">
                <b-form-input id="amountInput"
                  type="number"
                  v-model="ethAmountToVote"
                  required>
                </b-form-input>
              </b-form-group>
              <b-button @click="" variant="primary" size="sm">Vote</b-button>
            </b-modal>
          </div>
          </div>
</template>

<script>
export default {
  name: 'PastGuesses',
  data () {
    return {
    }
  },
  methods: {
    showPaymentModal () {
      this.$refs.paymentModal.show()
    },
    hidePaymentModal () {
      this.$refs.paymentModal.hide()
    }
  }
}
</script>
