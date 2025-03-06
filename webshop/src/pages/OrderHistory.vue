<template>
	<NavigationBar />
	<div class="order-history">
		<h1>Order History</h1>
		<div v-if="ordersData.length == 0">
			<p>No orders found.</p>
		</div>
		<div v-else>
			<div v-for="order in orders" :key="order.order_id" class="order-card">
				<div class="order-header" @click="toggleOrderItems(order.order_id)">
					<h3>Order #{{ order.order_id }}</h3>
					<p><strong>Date:</strong> {{ new Date(order.date).toLocaleDateString() }}</p>
					<span class="arrow" :class="{'rotate': order.showItems}">&#x25BC;</span>
				</div>

				<div v-if="order.showItems" class="order-details">
					
					<p><strong>Total Price:</strong> ${{ order.price }}</p>
					<p><strong>Status:</strong> {{ order.status }}</p>
				
					<div class="order-items">
						<h4>Items:</h4>
						<table>
							<thead>
								<tr>
								<th>Product Name</th>
								<th>Quantity</th>
								<th>Size</th>
								<th>Price</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="item in order.items" :key="item.product_name">
									<td>{{ item.product_name }}</td>
									<td>{{ item.quantity }}</td>
									<td>{{ item.size }}</td>
									<td>${{ item.sub_total }}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import NavigationBar from '@/components/NavigationBar.vue';

const ordersData = ref([]);
const orders = ref([]);

const orderHistory = async () => {
	try {
		const response = await axios.get('http://localhost:3000/api/orders/history');
		if (response.status == 200) {
			if (response.data.data.length == 0) {
				console.log("No orders found.");
			} else {
				console.log("Orders data received.");
				ordersData.value = response.data.data;
				processOrders();
			}
		}
	} catch (error) {
		console.error("Something went wrong while fetching order history:", error);
	}
};

const processOrders = () => {
	const sortOrders = {};

	for (let i = 0; i < ordersData.value.length; i++) {
		const orderItem = ordersData.value[i];
		const orderId = orderItem.order_id;

		//check if order exists or not
		if (!sortOrders[orderId]) {
			sortOrders[orderId] = {
			order_id: orderItem.order_id,
			date: orderItem.date,
			price: orderItem.price,
			status: orderItem.current_status,
			items: [] 
			};
		}
		sortOrders[orderId].items.push({
			product_name: orderItem.product_name,
			quantity: orderItem.quantity,
			sub_total: orderItem.sub_total,
			size: orderItem.size
		});
	}
	orders.value = Object.values(sortOrders);
};

const toggleOrderItems = (orderId) => {
	for (let i = 0; i < orders.value.length; i++) {
		if (orders.value[i].order_id == orderId) {
			orders.value[i].showItems = !orders.value[i].showItems;
			break; 
		}
	}
};

onMounted(async () => {
	await orderHistory();
});
</script>

<style scoped>
.order-history {
	padding: 20px;
	max-width: 800px;
	margin: auto;
}

.order-card {
	border: 1px solid #ccc;
	padding: 15px;
	margin-bottom: 20px;
	border-radius: 8px;
	background-color: #f9f9f9;
}

.order-header {
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.order-details {
	margin-top: 10px;
}

.arrow {
	transition: transform 0.3s ease;
	display: inline-block;
}

.arrow.rotate {
	transform: rotate(180deg);
}

.order-items {
	margin-top: 10px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
</style>
