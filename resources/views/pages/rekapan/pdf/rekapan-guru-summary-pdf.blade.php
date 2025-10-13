<!DOCTYPE html>
<html>
<head>
    <title>Rekapitulasi Setoran Guru</title>
    <style>
        body { font-family: 'sans-serif'; margin: 20px; font-size: 11px; }
        .header h1, .header h4 { text-align: center; margin: 5px 0; }
        .header h1 { font-size: 18px; }
        .header h4 { font-size: 14px; font-weight: normal; }
        
        .guru-block { page-break-inside: avoid; margin-bottom: 25px; border: 1px solid #eee; padding: 10px; }
        .guru-name { font-size: 14px; font-weight: bold; margin-bottom: 5px; }
        .sub-table { width: 100%; border-collapse: collapse; margin-top: 5px; }
        .sub-table th, .sub-table td { border: 1px solid #ccc; padding: 4px; }
        .sub-table th { background-color: #fafafa; text-align: center; }
        .no-data { text-align: center; color: #888; padding: 20px; }

        /* Style untuk rekapitulasi keseluruhan */
        .summary-container { margin-top: 40px; page-break-before: auto; page-break-inside: avoid; }
        .summary-table { width: 70%; margin: 20px auto 0 auto; border-collapse: collapse; }
        .summary-table th, .summary-table td { border: 1px solid #000; padding: 6px; }
        .summary-table th { background-color: #f2f2f2; text-align: center; }
        .totals-table { width: 70%; margin: 20px auto 0 auto; }
        .totals-table td { font-weight: bold; padding: 5px; }
        .section-title { font-size: 16px; margin-top: 30px; margin-bottom: 10px; text-align: center; }
        .text-right { text-align: right; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Rekapitulasi Rinci Setoran Guru</h1>
        <h4>Dicetak pada: {{ date('d M Y') }}</h4>
    </div>

    @forelse ($rekapData as $guruId => $data)
        <div class="guru-block">
            <div class="guru-name">{{ $loop->iteration }}. {{ $data['nama_guru'] }}</div>
            <strong>Total Setoran: Rp {{ number_format($data['total_harga'], 0, ',', '.') }}</strong>
            <table class="sub-table">
                <thead>
                    <tr>
                        <th>Jenis Sampah</th>
                        <th>Jumlah</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse ($data['sampah'] as $namaSampah => $detail)
                        <tr>
                            <td>{{ $namaSampah }}</td>
                            <td class="text-right">{{ number_format($detail['jumlah'], 0, ',', '.') }} {{ $detail['satuan'] }}</td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="2" style="text-align:center;">- Tidak ada rincian sampah -</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    @empty
        <p class="no-data">Tidak ada data setoran guru untuk ditampilkan.</p>
    @endforelse

    {{-- BAGIAN REKAPITULASI KESELURUHAN --}}
    @if (!empty($rekapData))
    <div class="summary-container">
        <h2 class="section-title">Rekapitulasi Keseluruhan (Semua Guru)</h2>
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
                        <td>{{ $rekap['nama_sampah'] }}</td>
                        <td class="text-right">{{ number_format($rekap['total_pcs'], 0, ',', '.') }}</td>
                        <td class="text-right">{{ number_format($rekap['total_harga'], 0, ',', '.') }}</td>
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
    @endif
    
</body>
</html>