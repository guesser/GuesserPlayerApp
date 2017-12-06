<template>
    <md-card class="shape md-with-hover event" v-bind:class='topic'>
        <md-card-header>
            <md-card-header-text>
                <div class="md-title">{{title}}</div>
            </md-card-header-text>

            <md-chip class="md-warn">32 
                <md-icon class='small'>thumb_up</md-icon>
            </md-chip>
        </md-card-header>


<md-card-expand>
        <md-card-actions v-bind:class='topic'>
          <div class='vote-margin'>
            <md-button>Vote</md-button>
          </div>

                <md-card-expand-trigger>
                    <md-button class="md-icon-button" md-expand-trigger>
                        <md-icon>keyboard_arrow_down</md-icon>
                    </md-button>
                </md-card-expand-trigger>
        </md-card-actions>


            <md-card-content>
                <div class="md-subhead">{{description}}</div>
                <h4>The options will be: </h4>
                <span class="md-caption"> {{option1}}</span>
                <span class="md-caption"> {{option2}}</span>

                <span class="md-caption" v-if='option3'> {{option3}}</span>
                <span class="md-caption" v-if='option4'> {{option4}}</span>
            </md-card-content>
        </md-card-expand>
    </md-card>
</template>

<script>
export default {
  name: 'EventCard',
  props: ['title', 'description', 'topic', 'option1', 'option2', 'option3', 'option4']
}
</script>

<style>
.event{
    width: 95%;
    max-width: 800px;
    display: inline-block;
    vertical-align:top;
    margin-top: 8px;
}
.small{
    font-size: 18px;
    padding-bottom: 5px;
}
.vote-margin{
    padding-right: 60%;
}
.md-title{
    padding-right: 100%;
}

/* Topics styles */
.crypto{
    background-color: cyan !important;
}
.esports{
    background-color: lime !important;

}
</style>
