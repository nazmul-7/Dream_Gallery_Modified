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
                  <p class="memu_thanks_text">Thank you for shopping with </br>{{shopData.companyName}}</br> Please visit www.dreamsgallerybd.com for Home Delivery. Purchase of Defected item must be exchanged by 24 hours with invoice.</p>
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
                index:0,
                sellResponse:[],
                sellResponseId:0,
                toDayDate:new Date(),
                searchValue:'',
                tempBarcode:'',
                height: 25,
                clearModel:false,
                loading:false,
                sending:false,
                homeDelivery:false,
                
                editModal:false,
                isCollapsed: false,
                
                dataSearch:[],
                tempCustomerInof:null,
                tempReferencerInfo:null,
                dataGroup:[],
                dataZone:[],
                dataCustomer:[],
                dataReferencer:[],
                shopData:[],
                dataInvoice: 
                [],
                currentCustomer:{
                    id:1,
                    customerName:'',
                    number:'',
                    email:'',
                    address:'',
                    Outstanding:'',
                    barcode:'',
                    delivery: 0,
                    zone:'SYLHET',
                    bonusAmount:null,
                    status:false


                },
                currentReferenceInfo:{
                    customerName:'',
                    number:'',
                    email:'',
                    address:'',
                    Outstanding:'',
                    barcode:'',
                    bonusAmount:null,
                    status:false
                },
                temp:{
                   
                },
                columns1: [ 
                    {
                        title: 'Item Name',
                        key: 'productName'
                    },

                    {
                        title: 'Color',
                        key: 'color',
                    },

                ],
                formValue: {
                     type:'sell',
                     date:'',
                     barcode:'',
                     discount:0,
                     paidAmount:0.00,
                     subTotal:0,
                     subQuantity:0,
                     total:0.00,
                     supplier_id: '',
                     customer_id: null,
                     reference_id: '',
                     productDetails: [],
                     cashPaid:0,
                     bonusAmount:0
                },
                // options2: {
                //         shortcuts: [
                //             {
                //                 text: '1 week',
                //                 value () {
                //                     const end = new Date();
                //                     const start = new Date();
                //                     start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                //                     return [start, end];
                //                 }
                //             },
                //             {
                //                 text: '1 month',
                //                 value () {
                //                     const end = new Date();
                //                     const start = new Date();
                //                     start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                //                     return [start, end];
                //                 }
                //             },
                //             {
                //                 text: '3 months',
                //                 value () {
                //                     const end = new Date();
                //                     const start = new Date();
                //                     start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                //                     return [start, end];
                //                 }
                //             }
                //         ]
                //     },
                temp:{},

               
            }
            
        },
        computed: {
            options() {
              return {
                height: this.height,
                 displayValue: false,
              }
            },

            changeAmount()
            {
                if(this.formValue.cashPaid)
                    return (this.formValue.cashPaid-this.formValue.paidAmount)
                else
                    return 0

            },
            flterMemberList(){
                    return this.dataCustomer.filter((data)=>{
                    return data.id != 1;
                        }
                    );

                    

            },
            flterReferencerList(){
                    return this.dataReferencer.filter((data)=>{
                        return this.formValue.customer_id ? data.id != this.formValue.customer_id : data.id != 0;
                   
                        }
                    );    

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

            
            totalQuantity()
            {
                var total=0
                if(this.formValue.productDetails)
                {
                    for ( var i = 0; i < this.formValue.productDetails.length; i++)
                    {
                        total+=parseInt(this.formValue.productDetails[i].quantity)   
                    }

                }
                return total   
            },
            
            totalPrice()
            {
                let sum = 0 
                if(this.formValue.productDetails)
                {
                    for(let d of this.formValue.productDetails)
                    {
                        sum+= (parseInt(d.quantity)*parseInt(d.discountedPrice))
                    }
                    this.formValue.totalTotal=sum
                }
                return sum
            },

        },
        methods: {
            bonusChange()
            {
                console.log(this.formValue.bonusAmount)
                this.quantityChange()

            },
            paidAmountChange()
            {
                this.formValue.cashPaid=this.formValue.paidAmount

            },
            async showPrint (index) {
                this.editModal=true
                await new Promise(resolve => setTimeout(resolve, 500));
                // console.log("Print")
                window.print();
            },
            removeItem(index)
            {
                this.formValue.productDetails.splice(index,1)
                this.quantityChange()
            },
            quantityChange()
            {
                let totalRealPrice=0;
                var totalPrice=0
                for ( let d of this.formValue.productDetails) {                  
                        totalPrice+=(d.quantity*d.discountedPrice)
                        totalRealPrice+=(d.quantity*d.sellingPrice)
                    }
                totalPrice=Math.round(totalPrice-(this.formValue.bonusAmount+0)).toFixed(2)
                this.formValue.total=parseFloat(totalPrice)
                this.formValue.paidAmount=parseFloat(totalPrice)
                this.formValue.subTotal=parseFloat(totalRealPrice)
                this.paidAmountChange()
            },
            discount(){
                var totalOld = this.formValue.subTotal
                var discountAmount = (this.formValue.discount*this.formValue.subTotal)/100
                var afterDiscount = totalOld - discountAmount
                afterDiscount= Math.round(afterDiscount-(this.formValue.bonusAmount+0)).toFixed(2)*1

                console.log(afterDiscount);
                
                this.formValue.total=afterDiscount
                this.formValue.paidAmount=afterDiscount
                this.paidAmountChange()
        },
            total(){
                var totalOld = this.formValue.subTotal
                var discountAmount = totalOld - this.formValue.total
                var discount = (discountAmount*100)/totalOld
                discount= Math.round(discount).toFixed(2)
                this.formValue.discount=parseInt(discount)
                this.formValue.paidAmount=parseFloat(this.formValue.total)
                this.paidAmountChange()
            },
            showClear()
            {
                this.clearModel=true
            },
            clearForm()
            {
                console.log('clear')
                this.dataReferencer=[];
                this.dataCustomer=[];
                this.tempCustomerInof = null;
                this.tempReferencerInfo= null;
                this.formValue.discount=0
                this.formValue.paidAmount=0.00
                this.formValue.subTotal=0
                this.formValue.subQuantity=0
                this.formValue.total=0.00
                this.formValue.cashPaid=0
                this.formValue.bonusAmount=0
                this.formValue.supplier_id=''
                this.formValue.customer_id=''
                this.formValue.reference_id=''
                this.formValue.productDetails.splice(0,this.formValue.productDetails.length)
                this.currentCustomer={}
                this.currentReferenceInfo={}
                this.editModal=false
                const start = new Date();
                this.formValue.date=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
                

            },
             clearPrint()
            {
                console.log('clear')

                // this.temp.date=''
                // this.temp.discount=0
                // this.temp.paidAmount=0
                // this.temp.subTotal=0
                // this.temp.subQuantity=0
                // this.temp.supplier_id=0
                // this.temp.customer_id=0
                // this.temp.reference_id=0
                // this.temp.total=0
                // this.temp.cashPaid=0
                // this.temp.barCode=''
                // this.temp.productDetails=[]

            },
            dateConverter(key)
            {
                this.formValue.date=key

            },

            async changedCustomerV2(e){

                if(!this.tempCustomerInof){
                    this.dataCustomer=[];
                    
                    return;
                }

                if (e.keyCode === 13){
                    console.log('Enterkey');
                    const res = await this.callApi('get', `/app/customerInfoOnEnter/${this.tempCustomerInof}`);
                    if(res.status==200){
                        console.log("res Data: ")
                        console.log(res.data)
                        this.changedCustomer(res.data);
                    }
                    else{
                        console.log("Something went wrong");
                    }
                }
                else{
                    console.log("OtherKey");

                    const res = await this.callApi('get', `/app/customerInfo/${this.tempCustomerInof}`);
                    console.log(res.data)
                    if(res.status==200){

                        this.dataCustomer=res.data;
                    }
                    else{
                        console.log("Something went wrong");
                    }
                }
            },

            async changedCustomer(customerPass){
               
                
                this.tempCustomerInof=customerPass.customerName;
               
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/payment/getOutstandingCustomer/${customerPass.id}`
                })
                
                this.setCustomer(customerPass)
                console.log(data)
              //  this.setCustomer(this.formValue.customer_id)

                
                this.currentCustomer.outStanding=Math.abs(data.outStanding)
                 console.log(" i am running ChangeCustomer")
                if(data.ledger[0].customer.barcode)
                {
                 //   console.log(data.ledger[0])
                    this.formValue.discount=10
                    this.currentCustomer.bonusAmount=data.bonus
                    this.currentCustomer.status=true
                }
                else
                {
                  //  console.log(data.ledger[0])
                    this.currentCustomer.status=false
                }
                
                this.lf();
                }catch(e){
                    this.e('(1)Oops!','Something went wrong, please try again!')
                this.le();
                }

                this.discount()


            },
            async enterChangedCustomer(k){
                if(!k)
                {
                    this.formValue.customer_id=null
                    return
                }
                if(this.formValue.customer_id==1)
                {
                    this.currentCustomer={}
                    return

                }

                console.log(k);
                console.log("id "+this.formValue.customer_id);
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/payment/getOutstandingCustomer/${this.formValue.customer_id}`
                })
                this.setCustomer(this.formValue.customer_id)
                this.currentCustomer.outStanding=Math.abs(data.outStanding)
                if(data.ledger[0].customer.barcode)
                {
                    console.log(data.ledger[0])
                    this.formValue.discount=10
                    this.currentCustomer.bonusAmount=data.bonus
                    this.currentCustomer.status=true
                }
                else
                {
                    console.log(data.ledger[0])
                    this.currentCustomer.status=false
                }

                this.lf();
                }catch(e){
                    this.e('(2)Oops!','Something went wrong, please try again!')
                this.le();
                }

                this.discount()


            },
            async changedReferenceV2(e){

                if(!this.tempReferencerInfo){
                    this.dataReferencer=[];
                    
                    return;
                }

                if (e.keyCode === 13){
                    console.log('Enterkey');
                    const res = await this.callApi('get', `/app/referencerInfoOnEnter/${this.tempReferencerInfo}`);
                    if(res.status==200){
                        console.log("res Data: ")
                        console.log(res.data)
                        this.changedReference(res.data);
                    }
                    else{
                        console.log("Something went wrong");
                    }
                }
                else{
                    console.log("OtherKey");

                    const res = await this.callApi('get', `/app/referencerInfo/${this.tempReferencerInfo}`);
                    console.log(res.data)
                    if(res.status==200){

                        this.dataReferencer=res.data;
                    }
                    else{
                        console.log("Something went wrong");
                    }
                }


            },
            async changedReference(referencerPass)
            {
                
                
                this.formValue.reference_id=referencerPass.id;
                this.tempReferencerInfo = referencerPass.customerName
                console.log(this.formValue.reference_id);
                console.log(referencerPass);
                this.setReferencer(referencerPass);
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/payment/getOutstandingCustomer/${this.formValue.reference_id}`
                })
                this.lf();
                }catch(e){
                    this.e('(1)Oops!','Something went wrong, please try again!')
                this.le();
                }
                if(this.formValue.discount<10)
                this.formValue.discount=this.shopData.referenceBonus
                this.discount()


            },
            setCustomer(customerPass){
                // var i=0

                // while (i < this.dataCustomer.length) {
                //     if (this.dataCustomer[i].id == id) {
                //         this.currentCustomer.customerName=this.dataCustomer[i].customerName
                //         this.currentCustomer.number=this.dataCustomer[i].contact
                //         this.currentCustomer.address=this.dataCustomer[i].address
                //         this.currentCustomer.email=this.dataCustomer[i].email
                //         this.currentCustomer.barcode=this.dataCustomer[i].barcode
                //     }
                //     i++;
                // }
                console.log(" i am customer Pass");
                this.formValue.customer_id=customerPass.id
                this.currentCustomer.customerName=customerPass.customerName
                this.currentCustomer.zone=customerPass.zone
                this.currentCustomer.id=customerPass.id
                
                this.currentCustomer.number=customerPass.contact
                this.currentCustomer.delivery=customerPass.zone_info.delivery
                this.currentCustomer.address=customerPass.address
                this.currentCustomer.email=customerPass.email
                this.currentCustomer.barcode=customerPass.barcode
                
            },
            setReferencer(referencerPass){

                console.log("i am here")
                        
                this.currentReferenceInfo.customerName=referencerPass.customerName
                this.currentReferenceInfo.number=referencerPass.contact
                this.currentReferenceInfo.address=referencerPass.address
                this.currentReferenceInfo.email=referencerPass.email
                this.currentReferenceInfo.barcode=referencerPass.barcode
                
            },
            async setData()
            {   this.formValue.barCode = this.temp.Barcode
                console.log('i am calling '+this.temp.Barcode )

                delete this.temp.Barcode;
                
                if(this.formValue.barCode)
                {   
                    if(this.formValue.productDetails)
                    {
                    for(let d of this.formValue.productDetails)
                    {
                        if(d.barCode == this.formValue.barCode){
                            if(d.stock==d.quantity){
                                this.formValue.barCode=null
                    
                                return this.i('You have crossed the available stock')
                                
                            }
                            d.quantity++
                            console.log(" i am from already barcode")
                            this.formValue.barCode=''
                           // this.formValue.barCode=null
                            this.quantityChange()
                            
                             return 

                            }
                        }
                    }
                    
                }
                try{
                let {data} =await axios({
                    method: 'get',
                    url:`/app/searchProduct/${this.formValue.barCode}`,
                    })
                    let ps=0,ss=0
                    console.log(data)
                    if(data.purchase_stock){
                        ps=data.purchase_stock.stock
                        
                    }
                    else
                    {
                    this.e('Oops!','No Purchase Stock')
                    this.formValue.barCode=null
                    return
                    }


                    if(data.sell_stock){
                        ss=data.sell_stock.stock
                    }
                    data.stock=ps-ss
                    if(data.stock==0)
                    {
                        this.e('Oops!','No stock avalaible, please try again!')
                        this.formValue.barCode=null
                        return;
                    }
                    data.quantity=1
                    for(let d of this.dataGroup){
                        if(d.groupName==data.groupName){
                            data.discount=d.discount
                        }
                    }
                   if(data.discount){
                        let d= (data.discount*data.sellingPrice)/100
                        data.discountedPrice= data.sellingPrice-d
                   }else{
                         data.discountedPrice= data.sellingPrice
                         data.discount=0
                   }

                    this.formValue.productDetails.push(data)
                    this.quantityChange()
                    this.lf();
                    this.formValue.barCode=null

                }catch(e){
                    console.log(0)
                    this.e('Oops!','Something went wrong, please try again!')
                    this.le();
                }
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            
            makeSell(){
                
                if(Math.round(this.formValue.paidAmount) != Math.round(this.formValue.total) )
                {
                    this.i('Due Alart','This invoice will add due amount')
                    if(!this.formValue.customer_id)
                    {
                        this.w('Customer','Plaease Add a Csutomer')
                        return                         
                    }

                }
                this.sellProduct ()
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            async sellProduct (){
                //invoice added
                this.formValue.totalQuantity=this.totalQuantity
                this.formValue.totalPrice=this.formValue.subTotal
                if( !this.formValue.totalQuantity || !this.formValue.totalPrice)
                {
                    this.loading=false
                    this.e('Oops!','You nedd to enter Stock and Price in All Fields')

                }
                else
                {
                    this.loading = true
                    try{
                        let {data} =await  axios({
                            method: 'post',
                            url:'/app/sell',
                            data: this.formValue
                        })
                        
                        this.s('Great!','Sell has been added successfully!')
                        this.loading=false
                        this.sellResponse = data.data
                        this.sellResponseId =  this.sellResponse.id
                        this.showPrint(1);
                        // this.temp=[...this.formValue]
                        // this.clearForm();
                    }catch(e){
                        this.loading=false
                        this.e('Oops!','4Something went wrong, please try again!')
                    }

                }
            },

        },
        async created(){
            this.$store.dispatch('updateHeader','Sale');
            let nd = new Date(this.toDayDate)
			this.toDayDate = `${nd.getFullYear()}-${nd.getMonth()+1}-${nd.getDate()}`
                
            this.ls();
            const start = new Date();
            this.formValue.date=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
            // try{
            //     let {data} =await  axios({
            //         method: 'get',
            //         url:'/app/customer'
            //     })
            //     this.dataCustomer=data;
            //     this.lf();

            // }catch(e){
            //     this.e('Oops!','5Something went wrong, please try again!')
            // this.le();
            // }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/group'
                })
                this.dataGroup=data;
                this.lf();

            }catch(e){
                this.e('Oops!','6Something went wrong, please try again!')
            this.le();
            }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/setting'
                })
                this.shopData=data
                this.logo=data.companyLogo
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

           
          //  console.log( this.dataZone[this.dataZone.indexOf("SYLHET")])
           // console.log( this.dataZone.indexOf("SYLHET"))

        },

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