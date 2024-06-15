import LawEnforcementLayoutView from "@/views/Users/Layout.vue";
//import EvidenceView from "./Evidence/Evidence.vue";
import CasesView from "./Cases/Cases.vue";
import DashboardView from "./Dashboard.vue";
import NotificationsView from "./Notifications.vue";

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
                path:'/notifications',
                name:'Case Activity',
                component:NotificationsView,
            }
        ]
    }
]
