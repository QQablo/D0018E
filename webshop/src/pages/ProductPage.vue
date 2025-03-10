<template>
	<NavigationBar ref="navbar" />
	<div class="product-page">
		<div class="product-container">
			<div v-for="product in productData.List" :key="product.product_id" class="product-details">
				<h1>{{ product.name }}</h1>
				<img :src="product.image" width="350" height="350" />
				<h4>${{ product.price }}</h4>
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
					class="size-item">
						{{ size.size }}
					</div>
				</div>
				<button @click="addToCart" :disabled="!selectedSize">Add to Cart</button>
			</div>
		</div>
	</div>
	
	<div style="width: 600px; margin: 0 auto;">
		<div v-if="canWriteReview" class="review-section"  >
			<h3>Leave a review</h3>
			<form @submit.prevent="submitReview" class="review-form">
				<label for="title">Review Title:</label>
				<input id="title" v-model="review.title" required />
				<label for="review">Review:</label>      
				<textarea id="review" v-model="review.text" maxlength="150" required></textarea>
				<label for="rating">Rating:</label>
				<select id="rating" v-model.number="review.rating" required>
					<option value="" disabled>Select</option> 
					<option value="5">5</option>
					<option value="4">4</option>
					<option value="3">3</option>
					<option value="2">2</option>
					<option value="1">1</option>
				</select>
				<input class="button" type="submit" value="Submit">  
			</form>
		</div>

		<!-- Display Reviews -->
		<div class="reviews-section">
			<h3>Customer Reviews</h3>
			<div v-if="reviewData.List.length === 0">No reviews yet.</div>
			<div v-for="review in reviewData.List" :key="review.review_id" class="review">
				<h4>{{ review.title }}</h4>
				<p><strong>Rating:</strong> {{ review.stars }} ⭐</p>
				<p>{{ review.text }}</p>
				<p><em>By: {{ review.first_name }} {{ review.last_name }}</em></p>
			</div>
		</div>
	</div>
</template>
  
<script setup>
import { useRoute } from "vue-router";
import { onMounted, reactive, ref } from "vue";
import NavigationBar from '@/components/NavigationBar.vue';
import axios from "axios";
import checkAuth from '../utils/auth.js';
import router from "@/config/router.js";
  
const $route = useRoute();
const productData = reactive({ List: [] });
const sizes = ref([]);  
const selectedSize = ref(null); 
const navbar = ref();
const loggedIn = ref(false);
//const hasBoughtProduct = ref(false);
const canWriteReview = ref(false);
const reviewData = reactive({ List: [] });
const availableOrderItemId = ref(null);

const review = reactive({
	title: '',
	text: '',
	stars: null,
});

const Product = async () => {
	const productId = $route.params.id;
	try {
		const productResponse = await axios.get(`products/product?id=${productId}`);

		if (productResponse.status == 200) {
			console.log("Product data received.");
			productData.List = productResponse.data.data;
		}
	} catch (error) {
		console.error("Something went wrong while fetching product details:", error);
	}
};
  
const ProductSizes = async () => {
	const productId = $route.params.id;
	// console.log("PRODUCT ID", productId)
	try {
		const sizesResponse = await axios.get(`products/product_sizes?id=${productId}`);

		if (sizesResponse.status == 200) {
			console.log("Product_sizes returned");
			sizes.value = sizesResponse.data.data;
		}
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
		const response = await axios.post(`cart/add`, args);

		// console.log(response);
		if (response.status == 200) {
			navbar.value.updateCartCounter();
		}
	} catch (err) {
		console.error("Something went wrong while adding to cart:", err);
	}
};

const fetchReviews = async () => { 
	const productId = $route.params.id;
	try {
		const reviewResponse = await axios.get(`products/product_reviews?id=${productId}`);

		if (reviewResponse.status == 200) {
			if (reviewResponse.data.data.length == 0) {
				console.log("There are no reviews for this product.");
			} else {
				console.log("Review data received.");
				reviewData.List = reviewResponse.data.data;
			}
		}
	} catch (error) {
		console.error("Something went wrong while fetching reviews:", error);
	}
};

const submitReview = async () => {
	const productId = $route.params.id;
	const R_args = {
		product_id: productId,
		title: review.title,
		text: review.text,
		stars: review.rating,
		order_item_id: availableOrderItemId.value.order_item_id
	}
	try {
		const response = await axios.post(`products/add_review`, R_args);

		if (response.status == 200) {
			console.log("Review submitted successfully");
			alert("Review submitted!")	
			router.go();
		}
	} catch (error) {
		console.error("Something went wrong while submitting review:", error);
	}
};


const customerCanWriteReview = async () => {
	const productId = $route.params.id;
	try {
		const response = await axios.get(`orders/can_write_review?product_id=${productId}`);

		
		if (response.status == 204) {
			// Not a logged in user so do nothing.
			console.log("Cannot write review");
		} else if (response.status == 200){
			canWriteReview.value = true;
			if(response.data.data.length <= 0){
				throw new Error('No id for an order item even though atleast one should be returned.')
			}
			// Pick the first order item id in case of a review.
			availableOrderItemId.value = response.data.data[0];
			
			console.info("Customer, can write review. Available reviews for this product: ", response.data.data.length);
		}
	} catch (err) {
		console.error("Something went wrong while adding to cart:", err);
	}
};

onMounted(async () => {
	await Product();
	await ProductSizes();
	await fetchReviews();
	loggedIn.value = await checkAuth('customer');
	if(loggedIn.value){
		// Check for the possibly to write reviews only if the customer is logged in.
		await customerCanWriteReview();
	}
});
</script>
  
<style scoped>
.product-page {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.product-container {
	display: flex;
	align-items: flex-start;
	gap: 20px;
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


.review-section { 
	margin: 20px auto;
	padding: 20px;
	border-top: 2px solid #ccc;
	background-color: #f9f9f9;
	border-radius: 8px;
	width: 50%; 
	box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.2);
}

.review-form {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.review-form input, .review-form textarea, .review-form select {
	padding: 8px;
	border: 1px solid #aaa;
	border-radius: 5px;
	width: 100%;
}

.button {
	padding: 10px;
	background-color: #3d423d;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	width: auto; 
	max-width: 200px;  
	margin: 0 auto;  
}


.reviews-section {
	width: 50%;
	margin: 20px auto;
	padding: 15px;
	background: #f9f9f9;
	border-radius: 10px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

.review {
	padding: 10px;
	border-bottom: 1px solid #ddd;
}
</style>
