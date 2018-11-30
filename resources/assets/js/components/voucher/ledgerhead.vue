<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="13" offset="1">
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search">
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                    <FormItem label="Type">
                        <Select v-model="filterLedger" placeholder="Select Type" filterable clearable>
                            <Option value="Income" >Income</Option>
                            <Option value="Expence" >Expence</Option>
                        </Select>
                    </FormItem>
                </Form>
                <Table :columns="columns1" :data="searchData"></Table>
            </Col>
            <Col class="dream-input-main" span="8" offset="1">
                <Form >

                    <Row :gutter="24">
                        <Col span="24">
                            <FormItem label="Type">
                                <Select v-model="formValue.type" placeholder="Select Type">
                                    <Option value="Income" >Income</Option>
                                    <Option value="Expence" >Expence</Option>
                                </Select>
                            </FormItem>
                            <FormItem label="Ledger Name">
                                <Input type="text" placeholder="Ledger Name" 
                                v-model="formValue.ledgerName" @on-enter="ledgerAdd"></Input>
                            </FormItem>

                        </Col>
                         <Col span="24">
                            <Button type="success" :loading="loading" @click="ledgerAdd">
                                <span v-if="!loading">Add</span>
                                <span v-else>Loading...</span>
                            </Button>
                        </Col>
                    </Row>
                </Form>
            </Col>
        </Row>

      <Modal v-model="editModal" width="360" :styles="{top: '20px'}">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Edit {{UpdateValue.ledgerName}}</span>
        </p>
        <div style="text-align:center">
            <Form>
               <Col span="24">
                <FormItem label="Ledger Name">
                    <Input type="text" placeholder="Ledger Name" 
                    v-model="editObj.ledgerName"></Input>
                </FormItem>
                <FormItem label="Type">
                    <Select v-model="editObj.type" placeholder="Select Type">
                        <Option value="Income" >Income</Option>
                        <Option value="Expence" >Expence</Option>
                    </Select>
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
            <span> Delete {{UpdateValue.ledgerName}}</span>
        </p>
        <div style="text-align:center">
            Are you sure you want delete {{UpdateValue.ledgerName}}

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
                filterLedger:'',
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                editObj: {
                    id:null,
                    ledgerName:'',
                    type: '',
                    
                },
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    ledgerName:'',
                    type: '',
                    
                },
                columns1: [
                    {
                        title: 'Ledger Head',
                        key: 'ledgerName'
                    },
                    {
                        title: 'Type',
                        key: 'type'
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
                    ledgerName:'',
                    type: '',
                },
                
            }
            
        },
        computed: {
            searchData()
            {
                if(this.filterLedger)
                {
                return this.data1.filter((data)=>{                    
                    return data.type.toUpperCase().match(this.filterLedger.toUpperCase()) 
                    && (data.ledgerName.toUpperCase().match(this.search.toUpperCase())
                    );
                    }
                );

                }
                else{
                return this.data1.filter((data)=>{                    
                    return data.ledgerName.toUpperCase().match(this.search.toUpperCase()) 
                    || data.type.toUpperCase().match(this.search.toUpperCase())
                    ;
                    }
                );

                }
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
            async ledgerAdd(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/ledger',
                        data: this.formValue
                    })
                    this.data1.unshift(data.status)
                    this.formValue.ledgerName=''
                    this.s('Great!','ledger has been added successfully!')
                    
                    this.loading=false
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.editObj.id=this.data1[index].id
                this.editObj.ledgerName=this.data1[index].ledgerName
                this.editObj.type=this.data1[index].type
                this.UpdateValue.ledgerName=this.data1[index].ledgerName
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.ledgerName=this.data1[index].ledgerName
                this.UpdateValue.id=this.data1[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/ledgerUpdate',
                        data: this.editObj
                    })
                    this.data1[this.UpdateValue.indexNumber].ledgerName=this.editObj.ledgerName
                    this.data1[this.UpdateValue.indexNumber].type=this.editObj.type
                    this.s('Great!','Ledger information has been updated successfully!')
                    
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
                        url:`/app/ledger/${this.UpdateValue.id}`,
                    })
                    this.data1.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Ledger information has been removed successfully!')
                    
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
                    url:'/app/ledger'
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
