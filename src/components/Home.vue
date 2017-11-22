<template>
    <div>
    <!--Here ends the pull to refresh-->
    <div id='content' class="container">
        <SearchHeaderBar/>
        <div class='cards'>
            <div v-for='guess in guesses'>
                    <GuessCard 
                        :title="guess.title" 
                        :description="guess.description"
                        :option1="guess.option1"
                        :option2="guess.option2"
                        :option3="guess.option3"
                        :option4="guess.option4"/>
            </div>
        </div>
        
    </div>
    </div>
</template>

<script>
// Contract helpers
import Guess from '@/js/Guess'

// Vue components
import SearchHeaderBar from './SearchHeaderBar.vue'
import GuessCard from './GuessCard.vue'

export default {
  name: 'home',
  data () {
    return {
      guesses: [],
      totalGuesses: 0, // This is total number of guesses
      totalGuessesLoading: false
    }
  },
  components: {
    SearchHeaderBar,
    GuessCard
  },
  methods: {
    getGuesses () {
      for (var i = 0; i < this.totalGuesses; i++) {
        Guess.getGuessFront(i).then((guess) => {
          console.log(guess)
          this.guesses.push({
            'title': guess[0],
            'description': guess[1],
            'option1': guess[2],
            'option2': guess[3],
            'option3': guess[4],
            'option4': guess[5]
          })
        }).catch(err => {
          console.log(err)
        })
      }
    },
    getGuessesNumber () {
      this.totalGuessesLoading = true
      return Guess.getGuessesNumber().then((number) => {
        this.totalGuesses = number.c[0]
        return this.totalGuesses
      }).catch(err => {
        console.log(err)
        this.totalGuessesLoading = false
      })
    }

  },
  mounted: function () {
    let self = this
    this.getGuessesNumber().then(function (number) {
      self.getGuesses()
    })
  },
  beforeCreate: function () {
    Guess.init().catch(err => {
      console.log(err)
    })
  }
}
</script>

<style>
.md-accent{
    margin-bottom: 10px;
}
.md-card-header-text{
    text-align:left;
}
.container{
    padding-bottom: 60px;
}
.cards{
    padding-left: 3%;
    padding-right: 3%;
}
</style>
