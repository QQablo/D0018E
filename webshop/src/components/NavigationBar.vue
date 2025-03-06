<template>
    <nav class="navbar">
      <ul>
        <li><router-link to="/">Home</router-link></li>
        <li v-if="!loggedIn"><router-link to="/login">Login</router-link></li>
        <li v-if="!loggedIn"><router-link to="/signup">Signup</router-link></li>

        <li><router-link to="/categories">Categories</router-link></li>
		<li v-if="loggedIn && isCustomer"><router-link to="/orderhistory">Order History</router-link></li>
		<li v-if="loggedIn && isAdmin"><router-link :to="{name: 'admin_products'}">Admin</router-link></li>
		<li v-if="loggedIn"><router-link @click="logout" to="#">Logout</router-link></li>
		<li><router-link :to="{name:'cart'}">🛍️ ({{ cartCount }})</router-link></li> 
      </ul>
    </nav>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import checkAuth from '../utils/auth.js';
import { useRouter } from 'vue-router';

const router = useRouter();

const cartCount = ref(0);
const loggedIn = ref(false);
const isAdmin = ref(false);
const isCustomer = ref(false);

const updateCartCounter = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/cart/count');
    if (response.status == 200){
		cartCount.value = response.data.count;
    } else{
		cartCount.value = 0;
	}
  } catch (error) {
		console.error("Cart not available. Error: ", error.response.data.message);
  }
};

const logout = async () => {
    try {
		await axios.get('http://localhost:3000/api/user/logout');
		loggedIn.value = false;
		router.push('/login');
    } catch (error) {
		console.error("Error logging out: ", error.response.data.message);
    }
};

// eslint-disable-next-line no-undef
defineExpose({ updateCartCounter });

onMounted(async () =>{
    await updateCartCounter();
    const userAuth = await checkAuth();
	//console.log(userAuth);
	
	if (userAuth.auth){
		if(userAuth.role == 'customer') {
			isCustomer.value = true;
		} else if (userAuth.role == 'admin'){
			isAdmin.value = true;
		}
		loggedIn.value = true;
	}

	// console.log(isAdmin.value)
	// console.log(isCustomer.value)
	// console.log(loggedIn.value)
})
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

