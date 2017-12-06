<template>
    <md-card class="md-accent shape md-with-hover guesses">
        <md-card-header>
            <md-card-header-text>
                <div class="md-title">{{title}}</div>
            </md-card-header-text>

            <md-chip class="md-warn">69 
                <md-icon>face</md-icon>
            </md-chip>
        </md-card-header>

        <md-card-expand>
            <md-card-actions>
                <md-progress md-indeterminate md-indeterminate></md-progress>
                <span style="flex: 1"></span>
                <md-button class="md-icon-button" md-expand-trigger>
                    <md-icon>keyboard_arrow_down</md-icon>
                </md-button>
            </md-card-actions>

            <md-card-content>
                {{description}}
                <h3> Votes: </h3>
                <div class="md-primary buttons-content">
                    <md-button class="md-raised md-primary" v-if='option1 !== "" '>{{option1}}</md-button>
                    <md-button class="md-raised md-primary" v-if='option2 !== "" '>{{option2}}</md-button>
                </div>
                <div class="md-primary buttons-content">
                    <md-button class="md-raised md-primary" v-if='option3'>{{option3}}</md-button>
                    <md-button class="md-raised md-primary" v-if='option4'>{{option4}}</md-button>
                </div>
            </md-card-content>
        </md-card-expand>
    </md-card>
</template>

<script>
export default {
  name: 'GuessCard',
  props: ['title', 'description', 'option1', 'option2', 'option3', 'option4'],
  mounted: function () {
    if (this.option4) {
      console.log(this.option4)
    }
  }
}
</script>

<style>
.md-progress{
    width: 55%;
    margin-left: 3%;
}
.guesses{
    width: 95%;
    max-width: 800px;
    display: inline-block;
    vertical-align:top;
    margin-top: 8px;
}
.buttons-content {
  width: 90%;
  display: inline-flex;
  justify-content: center;
  align-items: center;
}
</style>
