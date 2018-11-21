<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Selling extends Model
{

    protected $fillable = [
        'admin_id', 'invoice_id', 'product_id','quantity','unitPrice','hasReturned','profit','discount','date'
    ];
    public function invoice()
    {
       return $this->belongsTo('App\Invoice');
    }
    public function admin()
    {
       return $this->belongsTo('App\User', 'admin_id');
    } 
    public function product()
    {
       return $this->belongsTo('App\Product');
    }
   }
