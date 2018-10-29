<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use App\Invoice;
use App\Selling;
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
        $admin_id=Auth::user()->id;        
        $input=$request->all();
        // update invoice 
        $invoice=Invoice::where('id',$input['invoice_id'])
        ->update([
            'totalQuantity' => $input['totalQuantity'],
            'totalPrice' => $input['subTotal'],
            'customer_id' => $input['customer_id'],
            'discount' => $input['discount'],
            'sellingPrice' => $input['total'],
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);
        $currentSheets=Paymentsheet::where('invoice_id',$input['invoice_id'])
        ->get();
        foreach($currentSheets as $sheet )
        {
            if($sheet->type="incoming")
            {
                $paymentSheet=Paymentsheet::where('id',$sheet->id)
                ->update([
                    'uid' => $input['customer_id'],
                    'amount' => $input['total'],
                    'date' => $input['date'],
                ]);

            }
            if($sheet->type="due")
            {
                $paymentSheet=Paymentsheet::where('id',$sheet->id)
                ->update([
                    'uid' => $input['customer_id'],
                    'amount' => $input['total']*-1,
                    'date' => $input['date'],
                ]);

            }
            if($sheet->type="dueIncoming")
            {
                $paymentSheet=Paymentsheet::where('id',$sheet->id)
                ->update([
                    'uid' => $input['customer_id'],
                    'amount' => $input['paidAmount'],
                    'date' => $input['date'],
                ]);

            }
            if($sheet->type="outgoing")
            {
                $paymentSheet=Paymentsheet::where('id',$sheet->id)
                ->update([
                    'uid' => $input['customer_id'],
                    'amount' =>$input['subTotal']-$input['total'],
                    'date' => $input['date'],
                ]);

            }
            
        }
       
        // make  purchase details 
        foreach ($input['productDetails'] as $key => $value) {
            if($value['quantity']==0)
            {
                $sell=Selling::where('id',$value['id'] )
                ->update([
                    'quantity' => $value['quantity'],
                    'unitPrice' => 0,
                    'discount' => 0,
                    'profit' => 0,
                ]);
    
            }
            else
            {
                $profit= $value['discountedPrice'] - $value['product']['averageBuyingPrice'];
                $sell=Selling::where('id',$value['id'] )
                ->update([
                    'quantity' => $value['quantity'],
                    'unitPrice' => $value['product']['sellingPrice'],
                    'discount' => $value['discount'],
                    'profit' => $profit,
                ]);
            }
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
            'totalQuantity' => '0',
            'totalPrice' => '0',
            'customer_id' => '0',
            'discount' => $input['discount'],
            'sellingPrice' => $input['total'],
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);
        $currentSheets=Paymentsheet::where('invoice_id',$input['invoice_id'])
        ->get();
        foreach($currentSheets as $sheet )
        {
            if($sheet->type="incoming")
            {
                $paymentSheet=Paymentsheet::where('id',$sheet->id)
                ->update([
                    'uid' => $input['customer_id'],
                    'amount' => $input['total'],
                    'date' => $input['date'],
                ]);

            }
            if($sheet->type="due")
            {
                $paymentSheet=Paymentsheet::where('id',$sheet->id)
                ->update([
                    'uid' => $input['customer_id'],
                    'amount' => $input['total']*-1,
                    'date' => $input['date'],
                ]);

            }
            if($sheet->type="dueIncoming")
            {
                $paymentSheet=Paymentsheet::where('id',$sheet->id)
                ->update([
                    'uid' => $input['customer_id'],
                    'amount' => $input['paidAmount'],
                    'date' => $input['date'],
                ]);

            }
            if($sheet->type="outgoing")
            {
                $paymentSheet=Paymentsheet::where('id',$sheet->id)
                ->update([
                    'uid' => $input['customer_id'],
                    'amount' =>$input['subTotal']-$input['total'],
                    'date' => $input['date'],
                ]);

            }
            
        }
       
        // make  purchase details 
        foreach ($input['productDetails'] as $key => $value) {
            if($value['quantity']==0)
            {
                $sell=Selling::where('id',$value['id'] )
                ->update([
                    'quantity' => $value['quantity'],
                    'unitPrice' => 0,
                    'discount' => 0,
                    'profit' => 0,
                ]);
    
            }
            else
            {
                $profit= $value['discountedPrice'] - $value['product']['averageBuyingPrice'];
                $sell=Selling::where('id',$value['id'] )
                ->update([
                    'quantity' => $value['quantity'],
                    'unitPrice' => $value['product']['sellingPrice'],
                    'discount' => $value['discount'],
                    'profit' => $profit,
                ]);
            }
        }


         return response()->json([
                 'msg' => 'updated',
            ],200);
    }

}
