<template>
    <div>
    <h1> Bank </h1>

<md-card>
      <md-card-media-cover md-text-scrim>
        <md-card-media md-ratio="16:9">
          <img src="../assets/chest.jpg" alt="Skyscraper">
        </md-card-media>

        <md-card-area>
          <md-card-header>
              <span class="md-title"><h1 class='primary'>Daily chest</h1></span>
            <!--<span class="md-subhead">16/9 image</span>-->
          </md-card-header>

          <md-card-actions>
              <md-button><b>Open</b></md-button>
            <md-button>Discard</md-button>
          </md-card-actions>
        </md-card-area>
      </md-card-media-cover>
    </md-card>
    </div>
</template>

<script>
export default{
  name: 'Bank'
}
</script>

<style>
.primary{
    color: #ff0d73;
}
</style>
