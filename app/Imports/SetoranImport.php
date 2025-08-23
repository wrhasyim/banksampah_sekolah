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
use Maatwebsite\Excel\Concerns\WithValidation;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

class SetoranImport implements ToCollection, WithHeadingRow, WithValidation
{
    public function collection(Collection $rows)
    {
        $adminId = Auth::id();

        foreach ($rows as $row) 
        {
            $kelas = Kelas::where('nama_kelas', $row['kelas'])->first();
            $siswa = Siswa::where('id_kelas', $kelas->id)
                            ->whereHas('pengguna', function ($query) use ($row) {
                                $query->where('nama_lengkap', $row['nama']);
                            })->first();
            
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

    public function rules(): array
    {
        return [
            'nama' => 'required|string|max:255',
            'kelas' => 'required|string|exists:kelas,nama_kelas',
            'jenis_sampah' => 'required|string|exists:jenis_sampah,nama_sampah',
            'jumlah' => 'required|numeric|min:1',
        ];
    }
}