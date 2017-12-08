import Vue from 'vue'
import Router from 'vue-router'
import Profile from '@/components/Profile'
import Home from '@/components/Home'
import Bank from '@/components/Bank'
import Event from '@/components/Event'
import CreateEvent from '@/components/EventComponents/CreateEvent'
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
    {
      path: '/event',
      name: 'event',
      component: Event
    },
    // Home View Components
    {
      path: '/create',
      name: 'create',
      component: CreateEvent
    },
    {
      path: '/types',
      name: 'types',
      component: GuessesTypes
    }
  ]
})
