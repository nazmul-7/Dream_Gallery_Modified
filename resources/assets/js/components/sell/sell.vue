<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="14" offset="1">
                
                <Col span="11" offset="1">
                        <Input type="text" placeholder="Barcode" @on-enter="setData" 
                        v-model="formValue.barCode"></Input>  
                </Col>
                <h2>Product List</h2>

                <table style="width:100%" ref="printTable">
                  <tr>
                    <th>Name</th>
                    <th>Model</th>
                    <th>Color</th> 
                    <th>Size</th>
                    <th>Unit Price</th>
                    <th>Stock</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Action</th>

                  </tr>
                  <tr v-for="(data,i) in formValue.productDetails" :key="i">
                    <td >{{data.productName}}</td>
                    <td >{{data.model}}</td>
                    <td >{{data.color}}</td>
                    <td>{{data.size}}</td>
                    <td>{{data.sellingPrice}} <Tag  color="red" v-if="data.discount" type="border">-{{data.discount}}%</Tag></td>
                    <td>{{data.stock}}</td>
                    <td><InputNumber  :min="1" :max="data.stock" v-model="data.quantity" @on-change="quantityChange" ></InputNumber></td>
                    <td><InputNumber  v-model="data.discountedPrice*data.quantity" disabled></InputNumber></td>
                    <td><Button type="error" icon="ios-trash" @click="removeItem(i)"></Button></td>

                  </tr>

                  <tr style="background-color: #e9eaec;" >
                    <td colspan="6" style="text-align:right;">Sub Total </td>
                    <td >{{totalQuantity}}</td>
                    <td  colspan="2">{{totalPrice}}</td>
                    
                  </tr>
                <tr >
                    <td colspan="7" style="text-align:right">Discount</td>
                    <td  colspan="2"><InputNumber   :min="0" :max="100" @on-change="discount" v-model="formValue.discount"></InputNumber ></td>
                </tr>
                <tr >
                    <td colspan="7" style="text-align:right">Total</td>
                    <td  colspan="2"><InputNumber   :min="0" :max="parseInt(formValue.subTotal)" @on-change="total" v-model="formValue.total"></InputNumber ></td>
                </tr>
                <tr >
                    <td colspan="7" style="text-align:right">Paid Amount</td>
                    <td  colspan="2"><InputNumber  :min="0" :max="parseInt(formValue.total)"  v-model="formValue.paidAmount"></InputNumber></td>
                </tr>

                </table>

                <Col span="4"  offset="20">
                    <Button type="error" size="large"  @click="clearForm">
                        Clear
                    </Button>

                    <Button type="primary" size="large" :loading="sending" @click="makeSell">
                        <span v-if="!loading">Sell</span>
                        <span v-else>Loading...</span>
                    </Button>
                </Col>

            </Col>
            <Col class="dream-input-main" span="7" offset="1">
                <Row> 
                    <Form>
                        <Col span="22" offset="1">
                            <FormItem label="Customer">
                                <Select v-model="formValue.customer_id" placeholder="Customer"  :remote-method="changedCustomer" filterable>
                                    <Option v-for="(customer,i) in dataCustomer" :value="customer.id"  :key="i">{{customer.customerName}}</Option>
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
                        <Col span="22" offset="1">
                            <FormItem label="Reference">
                                <Select v-model="formValue.reference_id" placeholder="Number"  filterable>
                                    <Option v-for="(customer,i) in dataCustomer" :value="customer.id"  :key="i">{{customer.customerName}}</Option>
                                </Select>
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
                dataSearch:[],
                dataGroup:[],
                dataCustomer:[],
                dataInvoice: 
                [],
                currentCustomer:{
                    customerName:'',
                    number:'',
                    email:'',
                    address:'',
                    Outstanding:'',

                },
                formValue: {
                     type:'purchase',
                     date:'',
                     discount:0,
                     paidAmount:0.00,
                     subTotal:0,
                     subQuantity:0,
                     total:0.00,
                     supplier_id: '',
                     customer_id: '',
                     reference_id: '',
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

            
            totalQuantity()
            {
                var total=0
                for ( var i = 0; i < this.formValue.productDetails.length; i++) {
                        total+=parseInt(this.formValue.productDetails[i].quantity)   
                    }
                    return total   
            },
            
            totalPrice()
            {
                let sum = 0 
                for(let d of this.formValue.productDetails){
                    sum+= (parseInt(d.quantity)*parseInt(d.discountedPrice))
                }
                return sum
            },

        },
        methods: {
            removeItem(index)
            {
                
                this.formValue.productDetails.splice(index,1)
                this.quantityChange()
            },
            quantityChange()
            {
                
                var totalPrice=0
                for ( let d of this.formValue.productDetails) {                  
                        totalPrice+=(d.quantity*d.discountedPrice)
                    }
                totalPrice=Math.round(totalPrice).toFixed(2)
                this.formValue.total=parseFloat(totalPrice)
                this.formValue.paidAmount=parseFloat(totalPrice)
                this.formValue.subTotal=parseFloat(totalPrice)

  
            },
            discount(){
                var totalOld = this.formValue.subTotal
                var discountAmount = (this.formValue.discount*this.formValue.subTotal)/100
                var afterDiscount = totalOld - discountAmount
                
                afterDiscount= Math.round(afterDiscount).toFixed(2)*1

                console.log(afterDiscount);
                
                this.formValue.total=afterDiscount
                this.formValue.paidAmount=afterDiscount
            },
            total(){
                var totalOld = this.formValue.subTotal
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
            async addProduct(k){
                if(this.searchValue)
                {
                    for ( var i = 0; i < this.formValue.productDetails.length; i++) {
                        if(this.dataSearch[k].id==this.formValue.productDetails[i].id)
                        {
                            this.formValue.productDetails[i].quantity++
                            this.quantityChange()
                            return
                        }
                    
                    }
            
                    try{
                        let {data} =await axios({
                            method: 'get',
                            url:`/app/getStock/${this.dataSearch[k].id}`,
                            })
                            
                            this.lf()
                            console.log(data)
                            for ( var i = 0; i < this.dataGroup.length; i++) {
                                if(this.dataSearch[k].groupName==this.dataGroup[i].groupName)
                                {
                                    this.dataSearch[k].discount=this.dataGroup[i].discount                                
                                }
                            
                            }
                            this.dataSearch[k].stock=data.data
                            this.dataSearch[k].quantity=1
                            this.formValue.productDetails.push(this.dataSearch[k])
                            
                            
                            this.searchValue=''

                        }catch(e){
                            this.e('Oops!','Something went wrong, please try again!')
                            this.le()
                            return 0
                        }
                
                    
                }
                  
            },
            async changedCustomer(k)
            {
                console.log(k);
                console.log(this.formValue.customer_id);
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/payment/getOutstandingCustomer/${this.formValue.customer_id}`
                })
                this.setCustomer(this.formValue.customer_id)
                this.currentCustomer.outStanding=Math.abs(data.outStanding)

                this.lf();
                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }

            },
            setCustomer(id)
            {
                var i=0

                while (i < this.dataCustomer.length) {
                    if (this.dataCustomer[i].id == id) {
                        this.currentCustomer.customerName=this.dataCustomer[i].customerName
                        this.currentCustomer.number=this.dataCustomer[i].contact
                        this.currentCustomer.address=this.dataCustomer[i].address
                        this.currentCustomer.email=this.dataCustomer[i].email
                    }
                    i++;
                }
                
            },
            async setData()
            {
                if(this.formValue.barCode)
                {
                    for(let d of this.formValue.productDetails)
                    {
                        if(d.barCode == this.formValue.barCode){
                            if(d.stock==d.quantity){
                                return this.i('You have acceded the available stock')
                            }
                            d.quantity++
                            this.quantityChange()
                             return 

                            }
                        }

                    
                }
                try{
                let {data} =await axios({
                    method: 'get',
                    url:`/app/searchProduct/${this.formValue.barCode}`,
                    })
                    let ps=0,ss=0
                    if(data.purchase_stock.stock){
                        ps=data.purchase_stock.stock
                        
                    }

                    if(data.sell_stock){
                        console.log('IU am')
                        ss=data.sell_stock.stock
                    }


                    data.stock=ps-ss
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
                   }

                    let disco

                    this.formValue.productDetails.push(data)
                    this.quantityChange()
                    this.lf();

                }catch(e){
                    console.log(0)
                    this.e('Oops!','Something went wrong, please try again!')
                    this.le();
                }
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            makeSell()
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
                this.sellProduct ()
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
                    this.loading=true
                    try{
                        let {data} =await  axios({
                            method: 'post',
                            url:'/app/sell',
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
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/group'
                })
                this.dataGroup=data;
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
