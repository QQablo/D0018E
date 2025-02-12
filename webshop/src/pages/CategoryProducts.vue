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

<script>
//import { useRoute } from "vue-router";
import { reactive} from "vue";
import axios from "axios";

const categoryData = reactive({
  name: "Category",
  products: []
});

const products = async () => {
  try {
    const categoryResponse = await axios.get(`http://localhost:3000/api/categories/${id}`);
    category.name = categoryResponse.data.name;

    const productRespons = await axios.get(`http://localhost:3000/api/products?category_id=${id}`);
    category.products = productRespons.data;
  } catch (error) {
    console.error("Something went wrong while fetching products:", error);
  }
};

</script>