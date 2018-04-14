<script>
import VueCharts from 'vue-chartjs'
const { reactiveProp } = VueCharts.mixins

export default {
  extends: VueCharts.Line,
  mixins: [reactiveProp],
  props: ['options'],
  data () {
    return {
      gradient: null,
      gradient2: null
    }
  },
  mounted () {
    this.gradient = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)
    this.gradient2 = this.$refs.canvas.getContext('2d').createLinearGradient(0, 0, 0, 450)

    this.gradient.addColorStop(0, 'rgba(0, 231, 255, 0.9)')
    this.gradient.addColorStop(0.5, 'rgba(0, 231, 255, 0.25)')
    this.gradient.addColorStop(1, 'rgba(0, 231, 255, 0)')

    this.gradient2.addColorStop(0, 'rgba(255, 0,0, 0.5)')
    this.gradient2.addColorStop(0.5, 'rgba(255, 0, 0, 0.25)')
    this.gradient2.addColorStop(1, 'rgba(255, 0, 0, 0)')

    this.renderChart({
      labels: ['Week1', 'Week2', 'Week3', 'Week4', 'Week5', 'Week6', 'Week7'],
      datasets: [
        {
          label: 'Profits',
          borderColor: '#05CBE1',
          pointBackgroundColor: '#05CBE1',
          borderWidth: 1,
          pointBorderColor: '#05CBE1',
          backgroundColor: this.gradient,
          data: [40, 60, 80, 20, 30, 90, 70]
        },
        {
          label: 'Losses',
          borderColor: '#FC2525',
          pointBackgroundColor: '#FC2525',
          borderWidth: 1,
          backgroundColor: this.gradient2,
          pointBorderColor: '#FC2525',
          data: [20, 10, 20, 5, 50, 35, 25]
        }
      ]}, {responsive: true, maintainAspectRatio: false})
  }
}
</script>
