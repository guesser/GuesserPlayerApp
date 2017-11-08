<template>
    <form novalidate>
        <h2> Create a Guess</h2>
        <md-input-container>
            <label>Title</label>
            <md-input v-model="title"></md-input>
        </md-input-container>

        <md-input-container>
            <label>Description</label>
            <md-textarea></md-textarea>
        </md-input-container>

        <md-stepper >
            <md-step>
                <p>Select the first option:</p>
            <md-input v-model="option1"></md-input>
            </md-step>
            <md-step>
                <p>Select the second option:</p>
            <md-input v-model="option2"></md-input>
            </md-step>
            <md-step>
                <p>Select the third option:</p>
            <md-input v-model="option3"></md-input>
            </md-step>
            <md-step>
                <p>Select the fourth option:</p>
            <md-input v-model="option4"></md-input>
            </md-step>
        </md-stepper>
    </form>
</template>

<script>
export default {
  name: 'create'
}
</script>
