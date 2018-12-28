<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="14" offset="1">
                <Form >
                    <Row :gutter="24">
                        <Col span="24">
                            <FormItem  label="Name">
                                <Input type="text" placeholder="Name" 
                                v-model="dataUser.name"  ></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="User Name">
                                <Input type="text" placeholder="User Name" 
                                v-model="dataUser.username"  ></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Email">
                                <Input type="text" placeholder="Email" 
                                v-model="dataUser.email"  ></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem label="Type">
                                <Input type="text" placeholder="Type" 
                                v-model="dataUser.userType"  ></Input>
                            </FormItem>
                        </Col>
                    </Row>
                </Form>
            </Col>
            <Col class="dream-input-main" span="7" offset="1">
                <Form >
                    <Row :gutter="24">
                        <Col span="24">
                            <FormItem  label="Current Password">
                            <Input type="password" placeholder="Password" 
                            v-model="formValue.curPassword"  @on-enter="changePassowrd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="New Password">
                            <Input type="password" placeholder="Password" 
                            v-model="formValue.newPassword"  @on-enter="changePassowrd"></Input>
                            </FormItem >
                        </Col>
                        <Col span="24">
                            <FormItem  label="Confirm Password">
                            <Input type="password" placeholder="Password" 
                            v-model="formValue.conPassword"  @on-enter="changePassowrd"></Input>
                            </FormItem >
                        </Col>
                         <Col span="24">
                            <Button type="success" :loading="loading" @click="changePassowrd">
                                <span v-if="!loading">Change</span>
                                <span v-else>Loading...</span>
                            </Button>
                        </Col>
                    </Row>
                </Form>
            </Col>
        </Row>


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
                dataUser:[],
                formValue: {
                    curPassword:'',
                    newPassword:'',
                    conPassword:'',
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
            async changePassowrd(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/changePassword',
                        data: this.formValue
                    })
                    console.log(data)
                    if(data.result)
                    {
                        this.s('Great!','Password Changed Successfully')
                    }
                    else
                    {
                        this.e('Error!','Password Did not Changed')

                    }
                    this.formValue={}
                    this.loading=false

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
                url:'/app/authUser'
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
