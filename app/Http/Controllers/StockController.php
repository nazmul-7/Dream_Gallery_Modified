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
    public function getStockItem(Request $request){
     
        $serch = $request->serchData;
        if($serch){
            $product=Product::where('barCode',$serch)->orWhere('groupName','like',$serch. '%')->orWhere('catName','like',$serch. '%')->orWhere('brand','like',$serch. '%')->orWhere('unit','like',$serch. '%')
            ->orWhere('size','like',$serch. '%')->orWhere('color','like',$serch. '%')->orWhere('model','like',$serch. '%')->orWhere('sellingPrice','like',$serch. '%')->orWhere('averageBuyingPrice','like',$serch. '%') 
            ->orWhere('productName','like',$serch. '%')->orWhere('openingQuantity','like',$serch. '%')->orWhere('openingUnitPrice','like',$serch. '%')
            ->with(array('purchaseStock' => function($q)
            
            {
    
                $q->selectRaw('id, product_id, sum(quantity) as stock');
                $q->groupBy('product_id');
                $q->groupBy('product_id');
    
    
            }))->with(array('sellStock' => function($q)
            {
                $q->selectRaw('id, product_id, sum(quantity) as stock');
                $q->groupBy('product_id');
    
    
            }))->paginate(20);
            return response()->json([
                'msg' => 'Found Stock',
                'product' => $product,
           ],200);
        }

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
        ->orderBy('productName','ASC')->paginate(20);

        return response()->json([
                     'msg' => 'Found Stock',
                     'product' => $product,
                ],200);
    }



    public function getTotalStockItem(){
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
        $totalStock = 0;
        $totalPrice = 0;
        //$product->toArray();
        foreach ($product as $d) {
          
           $d['currentStock']=0;
            //\Log::info($d);
            if($d['purchaseStock']){
                if($d['sellStock']!==null){
                    $d['currentStock']= $d['purchaseStock']['stock']-$d['sellStock']['stock'];
                }
                else{
                    
                    $d['currentStock']= $d['purchaseStock']['stock'];
                }
               
                
            }
                $d['totalCost']= $d['currentStock']*$d['averageBuyingPrice'];
                
               
            if($d['currentStock']>0){
                \Log::info($d['currentStock']);
               $totalStock = $totalStock + $d['currentStock'];
               $totalPrice = $totalPrice + $d['totalCost'];
                
            }
        }

        return response()->json([
                     'msg' => 'Found Stock Total Stock',
                     'totalStock' => $totalStock,
                     'totalPrice' => $totalPrice,
                     
                ],200);
    }


    
}
