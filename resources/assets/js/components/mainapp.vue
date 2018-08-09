
<template>

 <div class="layout">
        <Layout>
            <Sider ref="side1" hide-trigger collapsible :collapsed-width="78" v-model="isCollapsed">
                <Menu active-name="1-2" theme="dark" width="auto" :class="menuitemClasses" @on-select="goToLink">
                    <MenuItem name="setting" :to="handleGoToMenu('/setting')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Setting</span>              
                    </MenuItem>
                    
                    <MenuItem name="group" :to="handleGoToMenu('/group')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Group</span>              
                    </MenuItem>

                    <MenuItem name="category" :to="handleGoToMenu('/category')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Category</span>              
                    </MenuItem>
                    <MenuItem name="unit" :to="handleGoToMenu('/unit')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Unit Type</span>              
                    </MenuItem>
                    <MenuItem name="product" :to="handleGoToMenu('/product')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Product</span>              
                    </MenuItem>
                    <MenuItem name="supplier" :to="handleGoToMenu('/supplier')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>supplier</span>              
                    </MenuItem>
                    <MenuItem name="customer" :to="handleGoToMenu('/customer')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>customer</span>              
                    </MenuItem>
                    <MenuItem name="zone" :to="handleGoToMenu('/zone')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>area zone</span>              
                    </MenuItem>
                    <MenuItem name="voucher" :to="handleGoToMenu('/voucher')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>voucher</span>              
                    </MenuItem>
                    <MenuItem name="ledgerhead" :to="handleGoToMenu('/ledgerhead')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>ledgerhead</span>              
                    </MenuItem>
                    <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>purchase</span>              
                    </MenuItem>
                    <MenuItem name="stock" :to="handleGoToMenu('/stock')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>stock</span>              
                    </MenuItem>
                    <MenuItem name="sell" :to="handleGoToMenu('/sell')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>sell</span>              
                    </MenuItem>
                    <MenuItem name="paytosupplier" :to="handleGoToMenu('/paytosupplier')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>paytosupplier</span>              
                    </MenuItem>
                    <MenuItem name="cashcollection" :to="handleGoToMenu('/cashcollection')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>cashcollection</span>              
                    </MenuItem>
                    <MenuItem name="returnproduct" :to="handleGoToMenu('/returnproduct')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>returnproduct</span>              
                    </MenuItem>
                    <MenuItem name="selllist" :to="handleGoToMenu('/selllist')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>selllist</span>              
                    </MenuItem>
                    <MenuItem name="itemselling" :to="handleGoToMenu('/itemselling')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>itemselling</span>              
                    </MenuItem>
                    <MenuItem name="profit" :to="handleGoToMenu('/profit')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>profit</span>              
                    </MenuItem>
                    <MenuItem name="paymentlist" :to="handleGoToMenu('/paymentlist')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>paymentlist</span>              
                    </MenuItem>
                    <MenuItem name="cash" :to="handleGoToMenu('/cash')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>cash</span>              
                    </MenuItem>
                    <MenuItem name="login" :to="handleGoToMenu('/login')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>login</span>              
                    </MenuItem>
                </Menu>
            </Sider>
            <Layout>
                <Header :style="{padding: 0}" class="layout-header-bar">
                    <Icon @click.native="collapsedSider" :class="rotateIcon" :style="{margin: '20px 20px 0'}" type="navicon-round" size="24"></Icon>
                    <p class="title-sett">DreamGallery</p>
                </Header>
                <Content :style="{minHeight: '220px'}">
                    <div class="dream-input">
                        <transition name="component-fade" mode="out-in">
							<router-view></router-view>
						</transition>	
                    </div>
                </Content>
            </Layout>
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
</style>
