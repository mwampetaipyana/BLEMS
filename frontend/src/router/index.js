import LandingView from "@/views/Landing.vue";
import AdminLayoutView from "@/views/Admin/Layout.vue"
import {createRouter, createWebHistory} from "vue-router"
import lawEnforcementRoutes from "@/views/Law_enforcement/enforcementRoutes"
import adminRoutes from "@/views/Admin/adminRoutes.js"
const routes = [  
    {
        path:'/',
        name:'landing',
        component:LandingView
    },

    ...lawEnforcementRoutes,
    ...adminRoutes
];

const router=createRouter({
    history:createWebHistory(), 
    routes
})

export default router