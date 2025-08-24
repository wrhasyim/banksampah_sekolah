<?php

namespace Tests\Feature;

use App\Models\Pengguna; // Ganti User menjadi Pengguna
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ProfileTest extends TestCase
{
    use RefreshDatabase;

    public function test_profile_page_is_displayed(): void
    {
        $user = Pengguna::factory()->create(); // Ganti User menjadi Pengguna

        $response = $this
            ->actingAs($user)
            ->get('/profile');

        $response->assertOk();
    }

    public function test_profile_information_can_be_updated(): void
    {
        $user = Pengguna::factory()->create(); // Ganti User menjadi Pengguna

        $response = $this
            ->actingAs($user)
            ->patch('/profile', [
                'nama_lengkap' => 'Test Name', // Ganti name menjadi nama_lengkap
                'username' => 'testuser', // Ganti email menjadi username
            ]);

        $response
            ->assertSessionHasNoErrors()
            ->assertRedirect('/profile');

        $user->refresh();

        $this->assertSame('Test Name', $user->nama_lengkap);
        $this->assertSame('testuser', $user->username);
    }

    public function test_user_can_delete_their_account(): void
    {
        $user = Pengguna::factory()->create(); // Ganti User menjadi Pengguna

        $response = $this
            ->actingAs($user)
            ->delete('/profile', [
                'password' => 'password',
            ]);

        $response
            ->assertSessionHasNoErrors()
            ->assertRedirect('/');

        $this->assertGuest();
        $this->assertDatabaseMissing('pengguna', ['id' => $user->id]);
    }

    public function test_correct_password_must_be_provided_to_delete_account(): void
    {
        $user = Pengguna::factory()->create(['role' => 'admin']); // Gunakan admin agar bisa akses

        $response = $this
            ->actingAs($user)
            ->from('/profile')
            ->delete('/profile', [
                'password' => 'wrong-password',
            ]);

        $response
            ->assertSessionHasErrorsIn('userDeletion', 'password') // <-- Gunakan assertion yang lebih spesifik
            ->assertRedirect('/profile');

        $this->assertNotNull($user->fresh());
    }

}