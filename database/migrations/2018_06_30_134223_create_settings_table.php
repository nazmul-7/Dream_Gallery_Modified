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
            $table->string('openingStock')->nullable()->default(0);
            $table->string('openingBalance')->nullable()->default(0);
            $table->string('companyName')->nullable();
            $table->string('companyLogo')->nullable();
            $table->text('companyInfo')->nullable();


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
