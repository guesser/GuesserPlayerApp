import Vue from 'vue'
import Router from 'vue-router'
import Landing from '@/components/Landing'
import Home from '@/components/Home'
import Create from '@/components/Create'
import Validation from '@/components/Validation'
import Search from '@/components/Search'
import SignUp from '@/components/SignUp'
import MyGuesses from '@/components/MyGuesses'

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
      path: '/home/:topic',
      name: 'home',
      component: Home
    },
    {
      path: '/create',
      name: 'create',
      component: Create
    },
    {
      path: '/signup',
      name: 'signup',
      component: SignUp
    },
    {
      path: '/validation',
      name: 'validation',
      component: Validation
    },
    {
      path: '/search',
      name: 'search',
      component: Search
    },
    {
      path: '/myguesses',
      name: 'myguesses',
      component: MyGuesses
    }
  ]
})
