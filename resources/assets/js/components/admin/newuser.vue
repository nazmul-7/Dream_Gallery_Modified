<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="14" offset="1">
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                </Form>
                <Table :columns="columns1" :data="dataUser"></Table>
            </Col>
            <Col class="dream-input-main" span="7" offset="1">
                <Form >
                    <Row :gutter="24">
                        <Col span="12">
                            <FormItem  label="Name">
                                <Input type="text" placeholder="Name" 
                                v-model="formValue.name"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="12">
                            <FormItem  label="Password">
                            <Input type="password" placeholder="Password" 
                            v-model="formValue.contact"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="12">
                            <FormItem  label="Email">
                                <Input type="text" placeholder="Email" 
                                v-model="formValue.email"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="12">
                            <FormItem label="Select">
                                <Select v-model="formValue.userType">
                                    <Option value="Admin">Admin</Option>
                                    <Option value="Editor">Sales Executive</Option>
                                </Select>
                            </FormItem>
                        </Col>
                         <Col span="24">
                            <Button type="success" :loading="loading" @click="customerAdd">
                                <span v-if="!loading">Add</span>
                                <span v-else>Loading...</span>
                            </Button>
                        </Col>
                    </Row>
                </Form>
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
                            <Input type="text" placeholder="Address" 
                            v-model="editObj.address"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem label="Zone">
                            <Select v-model="editObj.zone" placeholder="Select group">
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
                        title: 'Customer Name',
                        key: 'customerName'
                    },
                    {
                        title: 'Address',
                        key: 'address',
                        width: 250,
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
                        title: 'Opening',
                        key: 'opening'
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
                dataZone: [],
                dataUser:[],

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
                        url:'/app/newUser',
                        data: this.formValue
                    })
                    this.dataUser.unshift(data.status)
                    
                    this.s('Great!','Customer has been added successfully!')
                    this.loading=false
                    this.formValue.neme=''
                    this.formValue.password=''
                    this.formValue.userType=''
                    this.formValue.email=''
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
                url:'/app/userList'
                })
                this.dataUser=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
            
        }

    }
</script>
