import LandingView from "@/views/Landing.vue";
import AdminLayoutView from "@/views/Admin/Layout.vue"
import {createRouter, createWebHistory} from "vue-router"
import lawEnforcementRoutes from "@/views/Law_enforcement/enforcementRoutes"

const routes = [  
    {
        path:'/',
        name:'landing',
        component:LandingView
    },

    {
        path:'/adm',
        name:'admin',
        component:AdminLayoutView
    },
    ...lawEnforcementRoutes
    
];

const router=createRouter({
    history:createWebHistory(), 
    routes
})

export default router