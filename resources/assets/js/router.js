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
import profit from './components/profit/profit.vue'
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
					allowed: onlyAdmin
				}
				
				
			},
			

	    {
	      path: '/',
	      name: 'home',
				component: home,
				meta: {
					allowed: onlyAdmin
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
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/category',
	      name: 'category',
				component: category,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/unit',
	      name: 'unit',
				component: unit,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/product',
	      name: 'product',
				component: product,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/supplier',
	      name: 'supplier',
				component: supplier,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/customer',
	      name: 'customer',
				component: customer,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/zone',
	      name: 'zone',
				component: zone,
				meta: {
					allowed: onlyAdmin
				}

	    },
    	{
	      path: '/voucher',
	      name: 'voucher',
	      component: voucher,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/ledgerhead',
	      name: 'ledgerhead',
	      component: ledgerhead,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/purchase',
	      name: 'purchase',
	      component: purchase,
				meta: {
					allowed: onlyAdmin
				}
			},
    	{
	      path: '/stock',
	      name: 'stock',
	      component: stock,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/sale',
	      name: 'sell',
	      component: sell,
				meta: {
					allowed: onlyAdmin
				}
	    },
    	{
	      path: '/payment',
	      name: 'paytosupplier',
	      component: paytosupplier,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/collection',
	      name: 'collection',
	      component: collection,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/returnproduct',
	      name: 'returnproduct',
	      component: returnproduct,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/order',
	      name: 'order',
	      component: order,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/selllist',
	      name: 'selllist',
	      component: selllist,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/itemselling',
	      name: 'itemselling',
	      component: itemselling,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/purchaselist',
	      name: 'purchaselist',
	      component: purchaselist,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/purchaseitemlist',
	      name: 'purchaseitemlist',
	      component: purchaseitemlist,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/profit',
	      name: 'profit',
	      component: profit,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/paymentlist',
	      name: 'paymentlist',
	      component: paymentlist,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/cash',
	      name: 'cash',
	      component: cash,
				meta: {
					allowed: onlyAdmin
				}
	    },
			{
	      path: '/customerledger',
	      name: 'customerledger',
	      component: customerledger,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/supplierledger',
	      name: 'supplierledger',
	      component: supplierledger,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/customeroutstanding',
	      name: 'customeroutstanding',
	      component: customeroutstanding,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/supplieroutstanding',
	      name: 'supplieroutstanding',
	      component: supplieroutstanding,
				meta: {
					allowed: onlyAdmin
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
					allowed: onlyAdmin
				}
			},
			{
	      path: '/salecancel',
	      name: 'salecancel',
	      component: salecancel,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/collectioncancel',
	      name: 'collectioncancel',
	      component: collectioncancel,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/paymentcancel',
	      name: 'paymentcancel',
	      component: paymentcancel,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/collectionreport',
	      name: 'collectionreport',
	      component: collectionreport,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/paymentreport',
	      name: 'paymentreport',
	      component: paymentreport,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/currentstock',
	      name: 'currentstock',
	      component: currentstock,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/membershiplist',
	      name: 'membershiplist',
	      component: membershiplist,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/bonusledger',
	      name: 'bonusledger',
	      component: bonusledger,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/usersetting',
	      name: 'usersetting',
	      component: usersetting,
				meta: {
					allowed: onlyAdmin
				}
			},
			{
	      path: '/discountreport',
	      name: 'discountreport',
	      component: discountreport,
				meta: {
					allowed: onlyAdmin
				}
			},
			

			
						
		]
})