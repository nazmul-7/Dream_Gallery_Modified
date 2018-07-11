<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Invoice extends Model
{
	protected $fillable = [
        'type', 'totalQuantity','totalPrice','customer_id','supplier_id','date',
    ];
   
    public function customer()
    {
       return $this->belongsTo('App\Customer');
    } 
    public function supplier()
    {
       return $this->belongsTo('App\Supplier');
    } 
}
