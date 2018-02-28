    <template>
    <div>
    <FullPage :options="options">
      <div class="section">
          <h1>Can you guess the future?</h1> 
          <h1>Predict the outcome of the internet’s hottest events</h1>
      </div>
      <div class="section">
        Hola
          <!--<vue-particles-->
               <!--color="#FF0D73"-->
               <!--:particleOpacity="1"-->
               <!--:particlesNumber="160"-->
               <!--shapeType="circle"-->
               <!--:particleSize="5"-->
               <!--linesColor="#dedede"-->
               <!--:linesWidth="0"-->
               <!--:lineLinked="false"-->
               <!--:lineOpacity="0"-->
               <!--:linesDistance="150"-->
               <!--:moveSpeed="3"-->
               <!--:hoverEffect="false"-->
               <!--hoverMode="grab"-->
               <!--:clickEffect="true"-->
               <!--clickMode="push"-->
               <!-->-->
          <!--</vue-particles>-->
      </div>
    </FullPage>
  </div>
</template>

<script>

export default {
  data () {
    return {
      options: {
        paddingTop: '30px'
      }
    }
  }
}
</script>

<style lang="scss">
.absolute-position {
  position: absolute;
  margin: auto;
  top: 50%;
  width: 100%;
  /*height: 100%;
   */
}
</style>
