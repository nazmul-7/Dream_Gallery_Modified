<template>



    <div>
        <div class="form">
            

            <v-content>
                <v-container fluid fill-height>
                    <v-layout align-center justify-center>
                        <v-flex xs12 sm8 md4>
                            <v-card class="elevation-12">
                                <v-toolbar dark color="primary">
                                    <v-toolbar-title>Login form</v-toolbar-title>
                                    <v-spacer></v-spacer>


                                </v-toolbar>
                                <form @submit.prevent="login">
                                    <v-card-text>

                                        <v-form>
                                            <v-text-field prepend-icon="person"
                                            name="email" v-model="data.email" label="email" type="text">

                                        </v-text-field>
                                        <v-text-field prepend-icon="lock" 
                                        name="password" v-model="data.password" label="Password" id="password" type="password">

                                    </v-text-field>
                                </v-form>


                            </v-card-text>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="primary" type="submit">Login</v-btn>
                            </v-card-actions>
                        </form>

                    </v-card>
                </v-flex>
            </v-layout>
        </v-container>
    </v-content>


<Form ref="data" :model="data"  :rules="ruleInline" inline>
        <FormItem prop="email">
            <Input name="email" v-model="data.email" type="text" placeholder="Username">
                <Icon type="ios-person-outline" slot="prepend"></Icon>
            </Input>
        </FormItem prop="password">
        <FormItem >
            <Input name="password" type="password" v-model="data.password" id="password" placeholder="Password">
                <Icon type="ios-locked-outline" slot="prepend"></Icon>
            </Input>
        </FormItem>
        <FormItem>
            <Button type="primary" @click="login">Signin</Button>
        </FormItem>
    </Form>


</div>

</div>
</template>


<script>
export default {
    data(){
        return{
            data:{
                email:'',
                password:'',
            },
            ruleInline: {
                    email: [
                        { required: true, message: 'Please fill in the user name', trigger: 'blur' }
                    ],
                    password: [
                        { required: true, message: 'Please fill in the password.', trigger: 'blur' },
                        { type: 'string', min: 6, message: 'The password length cannot be less than 6 bits', trigger: 'blur' }
                    ]
                }
        }
    },

    methods:{


        async login(){
            try{
                let {data} =await  axios({
                    method: 'post',
                    url:'/app/login',
                    data: this.data
                })
                
                this.$store.dispatch('user',data.user)
                //this.s('Great!','You are Successfully logged in.')
                this.$Message.success('Successfully Logged In');
                this.$router.push('/')
                
            }catch(e){

                
                if(e.response.data){
                    this.$Message.error('Fail!');
                }else{
                    this.$Message.error('Fail!');                }
                
            }
        },



    },
    created(){
        //this.s('Great!','You are Successfully logged in.')
        //this.$store.dispatch('load','true')

    }
}
</script>