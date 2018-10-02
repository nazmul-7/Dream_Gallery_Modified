<?php

namespace App\Http\Controllers;
use App\Product;
use App\Purchase;
use App\Invoice;
use App\Selling;
use Illuminate\Http\Request;

class StockController extends Controller
{
    public function getStock($id)
    {
        $purchase=Purchase::where('product_id','=',$id)
        ->sum('quantity');
        $sell=Selling::where('product_id','=',$id)
        ->sum('quantity');
        $stock =$purchase - $sell;
        return response()->json([
                     'msg' => 'Found Stock',
                     'data' => $stock,
                ],200);
    }
    public function getStockList($id)
    {
        $purchase=Purchase::where('product_id','=',$id)
        ->get();
        $sell=Selling::where('product_id','=',$id)
        ->get();
        return response()->json([
                     'msg' => 'Found Stock',
                     'purchase' => $purchase,
                     'sell' => $sell,
                ],200);
    }
    
}
