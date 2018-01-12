<template>
  <div style="max-width: 300px;">
    <!--<h2>Topics:</h2>-->
    <b-list-group >
      <b-list-group-item href="#">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
      <b-list-group-item href="#" variant="primary">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
      <b-list-group-item href="#" variant="secondary">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
      <b-list-group-item href="#" variant="success">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
      <b-list-group-item href="#" variant="danger">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
      <b-list-group-item href="#" variant="warning">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
      <b-list-group-item href="#" variant="info">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
      <b-list-group-item href="#" variant="light">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
      <b-list-group-item href="#" variant="dark">
        <img class="topic-icon" src="../../assets/coin.png"/>
      </b-list-group-item>
    </b-list-group>
  </div>
</template>

<script>
export default {
  name: 'TopicList'
}
</script>

<style>
.topic-icon{
  width: 70%;
  max-width: 50px;
  max-height: 50px;
}
.list-group-item{
  /* padding: .75rem 0.25rem;*/
  padding: 0;
  margin:0;
}
</style>
