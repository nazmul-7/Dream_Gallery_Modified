<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Opening_stock_valuation extends Model
{
	protected $fillable = [
        'openingAmount', 'openingRemarks', 'currencySign'
    ];
}
