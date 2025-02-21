<template>
    <RouterLink :to="{name: 'cart'}">
        <button> Go Back </button>
    </RouterLink>
        
    <div class="checkout-page">
      <h2>Checkout</h2>
  
      <form @submit.prevent="createOrder" class="form-container">
        <div class="input-group">
          <input
            type="text"
            id="firstName"
            v-model="formData.firstName"
            placeholder="First Name"
            required
          />
        </div>

        <div class="input-group">
          <input
            type="text"
            id="lastName"
            v-model="formData.lastName"
            placeholder="Last Name"
            required
          />
        </div>

        <div class="input-group">
          <input
            type="email"
            id="email"
            v-model="formData.email"
            placeholder="Enter your email"
            required
          />
        </div>

        <div class="input-group">
          <input
            type="tel"
            id="phone"
            v-model="formData.phone"
            placeholder="Phone Number"
            required
          />
        </div>

        <div class="input-group">
          <input
            type="text"
            id="address"
            v-model="formData.shippingAddress"
            placeholder="Address"
            required
          />
        </div>

        <button type="submit">Simulate order</button>
      </form>
    <div class="order-info">
      <p>Nr of Items: {{ itemCount }} </p>
      <p>Total Price: {{ totalPrice }}</p>
    </div>
    </div>
</template>
  
<script setup>
import axios from 'axios';
import {reactive, ref, onMounted} from 'vue';
import { useRoute } from 'vue-router';


const $route = useRoute();

const formData = reactive ({
	firstName: '',
	lastName: '',
	email: '',
	phone: '',
	shippingAddress: ''
});

const itemCount = ref(0);
const totalPrice = ref(0);
        
const createOrder = async () => {
	//console.log(formData);
	if (!formData.firstName || !formData.lastName || !formData.email ||  !formData.phone || !formData.shippingAddress) {
		alert('Please fill in all fields');
		return;
	}

	const response = await axios.post('http://localhost:3000/api/orders/create', formData);
	if(response.status == 200){
		console.log("Order registered");
		console.log(response.data);
	}
}

const fetchCartCounter = async () => {
  try {
    const response = await axios.get('http://localhost:3000/api/cart/count');
    if (response.status == 200){
		itemCount.value = response.data.count;
    } 
  } catch (error) {
		console.error("Cart not available. Error: ", error.response.data.message);
  }
};

onMounted(() =>{
	fetchCartCounter();
	totalPrice.value = $route.params.price;
	// console.log(itemCount.value);
	// console.log(totalPrice.value);
});
</script>
  
<style scoped>
.checkout-page {
    max-width: 400px;
    margin: 50px auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

h2 {
    text-align: center;
    font-size: 28px;
    margin-bottom: 20px;
    color: #333;
}

.form-container {
    display: flex;
    flex-direction: column;
}

.input-group {
    margin-bottom: 15px;
}

.input-group input {
    padding: 10px;
    font-size: 16px;
    width: 100%;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}

button {
    padding: 12px;
    background-color: #28a745;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #218838;
}

p {
    text-align: center;
    margin-top: 15px;
}

router-link {
    color: #007bff;
    text-decoration: none;
}

router-link:hover {
    text-decoration: underline;
}
</style>