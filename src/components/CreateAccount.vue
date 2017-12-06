<template>
    <div>

<link href="https://cdn.jsdelivr.net/npm/animate.css@3.5.1" rel="stylesheet" type="text/css">
<transition
    name="custom-classes-transition"
    enter-active-class="animated tada"
    leave-active-class="animated bounceOutRight"
  >
    <div v-if='page==0'>
        <h1>Uoops!</h1>
        <md-divider></md-divider>
        <h2 class=''>It seems you don't have a user.</h2>
        <h2 class=''>Let's create it!</h2>
        <md-button class="md-primary" @click="page++"><h1>Start</h1></md-button>
        <img class='margin-img' src='https://m.popkey.co/987552/NGLb3.gif' width="70%"></img>
    </div>
</transition>
<transition
    name="custom-classes-transition"
    enter-active-class="animated tada"
    leave-active-class="animated bounceOutRight"
  >
    <div v-if='page==1'>
        <h1>Nickname</h1>
        <md-button class="md-primary" @click="page++"><h1>Next</h1></md-button>
    </div>
</transition>
<transition
    name="custom-classes-transition"
    enter-active-class="animated tada"
    leave-active-class="animated bounceOutRight"
  >
    <div v-if='page==2'>
        <h1>Picture</h1>
    </div>
</transition>
    </div>
</template>

<script>
export default{
  name: 'CreateAccount',
  data () {
    return {
      page: 0
    }
  }
}
</script>

<style>
.margin-img{
    padding-top: 20%;
}
</style>
