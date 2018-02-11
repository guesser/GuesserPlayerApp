<template>
  <div>
    <b-card-group deck class="mb-3">
      <!--TODO: Load Dinamically-->
      <div v-for='guess in guesses'>
        <b-card :border-variant="topic"
                       :header="guess.title"
                       :header-border-variant="topic"
                       header-text-variant="black"
                       align="center">
          <p class="card-text">{{ guess.description }}</p>
        </b-card>
      </div>
    </b-card-group>
  </div>
</template>

<script>
import GuessHelper from '@/js/Guess'

export default {
  name: 'OtherGuesses',
  props: ['topic'],
  data () {
    return {
      guesses: [],
      guessesByNumber: [],
      totalGuesses: 0
    }
  },
  methods: {
    printGuesses () {
      for (var i = 0; i < this.totalGuesses; i++) {
        GuessHelper.getGuessFront(i).then((guess) => {
          console.log(guess)
          this.guesses.push({
            'title': guess[0],
            'description': guess[1],
            'topic': guess[2],
            'votes': guess[3],
            'startingDay': guess[4],
            'finishingDay': guess[5]
          })
        }).catch(err => {
          console.log(err)
        })
      }
    },

    getGuessesOfTheDay () {
      let self = this

      GuessHelper.getGuessesOfTheDay(0, this.topic).then((_guesses) => {
        console.log(_guesses)
        self.guessesByNumber = _guesses
        self.printGuesses()
      }).catch(err => {
        console.log(err)
      })
    }
  },

  created: function () {
    GuessHelper.init().then(() => {
      this.getGuessesOfTheDay()
    }).catch(err => {
      console.log(err)
    })
  },

  watch: {
    topic: function () {
      this.getGuessesOfTheDay()
    }
  }
}
</script>

<style>

</style>
