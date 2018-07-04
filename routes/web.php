<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});



Route::post('/app/login','LoginController@login');
//update custom functions
Route::post('/app/settingUpdate','SettingController@updateSetting');
Route::post('/app/groupUpdate','GroupController@groupUpdate');
Route::post('/app/categoryUpdate','CategoryController@categoryUpdate');
Route::post('/app/unitUpdate','UnitController@unitUpdate');
//resources
Route::resource('/app/setting','SettingController');
Route::resource('/app/category','CategoryController');
Route::resource('/app/unit_type','UnitController');
Route::resource('/app/group','GroupController');
Route::resource('/app/product','ProductController');
//filtered 
Route::get('/app/categoryFiltered/{id}','CategoryController@categoryFiltered');


Route::post('/app/setting/upload','SettingController@upload');

Route::get('/logout', function () {
	Auth::logout();
   Session::flush();
	Session::forget('url.intented');
	return redirect("/");
    
});

Route::any('{slug}', [
   'uses' => 'StatusController@index',
])->where('slug', '([A-z\d-\/_.]+)?');