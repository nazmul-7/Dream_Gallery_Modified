<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Purchase;
use App\Invoice;
use Auth;
class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $product=Product::orderBy('id', 'desc')->get();
        return $product;
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
        $input['admin_id']=$admin_id;
        
        $created=Product::create($input);
        //set barcode
         $barCode=$created->id+1000000000;
         $data=array(
             'barCode' => $barCode
          );
        Product::where('id',$created->id)->update($data);
        $purchase=Purchase::create([
            'admin_id' => $admin_id,
            'product_id' => $created->id,
            'quantity' => $input['openingQuantity'],
            'unitPrice' => $input['openingUnitPrice'],

        ]);
        $settings=Product::where('id', $created->id)->first();
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


    }
        public function productUpdate(Request $request)
    {
        Product::where('id',$request->id)->update($request->all());
        $update=Product::where('id',$request->id)->first();
        return $update;

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $group = Product::where('id','=',$id)
          ->first();
          if($group->count()){
            $group->delete();
            return response()->json(['msg'=>'success','status'=>$id]);
          } else {
            return response()->json(['msg'=>'error','status'=>$id]);
          }
    }
}
