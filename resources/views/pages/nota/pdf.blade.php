<!DOCTYPE html>
<html>
<head>
    <title>Nota Setoran Kelas</title>
    <style>
        body { font-family: 'Helvetica', sans-serif; font-size: 12px; color: #333; }
        .container { width: 100%; margin: 0 auto; padding: 20px; }
        .header { text-align: center; margin-bottom: 20px; }
        .header h1 { margin: 0; font-size: 24px; }
        .header p { margin: 5px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .text-right { text-align: right; }
        .total-row { font-weight: bold; background-color: #f9f9f9; }
        .footer { margin-top: 40px; text-align: right; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>NOTA SETORAN SAMPAH</h1>
            <p><strong>Bank Sampah Sekolah</strong></p>
        </div>
        <hr>
        <table>
            <tr>
                <td style="border: none; padding: 2px;"><strong>Kelas</strong></td>
                <td style="border: none; padding: 2px;">: {{ $kelas->nama_kelas }}</td>
            </tr>
            <tr>
                <td style="border: none; padding: 2px;"><strong>Wali Kelas</strong></td>
                <td style="border: none; padding: 2px;">: {{ $kelas->waliKelas->nama_lengkap ?? 'Belum Diatur' }}</td>
            </tr>
             <tr>
                <td style="border: none; padding: 2px;"><strong>Periode</strong></td>
                <td style="border: none; padding: 2px;">: {{ $startDate->isoFormat('D MMMM YYYY') }} - {{ $endDate->isoFormat('D MMMM YYYY') }}</td>
            </tr>
        </table>
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Jenis Sampah</th>
                    <th class="text-right">Total Jumlah</th>
                    <th class="text-right">Total Harga</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($rincianSetoran as $rincian)
                    <tr>
                        <td>{{ $loop->iteration }}</td>
                        <td>{{ $rincian->jenisSampah->nama_sampah ?? 'Data Sampah Hilang' }}</td>
                        <td class="text-right">{{ number_format($rincian->total_jumlah, 2, ',', '.') }} {{ $rincian->jenisSampah->satuan ?? '' }}</td>
                        <td class="text-right">Rp {{ number_format($rincian->total_harga, 0, ',', '.') }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="4" style="text-align: center;">Tidak ada data setoran pada periode ini.</td>
                    </tr>
                @endforelse
            </tbody>
            <tfoot>
                <tr class="total-row">
                    <td colspan="3" class="text-right"><strong>TOTAL SETORAN</strong></td>
                    <td class="text-right"><strong>Rp {{ number_format($totalKeseluruhan, 0, ',', '.') }}</strong></td>
                </tr>
                {{-- --- TAMBAHAN BARIS INSENTIF --- --}}
                <tr>
                    <td colspan="3" class="text-right" style="border-bottom: none; border-left: none;">Insentif Wali Kelas ({{ $persentaseWaliKelas }}%)</td>
                    <td class="text-right" style="font-weight: bold; color: green;">Rp {{ number_format($insentifWaliKelas, 0, ',', '.') }}</td>
                </tr>
            </tfoot>
        </table>
        <div class="footer">
            <p>Dicetak pada: {{ now()->isoFormat('D MMMM YYYY, HH:mm') }}</p>
        </div>
    </div>
</body>
</html>