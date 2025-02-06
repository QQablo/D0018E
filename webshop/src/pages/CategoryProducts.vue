<template>
    <div>
      <h1>{{ categoryName }}</h1>
      <div v-for="product in categoryProducts" :key="product.id" class="product">
        <img :src="product.image" :alt="product.name" width="100" />
        <h3>{{ product.name }}</h3>
        <p>{{ product.description }}</p>
        <h4>${{ product.price }}</h4>
        <button>Add to Cart</button>
      </div>
    </div>
  </template>
  
  <script>
  import { useRoute } from "vue-router";
  import { products, categories } from "@/data.js";
  
  export default {
    setup() {
      const route = useRoute();
  
      const categoryId = Number(route.params.id);
      const categoryProducts = products[categoryId] || [];
      const categoryName = categories.find((c) => c.id === categoryId)?.name || "Category";
  
      return { categoryProducts, categoryName };
    }
  };
  </script>

