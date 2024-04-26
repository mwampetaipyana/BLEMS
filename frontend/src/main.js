import './assets/main.css'

// Vuetify
import 'vuetify/styles'
import "@mdi/font/css/materialdesignicons.css";
import "@fortawesome/fontawesome-free/css/all.css";


import vuetify from '../vuetify.config.js'
import { MotionPlugin } from '@vueuse/motion'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'


const app = createApp(App)

app.use(router)
app.use(vuetify)
app.use(MotionPlugin)
app.mount('#app')
