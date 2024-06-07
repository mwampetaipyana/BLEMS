import LandingView from "@/views/Landing.vue";
import AdminLayoutView from "@/views/Admin/Layout.vue"
import {createRouter, createWebHistory} from "vue-router"
import { getState } from "@/utils/contractService.js";
import { notifyError, notifySuccess } from "../utils/notificationService.js";
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

/*
router.beforeEach((to,from, next) => {
    if(to.meta.requiresMetaMask && !getState('signer')){
        next('/');
        notifyError("You are not Connected")
        return;
    }
  
    next()
})*/

export default router