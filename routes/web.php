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

// Route::get('/', function () {
//     return view('welcome');
// });



Route::post('/app/login','LoginController@login');
Route::post('/app/create','Auth/RegisterController@newUser');
Route::post('/app/userList','HomeController@userList');
//update custom functions
Route::post('/app/settingUpdate','SettingController@updateSetting');
Route::post('/app/groupUpdate','GroupController@groupUpdate');
Route::post('/app/categoryUpdate','CategoryController@categoryUpdate');
Route::post('/app/unitUpdate','UnitController@unitUpdate');
Route::post('/app/supplierUpdate','SupplierController@supplierUpdate');
Route::post('/app/customerUpdate','CustomerController@customerUpdate');
Route::post('/app/zoneUpdate','ZoneController@zoneUpdate');
Route::post('/app/ledgerUpdate','LedgerController@ledgerUpdate');
Route::post('/app/voucherUpdate','VoucherController@voucherUpdate');
Route::post('/app/productUpdate','ProductController@productUpdate');
//resourcesc
Route::resource('/app/category','CategoryController');
Route::resource('/app/unit_type','UnitController');
Route::resource('/app/group','GroupController');
Route::resource('/app/product','ProductController');
Route::resource('/app/supplier','SupplierController');
Route::resource('/app/customer','CustomerController');
Route::resource('/app/zone','ZoneController');
Route::resource('/app/ledger','LedgerController');
Route::resource('/app/voucher','VoucherController');
Route::resource('/app/purchase','PurchaseController');
Route::resource('/app/sell','SellingController');
Route::resource('/app/invoice','InvoiceController');
Route::resource('/app/setting','SettingController');
//filtered 
Route::get('/app/categoryFiltered/{id}','CategoryController@categoryFiltered');
Route::get('/app/ledgerFiltered/{id}','VoucherController@ledgerFiltered');
Route::get('/app/searchProduct/{id}','PurchaseController@searchProduct');
Route::get('/app/searchInvoice/{id}','InvoiceController@searchInvoice');

//uploads
Route::post('/app/setting/upload','SettingController@upload');

//purchase
Route::post('/app/purchaseInvoice','PurchaseController@purchaseInvoice');
Route::get('/app/getinvoice/{id}','InvoiceController@getInvoice');
//data collection
Route::get('/app/getInvoiceProducts/{id}','InvoiceController@getInvoiceProducts');
Route::get('/app/getStock/{id}','StockController@getStock');
Route::get('/app/payment/getOutstanding/{id}','PaymentController@getOutstanding');
Route::get('/app/payment/getOutstandingCustomer/{id}','PaymentController@getOutstandingCustomer');
Route::get('/app/payment/getLedgerSupplier/{id}','PaymentController@getLedgerSupplier');
Route::get('/app/payment/getLedgerCustomer/{id}','PaymentController@getLedgerCustomer');
Route::post('/app/paymentSupplier','PaymentController@paymentSupplier');
Route::post('/app/paymentCustomer','PaymentController@paymentCustomer');
Route::post('/app/returnInvoice','InvoiceController@returnInvoice');
Route::post('/app/returnAll/{id}','InvoiceController@returnAll');

//list
Route::get('/app/sellitemlist','SellingController@sellitemlist');
Route::get('/app/getProductProfit','ReportController@getProductProfit');
Route::get('/app/paymentList','ReportController@paymentList');
Route::get('/app/cash','ReportController@cash');
Route::get('/app/filterSale/{from}/{to}','SellingController@filterSale');
Route::get('/app/filterSaleItem/{from}/{to}','SellingController@filterSaleItem');
Route::get('/app/filterCash/{from}/{to}','ReportController@filterCash');
Route::get('/app/filterProfit/{from}/{to}','ReportController@filterProfit');
Route::get('/app/filterPurchase/{from}/{to}','PurchaseController@filterPurchase');
Route::get('/app/filterPurchaseItem/{from}/{to}','PurchaseController@filterPurchaseItem');
Route::get('/app/getStockList/{id}','StockController@getStockList');
Route::get('/app/getStockUnion/{id}','StockController@getStockUnion');
Route::get('/app/dueList','ReportController@dueList');



Route::get('/logout', function () {
	Auth::logout();
    Session::flush();
	Session::forget('url.intented');
	return redirect("/login");
    
});
Auth::routes();
Route::any('{slug}', [
   'uses' => 'StatusController@index',
])->where('slug', '([A-z\d-\/_.]+)?')->middleware('auth');