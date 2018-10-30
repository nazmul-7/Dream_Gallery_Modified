<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Supplier;
use App\Category;
use App\Paymentsheet;
use Auth;
class SupplierController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $supplier=Supplier::orderBy('id', 'desc')
        ->get();
        return $supplier;
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
        $created=Supplier::create($request->all());
        $settings=Supplier::where('id', $created->id)->first();
        $input=$request->all();
        if($input['opening'])
        $input['opening']=$input['opening']*-1;

        $paymentSheet=Paymentsheet::create([
            'admin_id' => $admin_id,
            'type' => 'opening',// incoming is profit, outgoing expense, due => due for supplier , due for customer 
            'paymentFor'=> 'supplier',//  customer mean, I am selling to customer, supllier mean buying from suplier 
            'uid' => $created->id,
            'amount' => $input['opening']*-1,
            'paymentMethod' => 'due',
            'remarks' => 'Opening',
        ]);
        return $settings;

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
    public function supplierUpdate(Request $request)
    {
        Supplier::where('id',$request->id)->update($request->all());
        $supplier=Supplier::where('id',$request->id)->first();
        return $supplier;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $supplier = Supplier::where('id','=',$id)
          ->first();
          if($supplier->count()){
            $supplier->delete();
            return response()->json(['msg'=>'success','status'=>$id]);
          } else {
            return response()->json(['msg'=>'error','status'=>$id]);
          }
    }
}
