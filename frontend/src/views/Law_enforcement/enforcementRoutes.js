import LawEnforcementLayoutView from "@/views/Law_enforcement/Layout.vue";
import EvidenceView from "./Evidence/Evidence.vue";
import CasesView from "./Cases/Cases.vue";
import DashboardView from "./Dashboard.vue";
import NotificationsView from "./Notifications.vue";

export default [
    {
        path:'/law_enforcement',
        name:'lawEnforcement',
        component:LawEnforcementLayoutView,
        children:[
            {
                path:'',
                name:'Dashboard',
                component:DashboardView
            },
            {
                path:'/evidence',
                name:'Evidence',
                component:EvidenceView
            },
            {
                path:'/cases',
                name:'Cases',
                component:CasesView
            },
            {
                path:'/notifications',
                name:'Notifications',
                component:NotificationsView
            }
        ]
    }
]
