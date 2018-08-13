<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="16" offset="1">

                        <Col span="11" offset="1">

                                 <Input type="text" placeholder="Barcode" @on-enter="setData" 
                                v-model="formValue.barCode"></Input>  

                        </Col>
                        <!-- <Col span="11" offset="1">
                            <FormItem  label="Search Product">
                                <br>
                                <Row>
                                    <Col span="22">
                                        <AutoComplete v-model="searchValue" icon="ios-search" placeholder="input here"  @on-search="setData" @on-select="addProduct">
                                                <Option v-for="(option,i) in dataSearch" :value="i" :key="i">
                                                    <span class="demo-auto-complete-title">{{ option.id }}</span>
                                                    <span class="demo-auto-complete-count">| {{option.paidAmount}}</span>
                                                </Option>

                                        </AutoComplete>
                                    </Col>
                                </Row>
                            </FormItem >
                        </Col> -->


                <h2>Product List</h2>

                <table style="width:100%">
                  <tr>
                    <th>Name</th>
                    <th>Model</th>
                    <th>Color</th> 
                    <th>Size</th>
                    <th>Unit Price</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Return</th>
                  </tr>
                  <tr v-for="(data,i) in formValue.productDetails" :key="i">
                    <td >{{data.product.productName}}</td>
                    <td >{{data.product.model}}</td>
                    <td >{{data.product.color}}</td>
                    <td>{{data.product.size}}</td>
                    <td>{{data.unitPrice}}<Tag  color="red" v-if="data.discount" type="border">-{{data.discount}}%</Tag></td>
                    <td><InputNumber :min="0" :max="data.stock" v-model="data.quantity" @on-change="quantityChange"></InputNumber></td>
                    <td><input type="number" v-model="data.discountedPrice*data.quantity" disabled></input></td>
                    <td><Button type="error" icon="ios-trash" @click="removeItem(i)"></Button></td>
                  </tr>

                  <tr style="background-color: #e9eaec;" >
                    <td colspan="6" style="text-align:right;">Sub Total </td>
                    <td >{{formValue.totalQuantity}}</td>
                    <td >{{formValue.subTotal}}</td>
                    
                  </tr>
                <tr >
                    <td colspan="7" style="text-align:right">Discount</td>
                    <td><InputNumber  v-if="formValue.subTotal>0"  :min="0" :max="100" @on-change="discount" v-model="formValue.discount"></InputNumber ></td>
                </tr>
                <tr >
                    <td colspan="7" style="text-align:right">Total</td>
                    <td><InputNumber v-if="formValue.total>0"  :min="0" :max="formValue.subTotal" @on-change="total" v-model="formValue.total"></InputNumber ></td>
                </tr>
                <tr >
                    <td colspan="7" style="text-align:right">Paid Amount</td>
                    <td><InputNumber  v-if="formValue.subTotal>0"  v-model="formValue.paidAmount"></InputNumber></td>
                </tr>

                </table>
                <Col span="4"  offset="20">
                    <Button type="error" size="large"  @click="showClear">
                        Clear
                    </Button>

                    <Button type="primary" size="large" :loading="sending" @click="makeReturn">
                        <span v-if="!loading">Update Sell</span>
                        <span v-else>Loading...</span>
                    </Button>
                </Col>

            </Col>
            <Col class="dream-input-main" span="5" offset="1">
                <Row> 
                    <Form>
                        <Col span="22" offset="1">
                            <FormItem label="Supplier">
                                <Select v-model="formValue.customer_id" placeholder="Supplier" filterable>
                                    <Option v-for="(customer,i) in dataCustomer" :value="customer.id" :key="i">{{customer.customerName}}</Option>
                                </Select>
                            </FormItem>
                        </Col>
                        <Col span="22" offset="1">
                            <FormItem  label="Buying Date">
                                <br>
                                <Row>
                                    <Col span="22">
                                        <DatePicker type="date" @on-change="dateConverter" placeholder="Select date"></DatePicker>
                                    </Col>
                                </Row>
                            </FormItem>
                        </Col>
                    </Form>
                </Row>
            </Col>
        </Row>
    </div>
</template>

