<!DOCTYPE html>
<html>
<head>
    <title>Laporan Buku Kas</title>
    <style>
        body { font-family: sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        h2 { text-align: center; }
        .total { font-weight: bold; }
        .pemasukan { color: green; }
        .pengeluaran { color: red; }
    </style>
</head>
<body>
    <h2>Laporan Buku Kas</h2>
    <p>Periode: {{ \Carbon\Carbon::parse($startDate)->format('d M Y') }} - {{ \Carbon\Carbon::parse($endDate)->format('d M Y') }}</p>
    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Deskripsi</th>
                <th>Kategori</th>
                <th>Pemasukan (Rp)</th>
                <th>Pengeluaran (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($transaksi as $trx)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($trx->tanggal)->format('d M Y') }}</td>
                    <td>{{ $trx->deskripsi }}</td>
                    <td>{{ $trx->kategori->nama_kategori ?? '-' }}</td>
                    <td class="pemasukan">{{ $trx->tipe == 'pemasukan' ? number_format($trx->jumlah, 0, ',', '.') : '0' }}</td>
                    <td class="pengeluaran">{{ $trx->tipe == 'pengeluaran' ? number_format($trx->jumlah, 0, ',', '.') : '0' }}</td>
                </tr>
            @endforeach
        </tbody>
        <tfoot>
            <tr class="total">
                <td colspan="3">Total Pemasukan</td>
                <td class="pemasukan" colspan="2">Rp {{ number_format($totalPemasukan, 0, ',', '.') }}</td>
            </tr>
            <tr class="total">
                <td colspan="3">Total Pengeluaran</td>
                <td class="pengeluaran" colspan="2">Rp {{ number_format($totalPengeluaran, 0, ',', '.') }}</td>
            </tr>
            <tr class="total">
                <td colspan="3">Saldo Akhir</td>
                <td colspan="2">Rp {{ number_format($saldoAkhir, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>
</body>
</html>