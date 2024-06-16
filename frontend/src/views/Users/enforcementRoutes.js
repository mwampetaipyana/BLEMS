import LawEnforcementLayoutView from "@/views/Users/Layout.vue";
//import EvidenceView from "./Evidence/Evidence.vue";
import CasesView from "./Cases/Cases.vue";
import DashboardView from "./Dashboard.vue";
import NotificationsView from "./Notifications.vue";
import UsersView from "@/views/Admin/Users/Users.vue"

export default [
    {
        path:'/user',
        name:'User',
        component:LawEnforcementLayoutView,
        meta: { requiresMetaMask: true },
        children:[
            {
                path:'',
                name:'Dashboard',
                component:DashboardView,
            },
            {
                path:'/cases',
                name:'Cases',
                component:CasesView,
            },
            {
                path:'/registered_users',
                name:'Registered Users',
                component: UsersView
            },
            {
                path:'/notifications',
                name:'Case Activity',
                component:NotificationsView,
            }
        ]
    }
]
