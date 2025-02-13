<template>
  
  <div>
    <h1>{{ categoryData.name }}</h1>
    <div v-for="product in categoryData.products" :key="product.id" class="product">
      <img :src="product.image" width="150" />
      <h3>{{ product.name }}</h3>
      <p>{{ product.description }}</p>
      <h4>${{ product.price }}</h4>
      <button>Add to Cart</button>
    </div>
  </div>
</template>

<script setup>
import { useRoute } from "vue-router";
import {onMounted, reactive} from "vue";
import axios from "axios";


const $route = useRoute();

const categoryData = reactive({
  name: "Category",
  products: []
});

const products = async () => {
  try {
    const categoryId = $route.params.id;
    const categoryResponse = await axios.get(`http://localhost:3000/api/products/category_products?category_id=${categoryId}`);
    //console.log(categoryResponse.data);
    categoryData.products = categoryResponse.data;
    // console.log(categoryData.products)
  } catch (error) {
    console.error("Something went wrong while fetching products:", error);
  }
};

onMounted(() => {
  products();
});
</script>

