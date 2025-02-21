import axios from 'axios';

async function checkAuth(role) {
    try {
      const response = await axios.get('http://localhost:3000/api/user/check', {withCredentials: true});
      console.log(response)      
      if(response.data.authenticated && response.data.role == role) return true;  
      else return false;
    } catch (error) {
      console.error(error);
    }
}

export default checkAuth;