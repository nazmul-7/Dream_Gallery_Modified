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
       return $this->belongsTo('App\Users','admin_id');
    }
    public function user()
    {
       return $this->belongsTo('App\Users','uid');
    }
}
