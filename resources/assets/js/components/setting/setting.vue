<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="12" offset="1">
                <Form >

                    <Row :gutter="16">
                        <Col span="24">
                            <FormItem label="Company Name" >
                                <Input type="text" placeholder="Company Name" 
                                v-model="formValue.companyName"></Input>
                            </FormItem>
                        </Col>
                        
                         <Col span="12">
                            <FormItem label="Contact" >
                                <Input type="text" placeholder="Contact Number" v-model="formValue.contact"></Input>
                            </FormItem>
                        </Col>
                        <Col span="12">
                            <FormItem label="Currency">
                                <Input type="text" placeholder="Currency" v-model="formValue.currencyType"></Input>
                            </FormItem>
                        </Col>
                         <Col span="12">
                            <FormItem label="Reference Bonus">
                                <Input type="text" placeholder="Reference Bonus" v-model="formValue.referenceBonus" :max="100" :min="0" :formatter="value => `${value}%`"
            :parser="value => value.replace('%', '')"></Input>
                            </FormItem>
                        </Col>



                         <Col span="12">
                            <FormItem label="Referer Bonus" >
                                <Input type="text" placeholder="Bonus Amount" v-model="formValue.refererBonus"></Input>
                            </FormItem>
                        </Col>


                        <Col span="24">
                            <FormItem label="Invoice Note">
                                <Input type="textarea" :autosize="{minRows: 4,maxRows: 5}" placeholder=" Discription" v-model="formValue.invoiceNote"></Input>
                            </FormItem>
                        </Col>
                        <Col span="24">
                            <FormItem label="Adress">
                                <Input type="textarea" :autosize="{minRows: 4,maxRows: 5}" placeholder="Adderss" v-model="formValue.address"></Input>
                            </FormItem>
                        </Col>
                        <Col span="24" v-if="opening==null">
                            <FormItem label="Opening Cash" >
                                <Input type="text" placeholder="Opening Cash" v-model="formValue.openingCash"></Input>
                            </FormItem>
                        </Col>

                        <Col class="dream-input-main-button" span="24">
                            <Button type="success" :loading="loading" @click="settingSave">
                                <span v-if="!loading">Update</span>
                                <span v-else>Loading...</span>
                            </Button>
                        </Col>
                    </Row>
                </Form>
            </Col>
            <Col class="dream-input-main" span="10" offset="1">
            <Upload
                ref="upload"
                type="drag"
                name="img"
                :show-upload-list="listMethod"
                :with-credentials="true"
                :headers="crfObj"
                :data="{id:1}"
                :on-success="handleSuccess"
                :format="['jpg','jpeg','png']"
                :max-size="2048"
                action="/app/setting/upload">
                <div style="padding: 20px 0">
                    <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                    <p>Click or drag image here to upload Logo</p>
                </div>
            </Upload>
            <Card  span="10" offset="1">
                <div style="text-align:center">
                    <img :src="`/uploads/${logo}`" v-if="logo">
                </div>
            </Card>
            
            </Col>
        </Row>


        <Row>
            <Col class="dream-input-main" span="22" offset="1">
                <Table :columns="columns1" :data="data1"></Table>
            </Col>
        </Row>
    </div>
</template>

<script>
    export default {
        data () {
            return {
                loading:false,
                listMethod:true,
                isCollapsed: false,
                opening:null,
               
               crfObj: {
                    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
               },
                columns1: [
                    {
                        title: 'Name',
                        key: 'name'
                    },
                    {
                        title: 'Value',
                        key: 'value'
                    },
                ],
                data1: [
                    {
                        name: 'Company Name',
                        value: '-----'
                    },
                    {
                        name: 'Invoice Note',
                        value: '-----'
                    },
                    {
                        name: 'Currency',
                        value: '-----'
                    },
                    {
                        name: 'Referer Bonus',
                        value: '-----'
                    },
                    {
                        name: 'Reference Bonus',
                        value: '-----'
                    }
                ],

                formValue: {
                    id: '',
                    companyName: '',
                    currencyType: '',
                    referenceBonus: '',
                    refererBonus: '',
                    companyInfo: '',
                },
                logo:''
                
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

            handleSuccess(res, file){
                this.logo=res.companyLogo
            },

            collapsedSider () {
                this.$refs.side1.toggleCollapse();
            },
            async settingSave(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/settingUpdate',
                        data: this.formValue
                    })
                    this.data1[0].value=this.formValue.companyName
                    this.data1[1].value=this.formValue.invoiceNote
                    this.data1[2].value=this.formValue.currencyType
                    this.data1[3].value=this.formValue.referenceBonus
                    this.data1[4].value=this.formValue.refererBonus

                    this.s('Great!','Settings information has been added successfully!')
                    
                    this.loading=false
                }catch(e){
                    this.loading=false
                    this.e('Oops!','Something went wrong, please try again!')
                }
            }
        },
        async created()
        {
          console.log(typeof this.crfObj)
            this.ls();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/setting'
                })
                this.formValue=data
                this.opening=data.openingCash
                this.data1[0].value=data.companyName
                this.data1[1].value=data.invoiceNote
                this.data1[2].value=data.currencyType
                this.data1[3].value=data.refererBonus
                this.data1[4].value=data.referenceBonus
                this.logo=data.companyLogo
            this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>