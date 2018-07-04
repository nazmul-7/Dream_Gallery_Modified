<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->increments('id');
            $table->string('groupName');
            $table->string('catName');
            $table->string('brand')->nullable();
            $table->string('unit')->nullable();
            $table->string('size')->nullable();
            $table->string('color')->nullable();
            $table->string('model');
            $table->string('sellingPrice');
            $table->string('productImage')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('products');
    }
}
