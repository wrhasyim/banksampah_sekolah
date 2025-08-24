<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class JenisSampahFactory extends Factory
{
    public function definition(): array
    {
        return [
            // Ganti sentence(2) dengan cara yang lebih aman
            'nama_sampah' => fake()->words(2, true),
            'harga_per_satuan' => fake()->numberBetween(100, 2000),
            'stok' => 0,
        ];
    }
}