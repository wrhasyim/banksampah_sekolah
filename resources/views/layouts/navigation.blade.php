<nav x-data="{ open: false }" class="bg-white border-b border-gray-100 dark:bg-gray-800 dark:border-gray-700">
    <div class="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex">
                <div class="flex items-center shrink-0">
                    <a href="{{ route('dashboard') }}">
                        <x-application-logo class="block w-auto text-gray-800 fill-current h-9 dark:text-gray-200" />
                    </a>
                </div>

                <div class="hidden space-x-8 sm:-my-px sm:ml-10 sm:flex">
                    <x-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')">
                        {{ __('Dashboard') }}
                    </x-nav-link>

                    {{-- Tambahkan Link Leaderboard di sini --}}
                    @if(Auth::user()->role == 'admin')
                    <x-nav-link :href="route('leaderboard.index')" :active="request()->routeIs('leaderboard.index')">
                        {{ __('Papan Peringkat') }}
                    </x-nav-link>
                    @endif

                    {{-- Menu lainnya... --}}
                </div>
            </div>

            </div>
    </div>
</nav>