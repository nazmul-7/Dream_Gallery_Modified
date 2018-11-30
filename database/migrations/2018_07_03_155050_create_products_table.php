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
            $table->integer('admin_id');
            $table->string('productName');
            $table->string('groupName');
            $table->string('catName');
            $table->string('brand')->nullable();
            $table->string('unit')->nullable();
            $table->string('size')->nullable();
            $table->string('color')->nullable();
            $table->string('model')->nullable()->unique();
            $table->string('sellingPrice');
            $table->string('averageBuyingPrice')->default(0);
            $table->string('barCode')->nullable();
            $table->string('productImage')->nullable();
            $table->date('date')->useCurrent();
            $table->string('openingQuantity')->nullable()->default(0);
            $table->string('openingUnitPrice')->nullable()->default(0);
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
