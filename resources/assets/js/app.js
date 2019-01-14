
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');
import Vue from 'vue'
import store from './store'
import iView from 'iview';
import locale from 'iview/dist/locale/en-US';
import 'iview/dist/styles/iview.css';
// import VueBarcode from 'vue-barcode';
import VueBarcode from '@xkeshi/vue-barcode';
import Bars from 'vuebars'
import Chart from 'chart.js';
import VueGoogleCharts from 'vue-google-charts'

Vue.use(VueGoogleCharts)
Vue.use(Bars)
Vue.use(iView, { locale });
//barcode source https://github.com/xkeshi/vue-barcode
// npm install chart.js --save
/*import lodash*/
window._ = require('lodash');
require('es6-promise').polyfill();
require('es6-object-assign').polyfill();
 Vue.component(VueBarcode.name, VueBarcode);

// common methods 


/*custom common methods*/
import common from './common';
Vue.mixin(common);

let userType = window.authUser.userType


router.beforeEach((to, from, next) => {
   
    if(to.meta){
        let allowed = to.meta.allowed
        
        for(let a of allowed){
            if(a==userType){
                next();
            }
        }
    }
    return
    
  
  });


Vue.component('mainapp', require('./components/mainapp.vue'));
Vue.component('printapp', require('./components/printapp.vue'));
import router from './router'
const app = new Vue({
    el: '#app',
    router,
   store: store,
});

