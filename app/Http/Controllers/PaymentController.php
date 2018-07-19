<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Paymentsheet;
use App\Product;
use App\Purchase;
use App\Invoice;
use App\Payment;
use App\Selling;
use Auth;
class PaymentController extends Controller
{
    public function getOutstanding($id)
    {
        $outStanding=Paymentsheet::where('uid',$id)
        ->where('paymentFor','supplier')
        ->sum('amount');
        $ledger=Paymentsheet::where('uid',$id)
        ->where('paymentFor','supplier')
        ->get();
        

        return response()->json([
            'msg' => 'Found',
            'outStanding'=> $outStanding,
            'ledger'=> $ledger,
       ],200);
    }
    public function getOutstandingCustomer($id)
    {
        $outStanding=Paymentsheet::where('uid',$id)
        ->where('paymentFor','customer')
        ->sum('amount');
        $ledger=Paymentsheet::where('uid',$id)
        ->where('paymentFor','customer')
        ->get();
        

        return response()->json([
            'msg' => 'Found',
            'outStanding'=> $outStanding,
            'ledger'=> $ledger,
       ],200);
    }
    public function paymentSupplier(Request $request)
    {
        $admin_id=Auth::user()->id;
        $input=$request->all();
        // create invoice 
        $invoice=Payment::create([
            'admin_id' => $admin_id,
            'uid' => $input['supplier_id'],
            'type' => 'outgoing',
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);
        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'invoice_id' => 0,// 0 if its payment or voucher
            'type' => 'outgoing',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'supplier',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $input['supplier_id'],
            'amount' => $input['paidAmount']* -1,
            'paymentMethod' => 'cash',
            'date' => $input['date'],
            'remarks' => 'Pay to Supplier',
        ]);

        $data=Paymentsheet::where('id',$paymentSheet->id)
        ->first();        
         return response()->json([
                 'msg' => 'Inserted',
                 'data'=> $data,
            ],200);
    }
    public function paymentCustomer(Request $request)
    {
        $admin_id=Auth::user()->id;
        $input=$request->all();
        // create invoice 
        $invoice=Payment::create([
            'admin_id' => $admin_id,
            'uid' => $input['customer_id'],
            'type' => 'incoming',
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);
        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'invoice_id' => 0,// 0 if its payment or voucher
            'type' => 'incoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $input['customer_id'],
            'amount' => $input['paidAmount'],
            'paymentMethod' => 'cash',
            'date' => $input['date'],
            'remarks' => 'Paid by Customer',
        ]);

        $data=Paymentsheet::where('id',$paymentSheet->id)
        ->first();        
         return response()->json([
                 'msg' => 'Inserted',
                 'data'=> $data,
            ],200);
    }
    

}
