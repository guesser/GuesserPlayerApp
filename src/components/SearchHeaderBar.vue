<template>
    <div>
        <md-toolbar class="md-transparent">
            <md-input-container class="searchHeader">
                <md-icon class="md-primary">search</md-icon>
                <md-input v-model="initialValue" md-theme="green"></md-input>
            </md-input-container>        
        </md-toolbar>
    </div>
</template>

<script>
export default{
  name: 'SearchHeaderBar'
}
</script>

<style>
.searchHeader{
    width: 60%;
    margin-left: 20%;
}
</style>
