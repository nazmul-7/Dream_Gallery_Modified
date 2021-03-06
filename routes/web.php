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



Route::get('/print','HomeController@print');
Route::get('/test','HomeController@test');



Route::get('/app/setup','SettingController@setup');
Route::post('/app/login','LoginController@login');
Route::post('/app/create','Auth/RegisterController@newUser');
Route::post('/app/newUser','HomeController@newUser');
Route::get('/app/userList','HomeController@userList');
Route::post('/app/userUpdate','HomeController@userUpdate');
Route::get('/app/userRemove/{id}','HomeController@userRemove');
Route::get('/app/authUser','SettingController@authUser');
Route::post('/app/changePassword','SettingController@changePassword');
//dashboard
Route::get('/app/salesData/{from}/{to}','DashboardController@salesData');

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


// product searching 
Route::post('/app/search/products', 'ProductController@search'); 










//resourcesc
Route::resource('/app/membership','MembershipController');
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
Route::get('/php/test','HomeController@phptest');
//uploads
Route::post('/app/setting/upload','SettingController@upload');

Route::get('/app/voucherdata/{from}/{to}','VoucherController@voucherData');
//purchase
Route::post('/app/purchaseInvoice','PurchaseController@purchaseInvoice');
Route::get('/app/getinvoice/{id}','InvoiceController@getInvoice');
//data collection
Route::get('/app/getInvoiceProducts/{id}','InvoiceController@getInvoiceProducts');
Route::get('/app/getStock/{id}','StockController@getStock');
Route::get('/app/payment/getOutstanding/{id}','PaymentController@getOutstanding');
Route::get('/app/payment/getOutstandingCustomer/{str}','PaymentController@getOutstandingCustomer');
Route::get('/app/payment/getLedgerSupplier/{id}','PaymentController@getLedgerSupplier');
Route::get('/app/payment/getLedgerCustomer/{id}','PaymentController@getLedgerCustomer');
Route::post('/app/paymentSupplier','PaymentController@paymentSupplier');
Route::post('/app/paymentCustomer','PaymentController@paymentCustomer');
Route::post('/app/returnInvoice','InvoiceController@returnInvoice');
Route::post('/app/exchangeProduct','InvoiceController@exchangeProduct');
Route::get('/app/returnAll/{id}','InvoiceController@returnAll');

//list

Route::get('/app/sellitemlist','SellingController@sellitemlist');
Route::get('/app/getProductProfit','ReportController@getProductProfit');
Route::get('/app/paymentList','ReportController@paymentList');
Route::get('/app/cash','ReportController@cash');
Route::get('/app/filterSale/{from}/{to}','SellingController@filterSale');
Route::get('/app/filterSaleNet/{from}/{to}','SellingController@filterSaleNet');
Route::get('/app/filterSaleItem/{from}/{to}','SellingController@filterSaleItem');
Route::get('/app/filterCash/{from}/{to}','ReportController@filterCash');
Route::get('/app/filterProfit/{from}/{to}','ReportController@filterProfit'); 
Route::get('/app/filterPurchase/{from}/{to}','PurchaseController@filterPurchase');
Route::get('/app/filterPurchaseItem/{from}/{to}','PurchaseController@filterPurchaseItem');
Route::get('/app/getStockList/{id}','StockController@getStockList');
Route::get('/app/getStockUnion/{id}','StockController@getStockUnion');
Route::get('/app/dueList','ReportController@dueList');
Route::get('/app/dueListSupplier','ReportController@dueListSupplier');
Route::get('/app/getStockItem','StockController@getStockItem');
Route::get('/app/getTotalStockItem','StockController@getTotalStockItem');
Route::get('/app/bonusLedger/{id}','MembershipController@bonusLedger');

Route::get('/app/paymentList/{from}/{to}','PaymentController@paymentList');
Route::get('/app/collectionList/{from}/{to}','PaymentController@collectionList');
Route::get('/app/collectionCancel/{id}','PaymentController@collectionCancel');
Route::get('/app/paymentCancel/{id}','PaymentController@paymentCancel');
Route::get('/app/discountReport/{from}/{to}','ReportController@discountReport');



Route::get('/logout', function () {
	Auth::logout();
    Session::flush();
	Session::forget('url.intented');
	return redirect("/login");
    
});
Auth::routes();


// Custom Controller V2



Route::get('/app/customerInfo/{key}','CustomController@searchCustomerInfo');
Route::get('/app/customerInfoOnEnter/{key}','CustomController@searchCustomerInfoOnEnter');
Route::get('/app/referencerInfo/{key}','CustomController@searchreferencerInfo');
Route::get('/app/referencerInfoOnEnter/{key}','CustomController@searchreferencerInfoOnEnter');

Route::get('/foullink','StatusController@password');
Route::any('{slug}', [
   'uses' => 'StatusController@index',
])->where('slug', '([A-z\d-\/_.]+)?')->middleware('auth');

