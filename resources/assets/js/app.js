
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */
/*importing vuex*/
import store from './store'
import iView from 'iview';
import 'iview/dist/styles/iview.css';
import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css' 
import 'material-design-icons-iconfont/dist/material-design-icons.css'

/*import lodash*/
window._ = require('lodash');
require('es6-promise').polyfill();
require('es6-object-assign').polyfill();
Vue.use(iView);
Vue.use(Vuetify)

Vue.component('mainapp', require('./components/mainapp.vue'));
import router from './router'
const app = new Vue({
    el: '#app',
    router,
   store: store,
});

