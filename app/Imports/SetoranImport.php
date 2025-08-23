<?php

namespace App\Imports;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use App\Models\Kelas;
use App\Models\Pengguna;
use Illuminate\Support\Collection;
use Maatwebsite\Excel\Concerns\ToCollection;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class SetoranImport implements ToCollection, WithHeadingRow
{
    public function collection(Collection $rows)
    {
        $adminId = Auth::id();

        foreach ($rows as $row) 
        {
            if (empty($row['nama']) || empty($row['kelas']) || empty($row['jenis_sampah']) || empty($row['jumlah'])) {
                continue;
            }

            // Temukan kelas berdasarkan nama
            $kelas = Kelas::where('nama_kelas', $row['kelas'])->first();
            if (!$kelas) {
                continue;
            }

            // Temukan siswa berdasarkan nama dan kelas
            $siswa = Siswa::where('id_kelas', $kelas->id)
                            ->whereHas('pengguna', function ($query) use ($row) {
                                $query->where('nama_lengkap', $row['nama']);
                            })->first();
            
            // Temukan jenis sampah
            $jenisSampah = JenisSampah::where('nama_sampah', 'like', '%' . $row['jenis_sampah'] . '%')->first();

            if ($siswa && $jenisSampah) {
                $jumlah_satuan = (float) $row['jumlah'];
                
                DB::transaction(function () use ($siswa, $jenisSampah, $jumlah_satuan, $adminId) {
                    Setoran::create([
                        'id_siswa' => $siswa->id,
                        'id_jenis_sampah' => $jenisSampah->id,
                        'id_admin' => $adminId,
                        'jumlah_satuan' => $jumlah_satuan,
                        'total_harga' => $jumlah_satuan * $jenisSampah->harga_per_satuan,
                    ]);
                    
                    $siswa->saldo += $jumlah_satuan * $jenisSampah->harga_per_satuan;
                    $siswa->save();
                });
            }
        }
    }
}