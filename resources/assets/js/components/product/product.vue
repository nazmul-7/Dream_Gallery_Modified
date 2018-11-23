<template>
    <div>
        <Row>
            <Col class="dream-input-main "  offset="1" >
                <Button type="success" @click="productAddButton">
                    Add New Product 
                </Button>
            </Col>
        </Row>
        <Row>
            <Col  class="dream-input-main" span="22" offset="1">
                <Form ref="formInline" inline>
                    <FormItem label="Search">
                        <Input type="text" v-model="search" placeholder="Search" @on-enter="searchProducts"> 
                            <Icon type="ios-search" slot="prepend"></Icon>
                        </Input>
                    </FormItem>
                    <FormItem label="Group">
                        <Select v-model="filterGroup" placeholder="Select group"  filterable clearable>
                                <Option v-for="(group,i) in dataGroup" :value="group.groupName" :key="i">{{group.groupName}}</Option>
                            </Select>
                    </FormItem>
                </Form>
                <Table :columns="columns1" :data="dataProduct"></Table>
            </Col>
        </Row>
      <Modal v-model="addProductModal" width="600">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="plus"></Icon>
            <span> Add New Product</span>

        </p>
        <div style="">
            <Form>
                <Row :gutter="24">
                    <Col span="12">
                        <FormItem label="Group">
                            <Select v-model="UpdateValue.group_id" placeholder="Select group" 
                             :remote-method="changed" filterable>
                                    <Option v-for="(group,i) in dataGroup" :value="group.id" :key="i">{{group.groupName}}</Option>
                                </Select>
                        </FormItem>
                    </Col>
                    <Col span="12">
                        <FormItem label="Category">
                            <Select v-model="formValue.catName" placeholder="Select category" filterable>
                                    <Option v-for="(category,i) in dataCategory" :value="category.catName" :key="i">{{category.catName}}</Option>
                                </Select>
                        </FormItem>
                    </Col>
                    <Col span="12">
                        <FormItem label="Unit">
                            <Select v-model="formValue.unit" placeholder="Select unit" filterable >
                                    <Option v-for="(unit,i) in dataUnit" :value="unit.unitName" :key="i">{{unit.unitName}}</Option>
                                </Select>
                        </FormItem>
                    </Col>
                    <Col span="12">
                        <FormItem  label="Product Name">
                            <Input type="text" placeholder="Product Name" 
                            v-model="formValue.productName"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Model">
                            <Input type="text" placeholder="Product Model" 
                            v-model="formValue.model"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Brand">
                            <Input type="text" placeholder="Product Brand" 
                            v-model="formValue.brand"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Size">
                            <Input type="text" placeholder="Product Size" 
                            v-model="formValue.size"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Color">
                            <Input type="text" placeholder="Product Color" 
                            v-model="formValue.color"></Input>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Opening Quantity">
                            <br/>
                            <InputNumber placeholder="Opening Quantity" v-model="formValue.openingQuantity">
                            </InputNumber>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Opening Unit Price">
                            <br/>
                            <InputNumber placeholder="Opening Unit Price" v-model="formValue.openingUnitPrice">
                            </InputNumber>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Price">
                            <br/>
                            <InputNumber placeholder="Selling Price" v-model="formValue.sellingPrice">
                            </InputNumber>
                        </FormItem >
                    </Col>
                    <Col span="12">
                        <FormItem  label="Image">
                        </FormItem >
                    </Col>

                </Row>
            </Form>
        </div>
        <div slot="footer">
            <Button type="primary" size="large" long  :loading="loading" @click="productAdd">
                <span v-if="!loading">Add</span>
                <span v-else>Adding...</span>
            </Button>
        </div>
    </Modal>

      <Modal v-model="editModal" width="600">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Edit {{editObj.model}}</span>
        </p>
        <div>
            <Form>
                <Col span="12">
                    <FormItem label="Group">
                        <Select v-model="UpdateValue.group_id" placeholder="Select group" 
                         :remote-method="changed" filterable>
                                <Option v-for="(group,i) in dataGroup" :value="group.id" :key="i">{{group.groupName}}</Option>
                            </Select>
                    </FormItem>
                </Col>
                <Col span="12">
                    <FormItem label="Category">
                        <Select v-model="editObj.catName" placeholder="Select category" filterable>
                                <Option v-for="(category,i) in dataCategory" :value="category.catName" :key="i">{{category.catName}}</Option>
                            </Select>
                    </FormItem>
                </Col>
                <Col span="12">
                    <FormItem label="Unit">
                        <Select v-model="editObj.unit" placeholder="Select unit" filterable >
                                <Option v-for="(unit,i) in dataUnit" :value="unit.unitName" :key="i">{{unit.unitName}}</Option>
                            </Select>
                    </FormItem>
                </Col>
                <Col span="12">
                    <FormItem  label="Product Name">
                        <Input type="text" placeholder="Product Name" 
                        v-model="editObj.productName"></Input>
                    </FormItem >
                </Col>
                <Col span="12">
                    <FormItem  label="Mode">
                        <Input type="text" placeholder="Product Mode" 
                        v-model="editObj.model"></Input>
                    </FormItem >
                </Col>
                <Col span="12">
                    <FormItem  label="Brand">
                        <Input type="text" placeholder="Product Brand" 
                        v-model="editObj.brand"></Input>
                    </FormItem >
                </Col>
                <Col span="12">
                    <FormItem  label="Size">
                        <Input type="text" placeholder="Product Size" 
                        v-model="editObj.size"></Input>
                    </FormItem >
                </Col>
                <Col span="12">
                    <FormItem  label="Color">
                        <Input type="text" placeholder="Product Color" 
                        v-model="editObj.color"></Input>
                    </FormItem >
                </Col>
                <Col span="12">
                    <FormItem  label="Selling Price">
                        <br/>
                        <InputNumber placeholder="Selling Price" 
                        v-model="editObj.sellingPrice"></InputNumber>
                    </FormItem >
                </Col>
                <Col span="12">
                    <FormItem  label="Image X">
                        
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

    <Modal v-model="deleteModal" width="600">
        <p slot="header" style="color:#f60;text-align:center">
            <Icon type="close"></Icon>
            <span> Delete "{{UpdateValue.productName}}"</span>
        </p>
        <div style="text-align:center">
            Are you sure you want delete {{UpdateValue.productName}}

        </div>
        <div slot="footer">
            <Button type="error" size="large" long :loading="sending" @click="remove">
                <span v-if="!loading">Delete</span>
                <span v-else>Deleting...</span>
            </Button>
        </div>
    </Modal>

    <Modal v-model="barcodeModal" width="600">
        <p slot="header" style="color:#19be6b;text-align:center">
            <span>Barcode </span>
        </p>
        <div style="text-align:center">
            <barcode v-bind:value="UpdateValue.barCode">
                Sorry Cant Load now
            </barcode>
        </div>
        <div slot="footer">
            <Button type="success" size="large" long :loading="sending" @click="barcodeModal=false">
                <span v-if="!loading">Close</span>
                <span v-else>Loading...</span>
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
                filterGroup:'',
                barcodeModal:false,
                addProductModal:false,
                editModal:false,
                deleteModal:false,
                loading:false,
                sending:false,
                isCollapsed: false,
                formValue: {
                    productName:'',
                    groupName:'',
                    catName:'',
                    brand: '',
                    unit:'',
                    size:'',
                    color: '',
                    model:'',
                    sellingPrice:0,
                    openingQuantity:0,
                    openingUnitPrice:0,
                    productImage:'',
                },
                formCategory: {
                   
                },
                editObj: {
                    id:null,
                    productName:'',
                    groupName:'',
                    catName:'',
                    brand: '',
                    unit:'',
                    size:'',
                    color: '',
                    model:'',
                    sellingPrice:0,
                    productImage:'',
                    
                },
                dataProduct: [],
                dataGroup: [],
                dataCategory: [],
                groupFilter: [],
                dataUnit: [],
                UpdateValue: {
                    indexNumber:null,
                    id:null,
                    productName:'',
                    groupName:'',
                    group_id:'',
                    catName:'',
                    brand: '',
                    unit:'',
                    size:'',
                    color: '',
                    model:'',
                    sellingPrice:0,
                    productImage:'',
                    barCode:null,
                    
                },
                columns1: [
                    {
                        title: 'Product Name',
                        key: 'productName'
                    },
                    {
                        title: 'Model Name',
                        key: 'model'
                    },
                    {
                        title: 'Group Name',
                        key: 'groupName'
                    },
                                        {
                        title: 'Category Name',
                        key: 'catName'
                    },
                                        {
                        title: 'Size',
                        key: 'size'
                    },
                                        {
                        title: 'Color',
                        key: 'color'
                    },
                                        {
                        title: 'Selling Price',
                        key: 'sellingPrice'
                    },
                    {   
                        title: 'Action',
                        key: 'action',
                        width: 200,
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
                                            this.showBarcode(params.index)
                                        }
                                    }
                                }, 'Barcode'),
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
            searchData()
            {
                console.log(this.search)
                


                // search should be done from server instead of front end... 
                // if(this.filterGroup)
                // {
                // return this.dataProduct.filter((data)=>{                    
                //     return data.groupName.toUpperCase().match(this.filterGroup.toUpperCase()) 
                //     && (data.productName.toUpperCase().match(this.search.toUpperCase()) 
                //     || data.model.toUpperCase().match(this.search.toUpperCase())
                //     || data.color.toUpperCase().match(this.search.toUpperCase()) 
                //     || data.size.toUpperCase().match(this.search.toUpperCase()) 
                //     || data.catName.toUpperCase().match(this.search.toUpperCase()) 
                //     || data.sellingPrice.toUpperCase().match(this.search.toUpperCase()))
                //     ;
                //     }
                // );

                // }
                // else{
                // return this.dataProduct.filter((data)=>{                    
                //     return data.productName.toUpperCase().match(this.search.toUpperCase()) 
                //     || data.model.toUpperCase().match(this.search.toUpperCase())
                //     || data.color.toUpperCase().match(this.search.toUpperCase()) 
                //     || data.groupName.toUpperCase().match(this.search.toUpperCase())
                //     || data.color.toUpperCase().match(this.search.toUpperCase()) 
                //     || data.catName.toUpperCase().match(this.search.toUpperCase()) 
                //     || data.sellingPrice.toUpperCase().match(this.search.toUpperCase())
                //     ;
                //     }
                // );

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
            onFileChange() {
                const files = this.$refs.image.files
                const data = new FormData()
                // data.append('logo', files[0])
                // console.log(data)
                // console.log(files[0])
                this.formValue.productImage=files[0]
            },
            async changed (k) {
                this.ls();
                this.formValue.catName=''
                this.formValue.groupName=k
                this.editObj.groupName=k
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
                    this.s('Great!','Product has been added successfully!')
                    this.loading=false
                    this.addProductModal=false
                    // this.formValue=null
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            showEdit (index) {
                this.groupNameToId(this.dataProduct[index].groupName)
                this.changed(this.dataProduct[index].groupName)
                this.editObj.id=this.dataProduct[index].id
                this.editObj.productName=this.dataProduct[index].productName
                this.editObj.groupName=this.dataProduct[index].groupName
                this.editObj.catName=this.dataProduct[index].catName
                this.editObj.brand=this.dataProduct[index].brand
                this.editObj.unit=this.dataProduct[index].unit
                this.editObj.size=this.dataProduct[index].size
                this.editObj.color=this.dataProduct[index].color
                this.editObj.model=this.dataProduct[index].model
                this.editObj.sellingPrice=parseInt(this.dataProduct[index].sellingPrice)
                this.editObj.productImage=this.dataProduct[index].productImage
                this.UpdateValue.id=this.dataProduct[index].id
                this.UpdateValue.productName=this.dataProduct[index].productName
                this.UpdateValue.indexNumber=index
                this.editModal=true

            },
            showRemove (index) {
                this.deleteModal=true
                this.UpdateValue.productName=this.dataProduct[index].productName
                this.UpdateValue.id=this.dataProduct[index].id
                this.UpdateValue.indexNumber=index
            },
            showBarcode (index) {
                this.UpdateValue.barCode= parseInt(this.dataProduct[index].barCode)
                this.barcodeModal=true
                this.UpdateValue.id=this.dataProduct[index].id
                this.UpdateValue.productName=this.dataProduct[index].productName
                this.UpdateValue.indexNumber=index
            },
            async edit(){
                this.sending=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/productUpdate',
                        data: this.editObj
                    })
                    this.dataProduct[this.UpdateValue.indexNumber].productName=data.productName
                    this.dataProduct[this.UpdateValue.indexNumber].groupName=data.groupName
                    this.dataProduct[this.UpdateValue.indexNumber].catName=data.catName
                    this.dataProduct[this.UpdateValue.indexNumber].brand=data.brand
                    this.dataProduct[this.UpdateValue.indexNumber].unit=data.unit
                    this.dataProduct[this.UpdateValue.indexNumber].size=data.size
                    this.dataProduct[this.UpdateValue.indexNumber].color=data.color
                    this.dataProduct[this.UpdateValue.indexNumber].model=data.model
                    this.dataProduct[this.UpdateValue.indexNumber].sellingPrice=data.sellingPrice
                    this.dataProduct[this.UpdateValue.indexNumber].productImage=data.productImage
                    this.s('Great!','Product information has been updated successfully!')
                    
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
                        url:`/app/product/${this.UpdateValue.id}`,
                    })
                    this.dataProduct.splice( this.UpdateValue.indexNumber, 1)
                    this.s('Great!','Product information has been removed successfully!')
                    
                    this.sending=false
                    this.deleteModal=false
                }catch(e){
                    this.sending=false
                    this.deleteModal=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            },
            groupNameToId(name)
            {
                var i=0

                while (i < this.dataGroup.length) {
                    if (this.dataGroup[i].groupName == name) {
                        this.UpdateValue.group_id=this.dataGroup[i].id
                    }
                    i++;
                }
                
            },
            async searchProducts(){
                if(this.search==''){
                   this.getProduct()
                   return
                }
                console.log(this.filterGroup)
                let obj = {
                    search : this.search,
                    group: this.filterGroup,
                }
                const res = await this.callApi('post', '/app/search/products',obj)
                if(res.status===200){
                    console.log(res.data)
                    this.dataProduct = res.data
                }else{
                    this.swr('search')
                }
            },
            async getProduct(){
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
            }



        },

        async created()
        {
            this.getProduct()

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

        },


    }
</script>
