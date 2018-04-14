<script>
import VueCharts from 'vue-chartjs'
const { reactiveProp } = VueCharts.mixins

export default {
  extends: VueCharts.Pie,
  mixins: [reactiveProp],
  props: ['options'],
  mounted () {
    this.renderChart({
      labels: ['Crypto', 'Calebrities', 'Entertainment', 'Gaming', 'Humor', 'News', 'Politics', 'Sports', 'Technology', 'Random'],
      datasets: [
        {
          label: 'Topics',
          borderColor: '#FC2525',
          borderWidth: 0.5,
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
    }, {responsive: true, maintainAspectRatio: false})
  }
}
</script>
