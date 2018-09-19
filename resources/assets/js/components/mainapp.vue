
<template>

 <div class="layout">
        <Layout>
            <Sider width="250" ref="side1" hide-trigger collapsible :collapsed-width="78" v-model="isCollapsed">
                <Menu  theme="dark" width="auto" :class="menuitemClasses" @on-select="goToLink">
                    <!-- menu -->
                    <Submenu name="1">
                        <template slot="title">
                            <Icon type="ios-navigate"></Icon>
                           Setup
                        </template>
                        <MenuItem name="1-1">                        
                            <Submenu name="1-1-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Setting
                                </template>
                                <MenuItem name="setting" :to="handleGoToMenu('/setting')">Store Setting</MenuItem>
                                <MenuItem name="unit" :to="handleGoToMenu('/unit')">Unit Type</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="1-2">                        
                            <Submenu name="1-2-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Product
                                </template>
                                <MenuItem name="product" :to="handleGoToMenu('/product')">Products</MenuItem>
                                <MenuItem name="group" :to="handleGoToMenu('/group')">Group</MenuItem>
                                <MenuItem name="category" :to="handleGoToMenu('/category')">Category</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <!-- <MenuItem name="1-3">                        
                            <Submenu name="1-3-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Account
                                </template>
                                <MenuItem name="setting" :to="handleGoToMenu('/setting')">Accounts</MenuItem>
                            </Submenu>
                        </MenuItem> -->
                        <MenuItem name="1-4">                        
                            <Submenu name="1-4-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Others
                                </template>
                                <MenuItem name="customer" :to="handleGoToMenu('/customer')">Customer</MenuItem>
                                <MenuItem name="supplier" :to="handleGoToMenu('/supplier')">Supplier</MenuItem>
                                <MenuItem name="zone" :to="handleGoToMenu('/zone')">Zone</MenuItem>
                            </Submenu>
                        </MenuItem>
                    </Submenu>
                    <!-- menu -->
                    <Submenu name="2">
                        <template slot="title">
                            <Icon type="ios-navigate"></Icon>
                           Task
                        </template>
                        <MenuItem name="sell" :to="handleGoToMenu('/sell')">
                            <Icon type="ios-info"></Icon>
                            <span>Sale</span>              
                        </MenuItem>
                        <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">
                            <Icon type="ios-info"></Icon>
                            <span>Purchas</span>              
                        </MenuItem>
                        <MenuItem name="returnproduct" :to="handleGoToMenu('/returnproduct')">
                            <Icon type="ios-info"></Icon>
                            <span>Return</span>              
                        </MenuItem>

                        <!-- <MenuItem name="2-1">                        
                            <Submenu name="2-1-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Purchase
                                </template>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">Product Purchase</MenuItem>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">Purchase List</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="2-2">                        
                            <Submenu name="2-2-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Sale
                                </template>
                                <MenuItem name="sell" :to="handleGoToMenu('/sell')">Product Sales</MenuItem>
                                <MenuItem name="sell" :to="handleGoToMenu('/sell')">Sales List</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="2-3">                        
                            <Submenu name="2-3-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Return
                                </template>
                                <MenuItem name="return" :to="handleGoToMenu('/return')">Sales Return</MenuItem>
                            </Submenu>
                        </MenuItem> -->
                        <MenuItem name="2-4">                        
                            <Submenu name="2-4-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Collection
                                </template>
                                <MenuItem name="cashcollection" :to="handleGoToMenu('/cashcollection')">Add Collection</MenuItem>
                                <MenuItem name="cashcollection" :to="handleGoToMenu('/cashcollection')">Collection List</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="2-5">                        
                            <Submenu name="2-5-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Payment
                                </template>
                                <MenuItem name="paytosupplier" :to="handleGoToMenu('/paytosupplier')">Add Payment</MenuItem>
                                <MenuItem name="paytosupplier" :to="handleGoToMenu('/paytosupplier')">Payment List</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="2-6">                        
                            <Submenu name="2-6-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Stock
                                </template>
                                <MenuItem name="stock" :to="handleGoToMenu('/stock')">Stock List</MenuItem>
                                <MenuItem name="stock" :to="handleGoToMenu('/stock')">Stock Adjustment</MenuItem>
                                <MenuItem name="stock" :to="handleGoToMenu('/stock')">Damage Products</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="2-7">                        
                            <Submenu name="2-7-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Voucher
                                </template>
                                <MenuItem name="voucher" :to="handleGoToMenu('/voucher')">Voucher Posting</MenuItem>
                                <MenuItem name="ledgerhead" :to="handleGoToMenu('/voucher')">Ledger Haed</MenuItem>
                                <MenuItem name="voucher" :to="handleGoToMenu('/voucher')">Voucher Lists</MenuItem>
                            </Submenu>
                        </MenuItem>                    
                    </Submenu>
                    <!-- menu -->
                    <Submenu name="3">
                        <template slot="title">
                            <Icon type="ios-navigate"></Icon>
                           Reports
                        </template>
                        <MenuItem name="3-1">                        
                            <Submenu name="3-1-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Sales
                                </template>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">Item Wise Sales</MenuItem>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">Invoice Wise Sales</MenuItem>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">Customer Wise Sales</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="3-2">                        
                            <Submenu name="3-2-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Profit
                                </template>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">Item Wise Profit</MenuItem>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">Overall Profit</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="3-3">                        
                            <Submenu name="3-3-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Account
                                </template>
                                <MenuItem name="cash" :to="handleGoToMenu('/cash')">Cash Report</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="3-4">                        
                            <Submenu name="3-4-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Ledger
                                </template>
                                <MenuItem name="cash" :to="handleGoToMenu('/cash')">Supplier</MenuItem>
                                <MenuItem name="cash" :to="handleGoToMenu('/cash')">Customer</MenuItem>
                            </Submenu>
                        </MenuItem>
                    </Submenu>
                    <!-- menu -->
                    <Submenu name="4">
                        <template slot="title">
                            <Icon type="ios-navigate"></Icon>
                           Security
                        </template>
                        <MenuItem name="user" :to="handleGoToMenu('/user')">
                            <Icon type="ios-info"></Icon>
                            <span>New User</span>              
                        </MenuItem>

                        <MenuItem name="4-1">                        
                            <Submenu name="4-1-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Manage User
                                </template>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">User Lists</MenuItem>
                                <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">Chage Password</MenuItem>
                            </Submenu>
                        </MenuItem>
                    </Submenu>                                          
                    <!-- <MenuItem name="setting" :to="handleGoToMenu('/setting')">
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
                        <span>Supplier</span>              
                    </MenuItem>
                    <MenuItem name="customer" :to="handleGoToMenu('/customer')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Customer</span>              
                    </MenuItem>
                    <MenuItem name="zone" :to="handleGoToMenu('/zone')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Zone</span>              
                    </MenuItem>
                    <MenuItem name="voucher" :to="handleGoToMenu('/voucher')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Voucher</span>              
                    </MenuItem>
                    <MenuItem name="ledgerhead" :to="handleGoToMenu('/ledgerhead')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Ledgerhead</span>              
                    </MenuItem>
                    <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Purchase</span>              
                    </MenuItem>
                    <MenuItem name="stock" :to="handleGoToMenu('/stock')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Stock</span>              
                    </MenuItem>
                    <MenuItem name="sell" :to="handleGoToMenu('/sell')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Sell</span>              
                    </MenuItem>
                    <MenuItem name="paytosupplier" :to="handleGoToMenu('/paytosupplier')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Pay to supplier</span>              
                    </MenuItem>
                    <MenuItem name="cashcollection" :to="handleGoToMenu('/cashcollection')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Cash Collection</span>              
                    </MenuItem>
                    <MenuItem name="returnproduct" :to="handleGoToMenu('/returnproduct')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Return Product</span>              
                    </MenuItem>
                    <MenuItem name="selllist" :to="handleGoToMenu('/selllist')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Sell list</span>              
                    </MenuItem>
                    <MenuItem name="itemselling" :to="handleGoToMenu('/itemselling')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Item Selling List</span>              
                    </MenuItem>
                    <MenuItem name="profit" :to="handleGoToMenu('/profit')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Profit</span>              
                    </MenuItem>
                    <MenuItem name="paymentlist" :to="handleGoToMenu('/paymentlist')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Payment List</span>              
                    </MenuItem>
                    <MenuItem name="cash" :to="handleGoToMenu('/cash')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>Cash</span>              
                    </MenuItem>
                    <!-- <MenuItem name="login" :to="handleGoToMenu('/login')">
                        <Icon type="ios-navigate" ></Icon>
                        <span>login</span>              
                    </MenuItem> -->
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
