<div class="relative overflow-x-auto shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">Tanggal</th>
                <th scope="col" class="px-6 py-3">Nama</th>
                <th scope="col" class="px-6 py-3">Keterangan</th>
                <th scope="col" class="px-6 py-3">Debit (Setoran)</th>
                <th scope="col" class="px-6 py-3">Kredit (Penarikan)</th>
            </tr>
        </thead>
        <tbody>
            {{-- Menampilkan Data Setoran --}}
            @foreach ($setorans as $setoran)
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($setoran->created_at)->format('d/m/Y') }}</td>
                    <td class="px-6 py-4">{{ $setoran->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}</td>
                    <td class="px-6 py-4">Setoran Sampah</td>
                    <td class="px-6 py-4 text-green-600">Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                    <td class="px-6 py-4">-</td>
                </tr>
            @endforeach

            {{-- Menampilkan Data Penarikan --}}
            @foreach ($penarikans as $penarikan)
                <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                    <td class="px-6 py-4">{{ \Carbon\Carbon::parse($penarikan->tanggal_penarikan)->format('d/m/Y') }}</td>
                    
                    {{-- --- PERBAIKAN DI SINI --- --}}
                    <td class="px-6 py-4">
                        @if ($penarikan->siswa)
                            {{ $penarikan->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}
                        @elseif ($penarikan->kelas)
                            <span class="font-bold">Kelas:</span> {{ $penarikan->kelas->nama_kelas ?? 'Kelas Dihapus' }}
                        @else
                            -
                        @endif
                    </td>
                    
                    <td class="px-6 py-4">Penarikan Saldo</td>
                    <td class="px-6 py-4">-</td>
                    <td class="px-6 py-4 text-red-600">Rp {{ number_format($penarikan->jumlah_penarikan, 0, ',', '.') }}</td>
                </tr>
            @endforeach

            @if ($setorans->isEmpty() && $penarikans->isEmpty())
                <tr>
                    <td colspan="5" class="px-6 py-4 text-center">Tidak ada transaksi setoran atau penarikan pada periode ini.</td>
                </tr>
            @endif
        </tbody>
        <tfoot class="bg-gray-50 dark:bg-gray-700">
            <tr class="font-semibold text-gray-900 dark:text-white">
                <td colspan="3" class="px-6 py-3 text-right">Total</td>
                <td class="px-6 py-3 text-green-600">Rp {{ number_format($totalSetoran, 0, ',', '.') }}</td>
                <td class="px-6 py-3 text-red-600">Rp {{ number_format($totalPenarikan, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>
</div>