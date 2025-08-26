<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <div>
        <h4 class="font-medium text-gray-800 mb-2">Data Setoran</h4>
        <div class="relative overflow-x-auto shadow-md sm:rounded-lg max-h-80">
            <table class="w-full text-sm text-left text-gray-500">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 sticky top-0">
                    <tr>
                        <th class="px-6 py-3">Tanggal</th>
                        <th class="px-6 py-3">Nama Siswa</th>
                        <th class="px-6 py-3 text-right">Total (Rp)</th>
                    </tr>
                </thead>
                <tbody class="divide-y">
                    @forelse ($setorans as $setoran)
                    <tr>
                        <td class="px-6 py-4">{{ \Carbon\Carbon::parse($setoran->tanggal_setor)->format('d M Y') }}</td>
                        <td class="px-6 py-4">{{ $setoran->siswa->nama_siswa }}</td>
                        <td class="px-6 py-4 text-right">{{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                    </tr>
                    @empty
                    <tr>
                        <td colspan="3" class="px-6 py-4 text-center">Tidak ada data setoran pada periode ini.</td>
                    </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
        <div class="mt-4 font-semibold text-right">
            Total Setoran: <span class="text-green-600">Rp {{ number_format($totalSetoran, 0, ',', '.') }}</span>
        </div>
    </div>

    <div>
        <h4 class="font-medium text-gray-800 mb-2">Data Penarikan</h4>
        <div class="relative overflow-x-auto shadow-md sm:rounded-lg max-h-80">
            <table class="w-full text-sm text-left text-gray-500">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 sticky top-0">
                    <tr>
                        <th class="px-6 py-3">Tanggal</th>
                        <th class="px-6 py-3">Nama Siswa</th>
                        <th class="px-6 py-3 text-right">Jumlah (Rp)</th>
                    </tr>
                </thead>
                <tbody class="divide-y">
                     @forelse ($penarikans as $penarikan)
                    <tr>
                        <td class="px-6 py-4">{{ \Carbon\Carbon::parse($penarikan->tanggal_penarikan)->format('d M Y') }}</td>
                        <td class="px-6 py-4">{{ $penarikan->siswa->nama_siswa ?? 'Siswa Dihapus' }}</td>
                        <td class="px-6 py-4 text-right">{{ number_format($penarikan->jumlah_penarikan, 0, ',', '.') }}</td>
                    </tr>
                    @empty
                    <tr>
                        <td colspan="3" class="px-6 py-4 text-center">Tidak ada data penarikan pada periode ini.</td>
                    </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
        <div class="mt-4 font-semibold text-right">
            Total Penarikan: <span class="text-red-600">Rp {{ number_format($totalPenarikan, 0, ',', '.') }}</span>
        </div>
    </div>
</div>