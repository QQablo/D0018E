<template>
    <nav class="admin-navbar">
      <ul>
        <li><router-link :to="{ name: 'admin_dashboard' }">Dashboard</router-link></li>
        <li><router-link :to="{ name: 'admin_products' }">Products</router-link></li>
      </ul>
    </nav>
</template>
  
<script setup>
</script>
  
<style scoped>
.admin-navbar {
    background-color: #333; 
    width: 200px; 
    height: 100vh; 
    padding: 20px 0; 
    position: fixed; /* Fixed position to stay on the left, */
    top: 0;
    left: 0;
}

.admin-navbar ul {
    list-style-type: none; 
    padding: 0;
    margin: 0;
}

.admin-navbar li {
    margin: 15px 0; 
}

.admin-navbar a {
    color: white; 
    text-decoration: none; 
    font-size: 18px; 
    padding: 10px 20px; 
    display: block; /* Make the entire div clickable. */
}

.admin-navbar a:hover {
    text-decoration: underline;
}

.admin-navbar a.router-link-active {
    /* Mark the link for the current page. */
    background-color: #34495e; 
    font-weight: bold; 
}
</style>