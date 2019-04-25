@extends('layouts.app')

@section('content')
<div class="login_page">
    <div class="container po">
        <div class="row justify-content-center">
            <div class="col-md-5 login_page_main_all">
                <div class="login_page_main">
                    <p class="login_page_main_title text_center">SIGN IN</p>
                    <div class="card-body">
                        <form method="POST" action="{{ url('/app/login') }}" aria-label="{{ __('Login') }}">
                            @csrf

                            <div class="form-group input_group">
                                <p for="username" class="input_group_title">{{ __('Username') }}</p>

                                <div class="input_group_input">
                                    <input id="username" type="text" class="form-control{{ $errors->has('username') ? ' is-invalid' : '' }}" name="username" value="{{ old('username') }}" required autofocus>

                                    @if ($errors->has('username'))
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $errors->first('username') }}</strong>
                                        </span>
                                    @endif
                                </div>
                            </div>

                            <div class="form-group input_group">
                                <p for="password" class="input_group_title">{{ __('Password') }}</p>

                                <div class="input_group_input">
                                    <input id="password" type="password" class="form-control{{ $errors->has('password') ? ' is-invalid' : '' }}" name="password" required>

                                    @if ($errors->has('password'))
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $errors->first('password') }}</strong>
                                        </span>
                                    @endif
                                </div>
                            </div>

                            <p class="log_forget_pass">
                            {{ __('Forgot Your Password?') }}
                            </p>

                            <!-- <div class="form-group row">
                                <div class="col-md-6 offset-md-4">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="remember" {{ old('remember') ? 'checked' : '' }}> {{ __('Remember Me') }}
                                        </label>
                                    </div>
                                </div>
                            </div> -->

                            <div class="form-group">
                                <div class="text_center log_button">
                                    <button type="submit" class="btn btn-primary">
                                        {{ __('Login') }}
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <p class="copy_right">COPYRIGHTS DREAMS GALLERY</p>
        </div>
    </div>
</div>
@endsection
<style>
/*============= login page ============*/
.login_page {
    background: #f3f3f359;
    position: fixed;
    width: 100%;
    height: 100vh;
    top: 0;
    left: 0;
    z-index: 1;
}
.login_page_main{}
    .login_page_main_title {
    font-size: 23px;
    color: #333;
    letter-spacing: 5px;
}
    .input_group {

}
.input_group_input input:focus{
    background: #d8d8d8;
    outline:none !important;
    border:none !important;
    box-shadow:none !important;
}
.log_button button:focus{
    box-shadow:none !important;
}
input:focus{

}
.input_group_input input {
    border-radius: 48px;
    height: 39px;
    background: #d8d8d86b;
    border: none;
    padding:0 15px;
    font-size: 13px;
}
.input_group_title {
    padding: 0 0 5px 13px;
    opacity: .7;
    font-size: 15px;
}
.input_group_input{}
.input_group_button{}
.log_forget_pass {
    text-align: right;
    margin: -10px 12px 0 0;
    opacity: .7;
}
.text_center{
    text-align: center;
}
.log_button {
    margin: 18px 0 0;
}


.log_button button:hover{
    border:none;
    background-color: #3a3838;
}
.log_button button {
    border-radius: 34px;
    padding: 11px 58px 10px;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: 2px;
    background: #524e4e;
    border: none;
}
.btn{
    border-radius: 34px;
    padding: 7px 32px 6px;
    text-transform: uppercase;
    font-size: 13px;
    letter-spacing: 2px;
    background: #524e4e;
    border: none;
}
.btn:hover{
    border:none;
    background-color: #3a3838;
}
.login_page_main_all{}
.copy_right {
    position: fixed;
    width: 100%;
    bottom: 122px;
    left: 0;
    text-align: center;
    opacity: .7;
    font-size:18px;
    letter-spacing: 7px;
}
.po {
    position: relative;
    width: 100%;
    height: 100%;
}.log_forget_pass {
    text-align: right;
    margin: -10px 12px 0 0;
    opacity: .7;
    font-size:15px;
}
.login_page_main_all {
    position: absolute !important;
    width: 100% !important;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
}
.{}
.{}
.{}
.{}
.{}
.{}
.{}
.{}
/*============= login page ============*/





@media only screen and (max-width: 750px) {
.copy_right {
    bottom: 18px;
    font-size: 12px;
    letter-spacing: 4px;
}
.log_forget_pass {
    font-size: 12px;
}









}
</style>