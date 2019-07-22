
<template>
    <div>
        <Row>
            <!-- <Col class="dream-input-main" span="14" offset="1">
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
                    <td v-if="data.type ==='incoming'">{{Math.abs(data.amount)}}</td>
                    <td v-else-if="data.type ==='dueIncoming'">{{Math.abs(data.amount)}}</td>
                    <td v-else>0</td>
                    <td v-if="data.type ==='due'">{{Math.abs(data.amount)}}</td>
                    <td v-else-if="data.type ==='opening'">{{Math.abs(data.amount)}}</td>
                    <td v-else>0</td>
                    <td >{{Math.abs(data.balance)}}</td>
                  </tr>

                </table>
            </Col>
 -->
            <Col class="dream-input-main" span="18" offset="3">
                <Form >
                    <Row :gutter="24">
                        <Col span="11" offset="1">
                            <FormItem label="Customer Name">
                                <Select v-model="formValue.customer_id" placeholder="Customer Name" :remote-method="changed" filterable>
                                    <Option v-for="(customer,i) in dataCustomer" :value="customer.id" :key="i">{{customer.customerName}}</Option>
                                </Select>
                            </FormItem>
                        </Col>
                        <Col span="11" offset="1">
                            <FormItem  label="Collection Date">
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
                            <FormItem  label="Collection Amount">
                                <br/>
                                <InputNumber type="text" :max="outStandingAmount" :min="0" v-model="formValue.paidAmount"></InputNumber>
                            </FormItem >
                        </Col>
                        <Col span="22" offset="1">
                            <Button type="error" size="large"  @click="clearForm">
                                Clear
                            </Button>

                            <Button type="primary" size="large" :loading="sending" @click="makePayment">
                                <span v-if="!loading">Collect</span>
                                <span v-else>Loading...</span>
                            </Button>
                        </Col>
                    </Row>
                </Form>
            </Col>
        </Row>
        <Row>
        </Row>

       
    </div>
</template>

<script>
    export default {
        data () {
            return {
                index:0,
                outStandingAmount:0,
                balance:null,
                date:null,
                searchValue:'',
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                dataCustomer: [],
                dataLedger: [],
                formInvoice:
                {
                    type:'purchase',

                },
                formValue: {
                     type:'purchase',
                     date:'',
                     customer_id: '',
                     outStanding:'',
                     paidAmount:0,
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
                const start = new Date();
                this.formValue.date=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
                this.date=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
                this.formValue.customer_id=0
                this.formValue.outStanding=0
                this.formValue.paidAmount=0
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
                console.log(this.formValue.customer_id)
                if(this.formValue.customer_id == '') return
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/payment/getOutstandingCustomer/${this.formValue.customer_id}`
                })
                this.formValue.outStanding=Math.abs(data.outStanding)
                this.formValue.paidAmount=Math.abs(data.outStanding)
                this.outStandingAmount=Math.abs(data.outStanding)
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
                if( !this.formValue.customer_id || !this.formValue.date || !this.formValue.outStanding || !this.formValue.paidAmount)
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
                            url:'/app/paymentCustomer',
                            data: this.formValue
                        })
                        this.emptyEnteredData()
                        console.log(data.data)
                        
                        data.data.balance=this.dataLedger[this.dataLedger.length - 1].balance + data.data.amount
                        this.dataLedger.push(data.data)
                        
                        this.s('Great!','Collection has been added successfully!')
                        this.loading=false
                    }catch(e){
                        this.loading=false
                        this.e('Oops!','1Something went wrong, please try again!')
                    }

                }
                
            },            


        },
        async created()
        {
            this.$store.dispatch('updateHeader','Collection');
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
