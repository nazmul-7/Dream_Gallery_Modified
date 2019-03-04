import Vue from 'vue'

import Vuex from 'vuex'
Vue.use(Vuex)
const store = new Vuex.Store({
  state: {
    counter:100,
    authUser: window.authUser,
    load:false,
    notifications:[],
    headerName:'DreamGallery',
  },

  /*All getters*/
  getters: {
    getCounter(state){
      return state.counter
    },
    getHeader(state){
      return state.headerName
    },
    isLoggedIn(state){
      if(_.isEmpty(state.authUser)){
        return false
      }else{
        return true
      }
      
    },
    loggedInUser(state){
      return state.authUser
    },
    load(state){
      return state.load
    },
    noti(state){
      return state.notifications
    },
  },

  /*all mutations*/
  mutations: {
    update (state,data) {
       state.counter++
    },
    user(state,user){
      state.authUser=user
    },
    updateHeader(state,data){
      state.headerName=data
    },
   
  },

 /*all actions*/
  actions: {
    update ({commit},data) {
     commit('update',data)
    },
    user({commit},user){
      commit('user',user)
    },
    updateHeader({commit},data){
      commit('updateHeader',data)
    },
  }
})

export default store