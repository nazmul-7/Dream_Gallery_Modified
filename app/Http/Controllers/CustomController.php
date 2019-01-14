<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Customer;

class CustomController extends Controller{

    public function searchCustomerInfo($key){

        $key = "%$key%";

        return Customer::where('customerName', 'Like',$key)
                        ->orwhere('contact', 'Like',$key)
                        ->orwhere('barcode', 'Like',$key)
                        ->get();
    }

    public function searchCustomerInfoOnEnter($key){

       

        return Customer::where('customerName',$key)
                        ->orwhere('contact',$key)
                        ->orwhere('barcode',$key)
                        ->first();
    }
    public function searchreferencerInfo($key){

        $key = "%$key%";

        return Customer::where('barcode', 'Like',$key)
                        ->get();
    }

    public function searchreferencerInfoOnEnter($key){

       

        return Customer::where('barcode',$key)
                        ->first();
    }
}
