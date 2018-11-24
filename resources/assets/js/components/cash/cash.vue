<template>
    <div>
        <Row>
            <Col class="dream-input-main" style="color:#369;text-align:center"  span="22" offset="1">
                <DatePicker type="daterange" :options="options2" placement="bottom-end" placeholder="Select date" @on-change="getData" style="width: 200px"></DatePicker>
            </Col>
            <Col class="dream-input-main" span="22" offset="1" v-if="date">
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                    <FormItem label="Type">
                        <Select v-model="filterType" placeholder="Select Type"  filterable clearable>
                                <Option value="debit" >Debit</Option>
                                <Option value="credit">Credit</Option>
                            </Select>
                    </FormItem>
                </Form>
                <Button  align="left" @click="showPrint">Print</Button>
                <table style="width:100%">
                    <tr>
                        <th>Date</th>
                        <th>Admin</th>
                        <th>Remarks</th> 
                        <th>Debit</th>
                        <th>Credit</th>
                        <th>Balance</th>
                    </tr>
                    <tr v-for="(data,i) in searchData" :key="i" v-if="data.balance!=0">
                        <td >{{data.date}}</td>
                        <td >{{data.adminName}}</td>
                        <td >{{data.remarks}}</td>
                        <td v-if="data.type ==='incoming'">{{Math.abs(data.amount)}}</td>
                        <td v-else-if="data.type ==='dueIncoming'">{{Math.abs(data.amount)}}</td>
                        <td v-else-if="data.type ==='incomingVoucher'">{{Math.abs(data.amount)}}</td>
                        <td v-else>0</td>
                        <td v-if="data.type ==='outgoing'">{{Math.abs(data.amount)}}</td>
                        <td v-else-if="data.type ==='outgoingVoucher'">{{Math.abs(data.amount)}}</td>
                        <td v-else>0</td>
                        <td >{{data.balance}}</td>
                    </tr>

                    </table>
            </Col>
            <!-- <Col class="dream-input-main" span="7" offset="1" v-if="date">
            <h2>Total</h2>
            <p><b>Cash In</b>: {{cashIn}}</p>
            <p><b>Cash Out</b>: {{cashOut}}</p>
            <p><b>Current Cash</b>: {{currentCash}}</p>
            </Col> -->
        </Row>

        <Modal v-model="editModal" width="740" style="margin-top:20px;" >
            <div  class="print">
                <h2 style="text-align:center">Dreams Gallery</h2>
                <h3>Profit List</h3>
                <h3>Date: {{ filterDate[0] }} to {{ filterDate[1] }}</h3>
                <Table :columns="columns1" :data="searchData"></Table>
            </div>
            <div slot="footer">
                
            </div>

        </Modal>
    </div>
</template>

<script>
    export default {
        data () {
            return {
                index:0,
                search:'',
                date:false,
                filterDate:[],
                filterType:[],
                searchValue:'',
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                cashIn:0,
                cashOut:0,
                currentCash:0,
                dataCash: [],
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
                        title: 'Admin',
                        key: 'adminName'
                    },
                    {
                        title: 'Amount',
                        key: 'amount'
                    },
                    {
                        title: 'Remarks',
                        key: 'remarks'
                    },
                    {
                        title: 'Date',
                        key: 'date'
                    },

                ],

                
            }
            
        },
        computed: {
            searchData()
            {
                // if(this.filterType=="debit")
                // {
                // return this.dataInvoice.filter((data)=>{                    
                //     return (data.type.toString().match('incoming') || data.type.toString().match('dueIncoming') ) &&
                //     (
                //     data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.paymentFor.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.id.toString().match(this.search) ||
                //      data.amount.toString().match(this.search) ||
                //      data.remarks.toUpperCase().match(this.search.toUpperCase()) 
                //     )

            
                //     }
                //     );

                // }
                // else if(this.filterType=="credit")
                // {
                // return this.dataInvoice.filter((data)=>{                    
                //     return data.type.toString().match('outgoing') &&
                //     (
                //     data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.paymentFor.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.id.toString().match(this.search) ||
                //      data.amount.toString().match(this.search) ||
                //      data.remarks.toUpperCase().match(this.search.toUpperCase()) 
                //     )

            
                //     }
                //     );

                // }
                // else{
                return this.dataInvoice.filter((data)=>{                    
                    return data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.paymentFor.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.amount.toString().match(this.search) ||
                     data.remarks.toUpperCase().match(this.search.toUpperCase()) 
        
                    }
                );

                // }
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
                        url:`/app/filterCash/${k[0]}/${k[1]}`

                    })
                // var cashIn=0
                // var cashOut=0
                // var currentCash=0
                // for(let d of data.data){
                //     d.adminName=d.admin.name
                //     if(d.type=='incoming' || d.type=='dueIncoming')
                //     cashIn+=Math.abs(d.amount)
                    
                //     if(d.type=='outgoing')
                //     cashOut+=Math.abs(d.amount)

                //     currentCash=cashIn-cashOut
                //     if(d.paymentFor=='customer' && d.uid)
                //     {
                //         d.customerName=d.customer.customerName

                //     }
                //     else if(d.paymentFor=='supplier' && d.uid)
                //     {
                //         d.supplierName=d.supplier.supplierName
                //     }
                    
                // }
                // this.cashIn=Math.round(cashIn)
                // this.cashOut=Math.round(cashOut)
                // this.currentCash=Math.round(currentCash)
                let balance={};
                balance.balance=data.balance
                balance.type='balance'
                balance.date=k[0]
                balance.adminName='Opening'
                balance.remarks='Opening Balance'
                
                
                var temp=data.balance
                for(let d of data.data){
                    d.adminName=d.admin.name

                    temp=temp+d.amount
                    d.balance=temp
                    if(d.paymentFor=='customer' && d.uid)
                    {
                        d.customerName=d.customer.customerName

                    }
                    else if(d.paymentFor=='supplier' && d.uid)
                    {
                        d.supplierName=d.supplier.supplierName
                    }
                    
                }
                data.data.unshift(balance)
                this.dataInvoice=data.data
                this.lf();

                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
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
                        
                        this.s('Great!','Cash has been added successfully!')
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
                    this.s('Great!','Cash information has been updated successfully!')
                    
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
                    this.s('Great!','Cash information has been removed successfully!')
                    
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
