<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Voucher extends Model
{
    protected $fillable = [
        'ledgerName','amount','type','date','remarks',
    ];
}
