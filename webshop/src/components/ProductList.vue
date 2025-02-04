<template>
  <div class="products">
    <div v-for="(product, index) in products" :key="index" class="product-card">
      <img :src="product.image" :alt="product.name" class="product-image" />
      <h2>{{ product.name }}</h2>
      <p>{{ product.description }}</p>
      <p>Price: ${{ product.price }}</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProductList',
  props: {
    products: Array
  }
}
</script>

<style scoped>
.products {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  gap: 20px;
  padding: 20px;
}
.product-card {
  border: 1px solid #ddd;
  padding: 20px;
  text-align: center;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}
.product-image {
  width: 100%;
  height: auto;
  max-height: 250px;
  object-fit: contain;
}
</style>
