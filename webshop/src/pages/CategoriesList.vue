<template>
    <div>
      <h1>Categories</h1>
      <div v-for="category in categories" :key="category.id">
        <router-link :to="'/category/' + category.id">
          <h3>{{ category.name }}</h3>
        </router-link>
      </div>
    </div>
  </template>
  
  <script>
  import { categories } from "@/data.js";
  
  export default {
    setup() {
      return { categories };
    }
  };
  </script>