<template>
  <div>
    <b-row>
      <b-col>
        <div class="chart">
          <line-chart></line-chart>
        </div>
      </b-col>
      <b-col >
        <div class="chart" align-self="center">
          <pie-chart :chart-data="datatopics"></pie-chart>
        </div>
      </b-col>
    </b-row>
    <b-row>
      <b-col>
        <div class="chart">
          <doughnut-chart :chart-data="dataevents"></doughnut-chart>
        </div>
      </b-col>
      <b-col>
        <div class="chart" style="">
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
      datatopics: {
        labels: ['Crypto', 'Calebrities', 'Entertainment', 'Gaming', 'Humor', 'News', 'Politics', 'Sports', 'Technology', 'Random'],
        datasets: [
          {
            label: 'Topics',
            backgroundColor: [
              '#f8e98d',
              '#e6b5ee',
              '#bae1ff',
              '#ffce54',
              '#cf9',
              '#9db5c4',
              '#dcebef',
              '#fff',
              '#bcbcbc',
              '#d9414c'
            ],
            data: [20, 10, 1, 5, 7, 9, 11, 8, 4, 11]
          }
        ]
      },
      dataevents: {
        labels: ['Created Event', 'Validated Event', 'Voted Event'],
        datasets: [
          {
            label: 'Topics',
            backgroundColor: [
              '#ff0d73',
              '#f87979',
              '#d52c38'
            ],
            data: [50, 10, 30]
          }
        ]
      }
    }
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

