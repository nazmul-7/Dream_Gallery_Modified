<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
class LoginController extends Controller
{
    public function login(Request $request)
	{
		\Log::info('code was here');
		
		
		if (Auth::attempt(['username' => $request->username, 'password' => $request->password ])) {
			\Log::info('user login');
			return redirect("/");
		 }
		 else{
			\Log::info('user cant  login');
			return redirect("/login");
		 }
		
	}
}
