<?php

namespace Tests\Feature\Auth;

use App\Models\Pengguna; // Ganti User menjadi Pengguna
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AuthenticationTest extends TestCase
{
    use RefreshDatabase;

    public function test_login_screen_can_be_rendered(): void
    {
        $response = $this->get('/login');
        $response->assertStatus(200);
    }

    public function test_users_can_authenticate_using_the_login_screen(): void
    {
        $user = Pengguna::factory()->create(); // Ganti User menjadi Pengguna

        $response = $this->post('/login', [
            'username' => $user->username, // Ganti email menjadi username
            'password' => 'password',
        ]);

        $this->assertAuthenticated();
        $response->assertRedirect(route('dashboard', absolute: false));
    }

    public function test_users_can_not_authenticate_with_invalid_password(): void
    {
        $user = Pengguna::factory()->create(); // Ganti User menjadi Pengguna

        $this->post('/login', [
            'username' => $user->username, // Ganti email menjadi username
            'password' => 'wrong-password',
        ]);

        $this->assertGuest();
    }

    public function test_users_can_logout(): void
    {
        $user = Pengguna::factory()->create(); // Ganti User menjadi Pengguna

        $response = $this->actingAs($user)->post('/logout');

        $this->assertGuest();
        $response->assertRedirect('/');
    }
}