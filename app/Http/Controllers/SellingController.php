<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Product;
use App\Purchase;
use App\Payment;
use App\Invoice;
use App\Paymentsheet;
use App\Selling;
use App\Bonus;
use App\Setting;
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
        $data=Invoice::where('type','sell')
        ->with('admin')
        ->with('customer')
        ->orderBy('id', 'desc')->get();
        return $data;
    }
    public function filterSale($from,$to)
    {
        $data=Invoice::where('type','sell')
        ->whereBetween('date', array($from, $to))
        ->with('admin')
        ->with('selling')
        ->with('customer')
        ->orderBy('id', 'asc')
        ->get();
        return $data;
    }
    public function filterSaleItem($from,$to)
    {
        $data=Selling::join('invoices', 'sellings.invoice_id', '=', 'invoices.id')
        ->select('sellings.*','invoices.date as date')
        ->whereBetween('invoices.date', array($from, $to))
        ->with('admin')
        ->with('product')
        ->orderBy('sellings.id', 'desc')->get();
        return $data;
    }    
    public function sellitemlist()
    {
        $data=Selling::with('admin')
        ->with('product')
        ->orderBy('id', 'desc')->get();
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
        $setting=Setting::first();
        $input=$request->all();
        if(!$input['customer_id'])
        $input['customer_id']=1;
        
        // create invoice 
        $paidAmount=$input['paidAmount']+$input['bonusAmount'];
        $invoice=Invoice::create([
            'admin_id' => $admin_id,
            'type' => 'sell',
            'totalQuantity' => $input['totalQuantity'],
            'totalPrice' => $input['totalPrice'],
            'customer_id' => $input['customer_id'],
            'discount' => $input['discount'],
            'sellingPrice' => $input['total']+$input['bonusAmount'],
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);
        $payment=Payment::create([
            'admin_id' => $admin_id,
            'uid' => $input['customer_id'],
            'type' => 'incoming',
            'paidAmount' => $input['paidAmount'],
            'date' => $input['date'],
        ]);

        if($input['total']==$input['paidAmount'])
        {
            if($input['customer_id']==1)
            {
                $paymentSheet=Paymentsheet::create([
                    'admin_id' => $admin_id,
                    'invoice_id' => $invoice->id,
                    'type' => 'incoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                    'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                    'uid' => $input['customer_id'],
                    'amount' => $input['total']+$input['bonusAmount'],
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
                    'amount' => ($input['total']+$input['bonusAmount'])*-1,
                    'paymentMethod' => 'cash',
                    'remarks' => 'Sell To Customer',
                    'date' => $input['date'],
                ]);
                $paymentSheet=Paymentsheet::create([
                    'admin_id' => $admin_id,
                    'invoice_id' => $invoice->id,
                    'type' => 'dueIncoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                    'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                    'uid' => $input['customer_id'],
                    'amount' => $input['total']+$input['bonusAmount'],
                    'paymentMethod' => 'cash',
                    'remarks' => 'Sell To Customer',
                    'date' => $input['date'],
                ]);
    
    

            }

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
            $due=$input['total'] - $paidAmount;
            if($paidAmount)
            {
                $paymentSheet=Paymentsheet::create([
                    'admin_id' => $admin_id,
                    'invoice_id' => $invoice->id,
                    'type' => 'dueIncoming',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                    'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                    'uid' => $input['customer_id'],
                    'amount' => $paidAmount,
                    'paymentMethod' => 'cash',
                    'remarks' => 'Advance Cash on Sale To Customer',
                    'date' => $input['date'],
                ]);
    
            }       
        }
        if($input['discount'])
        {
            $paymentSheet=Paymentsheet::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'type' => 'discount',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                'uid' => $input['customer_id'],
                'amount' => ($input['total']*$input['discount']/100)*-1,
                'paymentMethod' => 'cash',
                'remarks' => 'Discount To Customer',
                'date' => $input['date'],
            ]);
        }
        if($input['bonusAmount']>0)
        {
            $paymentSheet=Paymentsheet::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'type' => 'bonus',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                'uid' => $input['customer_id'],
                'amount' => $input['bonusAmount']*(-1),
                'paymentMethod' => 'cash',
                'remarks' => 'Customer Bonus Payment',
                'date' => $input['date'],
            ]);
            $paymentSheet=Bonus::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'customer_id' => $input['customer_id'],
                'amount' => $input['bonusAmount']*-1,
                'type' => 'withdraw',
                'bonusBy' => '',
                'date' => $input['date'],
            ]);

        }
        if($input['reference_id'] &&  $input['customer_id'])
        {
            // $bonusAmount=$input['total']*$setting->refererBonus)/100
            // $outstanding=Paymentsheet::where('customer_id',$input['reference_id'])
            // ->whereIn('type',['due','opening','dueincoming'])
            // ->sum('amount')

            // if($outstanding>0)

            $paymentSheet=Bonus::create([
                'admin_id' => $admin_id,
                'invoice_id' => $invoice->id,
                'customer_id' => $input['reference_id'],
                'amount' => ($input['total']*$setting->refererBonus)/100,
                'type' => 'gift',
                'bonusBy' => $input['customer_id'],
                'date' => $input['date'],
            ]);

        }        // make  purchase details 
        foreach ($input['productDetails'] as $key => $value) {
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
        // $created=Invoice::create($request->all());
        $data=Invoice::where('type', 'sell')
        ->where('id', $invoice->id)
        ->orderBy('id', 'desc')
        ->with('customer')
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
        $data=Selling::with('product')
        ->where('invoice_id',$id)
        ->orderBy('id', 'asc')
        ->get();
        return $data;
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
