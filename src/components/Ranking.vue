<template>
  <div>
        <h2>Ranking</h2>
    <md-table md-fixed-header>
      <md-table-row>
        <md-table-head md-numeric>ID</md-table-head>
        <md-table-head>Nickname</md-table-head>
        <md-table-head>Balance</md-table-head>
      </md-table-row>

      <md-table-row>
        <md-table-cell md-numeric>1</md-table-cell>
        <md-table-cell>ShawnaDubbin</md-table-cell>
        <md-table-cell>34$</md-table-cell>
      </md-table-row>

      <md-table-row>
        <md-table-cell md-numeric>2</md-table-cell>
        <md-table-cell>OdetteDemageard</md-table-cell>
        <md-table-cell>26$</md-table-cell>
      </md-table-row>

      <md-table-row>
        <md-table-cell md-numeric>3</md-table-cell>
        <md-table-cell>VeraTaleworth</md-table-cell>
        <md-table-cell>20$</md-table-cell>
      </md-table-row>
    </md-table>
  </div>
</template>

<script>
  export default {
    name: 'Ranking'
  }
</script>
