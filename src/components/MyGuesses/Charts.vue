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
    <b-row style="padding-top: 4%;">
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
            borderColor: '#8d141a',
            pointBackgroundColor: '#8d141a',
            borderWidth: 1,
            pointBorderColor: '#8d141a',
            backgroundColor: 'rgba(25,25,25,.27)',
            data: [40, 60, 80, 20, 30, 90, 70]
          },
          {
            label: 'Losses',
            borderColor: '#249EBF',
            pointBackgroundColor: '#249EBF',
            borderWidth: 1,
            pointBorderColor: '#249EBF',
            backgroundColor: 'transparent',
            data: [20, 10, 20, 5, 50, 35, 25]
          }
        ]
      },
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
.small {
  max-width: 300px;
  border-radius: 20px;
}
</style>

