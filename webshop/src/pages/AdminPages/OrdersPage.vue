<template>
    <AdminNavBar />
    <div class="admin-products-page">
        <h1>Orders</h1>
        <div class="control-buttons">
            <div>
                <p style="display:inline-block; margin-right: 20px;">Current Status: </p>
                <select v-model="selectedStatus">
                    <option v-for="status in statuses" :key="status.statuses" :value="status.statuses">
                        {{ status.statuses }}
                    </option>
                </select>
            </div>
            
        </div>
        <div v-if="orders.length == 0">
			<p>No orders found with status {{ selectedStatus }}.</p>
		</div>
		<div v-else>
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer ID</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Edit Status</th>
                    </tr>
                </thead> 
                <tbody>
                    <template v-for="order in orders" :key="order.order_id">
                        <tr>
                            <td>{{ order.order_id }}</td>
                            <td>{{ order.customer_id }}</td>
                            <td>{{ order.date.split('T')[0] }}</td>
                            <td>${{ order.total }}</td>
                            <td class="edit-button-cell" style="width: 200px;">
                                <button class="edit-button"  @click="toggleItems(order.order_id)" style="margin-right: 30px;">
                                    {{ openOrders.includes(order.order_id) ? 'Hide' : 'View' }}
                                </button>
                            </td>
                        </tr>

                        <!-- Update status -->
                        <tr v-if="openOrders.includes(order.order_id)">
                            <td colspan="5">
                                <button style="margin-right:20px; font-size:15px;" class="myButton" @click="updateStatus(order.order_id)">Update Status to</button>
                                <select v-model="newStatus">
                                    <option value="selectedStatus" disabled>{{ selectedStatus  }}</option>
                                    <option v-for="status in statuses.filter(s => s.statuses != order.current_status)" :value="status.statuses" :key="status.statuses">
                                        {{ status.statuses }}
                                    </option>
                                </select>
                            </td>
                        </tr>

                        <!-- Display customer info -->
                        <tr v-if="openOrders.includes(order.order_id)" style="width: 100%;">
                            <td colspan="5" >
                                <p style="display: inline-block;">Customer: {{ order.first_name }} {{ order.last_name }} |</p>
                                <p style="display: inline-block; margin-left: 20px;">Shipping Address: {{ order.shipping_address }} |</p>
                                <p style="display: inline-block; margin-left: 20px;">Phone: {{ order.phone }}</p>
                            </td>
                        </tr>

                        <!-- Order items -->
                        <tr v-if="openOrders.includes(order.order_id)">
                            <td colspan="5">
                                <div class="order-items-container">
                                    <!-- Add shipping info -->
                                    <table class="order-items-table">
                                        <thead>
                                            <tr>
                                                <th>Product</th>
                                                <th>Quantity</th>
                                                <th>Size</th>
                                                <th>Price</th>
                                                <th>Subtotal</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="item in order.items" 
                                                :key="item.order_item_id">
                                                <td>{{ item.product_name }}</td>
                                                <td>{{ item.quantity }}</td>
                                                <td>{{ item.size }}</td>
                                                <td>${{ item.price }}</td>
                                                <td>${{ item.sub_total }}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </template>
                </tbody>
            </table>
        </div>
    </div>
</template>
  
<script setup>
import { ref, onMounted, watch } from 'vue';
import axios from 'axios';
import AdminNavBar from '@/components/AdminNavBar.vue';

const orders = ref([]);
const ordersItems = ref([]);
const statuses = ref([]);
const selectedStatus = ref('');
// Variable to check which orders are being viewed. 
const openOrders = ref([]);
const newStatus = ref('');

const fetchStatuses = async () => {
    try {
        const response = await axios.get('orders/status');
        statuses.value = response.data.data;
        selectedStatus.value = statuses.value[0].statuses;
    } catch (error) {
        console.error('Error fetching categories:', error);
    }
};

const fetchOrdersByStatus = async (status) => {
    try {
        const response = await axios.get('orders/order_status?status=' + status);
        //console.log("DATA ", response.data.data);
        ordersItems.value = response.data.data;

        const ordersMap = new Map();
        ordersItems.value.forEach(item => {
            const orderId = item.order_id;
            if (!ordersMap.has(orderId)) {
                ordersMap.set(orderId, {
                    order_id: orderId,
                    date: item.date,
                    email: item.email,
                    first_name: item.first_name,
                    last_name: item.last_name,
                    phone: item. phone,
                    shipping_address: item.shipping_address,
                    customer_id: item.customer_id,
                    current_status: item.current_status,
                    items: [],
                    total: item.price
                });
            }
            const order = ordersMap.get(orderId);
            const { price, quantity, size, order_item_id, product_name, sub_total } = item;
            order.items.push({ price, quantity, size, order_item_id, product_name, sub_total });
        });
        
        //console.log("Orders list ", Array.from(ordersMap.values()));
        orders.value = Array.from(ordersMap.values());
    } catch (error) {
        console.error('Error fetching orders by status:', error);
    }
};

const toggleItems = (orderId) => {
    if (openOrders.value.includes(orderId)) {
        // Remove the order from list.
        openOrders.value = openOrders.value.filter(id => id !== orderId);
    } else {
        openOrders.value.push(orderId);
    }
};

const updateStatus = async (orderId) => {
    try {
        // console.log("Order id ", orderId);
        // console.log("Selected status ", newStatus.value)
        if(newStatus.value != ''){
            const response = await axios.put('orders/update_status', { orderId: orderId, newStatus: newStatus.value});
            if (response.status == 200){
                console.log("Status updated!");
                console.log(response.data.message);
                await fetchOrdersByStatus(selectedStatus.value);
            }
        }
        
    } catch (error) {
        console.error('Error updating order status:', error);
    }
};

watch(selectedStatus, async (newValue) => {
    await fetchOrdersByStatus(newValue);
    openOrders.value = [];
});

onMounted(async () => {
    await fetchStatuses();
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

.orders-table {
    width: 100%;
    border-collapse: collapse;
}

.orders-table th, .orders-table td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: left;
}

.orders-table th {
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

.order-items-container {
    padding: 15px;
    background-color: #f8f9fa;
    border-top: 2px solid #dee2e6;
}

.order-items-table {
    width: 100%;
    margin-top: 10px;
    background-color: white;
}

.order-items-table th {
    background-color: #e9ecef;
    padding: 8px 12px;
}

.order-items-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #dee2e6;
}

.myButton {
	background:linear-gradient(to bottom, #ededed 5%, #bab1ba 100%);
	background-color:#ededed;
	border-radius:5px;
	border:1px solid #d6bcd6;
	display:inline-block;
	cursor:pointer;
	color:#3a8a9e;
	font-family:Arial;
	font-size:12px;
	padding:7px 25px;
	text-decoration:none;
	text-shadow:0px 1px 0px #e1e2ed;
}
.myButton:hover {
	background:linear-gradient(to bottom, #bab1ba 5%, #ededed 100%);
	background-color:#bab1ba;
}
.myButton:active {
	position:relative;
	top:1px;
}
</style>
