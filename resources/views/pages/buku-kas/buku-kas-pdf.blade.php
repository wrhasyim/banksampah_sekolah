<!DOCTYPE html>
<html>
<head>
    <title>Laporan Buku Kas</title>
    <style>
        body { font-family: sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        h1, h2 { text-align: center; }
        .total { font-weight: bold; }
        .pemasukan { color: green; }
        .pengeluaran { color: red; }
    </style>
</head>
<body>
    <h1>Laporan Buku Kas</h1>
    <h2>Periode: {{ \Carbon\Carbon::parse($selectedMonth)->isoFormat('MMMM YYYY') }}</h2>
    
    <table>
        <thead>
            <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Keterangan</th>
                <th>Pemasukan</th>
                <th>Pengeluaran</th>
            </tr>
        </thead>
        <tbody>
            {{-- --- PERBAIKAN DI SINI --- --}}
            @forelse ($bukuKas as $item)
            <tr>
                <td>{{ $loop->iteration }}</td>
                <td>{{ \Carbon\Carbon::parse($item->tanggal)->format('d-m-Y') }}</td>
                <td>{{ $item->deskripsi }}</td>
                @if ($item->tipe == 'pemasukan')
                    <td class="pemasukan">Rp {{ number_format($item->jumlah, 0, ',', '.') }}</td>
                    <td>-</td>
                @else
                    <td>-</td>
                    <td class="pengeluaran">Rp {{ number_format($item->jumlah, 0, ',', '.') }}</td>
                @endif
            </tr>
            @empty
            <tr>
                <td colspan="5" style="text-align: center;">Tidak ada data untuk periode ini.</td>
            </tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr>
                <td colspan="3" class="total">Total Pemasukan</td>
                <td class-="total pemasukan">Rp {{ number_format($totalPemasukan, 0, ',', '.') }}</td>
                <td></td>
            </tr>
            <tr>
                <td colspan="4" class="total">Total Pengeluaran</td>
                <td class="total pengeluaran">Rp {{ number_format($totalPengeluaran, 0, ',', '.') }}</td>
            </tr>
            <tr>
                <td colspan="3" class="total" style="font-size: 1.2em;">Saldo Akhir</td>
                <td colspan="2" class="total" style="font-size: 1.2em;">Rp {{ number_format($saldoAkhir, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>
</body>
</html>