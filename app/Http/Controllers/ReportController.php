<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Purchase;
use App\Invoice;
use App\Paymentsheet;
use App\Payment;
use App\Selling;
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
        ->where('type','incoming')
        ->orWhere('type','dueIncoming')
        ->orWhere('type','outgoing')
        ->get();
        return response()->json([
            'msg' => 'Data Came',
            'data'=> $data,
       ],200);

    }
}