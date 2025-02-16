<template>
    <h1>Your Cart</h1>
    <div>
      <div v-if="cart.length === 0">Your cart is empty.</div>
  
      <div v-for="item in cart" :key="item.id">
        <img :src="item.image" width="50" />
        <h3>{{ item.name }} - ${{ item.price }} x {{ item.quantity }}</h3>
        <button @click="updateQuantity(item.id, Math.max(item.quantity - 1, 1))">-</button>
        <button @click="updateQuantity(item.id, item.quantity + 1)">+</button>
        <button @click="removeFromCart(item.id)">Remove</button>
      </div>
  
      <h2>Total: ${{ total.toFixed(2) }}</h2>
      <button @click="checkout">Payment</button>
    </div>
</template>
  
<script setup>
import { ref, onMounted} from "vue";
import axios from "axios";

const cart = ref([]);

onMounted(async () => {
    try {
    const response = await axios.get('http://localhost:3000/api/cart/items');
    console.log(response);
    if(response.status == 200){
      
    }
    } catch (err) {
        console.error("Something went wrong while fetching sizes:", err);
    }
});
</script>
  
<style scoped>

</style>