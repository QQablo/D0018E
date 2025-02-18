<template>
  <NavigationBar />
  <div>
    <h1>Categories</h1>
    <div v-for="category in categoriesData" :key="category.id">
      <router-link :to="'/category/' + category.id">
        <h3>{{ category.name }}</h3>
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import NavigationBar from '@/components/NavigationBar.vue';

const categoriesData = ref([]);


const fetchCategories = async () => {
  try {
    const categoryResponse = await axios.get('http://localhost:3000/api/products/categories');
    if (categoryResponse.data.length > 0){
            for(let i = 0; i < categoryResponse.data.length; i++){
                let category= {
                    id: categoryResponse.data[i].category_id,
                    name: categoryResponse.data[i].name
                }
                categoriesData.value.push(category);          
            }
        }
    //console.log(categoriesData.value);

  } catch (error) {
    console.error("Something went wrong while fetching categories:", error);
  }
};

onMounted(() => {
  fetchCategories();
});

</script>