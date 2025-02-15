<template>
     <NavigationBar/>
    <div>
      <h1>Welcome to our webshop</h1>
      <p>Choose a category to see the products <router-link to="/Categories">Categories</router-link></p>
    </div>
  </template>
  
<script setup>
import NavigationBar from '@/components/NavigationBar.vue';
</script>
  
  <style scoped>
  h1 {
    color: #333;
  }
  </style>
  