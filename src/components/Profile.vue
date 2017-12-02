<template>
<div class='bottom-margin'>
    
    <div class="viewport">  
      <div>  
        <md-avatar class="md-avatar-icon md-large">
            <img src="https://static.standard.co.uk/s3fs-public/styles/story_large/public/thumbnails/image/2014/03/07/11/BItcoin.jpg" alt="Avatar">
        </md-avatar>
      </div>

      <h1 class="">Satoshi Nakamoto</h1>

      <md-divider class=""></md-divider>
      
      <md-list class="md-double-line">
        <md-list-item>
          <div class="md-list-item-text">
            <md-subheader>Total</md-subheader>
            <span>123,534</span>
            <span>ETH</span>
          </div>

          <div class="md-list-item-text">
            <md-subheader>Spent</md-subheader>
            <span>12,44</span>
            <span>ETH</span>
          </div>
       </md-list-item>
      </md-list>
      
      <md-divider class=""></md-divider>

    </div>
       <GuessesBottomProfile/>
</div>
</template>

<script>
// Vue components
import GuessesBottomProfile from './ProfileComponents/GuessesBottomProfile.vue'

export default {
  name: 'profile',
  components: {
    GuessesBottomProfile
  }
}
</script>

<style lang="scss" scoped>
.viewport {
    width: 70%;
    max-width: 100%;
    display: inline-block;
    vertical-align: top;
    overflow: auto;
  }
.md-avatar {
    width: 50%;
    height: 50%;
    margin-top: 7%;
}
.bottom-margin{
    padding-bottom: 17%;
}
</style>
