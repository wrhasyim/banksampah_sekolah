<!DOCTYPE html>
<html>
<head>
    <title>Laporan Transaksi Per Kelas</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        h1, h2, h4 { text-align: center; }
        h1 { font-size: 18px; margin-bottom: 5px; }
        h4 { font-size: 14px; font-weight: normal; margin-top: 0; margin-bottom: 20px; }
        h2 { margin-top: 30px; border-top: 1px solid #ccc; padding-top: 20px; font-size: 16px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; font-size: 10px; }
        th, td { border: 1px solid #000; padding: 6px; text-align: left; }
        th { background-color: #f2f2f2; }
        .total-row { font-weight: bold; background-color: #e8e8e8; }
        .no-data { text-align: center; color: #888; }
        .page-break { page-break-after: always; }
    </style>
</head>
<body>
    <h1>Laporan Rekapitulasi Setoran Sampah</h1>
    <h4>Periode: {{ \Carbon\Carbon::parse($startDate)->isoFormat('D MMMM Y') }} - {{ \Carbon\Carbon::parse($endDate)->isoFormat('D MMMM Y') }}</h4>

    @forelse ($dataLaporan as $dataKelas)
        {{-- PERUBAHAN: Logika untuk memfilter jenis sampah yang aktif untuk kelas ini --}}
        @php
            $activeJenisSampah = collect($jenisSampahList)->filter(function($jenis) use ($dataKelas) {
                return ($dataKelas['total_per_sampah'][$jenis->id] ?? 0) >= 1;
            });
        @endphp

        {{-- Hanya tampilkan tabel jika ada jenis sampah yang aktif --}}
        @if($activeJenisSampah->isNotEmpty())
            <h2>Kelas: {{ $dataKelas['nama_kelas'] }}</h2>
            <table>
                <thead>
                    <tr>
                        <th style="width: 20%;">Nama Siswa</th>
                        {{-- Gunakan $activeJenisSampah untuk membuat header --}}
                        @foreach ($activeJenisSampah as $jenisSampah)
                            <th style="text-align: center;">{{ $jenisSampah->nama_sampah }} ({{ $jenisSampah->satuan }})</th>
                        @endforeach
                    </tr>
                </thead>
                <tbody>
                    @forelse ($dataKelas['siswa'] as $dataSiswa)
                        <tr>
                            <td>{{ $dataSiswa['nama_siswa'] }}</td>
                            {{-- Gunakan $activeJenisSampah untuk menampilkan data --}}
                            @foreach ($activeJenisSampah as $jenisSampah)
                                @php
                                    $jumlah = $dataSiswa['setoran'][$jenisSampah->id] ?? 0;
                                @endphp
                                <td style="text-align: center;">{{ $jumlah > 0 ? number_format($jumlah, 2, ',', '.') : '-' }}</td>
                            @endforeach
                        </tr>
                    @empty
                        <tr>
                            <td colspan="{{ $activeJenisSampah->count() + 1 }}" class="no-data">Tidak ada data setoran di kelas ini.</td>
                        </tr>
                    @endforelse
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td>TOTAL PER JENIS SAMPAH</td>
                        {{-- Gunakan $activeJenisSampah untuk menampilkan total --}}
                        @foreach ($activeJenisSampah as $jenisSampah)
                            @php
                                $total = $dataKelas['total_per_sampah'][$jenisSampah->id] ?? 0;
                            @endphp
                            <td style="text-align: center;">{{ number_format($total, 2, ',', '.') }}</td>
                        @endforeach
                    </tr>
                </tfoot>
            </table>

            @if (!$loop->last)
                <div class="page-break"></div>
            @endif
        @endif
    @empty
        <p class="no-data">Tidak ada data setoran untuk ditampilkan pada periode yang dipilih.</p>
    @endforelse

</body>
</html>