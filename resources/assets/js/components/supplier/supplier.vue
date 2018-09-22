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
                <Table :columns="columns1" :data="searchData"></Table>
            </Col>
            <Col class="dream-input-main" span="7" offset="1">
                <Form >

                    <Row :gutter="24">
                        <Col span="24">
                            <FormItem  label="SupplierName Name">
                                <Input type="text" placeholder="SupplierName Name" 
                                v-model="formValue.supplierName" @on-enter="supplierAdd"></Input>
                            </FormItem >
                            <FormItem  label="Contact Number">
                                <Input type="text" placeholder="Contact Number" 
                                v-model="formValue.contact" @on-enter="supplierAdd"></Input>
                            </FormItem >
                            <FormItem  label="Email">
                                <Input type="text" placeholder="Supplier's Email" 
                                v-model="formValue.email" @on-enter="supplierAdd"></Input>
                            </FormItem >
                            <FormItem label="Address">
                                <Input type="textarea" :autosize="{minRows: 4,maxRows: 5}" placeholder="Address" v-model="formValue.address" @on-enter="supplierAdd" ></Input>
                            </FormItem>
                            <FormItem  label="Opening Balance">
                                <Input type="text" placeholder="Amount" 
                                v-model="formValue.opening"  @on-enter="customerAdd"></Input>
                            </FormItem >
                            
                        </Col>
                         <Col  span="24">
                            <Button type="success" :loading="loading" @click="supplierAdd">
                                <span v-if="!loading">Add</span>
                                <span v-else>Loading...</span>
                            </Button>
                        </Col>
                    </Row>
                </Form>
            </Col>
        </Row>
      <Modal v-model="editModal" width="360">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Edit {{UpdateValue.supplierName}}</span>
        </p>
        <div style="text-align:center">
            <Form>
           <Col span="24">
                <FormItem  label="SupplierName Name">
                    <Input type="text" placeholder="SupplierName Name" 
                    v-model="editObj.supplierName"></Input>
                </FormItem >
                <FormItem  label="Contact Number">
                    <Input type="text" placeholder="Contact Number" 
                    v-model="editObj.contact"></Input>
                </FormItem >
                <FormItem  label="Email">
                    <Input type="text" placeholder="Supplier's Email" 
                    v-model="editObj.email"></Input>
                </FormItem >
                <FormItem label="Address">
                    <Input type="textarea" :autosize="{minRows: 4,maxRows: 5}" placeholder="Address" v-model="editObj.address"></Input>
                </FormItem>

            </Col>
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
            <span> Delete {{UpdateValue.supplierName}}</span>
        </p>
        <div style="text-align:center">
            Are you sure you want delete {{UpdateValue.supplierName}}

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
                    supplierName:'',
                    contact:'',
                    address:'',
                    email:'',

                    
                },
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    supplierName:'',
                    contact:'',
                    address:'',
                    email:'',

                    
                },
                columns1: [
                    {
                        title: 'Supplier Name',
                        key: 'supplierName'
                    },
                    {
                        title: 'Balance',
                        key: 'balance'
                    },
                    {
                        title: 'Contact Number',
                        key: 'contact'
                    },
                    {
                        title: 'Email',
                        key: 'email'
                    },
                    {
                        title: 'Address',
                        key: 'address'
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
                dataSupplier: [],

                formValue: {
                    id: '',
                    supplierName:'',
                    contact:'',
                    email:'',
                    address:'',
                    opening:0,
                },
                
            }
            
        },
        computed: {
            searchData()
            {

                return this.dataSupplier.filter((data)=>{                    
                    return data.supplierName.toUpperCase().match(this.search.toUpperCase()) 
                    || data.contact.toUpperCase().match(this.search.toUpperCase()) 
                    || data.address.toUpperCase().match(this.search.toUpperCase()) 
                    || data.email.toUpperCase().match(this.search.toUpperCase()) 
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
            async supplierAdd(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/supplier',
                        data: this.formValue
                    })
                    this.dataSupplier.unshift(data)
                    this.s('Great!','Category has been added successfully!')
                    this.loading=false
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.editObj.id=this.dataSupplier[index].id
                this.editObj.supplierName=this.dataSupplier[index].supplierName
                this.editObj.address=this.dataSupplier[index].address
                this.editObj.contact=this.dataSupplier[index].contact
                this.editObj.email=this.dataSupplier[index].email
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.supplierName=this.dataSupplier[index].supplierName
                this.UpdateValue.id=this.dataSupplier[index].id
                this.UpdateValue.indexNumber=index

                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/supplierUpdate',
                        data: this.editObj
                    })
                    console.log(data)
                    this.dataSupplier[this.UpdateValue.indexNumber].supplierName=data.supplierName
                    this.dataSupplier[this.UpdateValue.indexNumber].contact=data.contact
                    this.dataSupplier[this.UpdateValue.indexNumber].address=data.address
                    this.dataSupplier[this.UpdateValue.indexNumber].email=data.email
                    this.s('Great!','Supplier information has been updated successfully!')
                    
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
                        url:`/app/supplier/${this.UpdateValue.id}`,
                    })
                    this.dataSupplier.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Supplier information has been removed successfully!')
                    
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
        }

    }
</script>
