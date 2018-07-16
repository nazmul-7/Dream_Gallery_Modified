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
    public function supplier()
    {
       return $this->belongsTo('App\Supplier');
    } 
}
