<style scoped>
    .layout{
        background: #f5f7f9;
    }
    .layout-footer-center{
        text-align: center;
    }
</style>
<template>
	<div class="layout">
	<v-app id="inspire">
		<v-progress-linear 
		:indeterminate="true"
		 height="5"
		 v-show="load"
		class="p"></v-progress-linear>
	</v-app>
        <Layout>

				<normalmenu v-if="!isLoggedIn"/>
				<loginmenu v-if="isLoggedIn"/>
				<Content :style="{margin: '30px 0px 0', padding: '10px', background: '#fff', minHeight: '500px'}">
					<transition name="component-fade" mode="out-in">
						<router-view></router-view>
					</transition>
				</Content>
		

	<Footer class="layout-footer-center">Footer</Footer>
        </Layout>
    </div>

</template>

<script>
	import { mapGetters } from 'vuex'

	import loginmenu from './menu.vue'
	import normalmenu from './normalmenu.vue'
	export default {
		data(){
			return {

			}
		},
		computed: {
			...mapGetters([
				'isLoggedIn',
				'load',
			])
		},

		components: {
			loginmenu,
			normalmenu
		},
		

		
	}
</script>



<style>

.component-fade-enter-active, .component-fade-leave-active {
  transition: opacity .5s ease;
}
.component-fade-enter, .component-fade-leave-to
/* .component-fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}
.progress-linear {
    
    position: absolute;
    top: -15px;
   
}
</style>