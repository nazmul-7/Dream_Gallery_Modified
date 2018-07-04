<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
	protected $fillable = [
        'groupName','catName','brand','unit', 'size', 'color' , 'model', 'sellingPrice',  
        'productImage', 
    ];
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
