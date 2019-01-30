<template>
    <div>
        <Row>
           <Col  class="dream-input-main" span="22" offset="1" >
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search"> 
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                    
                    <FormItem label="Zone">
                        <Select v-model="filterZone" placeholder="Select Zone"  filterable clearable>
                                <Option v-for="(zone,i) in dataZone" :value="zone.zoneName" :key="i">{{ zone.zoneName }}</Option>
                            </Select>
                    </FormItem>
                    <FormItem label="Date">
                        <DatePicker type="daterange" :options="options2" placement="bottom-end" placeholder="Select date" @on-change="getData" style="width: 200px"></DatePicker>
                    </FormItem>
                </Form>
                <Button  align="left" @click="showPrint">Print</Button>
                <div>
            <div class="total_cost text_right">
                 <div class="total_cost_bottom d b_color">
                    <div class="total_cost_main dis">
                        <div class="total_cost_main_left flex_space">
                            <p class="total_cost_main_left_text">Total Sales Amount</p>
                        </div>
                        <div class="total_cost_main_right">
                            <!-- <p class="total_cost_main_left_text">{{totalProfit.toFixed(2)}}</p> -->
                            <p class="total_cost_main_left_text">{{totalSale.toFixed(2)}}</p>
                        </div>
                    </div>
                </div>
            </div>

                    <!-- new table -->
            <div class="buyer_tables">
                    <!-- items -->
                <div class="buyer_tables_all" v-if="searchData.length" v-for="(item,index) in searchData" :key="index" >
                    <div class="buyer_tables_all_name_all dis">
                        <p class="buyer_tables_all_title">Buyer Name</p>
                        <p class="buyer_tables_all_name"> {{item.customerName}}</p>
                    </div>

                    <div class="buyer_tables_all_name_all dis">
                        <p class="buyer_tables_all_title">Invoice No</p>
                        <p class="buyer_tables_all_name"> {{item.invoice_id}}</p>
                    </div>
                    <div class="buyer_tables_all_name_all dis">
                        <p class="buyer_tables_all_title">Date</p>
                        <p class="buyer_tables_all_name"> {{item.date}}</p>
                    </div>

                    <div class="buyer_tables_main">
                            <!-- title -->
                        <div class="buyer_tables_main_all table_title_bg dis b_color">
                            <div class="buyer_tables_main_name b_color flex_space">
                                <p class="buyer_tables_main_title">Product Name</p>
                            </div>

                            <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_title">Sales Unit</p>
                            </div>

                            <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_title">Unit Price</p>
                            </div>

                             <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_title">Total Sales Price</p>
                            </div>

                             <!-- <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_title">Profit</p>
                            </div>

                             <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_title">Profit(%)</p>
                            </div> -->
                        </div>
                            <!-- title -->

                            <!-- Items -->
                        <div class="buyer_tables_main_all dis b_color" v-if="item.selling.length"  v-for="(productItem,productIndex) in item.selling" :key="productIndex" >
                            <div class="buyer_tables_main_name b_color flex_space">
                                <p class="buyer_tables_main_text">{{productItem.product.productName}}</p>
                            </div>

                            <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_text">{{productItem.quantity}}</p>
                            </div>

                            <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_text">{{productItem.product.sellingPrice}}</p>
                            </div>

                              <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_text">{{(productItem.quantity)*(productItem.product.sellingPrice)}}</p>
                            </div>

                            <!-- <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_text">{{(productItem.product.sellingPrice-productItem.product.averageBuyingPrice)*productItem.quantity}}</p>
                            </div>

                             <div class="buyer_tables_main_num b_color">
                                <p class="buyer_tables_main_text">{{productItem | findProfitPercent}}</p>
                            </div> -->
                        </div>
                            <!-- Items -->

                            

                            <!-- Total Sales -->
                        <div class="Total_Sales dis">
                            <div class="buyer_tables_main_name b_color flex_space">
                                <Button  class="Total_Sales_text" @click="showPrint(index)"><span class="Total_Sales_text_span">Print</span></Button>
                            </div>

                            <div class="buyer_tables_main_num b_color">
                                <p class="Total_Sales_text"><span class="Total_Sales_text_span">{{ item.selling | totalUnit }}</span></p>
                            </div>

                            <div class="buyer_tables_main_num b_color">
                               <p class="Total_Sales_text"><span class="Total_Sales_text_span"></span></p>
                            </div>

                              <div class="buyer_tables_main_num b_color">
                                <p class="Total_Sales_text"><span class="Total_Sales_text_span">{{ item.selling | totalSalesPrice }}</span></p>
                            </div>

                         <!-- <div class="buyer_tables_main_num b_color">
                               <p class="Total_Sales_text"><span class="Total_Sales_text_span">{{item.selling | totalProfit}}</span></p>
                            </div>

                             <div class="buyer_tables_main_num b_color">
                                <p class="Total_Sales_text"><span class="Total_Sales_text_span">{{ totalProfitPercent(item.selling)}}</span></p>
                             </div> -->
                        </div>
                            <!-- Total Sales -->
                    </div>
                </div>
                    <!-- items -->
            </div>
                </div>


                <!-- <Row>
                    <Col span="10" offset="15" >
                        <h3>Total Sales amount: {{totalSalesPrice}} </h3>
                    </Col>
                </Row> -->
                <!-- <Table :columns="columns1" :data="searchData" @on-row-click="rowSelect"></Table> -->
            </Col>
        </Row>

        <!-- <Modal v-model="editModal" width="740" style="margin-top:20px;" >
            <div  class="print">
                <h2 style="text-align:center">Dreams Gallery</h2>
                <h3>Profit List</h3>
                <h3>Date: {{ filterDate[0] }} to {{ filterDate[1] }}</h3>
                <Table :columns="columns1" :data="searchData"></Table>
            </div>
            <div slot="footer">
                
            </div>

        </Modal> -->

        <Modal class="print_all" v-model="viewModal"  :styles="{top: '5px', width:'288px'}" >
             
         <div  class="print">
       
            <!-- <Table :columns="columns1" :data="formValue.productDetails"></Table> -->
            <div class="memu" v-if="dataInvoice[dataInvoiceIndex]" >
               <div class="memu_email text_center">
                  <p class="memu_text">For any queries, complanints or suggestion please</p>
                  <p class="memu_text">Call: {{shopData.contact}}</p>
                  <p class="memu_text">Email: info@greamsgallerybd.com</p>
               </div>
               <div class="memu_Address text_center">
                  <p class="memu_text">{{shopData.companyName}}</p>
                  <p class="memu_text">{{shopData.address}}</p>
                  
               </div>
               <div class="memu_sold dis b_color">
                  <p class="memu_text flex_space">Sold By : {{(dataInvoice[dataInvoiceIndex].admin.name)? dataInvoice[dataInvoiceIndex].admin.name : ''}}</p>
                  <p class="memu_text">Date: {{dataInvoice[dataInvoiceIndex].date}}</p>
               </div>
               <p class="RETAIL text_center"><span class="RETAIL_sapn">RETAIL INVOICE</span></p>
               <div class="memu_CUS_ADRESS">
                  <p class="memu_text">Customer: {{dataInvoice[dataInvoiceIndex].customerName }}</p>
                  <p class="memu_text" v-if="dataInvoice[dataInvoiceIndex].customer_id!=1" >Address: {{dataInvoice[dataInvoiceIndex].customer.address}}</p>
                  <p class="memu_text" v-if="dataInvoice[dataInvoiceIndex].customer_id!=1" >Mob: {{dataInvoice[dataInvoiceIndex].customer.contact}}</p>
               </div>
               <div class="to_Enjoy b_color">
                  <p class="memu_text">To Enjoy special Discounts Please register as a loyalty Customer</p>
               </div>
               
              
               <div class="memu_list">
                 
                  <div class="memu_list_main dis align">
                     <div class="memu_list_all sl">
                        <p class="memu_list_title">SL</p>
                     </div>
                     <div class="memu_list_all items flex_space text_center">
                        <p class="memu_list_title">Item Description</p>
                     </div>
                     <div class="memu_list_all MRP">
                        <p class="memu_list_title ">MRP</p>
                     </div>
                     <div class="memu_list_all QTy">
                        <p class="memu_list_title">Qty</p>
                     </div>
                     <div class="memu_list_all Total">
                        <p class="memu_list_title">Total</p>
                     </div>
                  </div>
                 
                  <div class="memu_list_main dis" v-for="(item,index) in dataInvoice[dataInvoiceIndex].selling" :key="index" >
                     <div class="memu_list_all sl">
                        <p class="memu_list_num">{{index+1}}</p>
                     </div>
                     <div class="memu_list_all items flex_space">
                        <p class="memu_list_title">{{item.product.productName }}</p>
                     </div>
                     <div class="memu_list_all MRP">
                        <p class="memu_list_title ">{{item.product.sellingPrice}}</p>
                     </div>
                     <div class="memu_list_all QTy">
                        <p class="memu_list_title">{{item.quantity}}</p>
                     </div>
                     <div class="memu_list_all Total">
                        <p class="memu_list_title">{{item.product.sellingPrice*item.quantity}} </p>
                     </div>
                  </div>
                 
                  <!-- <div class="memu_list_main dis">
                     <div class="memu_list_all sl">
                        <p class="memu_list_num">1</p>
                     </div>
                     <div class="memu_list_all items flex_space">
                        <p class="memu_list_title">Ladies Flat Shose DRSV-01</p>
                     </div>
                     <div class="memu_list_all MRP">
                        <p class="memu_list_title ">120000</p>
                     </div>
                     <div class="memu_list_all QTy">
                        <p class="memu_list_title">2</p>
                     </div>
                     <div class="memu_list_all Total">
                        <p class="memu_list_title">240000</p>
                     </div>
                  </div>
                 
                  <div class="memu_list_main dis">
                     <div class="memu_list_all sl">
                        <p class="memu_list_num">2</p>
                     </div>
                     <div class="memu_list_all items flex_space">
                        <p class="memu_list_title">Ladies Flat Shose DRSV-01</p>
                     </div>
                     <div class="memu_list_all MRP">
                        <p class="memu_list_title ">120000</p>
                     </div>
                     <div class="memu_list_all QTy">
                        <p class="memu_list_title">2</p>
                     </div>
                     <div class="memu_list_all Total">
                        <p class="memu_list_title">240000</p>
                     </div>
                  </div>
                 
                  <div class="memu_list_main dis b_color">
                     <div class="memu_list_all sl">
                        <p class="memu_list_num">3</p>
                     </div>
                     <div class="memu_list_all items flex_space">
                        <p class="memu_list_title">Ladies Flat Shose DRSV-01</p>
                     </div>
                     <div class="memu_list_all MRP">
                        <p class="memu_list_title ">1200</p>
                     </div>
                     <div class="memu_list_all QTy">
                        <p class="memu_list_title">99</p>
                     </div>
                     <div class="memu_list_all Total">
                        <p class="memu_list_title">2400</p>
                     </div>
                  </div> -->
                 
               </div>
              
               <div class="memu_total b_color">
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">Sub Total:</p>
                     <p class="memu_list_title memu_total_num">{{ dataInvoice[dataInvoiceIndex].totalPrice }}</p>
                  </div>
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">Discount:</p>
                     <p class="memu_list_title memu_total_num">{{ dataInvoice[dataInvoiceIndex].discount}}</p>
                  </div>
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">Net Payable:</p>
                     <p class="memu_list_title memu_total_num">{{ dataInvoice[dataInvoiceIndex].sellingPrice}}</p>
                  </div>
               </div>
              
               <div class="CASH_total">
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">CASH PAID:</p>
                     <p class="memu_list_title memu_total_num">{{ dataInvoice[dataInvoiceIndex].paidAmount }}</p>
                  </div>
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">CHANGE AMOUNT:</p>
                     <p class="memu_list_title memu_total_num">{{ dataInvoice[dataInvoiceIndex].paidAmount-dataInvoice[dataInvoiceIndex].paidAmount }}</p>
                  </div>
               </div>
               
               <!-- <div class="space b_color"></div> -->
               <div class="memu_thanks text_center">
                  <p class="memu_thanks_text">Thank you for shopping with </br>{{shopData.companyName}}</br> Please vist www.dreamsgallerybd.com for Home Delivery. Purchase of Defected item must be exchanged by 24 hours with invoice.</p>
               </div>
            </div>
              <!-- <h2 style="text-align:center">{{ shopData.companyName }}</h2>
               <p style="text-align:center"> 
                   {{ shopData.address }}</br>
                   world_first@yahoo.com</br>
                   {{ shopData.contact }}</br>
               </p>
               <hr/>
               <p> 
                   Sold by Bokor Talukder</br>
                   Invoice ID: INV1000002</br>
                   Date: 25/01/2018 13:22</br>
               </p>
               
                   <div id="table">
                       <table>
                           <tr class="tabletitle">
                               <td class="item"><h2>SL</h2></td>
                               <td class="item"><h2>Item</h2></td>
                               <td class="Hours"><h2>Qty</h2></td>
                               <td class="Rate"><h2>Sub Total</h2></td>
                           </tr>
               
                           <tr v-for="(item,i) in formValue.productDetails" :key="i" class="service">
                               <td class="tableitem"><p class="itemtext">{{ i+1 }}</p></td>
                               <td class="tableitem"><p class="itemtext">{{ item.productName }}</p></td>
                               <td class="tableitem"><p class="itemtext">{{ item.quantity }}</p></td>
                               <td class="tableitem"><p class="itemtext">{{ item.discountedPrice*item.quantity }}</p></td>
                           </tr>
               
                       
               
               
                           <tr class="tabletitle">
                               <td></td>
                               <td class="Rate"><h2>Sub-total</h2></td>
                               <td></td>
                               <td class="payment"><h2>{{ formValue.totalTotal }}</h2></td>
                           </tr>
               
                           <tr class="tabletitle">
                               <td></td>
                               <td class="Rate"><h2>Discount %(-)</h2></td>
                               <td></td>
                               <td class="payment"><h2>{{ formValue.discount}}</h2></td>
                           </tr>
                           <tr class="tabletitleDown">
                               <td></td>
                               <td class="Rate"><h2>Total</h2></td>
                               <td></td>
                               <td class="payment"><h2>{{ formValue.total }}</h2></td>
                           </tr>
                           </hr>
                           <tr class="tabletitle">
                               <td></td>
                               <td class="Rate"><h2>Cash Paid</h2></td>
                               <td></td>
                               <td class="payment"><h2>{{ formValue.cashPaid }}</h2></td>
                           </tr>
                           <tr class="tabletitle">
                               <td></td>
                               <td class="Rate"><h2>Cash Change</h2></td>
                               <td></td>
                                <td class="payment"><h2>{{ formValue.cashPaid-formValue.paidAmount }}</h2></td>
                           </tr>
                           <tr v-if='(homeDelivery) && currentCustomer.id!=1' class="tabletitle">
                               <td></td>
                               <td class="Rate"><h2>Delivery Charge</h2></td>
                               <td></td>
                                <td class="payment"><h2>40</h2></td>
                           </tr>
                           <tr v-if='(homeDelivery) && currentCustomer.id!=1' class="tabletitle">
                               <td></td>
                               <td class="Rate"><h2>Total with Delivery Charge</h2></td>
                               <td></td>
                                <td class="payment"><h2>{{ (formValue.total)+40 }}</h2></td>
                           </tr>
                       </table>
                   </div>
                   <p class="legal"> 
                       {{ shopData.invoiceNote }}
                   </p> -->
         </div>
         <div slot="footer">
            <Button type="primary" size="large"  @click="clearForm">
            <span>Clear and Exit</span>
            </Button>
         </div>
      </Modal>
        <!-- <pagination :list-data="createFakeData()"/>   -->
    </div>
