<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Setting extends Model
{
	protected $fillable = [
        'companyName','companyLogo','invoiceNote','currencyType', 'refererBonus' , 'referenceBonus','contact', 'address'
    ];
}
