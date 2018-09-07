<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateInvoicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('invoices', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('admin_id');
            $table->string('type')->default('purchase');
            $table->integer('totalQuantity');
            $table->float('totalPrice');
            $table->integer('discount')->default(0);
            $table->float('sellingPrice')->default(0);
            $table->float('paidAmount')->default(0);
            $table->integer('customer_id')->nullable()->default(0);
            $table->integer('supplier_id')->nullable()->default(0);
            $table->date('date')->nullable();
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
        Schema::dropIfExists('invoices');
    }
}
