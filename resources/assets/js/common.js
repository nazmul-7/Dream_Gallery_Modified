export default {
	data(){
		return {
			productStock:null,
		}
	},

	methods: {
		//  A COMMON WAY TO CALL THE APIS USING ASYNC AWAIT 
		async callApi(method, url, dataObj){
			try{
	  
				let data = await axios({
					method: method,
					url: url,
					data: dataObj
				})
				return data 
				
			}catch(e){
				
				return e.response
			}
		},
	  



		async getStock(id)
		{	
			
			try{
			let {data} =await axios({
				method: 'get',
				url:`/app/getStock/${id}`,
				})
				
				this.lf()
				this.productStock=data.data
				
				

			}catch(e){
				this.e('Oops!','Something went wrong, please try again!')
				this.le()
				return 0
			}
		},
		ls()
		{
			this.$Loading.start();
		},
		lf()
		{
			this.$Loading.finish();
		},
		le()
		{
			this.$Loading.error();
		},
		i(t,m){
			this.$Notice.info({
                title: t,
                desc: m
            });
		},
		e(t,m){
			this.$Notice.error({
                title: t,
                desc: m
            });
		},
		s(t,m){
			this.$Notice.success({
                title: t,
                desc: m
            });
		},
		w(t,m){
			this.$Notice.warning({
                title: t,
                desc: m
            });
		},
		swr(m){
			this.$Notice.error({
                title: 'Oops',
                desc: `Something went wrong with ${m}`
            });
		},
	}
}