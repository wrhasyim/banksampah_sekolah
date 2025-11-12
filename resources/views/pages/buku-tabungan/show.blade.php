<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Buku Tabungan Siswa') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">

                    <div class="mb-6">
                        <h3 class="text-lg font-medium text-gray-900">Detail Siswa</h3>
                        <div class="mt-2 text-sm text-gray-600">
                            <p><strong>Nama:</strong> {{ $siswa->pengguna->nama_lengkap ?? 'N/A' }}</p>
                            <p><strong>NIS:</strong> {{ $siswa->nis }}</p>
                            <p><strong>Kelas:</strong> {{ $siswa->kelas->nama_kelas ?? 'N/A' }}</p>
                            <p><strong>Total Saldo:</strong> Rp {{ number_format($siswa->saldo, 0, ',', '.') }}</p>
                        </div>
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
                                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Debit (Keluar)</th>
                                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Kredit (Masuk)</th>
                                                <th scope="col" class="px-3 py-3.5 text-left text-sm font-semibold text-gray-900">Saldo</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-gray-200">
                                            @forelse ($riwayatTransaksi as $transaksi)
                                                <tr>
                                                    <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-0">{{ $transaksi->tanggal->format('d-m-Y H:i') }}</td>
                                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">{{ $transaksi->deskripsi }}</td>
                                                    
                                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-red-600">
                                                        @if($transaksi->jenis === 'penarikan')
                                                            Rp {{ number_format($transaksi->debit, 0, ',', '.') }}
                                                        @endif
                                                    </td>
                                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-green-600">
                                                        @if($transaksi->jenis === 'setoran')
                                                            Rp {{ number_format($transaksi->kredit, 0, ',', '.') }}
                                                        @endif
                                                    </td>
                                                    <td class="whitespace-nowrap px-3 py-4 text-sm text-gray-500">Rp {{ number_format($transaksi->saldo, 0, ',', '.') }}</td>
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