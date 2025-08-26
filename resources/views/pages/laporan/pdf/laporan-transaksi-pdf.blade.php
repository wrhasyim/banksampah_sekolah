<!DOCTYPE html>
<html>
<head>
    <title>Laporan Transaksi</title>
    <style>
        body { font-family: sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .text-right { text-align: right; }
        .total { font-weight: bold; }
        h1 { text-align: center; }
        p { text-align: center; margin-bottom: 20px;}
    </style>
</head>
<body>
    <h1>Laporan Transaksi</h1>
    <p>Periode: {{ \Carbon\Carbon::parse($startDate)->format('d M Y') }} - {{ \Carbon\Carbon::parse($endDate)->format('d M Y') }}</p>

    <h2>Setoran Sampah</h2>
    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Nama Siswa</th>
                <th>Kelas</th>
                <th class="text-right">Total (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($setorans as $setoran)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($setoran->tanggal_setor)->format('d M Y') }}</td>
                    <td>{{ $setoran->siswa->nama_siswa }}</td>
                    <td>{{ $setoran->siswa->kelas->nama_kelas }}</td>
                    <td class="text-right">{{ number_format($setoran->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="4">Tidak ada data setoran pada periode ini.</td></tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr class="total">
                <td colspan="3">Total Setoran</td>
                <td class="text-right">Rp {{ number_format($totalSetoran, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>

    <h2 style="margin-top: 30px;">Penarikan Saldo</h2>
    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Nama Siswa</th>
                <th>Kelas</th>
                <th class="text-right">Jumlah (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($penarikans as $penarikan)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($penarikan->tanggal_penarikan)->format('d M Y') }}</td>
                    <td>{{ $penarikan->siswa->nama_siswa ?? 'Siswa Dihapus' }}</td>
                    <td>{{ $penarikan->siswa->kelas->nama_kelas ?? '-' }}</td>
                    <td class="text-right">{{ number_format($penarikan->jumlah_penarikan, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="4">Tidak ada data penarikan pada periode ini.</td></tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr class="total">
                <td colspan="3">Total Penarikan</td>
                <td class="text-right">Rp {{ number_format($totalPenarikan, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>
</body>
</html>