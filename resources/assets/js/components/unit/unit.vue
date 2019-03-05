<template>
    <div>
        <div class="_content">
            <div class="row">
                <div class="col-12 col-md-8 col-lg-8">
                    <div class="dream-input-main _b_color _b_r border">
                        <Row>
                            <Col  class="dream-input-main" span="24">
                                <Form ref="formInline" inline>
                                    <FormItem prop="user">
                                        <Input type="text" v-model="search" placeholder="Search">
                                            <Icon type="ios-search" slot="prepend"></Icon>
                                        </Input>
                                    </FormItem>
                                </Form>
                                <div class="_table_div _pa_table">
                                    <Table :columns="columns1"  :data="searchData"></Table>
                                </div>
                            </Col>
                        </Row>
                    </div>
                </div>

                <div class="col-12 col-md-4 col-lg-4 ">
                    <div class=" _b_color _b_r border dream-input-main">
                        <Input class="mr_b20" type="text" placeholder="Unit Name" v-model="formValue.unitName" @on-enter="unitAdd"></Input>
                        <button class="all_button btn" type="primary" @click="unitAdd">Add</button>
                    
                    </div>
                </div>
            </div>

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
                data1: [],

                formValue: {
                    id: '',
                    unitName: '',
                },
                
            }
            
        },
        computed: {
            searchData()
            {
                return this.data1.filter((data)=>{                    
                    return data.unitName.toUpperCase().match(this.search.toUpperCase()) ;
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
            async unitAdd(){
                
                this.loading=true
                const res = await this.callApi('post', '/app/unit_type',this.formValue )
                if(res.status===200){
                     this.loading=false
                    this.data1.unshift(res.data.status)
                    this.formValue.unitName=''
                    this.ss('Unit has been added successfully!')
                }else{
                    this.loading=false
                    this.swr()
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
             this.$store.dispatch('updateHeader','Unit Type');
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
