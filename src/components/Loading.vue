<template>
<div id='loadingHolder'>
  <div id='loadingSpinner' style="width:100px;height:100px;">
    <breeding-rhombus-spinner
      :animation-duration="2000"
      :size="70"
      color="#ff1d5e"
    />
  </div>
</div>
</template>

<script>
import { BreedingRhombusSpinner } from 'epic-spinners'

export default {
  name: 'Loading',
  components: {
    BreedingRhombusSpinner
  }
}
</script>

<style>
#loadingHolder{
  display:flex;
  justify-content:center;
  align-items:center;
  width:100vw;
  height:100vh;
  position: fixed;
  top:0;
  left:0;
  background-color: rgba(0,0,0,0.3);
}
</style>