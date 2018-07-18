<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Purchase;
use App\Invoice;
use App\Paymentsheet;
use App\Selling;
use Auth;
class SellingController extends Controller
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
        $admin_id=Auth::user()->id;
        $input=$request->all();

        // create invoice 
        $invoice=Invoice::create([
            'admin_id' => $admin_id,
            'type' => 'sell',
            'totalQuantity' => $input['totalQuantity'],
            'totalPrice' => $input['totalPrice'],
            'customer_id' => $input['customer_id'],
            'discount' => $input['discount'],
            'sellingPrice' => $input['total'],
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],


        ]);
        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'invoice_id' => $invoice->id,
            'type' => 'incoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $input['customer_id'],
            'amount' => $input['paidAmount'],
            'paymentMethod' => 'cash',
            'remarks' => 'Sell To Customer',
        ]);

        // make  purchase details 
        foreach ($input['productDetails'] as $key => $value) {
            $profit= $value['sellingPrice'] - $value['averageBuyingPrice'];
            $sell=Selling::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'product_id' => $value['id'],
                'quantity' => $value['quantity'],
                'unitPrice' => $value['sellingPrice'],
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
    

}
