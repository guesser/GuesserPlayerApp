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
import EventHelper from '@/js/Event'

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
      totalEvents: 0,
      totalEventsLoading: false,
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
  },
  methods: {
    getEvents () {
      for (var i = 0; i < this.totalEvents; i++) {
        console.log(i)
        EventHelper.getEventFront(i).then((event) => {
          console.log(event)
          this.events.push({
            'title': event[0],
            'description': event[1],
            'topic': event[2]
          })
        }).catch(err => {
          console.log(err)
        })
      }
    },
    getEventsNumber () {
      this.totalEventsLoading = true
      return EventHelper.getEventsNumber().then((number) => {
        this.totalEvents = number.c[0]
        return this.totalEvents
      }).catch(err => {
        console.log(err)
        this.totalEventsLoading = false
      })
    }
  },
  mounted: function () {
    let self = this
    this.getEventsNumber().then(function (number) {
      self.getEvents()
    })
  },
  beforeCreate: function () {
    EventHelper.init().catch(err => {
      console.log(err)
    })
  }
}

</script>
