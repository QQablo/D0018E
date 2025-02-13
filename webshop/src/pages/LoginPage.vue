<template>
    <div class="login-page">
      <h2>Login</h2>
      
      <form @submit.prevent="login" class="form-container">
        <div class="input-group">
          <input
            type="email"
            id="email"
            v-model="email"
            placeholder="Enter your email"
            required
          />
        </div>

        <div class="input-group">
          <input
            type="password"
            id="password"
            v-model="password"
            placeholder="Enter your password"
            required
          />
        </div>
  
        <button type="submit">Login</button>
      </form>
      
      <p>Don't have an account? <router-link to="/signup">Sign Up</router-link></p>
    </div>
  </template>
  
<script setup>
import { ref} from "vue";
import axios from "axios";
import router from '@/router';

const email = ref('');
const password = ref('');

const login = async () => {
  if (!password.value || !email.value) {
      alert('All fields must be filled');
      return;
    }
  try {
    const credentials = {
        email: email.value,
        password: password.value
    }
    const response = await axios.post('http://localhost:3000/api/user/login', credentials);
    //console.log(response);
    if(response.status == 200){
        //  TODO: MIGHT NEED TO UPDATE THE CART 
        console.log("Successful login.");
        router.push({ name: 'homepage' });
    } 
  } catch (error) {
    alert('Invalid credentials.')
    console.log(error);
  }
};


</script>
  
  <style scoped>
  .login-page {
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
    margin-bottom: 20px;
  }
  
  .input-group label {
    font-size: 14px;
    color: #555;
    margin-bottom: 5px;
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
    background-color: #007bff;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  
  button:hover {
    background-color: #0056b3;
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