<script>
    export default {
        data () {
            return {
                index:0,
                searchValue:'',
                clearModel:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                dataSearch:{},
                dataCustomer:[],
                dataInvoice: 
                [],
                formValue: {
                     type:'purchase',
                     date:'',
                     discount:0,
                     paidAmount:0,
                     subTotal:0,
                     subQuantity:0,
                     total:0,
                     supplier_id: '',
                     customer_id: '',
                     productDetails: []
                },
               
            }
            
        },
        computed: {

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
            // totalPrice()
            // {
            //     var totalPrice=0
            //     for ( var i = 0; i < this.formValue.productDetails.length; i++) {
                  
            //             totalPrice+=this.formValue.productDetails[i].quantity*this.formValue.productDetails[i].unitPrice
            //         }
            //     totalPrice=Math.round(totalPrice).toFixed(2)
            //     this.formValue.total=totalPrice
            //     this.formValue.paidAmount=totalPrice
            //     this.formValue.subTotal=totalPrice
            //     return totalPrice;
                
            // },
            // totalQuantity()
            // {
            //     var total=0
            //     for ( var i = 0; i < this.formValue.productDetails.length; i++) {
            //             total+=parseInt(this.formValue.productDetails[i].quantity)   
            //         }
            //         return total   
            // },
            

        },
        methods: {
            removeItem(index)
            {
                this.formValue.productDetails[index].quantity=0
                this.quantityChange()
            },
            quantityChange()
            {
                
                var totalPrice=0,totalQuantity=0
                for ( let d of this.formValue.productDetails) {
                        totalQuantity+=parseInt(d.quantity)               
                        totalPrice+=(d.quantity*d.discountedPrice)
                    }
                totalPrice=Math.round(totalPrice).toFixed(2)
                this.formValue.totalQuantity=totalQuantity
                this.formValue.total=parseFloat(totalPrice)
                this.formValue.paidAmount=parseFloat(totalPrice)
                this.formValue.subTotal=parseFloat(totalPrice)
                this.discount()

  
            },
            discount(){
                var totalOld = this.formValue.subTotal
                var discountAmount = (this.formValue.discount*this.formValue.subTotal)/100
                var afterDiscount = totalOld - discountAmount
                afterDiscount= Math.round(afterDiscount).toFixed(2)
                this.formValue.total=afterDiscount
                this.formValue.paidAmount=afterDiscount
            },
            total(){
                var totalOld = this.totalPrice
                var discountAmount = totalOld - this.formValue.total
                var discount = (discountAmount*100)/totalOld
                discount= Math.round(discount).toFixed(2)
                this.formValue.discount=discount
                this.formValue.paidAmount=this.formValue.total
            },
            showClear()
            {
                this.clearModel=true
            },
            clearForm()
            {
                this.formValue= []
                this.clearModel=false

            },
            dateConverter(key)
            {
                this.formValue.date=key

            },
            async addProduct(){
                if(this.dataSearch)
                {
                    console.log(this.dataSearch.id)
            
                    try{
                        let {data} =await axios({
                            method: 'get',
                            url:`/app/getInvoiceProducts/${this.dataSearch.id}`,
                            })
                            
                            this.lf()
                            console.log(data)
                            for (let c of data.data)
                            {
                                c.stock=c.quantity
                                console.log(111);
                                if(c.discount){
                                let d= (c.discount*c.unitPrice)/100
                                c.discountedPrice= c.unitPrice-d
                                }else{
                                        c.discountedPrice= c.unitPrice
                                }
                            }
                            this.formValue.invoice_id=this.dataSearch.id
                            this.formValue.productDetails=data.data
                            this.formValue.subTotal=this.dataSearch.totalPrice
                            this.formValue.totalQuantity=this.dataSearch.totalQuantity
                            this.formValue.paidAmount=this.dataSearch.paidAmount
                            this.formValue.total=this.dataSearch.sellingPrice
                            this.formValue.discount=this.dataSearch.discount
                            this.formValue.date=this.dataSearch.date
                            this.formValue.barCode=''
                        }catch(e){
                            this.e('Oops!','Something went wrong, please try again!')
                            this.le()
                            return 0
                        }
                
                    
                }
                
                
            },
            async setData()
            {
                if(this.formValue.barCode)
                {
                    try{
                    let {data} =await axios({
                        method: 'get',
                        url:`/app/searchInvoice/${this.formValue.barCode}`,
                        })
                        this.dataSearch=data;
                        this.addProduct()
                        this.lf();

                    }catch(e){
                        this.e('Oops!','Something went wrong, please try again!')
                        this.le();
                    }
                }
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            
            makeReturn()
            {
                if(Math.round(this.formValue.paidAmount) != Math.round(this.formValue.total) )
                {
                    this.i('Due Alart','This invoice will add due amount')
                    if(!this.formValue.customer_id)
                    {
                        this.w('Customer','Plaease Add a Csutomer')
                        return                         
                    }

                }
                this.returnProduct ()
            },
            async returnProduct (){
                //invoice added
                if( !this.totalQuantity || !this.totalPrice)
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
                            url:'/app/returnInvoice',
                            data: this.formValue
                        })
                        
                        this.s('Great!','Sell has been added successfully!')
                        this.loading=false
                    }catch(e){
                        this.loading=false
                        this.e('Oops!','Something went wrong, please try again!')
                    }

                }
                
            },

        },
        async created()
        {
            this.ls();
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
