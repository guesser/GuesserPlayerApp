<template>
    <div>
        <md-toolbar class="md-transparent">
            <md-icon class="md-primary"><router-link class="md-primary" to="/create">add_circle_outline</router-link></md-icon>
            <md-input-container class="searchHeader">
                <md-icon class="md-primary">search</md-icon>
                <md-input v-model="initialValue" md-theme="green"></md-input>
            </md-input-container>        
            <md-icon class="md-primary">view_list</md-icon>
        </md-toolbar>
    </div>
</template>

<script>
export default{
  name: 'SearchHeaderBar',
  data () {
    return {
      initialValue: ''
    }
  }
}
</script>

<style>
.searchHeader{
    width: 60%;
    padding: 0%;
}
</style>
