<!DOCTYPE html>
<html>
<head>
    <title>Laporan Buku Kas</title>
    <style>
        body { font-family: sans-serif; font-size: 12px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        h2 { text-align: center; }
        .total-section { margin-top: 20px; float: right; width: 40%; }
        .total-section table { width: 100%; }
        .total-section td { border: none; padding: 5px; }
        .total-section .label { font-weight: bold; }
        .total-section .saldo-akhir { font-weight: bold; border-top: 1px solid #000; }
        .pemasukan { color: green; }
        .pengeluaran { color: red; }
        .header-info { margin-bottom: 20px; }
    </style>
</head>
<body>
    <h2>Laporan Buku Kas</h2>
    <div class="header-info">
        @if ($startDate && $endDate)
            <p>Periode: {{ \Carbon\Carbon::parse($startDate)->format('d M Y') }} - {{ \Carbon\Carbon::parse($endDate)->format('d M Y') }}</p>
        @else
            <p>Periode: Semua Transaksi</p>
        @endif
    </div>

    <table>
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Deskripsi</th>
                <th>Kategori</th>
                <th style="text-align: right;">Pemasukan (Rp)</th>
                <th style="text-align: right;">Pengeluaran (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($transaksi as $trx)
                <tr>
                    <td>{{ \Carbon\Carbon::parse($trx->tanggal)->format('d M Y') }}</td>
                    <td>{{ $trx->deskripsi }}</td>
                    <td>{{ $trx->kategori->nama_kategori ?? '-' }}</td>
                    <td class="pemasukan" style="text-align: right;">{{ $trx->tipe == 'pemasukan' ? number_format($trx->jumlah, 0, ',', '.') : '-' }}</td>
                    <td class="pengeluaran" style="text-align: right;">{{ $trx->tipe == 'pengeluaran' ? number_format($trx->jumlah, 0, ',', '.') : '-' }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="5" style="text-align: center;">Tidak ada transaksi pada periode ini.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <div class="total-section">
        <table>
            <tr>
                <td class="label">Total Pemasukan</td>
                <td class="pemasukan" style="text-align: right;">Rp {{ number_format($totalPemasukan, 0, ',', '.') }}</td>
            </tr>
            <tr>
                <td class="label">Total Pengeluaran</td>
                <td class="pengeluaran" style="text-align: right;">Rp {{ number_format($totalPengeluaran, 0, ',', '.') }}</td>
            </tr>
            <tr>
                <td class="label saldo-akhir">Saldo Akhir</td>
                <td class="saldo-akhir" style="text-align: right;">Rp {{ number_format($saldoAkhir, 0, ',', '.') }}</td>
            </tr>
        </table>
    </div>

</body>
</html>