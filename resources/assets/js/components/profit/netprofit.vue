<template>
    <div>
        <Row>
           <Col  class="dream-input-main" span="22" offset="1" > 
                <Form ref="formInline" inline>
                    <!-- <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem> -->
                    <!-- <FormItem label="Customer">
                        <Select v-model="filterCustomer" placeholder="Select Customer"  filterable clearable>
                                <Option v-for="(customer,i) in dataCustomer" :value="customer.customerName" :key="i">{{ customer.customerName }}</Option>
                            </Select>
                    </FormItem> -->
                    <!-- <FormItem label="Zone">
                        <Select v-model="filterZone" placeholder="Select Zone"  filterable clearable>
                                <Option v-for="(zone,i) in dataZone" :value="zone.zoneName" :key="i">{{ zone.zoneName }}</Option>
                            </Select>
                    </FormItem> -->
                    <FormItem label="Date" >
                        <DatePicker type="daterange" :options="options2" placement="bottom-end" placeholder="Select date" @on-change="getData" style="width: 200px"></DatePicker>
                    </FormItem>
                </Form>
                <Row>
                    <!-- <Col span="11" >
                        <Button  align="left" @click="showPrint">Print</Button>
                    </Col>
                    <Col span="11" offset="1" >
                        <h3>Total Sales: {{totalSale}} | Total Cost: {{totalCost}} | Total Profit: {{totalProfit}}</h3>
                    </Col> -->
                </Row>
                <Table :columns="columns1" :data="totalNetProfitData"></Table>
            </Col>
        </Row>

        <Modal v-model="editModal" width="740" style="margin-top:20px;" >
            <div  class="print">
                <h2 style="text-align:center">Dreams Gallery</h2>
                <h3>Profit List</h3>
                <h3>Date: {{ filterDate[0] }} to {{ filterDate[1] }}</h3>
                <Table :columns="columns1" :data="dataInvoice"></Table>
            </div>
            <div slot="footer">
                
            </div>

        </Modal>

        <Modal v-model="viewModal"  :styles="{top: '5px', width:'110mm'}" >
            <div  class="print">
                <h2 style="text-align:center">{{ shopData.companyName }}</h2>
                <p style="text-align:center"> 
                    {{ shopData.address }}</br>
                    world_first@yahoo.com</br>
                    {{ shopData.contact }}</br>
                </p>
                <hr/>
                <p> 
                    Sold by Bokor Talukder</br>
                    Invoice ID: {{viewInvoice.id}}</br>
                    Date: {{viewInvoice.created_at}}</br>
                </p>
                
                    <div id="table">
                        <table>
                            <tr class="tabletitle">
                                <td class="item">SL</td>
                                <td class="item">Item</td>
                                <td class="Hours">Qty</td>
                                <td class="Rate">Sales Price</td>
                                <td class="Rate">Cost</td>
                                <td class="Rate">Profit</td>
                            </tr>

                            <tr v-for="(item,i) in viewSelling" :key="i" class="service">
                                <td class="tableitem"><p class="itemtext">{{ i+1 }}</p></td>
                                <td class="tableitem"><p class="itemtext">{{ item.product.productName }}</p></td>
                                <td class="tableitem"><p class="itemtext">{{ item.quantity }}</p></td>                                
                                <td class="tableitem"><p class="itemtext">{{ item.unitPrice }}</p></td>                                
                                <td class="tableitem"><p class="itemtext">{{ item.unitPrice-item.profit }}</p></td>                                
                                <td class="tableitem"><p class="itemtext">{{ item.profit*item.quantity }}</p></td>
                            </tr>
                            <!-- <tr class="tabletitle">
                                <td></td>
                                <td class="Rate">Sub-total</td>
                                <td></td>
                                <td class="payment">{{ viewInvoice.totalPrice }}</td>
                            </tr> -->

                            <tr class="tabletitle">
                                <td></td>
                                <td class="Rate">Profit (%)</td>
                                <td></td>
                                <td class="payment">{{ viewInvoice.profitPercentage }}</td>
                            </tr>
                            <!-- <tr class="tabletitleDown">
                                <td></td>
                                <td class="Rate">Total</td>
                                <td></td>
                                <td class="payment">{{ viewInvoice.sellingPrice }}</td>
                            </tr>
                            </hr>
                            <tr class="tabletitle">
                                <td></td>
                                <td class="Rate">Cash Paid</td>
                                <td></td>
                                <td class="payment">{{ viewInvoice.paidAmount }}</td>
                            </tr> -->
                        </table>
                    </div><!--End Table-->
                    <p class="legal"> 
                        {{ shopData.invoiceNote }}
                    </p>
                <!-- <Table :columns="columns1" :data="formValue.productDetails"></Table> -->
            </div>
            <!-- <div slot="footer">
                    <Button type="primary" size="large"  @click="clearForm">
                        <span>Clear and Exit</span>
                    </Button>
                
            </div>
 -->
        </Modal>

    </div>
