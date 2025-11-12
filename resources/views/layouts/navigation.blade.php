<nav x-data="{ open: false }" class="bg-white dark:bg-gray-800 border-b border-gray-100 dark:border-gray-700">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <div class="flex">
                <div class="shrink-0 flex items-center">
                    <a href="{{ route('dashboard') }}">
                        <img src="{{ asset('/img/logo-sekolah.png') }}" alt="Logo Sekolah" class="block h-12 w-auto">
                    </a>
                </div>

                <div class="hidden space-x-4 sm:-my-px sm:ms-10 sm:flex">
                    <x-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')">
                        <i class="fas fa-tachometer-alt fa-fw mr-2"></i>{{ __('Dashboard') }}
                    </x-nav-link>

                    {{-- ================================================== --}}
                    {{-- MENU UNTUK ADMIN --}}
                    {{-- ================================================== --}}
                    @if(Auth::user()->role === 'admin')
                        {{-- (Dropdown Transaksi) --}}
                        <div class="hidden sm:flex sm:items-center">
                            <x-dropdown align="left" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium leading-5 transition duration-150 ease-in-out {{ request()->routeIs('setoran.*', 'penarikan.*', 'penjualan.*', 'buku-kas.*', 'nota.*', 'stok.*') ? 'border-indigo-400 text-gray-900 focus:border-indigo-700' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300' }}">
                                        <i class="fas fa-exchange-alt fa-fw mr-2"></i><div>Transaksi</div>
                                        <div class="ms-1"><svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('setoran.index')"><i class="fas fa-upload fa-fw mr-2"></i>{{ __('Setoran Sampah') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('penarikan.index')"><i class="fas fa-download fa-fw mr-2"></i>{{ __('Penarikan Saldo') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('penjualan.index')"><i class="fas fa-shopping-cart fa-fw mr-2"></i>{{ __('Penjualan ke Pengepul') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('buku-kas.index')"><i class="fas fa-book-open fa-fw mr-2"></i>{{ __('Buku Kas') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('nota.index')"><i class="fas fa-print fa-fw mr-2"></i>{{ __('Cetak Nota') }}</x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>
                        {{-- (Dropdown Insentif) --}}
                        <div class="hidden sm:flex sm:items-center">
                            <x-dropdown align="left" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium leading-5 transition duration-150 ease-in-out {{ request()->routeIs('insentif.*', 'rewards.*') ? 'border-indigo-400 text-gray-900 focus:border-indigo-700' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300' }}">
                                        <i class="fas fa-gift fa-fw mr-2"></i><div>Insentif & Reward</div>
                                        <div class="ms-1"><svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('insentif.rekap')"><i class="fas fa-file-invoice-dollar fa-fw mr-2"></i>{{ __('Rekapitulasi Insentif') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('insentif.pembayaran')"><i class="fas fa-money-bill-wave fa-fw mr-2"></i>{{ __('Pembayaran Insentif') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('rewards.index')"><i class="fas fa-star fa-fw mr-2"></i>{{ __('Master Reward') }}</x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>
                        {{-- (Dropdown Master Data) --}}
                        <div class="hidden sm:flex sm:items-center">
                            <x-dropdown align="left" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium leading-5 transition duration-150 ease-in-out {{ request()->routeIs('jenis-sampah.*', 'kategori-transaksi.*', 'siswa.*', 'kelas.*', 'pengguna.*') ? 'border-indigo-400 text-gray-900 focus:border-indigo-700' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300' }}">
                                        <i class="fas fa-database fa-fw mr-2"></i><div>Master Data</div>
                                        <div class="ms-1"><svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('jenis-sampah.index')"><i class="fas fa-dumpster fa-fw mr-2"></i>{{ __('Jenis Sampah') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('kategori-transaksi.index')"><i class="fas fa-tags fa-fw mr-2"></i>{{ __('Kategori Transaksi') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('siswa.index')"><i class="fas fa-user-graduate fa-fw mr-2"></i>{{ __('Data Siswa') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('kelas.index')"><i class="fas fa-school fa-fw mr-2"></i>{{ __('Data Kelas') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('pengguna.index')"><i class="fas fa-users-cog fa-fw mr-2"></i>{{ __('Manajemen Pengguna') }}</x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>
                        {{-- (Dropdown Laporan) --}}
                        <div class="hidden sm:flex sm:items-center">
                            <x-dropdown align="left" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium leading-5 transition duration-150 ease-in-out {{ request()->routeIs('rekapan.*', 'laporan.*') ? 'border-indigo-400 text-gray-900 focus:border-indigo-700' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300' }}">
                                        <i class="fas fa-chart-bar fa-fw mr-2"></i><div>Laporan</div>
                                        <div class="ms-1"><svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('rekapan.menyeluruh')"><i class="fas fa-file-alt fa-fw mr-2"></i>{{ __('Rekap Menyeluruh') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('laporan.index')"><i class="fas fa-file-invoice fa-fw mr-2"></i>{{ __('Laporan Umum') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('rekapan.guru')"><i class="fas fa-chalkboard-teacher fa-fw mr-2"></i>{{ __('Rekap Setoran Guru') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('rekapan.siswa-terlambat')"><i class="fas fa-user-clock fa-fw mr-2"></i>{{ __('Rekap Siswa Terlambat') }}</x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>
                        {{-- (Dropdown Lainnya) --}}
                        <div class="hidden sm:flex sm:items-center">
                            <x-dropdown align="left" width="48">
                                <x-slot name="trigger">
                                    <button class="inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium leading-5 transition duration-150 ease-in-out {{ request()->routeIs('buku-tabungan.*', 'leaderboard.*', 'tutup-buku.*', 'settings.*') ? 'border-indigo-400 text-gray-900 focus:border-indigo-700' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300' }}">
                                        <i class="fas fa-ellipsis-h fa-fw mr-2"></i><div>Lainnya</div>
                                        <div class="ms-1"><svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                                    </button>
                                </x-slot>
                                <x-slot name="content">
                                    <x-dropdown-link :href="route('buku-tabungan.index')"><i class="fas fa-book fa-fw mr-2"></i>{{ __('Buku Tabungan') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('leaderboard.index')"><i class="fas fa-trophy fa-fw mr-2"></i>{{ __('Leaderboard') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('tutup-buku.index')"><i class="fas fa-calendar-check fa-fw mr-2"></i>{{ __('Tutup Buku') }}</x-dropdown-link>
                                    <x-dropdown-link :href="route('settings.index')"><i class="fas fa-cogs fa-fw mr-2"></i>{{ __('Pengaturan Aplikasi') }}</x-dropdown-link>
                                </x-slot>
                            </x-dropdown>
                        </div>
                    
                    {{-- ================================================== --}}
                    {{-- MENU UNTUK WALI KELAS (DIPERBARUI) --}}
                    {{-- ================================================== --}}
                    @elseif(Auth::user()->role === 'wali')
                        {{-- PERUBAHAN DI SINI: Mengganti 'buku-tabungan.index' menjadi 'wali.siswa.index' --}}
                        <x-nav-link :href="route('wali.siswa.index')" :active="request()->routeIs('wali.siswa.index')">
                            <i class="fas fa-users fa-fw mr-2"></i>{{ __('Siswa Kelas Saya') }}
                        </x-nav-link>
                        
                        {{-- PERUBAHAN DI SINI: Link Leaderboard dihapus --}}
                        
                    {{-- (Role 'siswa' tidak punya menu tambahan selain Dashboard) --}}
                    @endif
                    {{-- ================================================== --}}
                    {{-- AKHIR PERUBAHAN --}}
                    {{-- ================================================== --}}

                </div>
            </div>

            {{-- (Dropdown Profil Kanan Atas) --}}
            <div class="hidden sm:flex sm:items-center sm:ms-6">
                <x-dropdown align="right" width="48">
                    <x-slot name="trigger">
                        <button class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-gray-500 bg-white hover:text-gray-700 focus:outline-none transition ease-in-out duration-150">
                            <div>{{ Auth::user()->nama_lengkap }}</div>
                            <div class="ms-1"><svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" /></svg></div>
                        </button>
                    </x-slot>
                    <x-slot name="content">
                        <x-dropdown-link :href="route('profile.edit')"><i class="fas fa-user-edit fa-fw mr-2"></i>{{ __('Profile') }}</x-dropdown-link>
                        <form method="POST" action="{{ route('logout') }}"> @csrf <x-dropdown-link :href="route('logout')" onclick="event.preventDefault(); this.closest('form').submit();"><i class="fas fa-sign-out-alt fa-fw mr-2"></i>{{ __('Log Out') }}</x-dropdown-link></form>
                    </x-slot>
                </x-dropdown>
            </div>

            {{-- (Tombol Hamburger) --}}
            <div class="-me-2 flex items-center sm:hidden">
                <button @click="open = ! open" class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 focus:text-gray-500 transition duration-150 ease-in-out">
                    <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                        <path :class="{'hidden': open, 'inline-flex': ! open }" class="inline-flex" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                        <path :class="{'hidden': ! open, 'inline-flex': open }" class="hidden" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
        </div>
    </div>

    {{-- Responsive Navigation Menu --}}
    <div :class="{'block': open, 'hidden': ! open}" class="hidden sm:hidden">
        <div class="pt-2 pb-3 space-y-1">
            <x-responsive-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')"><i class="fas fa-tachometer-alt fa-fw mr-2"></i>{{ __('Dashboard') }}</x-responsive-nav-link>
        </div>
        <div class="pt-4 pb-1 border-t border-gray-200">
            <div class="px-4"><div class="font-medium text-base text-gray-800">{{ Auth::user()->nama_lengkap }}</div><div class="font-medium text-sm text-gray-500">{{ Auth::user()->email }}</div></div>
            <div class="mt-3 space-y-1">
                
                {{-- ================================================== --}}
                {{-- PERUBAHAN DI SINI (Mobile) --}}
                {{-- ================================================== --}}
                
                {{-- Tampilkan menu ini jika pengguna BUKAN siswa --}}
                @if(Auth::user()->role !== 'siswa')
                    
                    {{-- Menu Admin --}}
                    @if(Auth::user()->role === 'admin')
                        <div class="px-4 font-medium text-sm text-gray-500">Transaksi</div>
                        <x-responsive-nav-link :href="route('setoran.index')"><i class="fas fa-upload fa-fw mr-2"></i>{{ __('Setoran Sampah') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('penarikan.index')"><i class="fas fa-download fa-fw mr-2"></i>{{ __('Penarikan Saldo') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('penjualan.index')"><i class="fas fa-shopping-cart fa-fw mr-2"></i>{{ __('Penjualan') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('buku-kas.index')"><i class="fas fa-book-open fa-fw mr-2"></i>{{ __('Buku Kas') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('stok.create')"><i class="fas fa-box fa-fw mr-2"></i>{{ __('Penyesuaian Stok') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('nota.index')"><i class="fas fa-print fa-fw mr-2"></i>{{ __('Cetak Nota') }}</x-responsive-nav-link>
                        
                        <div class="mt-2 px-4 font-medium text-sm text-gray-500">Insentif & Reward</div>
                        <x-responsive-nav-link :href="route('insentif.rekap')"><i class="fas fa-file-invoice-dollar fa-fw mr-2"></i>{{ __('Rekapitulasi Insentif') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('insentif.pembayaran')"><i class="fas fa-money-bill-wave fa-fw mr-2"></i>{{ __('Pembayaran Insentif') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('rewards.index')"><i class="fas fa-star fa-fw mr-2"></i>{{ __('Master Reward') }}</x-responsive-nav-link>

                        <div class="mt-2 px-4 font-medium text-sm text-gray-500">Master Data</div>
                        <x-responsive-nav-link :href="route('jenis-sampah.index')"><i class="fas fa-dumpster fa-fw mr-2"></i>{{ __('Jenis Sampah') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('kategori-transaksi.index')"><i class="fas fa-tags fa-fw mr-2"></i>{{ __('Kategori Transaksi') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('siswa.index')"><i class="fas fa-user-graduate fa-fw mr-2"></i>{{ __('Data Siswa') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('kelas.index')"><i class="fas fa-school fa-fw mr-2"></i>{{ __('Data Kelas') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('pengguna.index')"><i class="fas fa-users-cog fa-fw mr-2"></i>{{ __('Manajemen Pengguna') }}</x-responsive-nav-link>

                        <div class="mt-2 px-4 font-medium text-sm text-gray-500">Laporan</div>
                        <x-responsive-nav-link :href="route('rekapan.menyeluruh')"><i class="fas fa-file-alt fa-fw mr-2"></i>{{ __('Rekap Menyeluruh') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('laporan.index')"><i class="fas fa-file-invoice fa-fw mr-2"></i>{{ __('Laporan Umum') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('rekapan.guru')"><i class="fas fa-chalkboard-teacher fa-fw mr-2"></i>{{ __('Rekap Setoran Guru') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('rekapan.siswa-terlambat')"><i class="fas fa-user-clock fa-fw mr-2"></i>{{ __('Rekap Siswa Terlambat') }}</x-responsive-nav-link>

                        <div class="mt-2 px-4 font-medium text-sm text-gray-500">Lainnya</div>
                        <x-responsive-nav-link :href="route('buku-tabungan.index')"><i class="fas fa-book fa-fw mr-2"></i>{{ __('Buku Tabungan') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('leaderboard.index')"><i class="fas fa-trophy fa-fw mr-2"></i>{{ __('Leaderboard') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('tutup-buku.index')"><i class="fas fa-calendar-check fa-fw mr-2"></i>{{ __('Tutup Buku') }}</x-responsive-nav-link>
                        <x-responsive-nav-link :href="route('settings.index')"><i class="fas fa-cogs fa-fw mr-2"></i>{{ __('Pengaturan Aplikasi') }}</x-responsive-nav-link>

                    {{-- Menu Wali Kelas --}}
                    @elseif(Auth::user()->role === 'wali')
                        <x-responsive-nav-link :href="route('wali.siswa.index')"><i class="fas fa-users fa-fw mr-2"></i>{{ __('Siswa Kelas Saya') }}</x-responsive-nav-link>
                        
                        {{-- PERUBAHAN DI SINI: Link Leaderboard dihapus --}}
                    
                    @endif
                
                @endif
                {{-- ================================================== --}}
                {{-- AKHIR PERUBAHAN --}}
                {{-- ================================================== --}}


                <div class="border-t border-gray-200 mt-3 pt-3"></div>
                <x-responsive-nav-link :href="route('profile.edit')"><i class="fas fa-user-edit fa-fw mr-2"></i>{{ __('Profile') }}</x-responsive-nav-link>
                <form method="POST" action="{{ route('logout') }}">@csrf<x-responsive-nav-link :href="route('logout')" onclick="event.preventDefault(); this.closest('form').submit();"><i class="fas fa-sign-out-alt fa-fw mr-2"></i>{{ __('Log Out') }}</x-responsive-nav-link></form>
            </div>
        </div>
    </div>
</nav>