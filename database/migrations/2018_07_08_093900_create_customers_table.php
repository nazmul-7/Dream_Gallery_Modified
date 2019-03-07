<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCustomersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('customers', function (Blueprint $table) {
            $table->increments('id');
            $table->string('customerName');
            $table->string('address')->nullable();
            $table->string('contact')->unique();
            $table->string('email')->nullable();
            $table->string('zone');
            $table->string('barcode')->nullable();
            $table->integer('zoneId')->default(1);
            $table->string('opening')->nullable()->default(0);
            $table->string('balance')->default(0);
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
        Schema::dropIfExists('customers');
    }
}
