<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{

	protected $fillable = [
        'admin_id','type', 'totalQuantity','totalPrice', 'discount','sellingPrice', 'paidAmount','customer_id','supplier_id','date',
    ];
   
    public function customer()
    {
       return $this->belongsTo('App\Customer');
    } 
    public function selling()
    {
       return $this->hasMany('App\Selling');
    } 
    public function supplier()
    {
       return $this->belongsTo('App\Supplier');
    } 
    public function admin()
    {
       return $this->belongsTo('App\User', 'admin_id');
    } 
}
