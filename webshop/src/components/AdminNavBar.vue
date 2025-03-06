<template>
    <nav class="admin-navbar">
      <ul>
        <li><router-link :to="{ name: 'admin_products' }">Products</router-link></li>
        <li><router-link :to="{ name: 'admin_orders' }">Orders</router-link></li>
        <li><router-link :to="{ name: 'homepage' }">Shop</router-link></li>
        <li><a href="#" @click="logout">Logout</a></li>
      </ul>
    </nav>
</template>
  
<script setup>
import axios from 'axios';
import { useRouter } from 'vue-router';

const router = useRouter();

const logout = async () => {
    try {
		await axios.get('http://localhost:3000/api/user/logout');
		router.push('/login');
    } catch (error) {
		console.error("Error logging out: ", error.response.data.message);
    }
};
</script>
  
<style scoped>
.admin-navbar {
    background-color: #333; 
    width: 200px; 
    height: 100vh; 
    padding: 20px 0; 
    position: fixed; 
    top: 0;
    left: 0;
}

.admin-navbar ul {
    list-style-type: none; 
    padding: 0;
    margin: 0;
}

.admin-navbar li {
    margin: 15px 0; 
}

.admin-navbar a {
    color: white; 
    text-decoration: none; 
    font-size: 18px; 
    padding: 10px 20px; 
    display: block; 
}

.admin-navbar a:hover {
    text-decoration: underline;
}

.admin-navbar a.router-link-active {
    background-color: #34495e; 
	font-weight: bold; 
}
</style>