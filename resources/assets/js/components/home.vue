<template>
    <div>
        <Row :gutter="16">
            <Col class="dream-input-main" span="6" offset="1" >
				<h3 style="text-align:center">Petty Cash</h3>
				<p style="text-align:center">{{ menuData.pettyCash}} {{currencyType}}</p>
            </Col>
        			<!-- total sale cash amount -->
			<Col class="dream-input-main" span="8"  offset="1" >
				<h3 style="text-align:center">Today's Sales</h3>
				<p style="text-align:center">{{ menuData.todaysSale}} {{currencyType}}</p>
            </Col>
			<!-- total collection and cash incoming amount -->
            <Col class="dream-input-main" span="6"  offset="1">
				<h3 style="text-align:center">Today's Collection</h3>
				<p style="text-align:center">{{ menuData.todaysCollection}} {{currencyType}}</p>
            
            </Col>
			<!-- total paid amount to supplier -->
            <Col class="dream-input-main" span="6" offset="1" >
				<h3 style="text-align:center">Today's Payment</h3>
				<p style="text-align:center">{{ menuData.todaysPayment}} {{currencyType}}</p>
            </Col>
			<!-- total sale cash amount -->
			<Col class="dream-input-main" span="8"  offset="1" >
				<h3 style="text-align:center">Customer's Outstanding</h3>
				<p style="text-align:center">{{ menuData.customerOutstanding}} {{currencyType}}</p>
            </Col>
			<!-- total collection and cash incoming amount -->
            <Col class="dream-input-main" span="6"  offset="1">
				<h3 style="text-align:center">Supplier's Outstanding</h3>
				<p style="text-align:center">{{ menuData.supplierOutstanding}} {{currencyType}}</p>
            
            </Col>
        </Row>


        <Row>
			
            <Col class="dream-input-main" span="22" offset="1" >
			<DatePicker type="daterange" :options="options2" @on-change="dateConverter" placeholder="Select date"></DatePicker>

				<GChart
					type="ColumnChart"
					:data="chartData"
					:options="chartOptions"
				/>
            </Col>
        </Row>
    </div>
</template>

<script>
    export default {
        data () {
            return {
				currencyType:'BDT',
				chartData: [
		        ['Year', 'Sales', 'Profit'],
      		],
				chartOptions: {
					chart: {
	    	    	    title: 'Company Performance',
    	    	    	subtitle: 'Sales, Expenses, and Profit: 2014-2017',
					},
					colors: ['#495060', '#bdbdbd']
				},
                loading:false,
                listMethod:true,
                isCollapsed: false,
               
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
				menuData:
				{
					pettyCash:0,
					todaysSale:0,
					todaysCollection:0,
					todaysPayment:0,
					customerOutstanding:0,
					supplierOutstanding:0,


				},
				options2: {
                        shortcuts: [
                            {
                                text: '1 week',
                                value () {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                                    return [start, end];
                                }
                            },
                            {
                                text: '1 month',
                                value () {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                                    return [start, end];
                                }
                            },
                            {
                                text: '3 months',
                                value () {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                                    return [start, end];
                                }
                            }
                        ]
                    },
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
			async dateConverter(k)
			{
				 try{
                    let {data} =await  axios({
                        method: 'get',
                        url:`/app/salesData/${k[0]}/${k[1]}`

                    })

                    
                    this.lf();

                }catch(e){
                    this.e('Oops!','Something went wrong, please try again!')
                this.le();
                }

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
			const end = new Date();
			const start = new Date();
			start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
            let date1=start.getFullYear()+'-'+(start.getMonth()+1)+'-'+start.getDate();
            let date2=end.getFullYear()+'-'+(end.getMonth()+1)+'-'+end.getDate();

			console.log(date1)
			console.log(date2)
            this.ls();
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:`/app/salesData/${date1}/${date2}`
                })
				this.menuData.pettyCash=data.pettycash
				this.menuData.todaysSale=data.todayssale
				this.menuData.todaysCollection=Math.abs(data.todayscollection)
				this.menuData.todaysPayment=Math.abs(data.todayspayment)
				this.menuData.customerOutstanding=Math.abs(data.customerOutstanding)
				this.menuData.supplierOutstanding=Math.abs(data.supplierOutstanding)
				let i=0;
				let array=[]
				for(let d of data.sales){
                    array[0]=d.date
                    array[1]=d.total_sale
                    array[2]=data.profit[i].total_profit
					this.chartData.push(array)
					array=[]
					i++
				}
            	this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }
            try{
                let {data} =await  axios({
                    method: 'get',
                    url:'/app/setting'
                })
                this.currencyType=data.currencyType
            this.lf();

            }catch(e){
                this.e('Oops!','Something went wrong, please try again!')
            this.le();
            }        }

    }
</script>