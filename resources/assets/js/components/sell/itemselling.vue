<template>
    <div>
        <div class="_content">
            <Row>
                <Col class="dream-input-main _b_color _b_r border" style="color:#369;text-align:center"  span="22" offset="1">
                    <DatePicker type="daterange" :options="options2" placement="bottom-end" placeholder="Select date" @on-change="getData" style="width: 200px"></DatePicker>
                </Col>

            <Col  class="dream-input-main _b_color _b_r border" span="22" offset="1" v-if="date">
                    <Form ref="formInline" inline>
                        <FormItem label="Search">
                            <Input type="text" v-model="search" placeholder="Search">
                                <Icon type="ios-search" slot="prepend"></Icon>
                            </Input>
                        </FormItem>
                        <FormItem label="Group">
                            <Select v-model="filterGroup" placeholder="Select Group"  filterable clearable>
                                    <Option v-for="(group,i) in dataGroup" :value="group.groupName" :key="i">{{ group.groupName }}</Option>
                                </Select>
                        </FormItem>
                        <FormItem label="Category">
                            <Select v-model="filterCategory" placeholder="Select Category"  filterable clearable>
                                    <Option v-for="(category,i) in dataCategory" :value="category.catName" :key="i">{{ category.catName }}</Option>
                                </Select>
                        </FormItem>   
                        <FormItem label="Product">
                            <Select v-model="filterProduct" placeholder="Select Product"  filterable clearable>
                                    <Option v-for="(product,i) in dataProduct" :value="product.id" :key="i">{{ product.productName }}</Option>
                                </Select>
                        </FormItem>                  
                    </Form>
                    <div class="mr_b20">
                         <Button type="success" class="all_button" align="left" @click="showPrint">Print</Button>
                    </div>

                    <div class="_table_div cusmo_table ">
                         <Table :columns="columns1" :data="searchData"></Table>
                    </div>
                </Col>
            </Row>
        </div>


        <Modal v-model="editModal" width="740" style="margin-top:20px;" >
        <div  class="print">
            <h2 style="text-align:center">Dreams Gallery</h2>
            <h3>Sale List: Item Wise</h3>
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
                date:false,
                search:'',
                searchValue:'',
                filterCategory:'',
                filterProduct:'',
                filterGroup:'',
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                filterDate:[],
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
                dateGroup:[],
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
                        title: 'Item Name',
                        key: 'productName'
                    },

                    {
                        title: 'Quantity',
                        key: 'quantity'
                    },
                    {
                        title: 'Profit',
                        key: 'profit'
                    },
                    {
                        title: 'Discount',
                        key: 'discount'
                    },
                    {
                        title: 'Price',
                        key: 'unitPrice'
                    },

                ],

                
            }
            
        },
        computed: {
            searchData()
            {
                if(this.filterCategory && this.filterGroup && this.filterProduct)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return (data.product.catName.toUpperCase().match(this.filterCategory.toUpperCase()) &&
                    data.product.groupName.toUpperCase().match(this.filterGroup.toUpperCase())   &&
                    data.product_id.toString().match(this.filterProduct) ) 
                    &&
                    (
                    data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
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
                        data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
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
                    data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
                     data.quantity.toString().match(this.search) ||
                     data.profit.toString().match(this.search) ||
                     data.unitPrice.toString().match(this.search)
                    )            
                    }
                    );

                }
                else if(this.filterProduct)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.product_id.toString().match(this.filterProduct)  
                    &&
                    (
                    data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
                     data.quantity.toString().match(this.search) ||
                     data.profit.toString().match(this.search) ||
                     data.unitPrice.toString().match(this.search)
                    )            
                    }
                    );

                }
                else{
                return this.dataInvoice.filter((data)=>{                    
                    return data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.productName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.discount.toString().match(this.search) ||
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
                        url:`/app/filterSaleItem/${k[0]}/${k[1]}`

                    })

                    for(let d of data){
                        d.adminName=d.admin.name
                        if(d.product)
                        d.productName=d.product.productName
                    }
                    this.dataInvoice=data
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
                    url:'/app/category'
                })
                this.dataCategory=data;
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
