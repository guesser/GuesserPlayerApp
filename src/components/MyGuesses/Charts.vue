<template>
  <div>
    <b-row>
      <b-col>
        <div class="chart">
          <line-chart></line-chart>
        </div>
      </b-col>
      <b-col >
        <div class="chart">
          <pie-chart></pie-chart>
        </div>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <div class="chart">
          <doughnut-chart></doughnut-chart>
        </div>
      </b-col>
      <b-col>
        <div class="chart">
        </div>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import LineChart from './Charts/LineChart.vue'
import PieChart from './Charts/PieChart.vue'
import DoughnutChart from './Charts/DoughnutChart.vue'

export default {
  components: {
    LineChart,
    PieChart,
    DoughnutChart
  }
}
</script>

<style>
.chart {
  background: transparent;
  border-radius: 5px;
  box-shadow: 0px 2px 15px rgba(25, 25, 25, 0.17);
  margin: 6% 0;
}
</style>

