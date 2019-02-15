<template>
   <div>
      <Row>
         <Col class="dream-input-main" span="14" offset="1">
         <Col span="24" >
         <Card>
            <p>Product Code</p>
            <Row>
               <Col span="17">
               <Input type="text" placeholder="Barcode" @on-enter="setData" 
                  v-model="temp.Barcode"></Input>  
               </Col>
               <Col span="5" offset="1">
               <DatePicker type="date" @on-change="dateConverter" placeholder="Select date"></DatePicker>
               </Col>
            </Row>
         </Card>
         </Col>
         <Col span="24">
         <Card>
            <p slot="title">Product List</p>
            <table style="width:100%" ref="printTable">
               <tr>
                  <th>Name</th>
                  <th>Model</th>
                  <th>Color</th>
                  <th>Size</th>
                  <th>Unit Price</th>
                  <th>Stock</th>
                  <th>Quantity</th>
                  <th>Total</th>
                  <th>Action</th>
               </tr>
               <tr v-for="(data,i) in formValue.productDetails" :key="i">
                  <td >{{data.productName}}</td>
                  <td >{{data.model}}</td>
                  <td >{{data.color}}</td>
                  <td>{{data.size}}</td>
                  <td>
                     {{data.sellingPrice}} 
                     <Tag  color="red" v-if="data.discount" type="border">-{{data.discount}}%</Tag>
                  </td>
                  <td>{{data.stock}}</td>
                  <td>
                     <InputNumber  :min="1" :max="data.stock" v-model="data.quantity" @on-change="quantityChange" ></InputNumber>
                  </td>
                  <td>
                     <InputNumber  v-model="data.discountedPrice*data.quantity" disabled></InputNumber>
                  </td>
                  <td><Button type="error" icon="ios-trash" @click="removeItem(i)"></Button></td>
               </tr>
               <tr style="background-color: #e9eaec;" >
                  <td colspan="6" style="text-align:right;">Sub Total </td>
                  <td >{{totalQuantity}}</td>
                  <td  colspan="2">{{totalPrice}}</td>
               </tr>
               <tr >
                  <td colspan="7" style="text-align:right">Discount %(-)</td>
                  <td  colspan="2">
                     <InputNumber   :min="0" :max="100" @on-change="discount" v-model="formValue.discount"></InputNumber >
                  </td>
               </tr>
               <tr >
                  <td colspan="7" style="text-align:right">Net Payable</td>
                  <td  colspan="2">
                     <InputNumber   :min="0" :max="parseInt(formValue.subTotal)" @on-change="total" v-model="formValue.total"></InputNumber >
                  </td>
               </tr>
               <tr >
                  <td colspan="7" style="text-align:right">Paid Amount</td>
                  <td  colspan="2">
                     <InputNumber  :min="0" :max="parseInt(formValue.total)"  v-model="formValue.paidAmount"  @on-change="paidAmountChange"></InputNumber>
                  </td>
               </tr>
               <tr >
                  <td colspan="7" style="text-align:right">Cash Paid</td>
                  <td  colspan="2">
                     <InputNumber  :min="parseInt(formValue.paidAmount)"  v-model="formValue.cashPaid"></InputNumber>
                  </td>
               </tr>
               <tr >
                  <td colspan="7" style="text-align:right">Change Amount</td>
                  <td  colspan="2">{{ changeAmount }}</td>
               </tr>
            </table>
         </Card>
         </Col>
         <div class="submits_form">
            <div class="submits_form_all">
               <div class="submits_form_checkbox">
                  <input type="checkbox" id="checkbox" v-model="homeDelivery">
                  <label for="homeDelivery">Home Delivery</label>
               </div>
               <div class="submits_button">
                  <Button type="error" size="large"  @click="clearForm">
                  Clear
                  </Button>
                  <Button type="primary" size="large" :loading="sending" @click="makeSell">
                  <span v-if="!loading">Confirm Sale</span>
                  <span v-else>Loading...</span>
                  </Button>
               </div>
            </div>
         </div>
         </Col>
         <Col class="dream-input-main" span="7" offset="1">
         <Row>
            <Form>
               <Col span="22" offset="1">
               <FormItem label="Customer">
                  <!-- <Select v-model="formValue.customer_id" placeholder="Customer" @on-change="changedCustomer" filterable clearable>
                     <Option v-for="(customer,i) in dataCustomer" :value="customer.id"  :key="i">
                         <span>{{customer.customerName}}</span>
                         <span style="float:right;color:#ccc">{{customer.contact}} | {{customer.barcode}}</span>
                     </Option>
                     </Select>  @on-change="changedCustomer"--> 
                  <div class="dropdown">
                     <Input class="dropbtn" v-model="tempCustomerInof" placeholder="Customer" @on-keyup="changedCustomerV2"      />
                     <div class="dropdown-content">
                        <a v-for="(customer,i) in flterMemberList" :value="customer.id"  :key="i" @click="changedCustomer(customer)"  >
                        <span>{{customer.customerName}}</span>
                        <span style="float:right;color:#ccc">{{customer.contact}} | {{customer.barcode}}</span>
                        </a>
                     </div>
                  </div>
               </FormItem>
               </Col>
               <Col span="11" offset="1" v-if="currentCustomer.status" >
               <FormItem label="Total Bonus Amount">
                  <br/>
                  <InputNumber   v-model="currentCustomer.bonusAmount" disabled></InputNumber >
               </FormItem>
               </Col>
               <Col span="11" offset="1" v-if="currentCustomer.status">
               <FormItem label="Useing Bonus Amount">
                  <br/>
                  <InputNumber   v-model="formValue.bonusAmount" :min="0" :max="Math.min(parseInt(currentCustomer.bonusAmount), parseInt(formValue.totalTotal))" @on-change="discount" ></InputNumber >
               </FormItem>
               </Col>
               <Col span="22" offset="1">
               <FormItem label="Reference">
                  <!-- <Select v-model="formValue.reference_id" placeholder="Number"  @on-change="changedReference" filterable clearable>
                     <Option v-for="(customer,i) in flterMemberList" :value="customer.id"  :key="i">
                         <span>{{customer.customerName}}</span>
                         <span style="float:right;color:#ccc">{{customer.contact}} | {{customer.barcode}}</span>
                     </Option>
                     </Select> -->
                  <div class="dropdown">
                     <Input class="dropbtn" v-model="tempReferencerInfo" placeholder="Number" @on-keyup="changedReferenceV2"      />
                     <div class="dropdown-content">
                        <a v-for="(customer,i) in flterReferencerList" :value="customer.id"  :key="i" @click="changedReference(customer)"  >
                        <span>{{customer.customerName}}</span>
                        <span style="float:right;color:#ccc">{{customer.contact}} | {{customer.barcode}}</span>
                        </a>
                     </div>
                  </div>
               </FormItem>
               </Col>
            </Form>
            <Col v-if="currentCustomer.customerName" span="24">
            <h3>Customer Info</h3>
            <p><b>Name:</b> {{currentCustomer.customerName}}</p>
            <p><b>Number:</b> {{currentCustomer.number}}</p>
            <p><b>Email:</b> {{currentCustomer.email}}</p>
            <p><b>Address:</b> {{currentCustomer.address}}</p>
            <p><b>Outstanding:</b> {{currentCustomer.outStanding}}</p>
            </Col>
            <Col v-if="currentReferenceInfo.customerName" span="24" >
            <hr/>
            </Col>
            <Col v-if="currentReferenceInfo.customerName" span="24"  >
            <h3>Referencer Info</h3>
            <p><b>Name:</b> {{currentReferenceInfo.customerName}}</p>
            <p><b>Number:</b> {{currentReferenceInfo.number}}</p>
            <p><b>Email:</b> {{currentReferenceInfo.email}}</p>
            <p><b>BarCode:</b> {{currentReferenceInfo.barcode}}</p>
            <p><b>Address:</b> {{currentReferenceInfo.address}}</p>
            <p><b>Outstanding:</b> {{currentReferenceInfo.outStanding}}</p>
            </Col>
         </Row>
         </Col>
      </Row>
      <Modal class="print_all" v-model="editModal"  :styles="{top: '5px', width:'288px'}" >
         <div  class="print">
       
            <!-- <Table :columns="columns1" :data="formValue.productDetails"></Table> -->
            <div class="memu">
               <div class="memu_email text_center">
                  <p class="memu_text">For any queries, complanints or suggestion please</p>
                  <p class="memu_text">Call: {{shopData.contact}}</p>
                  <p class="memu_text">Email: info@greamsgallerybd.com</p>
               </div>
               <div class="memu_Address text_center">
                  <p class="memu_text">{{shopData.companyName}}</p>
                  <p class="memu_text">{{shopData.address}}</p>
                  
               </div>
               <div class="memu_sold dis">
                  <p class="memu_text flex_space">Sold By : {{authUser.name}}</p>
                  <p class="memu_text">Date: {{toDayDate}}</p>
               </div>
               <p class="RETAIL text_center"><span class="RETAIL_sapn">RETAIL INVOICE</span></p>
               <div class="memu_CUS_ADRESS">
                  <p class="memu_text">Customer: {{(currentCustomer.customerName)? (currentCustomer.customerName) : "Cash" }}</p>
                  <p class="memu_text" v-if="currentCustomer.id!=1" >Address: {{currentCustomer.address}}</p>
                  <p class="memu_text" v-if="currentCustomer.id!=1" >Mob: {{currentCustomer.number}}</p>
               </div>
               <div class="to_Enjoy">
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
                 
                  <div class="memu_list_main dis" v-for="(item,index) in formValue.productDetails" :key="index" >
                     <div class="memu_list_all sl">
                        <p class="memu_list_num">{{index+1}}</p>
                     </div>
                     <div class="memu_list_all items flex_space">
                         <p class="memu_list_title">{{item.productName  }}<br> {{item.model  }} {{item.color }}  {{item.size }}</p>
                     </div>
                     <div class="memu_list_all MRP">
                        <p class="memu_list_title ">{{item.sellingPrice}}</p>
                     </div>
                     <div class="memu_list_all QTy">
                        <p class="memu_list_title">{{item.quantity}}</p>
                     </div>
                     <div class="memu_list_all Total">
                        <p class="memu_list_title" v-if="item.discount>0" ><del>{{item.sellingPrice*item.quantity}}</del></p>
                        <p class="memu_list_title">{{item.discountedPrice*item.quantity}}</p>
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
              
               <div class="memu_total">
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">Sub Total:</p>
                     <p class="memu_list_title memu_total_num">{{ formValue.totalTotal }}</p>
                  </div>
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">Discount:</p>
                     <p class="memu_list_title memu_total_num">{{ formValue.discount}}</p>
                  </div>
                  <div class="memu_total_main dis text_right" v-if="homeDelivery" >
                     <p class="memu_list_title flex_space">Delivery Charge:</p>
                     <p class="memu_list_title memu_total_num">{{ currentCustomer.delivery}}</p>
                  </div>
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">Net Payable:</p>
                     <p class="memu_list_title memu_total_num">{{(formValue.total)+(currentCustomer.delivery)}}</p>
                  </div>
               </div>
              
               <div class="CASH_total">
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">CASH PAID:</p>
                     <p class="memu_list_title memu_total_num">{{ formValue.cashPaid }}</p>
                  </div>
                  <div class="memu_total_main dis text_right">
                     <p class="memu_list_title flex_space">CHANGE AMOUNT:</p>
                     <p class="memu_list_title memu_total_num">{{ formValue.cashPaid-formValue.paidAmount }}</p>
                  </div>
               </div>
               
               <!-- <div class="space b_color"></div> -->
               <div class="memu_thanks text_center">
                  <p class="memu_thanks_text">Thank you for shopping with </br>{{shopData.companyName}}</br> Please vist www.dreamsgallerybd.com for Home Delivery. Purchase of Defected item must be exchanged by 24 hours with invoice.</p>
               </div>

   


                <div class="spaceBerCode">
                    <div class="print barcode_main_memu">
                        <div class="barcode_code">
                            <!-- <barcode v-bind:value="sellResponseId" style="margin-left: 60px;"> >
                                Sorry Cant Load now
                            </barcode> -->
                            <barcode v-bind:value="sellResponseId" :options="options">
                                Sorry Cant Load now
                            </barcode>
                        </div>
                         <p class="barcode_num">INV-SO-DG-{{sellResponseId}}</p>
                    </div>
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
   </div>
