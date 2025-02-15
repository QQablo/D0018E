<template>
    <nav class="navbar">
      <ul>
        <li><router-link to="/">Home</router-link></li>
        <li><router-link to="/login">Login</router-link></li>
        <li><router-link to="/signup">Signup</router-link></li>
        <li><router-link to="/categories">Categories</router-link></li>
        <li><router-link to="/cart">🛍️ ({{ cartCount }})</router-link></li>  
      </ul>
    </nav>
</template>
  
<script setup>
import { ref } from 'vue';
import axios from 'axios';
// prop to navbar from product/checkout pages?
const cartCount = ref(0);

const updateCartCounter = async () => {
  try {
    const sizesResponse = await axios.get('http://localhost:3000/api/cart/count');
    cartCount.value = sizesResponse.data.count;
  } catch (error) {
    console.error("Something went wrong while updating the cart counter.", error);
  }
};

// https://stackoverflow.com/questions/72591866/how-to-fix-defineexpose-method-not-defined-in-vue3

// eslint-disable-next-line no-undef
defineExpose({ updateCartCounter });

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
