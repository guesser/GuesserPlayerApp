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

import SearchHeaderBar from './EventComponents/SearchHeaderBar.vue'
import GuessCard from './GeneralComponents/GuessCard.vue'

export default{
  name: 'Event',
  components: {
    SearchHeaderBar,
    GuessCard
  }
}

</script>
