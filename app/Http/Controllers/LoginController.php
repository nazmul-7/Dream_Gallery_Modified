<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
class LoginController extends Controller
{
    public function login(Request $request)
	{
		\Log::info('code was here');
		if (Auth::attempt(['email' => $request->email, 'password' => $request->password ])) {

			return response()->json([
				'user' => Auth::user()
			],200);

		}
		else{
			return response()->json([
				'msg' => 'Invalid Details!',
				'title' => 'Oops!'

			],401);
		}
	}
}
