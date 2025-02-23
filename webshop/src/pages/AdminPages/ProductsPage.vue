<template>
    <AdminNavBar />
    <div class="admin-products-page">
        <h1>Products</h1>
        <div class="control-buttons">
            <select v-model="selectedCategory">
                <option value=""></option>
                <option v-for="category in categories" :key="category.category_id" :value="category.category_id">
                    {{ category.name }}
                </option>
            </select>
        
            <RouterLink :to="{name:'admin_create_product'}">
                <button @click="goToCreateProduct" class="create-button">Create New Product</button>
            </RouterLink>
        </div>
        
        <table class="products-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Edit</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="product in products" :key="product.product_id">
                    <td>{{ product.product_id }}</td>
                    <td>{{ product.name }}</td>
                    <td>${{ product.price }}</td>
                    <td class="edit-button-cell"> 
                        <button class="edit-button">Edit</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
  </template>
  
<script setup>
import { ref, onMounted, watch } from 'vue';
import axios from 'axios';
import AdminNavBar from '@/components/AdminNavBar.vue';


const products = ref([]); 
const categories = ref([]); 
const selectedCategory = ref(''); 
  

const fetchCategories = async () => {
    try {
        const response = await axios.get('http://localhost:3000/api/products/categories');
        //console.log(response.data);
        categories.value = response.data;
    } catch (error) {
        console.error('Error fetching categories:', error);
    }
};

const fetchAllProducts = async () => {
    try {
        const response = await axios.get('http://localhost:3000/api/products/products');
        products.value = response.data.data;
        //console.log(response.data.data)
    } catch (error) {
        console.error('Error fetching products:', error);
    }
};

const fetchProductsByCategory = async (categoryId) => {
    try {
        // console.log('INPUT: ' + categoryId)
        const response = await axios.get('http://localhost:3000/api/products/category_products?category_id='+ categoryId);
        products.value = response.data;
        // console.log('Here: ' + response.data)
    } catch (error) {
        console.error('Error fetching products:', error);
    }
}

watch(selectedCategory, async(newValue, oldValue) => {
    console.log('Selected option changed from', oldValue, 'to', newValue);
    if(newValue == ''){
        await fetchAllProducts();
    } else{
        await fetchProductsByCategory(newValue)
    }

});
  

onMounted(async () => {
    await fetchCategories();
    await fetchAllProducts();
});
</script>
  
<style scoped>
.admin-products-page {
    margin-left: 200px; 
    padding: 20px;
}

h1 {
    margin-bottom: 20px;
}

.control-buttons {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}

select {
    padding: 8px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.create-button {
    padding: 8px 16px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

.create-button:hover {
    background-color: #218838;
}

.products-table {
    width: 100%;
    border-collapse: collapse;
}

.products-table th, .products-table td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: left;
}

.products-table th {
    background-color: #f8f9fa;
    font-weight: bold;
}

.edit-button {
    padding: 6px 12px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    text-align: center;
}

.edit-button:hover {
    background-color: #0056b3;
}
</style>