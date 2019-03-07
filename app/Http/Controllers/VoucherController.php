<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Voucher;
use App\LedgerHead;
use App\Paymentsheet;
use Auth;
class VoucherController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data=Voucher::orderBy('id', 'desc')->get();
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
        $created=Voucher::create($request->all());
        if($input['type']=="Income")
        {
            $paymentSheet=Paymentsheet::create([
                'admin_id' => $admin_id,
                'uid' => $created->id,
                'type' => 'incomingVoucher',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                'paymentFor'=> 'voucher',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                'amount' => $input['amount'],
                'paymentMethod' => $input['ledgerName'],
                'remarks' =>  'Voucher : '.$input['ledgerName'],
                'voucher_id' => $created->id,
                'date' => $input['date'],
            ]);
    
        }
        else if($input['type']=="Investment")
        {
            $paymentSheet=Paymentsheet::create([
                'admin_id' => $admin_id,
                'uid' => $created->id,
                'type' => 'investmentVoucher',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                'paymentFor'=> 'voucher',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                'amount' => $input['amount'],
                'paymentMethod' => $input['ledgerName'],
                'remarks' =>  'Voucher : '.$input['ledgerName'],
                'voucher_id' => $created->id,
                'date' => $input['date'],
            ]);
    
        }
        else
        {
            $paymentSheet=Paymentsheet::create([
                'admin_id' => $admin_id,
                'uid' => $created->id,
                'type' => 'outgoingVoucher',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
                'paymentFor'=> 'voucher',//  customer mean, I am selling to customer, supllier mean buying from suplier 
                'amount' => $input['amount']*-1,
                'paymentMethod' => $input['ledgerName'],
                'remarks' =>  'Voucher : '.$input['ledgerName'],
                'voucher_id' => $created->id,
                'date' => $input['date'],
            ]);
        }
         return response()->json([
                 'msg' => 'Inserted',
                 'status' => $created
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
        //
    }

    public function voucherUpdate(Request $request)
    {
        Voucher::where('id',$request->id)->update($request->all());
        $data=Voucher::where('id',$request->id)->first();
        $input=$request->all();
        if($input['type']=='Income')
        {
            $payment=Paymentsheet::where('type','incomingVoucher')
            ->where('uid',$request->id)
            ->update([
                'amount' => $input['amount'],
                 
             ]);
    
        }
        else if($input['type']=='Investment')
        {
            $payment=Paymentsheet::where('type','incomingVoucher')
            ->where('uid',$request->id)
            ->update([
                'amount' => $input['amount'],
                 
             ]);
    
        }
        else
        {
            $payment=Paymentsheet::where('type','outgoingVoucher')
            ->where('uid',$request->id)
            ->update([
                'amount' => $input['amount']*-1,
                 
             ]);
 
        }
        return $data;
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy = Voucher::where('id','=',$id)
          ->first();
          $payment=Paymentsheet::where('paymentFor','voucher')
          ->where('uid',$id)
          ->delete();
          if($destroy->count()){
            $destroy->delete();
            return response()->json(['msg'=>'success','status'=>$id]);
          } else {
            return response()->json(['msg'=>'error','status'=>$id]);
          }
    }
        public function ledgerFiltered($id)
    {
        $data=LedgerHead::where('type', $id)
        ->orderBy('id', 'desc')
        ->get();
        
        return $data;
    }
    public function voucherData($from,$to)
    {
        date_default_timezone_set('Asia/Dhaka');
        

        $voucher = Voucher::whereBetween('date', array($from, $to)) 
                ->orderBy('id', 'desc')
                ->get();
            return $voucher;

    }
}
