<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('Buku Tabungan') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">

            @if(isset($siswa))
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg mb-6">
                    <div class="p-6 text-gray-900 dark:text-gray-100">

                        {{-- --- PERUBAHAN DIMULAI DI SINI --- --}}
                        <div class="flex justify-between items-center mb-4">
                            <div>
                                <h3 class="text-lg font-medium">Buku Tabungan Milik: {{ $siswa->pengguna->nama_lengkap }}</h3>
                                <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">Kelas: {{ $siswa->kelas->nama_kelas ?? 'N/A' }}</p>
                            </div>
                            {{-- Tombol ini hanya muncul jika yang login adalah admin --}}
                            @if(Auth::user()->role === 'admin')
                                <a href="{{ route('buku-tabungan.index') }}" class="inline-flex items-center px-4 py-2 bg-gray-200 dark:bg-gray-600 border border-transparent rounded-md font-semibold text-xs text-gray-800 dark:text-gray-200 uppercase tracking-widest hover:bg-gray-300 dark:hover:bg-gray-500">
                                    <i class="fas fa-arrow-left mr-2"></i>
                                    Kembali ke Pencarian
                                </a>
                            @endif
                        </div>
                        {{-- --- PERUBAHAN SELESAI --- --}}

                        <p class="mt-4 text-gray-600 dark:text-gray-400">Total Saldo Saat Ini:</p>
                        <p class="text-4xl font-bold text-green-600">Rp {{ number_format($siswa->saldo, 0, ',', '.') }}</p>
                    </div>
                </div>

                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 text-gray-900 dark:text-gray-100">
                        <h3 class="text-lg font-medium mb-4">Riwayat Transaksi</h3>
                        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
                            <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                    <tr>
                                        <th class="px-6 py-3">Tanggal</th>
                                        <th class="px-6 py-3">Deskripsi</th>
                                        <th class="px-6 py-3">Pemasukan (Kredit)</th>
                                        <th class="px-6 py-3">Pengeluaran (Debit)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse ($transaksi as $trx)
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td class="px-6 py-4">{{ $trx->tanggal->format('d M Y, H:i') }}</td>
                                        <td class="px-6 py-4">{{ $trx->deskripsi }}</td>
                                        <td class="px-6 py-4 text-green-600 font-semibold">
                                            @if($trx->kredit > 0)
                                                + Rp {{ number_format($trx->kredit, 0, ',', '.') }}
                                            @endif
                                        </td>
                                        <td class="px-6 py-4 text-red-600 font-semibold">
                                            @if($trx->debit > 0)
                                                - Rp {{ number_format($trx->debit, 0, ',', '.') }}
                                            @endif
                                        </td>
                                    </tr>
                                    @empty
                                    <tr>
                                        <td colspan="4" class="px-6 py-4 text-center">Belum ada riwayat transaksi.</td>
                                    </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            
            @elseif(Auth::user()->role === 'admin')
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg mb-6">
                    <div class="p-6 text-gray-900 dark:text-gray-100">
                        <h3 class="text-lg font-medium">Cari Buku Tabungan Siswa</h3>
                        <form action="{{ route('buku-tabungan.index') }}" method="GET" class="mt-4">
                            <div class="flex">
                                <input type="text" name="query" class="form-input block w-full rounded-l-md dark:bg-gray-900 dark:border-gray-600" placeholder="Masukkan nama siswa..." value="{{ $query ?? '' }}">
                                <button type="submit" class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-r-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700">Cari</button>
                            </div>
                        </form>
                    </div>
                </div>

                @if(isset($results))
                    <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg">
                        <div class="p-6 text-gray-900 dark:text-gray-100">
                            <h3 class="text-lg font-medium mb-4">Hasil Pencarian</h3>
                            @if($results->isEmpty())
                                <p>Tidak ada siswa yang ditemukan dengan nama tersebut.</p>
                            @else
                                <ul class="divide-y divide-gray-200 dark:divide-gray-700">
                                    @foreach($results as $result)
                                        <li class="py-4 flex justify-between items-center">
                                            <span>{{ $result->pengguna->nama_lengkap }} - Kelas {{ $result->kelas->nama_kelas ?? 'N/A' }}</span>
                                            <a href="{{ route('buku-tabungan.show', $result->id) }}" class="text-indigo-600 hover:text-indigo-900 dark:text-indigo-400 dark:hover:text-indigo-200">Lihat Tabungan</a>
                                        </li>
                                    @endforeach
                                </ul>
                            @endif
                        </div>
                    </div>
                @endif
            @endif
        </div>
    </div>
</x-app-layout>