<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Setting;
use App\Paymentsheet;
class SettingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $settings=Setting::first();
        return $settings;
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
        $created=Setting::create($request->all());
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
        \Log::info('worked');
        //return Setting::where('id',$request->id)->update($request->all());
    }
    public function updateSetting(Request $request)
    {
        date_default_timezone_set('Asia/Dhaka');
        $date=date("Y-m-d");
        $input=$request->all();
        Paymentsheet::where('paymentFor','cash')
        ->update([
            'amount' => $input['openingCash'],
            'date'=> $date,
        ]);
        return Setting::where('id',$request->id)->update($request->all());
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

    // file upload

    public function upload(Request $request)
    {
       
        
        request()->file('img')->store('uploads');
        $pic= $request->img->hashName();
        /*update the profile pic*/
        Setting::where('id', $request->id)->update([
            'companyLogo' => $pic
        ]);
        return response()->json([
            'companyLogo'=> $pic
        ],200);
    }
}
