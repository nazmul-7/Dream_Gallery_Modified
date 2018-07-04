<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Category;
class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $category=Category::with('group')
        ->orderBy('id', 'desc')
        ->get();

        return $category;
    }
        public function categoryFiltered($id)
    {
        $category=Category::where('group_id', $id)
        ->with('group')
        ->orderBy('id', 'desc')
        ->get();
        
        return $category;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $created=Category::create($request->all());
        $settings=Category::where('id', $created->id)->with('group')->first();
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
        Category::where('id',$request->id)->update($request->all());
        $category=Category::where('id',$request->id)->with('group')->first();
        return $category;
    }
    public function categoryUpdate(Request $request)
    {
        Category::where('id',$request->id)->update($request->all());
        $category=Category::where('id',$request->id)->with('group')->first();
        return $category;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $group = Category::where('id','=',$id)
          ->first();
          if($group->count()){
            $group->delete();
            return response()->json(['msg'=>'success','status'=>$id]);
          } else {
            return response()->json(['msg'=>'error','status'=>$id]);
          }
    }
}
