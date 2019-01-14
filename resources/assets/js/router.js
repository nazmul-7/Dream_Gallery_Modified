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
import collection from './components/payment/cashcollection.vue'
import returnproduct from './components/return/returnproduct.vue'
import order from './components/order/order.vue'
//reports
import selllist from './components/sell/selllist.vue'
import itemselling from './components/sell/itemselling.vue'
import purchaselist from './components/purchase/purchaselist.vue'
import purchaseitemlist from './components/purchase/purchaseitemlist.vue'
import grossprofit from './components/profit/grossprofit.vue'
import netprofit from './components/profit/netprofit.vue'
import paymentlist from './components/payment/paymentlist.vue'
import cash from './components/cash/cash.vue'
import customerledger from './components/ledgers/customer.vue'
import supplierledger from './components/ledgers/supplier.vue'
import customeroutstanding from './components/due/customeroutstanding.vue'
import supplieroutstanding from './components/due/supplieroutstanding.vue'
import newuser from './components/admin/newuser.vue'
import usersetting from './components/admin/usersetting.vue'
import collectionreport from './components/reports/collectionreport.vue'
import paymentreport from './components/reports/paymentreport.vue'
import discountreport from './components/discount/discountreport.vue'
//cancel
import purchasecancel from './components/cancel/purchasecancel.vue'
import salecancel from './components/cancel/salecancel.vue'
import collectioncancel from './components/cancel/collectioncancel.vue'
import paymentcancel from './components/cancel/paymentcancel.vue'
import currentstock from './components/stock/currentstock.vue'
import membershiplist from './components/membership/membershiplist.vue'
import bonusledger from './components/membership/bonusledger.vue'

let onlyAdmin = ['Admin']
let adminAndEditor = ['Admin','Editor']
let adminAndSale = ['Admin', 'Sale']
Vue.use(Router)
export default new Router({
	  mode: 'history',
	  routes: 
	  [
	    {
	      path: '/login',
	      name: 'login',
				component: login,
				meta: {
					allowed: adminAndEditor
				}
				
				
			},
			

	    {
	      path: '/',
	      name: 'home',
				component: home,
				meta: {
					allowed: adminAndEditor
				}
				

	    },
	    {
	      path: '/setting',
	      name: 'setting',
				component: setting,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/group',
	      name: 'group',
				component: group,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/category',
	      name: 'category',
				component: category,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/unit',
	      name: 'unit',
				component: unit,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/product',
	      name: 'product',
				component: product,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/supplier',
	      name: 'supplier',
				component: supplier,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/customer',
	      name: 'customer',
				component: customer,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/zone',
	      name: 'zone',
				component: zone,
				meta: {
					allowed: adminAndEditor
				}

	    },
    	{
	      path: '/voucher',
	      name: 'voucher',
	      component: voucher,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/ledgerhead',
	      name: 'ledgerhead',
	      component: ledgerhead,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/purchase',
	      name: 'purchase',
	      component: purchase,
				meta: {
					allowed: adminAndEditor
				}
			},
    	{
	      path: '/stock',
	      name: 'stock',
	      component: stock,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/sale',
	      name: 'sell',
	      component: sell,
				meta: {
					allowed: adminAndEditor
				}
	    },
    	{
	      path: '/payment',
	      name: 'paytosupplier',
	      component: paytosupplier,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/collection',
	      name: 'collection',
	      component: collection,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/returnproduct',
	      name: 'returnproduct',
	      component: returnproduct,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/order',
	      name: 'order',
	      component: order,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/selllist',
	      name: 'selllist',
	      component: selllist,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/itemselling',
	      name: 'itemselling',
	      component: itemselling,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/purchaselist',
	      name: 'purchaselist',
	      component: purchaselist,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/purchaseitemlist',
	      name: 'purchaseitemlist',
	      component: purchaseitemlist,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/grossprofit',
	      name: 'grossprofit',
	      component: grossprofit,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/netprofit',
	      name: 'netprofit',
	      component: netprofit,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/paymentlist',
	      name: 'paymentlist',
	      component: paymentlist,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/cash',
	      name: 'cash',
	      component: cash,
				meta: {
					allowed: adminAndEditor
				}
	    },
			{
	      path: '/customerledger',
	      name: 'customerledger',
	      component: customerledger,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/supplierledger',
	      name: 'supplierledger',
	      component: supplierledger,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/customeroutstanding',
	      name: 'customeroutstanding',
	      component: customeroutstanding,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/supplieroutstanding',
	      name: 'supplieroutstanding',
	      component: supplieroutstanding,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/newuser',
	      name: 'newuser',
	      component: newuser,
				meta: {
					allowed: onlyAdmin
				}
			},
			//cancle
			{
	      path: '/purchasecancel',
	      name: 'purchasecancel',
	      component: purchasecancel,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/salecancel',
	      name: 'salecancel',
	      component: salecancel,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/collectioncancel',
	      name: 'collectioncancel',
	      component: collectioncancel,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/paymentcancel',
	      name: 'paymentcancel',
	      component: paymentcancel,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/collectionreport',
	      name: 'collectionreport',
	      component: collectionreport,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/paymentreport',
	      name: 'paymentreport',
	      component: paymentreport,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/currentstock',
	      name: 'currentstock',
	      component: currentstock,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/membershiplist',
	      name: 'membershiplist',
	      component: membershiplist,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/bonusledger',
	      name: 'bonusledger',
	      component: bonusledger,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/usersetting',
	      name: 'usersetting',
	      component: usersetting,
				meta: {
					allowed: adminAndEditor
				}
			},
			{
	      path: '/discountreport',
	      name: 'discountreport',
	      component: discountreport,
				meta: {
					allowed: adminAndEditor
				}
			},
			

			
						
		]
})