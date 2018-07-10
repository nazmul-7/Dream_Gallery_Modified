<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="22" offset="1">
                <Form >

                    <Row :gutter="24">
                        <Col span="11" offset="1">
                            <FormItem label="Supplier">
                                <Select v-model="dataVoucher.supplier_id" placeholder="Supplier" filterable>
                                    <Option v-for="(suppier,i) in dataSupplier" :value="suppier.id" :key="i">{{suppier.supplierName}}</Option>
                                </Select>
                            </FormItem>
                        </Col>
                        <Col span="11" offset="1">
                            <FormItem  label="Buying Date">
                                <br>
                                <Row>
                                    <Col span="22">
                                        <DatePicker type="datetime" @on-change="dateConverter" placeholder="Select date"></DatePicker>
                                    </Col>
                                </Row>
                            </FormItem >
                        </Col>
                        <Col span="11" offset="1">
                            <FormItem  label="Barcode">
                                <Input type="text" placeholder="Barcode" 
                                v-model="formValue.barCode"></Input>
                            </FormItem >
                        </Col>
                        <Col span="11" offset="1">
                            <FormItem  label="Search Product">
                                <br>
                                <Row >
                                    <Col span="22">
                                        <AutoComplete v-model="searchValue" icon="ios-search" placeholder="input here"  @on-search="setData" @on-select="addProduct">
                                                <Option v-for="(option,i) in dataSearch" :value="i" :key="i">
                                                    <span class="demo-auto-complete-title">{{ option.model }}</span>
                                                    <span class="demo-auto-complete-count">{{option.groupName}} | {{option.catName}} | {{option.color}} | {{option.size}} | {{option.sellingPrice}}</span>
                                                </Option>

                                        </AutoComplete>
                                    </Col>
                                </Row>
                            </FormItem >
                        </Col>
                    </Row>
                </Form>
                <h2>Basic HTML Table</h2>

                <table style="width:100%">
                  <tr>
                    <th>Model</th>
                    <th>Color</th> 
                    <th>Size</th>
                    <th>Quantity</th>
                    <th>Buying Price</th>
                  </tr>
                  <tr v-for="(data,i) in formValue" :key="i">
                    <td >{{data.model}}</td>
                    <td >{{data.color}}</td>
                    <td>{{data.size}}</td>
                    <td><input type="text" v-model="data.stock"></input></td>
                    <td><input type="text" v-model="data.buyingPrice"></input></td>
                  </tr>
                  <tr >
                    <td colspan="3" style="text-align:right">Total</td>
                    <td >{{totalQuantity}}</td>
                    <td >{{totalPrice}}</td>
                    
                  </tr>
                </table>


            </Col>
        </Row>

        <Row>
            <Col class="dream-input-main" span="22" offset="1">
                <Table :columns="columns1" :data="dataInvoide"></Table>
            </Col>
        </Row>

      <Modal v-model="editModal" width="360">
        <p slot="header" style="color:#369;text-align:center">
            <Icon type="edit"></Icon>
            <span> Edit {{UpdateValue.catName}} {{editObj.group_id}}</span>
        </p>
        <div style="text-align:center">
            <Form>
           
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
                index:0,
                searchValue:'',
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
                        title: 'Invoice ID',
                        key: 'catName'
                    },
                    {
                        title: 'Date',
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
                dataVoucher:{
                    supplier_id:'',
                },
                dataSupplier: [],
                dataSearch:[],
                dataCategory: [],
                dataInvoide: [],
                formValue: [],
                
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
            },
            totalPrice()
            {
                var totalPrice=0
                for ( var i = 0; i < this.formValue.length; i++) {
                        totalPrice+=this.formValue[i].stock*this.formValue[i].buyingPrice
                    }

                return totalPrice;
                
            },
            totalQuantity()
            {
                var total=0
                for ( var i = 0; i < this.formValue.length; i++) {
                        total+=this.formValue[i].stock*1
                    }

                return total;
                
            },

        },
        methods: {
            dateConverter(key)
            {
                console.log(key)
                this.dataInvoide.date=key

            },
            addProduct(k){
                if(this.searchValue)
                {
                this.formValue.push(this.dataSearch[k])

                this.index++
                console.log(this.index)
                }
                this.searchValue=''
                
            },
            async setData()
            {
                try{
                let {data} =await axios({
                    method: 'get',
                    url:`/app/searchProduct/${this.searchValue}`,
                    })
                    this.dataSearch=data;
                    this.lf();

                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                    this.le();
                }
            },
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
            console.log(this.searchValue);
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/supplier'
                })
                this.dataSupplier=data;
                this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }

            
        }

    }
</script>
<style>
    th, td {
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px;
        text-align: left;
    }
    .demo-auto-complete-item{
        padding: 4px 0;
        border-bottom: 1px solid #F6F6F6;
    }
    .demo-auto-complete-group{
        font-size: 12px;
        padding: 4px 6px;
    }
    .demo-auto-complete-group span{
        color: #666;
        font-weight: bold;
    }
    .demo-auto-complete-group a{
        float: right;
    }
    .demo-auto-complete-count{
        float: right;
        color: #999;
    }
    .demo-auto-complete-more{
        display: block;
        margin: 0 auto;
        padding: 4px;
        text-align: center;
        font-size: 12px;
    }
</style>
