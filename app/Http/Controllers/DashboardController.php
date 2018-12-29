<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Paymentsheet;
use App\Invoice;
use App\Selling;

class DashboardController extends Controller
{
    public function salesData($from,$to)
    {
        date_default_timezone_set('Asia/Dhaka');
        $date=date("Y-m-d");

        $pettycash=Paymentsheet::orderBy('id', 'desc')
        ->whereBetween('date', array('2010-02-19', $date))
        ->whereIn('type',['incoming','dueincoming','outgoing','outgoingVoucher','incomingVoucher','investmentVoucher','bonus'])
        ->sum('amount');
        $todayssale=Invoice::orderBy('id', 'desc')
        ->where('date',  $date)
        ->where('type','sell')
        ->sum('totalPrice');
        $todayscollection=Paymentsheet::orderBy('id', 'desc')
        ->where('date',  $date)
        ->whereIn('type',['incoming','dueincoming','incomingVoucher','bonus'])
        ->sum('amount');
        $todayspayment=Paymentsheet::orderBy('id', 'desc')
        ->where('date',  $date)
        ->where('type','outgoing')
        ->sum('amount');
        $customerOutstanding = Paymentsheet::orderBy('id', 'desc')
        ->whereIn('type',['due','opening','dueincoming'])
        ->where('paymentFor','customer')
        ->sum('amount');
        $supplierOutstanding = Paymentsheet::orderBy('id', 'desc')
        ->whereIn('type',['due','opening','outgoing'])
        ->where('paymentFor','supplier')
        ->sum('amount');

        $sales = Selling::whereBetween('date', array($from, $to))        
        ->select('date', DB::raw('SUM(unitPrice) as total_sale'))
        ->groupBy('date')
        ->get();
        $quantity = Selling::whereBetween('date', array($from, $to))        
        ->select('date', DB::raw('SUM(quantity) as total_quantity'))
        ->groupBy('date')
        ->get();
        $profit = Selling::whereBetween('date', array($from, $to)) 
        ->select('date', DB::raw('SUM(quantity) as total_quantity'))
        ->groupBy('date')
        ->get();

        return response()->json([
                'msg' => 'Inserted',
                'date' => $date,
                'pettycash' => $pettycash,
                'todayssale' => $todayssale,
                'todayscollection' => $todayscollection,
                'todayspayment' => $todayspayment,
                'customerOutstanding' => $customerOutstanding,
                'supplierOutstanding' => $supplierOutstanding,
                'sales' => $sales,
                'profit' => $profit,
                'quantity' => $quantity,
            ],200);

    }
}
