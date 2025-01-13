import Vue from 'vue'
import VueRouter from 'vue-router'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-icons/font/bootstrap-icons.css'

Vue.use(VueRouter)

import HomeComponent from './components/HomeComponent.vue'
import CommutationComponent from './components/CommutationComponent.vue'
import PacketComponent from './components/PacketComponent.vue'
import ContactComponent from './components/ContactComponent.vue'

const routes = [
  { path: '/', component: HomeComponent },
  { path: '/commutationComponent', component: CommutationComponent },
  { path: '/packetComponent', component: PacketComponent },
  { path: '/contactComponent', component: ContactComponent }
]

const router = new VueRouter({
  routes,
  mode: 'history'
})

new Vue({
  router
}).$mount('#app')
