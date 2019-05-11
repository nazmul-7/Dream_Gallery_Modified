<template>
    <div>
        <div class="total_cost text_right">
            <div class="total_cost_top d b_color">
                <div class="total_cost_main dis">
                    <div class="total_cost_main_left flex_space">
                        <p class="total_cost_main_left_text">Total Discount Amount</p>
                    </div>
                    <div class="total_cost_main_right">
                        <!-- <p class="total_cost_main_left_text">{{totalSale.toFixed(2)}}</p> -->
                        <p class="total_cost_main_left_text">{{totalDiscount}}</p>
                    </div>
                </div>
            </div>
        </div>
        <Row>
            <Col class="dream-input-main" span="22" offset="1">
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                    <FormItem label="Date">
                        <DatePicker type="daterange" :options="options2" placement="bottom-end" placeholder="Select date" @on-change="getData" style="width: 200px"></DatePicker>
                    </FormItem>
                </Form>
                <Table :columns="columns1" :data="searchData"></Table>
            </Col>

        </Row>


      <Modal v-model="editModal" width="600">
        <p slot="header" style="color:#369;text-align:center"> 
            <Icon type="edit"></Icon>
            <span> Edit {{UpdateValue.customerName}}</span>
        </p>
        <div>
            <Form>
                <Row :gutter="24">
                    <Col span="12">
                        <FormItem  label="Customer Name">
                            <Input type="text" placeholder="Customer Name" 
                            v-model="editObj.customerName"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Membership Code">
                            <Input type="text" placeholder="Membership Code" 
                            v-model="editObj.barcode"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Contact Number">
                        <Input type="text" placeholder="Number" 
                        v-model="editObj.contact"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Email">
                            <Input type="text" placeholder="Email" 
                            v-model="editObj.email"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Address">
                            <Input type="textarea"
                             :autosize="{minRows: 4,maxRows: 5}"
                              placeholder=" Address" 
                              v-model="editObj.address"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem label="Zone">
                            <Select v-model="editObj.zone" placeholder="Select group" filerable>
                                <Option v-for="(zone,i) in dataZone" :value="zone.zoneName" :key="i">{{zone.zoneName}}</Option>
                            </Select>
                        </FormItem>
                    </Col>
                </Row>
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
            <span> Delete {{UpdateValue.customerName}}</span>
        </p>
        <div style="text-align:center">
            Are you sure you want delete {{UpdateValue.customerName}}

        </div>
        <div slot="footer">
            <Button type="error" size="large" long :loading="sending" @click="remove">
                <span v-if="!loading">Delete</span>
                <span v-else>Deleting...</span>
            </Button>
        </div>
    </Modal>
    </div>
</template>

<script>
    export default {
        data () {
            return {
                search:'',
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                editObj: {
                    id:null,
                    customerName:'',
                    address:'',
                    contact:'',
                    email:'',
                    zone:'',

                    
                },
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    customerName:'',
                    address:'',
                    contact:'',
                    email:'',
                    zone:'',


                    
                },
                 options2: {
                    shortcuts: [{
                            text: '1 week',
                            value() {
                                const end = new Date();
                                const start = new Date();
                                start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                                return [start, end];
                            }
                        },
                        {
                            text: '1 month',
                            value() {
                                const end = new Date();
                                const start = new Date();
                                start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                                return [start, end];
                            }
                        },
                        {
                            text: '3 months',
                            value() {
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
                        title: 'Invoice ID',
                        key: 'invoice_id'
                    },
                    {
                        title: 'Customer',
                        key: 'customerName',
                    },
                    {
                        title: 'Sales Amount',
                        key: 'salesAmount',
                    },
                    {
                        title: 'Discount Amount',
                        key: 'amount',
                    },
                    {
                        title: 'Admin',
                        key: 'adminName'
                    },

                ],
                dataZone: [],
                dataBonus: [],

                formValue: {
                    customerName:'',
                    address:'',
                    contact:'+880',
                    email:'',
                    zone:'',
                    opening:0,


                },
                
            }
            
        },
        computed: {
            searchData()
            {

                return this.dataBonus.filter((data)=>{                    
                    return data.customerName.toUpperCase().match(this.search.toUpperCase()) 
                    || data.amount.toString().toUpperCase().match(this.search.toString().toUpperCase())
                    ;
                    }
                );


            },
             totalDiscount() {
                var total = 0
                for (var i = 0; i < this.searchData.length; i++) {
                    total += parseInt(this.searchData[i].amount)
                }
                return total
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
            }
        },
        methods: {
              async getData(k) {
                if (!k[0]) {
                    return
                }
                this.filterDate = k
                if (k)
                    this.date = true
                else
                    this.date = false

                try {
                    let {
                        data
                    } = await axios({
                        method: 'get',
                        url: `/app/discountReport/${k[0]}/${k[1]}`

                    })
                    //
                    for(let d of data)
                {
                    d.customerName=d.customer.customerName   
                    d.adminName=d.admin.name   
                    d.salesAmount=d.invoice.totalPrice
                    d.amount=Math.abs(d.amount)
                }
                this.dataBonus=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
               
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            async customerAdd(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/customer',
                        data: this.formValue
                    })
                    this.dataCustomer.unshift(data.status)
                    
                    this.s('Great!','Customer has been added successfully!')
                    this.loading=false
                    this.formValue.customerName=''
                    this.formValue.address=''
                    this.formValue.contact='+880'
                    this.formValue.email=''
                    this.formValue.zone=''
                    this.formValue.opening=0
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.editObj.id=this.dataCustomer[index].id
                this.editObj.customerName=this.dataCustomer[index].customerName
                this.editObj.address=this.dataCustomer[index].address
                this.editObj.contact=this.dataCustomer[index].contact
                this.editObj.email=this.dataCustomer[index].email
                this.editObj.zone=this.dataCustomer[index].zone
                this.editObj.barcode=this.dataCustomer[index].barcode
                this.UpdateValue.customerName=this.dataCustomer[index].customerName
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.customerName=this.dataCustomer[index].customerName
                this.UpdateValue.id=this.dataCustomer[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/customerUpdate',
                        data: this.editObj
                    })

                    console.log(this.UpdateValue.indexNumber)
                    console.log(data)
                    this.dataCustomer[this.UpdateValue.indexNumber].customerName=data.customerName
                    this.dataCustomer[this.UpdateValue.indexNumber].address=data.address
                    this.dataCustomer[this.UpdateValue.indexNumber].contact=data.contact
                    this.dataCustomer[this.UpdateValue.indexNumber].email=data.email
                    this.dataCustomer[this.UpdateValue.indexNumber].zone=data.zone
                    this.s('Great!','Customer information has been updated successfully!')
                    
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
                        url:`/app/customer/${this.UpdateValue.id}`,
                    })
                    this.dataCustomer.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Customer information has been removed successfully!')
                    
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
            this.$store.dispatch('updateHeader','Discount Report');
            this.ls();
            const end = new Date();
            const start = new Date();
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
            let date1 = start.getFullYear() + '-' + (start.getMonth() + 1) + '-' + start.getDate();
            let date2 = end.getFullYear() + '-' + (end.getMonth() + 1) + '-' + end.getDate();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/discountReport/${date2}/${date2}`
                })
                for(let d of data)
                {
                    d.customerName=d.customer.customerName   
                    d.adminName=d.admin.name   
                    d.salesAmount=d.invoice.totalPrice
                    d.amount=Math.abs(d.amount)
                }
                this.dataBonus=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
