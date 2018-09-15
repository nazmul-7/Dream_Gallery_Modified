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
                <Form >

                    <Row :gutter="24">
                        <Col span="24">
                            <FormItem label="Group">
                                <Select v-model="formValue.group_id" placeholder="Select group" filterable>
                                    <Option v-for="(group,i) in dataGroup" :value="group.id" :key="i">{{group.groupName}}</Option>
                                </Select>
                            </FormItem>
                            <FormItem  label="Category Name">
                                <Input type="text" placeholder="Category Name" v-model="formValue.catName" @on-enter="categoryAdd">
                                </Input>
                            </FormItem >
                            
                        </Col>
                         <Col span="24">
                            <Button type="success" :loading="loading" @click="categoryAdd">
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
            <span> Edit {{UpdateValue.catName}} {{editObj.group_id}}</span>
        </p>
        <div >
            <Form>
           <Col span="24">
           <FormItem label="Group">
                    <Select v-model="editObj.group_id" placeholder="Select group" >
                        <Option v-for="(group,i) in dataGroup" :value="group.id" :key="i">{{group.groupName}}</Option>
                    </Select>
                </FormItem>
                <FormItem  label="Category Name">
                    <Input type="text" placeholder="Category Name" 
                    v-model="editObj.catName" @on-enter="edit"></Input>
                </FormItem >
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
            <span> Delete {{UpdateValue.catName}}</span>
        </p>
        <div style="text-align:center">
            Are you sure you want delete {{UpdateValue.catName}}

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
                    catName:'',
                    group_id:'',
                    
                },
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    catName:'',
                    group_id:'',
                    groupName:'',
                    
                },
                columns1: [
                    {
                        title: 'Category Name',
                        key: 'catName'
                    },
                    {
                        title: 'Group Name',
                        key: 'groupName'
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
                dataGroup: [
                    
                  
                    
                ],
                dataCategory: [],

                formValue: {
                    id: '',
                    catName:'',
                    group_id:'',
                },
                
            }
            
        },
        computed: {
            searchData()
            {
                return this.dataCategory.filter((data)=>{
                    
                    return data.catName.toUpperCase().match(this.search.toUpperCase()) ||data.groupName.toUpperCase().match(this.search.toUpperCase());
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
            async categoryAdd(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/category',
                        data: this.formValue
                    })
                    data.groupName=data.group.groupName
                    this.dataCategory.unshift(data)
                    
                    this.s('Great!','Category has been added successfully!')
                    this.loading=false
                    this.formValue.catName=''
                    this.formValue.group_id=null
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.editObj.id=this.dataCategory[index].id
                this.editObj.catName=this.dataCategory[index].catName
                this.editObj.group_id=this.dataCategory[index].group_id
                this.UpdateValue.group_id=this.dataCategory[index].group_id
                this.UpdateValue.catName=this.dataCategory[index].catName
                this.UpdateValue.indexNumber=index
                this.editModal=true
            },
            showRemove (index) {
                this.UpdateValue.catName=this.dataCategory[index].catName
                this.UpdateValue.id=this.dataCategory[index].id
                this.UpdateValue.indexNumber=index
                this.deleteModal=true
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/categoryUpdate',
                        data: this.editObj
                    })
                    this.dataCategory[this.UpdateValue.indexNumber].catName=data.catName
                    this.dataCategory[this.UpdateValue.indexNumber].group_id=data.group_id
                    this.dataCategory[this.UpdateValue.indexNumber].groupName=data.group.groupName
                    this.s('Great!','Category information has been updated successfully!')
                    
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
                        url:`/app/category/${this.UpdateValue.id}`,
                    })
                    this.dataCategory.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Category information has been removed successfully!')
                    
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
                    url:'/app/group'
                })
                this.dataGroup=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/category'
                })
                for(let d of data){
                    d.groupName=d.group.groupName
                }
                
                this.dataCategory=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
