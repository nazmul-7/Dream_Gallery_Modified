<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Product;
use App\Purchase;
use App\Invoice;
use App\Paymentsheet;
use App\Selling;
use Auth;

class PurchaseController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }
    public function filterPurchase($from,$to)
    {
        $data=Invoice::where('type','purchase')
        ->whereBetween('date', array($from, $to))
        ->with('admin')
        ->with('supplier')
        ->orderBy('id', 'desc')->get();
        return $data;
    }
    public function filterPurchaseItem($from,$to)
    {
        $data=Purchase::join('invoices', 'purchases.invoice_id', '=', 'invoices.id')
        ->select('purchases.*','invoices.date','invoices.supplier_id')
        ->whereBetween('invoices.date', array($from, $to))
        ->with('admin')
        ->with('product')
        ->orderBy('purchases.id', 'desc')->get();
        return $data;
    }  

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $admin_id=Auth::user()->id;
        $input=$request->all();

        // create invoice 
        $invoice=Invoice::create([
            'admin_id' => $admin_id,
            'type' => 'purchase',
            'totalQuantity' => $input['totalQuantity'],
            'totalPrice' => $input['totalPrice'],
            'supplier_id' => $input['supplier_id'],
            'date' => $input['date'],


        ]);
        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'invoice_id' => $invoice->id,
            'type' => 'due',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'supplier',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $input['supplier_id'],
            'amount' => $input['totalPrice'],
            'paymentMethod' => 'due',
            'remarks' => 'Purchased From Supplier',
            'date' => $input['date'],
        ]);

        // make  purchase details 

        foreach ($input['productDetails'] as $key => $value) {
            //averageBuyingPrice
            $product_id=$value['id'];
            $outStock = Selling::where('product_id' , $product_id)
            ->sum('quantity');
            $inStock=Purchase::where('product_id',$product_id)
            ->sum('quantity');

           $currentStock=$inStock - $outStock;

           $average= ( ($value['averageBuyingPrice']*$currentStock) + ($value['unitPrice']*$value['quantity'] ) ) / ( $currentStock + $value['quantity'] );
           $calculation = 'math: '.$value['averageBuyingPrice'].'*'.$currentStock. '+'. $value['unitPrice'].'*'.$value['quantity']. '/' .$currentStock .'+'. $value['quantity']. '=' .$average;
            $purchase=Purchase::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'product_id' => $value['id'],
                'quantity' => $value['quantity'],
                'unitPrice' => $value['unitPrice'],

            ]);

            Product::where('id',$product_id)->update([
                'averageBuyingPrice' => $average
            ]);
        }
        // $created=Invoice::create($request->all());
        $data=Invoice::where('type', 'purchase')
        ->where('id', $invoice->id)
        ->orderBy('id', 'desc')
        ->with('supplier')
        ->first();

         return response()->json([
                 'msg' => 'Inserted',
                 'data'=> $data,
            ],200);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        
        foreach($request->all() as $data){
        $purchase=new Purchase;
        $purchase->type='purchase';
        $purchase->invoice_id=$id;
        $purchase->product_id=$data['id'];
        $purchase->unitPrice=$data['unitPrice'];
        $purchase->quantity=$data['quantity'];
        $purchase->save();
        }
        return response()->json([
                 'msg' => 'Inserted',
            ],200);


    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
    public function searchProduct($search)
    {
        
        $product=Product::where('barCode',$search)

            ->with(array('purchaseStock' => function($q)
            {
                $q->selectRaw('id, product_id, sum(quantity) as stock');
                $q->groupBy('product_id');


            }))->with(array('sellStock' => function($q)
            {
                $q->selectRaw('id, product_id, sum(quantity) as stock');
                $q->groupBy('product_id');


            }))
            ->first();

        return $product;
    }

    public function purchaseInvoice(Request $request)
    {
        $input=$request->all();

        // create invoice 
        $invoice=Invoice::create([
            
            'totalQuantity' => $input['totalQuantity'],
            'totalPrice' => $input['totalPrice'],
            'supplier_id' => $input['supplier_id'],
            'date' => $input['date'],


        ]);

        // make  purchase details 

        foreach ($input['productDetails'] as $key => $value) {
            $purchase=Purchase::create([
               
                'invoice_id' => $invoice->id,
                'product_id' => $value['id'],
                'quantity' => $value['quantity'],
                'unitPrice' => $value['unitPrice'],
            ]);
        }

        // $created=Invoice::create($request->all());

         // return response()->json([
         //         'msg' => 'Inserted',
         //         'status' => $created,
         //         'id' => $created->id,
         //    ],200);
        
    }
    

}
