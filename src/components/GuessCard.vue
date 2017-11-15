<template>
    <md-card class="md-accent shape md-with-hover">
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
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Optio itaque ea, nostrum odio. Dolores, sed accusantium quasi non, voluptas eius illo quas, saepe voluptate pariatur in deleniti minus sint. Excepturi.
                Lorem ipsum dolor sit amet, consectetur adipisicing elit. Optio itaque ea, nostrum odio. Dolores, sed accusantium quasi non, voluptas eius illo quas, saepe voluptate pariatur in deleniti minus sint. Excepturi.

                <h3> Votes: </h3>
                <md-button class="md-raised md-primary" md-theme="green">No fucking way</md-button>
                <md-button class="md-raised md-primary" md-theme="orange">No</md-button>
                <md-button class="md-raised md-primary">Being Gay</md-button>

            </md-card-content>
        </md-card-expand>
    </md-card>
</template>

<script>
export default {
  name: 'GuessCard',
  props: ['title']
}
</script>

<style>
.md-progress{
    width: 55%;
    margin-left: 3%;
}
.md-card{
    max-width: 800px;
    display: inline-block;
    vertical-align:top;
}
</style>
