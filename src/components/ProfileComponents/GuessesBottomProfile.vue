<template>
    <div>
      <md-bottom-bar md-type="shift" class="md-accent">
          <md-bottom-bar-item id="bottom-bar-item-home" md-label="Current">
              <h3>Current</h3>
          </md-bottom-bar-item>
        <md-bottom-bar-item id="bottom-bar-item-pages" md-label="Past">
            <h3>Past</h3>
        </md-bottom-bar-item>
      </md-bottom-bar>
      <GuessCard/>
      <GuessCard/>
      <GuessCard/>
    </div>
</template>

<script>
import GuessCard from '../GuessCard.vue'

export default{
  name: 'GuessesBottomProfile',
  components: {
    GuessCard
  }
}
</script>

<style scoped>
div.md-bottom-bar.md-accent.md-theme-default.md-fixed{
    background: #ffeb3b;
    box-shadow: none;
}
button#bottom-bar-item-home.md-bottom-bar-item.md-active{
color: #e91e63;
}
.md-theme-default.md-bottom-bar.md-fixed.md-accent .md-bottom-bar-item.md-active{
color: #e91e63;
}
</style>
