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
        Schema::create('access_attempts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('employee_id') // Relación con la tabla employees
                ->constrained('employees') // Nombre de la tabla relacionada
                ->onDelete('cascade'); // Si un empleado es eliminado, eliminar sus intentos de acceso
            $table->boolean('was_successful'); // Indica si el acceso fue exitoso
            $table->timestamp('attempted_at'); // Fecha del intento de acceso
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('access_attempts');
    }
};
