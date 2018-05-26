<template>
  <div class="topicList" style="max-width: 300px;">
    <!--<h2>Topics:</h2>-->
    <b-list-group >
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Crypto') }" href="#play/Crypto" @click='topiClick("Crypto")' variant="Crypto">
        <img class="topic-icon" src="../../assets/bitcoin.png"/>
        <span class="toplist">Crypto</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Celebrities') }" href="#play/Celebrities" @click='topiClick("Celebrities")' variant="Celebrities">
        <img class="topic-icon" src="../../assets/sunglasses.png"/>
        <span class="toplist">Celebrities</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Entertainment') }" href="#play/Entertainment" @click='topiClick("Entertainment")' variant="Entertainment">
        <img class="topic-icon" src="../../assets/monitor.png"/>
                <span class="toplist">Entertainment</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Gaming') }" href="#play/Gaming" @click='topiClick("Gaming")' variant="Gaming">
        <img class="topic-icon" src="../../assets/gamepad.png"/> 
        <span class="toplist">Gaming</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Humor') }" href="#play/Humor" @click='topiClick("Humor")' variant="Humor">
        <img class="topic-icon" src="../../assets/cat.png"/>
        <span class="toplist">Humor</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('News') }" href="#play/News" @click='topiClick("News")' variant="News">
        <img class="topic-icon" src="../../assets/text-lines.png"/>
        <span class="toplist">News</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Politics') }" href="#play/Politics" @click='topiClick("Politics")' variant="Politics">
        <img class="topic-icon" src="../../assets/mayor.png"/>
        <span class="toplist">Politics</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Sports') }" href="#play/Sports" @click='topiClick("Sports")' variant="Sports">
        <img class="topic-icon" src="../../assets/cup.png"/>
        <span class="toplist">Sports</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Technology') }" href="#play/Technology" @click='topiClick("Technology")' variant="Technology">
        <img class="topic-icon" src="../../assets/robot.png"/>
        <span class="toplist">Technology</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected('Random') }" href="#play/Random" @click='topiClick("Random")' variant="Random">
        <img class="topic-icon" src="../../assets/vomiting.png"/>
        <span class="toplist">Random</span>
      </b-list-group-item>
    </b-list-group>
  </div>
</template>

<script>
export default {
  name: 'TopicList',
  data () {
    return {
      selected: ''
    }
  },
  methods: {
    topiClick (topic) {
      this.selected = topic
    },
    isSelected (i) {
      return i === this.selected
    }
  },
  watch: {
    '$route': function () {
      this.topic = this.$route.params.topic
      this.selected = this.topic
    }
  },
  created: function () {
    if (this.$route.params.topic) {
      this.topic = this.$route.params.topic
    } else {
      this.topic = 'Crypto'
    }
    this.selected = this.topic
  }
}
</script>

<style>
.topic-icon{
  width: 23%;
  min-width: 40px;
  margin-right: 10px;
}
.list-group-item{
  /* padding: .75rem 0.25rem; */
  padding: .25rem;
  margin:0;
  display: block;
  height: 100%;
}
.list-group-item.active{
  margin-bottom: 7px;
  margin-top: 7px;
  border-width: 1.5px;
}
</style>
