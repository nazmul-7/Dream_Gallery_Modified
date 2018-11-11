<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePaymentsheetsTable extends Migration
{
    /**
     * Run the migrations.
     * THIS IS THE TABLE WHERE ALL KINDS PAYMENTS IS STORED INCLUDING EXPENSES
     * @return void
     */
    public function up()
    {
        Schema::create('paymentsheets', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('admin_id');
            $table->integer('uid')->nullable();
            $table->float('amount');
            $table->string('type')->default('incoming'); // incoming is profit, outgoing expense, due => due for supplier , due for customer 
            $table->string('paymentFor')->default('customer');  //  customer mean, I am selling to customer, supllier mean buying from suplier , voucher, discount
            $table->string('remarks')->nullable();
            $table->string('paymentMethod')->nullable()->default('cash'); 
            $table->integer('invoice_id')->nullable();
            $table->integer('payment_id')->nullable();
            $table->integer('voucher_id')->nullable();
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
        Schema::dropIfExists('paymentsheets');
    }
}
