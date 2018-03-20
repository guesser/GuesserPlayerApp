<template>
  <div class="topicList" style="max-width: 300px;">
    <!--<h2>Topics:</h2>-->
    <b-list-group >
      <b-list-group-item v-bind:class="{ 'active' : isSelected(0) }" href="#" @click='topiClick("Crypto", 0)' variant="Crypto">
        <img class="topic-icon" src="../../assets/bitcoin.png"/>
        <span class="toplist">Crypto</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(1) }" href="#" @click='topiClick("Celebrities", 1)' variant="Celebrities">
        <img class="topic-icon" src="../../assets/sunglasses.png"/>
        <span class="toplist">Celebrities</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(2) }" href="#" @click='topiClick("Entertainment", 2)' variant="Entertainment">
        <img class="topic-icon" src="../../assets/monitor.png"/>
                <span class="toplist">Entertainment</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(3) }" href="#" @click='topiClick("Gaming", 3)' variant="Gaming">
        <img class="topic-icon" src="../../assets/gamepad.png"/> 
        <span class="toplist">Gaming</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(4) }" href="#" @click='topiClick("Humor", 4)' variant="Humor">
        <img class="topic-icon" src="../../assets/cat.png"/>
        <span class="toplist">Humor</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(5) }" href="#" @click='topiClick("News", 5)' variant="News">
        <img class="topic-icon" src="../../assets/text-lines.png"/>
        <span class="toplist">News</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(6) }" href="#" @click='topiClick("Politics", 6)' variant="Politics">
        <img class="topic-icon" src="../../assets/mayor.png"/>
        <span class="toplist">Politics</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(7) }" href="#" @click='topiClick("Sports", 7)' variant="Sports">
        <img class="topic-icon" src="../../assets/cup.png"/>
        <span class="toplist">Sports</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(8) }" href="#" @click='topiClick("Technology", 8)' variant="Technology">
        <img class="topic-icon" src="../../assets/robot.png"/>
        <span class="toplist">Technology</span>
      </b-list-group-item>
      <b-list-group-item v-bind:class="{ 'active' : isSelected(9) }" href="#" @click='topiClick("Random", 9)' variant="Random">
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
      selected: 0
    }
  },
  methods: {
    topiClick (topic, topicNumber) {
      this.selected = topicNumber
      this.$emit('topic-updated', topic)
    },
    isSelected (i) {
      return i === this.selected
    }
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
