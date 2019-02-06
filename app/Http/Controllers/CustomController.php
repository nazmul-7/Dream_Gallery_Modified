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
                        ->with('zoneInfo')
                        ->get();
    }

    public function searchCustomerInfoOnEnter($key){

       

        return Customer::where('customerName',$key)
                        ->orwhere('contact',$key)
                        ->orwhere('barcode',$key)
                        ->with('zoneInfo')->first();
    }
    public function searchreferencerInfo($key){

        $key = "%$key%";

         return Customer::whereNotNull('barcode')
                        ->where(function($query) use ($key){
                            $query->where('customerName', 'Like',$key);
                            $query->orwhere('contact', 'Like',$key);
                            $query->orwhere('barcode', 'Like',$key);
                                  
                            })->get();

                        
    }

    public function searchreferencerInfoOnEnter($key){

       

        return Customer::whereNotNull('barcode')
                        ->where(function($query) use ($key){
                         $query->where('customerName' ,$key);
                         $query->orwhere('contact' ,$key);
                         $query->orwhere('barcode' ,$key);          
                         })->first();
    }
}
