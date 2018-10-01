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
                    <FormItem label="Customer">
                        <Select v-model="filterCustomer" placeholder="Select Customer"  filterable clearable>
                                <Option v-for="(customer,i) in dataCustomer" :value="customer.id" :key="i">{{ customer.customerName }}</Option>
                            </Select>
                    </FormItem>
                    <FormItem label="Group">
                        <Select v-model="filterGroup" placeholder="Select Group"  filterable clearable>
                                <Option v-for="(group,i) in dataGroup" :value="group.groupName" :key="i">{{ group.groupName }}</Option>
                            </Select>
                    </FormItem>
                    <FormItem label="Product">
                        <Select v-model="filterProduct" placeholder="Select Product"  filterable clearable>
                                <Option v-for="(product,i) in dataProduct" :value="product.id" :key="i">{{ product.productName }}</Option>
                            </Select>
                    </FormItem>                    
                </Form>
                <Table :columns="columns1" :data="searchData"></Table>
            </Col>
            <!-- <Col class="dream-input-main" span="7" offset="1">
            <p><b>Total Gross Profit</b>: {{grossProfit}}</p>
            <p><b>Total Net Profit</b>: {{netProfit}}</p>
            </Col> -->
        </Row>

     
    </div>
</template>

<script>
    export default {
        data () {
            return {
                index:0,
                search:'',
                date:false,
                filterProduct:'',
                filterGroup:'',
                filterCustomer:'',
                searchValue:'',
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                grossProfit:'',
                totalUnitPrice:'',
                netProfit:'',
                dataCustomer: [],
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
                        title: 'Item Name',
                        key: 'productName'
                    },

                    {
                        title: 'Quantity',
                        key: 'quantity'
                    },
                    {
                        title: 'Selling Price',
                        key: 'unitPrice'
                    },
                    {
                        title: 'Unit Profit',
                        key: 'profit'
                    },
                    {
                        title: 'Total Profit',
                        key: 'totalProfit'
                    },

                ],

                
            }
            
        },
        computed: {
            searchData()
            {
                if(this.filterProduct && this.filterCustomer && this.filterGroup)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return (data.product.id.toString().toUpperCase().match(this.filterProduct.toString().toUpperCase()) &&
                    data.customer_id.toString().toUpperCase().match(this.filterCustomer.toString().toUpperCase()) &&
                    data.product.groupName.toUpperCase().match(this.filterGroup.toUpperCase()) ) 
                    &&
                    (
                    data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                    data.quantity.toString().match(this.search) ||
                    data.profit.toString().match(this.search) ||
                    data.unitPrice.toString().match(this.search)
                    )            
                    }
                    );

                }
                else if(this.filterCategory)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.product.catName.toUpperCase().match(this.filterCategory.toUpperCase()) &&
                    (
                    data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                    data.quantity.toString().match(this.search) ||
                    data.profit.toString().match(this.search) ||
                    data.unitPrice.toString().match(this.search)
                    )

            
                    }
                    );

                }
                else if(this.filterGroup)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.product.groupName.toUpperCase().match(this.filterGroup.toUpperCase()) 
                    &&
                    (
                    data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                    data.quantity.toString().match(this.search) ||
                    data.profit.toString().match(this.search) ||
                    data.unitPrice.toString().match(this.search)
                    )            
                    }
                    );

                }
                else if(this.filterCustomer)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.customer_id.toString().match(this.filterCustomer) 
                    &&
                    (
                    data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                    data.quantity.toString().match(this.search) ||
                    data.profit.toString().match(this.search) ||
                    data.unitPrice.toString().match(this.search)

                    )            
                    }
                    );

                }                
                else{
                return this.dataInvoice.filter((data)=>{                    
                    return data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                    data.quantity.toString().match(this.search) ||
                    data.profit.toString().match(this.search) ||
                    data.unitPrice.toString().match(this.search)
        
                    }
                );

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
                        url:`/app/filterProfit/${k[0]}/${k[1]}`

                    })

                    var grossProfit=0
                    var totalUnitBuying=0
                    var itemUnitPrice=0
                    var unitBuying=0
                    for(let d of data.sell){
                        itemUnitPrice=d.unitPrice*d.quantity
                        d.totalProfit=d.profit*d.quantity
                        unitBuying=itemUnitPrice-d.totalProfit
                        d.productName=d.product.productName
                        grossProfit+=d.totalProfit
                        totalUnitBuying+=unitBuying
                    }
                    this.netProfit=Math.round(data.totalSelling-totalUnitBuying)
                    this.grossProfit=Math.round(grossProfit)    
                    this.dataInvoice=data.sell
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
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/getProductProfit' //1=purchases

                })
                var grossProfit=0
                var totalUnitBuying=0
                var itemUnitPrice=0
                var unitBuying=0
                for(let d of data.sell){
                    itemUnitPrice=d.unitPrice*d.quantity
                    d.totalProfit=d.profit*d.quantity
                    unitBuying=itemUnitPrice-d.totalProfit
                    d.productName=d.product.productName
                    grossProfit+=d.totalProfit
                    totalUnitBuying+=unitBuying
                }
                this.netProfit=Math.round(data.totalSelling-totalUnitBuying)
                this.grossProfit=Math.round(grossProfit)    
                this.dataInvoice=data.sell
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
