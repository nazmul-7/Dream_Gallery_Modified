<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
	protected $fillable = [
        'admin_id','productName','groupName','catName','brand','unit', 'size', 'color' , 'model', 'sellingPrice', 'barCode','productImage', 
    ];
    public function selling()
    {
       return $this->belongsTo('App\Selling');
    } 
    public function purchase()
    {
       return $this->belongsTo('App\Purchase');
    } 
    // public function group()
    // {
    //    return $this->belongsTo('App\Group');
    // }
    // public function category()
    // {
    //    return $this->belongsTo('App\Group');
    // }
    //     public function unit_type()
    // {
    //    return $this->belongsTo('App\Unit_type');
    // } 
}
