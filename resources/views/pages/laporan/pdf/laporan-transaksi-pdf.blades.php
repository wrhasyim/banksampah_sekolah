<!DOCTYPE html>
<html>
<head>
    <title>Laporan Transaksi</title>
    <style>
        body { font-family: 'sans-serif'; margin: 20px; font-size: 12px; }
        .header h1, .header h4 { text-align: center; margin: 5px 0; }
        .header h1 { font-size: 18px; }
        .header h4 { font-size: 14px; font-weight: normal; }
        .content-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .content-table th, .content-table td { border: 1px solid #000; padding: 6px; }
        .content-table th { background-color: #f2f2f2; text-align: center; }
        .content-table td.text-right { text-align: right; }
        .content-table td.text-center { text-align: center; }
        .section-title { font-size: 16px; margin-top: 30px; margin-bottom: 10px; text-align: center; }
        .summary-container { margin-top: 40px; page-break-inside: avoid; }
        .summary-table { width: 60%; margin: 20px auto 0 auto; border-collapse: collapse; }
        .summary-table th, .summary-table td { border: 1px solid #000; padding: 6px; }
        .summary-table th { background-color: #f2f2f2; text-align: center; }
        .totals-table { width: 60%; margin: 20px auto 0 auto; }
        .totals-table td { font-weight: bold; padding: 5px; }
        .no-data { text-align: center; color: #888; padding: 20px; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Laporan Transaksi (Setoran & Penarikan)</h1>
        <h4>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM Y') }}</h4>
    </div>

    {{-- Tabel Setoran --}}
    <h2 class="section-title">Daftar Transaksi Setoran</h2>
    <table class="content-table">
        <thead>
            <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Nama Siswa</th>
                <th>Kelas</th>
                <th>Jenis Sampah</th>
                <th>Jumlah (Kg)</th>
                <th>Total (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($setoran as $item)
                <tr>
                    <td class="text-center">{{ $loop->iteration }}</td>
                    <td class="text-center">{{ \Carbon\Carbon::parse($item->created_at)->isoFormat('D MMM Y') }}</td>
                    <td>{{ $item->siswa->pengguna->nama_lengkap ?? 'N/A' }}</td>
                    <td class="text-center">{{ $item->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                    <td>{{ $item->jenisSampah->nama_sampah ?? 'N/A' }}</td>
                    <td class="text-right">{{ number_format($item->jumlah, 2, ',', '.') }}</td>
                    <td class="text-right">{{ number_format($item->total_harga, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="7" class="no-data">Tidak ada data setoran pada periode ini.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    {{-- Tabel Penarikan --}}
    <h2 class="section-title">Daftar Transaksi Penarikan</h2>
    <table class="content-table">
        <thead>
            <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Nama Siswa</th>
                <th>Kelas</th>
                <th>Jumlah Penarikan (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($penarikan as $item)
                <tr>
                    <td class="text-center">{{ $loop->iteration }}</td>
                    <td class="text-center">{{ \Carbon\Carbon::parse($item->tanggal_penarikan)->isoFormat('D MMM Y') }}</td>
                    <td>{{ $item->siswa->pengguna->nama_lengkap ?? 'N/A' }}</td>
                    <td class="text-center">{{ $item->siswa->kelas->nama_kelas ?? 'N/A' }}</td>
                    <td class="text-right">{{ number_format($item->jumlah_penarikan, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="5" class="no-data">Tidak ada data penarikan pada periode ini.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    {{-- Tabel Rekapitulasi & Total --}}
    <div class="summary-container">
        <h2 class="section-title">Rekapitulasi Total</h2>
        <table class="summary-table">
            <thead>
                <tr>
                    <th>Jenis Sampah</th>
                    <th>Total (Pcs)</th>
                    <th>Total Harga (Rp)</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($rekapJenisSampah as $rekap)
                    <tr>
                        <td>{{ $rekap->jenisSampah->nama_sampah }}</td>
                        <td class="text-right">{{ number_format($rekap->total_berat, 2, ',', '.') }}</td>
                        <td class="text-right">{{ number_format($rekap->total_harga, 0, ',', '.') }}</td>
                    </tr>
                @empty
                     <tr>
                        <td colspan="3" class="no-data">Tidak ada rekapitulasi sampah.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>

        <table class="totals-table">
            <tr>
                <td style="width: 70%;">TOTAL KESELURUHAN SETORAN (DEBIT)</td>
                <td class="text-right" style="width: 30%;">
                    Rp {{ number_format($totalSetoran, 0, ',', '.') }}
                </td>
            </tr>
            <tr>
                <td>TOTAL KESELURUHAN PENARIKAN (KREDIT)</td>
                <td class="text-right">
                    Rp {{ number_format($totalPenarikan, 0, ',', '.') }}
                </td>
            </tr>
        </table>
    </div>
</body>
</html>