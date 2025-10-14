<x-guest-layout>
    {{-- Container utama dengan background gradien --}}
    <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-green-400 via-blue-500 to-indigo-600">

        <div class="w-full max-w-lg p-8 space-y-6 bg-gray-800 bg-opacity-40 rounded-xl shadow-2xl">
            
            <div class="text-center">
                <h1 class="text-4xl font-bold text-white tracking-wider">
                    Bank Sampah Sekolah
                </h1>
                <p class="text-gray-200 mt-2">
                    Selamat datang, silakan login ke akun Anda.
                </p>
            </div>
            
            <x-auth-session-status class="mb-4" :status="session('status')" />

            <form method="POST" action="{{ route('login') }}" class="mt-6 space-y-6">
                @csrf

                <div>
                    <label for="username" class="sr-only">Username</label>
                    <x-text-input 
                        id="username" 
                        type="text" 
                        name="username" 
                        :value="old('username')" 
                        required 
                        autofocus 
                        autocomplete="username" 
                        placeholder="Username" 
                        class="w-full bg-gray-700 bg-opacity-50 text-white border-gray-500 focus:ring-indigo-400 focus:border-indigo-400 placeholder-gray-300" 
                    />
                    <x-input-error :messages="$errors->get('username')" class="mt-2" />
                </div>

                <div>
                    <label for="password" class="sr-only">Password</label>
                    <x-text-input 
                        id="password" 
                        type="password" 
                        name="password" 
                        required 
                        autocomplete="current-password" 
                        placeholder="Password" 
                        class="w-full bg-gray-700 bg-opacity-50 text-white border-gray-500 focus:ring-indigo-400 focus:border-indigo-400 placeholder-gray-300" 
                    />
                    <x-input-error :messages="$errors->get('password')" class="mt-2" />
                </div>

                <div class="flex items-center justify-between text-sm">
                    <label for="remember_me" class="inline-flex items-center">
                        <input id="remember_me" type="checkbox" class="rounded border-gray-600 bg-gray-700 text-indigo-500 shadow-sm focus:ring-indigo-600" name="remember">
                        <span class="ms-2 text-gray-300">{{ __('Remember me') }}</span>
                    </label>

                    @if (Route::has('password.request'))
                        <a class="font-medium text-indigo-300 hover:text-indigo-200" href="{{ route('password.request') }}">
                            {{ __('Forgot your password?') }}
                        </a>
                    @endif
                </div>

                <div>
                    <x-primary-button class="w-full justify-center py-3 text-base font-semibold">
                        {{ __('Log In') }}
                    </x-primary-button>
                </div>
            </form>
        </div>
    </div>
</x-guest-layout>