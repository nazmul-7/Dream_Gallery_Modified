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
import sell from './components/sell/sell.vue'
import supplier from './components/supplier/supplier.vue'
import zone from './components/customer/zone.vue'
import customer from './components/customer/customer.vue'
import voucher from './components/voucher/voucher.vue'
import ledgerhead from './components/voucher/ledgerhead.vue'
import stock from './components/stock/stock.vue'
import paytosupplier from './components/payment/paytosupplier.vue'
import cashcollection from './components/payment/cashcollection.vue'
import returnproduct from './components/return/returnproduct.vue'
import order from './components/order/order.vue'
//reports
import selllist from './components/sell/selllist.vue'
import itemselling from './components/sell/itemselling.vue'
import purchaselist from './components/purchase/purchaselist.vue'
import purchaseitemlist from './components/purchase/purchaseitemlist.vue'
import profit from './components/profit/profit.vue'
import paymentlist from './components/payment/paymentlist.vue'
import cash from './components/cash/cash.vue'
import customerledger from './components/ledgers/customer.vue'
import supplierledger from './components/ledgers/supplier.vue'

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
    	{
	      path: '/stock',
	      name: 'stock',
	      component: stock
			},
			{
	      path: '/sell',
	      name: 'sell',
	      component: sell
	    },
    	{
	      path: '/paytosupplier',
	      name: 'paytosupplier',
	      component: paytosupplier
			},
			{
	      path: '/cashcollection',
	      name: 'cashcollection',
	      component: cashcollection
			},
			{
	      path: '/returnproduct',
	      name: 'returnproduct',
	      component: returnproduct
			},
			{
	      path: '/order',
	      name: 'order',
	      component: order
			},
			{
	      path: '/selllist',
	      name: 'selllist',
	      component: selllist
			},
			{
	      path: '/itemselling',
	      name: 'itemselling',
	      component: itemselling
			},
			{
	      path: '/purchaselist',
	      name: 'purchaselist',
	      component: purchaselist
			},
			{
	      path: '/purchaseitemlist',
	      name: 'purchaseitemlist',
	      component: purchaseitemlist
			},
			{
	      path: '/profit',
	      name: 'profit',
	      component: profit
			},
			{
	      path: '/paymentlist',
	      name: 'paymentlist',
	      component: paymentlist
			},
			{
	      path: '/cash',
	      name: 'cash',
	      component: cash
	    },
			{
	      path: '/customerledger',
	      name: 'customerledger',
	      component: customerledger
			},
			{
	      path: '/supplierledger',
	      name: 'supplierledger',
	      component: supplierledger
	    },
		]
})