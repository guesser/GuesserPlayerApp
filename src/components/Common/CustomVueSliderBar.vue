<template>
  <div>
    <div class="range">
      <input type="range" min="1" max="70" steps="1" value="1">
    </div>

    <ul class="range-labels">
      <li class="active selected">Today</li>
      <li>2 days</li>
      <li>3 days</li>
      <li>4 days</li>
      <li>5 days</li>
      <li>6 days</li>
      <li>7 days</li>
    </ul>
  </div>
</template>

<script>
  export default {
    name: 'VueSlideBar'
  }
</script>

<style>
body {
  padding: 100px;
}

@mixin rangeThumb {
  width: 18px;
  height: 18px;
  margin: -8px 0  0;
  border-radius: 50%;
  background: #37adbf;
  cursor: pointer;
  border: 0 !important;
}

@mixin rangeTrack {
  width: 100%;
  height: 2px;
  cursor: pointer;
  background: #b2b2b2;
}

.range {
  position: relative;
  width: 550px;
  height: 5px;
}

.range input {
  width: 100%;
  position: absolute;
  top: 2px;
  height: 0;
  -webkit-appearance: none;
}

// Labels below slider
.range-labels {
  margin: 18px -41px 0;
  padding: 0;
  list-style: none;
  
  li {
    position: relative;
    float: left;
    width: 90.25px;
    text-align: center;
    color: #b2b2b2;
    font-size: 14px;
    cursor: pointer;
    
    &::before {
      position: absolute;
      top: -25px;
      right: 0;
      left: 0;
      content: "";
      margin: 0 auto;
      width: 9px;
      height: 9px;
      background: #b2b2b2;
      border-radius: 50%;
    }
  }
}
</style>
