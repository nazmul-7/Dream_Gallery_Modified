<template>
    <div>
        <div class="_content">
            <div class="row">
                <div class="col-12 col-md-8 col-lg-8">
                    <div class="dream-input-main _b_color _b_r border">
                        <Row :gutter="24">
                            <Col class="mr_b20" span="24">
                                <Card>
                                <p>Product Code</p>
                                        <Input type="text" placeholder="Barcode" 
                                        v-model="formValue.barCode"  @on-enter="setData" ></Input>
                                    </FormItem >
                                </Card>
                            </Col>
                            <!-- <Col span="11" offset="1">
                                <FormItem  label="Search Product">
                                    <br>
                                    <Row >
                                        <Col span="22">
                                            <AutoComplete v-model="searchValue" icon="ios-search" placeholder="input here"  @on-search="setData" @on-select="addProduct">
                                                    <Option v-for="(option,i) in dataSearch" :value="i" :key="i">
                                                        <span class="demo-auto-complete-title">{{ option.model }}</span>
                                                        <span class="demo-auto-complete-count">{{option.groupName}} | {{option.catName}} | {{option.color}} | {{option.size}} | {{option.sellingPrice}}</span>
                                                    </Option>

                                            </AutoComplete>
                                        </Col>
                                    </Row>
                                </FormItem >
                            </Col> -->
                            <Col span="24">
                                <Card>
                                    <p slot="title">Product List</p>
                                    <div class="_table_div product_div mr_b20">
                                        <table style="width:100%">
                                            <tr>
                                                <th>Name</th>
                                                <th>Model</th>
                                                <th>Color</th> 
                                                <th>Size</th>
                                                <th>Quantity</th>
                                                <th>Price</th>
                                                <th>Action</th>
                                            </tr>
                                            <tr v-for="(data,i) in formValue.productDetails" :key="i">
                                                <td >{{data.productName}}</td>
                                                <td >{{data.model}}</td>
                                                <td >{{data.color}}</td>
                                                <td>{{data.size}}</td>
                                                <td><InputNumber v-model="data.quantity"></InputNumber></td>
                                                <td><InputNumber v-model="data.unitPrice"></InputNumber></td>
                                                <td><Button type="error" icon="ios-trash" @click="removeItem(i)"></Button></td>
                                            </tr>
                                            <tr >
                                                <td colspan="4" style="text-align:right">Total </td>
                                                <td >{{totalQuantity}}</td>
                                                <td >{{totalPrice}}</td>
                                                <td > <Button type="error" size="large"  @click="showClear">
                                                    Clear All
                                                    </Button>
                                                </td>
                                                
                                            </tr>

                                        </table>
                                    </div>
                                    <Row>
                                        <Col>
                                        
                                            <Button  class="all_button btn" type="primary" size="large" :loading="sending" @click="makePurchase">
                                                <span v-if="!loading">Purchase</span>
                                                <span v-else>Loading...</span>
                                            </Button>
                                        </Col>
                                    </Row>
                                </Card>
                            </Col>
                        </Row>
                    </div>
                </div>

                <div class=" col-12 col-md-4 col-lg-4">
                    <div class="dream-input-main  _b_color _b_r border">
                        <Form >
                            <Row :gutter="24">
                                <Col span="11" offset="1">
                                    <FormItem label="Supplier">
                                        <Select v-model="formValue.supplier_id" placeholder="Supplier" :remote-method="changedSupplier" filterable clearable>
                                            <Option v-for="(suppier,i) in dataSupplier" :value="suppier.id" :key="i">{{suppier.supplierName}}</Option>
                                        </Select>
                                    </FormItem>
                                </Col>
                                <Col span="11" offset="1">
                                    <FormItem  label=" Date">
                                        <br>
                                        <Row>
                                            <Col span="22">
                                                <DatePicker type="date" v-model="currentSupplier.date" @on-change="dateConverter" placeholder="Select date"></DatePicker>
                                            </Col>
                                        </Row>
                                    </FormItem >
                                </Col>

                            </Row>
                        </Form>
                        <Col v-if="currentSupplier.supplierName" >
                            <h2>Supplier Info</h2>
                            <h3>Supplier Name: {{ currentSupplier.supplierName}}</h3>
                            <h3>Number: {{currentSupplier.number}}</h3>
                            <h3>Email: {{currentSupplier.email}}</h3>
                            <h3>Address: {{currentSupplier.address}}</h3>
                            <h3>Outstanding: {{currentSupplier.outStanding}}</h3>
                        </Col>
                    </div>
                </div>
            </div>
        </div>

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
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                dataSupplier: [],
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
                     supplier_id:null,
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
                columns1: [
                    {
                        title: 'Invoice ID',
                        key: 'id'
                    },
                    {
                        title: 'Supplier',
                        key: 'supplierName'
                    },
                    {
                        title: 'Total Quantity',
                        key: 'totalQuantity'
                    },
                    {
                        title: 'Total Price',
                        key: 'totalPrice'
                    },
                    {
                        title: 'Date',
                        key: 'date'
                    },
                    {   
                        title: 'Action',
                        key: 'action',
                        width: 150,
                        align: 'center',
                        render: (h, params) => {
                            return h('div', [
                                h('Button', {
                                    props: {
                                        type: 'primary',
                                        size: 'small'
                                    },
                                    style: {
                                        marginRight: '5px'
                                    },
                                    on: {
                                        click: () => {
                                            this.showEdit(params.index)
                                        }
                                    }
                                }, 'Edit'),
                                h('Button', {
                                    props: {
                                        type: 'error',
                                        size: 'small'
                                    },
                                    on: {
                                        click: () => {
                                            this.showRemove(params.index)
                                        }
                                    }
                                }, 'Delete')
                            ]);
                        }
                    }
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
            async changedSupplier(k)
            {
               // console.log(k);
               // console.log(this.formValue.supplier_id);
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
                this.currentSupplier={}

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
                if(this.formValue.barCode)
                {
                    for(let d of this.formValue.productDetails)
                    {
                        if(d.barCode == this.formValue.barCode){
                            this.i('Product already added')
                            this.searchValue=''
                             return 

                            }
                        }

                    
                }
                try{
                let {data} =await axios({
                    method: 'get',
                    url:`/app/searchProduct/${this.formValue.barCode}`,
                    })
                    if(data)
                    {
                        data.quantity=0
                        data.unitPrice=0
                        this.formValue.productDetails.push(data)
                    }
                    else
                    this.e('Oops!','No Data Found')
                    this.lf();
                    this.formValue.barCode=''

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

                
                console.log("Make "+(this.formValue.supplier_id));
                if( !this.totalQuantity || !this.totalPrice || !this.formValue.date)
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
                    this.s('Great!','Purchase information has been updated successfully!')
                    
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
                    this.s('Great!','Purchase information has been removed successfully!')
                    
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
            const start = new Date();
            this.formValue.date=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/supplier'
                })
                this.dataSupplier=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }


            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/getinvoice/purchase' //1=purchases

                })
                for(let d of data){
                    d.supplierName=d.supplier.supplierName
                }
                this.dataInvoice=data
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
