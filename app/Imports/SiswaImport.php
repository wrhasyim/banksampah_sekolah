<?php

namespace App\Imports;

use App\Models\Siswa;
use App\Models\Pengguna;
use App\Models\Kelas;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Maatwebsite\Excel\Concerns\Importable;
use Illuminate\Support\Str;

class SiswaImport implements ToModel, WithHeadingRow, WithChunkReading
{
    use Importable;

    private $kelasCollection;

    public function __construct()
    {
        // Ambil semua data kelas sekali saja di awal
        $this->kelasCollection = Kelas::pluck('id', 'nama_kelas');
    }

    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        // PERBAIKAN: Secara eksplisit konversi data ke string sebelum digunakan.
        // Ini mengatasi masalah Excel yang membaca NIS dan password sebagai angka.
        $row['nama_lengkap'] = (string) ($row['nama_lengkap'] ?? '');
        $row['username']     = (string) ($row['username'] ?? '');
        $row['password']     = (string) ($row['password'] ?? Str::random(10));
        $row['nis']          = (string) ($row['nis'] ?? null);
        $row['nama_kelas']   = (string) ($row['nama_kelas'] ?? '');
        
        // Lakukan validasi manual di sini
        if (empty($row['nama_lengkap']) || empty($row['username']) || empty($row['nama_kelas'])) {
            return null; // Lewati baris yang tidak lengkap
        }

        $idKelas = $this->kelasCollection->get($row['nama_kelas']);

        // Jika kelas tidak ditemukan, lewati baris ini.
        if (is_null($idKelas)) {
            return null;
        }

        // Mulai transaksi database untuk setiap baris
        DB::beginTransaction();

        try {
            // Cek apakah username sudah ada
            $pengguna = Pengguna::firstOrNew(['username' => $row['username']]);
            
            // Jika pengguna baru, buat data pengguna
            if (!$pengguna->exists) {
                $pengguna->nama_lengkap = $row['nama_lengkap'];
                $pengguna->password     = Hash::make($row['password']);
                $pengguna->role         = 'siswa';
                $pengguna->save();
            }

            // Cek apakah NIS sudah ada
            $siswa = Siswa::firstOrNew(['nis' => $row['nis']]);
            
            // Jika NIS baru, buat data siswa
            if (!$siswa->exists) {
                $siswa->id_pengguna = $pengguna->id;
                $siswa->id_kelas    = $idKelas;
                $siswa->nis         = $row['nis'];
                $siswa->saldo       = 0;
                $siswa->save();
            }
            DB::commit();
            return $siswa;

        } catch (\Exception $e) {
            DB::rollback();
            // Lanjutkan impor tanpa menghentikan proses
            return null;
        }
    }

    // `rules()` dan metode validasi lainnya dihapus karena validasi sekarang manual
    public function chunkSize(): int
    {
        return 100;
    }
}