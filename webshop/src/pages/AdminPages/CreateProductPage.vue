<template>
    <AdminNavBar />
    <div class="form-container">
        <h1>Create a New Product</h1>
        <form @submit.prevent="submitForm">
            <label for="product-name">Product Name:</label>
            <input type="text" id="product-name" v-model="product.name" required />

            <label for="product-price">Price:</label>
            <input type="number" id="product-price" v-model="product.price" required />

            <label for="product-description">Description:</label>
            <textarea id="product-description" v-model="product.description" rows="5" required></textarea>

            <label for="product-image">Image Link (imgur):</label>
            <input type="text" id="product-image" v-model="product.image" required />

            <div id="sizesContainer">
                <h3>Sizes and Stock</h3>
                <div v-for="(size, index) in product.sizes" :key="index" class="size-stock-row">
                    <label class="size-label">Size:</label><br>
                    <select v-model="size.size" required>
                        <option value="" disabled>Select a size</option>
                        <option v-for="item in availableSizes(index)" :key="item.id" :value="item.id">
                            {{ item.size }}
                        </option>
                    </select>

                    <label class="stock-label">Stock:</label>
                    <input type="number" v-model="size.stock" min="0" required />

                    <button type="button" class="remove-size" @click="removeSize(index)">Remove</button>
                </div>
            </div>
            <button type="button" @click="addSize">Add Another Size</button>

            <div id="categoriesContainer">
                <h3>Categories</h3>
                <div v-for="category in categories" :key="category" class="categories">
                    <input type="checkbox" v-model="product.categories" :value="category.id" />
                    <label>{{ category.name }}</label>                    
                </div>    
            </div>
        <br>
        <button type="submit">Create Product</button>
        </form>
    </div>
</template>
  
<script setup>
import AdminNavBar from '@/components/AdminNavBar.vue';
import { reactive, ref, onMounted } from 'vue';
import axios from 'axios';
//import router from '@/config/router';
  
const categories = ref([]);
const sizes = ref([]);

const product = reactive({
    name: '',
    price: 0,
    description: '',
    image: '',
    sizes: [{ size: '', stock: 0 }], // Start with empty so that atleast 1 is required.
    categories: [],
});

const addSize = () => {
    product.sizes.push({ size: '', stock: 0 });
};

const removeSize = (index) => {
    if(index != 0){
        product.sizes.splice(index, 1);
    }
};

const availableSizes = (currentIndex) => {
    // Filters out the sizes stored in the product.sizes from the sizes reactive variable
    // so that they cannot be selected again.
    return sizes.value.filter(size => {
        return !product.sizes.some((s, i) => i !== currentIndex && s.size === size.id);
    });
};

const submitForm = async () => {
    try {
        if (product.categories.length > 0){
            const createProduct = await axios.post('http://localhost:3000/api/products/create', product);
            console.log(createProduct)
            if(createProduct.status == 200){
                console.log('Product created successfully.');
                alert('product created successfully');
                //router.push({ name: 'admin_create_product' });
            }
        } else {
            alert("Alteast one category is required.");
        }
        
    } catch (error) {
        console.error("Something went wrong while creating the product: ", error);
    }
};

const fetchCategories = async () => {
    try {
        const categoriesReturned = await axios.get('http://localhost:3000/api/products/categories');
        if (categoriesReturned.data.length > 0){
            for(let i = 0; i < categoriesReturned.data.length; i++){
                let category= {
                    id: categoriesReturned.data[i].category_id,
                    name: categoriesReturned.data[i].name
                }
                categories.value.push(category);          
            }
        }
    } catch (error) {
        console.error("Something went wrong while fetching categories: ", error);
    }
};

const fetchSizes = async () => {
    try {
        const response = await axios.get('http://localhost:3000/api/products/sizes');
        console.log(response.data)
        if (response.data.length > 0){
            for(let i = 0; i < response.data.length; i++){
                let tmp= {
                    id: response.data[i].size_id,
                    size: response.data[i].size
                }
                sizes.value.push(tmp);          
            }
        }
    } catch (error) {
        console.error("Something went wrong while fetching the sizes: ", error);
    }
};

onMounted(async () =>{
    await fetchCategories();
    await fetchSizes();
});
</script>
  
<style scoped>
.form-container {
    max-width: 500px;
    margin: 50px auto;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label, input, textarea {
    display: block;
    width: 250px;
    margin-top: 10px;
    
    text-align: left;
}

input[type="text"], input[type="number"], textarea {
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.size-stock-row {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 10px;
}

.size-stock-row input, .size-stock-row label  {
    width: 80px;
} 

.categories {
    display: flex;
}

button {
    padding: 10px 15px;
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

button:hover {
    background: #0056b3;
}

.remove-size {
    background: #dc3545;
}

.remove-size:hover {
    background: #c82333;
}
</style>