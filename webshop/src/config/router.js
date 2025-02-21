import { createRouter, createWebHistory } from "vue-router";
import HomePage from "../pages/HomePage.vue";
import LoginPage from "../pages/LoginPage.vue";
import SignupPage from "../pages/SignupPage.vue";
import CategoriesList from "../pages/CategoriesList.vue";
import CategoryProducts from "../pages/CategoryProducts.vue";
import ProductPage from "../pages/ProductPage.vue";
import CartPage from "../pages/CartPage.vue";
import CheckoutPage from "@/pages/CheckoutPage.vue";

const routes = [
    { 
        name: 'homepage',
        path: '/', 
        component: HomePage 
    },
    { 
        path: '/login', 
        component: LoginPage 
    },
    { 
        path: '/signup', 
        component: SignupPage 
    },
    { 
        path: '/categories', 
        component: CategoriesList 
    },
    { 
        path: '/category/:id', 
        component: CategoryProducts 
    },
    {   path: '/product/:id', 
        component: ProductPage
    },
    { 
        path: '/cart', 
        name: 'cart',
        component: CartPage 
    },
    {
        path: '/checkout/:price',
        name: 'checkout',
        component: CheckoutPage,
    }, 
    // {
    //     path: '/profile',
    //     name: 'profile',
    //     component:,
    //     meta: { requiresAuth: true, role: 'customer' }
    // }
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

// router.beforeEach(async (to) => {
//     if (to.meta.requiresAuth && !authStore.isAuthenticated) {
//       await authStore.checkAuth(); // Double-check with server
//       if (!authStore.isAuthenticated) return '/login';
//     }
//     return true;
// });

// Global navigation guard
// router.beforeEach((to, from, next) => {
//     Check if the route requires authentication
//     if (to.meta.requiresAuth) {
//         try {
//             Check token expiration if needed
//             if(to.meta.role === decodedToken.user.role) {
//                 console.log("Access granted");
//                 next();
//             } else{
//                 console.log("Access denied");
//                 next({ name: 'home' });
//             }
//         } catch (error) {
//             console.error('Token err:', error);
//             next({ name: 'login' });
//         }
//     }
//     } else {
//         next();
//     }
// });

export default router;
