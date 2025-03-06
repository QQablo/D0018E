<template>
    <AdminNavBar />
    <div class="form-container">
        <h1>Edit Product</h1>
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
                <div v-for="(size, index) in product.sizes" :key="size.size_id" class="size-stock-row">
                    <label class="size-label">Size:</label><br>
                    <select v-model="size.size_id" required>
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
                <div v-for="category in categories" :key="category.id" class="categories">
                    <input type="checkbox" v-model="product.categories" :value="category.id" />
                    <label>{{ category.name }}</label>                    
                </div>    
            </div>
        <br>
        <button type="submit">Update Product</button>
        </form>
    </div>
</template>

<script setup>
import AdminNavBar from '@/components/AdminNavBar.vue';
import { reactive, ref, onMounted } from 'vue';
import axios from 'axios';
import { useRoute } from 'vue-router';
import router from '@/config/router';

const route = useRoute();
const productId = route.params.id;

const categories = ref([]);
const sizes = ref([]);

const product = reactive({
    productId,
    name: '',
    price: 0,
    description: '',
    image: '',
    sizes: [],
    categories: [],
});

const addSize = () => {
    product.sizes.push({ size: '', stock: 0 });
};

const removeSize = (index) => {
    if (product.sizes.length > 1) {
        product.sizes.splice(index, 1);
    }
};

const submitForm = async () => {
    try {
        if (product.categories.length > 0) {
            const response = await axios.put(`products/update`, product);
            if (response.status === 200) {
                alert('Product updated successfully');
                await router.push({ name: 'admin_products' });
            }
        } else {
            alert("At least one category is required.");
        }
    } catch (error) {
        console.error("Error updating product:", error);
    }
};

const fetchCategories = async () => {
    try {
        const response = await axios.get('products/categories');
        categories.value = response.data.map(c => ({
            id: c.category_id,
            name: c.name
        }));
    } catch (error) {
        console.error("Error fetching categories:", error);
    }
};

const fetchSizes = async () => {
    try {
        const response = await axios.get('products/sizes');
        //console.log("Sizes: ", response.data)
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
        console.error("Error fetching sizes:", error);
    }
};

const availableSizes = (currentIndex) => {
    const currentSizeId = product.sizes[currentIndex].size_id;
    return sizes.value.filter(size => {
        // Keep the current size or sizes not used in other rows.
        return size.id === currentSizeId ||
            !product.sizes.some((s, i) => i !== currentIndex && s.size_id === size.id);
    });
};

const fetchProduct = async () => {
    try {
        const response = await axios.get(`products/product?id=${productId}`);
        //console.log(response.data.data);
        if (response.status == 200) {
            const productData = response.data.data[0];
            product.name = productData.name;
            product.price = productData.price;
            product.description = productData.description;
            product.image = productData.image;
            //console.log(productData)
            await fetchProductSizes();
            await fetchProductCategories();
        } else {
            console.log("Could not fetch the product? Response check: ", response)
        }
    } catch (error) {
        console.error("Error fetching product:", error);
    }
};

const fetchProductSizes = async () => {
    try {
        console.log("Product ID", productId)
        const response = await axios.get(`products/product_sizes?id=${productId}`);
        console.log("Current product sizes: ", response.data)
        product.sizes.push(...response.data.data);
        //console.log(product)
    } catch (error) {
        console.error("Error fetching sizes:", error);
    }
};

const fetchProductCategories = async () => {
    try {
        const response = await axios.get(`products/product_categories?id=${productId}`);
        //console.log(response.data)
        const categoryIds = response.data.data.map(c => c.category_id);
        console.log(categoryIds);
        product.categories.push(...categoryIds);
    } catch (error) {
        console.error("Error fetching sizes:", error);
    }
};

onMounted(async () => {
    await fetchProduct();
    await fetchSizes();
    await fetchCategories();
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