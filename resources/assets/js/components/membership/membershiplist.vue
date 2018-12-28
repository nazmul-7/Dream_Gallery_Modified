<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="22" offset="1">
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
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
                columns1: [
                    {
                        title: 'Membership Code',
                        key: 'barcode'
                    },
                    {
                        title: 'Member Name',
                        key: 'customerName'
                    },
                    {
                        title: 'Address',
                        key: 'address',
                    },
                    {
                        title: 'Zone',
                        key: 'zone',
                    },
                    {
                        title: 'Contact',
                        key: 'contact'
                    },
                    {
                        title: 'Bonus Balance',
                        key: 'bonusAmount'
                    },

                ],
                dataZone: [],
                dataCustomer: [],

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

                return this.dataCustomer.filter((data)=>{                    
                    return data.customerName.toUpperCase().match(this.search.toUpperCase()) 
                    || data.address.toUpperCase().match(this.search.toUpperCase())
                    || data.contact.toString().match(this.search.toString()) 
                    || data.zone.toUpperCase().match(this.search.toUpperCase()) 
                    || data.barcode.toString().match(this.search) 
                    ;
                    }
                );


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
            this.ls();
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
                    url:'/app/membership'
                })
                
                for(let d of data)
                {
                    d.bonusAmount=0
                    for(let f of d.bonus)
                    {
                        d.bonusAmount=d.bonusAmount+f.amount   
                    }
                    
                }
                
                this.dataCustomer=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
