<template>
    <div>
        <md-toolbar class="md-transparent">
            <!--<md-icon class="md-primary"><router-link class="md-primary link" to="/create">add_circle_outline</router-link></md-icon>-->
            <router-link class="md-primary link" to="/create">➕</router-link>
            <md-input-container class="searchHeader">
                <md-icon class="md-primary">search</md-icon>
                <md-input v-model="initialValue"></md-input>
            </md-input-container>        
            <!--<md-icon class="md-primary"><router-link class="md-primary link" to="/types">view_list</router-link></md-icon>-->
            <router-link class="md-primary link" to="/types">🗂</router-link>
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
    max-width: 65%;
    color: #ff0d73;
    margin-right: 20px;
    margin-left: 20px;
}
a.md-primary.link{
    color: #ff0d73;
    text-decoration: none !important;
    font-size: 30px;
}
i.md-icon.md-primary.md-theme-default.material-icons{
    color: #ff0d73;
}
</style>
