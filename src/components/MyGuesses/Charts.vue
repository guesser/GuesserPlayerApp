<template>
  <div>
    <b-row>
      <b-col>
        <div class="small">
          <line-chart :chart-data="dataprofits"></line-chart>
        </div>
      </b-col>
      <b-col>
        <div class="small">
          <pie-chart :chart-data="datatopics"></pie-chart>
        </div>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <div class="small">
          <doughnut-chart :chart-data="dataevents"></doughnut-chart>
        </div>
      </b-col>
      <b-col>
        <div class="small" style="">
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
  },
  data () {
    return {
      dataprofits: {
        labels: ['Week1', 'Week2', 'Week3', 'Week4', 'Week5', 'Week6', 'Week7'],
        datasets: [
          {
            label: 'Profits',
            backgroundColor: '#f87979',
            data: [40, 60, 80, 20, 30, 90, 70]
          }
        ]
      },
      datatopics: {
        labels: ['Crypto', 'Calebrities', 'Entertainment', 'Gaming', 'Humor', 'News', 'Politics', 'Sports', 'Technology', 'Random'],
        datasets: [
          {
            label: 'Topics',
            backgroundColor: '#f87979',
            data: [20, 10, 1, 5, 7, 9, 11, 8, 4, 11]
          }
        ]
      },
      dataevents: {
        labels: ['Created Event', 'Validated Event', 'Voted Event'],
        datasets: [
          {
            label: 'Topics',
            backgroundColor: '#f87979',
            data: [20, 10, 50]
          }
        ]
      }
    }
  },
  mounted () {
    this.LineChart.renderChart(this.dataprofits)
    this.PieChart.renderChart(this.datatopics)
    this.DoughnutChart.renderChart(this.dataevents)
  }
}
</script>

<style>
.small {
  max-width: 300px;
}
</style>

