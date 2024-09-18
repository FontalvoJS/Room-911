<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('access_attempts', function (Blueprint $table) {
            $table->dropForeign(['employee']);
            $table->unsignedBigInteger('employee')->nullable()->change();
            $table->foreign('employee')->references('id')->on('employees');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('access_attempts', function (Blueprint $table) {
            $table->dropForeign(['employee']);
            $table->unsignedBigInteger('employee')->nullable(false)->change();
            $table->foreign('employee')->references('id')->on('employees');
        });
    }
};
