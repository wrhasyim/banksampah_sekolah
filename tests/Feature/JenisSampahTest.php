<?php

// tests/Feature/JenisSampahTest.php

use App\Models\JenisSampah;
use App\Models\Pengguna;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase; // <-- Tambahkan ini untuk mengaktifkan helper Laravel

// uses() adalah cara Pest untuk menerapkan traits
uses(TestCase::class, RefreshDatabase::class); // <-- Tambahkan TestCase::class

// --- TES OTORISASI ---
test('hanya admin yang bisa mengakses halaman kelola jenis sampah', function () {
    $siswaUser = Pengguna::factory()->create(['role' => 'siswa']);
    $adminUser = Pengguna::factory()->create(['role' => 'admin']);

    $this->actingAs($siswaUser)->get(route('jenis-sampah.index'))
        ->assertForbidden();

    $this->actingAs($adminUser)->get(route('jenis-sampah.index'))
        ->assertOk();
});

test('tamu (guest) tidak bisa mengakses halaman kelola jenis sampah', function () {
    $this->get(route('jenis-sampah.index'))
        ->assertRedirect(route('login'));
});


// --- TES FUNGSIONALITAS ---
test('admin bisa melihat data jenis sampah di halaman index', function () {
    $sampah = JenisSampah::factory()->create(['nama_sampah' => 'Botol Kaca']);
    $admin = Pengguna::factory()->create(['role' => 'admin']);

    $this->actingAs($admin)->get(route('jenis-sampah.index'))
        ->assertOk()
        ->assertSeeText('Botol Kaca');
});

test('admin bisa menambahkan jenis sampah baru', function () {
    $admin = Pengguna::factory()->create(['role' => 'admin']);
    $dataBaru = ['nama_sampah' => 'Kaleng Aluminium', 'harga_per_satuan' => 1500];

    $this->actingAs($admin)->post(route('jenis-sampah.store'), $dataBaru)
        ->assertRedirect(route('jenis-sampah.index'));
    
    $this->assertDatabaseHas('jenis_sampah', $dataBaru);
});

test('admin bisa mengupdate data jenis sampah', function () {
    $admin = Pengguna::factory()->create(['role' => 'admin']);
    $sampah = JenisSampah::factory()->create();
    $dataUpdate = ['nama_sampah' => 'Kertas Koran', 'harga_per_satuan' => 800];

    $this->actingAs($admin)->put(route('jenis-sampah.update', $sampah->id), $dataUpdate);
    
    $this->assertDatabaseHas('jenis_sampah', $dataUpdate);
});

test('admin bisa menghapus data jenis sampah', function () {
    $admin = Pengguna::factory()->create(['role' => 'admin']);
    $sampah = JenisSampah::factory()->create();

    $this->actingAs($admin)->delete(route('jenis-sampah.destroy', $sampah->id));

    $this->assertDatabaseMissing('jenis_sampah', ['id' => $sampah->id]);
});