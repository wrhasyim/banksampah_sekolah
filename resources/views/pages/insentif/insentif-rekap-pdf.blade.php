<!DOCTYPE html>
<html>
<head>
    <title>Rekapitulasi Insentif Gabungan</title>
    <style>
        body { font-family: 'sans-serif'; margin: 20px; font-size: 12px; }
        .header h1, .header h4 { text-align: center; margin: 5px 0; }
        .header h1 { font-size: 18px; }
        .header h4 { font-size: 14px; font-weight: normal; }
        .content-table { width: 100%; border-collapse: collapse; margin-bottom: 25px; }
        .content-table th, .content-table td { border: 1px solid #000; padding: 6px; }
        .content-table th { background-color: #f2f2f2; text-align: center; }
        .text-right { text-align: right; }
        .no-data { text-align: center; color: #888; padding: 20px; }
        .totals-row td { font-weight: bold; background-color: #f2f2f2; }
        .section-title { font-size: 16px; font-weight: bold; margin-top: 20px; margin-bottom: 5px;}
    </style>
</head>
<body>
    <div class="header">
        <h1>Rekapitulasi Insentif Gabungan</h1>
        <h4>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM Y') }}</h4>
    </div>

    {{-- Tabel Insentif Wali Kelas --}}
    <div class="section-title">Insentif Wali Kelas</div>
    <table class="content-table">
        <thead>
            <tr>
                <th>Nama Wali Kelas</th>
                <th class="text-right">Total Insentif (Rp)</th>
                <th class="text-right">Sudah Dibayar (Rp)</th>
                <th class="text-right">Belum Dibayar (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($rekapWaliKelas as $item)
                <tr>
                    <td>{{ $item['nama_wali_kelas'] }}</td>
                    <td class="text-right">{{ number_format($item['total_insentif'], 0, ',', '.') }}</td>
                    <td class="text-right">{{ number_format($item['sudah_dibayar'], 0, ',', '.') }}</td>
                    <td class="text-right">{{ number_format($item['belum_dibayar'], 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="4" class="no-data">Tidak ada data.</td></tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr class="totals-row">
                <td class="text-right" colspan="3">Total Insentif Wali Kelas</td>
                <td class="text-right">Rp {{ number_format($totalWaliKelas, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>

    {{-- Tabel Insentif Pengelola --}}
    <div class="section-title">Insentif Pengelola</div>
    <table class="content-table">
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Keterangan</th>
                <th class="text-right" style="width: 25%;">Jumlah (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($insentifPengelola as $item)
                <tr>
                    <td style="width: 25%; text-align:center;">{{ \Carbon\Carbon::parse($item->tanggal)->format('d M Y') }}</td>
                    <td>{{ $item->deskripsi }}</td>
                    <td class="text-right">{{ number_format($item->jumlah, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="3" class="no-data">Tidak ada data.</td></tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr class="totals-row">
                <td colspan="2" class="text-right">Total Insentif Pengelola</td>
                <td class="text-right">Rp {{ number_format($totalPengelola, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>

    {{-- Tabel Insentif Sekolah --}}
    <div class="section-title">Insentif Sekolah</div>
    <table class="content-table">
        <thead>
            <tr>
                <th>Tanggal</th>
                <th>Keterangan</th>
                <th class="text-right" style="width: 25%;">Jumlah (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($insentifSekolah as $item)
                <tr>
                    <td style="width: 25%; text-align:center;">{{ \Carbon\Carbon::parse($item->tanggal)->format('d M Y') }}</td>
                    <td>{{ $item->deskripsi }}</td>
                    <td class="text-right">{{ number_format($item->jumlah, 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr><td colspan="3" class="no-data">Tidak ada data.</td></tr>
            @endforelse
        </tbody>
        <tfoot>
            <tr class="totals-row">
                <td colspan="2" class="text-right">Total Insentif Sekolah</td>
                <td class="text-right">Rp {{ number_format($totalSekolah, 0, ',', '.') }}</td>
            </tr>
        </tfoot>
    </table>

</body>
</html>