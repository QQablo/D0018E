<template>
  <p>hello</p>
  <!-- <div>
    <h1>{{ categoryData.name }}</h1>
    <div v-for="product in categoryData.products" :key="product.id" class="product">
      <img :src="product.image" width="150" />
      <h3>{{ product.name }}</h3>
      <p>{{ product.description }}</p>
      <h4>${{ product.price }}</h4>
      <button>Add to Cart</button>
    </div>
  </div> -->
</template>

<script setup>
//import { useRoute } from "vue-router";
import {onMounted } from "vue";
import axios from "axios";

// const categoryData = ref({
//   name: "Category",
//   products: []
// });

const products = async () => {
  try {
    const categoryResponse = await axios.get('http://localhost:3000/api/products/category_products');
    console.log( categoryResponse.data);

    // const productRespons = await axios.get(`http://localhost:3000/api/products?category_id=${id}`);
    // category.products = productRespons.data;
  } catch (error) {
    console.error("Something went wrong while fetching products:", error);
  }
};

// const categoryResponse = await axios.get(`http://localhost:3000/api/products/category_products?category=${cat}`);
// const productRespons = await axios.get(`http://localhost:3000/api/products?category_id=${id}`);
// category.products = productRespons.data;

// const ategoriesResponse = async () => {
//   try {
//     const response = await axios.get("http://localhost:3000/api/categories");
//     categoriesData.list = response.data;
//   } catch (error) {
//     console.error("Something went wrong while fetching categories:", error);
//   }
// };

onMounted(() => {
  products();
});
</script>

<!--const products = async (categoryId) => {
  try {
    const categoryResponse = await axios.get(`http://localhost:3000/api/categories/${categoryId}`);
    categoryData.value.name = categoryResponse.data.name;

    const productResponse = await axios.get(`http://localhost:3000/api/products?category=${categoryId}`);
    categoryData.value.products = productResponse.data;
  } catch (error) {
    console.error("Error fetching category and products:", error);
  }
};

onMounted(() => {
  const categoryId = window.location.pathname.split('/').pop(); 
  products(categoryId);
});-->

