<template>
  <div>
    <h1>Categories</h1>
    <div v-for="category in categoriesData.list" :key="category.id">
      <router-link :to="'/category/' + category.id">
        <h3>{{ category.name }}</h3>
      </router-link>
    </div>
  </div>
</template>

<script>
import { reactive } from "vue";
import axios from "axios";

const categoriesData = reactive({ list: [] });

const ategoriesResponse = async () => {
  try {
    const response = await axios.get("http://localhost:3000/api/categories");
    categoriesData.list = response.data;
  } catch (error) {
    console.error("Something went wrong while fetching categories:", error);
  }
};

</script>