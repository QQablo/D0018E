<template>
    <div>
      <h1>Welcome to our webshop</h1>
      <p>Choose a category to see the products <router-link to="/Categories">Categories</router-link></p>
    </div>
  </template>
  
  <script>
  export default {
    name: "HomePage",
  };
  </script>
  
  <style scoped>
  h1 {
    color: #333;
  }
  </style>
  