<!DOCTYPE html>
<html>
<head>
    <title>Laporan Penjualan</title>
    <style>
        body { font-family: sans-serif; font-size: 12px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        h1, p { text-align: center; }
        .text-right { text-align: right; }
        .total { font-weight: bold; }
    </style>
</head>
<body>
    <h1>Laporan Penjualan Sampah</h1>
    <p>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM YYYY') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM YYYY') }}</p>

    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Pengepul</th>
                <th>Detail Sampah</th>
                <th class="text-right">Total Harga (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($penjualans as $penjualan)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($penjualan->tanggal_penjualan)->format('d/m/Y') }}</td>
                    <td>{{ $penjualan->nama_pengepul }}</td>
                    <td>
                        <ul style="margin:0; padding-left:15px;">
                        {{-- --- PERBAIKAN DI SINI --- --}}
                        @foreach($penjualan->detailPenjualan as $detail)
                            <li>{{ $detail->jenisSampah->nama_sampah ?? 'Data Sampah Hilang' }}: {{ $detail->jumlah }} {{ $detail->jenisSampah->satuan ?? '' }}</li>
                        @endforeach
                        </ul>
                    </td>
                    <td class="text-right">{{ number_format($penjualan->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="4" style="text-align: center;">Tidak ada data penjualan pada periode ini.</td></tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr class="total">
                <td colspan="3">Total Penjualan</td>
                <td class="text-right">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>
</body>
</html>