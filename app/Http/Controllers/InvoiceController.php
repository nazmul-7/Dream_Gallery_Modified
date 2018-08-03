<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Invoice;
use App\Selling;

class InvoiceController extends Controller
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
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy = Invoice::where('id','=',$id)
          ->first();
          if($destroy->count()){
            $destroy->delete();
            return response()->json(['msg'=>'success','status'=>$id]);
          } else {
            return response()->json(['msg'=>'error','status'=>$id]);
          }
    }
    
    public function getInvoice($id)
    {
        if($id=='sell')
        {
        return Invoice::where('type', $id)
        ->orderBy('id', 'desc')
        ->with('customer')
        ->get();

        }
        elseif($id=='purchase')
        {
        return Invoice::where('type', $id)
        ->orderBy('id', 'desc')
        ->with('supplier')
        ->get();            
        }
    }
    public function searchInvoice($search)
    {
        
        $product=Invoice::where('id',$search)
        ->where('type','sell')
        ->with('customer')
        ->first();

        return $product;
    }
    public function getInvoiceProducts($id)
    {
        
        $product=Selling::where('invoice_id',$id)
        ->with('product')
        ->get();

         return response()->json([
                'msg' => 'Inserted',
                'data' => $product,
            ],200);
    }
    public function returnInvoice(Request $request)
    {
        
        $input=$request->all();
        // update invoice 
        $invoice=Invoice::update([
            'totalQuantity' => $input['totalQuantity'],
            'totalPrice' => $input['totalPrice'],
            'customer_id' => $input['customer_id'],
            'discount' => $input['discount'],
            'sellingPrice' => $input['total'],
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);

        if($input['total']==$input['paidAmount'])
        {
            $paymentSheet=Paymentsheet::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'type' => 'incoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                'uid' => $input['customer_id'],
                'amount' => $input['total'],
                'paymentMethod' => 'cash',
                'remarks' => 'Sell To Customer',
                'date' => $input['date'],
            ]);

        }
        else
        {
            $paymentSheet=Paymentsheet::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'type' => 'due',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                'uid' => $input['customer_id'],
                'amount' => $input['total']*-1,
                'paymentMethod' => 'due',
                'remarks' => 'Sell To Customer',
                'date' => $input['date'],
            ]);
            $due=$input['total'] - $input['paidAmount'];
            if($input['paidAmount'])
            {
                $paymentSheet=Paymentsheet::create([
                    'admin_id' => $admin_id,
                    'invoice_id' => $invoice->id,
                    'type' => 'dueIncoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                    'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                    'uid' => $input['customer_id'],
                    'amount' => $input['paidAmount'],
                    'paymentMethod' => 'cash',
                    'remarks' => 'Due To Customer',
                    'date' => $input['date'],
                ]);
    
            }       
        }
        if($input['discount'])
        {
            $paymentSheet=Paymentsheet::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'type' => 'outgoing',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                'uid' => $input['customer_id'],
                'amount' => $input['total'],
                'paymentMethod' => 'cash',
                'remarks' => 'Discount To Customer',
                'date' => $input['date'],
            ]);
        }
        // make  purchase details 
        foreach ($input['productDetails'] as $key => $value) {
            $profit= $value['discountedPrice'] - $value['averageBuyingPrice'];
            $sell=Selling::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'product_id' => $value['id'],
                'quantity' => $value['quantity'],
                'unitPrice' => $value['sellingPrice'],
                'discount' => $value['discount'],
                'profit' => $profit,
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

}
