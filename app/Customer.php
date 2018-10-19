<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{

    protected $fillable = [
        'customerName', 'address', 'contact','email', 'zone', 'balance','opening','barcode'
    ];
}
