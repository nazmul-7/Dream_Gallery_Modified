<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
	protected $fillable = [
        'companyName','companyLogo','companyInfo','currencyType', 'unitType', 'openingStock' , 'openingBalance'
    ];
}
