<!DOCTYPE html>
<html>
<head>
    <title>Laporan Penjualan</title>
    <style>
        /* ... (style tetap sama) ... */
    </style>
</head>
<body>
    <h1>Laporan Penjualan Sampah</h1>
    <p>Periode: {{ \Carbon\Carbon::parse($startDate)->format('d M Y') }} - {{ \Carbon\Carbon::parse($endDate)->format('d M Y') }}</p>

    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Nota</th>
                <th>Penjual</th>
                <th>Detail Sampah</th>
                <th class="text-right">Total Harga (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($penjualans as $penjualan)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($penjualan->tanggal_penjualan)->format('d M Y') }}</td> <td>{{ $penjualan->kode_penjualan }}</td>
                    <td>{{ $penjualan->nama_penjual }}</td>
                    <td>
                        <ul style="margin:0; padding-left:15px;">
                        @foreach($penjualan->details as $detail)
                            <li>{{ $detail->jenisSampah->nama_sampah }}: {{ $detail->jumlah_kg }} kg</li>
                        @endforeach
                        </ul>
                    </td>
                    <td class="text-right">{{ number_format($penjualan->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="5">Tidak ada data penjualan pada periode ini.</td></tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr class="total">
                <td colspan="4">Total Penjualan</td>
                <td class="text-right">Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>
</body>
</html>