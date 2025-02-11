<template>
    <div class="signup-page">
      <h2>Sign Up</h2>
  
      <form @submit.prevent="signup" class="form-container">
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
            v-model="formData.address"
            placeholder="Address"
            required
          />
        </div>

        <div class="input-group">
          <input
            type="password"
            id="password"
            v-model="formData.password"
            placeholder="Enter your password"
            required
          />
        </div>
  
        <div class="input-group">
          <input
            type="password"
            id="confirmPassword"
            v-model="formData.confirmPassword"
            placeholder="Confirm your password"
            required
          />
        </div>

        <button type="submit">Sign Up</button>
      </form>

      <p>Already have an account? <router-link to="/login">Login</router-link></p>
    </div>
  </template>
  
<script setup>
import axios from 'axios';
import {reactive} from 'vue';

const formData = reactive ({
  firstName: '',
  lastName: '',
  email: '',
  phone: '',
  address: '',
  password: '',
  confirmPassword: '',
});
        
const signup = async () => {
    console.log(formData)
    if (!formData.firstName || !formData.lastName || !formData.email ||  !formData.phone || !formData.address || !formData.password || !formData.confirmPassword) {
      alert('Please fill in all fields');
      return;
    }
    if (formData.password !== formData.confirmPassword) {
      alert('Passwords do not match');
      return;
    }
    
    //console.log('Signing up with:', formData.firstName, formData.lastName, formData.email, formData.phone, formData.address, formData.password);
    const response = await axios.post('http://localhost:3000/api/user/sign_up', formData);
    console.log(response)
    
}
</script>
  
<style scoped>
  .signup-page {
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