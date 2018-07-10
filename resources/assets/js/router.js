import Vue from 'vue'
import Router from 'vue-router'
import login from './components/login.vue'
import home from './components/home.vue'
import setting from './components/setting/setting.vue'
import group from './components/group/group.vue'
import category from './components/category/category.vue'
import unit from './components/unit/unit.vue'
import product from './components/product/product.vue'
import purchase from './components/product/purchase.vue'
import supplier from './components/supplier/supplier.vue'
import zone from './components/customer/zone.vue'
import customer from './components/customer/customer.vue'
import voucher from './components/voucher/voucher.vue'
import ledgerhead from './components/voucher/ledgerhead.vue'

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
    	{
	      path: '/category',
	      name: 'category',
	      component: category
	    },
    	{
	      path: '/unit',
	      name: 'unit',
	      component: unit
	    },
    	{
	      path: '/product',
	      name: 'product',
	      component: product
	    },
    	{
	      path: '/supplier',
	      name: 'supplier',
	      component: supplier
	    },
    	{
	      path: '/customer',
	      name: 'customer',
	      component: customer
	    },
    	{
	      path: '/zone',
	      name: 'zone',
	      component: zone
	    },
    	{
	      path: '/voucher',
	      name: 'voucher',
	      component: voucher
	    },
    	{
	      path: '/ledgerhead',
	      name: 'ledgerhead',
	      component: ledgerhead
	    },
    	{
	      path: '/purchase',
	      name: 'purchase',
	      component: purchase
	    },
	 ]
})