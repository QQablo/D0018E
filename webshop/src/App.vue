<template>
  <div>
    <header class="header">
      <h1>Welcome to Our Webshop</h1>
    </header>
    <img alt="Vue logo" src="./assets/logo.png">
    <ProductList :products="products" />
  </div>
</template>

<script>
import { reactive } from 'vue';
import ProductList from './components/ProductList.vue';

export default {
  name: 'App',
  components: {
    ProductList
  },
  setup() {
    const products = reactive([
    { image: 'https://i.imgur.com/gQgKIo9.jpeg', name: 'Adidas Samba', description: 'Adidas', price: 69.99 },
    { image: 'https://i.imgur.com/u9mP87O.jpeg', name: 'Nike Air Force 1', description: 'Nike', price: 89.99 },
      { image: 'https://i.imgur.com/Kby3OB5.jpeg', name: 'Nike Lunar Force', description: 'Nike', price: 69.99 },
      { image: 'https://i.imgur.com/XrTBCyq.jpeg', name: 'BOSS Sienne', description: 'BOSS', price: 59.99 },
      { image: 'https://i.imgur.com/u5Np6pK.jpeg', name: 'DIOR Boy', description: 'DIOR', price: 99.99 },
      { image: 'https://i.imgur.com/9nH5sM0.jpeg', name: 'GANT Wilmon', description: 'GANT', price: 19.99 },
      { image: 'https://i.imgur.com/rF8i3Qg.jpeg', name: 'ECCO Melbourne', description: 'ECCO', price: 119.99 },
      { image: 'https://i.imgur.com/Tp5bSfQ.jpeg', name: 'DIOR Timeless', description: 'DIOR', price: 79.99 },
      { image: 'https://i.imgur.com/d9RG5lx.jpeg', name: 'Pier One Eleganta', description: 'Pier One', price: 99.99 },
      { image: 'https://i.imgur.com/xsoTkVE.jpeg', name: 'Jack & Jones Jfwadam', description: 'Jack & Jones', price: 59.99 },
      { image: 'https://i.imgur.com/WkhfN1R.jpeg', name: 'Doc-Martens 1460', description: 'Doc Martens 1460', price: 99.99 },
      { image: 'https://i.imgur.com/ssZDa6M.jpeg', name: 'Timberlands 6', description: 'Timberlands', price: 79.99 }
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
