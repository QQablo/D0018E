<template>
  <div>
      <h1>Your Cart</h1>
    </div>
</template>

<!--
<template>
    <div>
      <h1>Your Cart</h1>
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
  import { computed } from "vue";
  //import { ref, onMounted} from "vue";
  //import axios from "axios";

  //const cart = ref([]);

  const total = computed(() =>
  cart.value.reduce((sum, item) => sum + item.price * item.quantity, 0)
);

const updateQuantity = (id, quantity) => {
  const item = cart.value.find((item) => item.id === id);
  if (item) {
    item.quantity = quantity;
    saveCart();
  }
};

const removeFromCart = (id) => {
  cart.value = cart.value.filter((item) => item.id !== id);
  saveCart();
};

const saveCart = () => {

};
 
  </script>
  
-->