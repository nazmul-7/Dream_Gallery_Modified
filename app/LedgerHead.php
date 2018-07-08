<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class LedgerHead extends Model
{
    protected $fillable = [
        'ledgerName','type'
    ];
}
