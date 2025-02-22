import { createRouter, createWebHistory } from "vue-router";
import HomePage from "../pages/HomePage.vue";
import LoginPage from "../pages/LoginPage.vue";
import SignupPage from "../pages/SignupPage.vue";
import CategoriesList from "../pages/CategoriesList.vue";
import CategoryProducts from "../pages/CategoryProducts.vue";
import ProductPage from "../pages/ProductPage.vue";
import CartPage from "../pages/CartPage.vue";
import CheckoutPage from "@/pages/CheckoutPage.vue";
import DashboardPage from "@/pages/AdminPages/DashboardPage.vue";
import checkAuth from '../utils/auth.js';
import ProductsPage from "@/pages/AdminPages/ProductsPage.vue";

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
    {
        path: '/admin/dashboard',
        name: 'admin_dashboard',
        component: DashboardPage,
        meta: { requiresAuth: true, role: 'admin' }
    },
    {
        path: '/admin/products',
        name: 'admin_products',
        component: ProductsPage,
        meta: { requiresAuth: true, role: 'admin' }
    }
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

router.beforeEach(async (to, from, next) => {
    if (to.meta.requiresAuth) {
        const user = await checkAuth(); 
        // // console.log(user)
        // console.log("Page requires user role: " + to.meta.role);
        if(to.meta.role == user.role && user.auth){
            console.log("Access to private page granted.")
            next();
        } else {
            console.log("Access denied");
            next({ name: 'homepage' });
        }
    } else {
        next();
    }
});


export default router;
