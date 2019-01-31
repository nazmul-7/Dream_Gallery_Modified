<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
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
    public function getStockUnion($id)
    {
        $purchase=DB::table('purchases')
        ->select( 'admin_id as admin_id', 'invoice_id as invoice_id','product_id as product_id'
        , 'quantity as quantity', 'unitPrice as unitPrice', 'date as date', 'profit as profit')
        ->where('product_id',$id);
        $sell=Selling::union($purchase)
        ->select( 'admin_id as admin_id', 'invoice_id as invoice_id','product_id as product_id'
        , 'quantity as quantity', 'unitPrice as unitPrice', 'date as date', 'profit as profit')
        ->orderBy('invoice_id', 'asc')
        ->with('admin')
        ->with('invoice')
        ->where('product_id',$id)
        ->get();
        return response()->json([
                    'msg' => 'Found Stock',
                     'sell' => $sell,
                ],200);
    }
    public function getStockItem()
    {
        $product=Product::with(array('purchaseStock' => function($q)
        {

            $q->selectRaw('id, product_id, sum(quantity) as stock');
            $q->groupBy('product_id');
            $q->groupBy('product_id');


        }))->with(array('sellStock' => function($q)
        {
            $q->selectRaw('id, product_id, sum(quantity) as stock');
            $q->groupBy('product_id');


        }))
        ->get();

        return response()->json([
                     'msg' => 'Found Stock',
                     'product' => $product,
                ],200);
    }
    
}
