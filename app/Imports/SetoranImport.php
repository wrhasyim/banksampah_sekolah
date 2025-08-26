<?php

namespace App\Imports;

use App\Models\Setoran;
use App\Models\Siswa;
use App\Models\JenisSampah;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Illuminate\Validation\ValidationException;

class SetoranImport implements ToModel, WithHeadingRow, WithValidation
{
    protected $id_admin;

    // --- CONSTRUCTOR BARU UNTUK MENERIMA ID ADMIN ---
    public function __construct(int $id_admin)
    {
        $this->id_admin = $id_admin;
    }

    public function model(array $row)
    {
        $siswa = Siswa::whereHas('pengguna', fn($q) => $q->where('nama_lengkap', $row['nama_siswa']))
                    ->whereHas('kelas', fn($q) => $q->where('nama_kelas', $row['nama_kelas']))
                    ->first();
        $jenisSampah = JenisSampah::where('nama_sampah', $row['nama_sampah'])->first();

        if (!$siswa) {
            throw ValidationException::withMessages(['file' => 'Kombinasi siswa "' . ($row['nama_siswa'] ?? '') . '" dan kelas "' . ($row['nama_kelas'] ?? '') . '" tidak ditemukan.']);
        }
        if (!$jenisSampah) {
            throw ValidationException::withMessages(['file' => 'Jenis sampah "' . ($row['nama_sampah'] ?? '') . '" tidak ditemukan.']);
        }

        DB::transaction(function () use ($siswa, $jenisSampah, $row) {
            $totalHarga = $jenisSampah->harga_per_satuan * $row['jumlah'];

            Setoran::create([
                'id_siswa' => $siswa->id,
                'id_jenis_sampah' => $jenisSampah->id,
                'id_admin' => $this->id_admin, // <-- Gunakan ID admin yang sudah disimpan
                'jumlah' => $row['jumlah'],
                'total_harga' => $totalHarga,
            ]);

            $siswa->increment('saldo', $totalHarga);
            $jenisSampah->increment('stok', $row['jumlah']);
        });

        return null;
    }

    public function rules(): array
    {
        return [
            'nama_siswa' => 'required|string',
            'nama_kelas' => 'required|string',
            'nama_sampah' => 'required|string',
            'jumlah' => 'required|numeric|min:0.01',
        ];
    }
}