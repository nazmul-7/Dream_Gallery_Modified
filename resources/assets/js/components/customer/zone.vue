<template>
    <div>
        <div class="_content">
             <div class="row">
                <div class="col-12 col-md-8 col-lg-8">
                    <div class="dream-input-main _b_color _b_r border">
                        <Form ref="formInline" inline>
                            <FormItem prop="user">
                                <Input type="text" v-model="search" placeholder="Search">
                                    <Icon type="ios-search" slot="prepend"></Icon>
                                </Input>
                            </FormItem>
                        </Form>
                        <div class="_table_div zone_table _pa_table">
                            <Table :columns="columns1" :data="searchData"></Table>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-4 col-lg-4 ">
                    <div class=" _b_color _b_r border dream-input-main">
                        <Input class="mr_b20" type="text" placeholder="Zone Name" v-model="formValue.zoneName" @on-enter="zoneAdd"></Input>
                        <button class="all_button btn"  @click="zoneAdd">Add</button>
                    </div>
                </div>
            </div>


         

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
                        <FormItem >
                        <InputNumber  placeholder="Delivery" :max="100" :min="0" :formatter="value => `${value}`"
                :parser="value => value.replace('', '')"
                        v-model="editObj.delivery" @on-enter="edit"></InputNumber>
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
                    delivery:0,
                    
                },
                UpdateValue: {
                    indexNumber:null,
                    zoneName:'',
                    delivery:0,
                    id:null,
                    
                },
                columns1: [
                    {
                        title: 'Name',
                        key: 'zoneName'
                    },
                    {
                        title: 'Delivery Charge',
                        key: 'delivery'
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
                this.editObj.delivery=this.data1[index].delivery
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
                     this.data1[this.UpdateValue.indexNumber].discount=this.editObj.discount
                     this.data1[this.UpdateValue.indexNumber].delivery=this.editObj.delivery
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
             this.$store.dispatch('updateHeader','Zone');
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
