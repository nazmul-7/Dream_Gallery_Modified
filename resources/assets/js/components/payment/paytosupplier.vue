<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="14" offset="1">
                <h2>Product List</h2>

                <table style="width:100%">
                    <tr>
                        <th>Date</th>
                        <th>Type</th> 
                        <th>ID</th>
                        <th>Debit</th>
                        <th>Credit</th>
                        <th>Balance</th>
                    </tr>
                        <tr v-for="(data,i) in dataLedger" :key="i">
                        <td >{{data.date}}</td>
                        <td >{{data.type}}</td>
                        <td>{{data.invoice_id}}</td>
                        <td v-if="data.type ==='outgoing'">{{Math.abs(data.amount)}}</td>
                        <td v-else>0</td>
                        <td v-if="data.type ==='due'">{{data.amount}}</td>
                        <td v-else-if="data.type ==='opening'">{{data.amount}}</td>
                        <td v-else>0</td>
                        <td >{{data.balance}}</td>
                    </tr>
                </table>
            </Col>
            <Col class="dream-input-main" span="7" offset="1">
                <Form >
                    <Row :gutter="24">
                        <Col span="11" offset="1">
                            <FormItem label="Supplier">
                                <Select v-model="formValue.supplier_id" placeholder="Supplier" :remote-method="changed" filterable>
                                    <Option v-for="(suppier,i) in dataSupplier" :value="suppier.id" :key="i">{{suppier.supplierName}}</Option>
                                </Select>
                            </FormItem>
                        </Col>
                        <Col span="11" offset="1">
                            <FormItem  label="Payment Date">
                                <br>
                                <Row>
                                    <Col span="22">
                                        <DatePicker v-model="date" type="date" @on-change="dateConverter" placeholder="Select date"></DatePicker>
                                    </Col>
                                </Row>
                            </FormItem >
                        </Col>
                        <Col span="11" offset="1">
                            <FormItem  label="Outstanding Amount">
                                <Input type="text" v-model="formValue.outStanding" placeholder="Outstanding Amount"  disabled></Input>
                            </FormItem >
                        </Col>
                        <Col span="11" offset="1">
                            <FormItem  label="Payment Amount">
                                <Input type="text" v-model="formValue.paidAmount" placeholder="Payment Amount"></Input>
                            </FormItem >
                        </Col>
                        <Col span="22" offset="1">
                            <Button type="error" size="large"  @click="showClear">
                                Clear
                            </Button>

                            <Button type="primary" size="large" :loading="sending" @click="makePayment">
                                <span v-if="!loading">Pay</span>
                                <span v-else>Loading...</span>
                            </Button>
                        </Col>
                    </Row>
                </Form>
            </Col>
        </Row>
        <Row>

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
                balance:null,
                date:null,
                searchValue:'',
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                dataSupplier: [],
                dataLedger: [],
                formInvoice:
                {
                    type:'purchase',

                },
                formValue: {
                     type:'purchase',
                     date:'',
                     supplier_id: '',
                     outStanding:'',
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
           
             showClear()
            {
                this.clearModel=true
            },
            clearForm(){
                this.emptyEnteredData()
                this.dataLedger.splice(0,this.dataLedger.length)
                this.clearModel=false
            },
            emptyEnteredData()
            {
                this.formValue.supplier_id=''
                this.formValue.date=''
                this.date=''
                this.formValue.outStanding=''
                this.formValue.paidAmount=''
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
            async changed (k) {
                console.log(this.formValue.supplier_id)
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/payment/getOutstanding/${this.formValue.supplier_id}`
                })
                this.formValue.outStanding=data.outStanding
                this.formValue.paidAmount=data.outStanding
                var temp=0
                for(let d of data.ledger){
                   
                    temp=temp+d.amount
                    d.balance=temp
                }
                this.dataLedger=data.ledger
                console.log(data);
                
                this.lf();
                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            async makePayment(){
                //invoice added
                if( !this.formValue.supplier_id || !this.formValue.date || !this.formValue.outStanding || !this.formValue.paidAmount)
                {
                    this.loading=false
                    this.e('Oops! ','You nedd to Enter Form in All Fields')

                }
                else
                {
                    this.loading=true
                    try{
                        let {data} =await  axios({
                            method: 'post',
                            url:'/app/paymentSupplier',
                            data: this.formValue
                        })
                        this.emptyEnteredData()
                        console.log(data.data)
                        
                        data.data.balance=this.dataLedger[this.dataLedger.length - 1].balance + data.data.amount
                        this.dataLedger.push(data.data)
                        
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
