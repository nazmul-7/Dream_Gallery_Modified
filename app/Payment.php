<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    protected $fillable = [
        'admin_id','uid', 'type','paidAmount','date'
    ];
    public function admin()
    {
       return $this->belongsTo('App\User','admin_id');
    }
    public function customer()
    {
       return $this->belongsTo('App\Customer','uid');
    }
    public function supplier()
    {
       return $this->belongsTo('App\Supplier','uid');
    }
}
