import Vue from 'vue'
import Router from 'vue-router'
import Profile from '@/components/Profile'
import Home from '@/components/Home'
import Bank from '@/components/Bank'
import CreateGuess from '@/components/HomeComponents/CreateGuess'
import GuessesTypes from '@/components/HomeComponents/GuessesTypes'

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
      path: '/bank',
      name: 'bank',
      component: Bank
    },
    // Home View Components
    {
      path: '/create',
      name: 'create',
      component: CreateGuess
    },
    {
      path: '/types',
      name: 'types',
      component: GuessesTypes
    }
  ]
})
