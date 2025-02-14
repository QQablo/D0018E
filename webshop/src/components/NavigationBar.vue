<template>
    <nav class="navbar">
      <ul>
        <li><router-link to="/">Home</router-link></li>
        <li><router-link to="/login">Login</router-link></li>
        <li><router-link to="/signup">Signup</router-link></li>
        <li><router-link to="/Categories">Categories</router-link></li>
        <!-- <li><router-link to="/cart">🛍️ ({{ cartCount }})</router-link></li> -->  
      </ul>
    </nav>
  </template>
  
  <script>
  export default {
    name: 'NavigationBar',
    setup() {
  }
  };
  </script>
  
  <style scoped>
  .navbar {
    background-color: #333;
    padding: 10px;
    text-align: center;
  }
  
  .navbar ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
  }
  
  .navbar li {
    display: inline;
    margin: 0 15px;
  }
  
  .navbar a {
    color: white;
    text-decoration: none;
    font-size: 18px;
  }
  
  .navbar a:hover {
    text-decoration: underline;
  }
  </style>
