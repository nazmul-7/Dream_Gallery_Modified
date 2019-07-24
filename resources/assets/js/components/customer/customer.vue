<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="20" offset="1">
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                    <FormItem label="Add">
                         <Button type="primary" @click="addModal=true" >Add New Customer</Button>
                    </FormItem>
                    <FormItem label="Total Customer">
                         <p style="text-align: center"> {{dataCustomer.length}}</p>
                    </FormItem>
                </Form>
                
                <Table :columns="columns1" :data="searchData"></Table>
            </Col>
            <!-- <Col class="dream-input-main" span="8" offset="1">
                
            </Col> -->
        </Row>


      <Modal v-model="addModal" width="600">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Add New Customer</span>
        </p>
        <div>
           <Form >
                    <Row :gutter="24">
                        <Col span="24">
                            <FormItem  label="Customer Name">
                                <Input type="text" placeholder="Customer Name" 
                                v-model="formValue.customerName"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Contact Number">
                            <Input type="text" placeholder="Number" 
                            v-model="formValue.contact"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Facebook Link">
                            <Input type="text" placeholder="Facebook" 
                            v-model="formValue.facebook"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Instagram Link">
                            <Input type="text" placeholder="Instagram" 
                            v-model="formValue.instagram"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem label="Zone">
                                <Select v-model="tempZone" placeholder="Select group" filterable>
                                    <Option v-for="(zone,i) in dataZone" :value="i" :key="i">{{zone.zoneName}}</Option>
                                </Select>
                            </FormItem>
                        </Col>
                        <Col span="24">
                            <FormItem  label="Address">
                            <Input type="textarea"
                             :autosize="{minRows: 4,maxRows: 5}"
                              placeholder=" Address" 
                              v-model="formValue.address"></Input>                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Opening Balance">
                                <Input type="text" placeholder="Amount" 
                                v-model="formValue.opening"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        
                    </Row>
                </Form>
        </div>
        <div slot="footer">
            <Button type="success" :loading="loading" @click="customerAdd">
                <span v-if="!loading">Add</span>
                <span v-else>Loading...</span>
            </Button>
        </div>
    </Modal>
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
                    <Col span="24">
                        <FormItem  label="Facebook Link">
                        <Input type="text" placeholder="Facebook" 
                        v-model="editObj.facebook"></Input>
                        </FormItem >
                    </Col>
                    <Col span="24">
                        <FormItem  label="Instagram Link">
                        <Input type="text" placeholder="Instagram" 
                        v-model="editObj.instagram"></Input>
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
                            <Select v-model="tempZone" placeholder="Select group" filerable>
                                <Option v-for="(zone,i) in dataZone" :value="i" :key="i">{{zone.zoneName}}</Option>
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
                addModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                tempZone:'',
                editObj: {
                    id:null,
                    customerName:'',
                    address:'',
                    contact:'',
                    email:'',
                    zone:'',
                    facebook:'',
                    instagram:'',
                    zoneId:'',

                    
                },
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    customerName:'',
                    address:'',
                    contact:'',
                    email:'',
                    zone:'',
                    facebook:'',
                    instagram:'',
                    zoneId:'',


                    
                },
                columns1: [
                    {
                        title: 'Customer Name',
                        key: 'customerName'
                    },
                    {
                        title: 'Address',
                        key: 'address',
                        width:350
                    },
                    {
                        title: 'Contact',
                        key: 'contact'
                    },
                    {
                        title: 'Zone',
                        key: 'zone'
                    },
                    {
                        title: 'Opening Balance',
                        key: 'opening'
                    },
                    {   
                        title: 'Social Links',
                        key: 'links',
                        width: 250,
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
                                            this.goToLink(params.index,'facebook')
                                        }
                                    }
                                }, 'Facebook'),
                                h('Button', {
                                    props: {
                                        type: 'success',
                                        size: 'small'
                                    },
                                    on: {
                                        click: () => {
                                            this.goToLink(params.index,'instagram')
                                        }
                                    }
                                }, 'Instagram')
                            ]);
                        }
                    },
                    {   
                        title: 'Action',
                        key: 'action',
                        width: 200,
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
                dataZone: [],
                dataCustomer: [],

                formValue: {
                    customerName:'',
                    address:'',
                    contact:'',
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
            goToLink (index,item){
                if(item == 'facebook') window.open(this.searchData[index].facebook);
                else  window.open(this.searchData[index].instagram);
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            
            async customerAdd(){
                if(this.tempZone===""){
                    this.i("Zone is Required!");
                    return;
                }
                if(this.formValue.contact.length!=11){
                    this.i("Number length is not valid!");
                    return;
                }
                
                this.loading=true
                this.formValue.zone = this.dataZone[this.tempZone].zoneName
                this.formValue.zoneId = this.dataZone[this.tempZone].id
                this.tempZone=''
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
                    this.addModal = false
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
                this.editObj.facebook=this.dataCustomer[index].facebook
                this.editObj.instagram=this.dataCustomer[index].instagram
                // this.editObj.zone=this.dataCustomer[index].zone
                let tData = this.dataZone.findIndex(x => x.zoneName == this.dataCustomer[index].zone )
                this.tempZone =  tData
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
               
                this.editObj.zone = this.dataZone[this.tempZone].zoneName
                this.editObj.zoneId = this.dataZone[this.tempZone].id
                this.tempZone = ''
                
                
                
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
                    this.dataCustomer[this.UpdateValue.indexNumber].facebook=data.facebook
                    this.dataCustomer[this.UpdateValue.indexNumber].instagram=data.instagram
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
            this.$store.dispatch('updateHeader','Customer');
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
