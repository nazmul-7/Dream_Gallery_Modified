<template>
    <div>
        <div class="_content">
            <div class="row">
                <div class="col-12 col-md-8 col-lg-8">
                    <div class="dream-input-main _b_color _b_r border">
                        <Form ref="formInline" inline>
                            <FormItem label="Search">
                                <Input type="text" v-model="search" placeholder="Search">
                                    <Icon type="ios-search" slot="prepend"></Icon>
                                </Input>
                            </FormItem>
                            <FormItem label="Choose Dates">
                                <DatePicker type="daterange" placement="bottom-end" @on-change="dateRangeConverter" placeholder="Select date" style="width: 200px"></DatePicker>
                            </FormItem>

                        </Form>
                        <div class="_table_div cusmo_table ">
                            <Table :columns="columns1" :data="searchData"></Table>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-4 col-lg-4">
                    <div class="dream-input-main _b_color _b_r border">
                        <Form >
                            <Row :gutter="24">
                                <Col span="24">
                                    <FormItem label="Type">
                                        <Select v-model="formValue.type" placeholder="Type"
                                        :remote-method="changed">
                                            <Option v-for="(type,i) in voucherType" :value="type.value" :key="i">{{ type.label }}</Option>
                                        </Select>
                                    </FormItem>
                                    
                                </Col>
                                <Col span="12">
                                    <FormItem label="Ledger Head">
                                        <Select v-model="formValue.ledgerName" placeholder="Ledger Head">
                                            <Option v-for="(ledger,i) in dataLedger" :value="ledger.ledgerName" :key="i">{{ledger.ledgerName}} ({{ledger.type}})</Option>
                                        </Select>
                                    </FormItem>
                                </Col>
                                <Col span="12">
                                    <FormItem  label="Voucher Date">
                                        <DatePicker type="date" @on-change="dateConverter" placeholder="Select date"></DatePicker>
                                    </FormItem >
                                </Col>
                                <Col span="24">
                                    <FormItem  label="Amount">
                                        <Input type="text" placeholder="Amount" 
                                        v-model="formValue.amount"></Input>
                                    </FormItem >
                                </Col>
                                <Col span="24">
                                    <FormItem  label="Remarks">
                                        <Input type="textarea"
                                        :autosize="{minRows: 4,maxRows: 5}"
                                    placeholder="Remarks" 
                                        v-model="formValue.remarks"></Input>
                                    </FormItem >
                                </Col>
                                <Col span="24">
                                    <Button type="success" :loading="loading" @click="voucherAdd">
                                        <span v-if="!loading">Add</span>
                                        <span v-else>Loading...</span>
                                    </Button>
                                </Col>
                            </Row>
                        </Form>
                    </div>
                </div>

            </div>
        </div>

      <Modal v-model="editModal" width="600">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Edit</span>
        </p>
        <div style="text-align:center">
            <Form>
                <Row :gutter="24">
                    <Col span="24">
                        <FormItem label="Type">
                            <Select v-model="editObj.type" placeholder="Type"
                            :remote-method="changed">
                                <Option v-for="(type,i) in voucherType" :value="type.value" :key="i">{{ type.label }}</Option>
                            </Select>
                        </FormItem>
                    </Col>
                    <Col span="12">
                        <FormItem label="Ledger Head">
                            <Select v-model="editObj.ledgerName" placeholder="Ledger Head">
                                <Option v-for="(ledger,i) in dataLedger" :value="ledger.ledgerName" :key="i">{{ledger.ledgerName}} ({{ledger.type}})</Option>
                            </Select>
                        </FormItem>
                    </Col>
                    <Col span="12">
                        <FormItem  label="Voucher Date">
                            <br/>
                        <DatePicker type="datetime" @on-change="dateConverter" placeholder="Select date"></DatePicker>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Amount">
                            <Input type="text" placeholder="Amount" 
                            v-model="editObj.amount"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Remarks">
                            <Input type="text" placeholder="Remarks" 
                            v-model="editObj.remarks"></Input>
                        </FormItem >
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
                dateRange:[],
                editObj: {
                    id:null,
                    type:'',
                    ledgerName:'',
                    amount:'',
                    date:'',
                    remarks:'',

                    
                },
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    type:'',
                    ledgerName:'',
                    amount:'',
                    date:'',
                    remarks:'',


                    
                },
                columns1: [
                    {
                        title: 'Date',
                        key: 'date'
                    },
                    {
                        title: 'Voucher ID',
                        key: 'voucherID'
                    },
                    {
                        title: 'Type',
                        key: 'type'
                    },
                    {
                        title: 'Ledger',
                        key: 'ledgerName'
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
                dataVoucher: [],
                dataLedger: [],

                formValue: {
                    ledgerName:'',
                    type:'',
                    amount:'',
                    date:'',
                    remarks:'',


                },
                voucherType: [
                    {
                        value: 'Income',
                        label: 'Income'
                    },
                    {
                        value: 'Expence',
                        label: 'Expence'
                    },
                    {
                        value: 'Investment',
                        label: 'Investment'
                    },
                    
                ],
                
            }
            
        },
        computed: {
            searchData()
            {
                if(this.dateRange[0] && this.dateRange[1])
                {
                    return this.dataVoucher.filter((data)=>{
                    return ((data.date>= this.dateRange[0] && data.date<=this.dateRange[1]) 
                        && ( data.type.toUpperCase().match(this.search.toUpperCase()) 
                        || data.ledgerName.toUpperCase().match(this.search.toUpperCase())
                        || data.amount.toString().match(this.search.toString())  
                        || data.remarks.toUpperCase().match(this.search.toUpperCase()) 
                    )
                    
                    );
                        }
                    );
                }
                else
                {
                    return this.dataVoucher.filter((data)=>{                    
                        return data.type.toUpperCase().match(this.search.toUpperCase()) 
                        || data.ledgerName.toUpperCase().match(this.search.toUpperCase())
                        || data.amount.toString().match(this.search.toString())  
                        || data.remarks.toUpperCase().match(this.search.toUpperCase()) 
                        });
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
            }
        },
        methods: {
            dateRangeConverter(key)
            {
                this.dateRange=key

            },
            dateConverter(key)
            {
                console.log(key)
                this.formValue.date=key
                this.editObj.date=key

            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            async changed (k) {
                this.ls();
                this.formValue.type=k
                this.editObj.type=k
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/ledgerFiltered/${k}`
                })
                this.dataLedger=data
                this.lf();
                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }
            },
            async voucherAdd(){
                this.loading=true
                try{
                    console.log(this.formValue)
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/voucher',
                        data: this.formValue
                    })
                    data.status.voucherID="INV-VO-DG-"+data.status.id
                    
                    this.dataVoucher.unshift(data.status)
                    
                    this.s('Great!','Voucher has been added successfully!')
                    this.loading=false
                    this.formValue.ledgerName=''
                    this.formValue.type=''
                    this.formValue.date=''
                    this.formValue.remarks=''
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.editObj.id=this.dataVoucher[index].id
                this.editObj.type=this.dataVoucher[index].type
                this.editObj.ledgerName=this.dataVoucher[index].ledgerName
                this.editObj.date=this.dataVoucher[index].date
                this.editObj.amount=this.dataVoucher[index].amount
                this.editObj.remarks=this.dataVoucher[index].remarks
                this.UpdateValue.ledgerName=this.dataVoucher[index].ledgerName
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.ledgerName=this.dataVoucher[index].ledgerName
                this.UpdateValue.id=this.dataVoucher[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/voucherUpdate',
                        data: this.editObj
                    })

                    console.log(this.UpdateValue.indexNumber)
                    console.log(data)
                    this.dataVoucher[this.UpdateValue.indexNumber].type=data.type
                    this.dataVoucher[this.UpdateValue.indexNumber].ledgerName=data.ledgerName
                    this.dataVoucher[this.UpdateValue.indexNumber].date=data.date
                    this.dataVoucher[this.UpdateValue.indexNumber].amount=data.amount
                    this.dataVoucher[this.UpdateValue.indexNumber].remarks=data.remarks
                    this.s('Great!','Voucher information has been updated successfully!')
                    
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
                        url:`/app/voucher/${this.UpdateValue.id}`,
                    })
                    this.dataVoucher.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Voucher information has been removed successfully!')
                    
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
            this.$store.dispatch('updateHeader','Voucher Posting');
             this.ls();
             const start = new Date();
            this.formValue.date=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
            this.editObj.date=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
            // try{
            //     let {data} =await  axios({
            //         method: 'get',
            //         url:'/app/ledgerhead'
            //     })
            //     this.dataLedger=data;
            //     this.lf();

            // }catch(e){
            //     this.e('Oops!','Something went wrong, please try again!')
            // this.le();
            // }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/voucher'
                })
                for(let d of data)
                {
                    d.voucherID="INV-VO-DG-"+d.id
                }
                this.dataVoucher=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
 