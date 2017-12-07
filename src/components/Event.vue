<template>
     <div>
    <!--Here ends the pull to refresh-->
    <div id='content' class="container">
        <SearchHeaderBar/>
        <div class='cards'>
            <div v-for='event in events'>
                    <EventCard 
                        :title="event.title" 
                        :description="event.description"
                        :topic="event.topic"
                        :people="event.people"
                        :option1="event.option1"
                        :option2="event.option2"
                        :option3="event.option3"
                        :option4="event.option4"/>
            </div>
        </div>
        
    </div>
    </div>
</template>

<script>

import SearchHeaderBar from './EventComponents/SearchHeaderBar.vue'
import EventCard from './EventComponents/EventCard.vue'

export default{
  name: 'Event',
  components: {
    SearchHeaderBar,
    EventCard
  },
  data () {
    return {
      events: [
        {
          title: 'Hola',
          description: 'HolaHola',
          topic: 'crypto',
          people: 32,
          option1: 'yes',
          option2: 'no'
        },
        {
          title: 'Hola1',
          description: 'HolaHola1',
          topic: 'esports',
          people: 120,
          option1: 'yes',
          option2: 'no'
        }
      ]
    }
  }
}

</script>
