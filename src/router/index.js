import Vue from 'vue'
import Router from 'vue-router'
import Profile from '@/components/Profile'
import Create from '@/components/Create'
import Home from '@/components/Home'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/profile',
      name: 'profile',
      component: Profile
    },
    {
      path: '/create',
      name: 'create',
      component: Create
    }
  ]
})
