<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
	protected $fillable = [
        'catName', 'group_id'
    ];
   
    public function group()
    {
       return $this->belongsTo('App\Group');
    } 

   
}
