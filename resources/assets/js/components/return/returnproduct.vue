<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="14" offset="1">
                <Row>
                    <Col span="24" >
                        <Card>
                                <Row  :gutter="24">
                                    
                                        <Col span="12">
                                        <p>Invoice Code</p>
                                            <Input type="text" placeholder="Barcode" @on-enter="setData" 
                                            v-model="formValue.barCode"></Input>  
                                        </Col>
                                        <Col span="12">
                                        <p>Product Code</p>
                                            <Input type="text" placeholder="Barcode" @on-enter="addNewSale" 
                                            v-model="formValue.productCode"></Input>  
                                        </Col>
                                    </Row>
                        </Card>
                    </Col>
                    <Col span="24">
                        <Card>
                            <p slot="title">Product List</p>
                            
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
                                <tr v-for="(data,i) in formValue.newProduct" :key="i">
                                    <td >{{data.productName}}</td>
                                    <td >{{data.model}}</td>
                                    <td >{{data.color}}</td>
                                    <td>{{data.size}}</td>
                                    <td>{{data.sellingPrice}}<Tag  color="red" v-if="data.discount" type="border">-{{data.discount}}%</Tag></td>
                                    <td><InputNumber :min="0" :max="data.stock" v-model="data.quantity" @on-change="quantityChange"></InputNumber></td>
                                    <td><input type="number" v-model="data.discountedPrice*data.quantity" disabled></input></td>
                                    <td><Button type="error" icon="ios-trash" @click="removeItemNew(i)"></Button></td>
                                </tr>
                                <tr style="background-color: #e9eaec;" >
                                    <td colspan="5" style="text-align:right;">Sub Total </td>
                                    <td >{{formValue.totalQuantity}}</td>
                                    <td colspan="2">{{formValue.subTotal}}</td>
                                    
                                </tr>
                                <tr v-if="formValue.oldTotal>0">
                                    <td colspan="7" style="text-align:right">Previous Paid Amound</td>
                                    <td><InputNumber  :min="0" :max="formValue.oldTotal" @on-change="total" v-model="formValue.oldTotal"></InputNumber ></td>
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
                            <Col>
                                <Button type="error" size="large"  @click="showClear">
                                    Clear
                                </Button>

                                <Button type="primary" size="large" :loading="sending" @click="makeReturn">
                                    <span v-if="!loading">Update Sell</span>
                                    <span v-else>Loading...</span>
                                </Button>
                            </Col>
                        </Card>
                    </Col>
                </Row>
            </Col>

                <Col span="7" offset="1">
                    <Row> 
                        <Col class="dream-input-main" span="22" offset="1">
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
                        <Col class="dream-input-main" span="22" offset="1">
                            <Row> 
                                <Form>
                                    <Col span="22" offset="1">
                                        <Button type="error" size="large"  @click="returnAll" long>
                                            Return All
                                        </Button>
                                    </Col>
                                </Form>
                            </Row>
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
                dataSearch:{},
                dataCustomer:[],
                dataInvoice: 
                [],
                formValue: {
                     type:'purchase',
                     date:'',
                     discount:0,
                     oldTotal:0,
                     paidAmount:0,
                     subTotal:0,
                     subQuantity:0,
                     total:0,
                     supplier_id: '',
                     customer_id: '',
                     productDetails: [],
                     newProductFlag: true,
                     newProduct: [],
                     productCode:''
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
            async returnAll()
            {
                
                    try{
                    let {data} =await axios({
                        method: 'get',
                        url:`/app/returnAll/${this.formValue.invoice_id}`,
                        })
                        this.s('Success!')
                        this.lf();

                    }catch(e){
                        this.e('Oops!','Something went wrong, please try again!')
                        this.le();
                    }
                this.clearData()
            },
            async addNewSale()
            {
               

                if(this.formValue.productCode)
                {
                    if(this.formValue.newProduct)
                    {
                    for(let d of this.formValue.newProduct)
                    {
                        if(d.barCode == this.formValue.productCode){
                            if(d.stock==d.quantity){
                                return this.i('You have acceded the available stock')
                            }
                            d.quantity++
                            this.quantityChange()
                            this.formValue.productCode=null
                             return 

                            }
                        }
                    }
                    
                }
                try{
                let {data} =await axios({
                    method: 'get',
                    url:`/app/searchProduct/${this.formValue.productCode}`,
                    })
                    let ps=0,ss=0
                    console.log(data)
                    if(data.purchase_stock){
                        ps=data.purchase_stock.stock
                        
                    }
                    else
                    {
                    this.e('Oops!','No Purchase Stock')
                    return
                    }


                    if(data.sell_stock){
                        console.log('11')
                        ss=data.sell_stock.stock
                    }
                    data.stock=ps-ss
                    data.quantity=1
                    for(let d of this.dataGroup){
                        console.log('12')
                        if(d.groupName==data.groupName){
                        console.log('22')
                            data.discount=d.discount
                        }
                    }
                   if(data.discount){
                        console.log('33')
                        let d= (data.discount*data.sellingPrice)/100
                        data.discountedPrice= data.sellingPrice-d
                   }else{
                        console.log('44')
                         data.discountedPrice= data.sellingPrice
                         data.discount=0
                   }

                    this.formValue.newProduct.push(data)
                    this.quantityChange()
                    this.lf();
                    this.formValue.productCode=null

                }catch(e){
                    this.e('Oops!','3Something went wrong, please try again!')
                    this.le();
                }

            },
            removeItem(index)
            {
                this.formValue.productDetails[index].quantity=0
                this.quantityChange()
            },
            removeItemNew(index)
            {
                 this.formValue.newProduct.splice(index,1)
                this.quantityChange()
            },
            quantityChange()
            {
                if(this.formValue.newProductFlag)
                {
                this.formValue.oldTotal=this.formValue.paidAmount
                this.formValue.newProductFlag=false

                }
                
                var totalPrice=0,totalQuantity=0,totalQuantityN=0,totalPriceN=0
                for ( let d of this.formValue.productDetails) {
                        totalQuantity+=parseInt(d.quantity)               
                        totalPrice+=(d.quantity*d.discountedPrice)
                    }
                for ( let d of this.formValue.newProduct) {
                        totalQuantityN+=parseInt(d.quantity)               
                        totalPriceN+=(d.quantity*d.discountedPrice)
                    }
                totalPrice=Math.round(totalPrice+totalPriceN).toFixed(2)
                this.formValue.totalQuantity=Math.round(totalQuantity+totalQuantityN).toFixed(2)
                this.formValue.total=parseFloat(totalPrice)
                this.formValue.paidAmount=parseFloat(totalPrice-this.formValue.oldTotal)
                this.formValue.subTotal=parseFloat(totalPrice)
                this.discount()

  
            },
            discount(){
                var totalOld = this.formValue.subTotal
                var discountAmount = (this.formValue.discount*this.formValue.subTotal)/100
                var afterDiscount = totalOld - discountAmount
                afterDiscount= Math.round(afterDiscount).toFixed(2)
                this.formValue.total=parseFloat(afterDiscount)
                this.formValue.paidAmount=parseFloat(afterDiscount-this.formValue.oldTotal)
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
            clearData()
            {
                this.formValue.invoice_id=''
                this.formValue.productDetails=[]
                this.formValue.subTotal=''
                this.formValue.totalQuantity=''
                this.formValue.paidAmount=''
                this.formValue.total=''
                this.formValue.discount=''
                this.formValue.date=''
                this.dataSearch=[]

            },
            async addProduct(){
                this.formValue.barCode=''
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
                            this.quantityChange()
                        }catch(e){
                            this.e('Oops!','Something went wrong, please try again!')
                            this.le()
                            return 0
                        }
                
                    
                }
                
                
            },
            async setData()
            {
                this.clearData()
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
                if( !this.dataSearch)
                {
                    this.loading=false
                    this.e('Oops!','You need to enter Stock and Price in All Fields')

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
                        this.clearData()
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
            const start = new Date();
            this.formValue.date=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();

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
