import axios from 'axios';

async function checkAuth() {
    try {
		const response = await axios.get('http://localhost:3000/api/user/check', {withCredentials: true});
		//console.log(response)      
		return {auth: response.data.authenticated, role: response.data.role};
    } catch (error) {
		console.error(error);
    }
}

export default checkAuth;