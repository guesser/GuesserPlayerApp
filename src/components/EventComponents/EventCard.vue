<template>
    <md-card v-bind:class='topic' class='event'>
     <md-card-header class='event-header'>
       <md-card-header-text>
        <div class="md-title">{{title}}</div>
       </md-card-header-text>
       <md-card-media>
        <img v-if='topic=="crypto"' style="width:55px;" src="../../assets/coin.png"/>
        <img v-if='topic=="esports"' style="width:55px;" src="../../assets/esports.png"/>
      </md-card-media>
      </md-card-header>
       
      <md-card-expand v-bind:class='topic'>
        <md-card-actions md-alignment="space-between" v-bind:class='topic'>
          <div>
            <md-button class="md-raised md-primary" @click="voteEvent">Vote</md-button>
            <span class='md-subhead center-people'>{{people}}<img src='../../assets/beard.png' width='24' />already did</span>
          </div>

          <md-card-expand-trigger >
            <md-button class="md-icon-button">
              <md-icon>keyboard_arrow_down</md-icon>
            </md-button>
          </md-card-expand-trigger>
        </md-card-actions>

        <md-card-expand-content>
          <md-card-content>
          <h4>Description: </h4>
            {{description}}
          <h4>Options: </h4>
          <md-button disabled> {{option1}}</md-button>
          <md-button disabled> {{option2}}</md-button>

          <md-button disabled v-if='option3'> {{option3}}</md-button>
          <md-button disabled v-if='option4'> {{option4}}</md-button>

          </md-card-content>
        </md-card-expand-content>
      </md-card-expand>
    </md-card>
</template>

<script>
import EventHelper from '@/js/Event'

export default {
  name: 'EventCard',
  props: ['id', 'title', 'description', 'topic', 'option1', 'option2', 'option3', 'option4', 'people'],
  methods: {
    voteEvent () {
      EventHelper.voteEvent(this.id).catch(err => {
        console.log(err)
      })
    }
  }
}
</script>

<style>
.event{
  margin-top: 8px;
}
.event-header{
  padding-bottom: 4px;
  padding-left: 10px;
}
.md-card-header-text{
  flex: 0 !important;
}
.md-card .md-subhead {
  line-height: 35px;
  opacity: .74;
}
.center-people{
  font-size: 10px !important;
}
.md-card-media{
  width: 0 !important;
  height:0 !important;
}

/* Topics styles */
.crypto{
  background-color: #9ebbc4 !important;
}
.esports{
  background-color: #e6b7be !important;

}
</style>
