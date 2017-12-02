<template>
    <div>
    <h1> Bank </h1>
    <Chest/>
    </div>
</template>

<script>
import Chest from './BankComponents/Chest'

export default{
  name: 'Bank',
  components: {
    Chest
  }
}
</script>

<style>
.primary{
    color: #ff0d73;
}
</style>
