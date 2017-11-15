<template>
<div>
    
    <div class="viewport">  
      <div>  
        <md-avatar class="md-avatar-icon md-large">
            <img src="http://www.drunkmall.com/wp-content/uploads/2016/04/Dickhead-Mask.jpg" alt="Avatar">
        </md-avatar>
      </div>

      <h1 class="">Dickhead</h1>

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

      <md-list class="md-double-line">
        <md-list-item>
          <div class="md-list-item-text">
            <md-subheader>Score</md-subheader>
            <span>1235</span>
          </div>
         
          <div class="md-list-item-text">
            <md-subheader>Rank</md-subheader>
            <span>100</span>
          </div>

          <div class="md-list-item-text">
            <md-subheader>Streak</md-subheader>
            <span>12</span>
          </div>
         </md-list-item>
       </md-list>
       
       <md-divider class=""></md-divider>

        <div>
            <md-button class="md-primary">Current</md-button>
            <md-button class="md-primary">Past</md-button>
         </div>
    </div>

</div>
</template>

<script>
export default {
  name: 'profile'
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
</style>
