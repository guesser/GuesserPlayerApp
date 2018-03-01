import Vue from 'vue'
import Router from 'vue-router'
import Landing from '@/components/Landing'
import Home from '@/components/Home'
import Create from '@/components/Create'
import Validation from '@/components/Validation'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'landing',
      component: Landing
    },
    {
      path: '/home',
      name: 'home',
      component: Home
    },
    {
      path: '/create',
      name: 'create',
      component: Create
    },
    {
      path: '/validation',
      name: 'validation',
      component: Validation
    }
  ]
})
