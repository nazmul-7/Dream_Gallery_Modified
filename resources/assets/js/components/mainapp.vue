
<template>
 
 <div class="layout">
        <Layout>
            <Sider width="250" ref="side1" hide-trigger collapsible :collapsed-width="78" v-model="isCollapsed">
                <Menu class="_side_menu"  theme="dark" width="auto" accordion :class="menuitemClasses" @on-select="goToLink">
                    <!-- menu -->
                    <MenuItem name="/" :to="handleGoToMenu('/')">Dashboard</MenuItem>
                    <Submenu name="1">
                        <template slot="title">
                           <Icon type="ios-settings" />
                           Setup
                        </template>
                        <MenuItem name="1-1">                        
                            <Submenu name="1-1-1">
                                <template slot="title">
                                    Setting
                                </template>
                                <MenuItem name="setting" :to="handleGoToMenu('/setting')">Store Setting</MenuItem>
                                <MenuItem name="unit" :to="handleGoToMenu('/unit')">Unit Type</MenuItem>
                                <MenuItem name="zone" :to="handleGoToMenu('/zone')">Zone</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="1-2">                        
                            <Submenu name="1-2-1">
                                <template slot="title">
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
                                    Others
                                </template>
                                <MenuItem name="customer" :to="handleGoToMenu('/customer')">Customer</MenuItem>
                                <MenuItem name="supplier" :to="handleGoToMenu('/supplier')">Supplier</MenuItem>
                                <MenuItem name="ledgerhead" :to="handleGoToMenu('/ledgerhead')">Ledger Haed</MenuItem>
                            </Submenu>
                        </MenuItem>
                    </Submenu>
                    <!-- menu -->
                    <Submenu name="2">
                        <template slot="title">
                            <Icon type="ios-navigate"></Icon>
                           Task
                        </template>
                        <MenuItem name="purchase" :to="handleGoToMenu('/purchase')">
                            <Icon type="ios-alert"></Icon>
                            <span>Purchase</span>              
                        </MenuItem>
                        <MenuItem name="sale" :to="handleGoToMenu('/sale')">
                            <Icon type="ios-alert"></Icon>
                            <span>Sale</span>              
                        </MenuItem>
                        <MenuItem name="returnproduct" :to="handleGoToMenu('/returnproduct')">
                            <Icon type="ios-alert"></Icon>
                            <span>Return</span>              
                        </MenuItem>
                        <MenuItem name="exchangeproduct" :to="handleGoToMenu('/exchangeproduct')">
                            <Icon type="ios-alert"></Icon>
                            <span>Exchange</span>              
                        </MenuItem>
                        <MenuItem name="payment" :to="handleGoToMenu('/payment')">
                            <Icon type="ios-alert"></Icon>
                            <span>Payment</span>              
                        </MenuItem>
                        <MenuItem name="collection" :to="handleGoToMenu('/collection')">
                            <Icon type="ios-alert"></Icon>
                            <span>Collection</span>              
                        </MenuItem>
                        <MenuItem name="voucher" :to="handleGoToMenu('/voucher')">
                            <Icon type="ios-alert"></Icon>
                            <span>Voucher Posting</span>              
                        </MenuItem>
                        <MenuItem name="2-1">                        
                            <Submenu name="2-1-1">
                                <template slot="title">
                                    <span class="cencel">Cancel</span>
                                </template>
                                <MenuItem name="purchasecancel" :to="handleGoToMenu('/purchasecancel')">Purchase</MenuItem>
                                <MenuItem name="salecancel" :to="handleGoToMenu('/salecancel')">Sale</MenuItem>
                                <MenuItem name="paymentcancel" :to="handleGoToMenu('/paymentcancel')">Payment</MenuItem>
                                <MenuItem name="collectioncancel" :to="handleGoToMenu('/collectioncancel')">Collection</MenuItem>
                            </Submenu>
                        </MenuItem>
                    </Submenu>
                    <!-- menu -->
                    <Submenu name="3">
                        <template slot="title">
                            <Icon type="ios-navigate"></Icon>
                           Reports
                        </template>
                        <MenuItem name="purchasereport" :to="handleGoToMenu('/purchasereport')">Purchase Report</MenuItem>
                        <MenuItem name="salesreport" :to="handleGoToMenu('/salesreport')">Sales Report</MenuItem>
                        <MenuItem name="paymentreport" :to="handleGoToMenu('/paymentreport')">
                        Payment Report            
                        </MenuItem>
                        <MenuItem name="collectionreport" :to="handleGoToMenu('/collectionreport')">
                        Collection Report         
                        </MenuItem>

                        <!-- <MenuItem name="3-1">                        
                            <Submenu name="3-1-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Sales
                                </template>
                                <MenuItem name="itemselling" :to="handleGoToMenu('/itemselling')">Item Wise</MenuItem>
                                <MenuItem name="selllist" :to="handleGoToMenu('/selllist')">Invoice Wise</MenuItem>
                                <MenuItem name="customerdue" :to="handleGoToMenu('/customerdue')">Due List</MenuItem>
                            </Submenu>
                        </MenuItem> -->
                        <!-- <MenuItem name="3-2">                        
                            <Submenu name="3-2-1">
                                <template slot="title">
                                    <Icon type="ios-albums"></Icon>
                                    Purchas
                                </template>
                                <MenuItem name="purchaseitemlist" :to="handleGoToMenu('/purchaseitemlist')">Item Wise</MenuItem>
                            </Submenu>
                        </MenuItem>                         -->
                        <MenuItem name="3-3">                        
                            <Submenu name="3-3-1">
                                <template slot="title">
                                    Account
                                </template>
                                <MenuItem name="cash" :to="handleGoToMenu('/cash')">Cash Report</MenuItem>
                                <!-- <MenuItem name="customerdue" :to="handleGoToMenu('/customerdue')">Due Report Delete</MenuItem> -->
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="3-4">                        
                            <Submenu name="3-4-1">
                                <template slot="title">
                                    Ledger
                                </template>
                                <MenuItem name="supplierledger" :to="handleGoToMenu('/supplierledger')">Supplier</MenuItem>
                                <MenuItem name="customerledger" :to="handleGoToMenu('/customerledger')">Customer</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="3-5">                        
                            <Submenu name="3-5-1">
                                <template slot="title">
                                    Stock Report
                                </template>
                                <MenuItem name="productledger" :to="handleGoToMenu('/productledger')">Product Ledger</MenuItem>
                                <MenuItem name="currentstock" :to="handleGoToMenu('/currentstock')">Current Stock</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="3-6">                        
                            <Submenu name="3-6-1">
                                <template slot="title">
                                    Membership Report
                                </template>
                                <MenuItem name="membershiplist" :to="handleGoToMenu('/membershiplist')">Membership List</MenuItem>
                                <MenuItem name="bonusledger" :to="handleGoToMenu('/bonusledger')">Bonus Ledger</MenuItem>
                            </Submenu>
                        </MenuItem>
                        <MenuItem name="3-7">                        
                            <Submenu name="3-7-1">
                                <template slot="title">
                                    Others Report
                                </template>
                                <MenuItem  v-if="authUser.userType=='Admin'" name="grossprofit" :to="handleGoToMenu('/grossprofit')">Gross Profit</MenuItem>
                                <MenuItem  v-if="authUser.userType=='Admin'" name="netprofit" :to="handleGoToMenu('/netprofit')">Net Profit</MenuItem>
                                <MenuItem name="supplieroutstanding" :to="handleGoToMenu('/supplieroutstanding')">Supplier Outstanding</MenuItem>
                                <MenuItem name="customeroutstanding" :to="handleGoToMenu('/customeroutstanding')">Customer Outstanding</MenuItem>
                                <MenuItem name="discountreport" :to="handleGoToMenu('/discountreport')">Discount Report</MenuItem>
                            </Submenu>
                        </MenuItem>
                    </Submenu>
                    <!-- menu -->
                    <Submenu name="4">
                        <template slot="title">
                            <Icon type="ios-navigate"></Icon>
                           User
                        </template>
                        <MenuItem v-if="authUser.userType=='Admin'" name="newuser" :to="handleGoToMenu('/newuser')">New User</MenuItem>
                        <MenuItem name="changepassword" :to="handleGoToMenu('/changepassword')">Change Password</MenuItem>

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
                    <p class="title-sett">{{headerName}}</p>
                    
                    <p class="title-sett_left"><a href="/logout">Logout</a></p>
                    <p class="title-sett_left">{{authUser.name}}</p>
                    
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
.layout {
    border: 0px solid #d7dde4;
    background: #f5f7f9;
    position: relative;
    border-radius: 0px;
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
.ivu-menu-dark.ivu-menu-vertical .ivu-menu-submenu .ivu-menu-item-active, .ivu-menu-dark.ivu-menu-vertical .ivu-menu-submenu .ivu-menu-item-active:hover {
    border-right: none;
    color: #fff;
    background: transparent !important;
}
 .ivu-layout-sider {
    background: #3a3838 !important;
}
 .ivu-menu-dark {
    background: #3a3838 !important;
}
 .ivu-menu-dark.ivu-menu-vertical .ivu-menu-opened {
    background: #191818 !important;
}
.ivu-menu-dark.ivu-menu-vertical .ivu-menu-opened .ivu-menu-submenu-title {
    background: #565656;
}
.ivu-menu-dark.ivu-menu-vertical .ivu-menu-item:hover, .ivu-menu-dark.ivu-menu-vertical .ivu-menu-submenu-title:hover {
    color: #fff;
    background: #565656;
}
.menu-item span {
    width: auto;
}
</style>
