<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Bonus extends Model
{
        protected $fillable = [
        'admin_id','user_id','invoice_id', 'amount','type','date','bonusBy'
    ];
    public function admin()
    {
       return $this->belongsTo('App\User','admin_id');
    }
    public function customer()
    {
       return $this->belongsTo('App\Customer','user_id');
    }

}
