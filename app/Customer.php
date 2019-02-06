<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{

    protected $fillable = [
        'customerName', 'address', 'contact','email', 'zone', 'balance','opening','barcode','zoneId'
    ];
    public function dueAmount()
    {
       return $this->belongsTo('App\Paymentsheet','uid');
    } 
    public function bonus()
    {
       return $this->hasMany('App\Bonus');
    } 
    public function zoneInfo()
    {
       return $this->belongsTo('App\Zone','zoneId');
    } 

}
