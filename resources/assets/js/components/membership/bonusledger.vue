<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="22" offset="1" >
                <Form ref="formInline" inline>
                    <FormItem label="Select Member">
                        <Select v-model="formValue.customer_id" placeholder="Member Name" @on-change="changed" filterable clearable>
                            <Option v-for="(customer,i) in dataCustomer" :value="customer.id" :key="i">{{customer.customerName}}</Option>
                        </Select>
                    </FormItem>
                    <FormItem label="Date">
                        <DatePicker type="daterange" style="width: 200px"></DatePicker>
                    </FormItem>
                </Form>
                <div>
                    <Button  align="left" @click="showPrint">Print</Button>
                </div>
                <div  class="print">
                    <h2>Membership Ledger</h2>
                    <table style="width:100%">
                    <tr>
                        <th>Date</th>
                        <th>Invoice ID</th> 
                        <th>Admin</th> 
                        <th>Type</th> 
                        <th>Debit</th>
                        <th>Credit</th>
                        <th>Balance</th>
                    </tr>
                    <tr v-for="(data,i) in dataLedger" :key="i">
                        <td >{{data.date}}</td>
                        <td >INV-SO-DG-{{data.invoice_id}}</td>


                        <td >{{data.adminName}}</td>
                        <td v-if="data.type ==='gift'">Bonus In</td>
                        <td v-else-if="data.type ==='withdraw'">Bonus Out</td>
                        <td v-else>Not define</td>
                        <td v-if="data.type ==='gift'">{{Math.abs(data.amount)}}</td>
                        <td v-else>0</td>
                        <td v-if="data.type ==='withdraw'">{{Math.abs(data.amount)}}</td>
                        <td v-else>0</td>
                        <td >{{Math.abs(data.balance)}}</td>
                    </tr>

                    </table>
                </div>
            </Col>

        </Row>

    </div>
</template>

<script>
    export default {
        data () {
            return {
                index:0,
                user:0,
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
            async showPrint (index) {
                this.editModal=true
                await new Promise(resolve => setTimeout(resolve, 500));
                console.log("Print")
                window.print();
            },
           
             showClear()
            {
                this.clearModel=true
            },
            clearForm(){
                this.dataLedger.splice(0,this.dataLedger.length)
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
            async changed (k) {
                if(!k)
                {
                    this.clearForm()
                    this.user=0
                    return
                    
                }
                this.user=1
                console.log(this.formValue.customer_id)
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/bonusLedger/${this.formValue.customer_id}`
                })
                var temp=0
                for(let d of data){
                    d.adminName=d.admin.name
                    temp=temp+d.amount
                    d.balance=temp
                }
                this.dataLedger=data
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
            
            this.$store.dispatch('updateHeader','Bonus Ledger');
            this.ls();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/membership'
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
