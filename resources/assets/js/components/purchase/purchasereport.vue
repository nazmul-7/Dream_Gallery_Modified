<template>
    <div>
        <div class="_content">
            <div class="row">
                <div class="col-12 col-md-12 col-lg-12">
                    <div class="dream-input-main _b_color _b_r border">
                    <Form ref="formInline" inline>
                        <FormItem label="Search">
                            <Input type="text" v-model="search" placeholder="Search">
                                <Icon type="ios-search" slot="prepend"></Icon>
                            </Input>
                        </FormItem>
                        <!-- <FormItem label="Supplier">
                            <Select v-model="filterSupplier" placeholder="Select supplier"  filterable clearable>
                                    <Option v-for="(supplier,i) in dataSupplier" :value="supplier.id" :key="i">{{ supplier.supplierName }}</Option>
                                </Select>
                        </FormItem> -->
                        <FormItem label="Admin">
                            <Select v-model="filterAdmin" placeholder="Select Admin"  filterable clearable>
                                    <Option v-for="(admin,i) in dataAdmin" :value="admin.name" :key="i">{{ admin.name }}</Option>
                                </Select>
                        </FormItem>
                        <FormItem label="Date">
                            <DatePicker type="daterange" :options="options2" placement="bottom-end" placeholder="Select date" @on-change="getData" style="width: 200px"></DatePicker>
                        </FormItem>
                    </Form>
                    
                    <Row>
                    
                            <Button  align="left" @click="showPrint">Print</Button>
                    
                        <div class="total_cost text_right">
                    <div class="total_cost_bottom d b_color">
                        <div class="total_cost_main dis">
                            <div class="total_cost_main_left flex_space">
                                <p class="total_cost_main_left_text">Total Purchase Amount</p>
                            </div>
                            <div class="total_cost_main_right">
                                <!-- <p class="total_cost_main_left_text">{{totalProfit.toFixed(2)}}</p> -->
                                <p class="total_cost_main_left_text">{{totalPurchasePrice.toFixed(2)}}</p>
                            </div>
                        </div>
                    </div>
                </div>


                
                            <!-- new table -->
                    <div class="buyer_tables">
                            <!-- items -->
                        <div class="buyer_tables_all" v-if="searchData.length" v-for="(item,index) in searchData" :key="index" >
                            <div class="buyer_tables_all_name_all dis">
                                <p class="buyer_tables_all_title">Supplier Name</p>
                                <p class="buyer_tables_all_name"> {{item.supplierName}}</p>
                            </div>

                            <div class="buyer_tables_all_name_all dis">
                                <p class="buyer_tables_all_title">Invoice No</p>
                                <p class="buyer_tables_all_name"> {{item.invoice_id}}</p>
                            </div>
                            <div class="buyer_tables_all_name_all dis">
                                <p class="buyer_tables_all_title">Date</p>
                                <p class="buyer_tables_all_name"> {{item.date}}</p>
                            </div>
                            <div class="buyer_tables_all_name_all dis">
                                <p class="buyer_tables_all_title">Admin</p>
                                <p class="buyer_tables_all_name"> {{item.adminName}}</p>
                            </div>
                            

                            <div class="_table_div ">
                                <div class="buyer_tables_main buyer_tables_main_overflow_two">
                                        <!-- title -->
                                    <div class="buyer_tables_main_all table_title_bg dis b_color">
                                        <div class="buyer_tables_main_name b_color flex_space">
                                            <p class="buyer_tables_main_title">Product Name</p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_title">Purchase Unit</p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_title">Unit Price</p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_title"> Total Purchase Price</p>
                                        </div>

                                            <!--  <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_title">Profit</p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_title">Profit(%)</p>
                                        </div> -->
                                    </div>
                                        <!-- title -->

                                        <!-- Items -->
                                    <div class="buyer_tables_main_all dis b_color" v-if="item.purchase.length"  v-for="(productItem,productIndex) in item.purchase" :key="productIndex" >
                                        <div class="buyer_tables_main_name b_color flex_space">
                                             <p class="buyer_tables_main_text">{{productItem.product.productName}}
                                            <span v-if="productItem.product.model" >|  {{productItem.product.model}}</span>
                                            <span v-if="productItem.product.size" > | {{productItem.product.size}} </span>
                                            <span v-if="productItem.product.color" > | {{productItem.product.color}} </span>
                                             
                                        </p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_text">{{productItem.quantity}}</p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_text">{{productItem.unitPrice}}</p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_text">{{productItem.quantity*productItem.unitPrice}}</p>
                                        </div>

                                        <!-- <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_text">{{(productItem.product.sellingPrice-productItem.product.averageBuyingPrice)*productItem.quantity}}</p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="buyer_tables_main_text">{{productItem | findProfitPercent}}</p>
                                        </div> -->
                                    </div>
                                        <!-- Items -->

                                        

                                        <!-- Total Sales -->
                                    <div class="Total_Sales dis">
                                        <div class="buyer_tables_main_name b_color flex_space">
                                            
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="Total_Sales_text"><span class="Total_Sales_text_span">{{ item.totalQuantity  }}</span></p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                        
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="Total_Sales_text"><span class="Total_Sales_text_span">{{ item.totalPrice }}</span></p>
                                        </div>

                                        <!-- <div class="buyer_tables_main_num b_color">
                                        <p class="Total_Sales_text"><span class="Total_Sales_text_span">{{item.selling | totalProfit}}</span></p>
                                        </div>

                                        <div class="buyer_tables_main_num b_color">
                                            <p class="Total_Sales_text"><span class="Total_Sales_text_span">{{ totalProfitPercent(item.selling)}}</span></p>
                                        </div> -->
                                    </div>
                                        <!-- Total Sales -->
                                </div>
                            </div>
                        </div>
                            <!-- items -->
                    </div>
                    <!-- <Col span="10" offset="15" >
                            <h3>Total Purchase Amount: {{totalPurchasePrice}} </h3>
                        </Col> -->
                    </Row>
                    <!-- <Table :columns="columns1" :data="searchData" @on-row-click="rowSelect"></Table> -->
                    </div>
                </div>
            </div>
        </div>

      <Modal v-model="editModal" width="740">
        <div  class="print">
            <h2 style="text-align:center">Dreams Gallery</h2>
            <h3>Purchas List by Invoice</h3>
            <h3>Date: {{ filterDate[0] }} to {{ filterDate[1] }}</h3>
            <Table :columns="columns1" :data="searchData"></Table>
        </div>
        <div slot="footer">
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
    <Modal v-model="viewModal"  :styles="{top: '5px', width:'110mm'}" >
            <div  class="print">
                
                    <div id="table">
                        <table>
                            <tr class="tabletitle">
                                <td class="item">SL</td>
                                <td class="item">Item</td>
                                <td class="item">Color</td>
                                <td class="item">Size</td>
                                <td class="Hours">Qty</td>
                                <td class="Rate">Sub Total</td>
                            </tr>

                            <tr v-for="(item,i) in viewPurchase" :key="i" class="service">
                                <td class="tableitem"><p class="itemtext">{{ i+1 }}</p></td>
                                <td class="tableitem"><p class="itemtext">{{ item.product.productName }}</p></td>
                                <td class="tableitem"><p class="itemtext">{{ item.product.color }}</p></td>
                                <td class="tableitem"><p class="itemtext">{{ item.product.size }}</p></td>
                                <td class="tableitem"><p class="itemtext">{{ item.quantity }}</p></td>                                
                                <td class="tableitem"><p class="itemtext">{{  item.unitPrice*item.quantity }}</p></td>
                            </tr>
                            <tr class="tabletitle">
                                <td></td>
                                <td class="Rate">Sub-total</td>
                                <td></td>
                                <td></td>
                                <td class="payment">{{ viewInvoice.totalQuantity }}</td>
                                <td class="payment">{{ viewInvoice.totalPrice }}</td>
                            </tr>
                        </table>
                    </div><!--End Table-->
                    <p class="legal"> 
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
                date:false,
                viewModal:false,
                viewPurchase:{},
                viewInvoice:{},
                index:0,
                search:'',
                filterSupplier:'',
                filterAdmin:'',
                searchValue:'',
                clearModel:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                dataSupplier: [],
                filterDate:[

                ],
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
                dataAdmin:[],
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
                    // {
                    //     title: 'Invoice ID',
                    //     key: 'id'
                    // },
                    {
                        title: 'Date',
                        key: 'date'
                    },
                    {
                        title: 'Invoice ID',
                        key: 'invoice_id'
                    },
                    {
                        title: 'Supplier',
                        key: 'supplierName'
                    },
                    {
                        title: 'Total Price',
                        key: 'totalPrice'
                    },
                    {
                        title: 'Admin',
                        key: 'adminName'
                    },
                    // {   
                    //     title: 'Action',
                    //     key: 'action',
                    //     width: 200,
                    //     align: 'center',
                    //     render: (h, params) => {
                    //         return h('div', [
                    //             // h('Button', {
                    //             //     props: {
                    //             //         type: 'primary',
                    //             //         size: 'small'
                    //             //     },
                    //             //     style: {
                    //             //         marginRight: '5px'
                    //             //     },
                    //             //     on: {
                    //             //         click: () => {
                    //             //             this.showView(params.index)
                    //             //         }
                    //             //     }
                    //             // }, 'View'),
                    //             h('Button', {
                    //                 props: {
                    //                     type: 'error',
                    //                     size: 'small'
                    //                 },
                    //                 on: {
                    //                     click: () => {
                    //                         this.showRemove(params.index)
                    //                     }
                    //                 }
                    //             }, 'Remove')
                    //         ]);
                    //     }
                    // }
                    
                ],

                
            }
            
        },
        computed: {
            searchData()
            {
                if(this.filterAdmin && this.filterSupplier){
                    return this.dataInvoice.filter((data)=>{                    
                        return (data.adminName.toUpperCase().match(this.filterAdmin.toUpperCase()) &&
                        data.customer.zone.toUpperCase().match(this.filterZone.toUpperCase()) ) 
                        &&
                        (
                        data.supplierName.toUpperCase().match(this.search.toUpperCase()) ||
                        data.id.toString().match(this.search) ||
                        data.totalPrice.toString().match(this.search) ||
                        data.totalQuantity.toString().match(this.search)||
                        data.invoice_id.toUpperCase().match(this.search.toUpperCase()) ||
                        data.adminName.toUpperCase().match(this.search.toUpperCase()) 
                        )            
                        }
                        );

                }
                else if(this.filterAdmin)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.adminName.toUpperCase().match(this.filterAdmin.toUpperCase()) &&
                    (
                     data.supplierName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.totalQuantity.toString().match(this.search)||
                     data.invoice_id.toUpperCase().match(this.search.toUpperCase()) ||
                     data.adminName.toUpperCase().match(this.search.toUpperCase()) 
                    )

            
                    }
                    );

                }
               else if(this.filterSupplier)
                {
                return this.dataInvoice.filter((data)=>{                    
                    return data.supplier_id.toString().match(this.filterSupplier) &&
                    (
                     data.supplierName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.totalQuantity.toString().match(this.search)||
                     data.invoice_id.toUpperCase().match(this.search.toUpperCase()) ||
                     data.adminName.toUpperCase().match(this.search.toUpperCase()) 
                    )

            
                    }
                    );

                }
                else{
                return this.dataInvoice.filter((data)=>{                    
                    return data.supplierName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.id.toString().match(this.search) ||
                     data.totalPrice.toString().match(this.search) ||
                     data.invoice_id.toUpperCase().match(this.search.toUpperCase()) ||
                     data.adminName.toUpperCase().match(this.search.toUpperCase()) ||
                     data.totalQuantity.toString().match(this.search) 
                    || data.purchase.some((p)=>{
                               return p.product.productName.toUpperCase().match(this.search.toUpperCase())
                          })
    
                    }
                );

                }
            },
            totalPurchasePrice(){
                let totalPurchase=0;
                let item;
                console.log("filter Search item");
                console.log(this.searchData.length);
                for(let i = 0;i<this.searchData.length;i++){
                   
                    
                    totalPurchase+= parseInt(this.searchData[i].totalPrice,10);
                }
                return totalPurchase;

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
                try{
                    let {data} =await  axios({
                        method: 'get',
                        url:`/app/purchase/${this.viewInvoice.id}`,
                    })
                    this.viewPurchase=data
                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                }
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
                        url:`/app/filterPurchase/${k[0]}/${k[1]}`

                    })
                    for(let d of data){
                        d.adminName=d.admin.name
                        d.invoice_id="INV-PO-DG-"+d.id

                        if(d.supplier)
                        d.supplierName=d.supplier.supplierName
                    }
                    this.dataInvoice=data
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
                        
                        this.s('Great!','Purchase has been added successfully!')
                        this.loading=false
                    }catch(e){
                        this.loading=false
                        this.e('Oops!','Something went wrong, please try again!')
                    }

                }
                
            },
            async showPrint (index) {
                this.editModal=true
                await new Promise(resolve => setTimeout(resolve, 500));
                console.log("Print")
                window.print();
            },
            showRemove (index) {
                this.UpdateValue.id=this.dataInvoice[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async showView(){
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
            this.$store.dispatch('updateHeader','Purchase Report');
            this.ls();
            const end = new Date();
			const start = new Date();
			start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
            let date1=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
            let date2=end.getFullYear()+'-'+(end.getMonth()+1)+'-'+end.getDate();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/filterPurchase/${date2}/${date2}`

                })
                    for(let d of data){
                        d.invoice_id="INV-PO-DG-"+d.id
                        d.adminName=d.admin.name
                        if(d.supplier)
                        d.supplierName=d.supplier.supplierName
                    }
                    this.dataInvoice=data
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
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
                    url:'/app/zone'
                })
                this.dataZone=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }

              try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/userList'
                })
                this.dataAdmin=data
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
