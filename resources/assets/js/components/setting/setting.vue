<template>
    <div>
        <Row>
            <Col class="dream-input-main" span="12" offset="1">
                <Form >

                    <Row :gutter="16">
                        <Col span="12">
                            <FormItem >
                                <Input type="text" placeholder="Company Name" 
                                v-model="formValue.companyName"></Input>
                            </FormItem>
                        </Col>
                        <Col span="12">
                            <FormItem >
                                <Input type="text" placeholder="Currency" v-model="formValue.currencyType"></Input>
                            </FormItem>
                        </Col>
                         <Col span="12">
                            <FormItem >
                                <Input type="text" placeholder="Opening Stock Valution" v-model="formValue.openingStock"></Input>
                            </FormItem>
                        </Col>

                         <Col span="12">
                            <FormItem >
                                <Input type="text" placeholder="Account Opening Balance" v-model="formValue.openingBalance"></Input>
                            </FormItem>
                        </Col>
                        
                        <Col span="24">
                            <FormItem >
                                <Input type="textarea" :autosize="{minRows: 4,maxRows: 5}" placeholder="Coumpany Discription" v-model="formValue.companyInfo"></Input>
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
                isCollapsed: false,
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
                        name: 'Company Discription',
                        value: '-----'
                    },
                    {
                        name: 'Currency',
                        value: '-----'
                    },
                    {
                        name: 'Account Opening Balance',
                        value: '-----'
                    },
                    {
                        name: 'Opening Stock Valution',
                        value: '-----'
                    }
                ],

                formValue: {
                    id: '',
                    companyName: '',
                    currencyType: '',
                    openingStock: '',
                    openingBalance: '',
                    companyInfo: '',
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
            async settingSave(){
                this.loading=true
                try{
                    let {data} =await  axios({
                        method: 'post',
                        url:'/app/settingUpdate',
                        data: this.formValue
                    })
                    this.data1[0].value=this.formValue.companyName
                    this.data1[1].value=this.formValue.companyInfo
                    this.data1[2].value=this.formValue.currencyType
                    this.data1[3].value=this.formValue.openingStock
                    this.data1[4].value=this.formValue.openingBalance

                    this.s('Great!','Address information has been added successfully!')
                    
                    this.loading=false
                }catch(e){
                    this.loading=false
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
                    url:'/app/setting'
                })
                this.formValue=data
                this.data1[0].value=data.companyName
                this.data1[1].value=data.companyInfo
                this.data1[2].value=data.currencyType
                this.data1[3].value=data.openingStock
                this.data1[4].value=data.openingBalance
            this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
        }

    }
</script>
