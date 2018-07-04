<template>
    <div>
        <Row>
            <Col class="dream-input-main "  offset="1" >
                <Button type="success" :loading="loading" @click="productAddButton">
                    Add New Product
                </Button>
            </Col>
        </Row>

        <Row>
            <Col class="dream-input-main" span="22" offset="1">
                <Table :columns="columns1" :data="dataProduct"></Table>
            </Col>
        </Row>









      <Modal v-model="addProductModal" width="360">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="plus"></Icon>
            <span> Add New Item</span>

        </p>
        <div style="text-align:center">
            <Form>
                <Col span="24">

                    <FormItem label="Group">
                        <Select v-model="UpdateValue.group_id" placeholder="Select group" 
                         :remote-method="changed">
                                <Option v-for="(group,i) in dataGroup" :value="group.id" :key="i">{{group.groupName}}</Option>
                            </Select>
                    </FormItem>

                    <FormItem label="Category">
                        <Select v-model="formValue.catName" placeholder="Select category" 
                         >
                                <Option v-for="(category,i) in dataCategory" :value="category.catName" :key="i">{{category.catName}}</Option>
                            </Select>
                    </FormItem>

                    <FormItem label="Unit">
                        <Select v-model="formValue.unit" placeholder="Select unit" >
                                <Option v-for="(unit,i) in dataUnit" :value="unit.unitName" :key="i">{{unit.unitName}}</Option>
                            </Select>
                    </FormItem>

                    <FormItem  label="Mode">
                        <Input type="text" placeholder="Product Mode" 
                        v-model="formValue.model"></Input>
                    </FormItem >

                    <FormItem  label="Brand">
                        <Input type="text" placeholder="Product Brand" 
                        v-model="formValue.brand"></Input>
                    </FormItem >

                    <FormItem  label="Size">
                        <Input type="text" placeholder="Product Size" 
                        v-model="formValue.size"></Input>
                    </FormItem >

                    <FormItem  label="Color">
                        <Input type="text" placeholder="Product Color" 
                        v-model="formValue.color"></Input>
                    </FormItem >
                    <FormItem  label="Selling Price">
                        <Input type="text" placeholder="Selling Price" 
                        v-model="formValue.sellingPrice"></Input>
                    </FormItem >

                </Col>
            </Form>
        </div>
        <div slot="footer">
            <Button type="primary" size="large" long :loading="sending" @click="productAdd">
                <span v-if="!loading">Update</span>
                <span v-else>Updating...</span>
            </Button>
        </div>
    </Modal>






















      <Modal v-model="editModal" width="360">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Edit {{UpdateValue.catName}} {{editObj.group_id}}</span>
        </p>
        <div style="text-align:center">
            <Form>
                <Col span="24">
                    <FormItem label="Group">
                        <Select v-model="UpdateValue.group_id" placeholder="Select group" >
                            <Option v-for="(group,i) in dataGroup" :value="group.groupName" :key="i">{{group.groupName}}</Option>
                        </Select>
                    </FormItem>
                    <FormItem label="Group">
                        <Select v-model="formValue.groupName" placeholder="Select group" >
                            <Option v-for="(group,i) in dataGroup" :value="group.groupName" :key="i">{{group.groupName}}</Option>
                        </Select>
                    </FormItem>
                    <FormItem  label="Category Name">
                        <Input type="text" placeholder="Category Name" 
                        v-model="editObj.catName"></Input>
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
                addProductModal:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                formValue: {
                    groupName:'',
                    catName:'',
                    brand: '',
                    unit:'',
                    size:'',
                    color: '',
                    model:'',
                    sellingPrice:'',
                    productImage:'',
                },
                formCategory: {
                   
                },
                editObj: {
                    id:null,
                    catName:'',
                    group_id:'',
                    
                },
                dataProduct: [],
                dataGroup: [],
                dataCategory: [],
                dataUnit: [],
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    catName:'',
                    group_id:'',
                    groupName:'',
                    
                },
                columns1: [
                    {
                        title: 'Model Name',
                        key: 'model'
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
            async changed (k) {
                this.formValue.catName=''
                this.formValue.groupName=k
                this.ls();
                try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/categoryFiltered/${this.UpdateValue.group_id}`
                })
                for(let d of data){
                    d.groupName=d.group.groupName
                }
                this.dataCategory=data
                this.lf();
                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }
            },
            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            productAddButton () {
                this.addProductModal=true
            },
            async productAdd(){
                this.loading=true
                console.log(this.formValue)
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/product/',
                        data: this.formValue
                    })
                    this.dataProduct.unshift(data)
                    this.s('Great!','Category has been added successfully!')
                    this.loading=false
                    this.addProductModal=false
                    // this.formValue=null
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
                    url:'/app/product'
                })
                this.dataProduct=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }

            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/unit_type'
                })
                this.dataUnit=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }

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

        }

    }
</script>
