<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use Auth;

class StatusController extends Controller
{
    public function index()
    {
      
       return view('welcome');
    }
    public function password()
    {
      
       return \Hash::make('123456');
    }
}
