<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="12" offset="1">
                <Form >

                    <Row :gutter="24">
                        <Col span="24">
                            <FormItem label="Unit Name" >
                                <Input type="text" placeholder="Unit Name" 
                                v-model="formValue.unitName"></Input>
                            </FormItem>
                        </Col>
                         <Col class="dream-input-main-button" span="24">
                            <Button type="success" :loading="loading" @click="unitAdd">
                                <span v-if="!loading">Add</span>
                                <span v-else>Loading...</span>
                            </Button>
                        </Col>
                    </Row>
                </Form>
            </Col>
        </Row>

        <Row>
            <Col class="dream-input-main" span="22" offset="1">
                <Table :columns="columns1" :data="data1"></Table>
            </Col>
        </Row>

      <Modal v-model="editModal" width="360">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Edit {{UpdateValue.unitName}}</span>
        </p>
        <div style="text-align:center">
            <Form>
           <Col span="24">
                <FormItem >
                    <Input type="text" placeholder="Group Name" 
                    v-model="editObj.unitName"></Input>
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
            <span> Delete {{UpdateValue.unitName}}</span>
        </p>
        <div style="text-align:center">
            Are you sure you want delete {{UpdateValue.unitName}}

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
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                editObj: {
                    id:null,
                    unitName:'',
                    
                },
                UpdateValue: {
                    indexNumber:null,
                    unitName:'',
                    id:null,
                    
                },
                columns1: [
                    {
                        title: 'Name',
                        key: 'unitName'
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
                data1: [
                    
                  
                    
                ],

                formValue: {
                    id: '',
                    unitName: '',
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
            async unitAdd(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/unit_type',
                        data: this.formValue
                    })
                    this.data1.unshift(data.status)
                    this.formValue.unitName=''
                    this.s('Great!','Unit has been added successfully!')
                    
                    this.loading=false
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.editObj.id=this.data1[index].id
                this.editObj.unitName=this.data1[index].unitName
                this.UpdateValue.unitName=this.data1[index].unitName
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.unitName=this.data1[index].unitName
                this.UpdateValue.id=this.data1[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/unitUpdate',
                        data: this.editObj
                    })
                    this.data1[this.UpdateValue.indexNumber].unitName=this.editObj.unitName
                    this.s('Great!','Unit information has been updated successfully!')
                    
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
                        url:`/app/unit_type/${this.UpdateValue.id}`,
                    })
                    this.data1.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Unit information has been removed successfully!')
                    
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
                    url:'/app/unit_type'
                })
                this.data1=data;

            this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
