<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{-- JUDUL DINAMIS BERDASARKAN ROLE --}}
            @if(auth()->user()->role == 'siswa')
                {{ __('Buku Tabungan Saya') }}
            @elseif(auth()->user()->role == 'wali')
                {{ __('Buku Tabungan Siswa: ') }} {{ $siswa->pengguna->nama_lengkap ?? 'N/A' }}
            @else
                {{ __('Detail Buku Tabungan: ') }} {{ $siswa->pengguna->nama_lengkap ?? 'N/A' }}
            @endif
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">

            <div class="flex justify-between items-center mb-4">
                <div>
                    {{-- TOMBOL KEMBALI DINAMIS BERDASARKAN ROLE --}}
                    @if(auth()->user()->role == 'admin')
                        <a href="{{ route('buku-tabungan.index') }}" class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 focus:bg-gray-700 active:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition ease-in-out duration-150">
                            &larr; Kembali ke Daftar
                        </a>
                    @elseif(auth()->user()->role == 'wali')
                        <a href="{{ route('wali.siswa.index') }}" class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 focus:bg-gray-700 active:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition ease-in-out duration-150">
                            &larr; Kembali ke Siswa Saya
                        </a>
                    @else
                        <a href="{{ route('dashboard') }}" class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 focus:bg-gray-700 active:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition ease-in-out duration-150">
                            &larr; Kembali ke Dashboard
                        </a>
                    @endif
                </div>
                <div>
                    {{-- TOMBOL EXPORT PDF (MENGGUNAKAN RUTE DARI LANGKAH 1) --}}
                    <a href="{{ route('buku-tabungan.exportPdf', $siswa) }}" target="_blank" class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-500 active:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 transition ease-in-out duration-150">
                        Export PDF
                    </a>
                </div>
            </div>
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">

                    <div class="mb-6 border-b pb-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-2">Detail Siswa</h3>
                        <dl class="grid grid-cols-1 md:grid-cols-2 gap-x-4 gap-y-2">
                            <div class="sm:col-span-1">
                                <dt class="text-sm font-medium text-gray-500">Nama</dt>
                                <dd class="mt-1 text-sm text-gray-900 font-semibold">{{ $siswa->pengguna->nama_lengkap ?? 'N/A' }}</dd>
                            </div>
                            <div class="sm:col-span-1">
                                <dt class="text-sm font-medium text-gray-500">NIS</dt>
                                <dd class="mt-1 text-sm text-gray-900">{{ $siswa->nis }}</dd>
                            </div>
                            <div class="sm:col-span-1">
                                <dt class="text-sm font-medium text-gray-500">Kelas</dt>
                                <dd class="mt-1 text-sm text-gray-900">{{ $siswa->kelas->nama_kelas ?? 'N/A' }}</dd>
                            </div>
                            <div class="sm:col-span-1">
                                <dt class="text-sm font-medium text-gray-500">Total Saldo</dt>
                                <dd class="mt-1 text-xl font-bold text-green-600">Rp {{ number_format($siswa->saldo, 0, ',', '.') }}</dd>
                            </div>
                        </dl>
                    </div>
                    <div class="mt-6">
                        <h3 class="text-lg font-medium text-gray-900">Riwayat Transaksi</h3>
                        <div class="mt-4 flow-root">
                            <div class="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
                                <div class="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
                                    <table class="min-w-full divide-y divide-gray-300">
                                        <thead>
                                            <tr>
                                                <th scope="col" class="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 sm:pl-0">Tanggal</th>
                                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Deskripsi</th>
                                                <th scope="col" class="px-3 py-3.5 text-right text-sm font-semibold text-gray-900">Debit (Keluar)</th>
                                                <th scope="col" class="px-3 py-3.5 text-right text-sm font-semibold text-gray-900">Kredit (Masuk)</th>
                                                <th scope="col" class="px-3 py-3.5 text-right text-sm font-semibold text-gray-900">Saldo</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-gray-200">
                                            @forelse ($riwayatTransaksi as $transaksi)
                                                <tr>
                                                    <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-0">{{ $transaksi->tanggal->format('d-m-Y H:i') }}</td>
                                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">{{ $transaksi->deskripsi }}</td>
                                                    
                                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-red-600 text-right">
                                                        @if($transaksi->jenis === 'penarikan')
                                                            Rp {{ number_format($transaksi->debit, 0, ',', '.') }}
                                                        @else
                                                            -
                                                        @endif
                                                    </td>
                                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-green-600 text-right">
                                                        @if($transaksi->jenis === 'setoran')
                                                            Rp {{ number_format($transaksi->kredit, 0, ',', '.') }}
                                                        @else
                                                            -
                                                        @endif
                                                    </td>
                                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-900 font-medium text-right">Rp {{ number_format($transaksi->saldo, 0, ',', '.') }}</td>
                                                </tr>
                                            @empty
                                                <tr>
                                                    <td colspan="5" class="py-4 pl-4 pr-3 text-sm text-center text-gray-500 sm:pl-0">Belum ada riwayat transaksi.</td>
                                                </tr>
                                            @endforelse
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</x-app-layout>