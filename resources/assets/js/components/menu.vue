<style scoped>

    .layout-logo{
        width: 100px;
        height: 30px;
        background: #5b6270;
        border-radius: 3px;
        float: left;
        position: relative;
        top: 15px;
        left: 20px;
    }
    .layout-nav{
        width: 420px;
        margin: 0 auto;
        margin-right: 20px;
    }
</style>
<template>
            <Header :style="{ width: '100%'}">
                <Menu mode="horizontal" theme="dark" active-name="1">
                    <router-link to="/"><div class="layout-logo"></div></router-link>
                    <div class="layout-nav">
                        <a href="/logout">
                        	<MenuItem name="1">
	                            <Icon type="power"></Icon>
	                            Logout
                        	</MenuItem>
                    	</a>
                    </div>
                </Menu>
            </Header>
</template>

<script>
	export default {
		data(){
			return {

			}
		},

	}

</script>