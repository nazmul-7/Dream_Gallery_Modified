<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Foundation\Auth\RegistersUsers;
class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    use RegistersUsers;

    /**
     * Where to redirect users after registration.
     *
     * @var string
     */
    protected $redirectTo = '/home';

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }
    public function phptest()
    {
        return date("Y-m-d");
        
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        return Validator::make($data, [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6|confirmed',
        ]);
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('home');
    }
    public function newUser(Request $request)
    {
        $user=new User;
        $user->name=$request->input('name');
        $user->email=$request->input('email');
        $user->userType=$request->input('userType');
        $user->username=$request->input('username');
        $user->password=bcrypt($request->input('password'));
        $user->save();
        return $user;
    }
    public function userList()
    {
        $data=User::get();
        return $data;
    }
    public function userUpdate(Request $request)
    {
        return User::where('id',$request->id)->update($request->all());
    }
    public function userRemove($id)
    {
        $group = User::where('id','=',$id)
          ->first();
        $group->delete();
        return $group;
        
    }

}
