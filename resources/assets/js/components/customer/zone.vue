<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="13" offset="1">
                <Form ref="formInline" inline>
                    <FormItem prop="user">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                </Form>
                <Table :columns="columns1" :data="searchData"></Table>
            </Col>
            <Col class="dream-input-main" span="8" offset="1">
            <Input type="text" placeholder="Zone Name" v-model="formValue.zoneName" @on-enter="zoneAdd"></Input>
            <Button type="primary" @click="zoneAdd">Add</Button>
              
            </Col>
        </Row>

        <Modal v-model="editModal" width="360">
            <p slot="header" style="color:#369;text-align:center">
                <Icon type="edit"></Icon>
                <span> Edit {{UpdateValue.zoneName}}</span>
            </p>
            <div >
                <Form>
            <Col span="24">
                    <FormItem >
                        <Input type="text" placeholder="Zone Name" 
                        v-model="editObj.zoneName" @on-enter="edit"></Input>
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
                <span> Delete {{UpdateValue.zoneName}}</span>
            </p>
            <div style="text-align:center">
                Are you sure you want delete {{UpdateValue.zoneName}}

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
                    zoneName:'',
                    
                },
                UpdateValue: {
                    indexNumber:null,
                    zoneName:'',
                    id:null,
                    
                },
                columns1: [
                    {
                        title: 'Name',
                        key: 'zoneName'
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
                    zoneName: '',
                },
                
            }
            
        },
        computed: {
            searchData()
            {
                return this.data1.filter((data)=>{                    
                    return data.zoneName.toUpperCase().match(this.search.toUpperCase()) 
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
            async zoneAdd(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/zone',
                        data: this.formValue
                    })
                    this.data1.unshift(data.status)
                    this.formValue.zoneName=''
                    this.s('Great!','Zone has been added successfully!')
                    
                    this.loading=false
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.editObj.id=this.data1[index].id
                this.editObj.zoneName=this.data1[index].zoneName
                this.UpdateValue.zoneName=this.data1[index].zoneName
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.zoneName=this.data1[index].zoneName
                this.UpdateValue.id=this.data1[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/zoneUpdate',
                        data: this.editObj
                    })
                    this.data1[this.UpdateValue.indexNumber].zoneName=this.editObj.zoneName
                    this.s('Great!','Zone information has been updated successfully!')
                    
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
                        url:`/app/zone/${this.UpdateValue.id}`,
                    })
                    this.data1.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Zone information has been removed successfully!')
                    
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
                this.data1=data;

            this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
