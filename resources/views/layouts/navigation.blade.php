<nav x-data="{ open: false }" class="bg-white border-b border-gray-100">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex">
                <div class="shrink-0 flex items-center">
                    <a href="{{ route('dashboard') }}">
                        <x-application-logo class="block h-9 w-auto fill-current text-gray-800" />
                    </a>
                </div>

                <div class="hidden space-x-8 sm:-my-px sm:ms-10 sm:flex">
                    <x-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')">
                        {{ __('Dashboard') }}
                    </x-nav-link>

                    @if(Auth::user()->role === 'siswa')
                    <x-nav-link :href="route('buku-tabungan.index')" :active="request()->routeIs('buku-tabungan.index')">
                        {{ __('Buku Tabungan') }}
                    </x-nav-link>
                    @endif

                    @if(Auth::user()->role === 'admin')
                        <div class="hidden sm:flex sm:items-center sm:ms-6">
                            <x-dropdown align="right" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150">
                                        <div>Kelola Bank Sampah</div>
                                        <div class="ms-1">
                                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg>
                                        </div>
                                    </button>
                                </x-slot>

                                <x-slot name="content">
                                    <x-dropdown-link :href="route('jenis-sampah.index')">
                                        {{ __('Kelola Jenis Sampah') }}
                                    </x-dropdown-link>
                                    <x-dropdown-link :href="route('kelas.index')">
                                        {{ __('Kelola Kelas') }}
                                    </x-dropdown-link>
                                    <x-dropdown-link :href="route('siswa.index')">
                                        {{ __('Kelola Siswa') }}
                                    </x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>

                        <x-nav-link :href="route('setoran.index')" :active="request()->routeIs('setoran.*')">
                            {{ __('Setoran Sampah') }}
                        </x-nav-link>
                        <x-nav-link :href="route('penarikan.index')" :active="request()->routeIs('penarikan.*')">
                            {{ __('Penarikan Saldo') }}
                        </x-nav-link>
                        <x-nav-link :href="route('penjualan.index')" :active="request()->routeIs('penjualan.*')">
                            {{ __('Penjualan Sampah') }}
                        </x-nav-link>
                        <x-nav-link :href="route('laporan.index')" :active="request()->routeIs('laporan.*')">
                            {{ __('Laporan') }}
                        </x-nav-link>
                    @endif
                </div>
            </div>

            </div>
    </div>
</nav>