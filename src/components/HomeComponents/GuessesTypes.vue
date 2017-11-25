<template>
    <div>
        <h1>Topics</h1>
        <div class='box-selection'>
            <!--First row-->
            <div class='one'>
                <h3>Arts</h3>
            </div>
            <div class='two'>
                <h3>Industry</h3>
            </div>
            <div class='three'>
                <h3>ESports</h3>
            </div>
            <!--Second row-->
            <div class='four'>
                <h3>Tech</h3>
            </div>
            <div class='five'>
                <h3>Life</h3>
            </div>
            <div class='six'>
                <h3>Society</h3>
            </div>
        </div>
    </div>
</template>

<script>
export default{
  name: 'GuessesTypes'
}
</script>

<style>
.box-selection{
  margin-left: 2.5%;
  width:95%;
  margin-bottom: 19%;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-gap: 8px;
  grid-auto-rows: minmax(200px, auto);
}

.one{
  grid-column: 1;
  grid-row: 1;
  background-image: url('https://crystalbridges.org/wp-content/uploads/2017/09/4007-032.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-position: center;
  box-shadow: inset 0 0 0 1000px rgba(255, 255, 1, 0.5);
}
.two{
  grid-column: 2;
  grid-row: 1;
  background-image: url('http://www.stat.gov.mk/Images/Industry.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-position: center;
  box-shadow: inset 0 0 0 1000px rgba(255, 13, 115, 0.5);
}
.three{
  grid-column: 1;
  grid-row: 2;
  background-image: url('https://www.esportsearnings.com/images/logos/g151-starcraft-ii.jpg');
  /*background-repeat: no-repeat;*/
  background-attachment: fixed;
  background-position: center;
  box-shadow: inset 0 0 0 1000px rgba(255, 13, 115, 0.5);
}
.four{
  grid-column: 2;
  grid-row: 2;
  background-image: url('http://www.warranteer.com/wp-content/uploads/2015/09/bitcoin.png');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-position: center;
  box-shadow: inset 0 0 0 1000px rgba(255, 255, 1, 0.5);
}
.five{
  grid-column: 1;
  grid-row: 3;
  background-image: url('https://www.pickthebrain.com/blog/wp-content/uploads/2013/03/life-coach.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-position: center;
  box-shadow: inset 0 0 0 1000px rgba(255, 255, 1, 0.5);
}
.six{
  grid-column: 2;
  grid-row: 3;
  background-image: url('http://www.stat.gov.mk/Images/Industry.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-position: center;
  box-shadow: inset 0 0 0 1000px rgba(255, 13, 115, 0.5);
}
</style>
