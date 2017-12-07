<template>
    <md-card class="shape md-with-hover event" v-bind:class='topic'>
        <md-card-header>
            <md-card-header-text class="text-flex">

                <div class="md-title">{{title}}</div>
                <div class="md-subhead">{{description}}</div>
            </md-card-header-text>

            <md-card-media>
                <img v-if='topic=="crypto"'src="../../assets/coin.png"/>
                <img v-if='topic=="esports"'src="../../assets/esports.png"/>
            </md-card-media>

        </md-card-header>


        <md-card-expand>
            <md-card-actions v-bind:class='topic'>
                <div class='vote-margin'>
                    <md-button class="md-raised md-primary">Vote</md-button>
                    <span class='md-subhead center-people'> {{people}}<img src='../../assets/beard.png' width='24' />already did</span>
                </div>

                <md-button class="md-icon-button" md-expand-trigger>
                    <md-icon>keyboard_arrow_down</md-icon>
                </md-button>
            </md-card-actions>


            <md-card-content>
                <h4>Options: </h4>
                <md-button disabled> {{option1}}</md-button>
                <md-button disabled> {{option2}}</md-button>

               <md-button disabled v-if='option3'> {{option3}}</md-button>
                <md-button disabled v-if='option4'> {{option4}}</md-button>
            </md-card-content>
        </md-card-expand>
    </md-card>
</template>

<script>
export default {
  name: 'EventCard',
  props: ['title', 'description', 'topic', 'option1', 'option2', 'option3', 'option4', 'people']
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
    padding-right: 30%;
}

.md-card .md-subhead {
    line-height: 35px;
    opacity: .74;
}
.text-flex{
    flex: 0 !important;
}
.center-people{
    margin-top: 10px;
}

/* Topics styles */
.crypto{
    background-color: cyan !important;
}
.esports{
    background-color: lime !important;

}
</style>
