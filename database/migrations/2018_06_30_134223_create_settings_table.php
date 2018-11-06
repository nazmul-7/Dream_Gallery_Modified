<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSettingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('settings', function (Blueprint $table) {
            $table->increments('id');
            $table->string('currencyType')->nullable()->default('BDT');
            $table->string('referenceBonus')->nullable()->default(0);
            $table->string('refererBonus')->nullable()->default(0);
            $table->string('companyName')->nullable();
            $table->string('companyLogo')->nullable();
            $table->string('contact')->nullable();
            $table->string('openingCash')->nullable();
            $table->text('address')->nullable();
            $table->text('invoiceNote')->nullable();


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
        Schema::dropIfExists('settings');
    }
}
