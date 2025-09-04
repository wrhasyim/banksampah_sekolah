<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laporan Penjualan</title>
    <style>
        body {
            font-family: 'sans-serif';
            font-size: 12px;
        }
        .header {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            margin: 0;
            font-size: 18px;
        }
        .header p {
            margin: 0;
            font-size: 14px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
        .total {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Laporan Penjualan Sampah</h1>
        <p>Bulan: {{ \Carbon\Carbon::parse($selectedMonth)->translatedFormat('F Y') }}</p>
    </div>

    <table>
        <thead>
            <tr>
                <th>Tanggal Penjualan</th>
                <th>Detail Sampah Terjual</th>
                <th>Total Harga</th>
            </tr>
        </thead>
        <tbody>
            {{-- PERBAIKAN: Mengganti $penjualans menjadi $penjualan --}}
            @forelse ($penjualan as $item)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($item->tanggal_penjualan)->format('d-m-Y') }}</td>
                    <td>
                        <ul>
                        @foreach($item->detailPenjualan as $detail)
                            <li>{{ $detail->jenisSampah->nama_sampah }}: {{ $detail->jumlah }} {{ $detail->jenisSampah->satuan }}</li>
                        @endforeach
                        </ul>
                    </td>
                    <td>Rp {{ number_format($item->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="3" style="text-align: center;">Tidak ada data penjualan untuk bulan ini.</td>
                </tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr class="total">
                <td colspan="2" style="text-align: right;">Total Keseluruhan</td>
                <td>Rp {{ number_format($totalPenjualan, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>

</body>
</html>