<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use App\Invoice;
use App\Purchase;
use App\Selling;
use App\Bonus;
use App\Paymentsheet;


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
            $selling = Selling::where('invoice_id','=',$id)
            ->delete();
            $purchase = Purchase::where('invoice_id','=',$id)
            ->delete();
            $paymentsheet = Paymentsheet::where('invoice_id','=',$id)
            ->delete();
            $bonus = Bonus::where('invoice_id','=',$id)
            ->delete();
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
        $bonus=Bonus::where('invoice_id',$id)
        ->where('type','withdraw')
        ->first();
        $due=Paymentsheet::where('invoice_id',$id)
        ->whereIn('type', ['due','dueIncoming'])
        ->sum('amount');
        $discount=Paymentsheet::where('invoice_id',$id)
        ->where('type', 'discount')
        ->sum('amount');

         return response()->json([
                'msg' => 'Inserted',
                'data' => $product,
                'bonus' => $bonus,
                'due' => $due,
                'discount' => $discount,
            ],200);
    }
    public function returnInvoice(Request $request)
    {
        $admin_id=Auth::user()->id;        
        $input=$request->all();
        // update invoice 
        $invoice=Invoice::create([
            'admin_id' => $admin_id,
            'type' => 'sell',
            'totalQuantity' => $input['totalQuantity'],
            'totalPrice' => $input['subTotal'],
            'customer_id' => $input['customer_id'],
            'discount' => $input['discount'],
            'sellingPrice' => $input['total'],
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);
        //
        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'invoice_id' => $invoice->id,
            'type' => 'incoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $input['customer_id'],
            'amount' => $input['paidAmount'],
            'paymentMethod' => 'cash',
            'remarks' => 'Sell To Customer',
            'date' => $input['date'],
        ]);
        //
        foreach ($input['newProduct'] as $key => $value) {
            if(!$value['discount'])
            $value['discount']=0;

            $profit= $value['discountedPrice'] - $value['averageBuyingPrice'];
            $sell=Selling::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'product_id' => $value['id'],
                'quantity' => $value['quantity'],
                'unitPrice' => $value['sellingPrice'],
                'discount' => $value['discount'],
                'profit' => $profit,
                'date' => $input['date'],
                
            ]);
        }
        $i=0;
        foreach ($input['productDetails'] as $key => $value) {
            if(!$value['discount'])
            $value['discount']=0;

            $profit= $value['discountedPrice'] - $value['product']['averageBuyingPrice'];
            if($value['quantity']>$input['productDetailsInvoice'][$i]['quantity'])
            {
                $purchase=Purchase::create([
                    'admin_id' => $admin_id,
                    'invoice_id' => $invoice->id,
                    'product_id' => $value['id'],
                    'quantity' => $value['quantity']-$input['productDetailsInvoice']['quantity'],
                    'unitPrice' => $value['unitPrice'],
                    'date' => $input['date'],
                    
                ]);
            }
            $i++;
        }

         return response()->json([
                 'msg' => 'updated',
            ],200);
    }
    public function returnAll($id)
    {
        $admin_id=Auth::user()->id;        
        $invoice=Invoice::where('id',$id)
        ->update([
            'totalQuantity' => 0,
            'totalPrice' => 0,
            'discount' => 0,
            'sellingPrice' => 0,
            'paidAmount' => 0,
        ]);
        $deleteAllPayment=Paymentsheet::where('invoice_id',$id)
        ->delete();
        $deleteAllSelling=Selling::where('invoice_id',$id)
        ->delete();
        $deleteAllBonus=Bonus::where('invoice_id',$id)
        ->delete();
        


         return response()->json([
                 'msg' => 'updated',
            ],200);
    }

}
