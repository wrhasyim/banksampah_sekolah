<!DOCTYPE html>
<html>
<head>
    <title>Rekapan Setoran Guru</title>
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
        .no-data { text-align: center; color: #888; padding: 20px; }
        
        /* Style untuk rekapitulasi */
        .summary-container { margin-top: 40px; page-break-inside: avoid; }
        .summary-table { width: 60%; margin: 20px auto 0 auto; border-collapse: collapse; }
        .summary-table th, .summary-table td { border: 1px solid #000; padding: 6px; }
        .summary-table th { background-color: #f2f2f2; text-align: center; }
        .totals-table { width: 60%; margin: 20px auto 0 auto; }
        .totals-table td { font-weight: bold; padding: 5px; }
        .section-title { font-size: 16px; margin-top: 30px; margin-bottom: 10px; text-align: center; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Rekapan Setoran Guru</h1>
        <h4>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM Y') }}</h4>
    </div>

    <table class="content-table">
        <thead>
            <tr>
                <th>No</th>
                <th>Nama Guru</th>
                <th>Total Setoran (Rp)</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($guruData as $data)
                <tr>
                    <td class="text-center">{{ $loop->iteration }}</td>
                    <td>{{ $data['nama'] }}</td>
                    <td class="text-right">{{ number_format($data['total_setoran'], 0, ',', '.') }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="3" class="no-data">Tidak ada data guru pada periode ini.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    {{-- BAGIAN REKAPITULASI --}}
    <div class="summary-container">
        <h2 class="section-title">Rekapitulasi Total</h2>
        <table class="summary-table">
            <thead>
                <tr>
                    <th>Jenis Sampah</th>
                    <th>Total Sampah (Pcs)</th>
                    <th>Total Harga (Rp)</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($rekapJenisSampahGuru as $rekap)
                    <tr>
                        <td>{{ $rekap->nama_sampah }}</td>
                        <td class="text-right">{{ number_format($rekap->total_pcs, 0, ',', '.') }}</td>
                        <td class="text-right">{{ number_format($rekap->total_harga, 0, ',', '.') }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="3" class="no-data">Tidak ada data setoran.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>

        <table class="totals-table">
            <tr>
                <td style="width: 70%;">TOTAL KESELURUHAN SETORAN (DEBIT)</td>
                <td class="text-right" style="width: 30%;">
                    Rp {{ number_format($totalSetoranGuru, 0, ',', '.') }}
                </td>
            </tr>
            <tr>
                <td>TOTAL KESELURUHAN PENARIKAN (KREDIT)</td>
                <td class="text-right">
                    Rp {{ number_format($totalPenarikanGuru, 0, ',', '.') }}
                </td>
            </tr>
        </table>
    </div>
    
</body>
</html>