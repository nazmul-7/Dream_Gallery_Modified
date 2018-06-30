<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Account_opening_balance extends Model
{
    protected $fillable = [
        'accountBalance', 'accountRemarks'
    ];
}
