<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Product;
use App\Purchase;
use App\Invoice;
use App\Paymentsheet;
use App\Payment;
use App\Selling;
use App\Customer;
use Auth;
class ReportController extends Controller
{
    public function getProductProfit()
    {
        $data=Invoice::where('type','sell')
        ->orderBy('id', 'desc')
        ->sum('sellingPrice');
        $sell=Selling::with('product')
        ->orderBy('id', 'desc')
        ->get();

        return response()->json([
            'msg' => 'Data Came',
            'sell'=> $sell,
            'totalSelling'=> $data,
       ],200);
    }
    public function filterProfit($from,$to)
    {
        $data=Invoice::where('type','sell')
        ->whereBetween('date', array($from, $to))
        ->orderBy('id', 'desc')
        ->sum('sellingPrice');
        $sell=Selling::join('invoices', 'sellings.invoice_id', '=', 'invoices.id')
        ->select('sellings.*','invoices.date','invoices.customer_id')
        ->whereBetween('invoices.date', array($from, $to))
        ->with('product')
        ->orderBy('sellings.id', 'desc')
        ->get();

        return response()->json([
            'msg' => 'Data Came',
            'sell'=> $sell,
            'totalSelling'=> $data,
       ],200);
    }
    public function paymentList()
    {
        $data=Payment::orderBy('id', 'desc')
        ->with('admin')
        ->with('customer')
        ->with('supplier')
        ->get();
        return response()->json([
            'msg' => 'Data Came',
            'data'=> $data,
       ],200);

    }
    public function cash()
    {
        $data=Paymentsheet::orderBy('id', 'desc')
        ->with('admin')
        ->with('customer')
        ->with('supplier')
        ->whereIn('type',['incoming','dueincoming','outgoing'])
        ->get();
        return response()->json([
            'msg' => 'Data Came',
            'data'=> $data,
       ],200);

    }
    public function filterCash($from,$to)
    {
        date_default_timezone_set('Asia/Dhaka');
        $balance=Paymentsheet::orderBy('id', 'asc')
        ->whereBetween('date', array('2018-01-01',date('Y-m-d',(strtotime ( '-1 day' , strtotime ( $from) ) ))))
        ->whereIn('type',['incomingVoucher','outgoingVoucher','incoming','dueincoming','outgoing'])
        ->sum('amount');
        $data=Paymentsheet::orderBy('date', 'asc')
        ->with('admin')
        ->with('customer')
        ->with('supplier')
        ->whereBetween('date', array($from, $to))
        ->whereIn('type',['incomingVoucher','outgoingVoucher','incoming','dueincoming','outgoing'])
        ->get();
        $opening=Paymentsheet::orderBy('date', 'asc')
        ->with('admin')
        ->with('customer')
        ->with('supplier')
        ->whereBetween('date', array($from, $to))
        ->where('type','incoming')
        ->where('paymentFor','cash')
        ->first();

        return response()->json([
            'msg' => 'Data Came',
            'data'=> $data,
            'date'=> $from,
            'balance'=> $balance,
            'opening'=> $opening
        ],200);
    }
    public function dueList()
    {
        // $product=Customer::with(array('dueAmount' => function($q)
        //     {
        //         $q->selectRaw('sum(amount) as dueBalance');
        //         $q->groupBy('amount');
        //     }))
        //     ->get();
        $orders = Paymentsheet::with('customer')
                ->select('uid', DB::raw('SUM(amount) as total_due'),'date')
                ->groupBy('uid')
                ->whereIn('type',['due','opening','dueincoming'])
                ->where('paymentFor','customer')
                ->whereNotIn('uid',[1])
                ->get();
            return $orders;

    }
    public function dueListSupplier()
    {
        $orders = Paymentsheet::with('supplier')
                ->select('uid', DB::raw('SUM(amount) as total_due'),'date')
                ->groupBy('uid')
                ->whereIn('type',['due','opening','outgoing'])
                ->where('paymentFor','supplier')
                ->whereNotIn('uid',[1])
                ->get();
            return $orders;

    }
    public function discountReport($from,$to) 
    {
        $data = Paymentsheet::with('customer') 
                ->whereBetween('date', array($from, $to))
                ->with('admin')
                ->with('invoice')
                ->where('type','discount')
                ->where('paymentFor','customer')
                
              //  ->whereNotIn('uid',[1])
                ->get();
            return $data;

    }
}
