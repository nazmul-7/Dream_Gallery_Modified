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
                        <Col span="24">
                            <FormItem  label="Name">
                                <Input type="text" placeholder="Name" 
                                v-model="formValue.name"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="User Name">
                                <Input type="text" placeholder="User Name" 
                                v-model="formValue.username"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Password">
                            <Input type="password" placeholder="Password" 
                            v-model="formValue.password"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Email">
                                <Input type="text" placeholder="Email" 
                                v-model="formValue.email"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
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
            <span> Edit </span>
        </p>
        <div>
            <Form>
                <Row :gutter="24">
                        <Col span="24">
                            <FormItem  label="Name">
                                <Input type="text" placeholder="Name" 
                                v-model="editObj.name"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="User Name">
                                <Input type="text" placeholder="User Name" 
                                v-model="editObj.username"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Email">
                                <Input type="text" placeholder="Email" 
                                v-model="editObj.email"  @on-enter="customerAdd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem label="Select">
                                <Select v-model="editObj.userType">
                                    <Option value="Admin">Admin</Option>
                                    <Option value="Editor">Sales Executive</Option>
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
                    name:'',
                    email:'',
                    userType:'',
                    username:','

                    
                },
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    

                    
                },
                columns1: [
                    {
                        title: 'Name',
                        key: 'name'
                    },
                    {
                        title: 'User Name',
                        key: 'username'
                    },
                    {
                        title: 'Email',
                        key: 'email',
                    },
                    {
                        title: 'Type',
                        key: 'userType'
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
                    newUser:'',
                    password:'',
                    userType:'',
                    email:'',


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
                    this.dataUser.unshift(data)
                    
                    this.s('Great!','Customer has been added successfully!')
                    this.loading=false
                    this.formValue.neme=''
                    this.formValue.userneme=''
                    this.formValue.password=''
                    this.formValue.userType=''
                    this.formValue.email=''
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.editObj.id=this.dataUser[index].id
                this.editObj.name=this.dataUser[index].name
                this.editObj.email=this.dataUser[index].email
                this.editObj.username=this.dataUser[index].username
                this.editObj.userType=this.dataUser[index].userType
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.name=this.dataUser[index].name
                this.UpdateValue.id=this.dataUser[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/userUpdate',
                        data: this.editObj
                    })

                    console.log(this.UpdateValue.indexNumber)
                    console.log(data)
                    this.dataUser[this.UpdateValue.indexNumber].name=this.editObj.name
                    this.dataUser[this.UpdateValue.indexNumber].username=this.editObj.username
                    this.dataUser[this.UpdateValue.indexNumber].email=this.editObj.email
                    this.dataUser[this.UpdateValue.indexNumber].userType=this.editObj.userType
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
                        method: 'get',
                        url:`/app/userRemove/${this.UpdateValue.id}`,
                    })
                    this.dataUser.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','User information has been removed successfully!')
                    
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
