<template>
  <div>
    <header class="header">
      <h1>Welcome to Our Webshop</h1>
    </header>
    <img alt="Vue logo" src="./assets/logo.png">
    <HelloWorld :products="products" />
  </div>
</template>

<script>
import { reactive } from 'vue';
import HelloWorld from './components/HelloWorld.vue';

export default {
  name: 'App',
  components: {
    HelloWorld
  },
  setup() {
    const products = reactive([
      { image: 'Adidas_Samba.jpg', name: 'Adidas Samba', description: 'Adidas', price: 69.99 },
      { image: 'BOSS_Sienne.jpg', name: 'BOSS Sienne', description: 'BOSS', price: 59.99 },
      { image: 'DIOR_Boy.jpg', name: 'DIOR Boy', description: 'DIOR', price: 99.99 },
      { image: 'DIOR_Timeless.jpg', name: 'DIOR Timeless', description: 'DIOR', price: 79.99 },
      { image: 'Doc-Martens_1460.jpg', name: 'Doc-Martens 1460', description: 'Doc Martens 1460', price: 59.99 },
      { image: 'Nike_Air_Force_1.jpg', name: 'Nike Air Force 1', description: 'Nike', price: 89.99 },
    ]);

    return { products };
  }
}
</script>

<style>
.header {
  text-align: center;
  background-color: #2c3e50;
  color: white;
  padding: 20px;
  font-size: 24px;
}
</style>
