<template>
  <div id="app">
   
   <!-- Displays the content of the page -->
    <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'App',
};

</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  margin-top: 20px;
}
</style>