</template>

<script>
   import pagination from '../pagination.vue'
export default {
	
	components: {
    pagination,
  },
        data () {
            return {
                shopData:[],
                dataInvoiceIndex: 0,
                viewSelling:{},
                viewModal:false,
                date:false,
                index:0,
                search:'',
                filterCustomer:'',
                filterZone:'',
                searchValue:'',
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                dataSupplier: [],
                filterDate:[],
                viewInvoice:{},
                currentSupplier: {
                    supplierName:'',
                    number:'',
                    email:'',
                    address:'',
                    outStanding:'',
                
                },
                
                dataSearch:[],
                dataCustomer: [],
                dataInvoice:[],
                dataZone:[],
                formInvoice:
                {
                    type:'purchase',

                },
                formValue: {
                     type:'purchase',
                     date:'',
                     supplier_id: '',
                     productDetails: []
                },
                editObj: {
                    id:null,
                    catName:'',
                    group_id:'',
                    
                },
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    catName:'',
                    group_id:'',
                    groupName:'',
                    
                },
                options2: {
                        shortcuts: [
                            {
                                text: '1 week',
                                value () {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                                    return [start, end];
                                }
                            },
                            {
                                text: '1 month',
                                value () {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                                    return [start, end];
                                }
                            },
                            {
                                text: '3 months',
                                value () {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                                    return [start, end];
                                }
                            }
                        ]
                    },
                columns1: [
                    {
                        title: 'Date',
                        key: 'date'
                    },
                    {
                        title: 'Invoice ID',
                        key: 'invoice_id'
                    },
                    {
                        title: 'Customer',
                        key: 'customerName'
                    },
                    {
                        title: 'Sales Amount',
                        key: 'totalPrice'
                    },
                    {
                        title: 'Admin',
                        key: 'adminName'
                    },

                ],

                
            }
            
        },
         filters: {
            findProfitPercent(productItem){
                return (((productItem.product.sellingPrice-productItem.product.averageBuyingPrice)*100)/productItem.product.averageBuyingPrice).toFixed(2);
            },
            totalUnit(selling){
                let unit = 0 
                for(let d of selling){
                    unit += d.quantity
                }
                return unit
            },
            totalSalesPrice(selling){
                let p = 0 
                for(let d of selling){
                    p += parseFloat(d.product.sellingPrice*d.quantity)
                }
                return p
            },
         },
        computed: {
                totalSale() {

                var tF = 0
                for (let d of this.searchData) {
                    tF = tF + d.totalPrice

                }
                return tF

            },
            searchData(){
                // if(this.filterCustomer && this.filterZone){
                //     return this.dataInvoice.filter((data)=>{                    
                //         return (data.customerName.toUpperCase().match(this.filterCustomer.toUpperCase()) &&
                //         data.customer.zone.toUpperCase().match(this.filterZone.toUpperCase()) ) 
                //         &&
                //         (
                //         data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                //          data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                //          data.id.toString().match(this.search) ||
                //          data.totalPrice.toString().match(this.search) ||
                //          data.totalQuantity.toString().match(this.search) ||
                //          data.discount.toString().match(this.search) ||
                //          data.paidAmount.toString().match(this.search)
                //         )            
                //         }
                //         );

                // }
                // else if(this.filterCustomer)
                // {
                // return this.dataInvoice.filter((data)=>{                    
                //     return data.customerName.toUpperCase().match(this.filterCustomer.toUpperCase()) &&
                //     (
                //         data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.id.toString().match(this.search) ||
                //      data.totalPrice.toString().match(this.search) ||
                //      data.totalQuantity.toString().match(this.search) ||
                //      data.discount.toString().match(this.search) ||
                //      data.invoice_id.toString().match(this.search) ||
                //      data.paidAmount.toString().match(this.search)
                //     )

            
                //     }
                //     );

                // }
                if(this.filterZone){
                    console.log(this.filterZone);
                    return this.dataInvoice.filter((data)=>{                    
                        return data.customer.zone.toUpperCase().match(this.filterZone.toUpperCase()) 
                        &&
                        (
                        data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                        data.invoice_id.toUpperCase().match(this.search.toUpperCase()) ||
                        data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                         data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                         data.id.toString().match(this.search) ||
                         data.totalPrice.toString().match(this.search) ||
                         data.totalQuantity.toString().match(this.search) ||
                         data.discount.toString().match(this.search) ||
                         data.paidAmount.toString().match(this.search)
                        )            
                        });

                }
                else{
                    console.log('okkk')
                    return this.dataInvoice.filter((data)=>{                    
                        return data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                            data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                            data.invoice_id.toUpperCase().match(this.search.toUpperCase()) ||
                            data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                            data.id.toString().match(this.search) ||
                            data.totalPrice.toString().match(this.search) ||
                            data.totalQuantity.toString().match(this.search) ||
                            data.discount.toString().match(this.search) ||
                            data.paidAmount.toString().match(this.search)
                            || data.selling.some((p)=>{
                                 return p.product.productName.toUpperCase().match(this.search.toUpperCase())
                            })
                       
                    });

                }
            },
            totalSalesPrice(){
                let totalSale=0;
                let item;
               
                for(let i = 0;i<this.searchData.length;i++){
                   
                    
                    totalSale+= parseInt(this.searchData[i].totalPrice,10);
                }
                return totalSale;

            },
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
            },
            totalPrice()
            {
                var totalPrice=0
                for ( var i = 0; i < this.formValue.productDetails.length; i++) {
                  
                        totalPrice+=this.formValue.productDetails[i].quantity*this.formValue.productDetails[i].unitPrice
                    }
                return totalPrice;
                
            },
            totalQuantity()
            {
                var total=0
                for ( var i = 0; i < this.formValue.productDetails.length; i++) {
                        total+=parseInt(this.formValue.productDetails[i].quantity)   
                    }
                    return total   
            },

        },
        methods: {
            // async rowSelect(k)
            // {
            //     this.viewModal=true
            //     this.viewInvoice=k
            //     try{
            //         let {data} =await  axios({
            //             method: 'get',
            //             url:`/app/sell/${this.viewInvoice.id}`,
            //         })
            //         this.viewSelling=data
            //     }catch(e){
            //         this.e('Oops!','Something went wrong, please try again!')
            //     }
            // },

             createFakeData(){
                  let data = [];
                  for(let i = 0; i < 100; i++){
                    data.push({first: 'John',
                               last:'Doe', 
                               suffix:'#' + i});
                  }
                  return data;
                },
            async showPrint (index) {
                console.log(index)
                this.dataInvoiceIndex=index
                this.viewModal=true
                // this.editModal=true
                await new Promise(resolve => setTimeout(resolve, 500));
                console.log("Print")
                window.print();
            },
            async getData(k)
            {
                if(!k[0])
                {
                    return
                }
                this.filterDate=k
                if(k)
                this.date=true
                else
                this.date=false

                try{
                    let {data} =await  axios({
                        method: 'get',
                        url:`/app/filterSale/${k[0]}/${k[1]}`

                    })
                    for(let d of data){
                        d.invoice_id="INV-SO-DG-"+d.id
                        d.adminName=d.admin.name
                        if(d.customer)
                        d.customerName=d.customer.customerName
                    }
                    this.dataInvoice=data
                    this.lf();

                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }
                console.log(k);
            },
            async changedSupplier(k)
            {
                console.log(k);
                console.log(this.formValue.supplier_id);
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/payment/getOutstanding/${this.formValue.supplier_id}`
                })
                this.setSupplier(this.formValue.supplier_id)
                this.currentSupplier.outStanding=data.outStanding

                this.lf();
                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }

            },
            setSupplier(id)
            {
                var i=0

                while (i < this.dataSupplier.length) {
                    if (this.dataSupplier[i].id == id) {
                        this.currentSupplier.supplierName=this.dataSupplier[i].supplierName
                        this.currentSupplier.number=this.dataSupplier[i].number
                        this.currentSupplier.address=this.dataSupplier[i].address
                        this.currentSupplier.email=this.dataSupplier[i].email
                    }
                    i++;
                }
                
            },
            showClear()
            {
                this.clearModel=true
            },
            removeItem(index)
            {
                
                this.formValue.productDetails.splice(index,1)
            },
            clearForm()
            {
                this.formValue.supplier_id=''
                this.formValue.productDetails.splice(0,this.formValue.productDetails.length)
                this.clearModel=false

            },
            dateConverter(key)
            {
                this.formValue.date=key

            },
            addProduct(k){
                if(this.searchValue)
                {
                this.formValue.productDetails.push(this.dataSearch[k])
                }
                this.searchValue=''
                
            },
            async setData()
            {
                try{
                let {data} =await axios({
                    method: 'get',
                    url:`/app/searchProduct/${this.searchValue}`,
                    })
                    this.dataSearch=data;
                    this.lf();

                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                    this.le();
                }
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            async makePurchase(){
                //invoice added
                this.formValue.totalPrice=this.totalPrice
                this.formValue.totalQuantity=this.totalQuantity
                if( !this.totalQuantity || !this.totalPrice || !this.formValue.supplier_id|| !this.formValue.date)
                {
                    this.loading=false
                    this.e('Oops!','You nedd to enter Stock and Price in All Fields')

                }
                else
                {
                    this.loading=true
                    try{
                        let {data} =await  axios({
                            method: 'post',
                            url:'/app/purchase',
                            data: this.formValue
                        })
                        this.clearForm()
                        
                        data.data.supplierName=data.data.supplier.supplierName
                        this.dataInvoice.unshift(data.data)
                        
                        this.s('Great!','Purchase has been added successfully!')
                        this.loading=false
                    }catch(e){
                        this.loading=false
                        this.e('Oops!','Something went wrong, please try again!')
                    }

                }
                
            },
            showEdit (index) {
                this.editObj.id=this.dataInvoice[index].id
                this.editObj.invoice_id=this.dataInvoice[index].invoice_id
                this.editObj.product_id=this.dataInvoice[index].product_id
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.id=this.dataInvoice[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/categoryUpdate',
                        data: this.editObj
                    })
                    this.dataCategory[this.UpdateValue.indexNumber].catName=data.catName
                    this.dataCategory[this.UpdateValue.indexNumber].group_id=data.group_id
                    this.dataCategory[this.UpdateValue.indexNumber].groupName=data.group.groupName
                    this.s('Great!','Category information has been updated successfully!')
                    
                    this.sending=false
                    this.editModal=false
                }catch(e){
                    this.sending=false
                    this.editModal=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            async remove(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'delete',
                        url:`/app/invoice/${this.UpdateValue.id}`,
                    })
                    this.dataInvoice.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Invoice information has been removed successfully!')
                    
                    this.sending=false
                    this.deleteModal=false
                }catch(e){
                    this.sending=false
                    this.deleteModal=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            }
        },



        async created()
        {
            this.ls();
            const end = new Date();
			const start = new Date();
			start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
            let date1=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
            let date2=end.getFullYear()+'-'+(end.getMonth()+1)+'-'+end.getDate();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/filterSale/${date2}/${date2}`

                })
                for(let d of data){
                    d.invoice_id="INV-SO-DG-"+d.id
                    d.adminName=d.admin.name
                    if(d.customer)
                    d.customerName=d.customer.customerName
                }
                this.dataInvoice=data
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/customer'
                })
                this.dataCustomer=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/zone'
                })
                this.dataZone=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/setting'
                })
                this.shopData=data
            this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }


            
        }

    }
</script>
<style>
    th, td {
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px;
        text-align: left;
    }
    .demo-auto-complete-item{
        padding: 4px 0;
        border-bottom: 1px solid #F6F6F6;
    }
    .demo-auto-complete-group{
        font-size: 12px;
        padding: 4px 6px;
    }
    .demo-auto-complete-group span{
        color: #666;
        font-weight: bold;
    }
    .demo-auto-complete-group a{
        float: right;
    }
    .demo-auto-complete-count{
        float: right;
        color: #999;
    }
    .demo-auto-complete-more{
        display: block;
        margin: 0 auto;
        padding: 4px;
        text-align: center;
        font-size: 12px;
    }
</style>