</template>

<script>
    export default {
        data () {
            return {
                shopData:[],
                viewSelling:{},
                viewModal:false,
                date:false,
                index:0,
                search:'',
                filterCustomer:'',
                filterZone:'',
                searchValue:'',
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                dataSupplier: [],
                filterDate:[],
                viewInvoice:{},
                currentSupplier: {
                    supplierName:'',
                    number:'',
                    email:'',
                    address:'',
                    outStanding:'',
                
                },
                
                dataSearch:[],
                dataCustomer: [],
                dataInvoice:[],
                dataExpense:[],
                dataIncome:[],
                dataZone:[],
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
                        title: 'Total Sales Amount',
                        key: 'totalSalesAmount'
                    },
                    {
                        title: 'Total Gross Profit',
                        key: 'totalGrossProfit'
                    },
                    {
                        title: 'Total Income',
                        key: 'totalIncome'
                    },
                    {
                        title: 'Total Expense',
                        key: 'totalExpense'
                    },
                    {
                        title: 'Net Profit',
                        key: 'totalNetProfit'
                    },
                   

                ],
                netProfitData :[
                    {totalSalesAmount : this.totalSale,
                    totalGrossProfit : this.totalProfit,
                    totalIncome : this.totalIncome,
                    totalExpense : this.totalCost,
                    totalNetProfit : this.NetProfit,
                    },
                ],

                
            }
            
        },
        computed: {
            totalProfit()
            {

                var tF=0
                for (let d of this.searchData)
                {
                    var sF=0
                    for(let dd of d.selling)
                    {
                        sF=(sF+(dd.profit*dd.quantity))
                    }
                tF=tF+sF

                }
                return tF
                
            },
            totalCost()
            {

                var tF=0
                for (let d of this.dataExpense)
                {
                    tF+=d.amount
                    console.log(tF)
                }

                for (let d of this.dataInvoice)
                {
                   if(d.bonus.length>0){
                       console.log("i have bonus")
                       for(let dp of d.bonus){
                               tF+=dp.amount
                                console.log(tF)
                       }
                   }
                }

                return (tF*(-1))
                
            },
            totalIncome()
            {

                var tF=0
                for (let d of this.dataIncome)
                {
                    tF+=d.amount
                    console.log(d.amount)
                }
                return (tF)
                
            },
            NetProfit()
            {

               let profit = (this.totalProfit-this.totalCost)+this.totalIncome
               return profit
                
            },

            totalSale()
            {

                var tF=0
                for (let d of this.searchData)
                {
                    tF=tF+d.totalPrice

                }
                return tF
                
            },
            totalNetProfitData(){
                
                    this.netProfitData[0].totalSalesAmount = this.totalSale.toFixed(2);
                    this.netProfitData[0].totalGrossProfit = this.totalProfit.toFixed(2);
                    this.netProfitData[0].totalIncome = this.totalIncome.toFixed(2);
                    this.netProfitData[0].totalExpense = this.totalCost.toFixed(2);
                    this.netProfitData[0].totalNetProfit = this.NetProfit.toFixed(2);

                    return this.netProfitData;
                
            },
            searchData()
            {
                if(this.filterCustomer && this.filterZone)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return (data.customerName.toUpperCase().match(this.filterCustomer.toUpperCase()) &&
                    data.customer.zone.toUpperCase().match(this.filterZone.toUpperCase()) ) 
                    &&
                    (
                    data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.totalQuantity.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
                     data.paidAmount.toString().match(this.search)
                    )            
                    }
                    );

                }
                else if(this.filterCustomer)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.customerName.toUpperCase().match(this.filterCustomer.toUpperCase()) &&
                    (
                        data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.totalQuantity.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
                     data.paidAmount.toString().match(this.search)
                    )

            
                    }
                    );

                }
                else if(this.filterZone)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.customer.zone.toUpperCase().match(this.filterZone.toUpperCase()) 
                    &&
                    (
                    data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.totalQuantity.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
                     data.paidAmount.toString().match(this.search)
                    )            
                    }
                    );

                }
                else{
                     return this.dataInvoice
                // return this.dataInvoice.filter((data)=>{                    
                //     return data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.customerName.toUpperCase().match(this.search.toUpperCase()) ||
                //      data.id.toString().match(this.search) ||
                //      data.totalPrice.toString().match(this.search) ||
                //      data.totalQuantity.toString().match(this.search) ||
                //      data.discount.toString().match(this.search) ||
                //      data.paidAmount.toString().match(this.search)
        
                //     }
                // );

                }
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
            async rowSelect(k)
            {
                this.viewModal=true
                this.viewInvoice=k
                this.viewInvoice.profitPercentage=Math.round((this.viewInvoice.profitPrice*100)/this.viewInvoice.sellingPrice).toFixed(2)

                try{
                    let {data} =await  axios({
                        method: 'get',
                        url:`/app/sell/${this.viewInvoice.id}`,
                    })
                    this.viewSelling=data
                }catch(e){
                    this.e('1Oops!','Something went wrong, please try again!')
                }
            },
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
                        url:`/app/filterSaleNet/${k[0]}/${k[1]}`

                    })
                    //
                    for(let d of data.data){
                        d.adminName=d.admin.name
                        d.invoice_id="INV-SO-DG-"+d.id
                        d.costPrice=0
                        d.profitPrice=0
                        for(let dd of d.selling)
                        {
                            d.costPrice=(d.costPrice+((dd.unitPrice-dd.profit)*dd.quantity))
                            d.profitPrice=(d.profitPrice+(dd.profit*dd.quantity))
                        }
                        if(d.customer)
                        d.customerName=d.customer.customerName
                    }
                    //
                    this.dataInvoice=data.data
                    this.dataExpense=data.expense
                    this.dataIncome=data.income
                    this.lf();

                }catch(e){
                    this.e('2Oops!','Something went wrong, please try again!')
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
                    this.e('3Oops!','Something went wrong, please try again!')
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
            addProduct(k)
            {
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
                    this.e('4Oops!','Something went wrong, please try again!')
                    this.le();
                }
            },
            collapsedSider ()
            {
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
                        this.e('5Oops!','Something went wrong, please try again!')
                    }

                }
                
            },
            showEdit (index)
            {
                this.editObj.id=this.dataInvoice[index].id
                this.editObj.invoice_id=this.dataInvoice[index].invoice_id
                this.editObj.product_id=this.dataInvoice[index].product_id
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index)
            {
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
                    this.e('6Oops!','Something went wrong, please try again!')
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
                    this.e('7Oops!','Something went wrong, please try again!')
                }
            }
        },



        async created()
        {
            this.$store.dispatch('updateHeader','Net Profit');
            this.ls();
            const end = new Date();
			const start = new Date();
			start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
            let date1=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate(); 
            let date2=end.getFullYear()+'-'+(end.getMonth()+1)+'-'+end.getDate();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/filterSaleNet/${date2}/${date2}` 

                })
                for(let d of data.data){
                    d.adminName=d.admin.namefilterSale
                    d.invoice_id="INV-SO-DG-"+d.id
                    d.costPrice=0
                    d.profitPrice=0
                    for(let dd of d.selling)
                    {
                        d.costPrice=(d.costPrice+((dd.unitPrice-dd.profit)*dd.quantity))
                        d.profitPrice=(d.profitPrice+(dd.profit*dd.quantity))
                    }
                    if(d.customer)
                    d.customerName=d.customer.customerName
                }
                this.dataInvoice=data.data
                this.dataExpense=data.expense
                this.dataIncome=data.income
                this.lf();

            }catch(e){
                this.e('8Oops!','Something went wrong, please try again!')
            this.le();
            }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/customer'
                })
                this.dataCustomer=data;
                this.lf();

            }catch(e){
                this.e('9Oops!','Something went wrong, please try again!')
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
                this.e('99Oops!','Something went wrong, please try again!')
            this.le();
            }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/setting'
                })
                this.shopData=data
            this.lf();

            }catch(e){
                this.e('88Oops!','Something went wrong, please try again!')
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
