<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
	protected $fillable = [
        'admin_id','productName','groupName','catName','brand','unit', 'size', 'color' , 'model', 'sellingPrice', 'barCode','productImage' ,'opening','facebook','instagram'
    ];
    public function selling()
    {
       return $this->belongsTo('App\Selling');
    }
    public function sellStock()
    {
       return $this->hasOne('App\Selling');
    } 
    public function purchase()
    {
       return $this->belongsTo('App\Purchase');
    } 
    public function purchaseStock()
    {
       return $this->hasOne('App\Purchase');
    }
    public function groupDiscount()
    {
       return $this->hasOne('App\Group');
    } 



    //public function 


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
