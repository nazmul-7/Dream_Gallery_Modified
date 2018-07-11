<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Purchase extends Model
{
	protected $fillable = [
        'invoice_id', 'product_id','quantity','unitPrice','hasReturned'
    ];
   
    public function invoice()
    {
       return $this->belongsTo('App\Customer');
    } 
    public function product()
    {
       return $this->belongsTo('App\Customer');
    } 
  
}
