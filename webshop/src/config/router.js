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
        path: '/checkout',
        name: 'checkout',
        component: CheckoutPage
    }

];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
