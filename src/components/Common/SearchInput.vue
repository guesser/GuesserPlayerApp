<template>
  <div>
    <form @submit="changeToSearched" class="navbar-form" role="search">
      <div class="search input-group">
        <input type="checkbox" id="trigger" class="search__checkbox" />
        <label class="search__label-init" for="trigger"></label>
        <label class="search__label-active" for="trigger"></label>
        <div class="search__border"></div>
        <input type="text" class="search__input" id="srch-term" placeholder="ID" v-model="form._id" style="padding-top: 8px"/>
        <div class="search__close"></div>
      </div>
    </form>
  </div>
</template>
<script>
export default {
  name: 'SearchInput',
  data: function () {
    return {
      form: {
        _id: ''
      }
    }
  },
  methods: {
    changeToSearched () {
      window.location = '#search/' + this.form._id
      console.log('identifier: ', this.form._id)
    }
  }
}
</script>
<style scoped lang="scss">

$search: #ff0d73;

*, *:before, *:after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}
html, body {
  font-size: 62.5%;
  height: 100%;
}
body {
  background: #fff;
}
$cub: cubic-bezier(.73,.14,.4,1.58);
$step1: 0.2s;
$step2: 0.3s;
$delayClose1: 0.2s;
$delayClose2: 0.3s;
$totalAnim: $step1 + $step2;
$w: 18rem;
$h: 2rem;
$borderW: 0.2rem;

.search {
  position: relative;
  top: $h/3;
  margin-bottom: 5px;
  width: $w;
  height: $h;

  &__border {
    position: absolute;
    top: 50%;
    left: 0%;
    width: $h;
    height: 100%;
    border: $borderW solid $search;
    border-radius: 10rem;
    transform: translate(0%, -50%);
    transition: width $step2 $delayClose2;

    #trigger:checked ~ & {
      transition: width $step2 $step1;
      width: 100%;

      &:after {
        width: 0;
        transition: width $step1 cubic-bezier(.45,-0.7,.62,1.25);
      }
    }

    &:after {
      content: "";
      position: absolute;
      bottom: -1.6rem;
      right: -1.6rem;
      width: $h/2.5;
      height: $borderW;
      background: $search;
      border-radius: $h/10;
      transform-origin: 100% 50%;
      transform: rotate(225deg) translateX(2.5rem);
      transition: width $step1 $delayClose2 + $step2;
    }
  }

  &__input {
    position: relative;
    width: $w - $h;
    height: $h;
    padding: $h*0.15 0 $h*0.15 $h*0.4;
    background: transparent;
    outline: none;
    border: none;
    font-size: $h*0.4;
    color: $search;
    z-index: -1;
    opacity: 0;
    transition: opacity 0.2s;

    #trigger:checked ~ & {
      opacity: 1;
      z-index: auto;
      transition: opacity 0.2s $totalAnim;
    }
  }

  &__checkbox {
    position: absolute;
    top: -9999px;
    left: -9999px;
    opacity: 0;
    z-index: -10;
  }
  &__label-init {
    z-index: 2;
    position: absolute;
    top: 0;
    left: 0;
    width: $w*0.2125;
    height: $w*0.4;
    cursor: pointer;

    #trigger:checked ~ & {
      transform: scale(0);
    }
  }
  &__label-active {
    z-index: 3;
    position: absolute;
    top: $h/4;
    right: $h/4;
    width: $h/2;
    height: $h/2;
    cursor: pointer;
    transform: scale(0);

    #trigger:checked ~ & {
      tranition: transform 0 $totalAnim;
      transform: scale(1);
    }
  }

  &__close {
    position: absolute;
    top: $h/4;
    right: $h/4;
    width: $h/2;
    height: $h/2;
    cursor: pointer;
    z-index: -1;

    #trigger:checked ~ & {
      z-index: auto;

      &:before {
        transform: rotate(-45deg);
        opacity: 1;
        transition: transform 0.2s $totalAnim $cub, opacity 0.1s $totalAnim;
      }
      &:after {
        transform: rotate(45deg);
        opacity: 1;
        transition: transform 0.2s ($totalAnim + $delayClose1) $cub, opacity 0.1s ($totalAnim + $delayClose1);
      }
    }

    &:before,
    &:after {
      content: "";
      position: absolute;
      top: $h/5;
      left: 0;
      width: 100%;
      height: $h/10;
      background: $search;
      border-radius: 0.5rem;
      opacity: 0;
    }
    &:before {
      transform: rotate(-45deg) translateX(2rem);
      transition: transform 0.2s, opacity 0.1s 0.1s;
    }
    &:after {
      transform: rotate(45deg) translateX(2rem);
      transition: transform 0.2s 0.2s, opacity 0.1s 0.3s;
    }
  }
}
</style>
