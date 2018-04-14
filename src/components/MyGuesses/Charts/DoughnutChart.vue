<script>
import VueCharts from 'vue-chartjs'
const { reactiveProp } = VueCharts.mixins

export default {
  extends: VueCharts.Doughnut,
  mixins: [reactiveProp],
  props: ['options'],
  mounted () {
    this.renderChart({
      labels: ['Created Event', 'Validated Event', 'Voted Event'],
      datasets: [
        {
          label: 'Topics',
          borderWidth: 0.5,
          backgroundColor: [
            '#ff0d73',
            '#f87979',
            '#d52c38'
          ],
          data: [50, 10, 30]
        }
      ]
    }, {responsive: true, maintainAspectRatio: false})
  }
}
</script>
