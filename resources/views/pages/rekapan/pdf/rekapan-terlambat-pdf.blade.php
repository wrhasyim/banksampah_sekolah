<!DOCTYPE html>
<html>
<head>
    <title>Laporan Rinci Setoran Terlambat</title>
    <style>
        body { font-family: 'Helvetica', sans-serif; font-size: 11px; }
        .header h1 { text-align: center; font-size: 18px; margin-bottom: 5px; }
        .header h2 { text-align: center; font-size: 14px; margin-top: 0; margin-bottom: 20px; font-weight: normal; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #333; padding: 6px; text-align: left; }
        th { background-color: #f2f2f2; font-weight: bold; }
        .text-center { text-align: center; }
        .text-right { text-align: right; }
        .total-row td { font-weight: bold; background-color: #f2f2f2; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Laporan Rinci Setoran Terlambat</h1>
        {{-- Menambahkan periode tanggal --}}
        <h2>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM Y') }}</h2>
    </div>

    <table>
        <thead>
            <tr>
                <th class="text-center" style="width: 5%;">No</th>
                <th style="width: 15%;">Tanggal</th>
                <th>Nama Siswa</th>
                <th style="width: 15%;">Kelas</th>
                <th>Jenis Sampah</th>
                <th class="text-right" style="width: 12%;">Jumlah</th>
                <th class="text-right" style="width: 20%;">Total Harga</th>
            </tr>
        </thead>
        <tbody>
            @php $totalKeseluruhan = 0; @endphp
            @forelse ($data as $setoran)
                <tr>
                    <td class="text-center">{{ $loop->iteration }}</td>
                    <td>{{ \Carbon\Carbon::parse($setoran->created_at)->isoFormat('D MMM Y, HH:mm') }}</td>
                    <td>{{ $setoran->siswa->pengguna->nama_lengkap ?? 'Siswa Dihapus' }}</td>
                    <td>{{ $setoran->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                    <td>{{ $setoran->jenisSampah->nama_sampah ?? 'Sampah Dihapus' }}</td>
                    <td class="text-right">{{ number_format($setoran->jumlah, 0, ',', '.') }} {{ $setoran->jenisSampah->satuan ?? '' }}</td>
                    <td class="text-right">Rp {{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                </tr>
                @php $totalKeseluruhan += $setoran->total_harga; @endphp
            @empty
                <tr>
                    <td colspan="7" class="text-center" style="padding: 20px;">Tidak ada data setoran terlambat pada periode ini.</td>
                </tr>
            @endforelse
        </tbody>
        @if(count($data) > 0)
        <tfoot>
            <tr class="total-row">
                <td colspan="6" class="text-right">
                    <strong>TOTAL KESELURUHAN</strong>
                </td>
                <td class="text-right">
                    <strong>Rp {{ number_format($totalKeseluruhan, 0, ',', '.') }}</strong>
                </td>
            </tr>
        </tfoot>
        @endif
    </table>

    <div style="margin-top: 40px; font-size: 11px;">
        <p style="text-align: right;">Dicetak pada: {{ \Carbon\Carbon::now()->isoFormat('D MMMM YYYY, HH:mm') }}</p>
    </div>
</body>
</html>