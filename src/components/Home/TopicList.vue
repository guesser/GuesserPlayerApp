<template>
  <div style="max-width: 300px;">
    <!--<h2>Topics:</h2>-->
    <b-list-group >
      <b-list-group-item href="#" @click='topiClick("crypto")' variant="crypto">
        <img class="topic-icon" src="../../assets/bitcoin.png"/>
        Crypto
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("celebrities")' variant="celebrities">
        <img class="topic-icon" src="../../assets/sunglasses.png"/>
        Celebrities
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("entertainment")' variant="entertainment">
        <img class="topic-icon" src="../../assets/monitor.png"/>
        Entertainment
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("gaming")' variant="gaming">
        <img class="topic-icon" src="../../assets/gamepad.png"/>
        Gaming
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("humor")' variant="humour">
        <img class="topic-icon" src="../../assets/cat.png"/>
        Humour
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("news")' variant="news">
        <img class="topic-icon" src="../../assets/text-lines.png"/>
        News
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("politics")' variant="politics">
        <img class="topic-icon" src="../../assets/mayor.png"/>
        Politics
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("sport")' variant="sport">
        <img class="topic-icon" src="../../assets/cup.png"/>
        Sports
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("technology")' variant="technology">
        <img class="topic-icon" src="../../assets/robot.png"/>
        Technology
      </b-list-group-item>
      <b-list-group-item href="#" @click='topiClick("random")' variant="random">
        <img class="topic-icon" src="../../assets/vomiting.png"/>
        Random
      </b-list-group-item>
    </b-list-group>
  </div>
</template>

<script>
export default {
  name: 'TopicList',
  methods: {
    topiClick (topic) {
      this.$emit('topic-updated', topic)
    }
  }
}
</script>

<style>
.topic-icon{
  width: 70%;
  max-width: 50px;
  max-height: 50px;
}
.list-group-item{
  /* padding: .75rem 0.25rem; */
  padding: 0;
  margin:0;
}
</style>
