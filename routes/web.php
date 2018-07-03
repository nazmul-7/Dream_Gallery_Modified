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
Route::post('/app/settingUpdate','SettingController@updateSetting');
Route::post('/app/groupUpdate','GroupController@groupUpdate');

Route::resource('/app/category','CategoryController');
Route::resource('/app/group','GroupController');
Route::post('/app/setting/upload','SettingController@upload');
Route::resource('/app/setting','SettingController');

Route::get('/logout', function () {
	Auth::logout();
   Session::flush();
	Session::forget('url.intented');
	return redirect("/");
    
});

Route::any('{slug}', [
   'uses' => 'StatusController@index',
])->where('slug', '([A-z\d-\/_.]+)?');