</template>

<script>
    export default {
        data () {
            return {
                shopData:[],
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
                dataExpense:[],
                dataIncome:[],
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
                        title: 'Total Sales Amount',
                        key: 'totalSalesAmount'
                    },
                    {
                        title: 'Total Gross Profit',
                        key: 'totalGrossProfit'
                    },
                    {
                        title: 'Total Income',
                        key: 'totalIncome'
                    },
                    {
                        title: 'Total Expense',
                        key: 'totalExpense'
                    },
                    {
                        title: 'Net Profit',
                        key: 'totalNetProfit'
                    },
                   

                ],
                netProfitData :[
                    {totalSalesAmount : this.totalSale,
                    totalGrossProfit : this.totalProfit,
                    totalIncome : this.totalIncome,
                    totalExpense : this.totalCost,
                    totalNetProfit : this.NetProfit,
                    },
                ],

                
            }
            
        },
        computed: {
            totalProfit()
            {

                var tF=0
                for (let d of this.searchData)
                {
                    var sF=0
                    for(let dd of d.selling)
                    {
                        sF=(sF+(dd.profit*dd.quantity))
                    }
                tF=tF+sF

                }
                return tF
                
            },
            totalCost()
            {

                var tF=0
                for (let d of this.dataExpense)
                {
                    tF+=d.amount
                    console.log(tF)
                }

                for (let d of this.dataInvoice)
                {
                   if(d.bonus.length>0){
                       console.log("i have bonus")
                       for(let dp of d.bonus){
                               tF+=dp.amount
                                console.log(tF)
                       }
                   }
                }

                return (tF*(-1))
                
            },
            totalIncome()
            {

                var tF=0
                for (let d of this.dataIncome)
                {
                    tF+=d.amount
                    console.log(d.amount)
                }
                return (tF)
                
            },
            NetProfit()
            {

               let profit = (this.totalProfit-this.totalCost)+this.totalIncome
               return profit
                
            },

            totalSale()
            {

                var tF=0
                for (let d of this.searchData)
                {
                    tF=tF+d.totalPrice

                }
                return tF
                
            },
            totalNetProfitData(){
                
                    this.netProfitData[0].totalSalesAmount = this.totalSale.toFixed(2);
                    this.netProfitData[0].totalGrossProfit = this.totalProfit.toFixed(2);
                    this.netProfitData[0].totalIncome = this.totalIncome.toFixed(2);
                    this.netProfitData[0].totalExpense = this.totalCost.toFixed(2);
                    this.netProfitData[0].totalNetProfit = this.NetProfit.toFixed(2);

                    return this.netProfitData;
                
            },
            searchData()
            {
                if(this.filterCustomer && this.filterZone)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return (data.customerName.toUpperCase().match(this.filterCustomer.toUpperCase()) &&
                    data.customer.zone.toUpperCase().match(this.filterZone.toUpperCase()) ) 
                    &&
                    (
                    data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.totalQuantity.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
                     data.paidAmount.toString().match(this.search)
                    )            
                    }
                    );

                }
                else if(this.filterCustomer)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.customerName.toUpperCase().match(this.filterCustomer.toUpperCase()) &&
                    (
                        data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.totalQuantity.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
                     data.paidAmount.toString().match(this.search)
                    )

            
                    }
                    );

                }
                else if(this.filterZone)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.customer.zone.toUpperCase().match(this.filterZone.toUpperCase()) 
                    &&
                    (
                    data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.totalQuantity.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
                     data.paidAmount.toString().match(this.search)
                    )            
                    }
                    );

                }
                else{
                     return this.dataInvoice
                // return this.dataInvoice.filter((data)=>{                    
                //     return data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.id.toString().match(this.search) ||
                //      data.totalPrice.toString().match(this.search) ||
                //      data.totalQuantity.toString().match(this.search) ||
                //      data.discount.toString().match(this.search) ||
                //      data.paidAmount.toString().match(this.search)
        
                //     }
                // );

                }
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
            async rowSelect(k)
            {
                this.viewModal=true
                this.viewInvoice=k
                this.viewInvoice.profitPercentage=Math.round((this.viewInvoice.profitPrice*100)/this.viewInvoice.sellingPrice).toFixed(2)

                try{
                    let {data} =await  axios({
                        method: 'get',
                        url:`/app/sell/${this.viewInvoice.id}`,
                    })
                    this.viewSelling=data
                }catch(e){
                    this.e('1Oops!','Something went wrong, please try again!')
                }
            },
            async showPrint (index) {
                this.editModal=true
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
                        url:`/app/filterSaleNet/${k[0]}/${k[1]}`

                    })
                    //
                    for(let d of data.data){
                        d.adminName=d.admin.name
                        d.invoice_id="INV-SO-DG-"+d.id
                        d.costPrice=0
                        d.profitPrice=0
                        for(let dd of d.selling)
                        {
                            d.costPrice=(d.costPrice+((dd.unitPrice-dd.profit)*dd.quantity))
                            d.profitPrice=(d.profitPrice+(dd.profit*dd.quantity))
                        }
                        if(d.customer)
                        d.customerName=d.customer.customerName
                    }
                    //
                    this.dataInvoice=data.data
                    this.dataExpense=data.expense
                    this.dataIncome=data.income
                    this.lf();

                }catch(e){
                    this.e('2Oops!','Something went wrong, please try again!')
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
                    this.e('3Oops!','Something went wrong, please try again!')
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
            addProduct(k)
            {
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
                    this.e('4Oops!','Something went wrong, please try again!')
                    this.le();
                }
            },
            collapsedSider ()
            {
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
                        this.e('5Oops!','Something went wrong, please try again!')
                    }

                }
                
            },
            showEdit (index)
            {
                this.editObj.id=this.dataInvoice[index].id
                this.editObj.invoice_id=this.dataInvoice[index].invoice_id
                this.editObj.product_id=this.dataInvoice[index].product_id
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index)
            {
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
                    this.e('6Oops!','Something went wrong, please try again!')
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
                    this.e('7Oops!','Something went wrong, please try again!')
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
                    url:`/app/filterSaleNet/${date2}/${date2}` 

                })
                for(let d of data.data){
                    d.adminName=d.admin.namefilterSale
                    d.invoice_id="INV-SO-DG-"+d.id
                    d.costPrice=0
                    d.profitPrice=0
                    for(let dd of d.selling)
                    {
                        d.costPrice=(d.costPrice+((dd.unitPrice-dd.profit)*dd.quantity))
                        d.profitPrice=(d.profitPrice+(dd.profit*dd.quantity))
                    }
                    if(d.customer)
                    d.customerName=d.customer.customerName
                }
                this.dataInvoice=data.data
                this.dataExpense=data.expense
                this.dataIncome=data.income
                this.lf();

            }catch(e){
                this.e('8Oops!','Something went wrong, please try again!')
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
                this.e('9Oops!','Something went wrong, please try again!')
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
                this.e('99Oops!','Something went wrong, please try again!')
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
                this.e('88Oops!','Something went wrong, please try again!')
            this.le();
            }


            
        }

    }
</script>
<style scoped>
    th{
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px;
        text-align: left;
    }
    td {
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
.table {
  width: 100%;
  border-collapse: collapse;
}
.tabletitle {
  font-size: .7em;
  background: #EEE;
}
.tabletitleDown {
  font-size: .7em;
  background: #EEE;
  border-bottom: 1px solid #000;
}



.dropdown {
  position: relative;
  /* display: inline-block; */
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown:hover .dropbtn {background-color: #3e8e41;}

</style>