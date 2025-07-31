<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::table('conciertos', function (Blueprint $table) {
            $table->string('categoria')->nullable();
            $table->float('rating')->default(4.5);
        });
    }

    public function down(): void {
        Schema::table('conciertos', function (Blueprint $table) {
            $table->dropColumn(['categoria', 'rating']);
        });
    }
};
