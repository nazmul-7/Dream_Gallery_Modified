<?php

namespace App;
use Illuminate\Database\Eloquent\Model;

class Paymentsheet extends Model
{
    protected $fillable = [
        'admin_id','uid', 'amount','type','paymentFor','remarks','paymentMethod','invoice_id','date'
    ];
}
