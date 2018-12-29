
<template>

 <div class="layout">
        <Layout>
            <router-view></router-view>
        </Layout>
    </div>


</template>

<script>
	import { mapGetters } from 'vuex'


	export default {
		data(){
			return {
				isCollapsed:false
			}
		},
		computed: {
			...mapGetters([
				
			]),
			rotateIcon () {
                return [
                    'menu-icon',
                    this.isCollapsed ? 'rotate-icon' : ''
                ];
            },
            menuitemClasses () {
                return [
                    'menu-item',
                    this.isCollapsed ? 'collapsed-menu' : ''
                ]
            }
		},
		methods: {
			collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            goToLink(url){
               console.log('okk')
                this.$router.push(url)
            },
            handleGoToMenu(d){
                return d
            }
		}

		

		
	}
</script>

<style>
    .layout{
        border: 1px solid #d7dde4;
        background: #f5f7f9;
        position: relative;
        border-radius: 4px;
        overflow: hidden;
    }
    .layout-header-bar{
        background: #fff;
        box-shadow: 0 1px 1px rgba(0,0,0,.1);
    }
    .layout-logo-left{
        width: 90%;
        height: 30px;
        background: #5b6270;
        border-radius: 3px;
        margin: 15px auto;
    }
    .menu-icon{
        transition: all .3s;
    }
    .rotate-icon{
        transform: rotate(-90deg);
    }
    .menu-item span{
        display: inline-block;
        overflow: hidden;
        width: 69px;
        text-overflow: ellipsis;
        white-space: nowrap;
        vertical-align: bottom;
        transition: width .2s ease .2s;
    }
    .menu-item i{
        transform: translateX(0px);
        transition: font-size .2s ease, transform .2s ease;
        vertical-align: middle;
        font-size: 16px;
    }
    .collapsed-menu span{
        width: 0px;
        transition: width .2s ease;
    }
    .collapsed-menu i{
        transform: translateX(5px);
        transition: font-size .2s ease .2s, transform .2s ease .2s;
        vertical-align: middle;
        font-size: 22px;
    }

        @media print {
    body * {
        
        visibility: hidden;
    }
    .print, .print * {
        visibility: visible;
    }
    .print {
        position: absolute;
        left: 0;
        top: 0;
    }
    }
    .hidden {
display: none;
}
</style>
