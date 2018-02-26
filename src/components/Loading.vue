<template>
<!-- h1.loading{loading...} -->
<h1 class="loading">loading...</h1>
</template>

<script>
//lettering js
$(".loading").lettering();
</script>

<style lang='scss'>
@import "compass/css3";

html,body{height: 100%;}
body{ 
  background:-webkit-radial-gradient( center center,circle cover,#078ABE, #0D343A);
  background:-moz-radial-gradient( center center,circle cover,#078ABE, #0D343A);  
 background:radial-gradient( center center,circle cover,#078ABE, #0D343A); 
} 

.loading{
  position: absolute;
  top: 0; bottom: 0;
  left: 0; right: 0;
  margin: auto;
  //border: solid;
  width: 500px;
  height: 50px;
  text-transform: uppercase;
  font-size: 18px;
  span{
    display: inline-block;
    background: tomato;
    width: 50px;
    height: 50px;
    line-height: 50px; 
    text-align: center;
    color: white;
    text-shadow: 1px 1px 0 black;
    position: relative;
    top: 0;
    box-shadow: inset 0 1px 1px -1px black, inset 0 -5px 1px -1px rgba(black, .5);
  }
}

@for $i from 1 through 10{
  .char#{$i}{
    animation: foo 2s ease infinite, bar 3s linear infinite;
    animation-delay: .1s * $i;
  }
}

@keyframes foo{
  10%{
    top: -10px;
  }
  50%{
    top:0;
  }
  100%{
    top: 0;
  }
}

@keyframes bar{
  10%{
    opacity: 0;
  }
  50%{
    opacity: 1;
  }
  100%{
    opacity: 1;
  }
}

</style>
