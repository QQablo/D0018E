<template>
  <NavigationBar ref="navbar" />
  <div class="product-page">
    <div v-for="product in productData.List" :key="product.product_id" class="product-details">
      <h1>{{ product.name }}</h1>
      <img :src="product.image" width="350" height="350" />
      <h4>{{ product.price }}</h4>
      <p>{{ product.description }}</p>
    </div>
  
    <div class="sizes">
      <h2>Select Size:</h2>
      <div class="grid">
        <div 
          v-for="size in sizes" 
          :key="size.size_id" 
          :class="{'selected': selectedSize === size.size}"
          @click="selectSize(size.size)"
          class="size-item"
        >
          {{ size.size }}
        </div>
      </div>

      <button @click="addToCart" :disabled="!selectedSize">Add to Cart</button>
    </div>
</div>
  </template>
  
<script setup>
import { useRoute } from "vue-router";
import { onMounted, reactive, ref } from "vue";
import NavigationBar from '@/components/NavigationBar.vue';
//import { useCartStore } from '@/stores/cart';
import axios from "axios";

//const cartStore = useCartStore();

  
const $route = useRoute();

const productData = reactive({
    List:[]
});
const sizes = ref([]);  
const selectedSize = ref(null); 
const navbar = ref();

const Product = async () => {
  const productId = $route.params.id;
    try {
      const productResponse = await axios.get(`http://localhost:3000/api/products/product?id=${productId}`);
      //console.log(productResponse.data);
      productData.List = productResponse.data.data;
      //console.log(productData.List)
    } catch (error) {
      console.error("Something went wrong while fetching product details:", error);
    }
};
  
const ProductSizes = async () => {
  const productId = $route.params.id;
  try {
    const sizesResponse = await axios.get(`http://localhost:3000/api/products/product_sizes?product_id=${productId}`);
    sizes.value = sizesResponse.data.data;
  } catch (error) {
    console.error("Something went wrong while fetching sizes:", error);
  }
};

const selectSize = (size) => {
  selectedSize.value = size;
};
  
const addToCart = async () => {
  console.log("Product is added to Cart:", selectedSize.value);
  const productId = $route.params.id;
  const args = {
    product_id:productId,
    size:selectedSize.value
  }
  
  try {
    const response = await axios.post('http://localhost:3000/api/cart/add', args);
    console.log(response);
    if(response.status == 200){
      navbar.value.updateCartCounter();
    }
  } catch (err) {
    console.error("Something went wrong while fetching sizes:", err);
  }
};

onMounted(() => {
  Product();
  ProductSizes();
});
</script>
  
<style scoped>
.product-page {
  display: flex;
  align-items: flex-start;
  gap: 20px;
}

.product-details {
  flex: 1;
  max-width: 50%;
}

.product-details img {
  border-radius: 8px;
  margin-bottom: 10px;
}

.sizes {
  display: flex;
  flex-direction: column;
  align-items: center; 
}

.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 2px;
  margin-top: 5px;
  border: 1px solid #ccc;
  padding: 5px;
}

.size-item {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 5px;
  border: 1px solid #aaa;
  cursor: pointer;
  background-color: #f8f8f8;
  font-size: 14px;
  height: 35px;
  width: 35px;
}

.size-item:hover {
  background-color: #e0e0e0;
}

.size-item.selected {
  background-color: #414641;
  color: white;
}

button {
  margin-top: 10px;
  padding: 8px 15px;
  background-color: #3d423d;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  width: auto; 
  align-self: center; 
}

button:disabled {
  background-color: rgb(165, 169, 170);
  cursor: not-allowed;
}
</style>