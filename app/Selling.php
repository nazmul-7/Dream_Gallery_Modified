<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Selling extends Model
{

    protected $fillable = [
        'admin_id', 'invoice_id', 'product_id','quantity','unitPrice','hasReturned','profit'
    ];
}
