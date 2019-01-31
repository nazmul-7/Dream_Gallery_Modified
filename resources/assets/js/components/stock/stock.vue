<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="22" offset="1">
                <Form >
                    <Row :gutter="24">
                        <Col span="8" offset="8">
                            <FormItem label="Select Product">
                                <Select v-model="formValue.product_id" placeholder="Product Name" @on-change="getData" filterable clearable>
                                    <Option v-for="(product,i) in dataProduct" :value="product.id" :key="i">{{  product.productName}}</Option>
                                </Select>
                            </FormItem>
                        </Col>
                        <!-- <Col span="22" offset="1" v-if="user">
                            <h2>Customer Info</h2>
                            <p></p>
                        </Col> -->
                    </Row>
                </Form>
            </Col>
            <Col class="dream-input-main" span="22" offset="1">
                <Button  align="left">Print</Button>
                <table style="width:100%">
                    <tr>
                        <th>Date</th>
                        <th>Admin</th>
                        <th>Type</th>
                        <th>Invoice ID</th>
                        <th>Debit Qty</th>
                        <th>Debit Value</th>
                        <th>Credit Qty</th>
                        <th>Credit Value</th>
                        <th>Balance</th>
                    </tr>
                    <tr v-for="(data,i) in dataSell" :key="i">
                        <td >{{data.date}}</td>
                        <td v-if="data.type ==='opening'">Opening</td>
                        <td v-else>{{data.adminName}}</td>
                        <td v-if="data.type ==='purchase'">Purchase</td>
                        <td v-else-if="data.type ==='opening'">Opening</td>
                        <td v-else-if="data.type ==='sell'">Sale</td>
                        <td v-else-if="data.type ==='return'">Returned</td>
                        <td v-else>Unfefined</td>
                        <td v-if="data.type ==='purchase'">PU-{{data.invoice_id}}</td>
                        <td v-else-if="data.type ==='opening'">OP-{{data.invoice_id}}</td>
                        <td v-else-if="data.type ==='sell'">SA-{{data.invoice_id}}</td>
                        <td v-else-if="data.type ==='return'">RE-{{data.invoice_id}}</td>
                        <td v-else>{{data.invoice_id}}</td>
                        <td v-if="data.type ==='purchase'">{{data.quantity}}</td>
                        <td v-else-if="data.type ==='opening'">{{data.quantity}}</td>
                        <td v-else-if="data.type ==='return'">{{data.quantity}}</td>
                        <td v-else>0</td>
                        <td v-if="data.type ==='purchase'">{{data.unitPrice}}</td>
                        <td v-else-if="data.type ==='opening'">{{data.unitPrice}}</td>
                        <td v-else>0</td>
                        <td v-if="data.type ==='sell'">{{data.quantity}}</td>
                        <td v-else>0</td>
                        <td v-if="data.type ==='sell'">{{data.unitPrice-data.profit}}</td>
                        <td v-else>0</td>
                        <td >{{data.totalQuantity}} | {{data.balance}}</td>
                    </tr>

                    </table>
                </Col>
        </Row>

      <Modal v-model="editModal" width="360">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Edit {{UpdateValue.catName}} {{editObj.group_id}}</span>
        </p>
        <div style="text-align:center">
            <Form>
           
        </Form>

        </div>
        <div slot="footer">
            <Button type="primary" size="large" long :loading="sending" @click="edit">
                <span v-if="!loading">Update</span>
                <span v-else>Updating...</span>
            </Button>
        </div>
    </Modal>
    <Modal v-model="deleteModal" width="360">
        <p slot="header" style="color:#f60;text-align:center">
            <Icon type="close"></Icon>
            <span> Delete</span>
        </p>
        <div style="text-align:center">
            Are you sure you want delete

        </div>
        <div slot="footer">
            <Button type="error" size="large" long :loading="sending" @click="remove">
                <span v-if="!loading">Delete</span>
                <span v-else>Deleting...</span>
            </Button>
        </div>
    </Modal>
     <Modal v-model="clearModel" width="360">
        <p slot="header" style="color:#f60;text-align:center">
            <Icon type="close"></Icon>
            <span> Clear </span>
        </p>
        <div style="text-align:center">
            Are you sure you want clear invoice

        </div>
        <div slot="footer">
            <Button type="error" size="large" long :loading="sending" @click="clearForm">
                <span v-if="!loading">Clear</span>
                <span v-else>Loading...</span>
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
                searchValue:'',
                dataProduct:[],
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                grossProfit:'',
                totalUnitPrice:'',
                netProfit:'',
                dataPurchase: [],
                dataSell: [],
                dataPaymentCustomer: [],
                dataPaymentSupplier: [],
                currentSupplier: {
                    supplierName:'',
                    number:'',
                    email:'',
                    address:'',
                    outStanding:'',
                
                },
                dataSearch:[],
                dataCategory: [],
                dataInvoice: 
                [],
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
                        title: 'Quantity',
                        key: 'quantity'
                    },

                    {
                        title: 'Unit Price',
                        key: 'unitPrice'
                    },
                ],
                columns2: [ 
                    {
                        title: 'Date',
                        key: 'date'
                    },
                    {
                        title: 'Quantity',
                        key: 'quantity'
                    },

                    {
                        title: 'Unit Price',
                        key: 'unitPrice'
                    },
                ],

                
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
            async getData(k)
            {
                if(!k)
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
                        url:`/app/getStockUnion/${k}`

                    })
                    let temp=0
                    let tempQuantity=0
                     for(let d of data.sell){
                         if(d.invoice_id==0)
                         {
                             d.type='opening'
                         }
                         else
                         {
                             d.type=d.invoice.type
                         }
                        d.adminName=d.admin.name
                        if(d.type=='sell')
                        {
                        temp=temp-(d.quantity*(d.unitPrice-d.profit))
                        tempQuantity=tempQuantity-d.quantity

                        }
                        else
                        {
                        temp=temp+(d.quantity*d.unitPrice)
                        tempQuantity=tempQuantity+d.quantity

                        }
                        d.totalQuantity=tempQuantity

                        d.balance=temp
                    }
                    this.dataSell=data.sell
                    this.lf();

                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }
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
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/product'
                })
                this.dataProduct=data;
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
