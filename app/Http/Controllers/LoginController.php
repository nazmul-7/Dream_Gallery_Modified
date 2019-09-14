<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
class LoginController extends Controller
{
    public function login(Request $request) 
	{   
		
		 
		
		if (Auth::attempt(['username' => $request->username, 'password' => $request->password ])) {
			
			return redirect("/");
		 }
		 else{
		
			return redirect("/login");
		 }
		
	}
}
