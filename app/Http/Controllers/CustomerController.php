<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Customer;
use App\Paymentsheet;
use Auth;

class CustomerController extends Controller
{
/**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    // public function index()
    // {
    //     $data=Customer::whereNotIn('id',[1])
    //     ->orderBy('customerName', 'asc')->get();
    //     return $data;
    // }
    public function getSearchData(Request $request){

        $search = $request->searchData;
        if($search){
           return $data=Customer::whereNotIn('id',[1])->where('customerName','like', '%'.$search.'%')->orWhere('address','like', '%'.$search.'%')
           ->orWhere('contact','like','%'.$search.'%')->orWhere('email','like', '%'.$search.'%')->orWhere('zone','like', '%'.$search.'%')
           ->orWhere('opening','like', '%'.$search.'%') ->orderBy('customerName', 'asc')->get();;
        }
        $data=Customer::whereNotIn('id',[1])
        ->orderBy('customerName', 'asc')->get();
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
        date_default_timezone_set('Asia/Dhaka');
        $date=date("Y-m-d");
        $admin_id=Auth::user()->id;
        $created=Customer::create($request->all());
        $input=$request->all();
        //if($input['opening'])
        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'type' => 'opening',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'customer',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $created->id,
            'amount' => $input['opening']*-1,
            'paymentMethod' => 'due',
            'date'=> $date,
            'remarks' => 'Opening',
        ]);
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
        public function customerUpdate(Request $request)
    {
        Customer::where('id',$request->id)->update($request->all());
        $data=Customer::where('id',$request->id)->first();
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
        $customer = Customer::where('id','=',$id)
          ->first();
          if($customer->count()){
            $customer->delete();
            return response()->json(['msg'=>'success','status'=>$id]);
          } else {
            return response()->json(['msg'=>'error','status'=>$id]);
          }
    }
}
