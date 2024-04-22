import LayoutView from "./Layout.vue"
import UsersView from "./Users/Users.vue"
import DashboardView from "./Dashboard.vue"
import CasesView from "./Cases.vue"
import NotificationsView from "./Logs.vue";

export default [
    {
        path:'/adm',
        name:'Adminlayout',
        component:LayoutView,
        children:[
            {
                path:'',
                name:'Admin Dashboard',
                component: DashboardView
            },
            {
                path:'/users',
                name:'Users',
                component: UsersView
            },
            {
                path:'/allCases',
                name:'All Cases',
                component: CasesView
            },
            {
                path:'/logs',
                name:'Logs',
                component: NotificationsView
            },
        ]
    }
]