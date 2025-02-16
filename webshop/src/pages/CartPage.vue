<template>
    <NavigationBar ref="navbar" />
    <h1>Your Cart</h1>
    <div>
        <div v-if="cartProducts.length == 0">Your cart is empty.</div>

        <div v-else>
            <div v-for="product in cartProducts" :key="product.product_id" class="cart-product">
                <img :src="product.image" width="50" />
                <h3>{{ product.name }}</h3>
                <p>Size: {{ product.size }}</p>
                <p>Sub total: ${{ product.subTotal }}</p>
                <div class="quantity-buttons">
                    <button @click="decrease(product.product_id, product.size)">-</button>
                    <p>{{ product.quantity }}</p>
                    <button @click="add(product.product_id, product.size)">+</button>
                    <button @click="removeFromCart(product.item_id)">Remove</button>    
                </div>
            </div>

            <h2>Total: ${{ totalPrice }}</h2>
            <button @click="checkout">Checkout</button>
        </div>
    </div>
</template>
  
<script setup>
import { ref, onMounted} from "vue";
import axios from "axios";
import NavigationBar from '@/components/NavigationBar.vue';

const cartProducts = ref([]);
const totalPrice = ref(0);
const navbar = ref();
const cartIsEmtpy = ref(true);


const fetchCartProducts = async () => {
    try {
        const response = await axios.get('http://localhost:3000/api/cart/items');
        //console.log(response.data);
        //console.log("1")
        if(response.status == 200){
            //console.log("2")
            console.log(response.data);
            if (response.data.length > 0){
                cartProducts.value = [];
                totalPrice.value = 0;
                for(let i = 0; i < response.data.length; i++){
                    let product= {
                        item_id: response.data[i].cart_item_id,
                        product_id: response.data[i].product_id,
                        name: response.data[i].product_name,
                        quantity: response.data[i].quantity,
                        size: response.data[i].size,
                        subTotal: response.data[i].sub_total,
                        image: response.data[i].image
                    }
                    
                    cartProducts.value.push(product); 
                    totalPrice.value += parseFloat(product.subTotal);
                }
                console.log(cartProducts.value);
                cartIsEmtpy.value = false;
            } 
        }else if(response.status == 204 && !cartIsEmtpy.value){ // Emtpy/Inexistent cart
            // console.log("Hello")
            // console.log(response)
            location.reload();
        }
            console.log(response.status);
    } catch (err) {
        console.error("Something went wrong while fetching sizes:", err.response.data.message);
    }
}

const add = async (productId, size) => {
    try {
        const input = {
            product_id: productId,
            size: size
        }
        const response = await axios.post('http://localhost:3000/api/cart/add', input);

        if(response.status == 200){
            console.log("Added successfully", response);
            navbar.value.updateCartCounter();
            fetchCartProducts();
        } else {
            console.log("error");
        }
    } catch (error) {
      console.error("Something went wrong while fetching product details:", error);
    }
};

const decrease = async (productId, size) => {
    try {
        const input = {
            product_id: productId,
            size: size
        }
        const response = await axios.put('http://localhost:3000/api/cart/delete', input);

        if(response.status == 200){
            console.log("Removed successfully", response);
            navbar.value.updateCartCounter();
            fetchCartProducts();
        } else {
            console.log("error");
        }
    } catch (error) {
      console.error("Something went wrong while fetching product details:", error);
    }
};

onMounted(async () => {
    navbar.value.updateCartCounter();
    fetchCartProducts();
});
</script>
  
<style scoped>
.quantity-buttons{
    display: flex;
    margin: 0 auto;
    width: 100px;
    gap: 10px;
    align-items: center;
}

.quantity-buttons button{
    height: fit-content;
    width: fit-content;
    
}

.cart-product{
    padding: 5px;
    margin: 5px auto;
    border: 1px solid black;
    width: 200px;
    
}
</style>