<?php

namespace App\Imports;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
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
            if (empty($row['nama']) || empty($row['jenis_sampah']) || empty($row['jumlah'])) {
                continue;
            }

            $pengguna = Pengguna::where('nama_lengkap', $row['nama'])->first();

            if ($pengguna) {
                $siswa = Siswa::where('id_pengguna', $pengguna->id)->first();
            } else {
                continue;
            }
            
            $jenisSampah = JenisSampah::where('nama_sampah', 'like', '%' . $row['jenis_sampah'] . '%')->first();

            if ($siswa && $jenisSampah) {
                $jumlah_satuan = (float) $row['jumlah'];
                
                DB::transaction(function () use ($siswa, $jenisSampah, $jumlah_satuan, $adminId) {
                    Setoran::create([
                        'id_siswa' => $siswa->id,
                        'id_jenis_sampah' => $jenisSampah->id,
                        'id_admin' => $adminId,
                        'jumlah_satuan' => $jumlah_satuan, // Menggunakan 'jumlah_satuan'
                        'total_harga' => $jumlah_satuan * $jenisSampah->harga_per_satuan, // Menggunakan 'harga_per_satuan' dari jenis sampah
                    ]);
                    
                    $siswa->saldo += $jumlah_satuan * $jenisSampah->harga_per_satuan;
                    $siswa->save();
                });
            }
        }
    }
}