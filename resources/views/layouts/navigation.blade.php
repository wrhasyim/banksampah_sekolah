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

                    {{-- Menu untuk Admin --}}
                    @if (Auth::user()->role == 'admin')
                        <x-nav-link :href="route('leaderboard.index')" :active="request()->routeIs('leaderboard.index')">
                            {{ __('Papan Peringkat') }}
                        </x-nav-link>

                        <div class="hidden sm:flex sm:items-center sm:ml-6">
                            <x-dropdown align="right" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-1 pt-1 text-sm font-medium leading-5 text-gray-500 transition duration-150 ease-in-out border-b-2 border-transparent dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 hover:border-gray-300 dark:hover:border-gray-700 focus:outline-none focus:text-gray-700 dark:focus:text-gray-300 focus:border-gray-300 dark:focus:border-gray-700">
                                        <div>Transaksi</div>
                                        <div class="ml-1"><svg class="w-4 h-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('setoran.index')">
                                        {{ __('Setoran') }}
                                    </x-dropdown-link>
                                    <x-dropdown-link :href="route('penarikan.index')">
                                        {{ __('Penarikan') }}
                                    </x-dropdown-link>
                                    <x-dropdown-link :href="route('penjualan.index')">
                                        {{ __('Penjualan') }}
                                    </x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>
                        
                        <div class="hidden sm:flex sm:items-center sm:ml-6">
                            <x-dropdown align="right" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-1 pt-1 text-sm font-medium leading-5 text-gray-500 transition duration-150 ease-in-out border-b-2 border-transparent dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 hover:border-gray-300 dark:hover:border-gray-700 focus:outline-none focus:text-gray-700 dark:focus:text-gray-300 focus:border-gray-300 dark:focus:border-gray-700">
                                        <div>Manajemen Data</div>
                                        <div class="ml-1"><svg class="w-4 h-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('siswa.index')">
                                        {{ __('Data Siswa') }}
                                    </x-dropdown-link>
                                    <x-dropdown-link :href="route('buku-kas.index')">
                                        {{ __('Buku Kas') }}
                                    </x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>
                        
                        <div class="hidden sm:flex sm:items-center sm:ml-6">
                            <x-dropdown align="right" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-1 pt-1 text-sm font-medium leading-5 text-gray-500 transition duration-150 ease-in-out border-b-2 border-transparent dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-300 hover:border-gray-300 dark:hover:border-gray-700 focus:outline-none focus:text-gray-700 dark:focus:text-gray-300 focus:border-gray-300 dark:focus:border-gray-700">
                                        <div>Master Data</div>
                                        <div class="ml-1"><svg class="w-4 h-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('kelas.index')">
                                        {{ __('Kelas') }}
                                    </x-dropdown-link>
                                    <x-dropdown-link :href="route('jenis-sampah.index')">
                                        {{ __('Jenis Sampah') }}
                                    </x-dropdown-link>
                                    <x-dropdown-link :href="route('kategori-transaksi.index')">
                                        {{ __('Kategori Transaksi') }}
                                    </x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>

                        <x-nav-link :href="route('laporan.index')" :active="request()->routeIs('laporan.index')">
                            {{ __('Laporan') }}
                        </x-nav-link>
                        <x-nav-link :href="route('settings.index')" :active="request()->routeIs('settings.index')">
                            {{ __('Pengaturan') }}
                        </x-nav-link>
                    @endif
                </div>
            </div>

            <div class="hidden sm:flex sm:items-center sm:ml-6">
                <x-dropdown align="right" width="48">
                    <x-slot name="trigger">
                        <button
                            class="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 text-gray-500 transition duration-150 ease-in-out bg-white border border-transparent rounded-md dark:text-gray-400 dark:bg-gray-800 hover:text-gray-700 dark:hover:text-gray-300 focus:outline-none">
                            <div>{{ Auth::user()->name }}</div>

                            <div class="ml-1">
                                <svg class="w-4 h-4 fill-current" xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 20 20">
                                    <path fill-rule="evenodd"
                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                        clip-rule="evenodd" />
                                </svg>
                            </div>
                        </button>
                    </x-slot>

                    <x-slot name="content">
                        <x-dropdown-link :href="route('profile.edit')">
                            {{ __('Profile') }}
                        </x-dropdown-link>

                        <form method="POST" action="{{ route('logout') }}">
                            @csrf

                            <x-dropdown-link :href="route('logout')" onclick="event.preventDefault();
                                                this.closest('form').submit();">
                                {{ __('Log Out') }}
                            </x-dropdown-link>
                        </form>
                    </x-slot>
                </x-dropdown>
            </div>

            <div class="flex items-center -mr-2 sm:hidden">
                <button @click="open = ! open"
                    class="inline-flex items-center justify-center p-2 text-gray-400 transition duration-150 ease-in-out rounded-md dark:text-gray-500 hover:text-gray-500 dark:hover:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-900 focus:outline-none focus:bg-gray-100 dark:focus:bg-gray-900 focus:text-gray-500 dark:focus:text-gray-400">
                    <svg class="w-6 h-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                        <path :class="{ 'hidden': open, 'inline-flex': !open }" class="inline-flex"
                            stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M4 6h16M4 12h16M4 18h16" />
                        <path :class="{ 'hidden': !open, 'inline-flex': open }" class="hidden" stroke-linecap="round"
                            stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
        </div>
    </div>

    <div :class="{ 'block': open, 'hidden': !open }" class="hidden sm:hidden">
        <div class="pt-2 pb-3 space-y-1">
            <x-responsive-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')">
                {{ __('Dashboard') }}
            </x-responsive-nav-link>
            
            @if (Auth::user()->role == 'admin')
                <x-responsive-nav-link :href="route('leaderboard.index')" :active="request()->routeIs('leaderboard.index')">
                    {{ __('Papan Peringkat') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('setoran.index')" :active="request()->routeIs('setoran.index')">
                    {{ __('Setoran') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('penarikan.index')" :active="request()->routeIs('penarikan.index')">
                    {{ __('Penarikan') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('penjualan.index')" :active="request()->routeIs('penjualan.index')">
                    {{ __('Penjualan') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('siswa.index')" :active="request()->routeIs('siswa.index')">
                    {{ __('Data Siswa') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('buku-kas.index')" :active="request()->routeIs('buku-kas.index')">
                    {{ __('Buku Kas') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('kelas.index')" :active="request()->routeIs('kelas.index')">
                    {{ __('Master Kelas') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('jenis-sampah.index')" :active="request()->routeIs('jenis-sampah.index')">
                    {{ __('Master Jenis Sampah') }}
                </x-responsive-nav-link>
                 <x-responsive-nav-link :href="route('kategori-transaksi.index')" :active="request()->routeIs('kategori-transaksi.index')">
                    {{ __('Master Kategori Transaksi') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('laporan.index')" :active="request()->routeIs('laporan.index')">
                    {{ __('Laporan') }}
                </x-responsive-nav-link>
                <x-responsive-nav-link :href="route('settings.index')" :active="request()->routeIs('settings.index')">
                    {{ __('Pengaturan') }}
                </x-responsive-nav-link>
            @endif
        </div>

        <div class="pt-4 pb-1 border-t border-gray-200 dark:border-gray-600">
            <div class="px-4">
                <div class="text-base font-medium text-gray-800 dark:text-gray-200">{{ Auth::user()->name }}</div>
                <div class="text-sm font-medium text-gray-500">{{ Auth::user()->email }}</div>
            </div>

            <div class="mt-3 space-y-1">
                <x-responsive-nav-link :href="route('profile.edit')">
                    {{ __('Profile') }}
                </x-responsive-nav-link>

                <form method="POST" action="{{ route('logout') }}">
                    @csrf

                    <x-responsive-nav-link :href="route('logout')" onclick="event.preventDefault();
                                        this.closest('form').submit();">
                        {{ __('Log Out') }}
                    </x-responsive-nav-link>
                </form>
            </div>
        </div>
    </div>
</nav>