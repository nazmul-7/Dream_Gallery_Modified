<?php

namespace App;
use Illuminate\Database\Eloquent\Model;

class Paymentsheet extends Model
{
    protected $fillable = [
        'admin_id','uid', 'amount','type','paymentFor','remarks','paymentMethod','invoice_id','date','payment_id','voucher_id'
    ];
    public function admin()
    {
       return $this->belongsTo('App\User','admin_id');
    }
    public function invoice()
    {
       return $this->belongsTo('App\Invoice','invoice_id');
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
