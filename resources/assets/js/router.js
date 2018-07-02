import Vue from 'vue'
import Router from 'vue-router'
import login from './components/login.vue'
import home from './components/home.vue'
import setting from './components/setting/setting.vue'
import group from './components/group/group.vue'

Vue.use(Router)
export default new Router({
	  mode: 'history',
	  routes: 
	  [
	    {
	      path: '/login',
	      name: 'login',
	      component: login
	    },
	    {
	      path: '/',
	      name: 'home',
	      component: home
	    },
	    {
	      path: '/setting',
	      name: 'setting',
	      component: setting
	    },
    	{
	      path: '/group',
	      name: 'group',
	      component: group
	    },
	 ]
})