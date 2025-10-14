<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penarikan;
use App\Models\Pengguna;
use App\Models\Insentif;
use App\Models\BukuKas;
use App\Models\Penjualan;
use Illuminate\Support\Facades\Cache;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class RekapanController extends Controller
{
    /**
     * Membuat query dasar untuk laporan siswa terlambat dengan filter tanggal.
     */
    private function getSiswaTerlambatQuery(Request $request)
    {
        $query = Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'terlambat')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'));

        // Terapkan filter tanggal jika ada
        if ($request->filled('start_date') && $request->filled('end_date')) {
            $query->whereBetween('created_at', [$request->start_date, $request->end_date]);
        }

        return $query->latest();
    }

    public function indexSiswaTerlambat(Request $request)
    {
        // Ambil tanggal dari request atau gunakan default bulan ini
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        $currentPage = $request->input('page', 1);
        // Buat cache key yang unik berdasarkan filter tanggal dan halaman
        $cacheKey = 'rekapan_siswa_terlambat_page_' . $currentPage . '_' . md5($startDate . $endDate);

        $setoranTerlambat = Cache::remember($cacheKey, now()->addMinutes(60), function () use ($request) {
            return $this->getSiswaTerlambatQuery($request)->paginate(15);
        });

        // Kirim variabel tanggal ke view
        return view('pages.rekapan.siswa-terlambat', compact('setoranTerlambat', 'startDate', 'endDate'));
    }

    public function exportSiswaTerlambatPdf(Request $request)
    {
        // Ambil tanggal dari request atau gunakan default bulan ini
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());

        // Buat cache key yang unik berdasarkan filter tanggal
        $cacheKey = 'export_rekapan_siswa_terlambat_' . md5($startDate . $endDate);
        
        $data = Cache::remember($cacheKey, now()->addMinutes(60), function () use ($request) {
            return $this->getSiswaTerlambatQuery($request)->get();
        });

        // Kirim variabel tanggal ke view PDF
        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-terlambat-pdf', [
            'data' => $data,
            'startDate' => $startDate,
            'endDate' => $endDate
        ]);
        return $pdf->download('laporan-rinci-setoran-terlambat-'.date('Y-m-d').'.pdf');
    }
    
    /**
     * Membuat query dasar untuk laporan siswa tanpa wali kelas (tanpa insentif).
     */
    private function getSiswaTanpaWaliKelasQuery()
    {
        return Setoran::with(['siswa.pengguna', 'siswa.kelas', 'jenisSampah'])
            ->where('status', 'normal')
            ->whereDoesntHave('insentif')
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'not like', '%guru%'))
            ->latest();
    }
    
    public function indexSiswaTanpaWaliKelas(Request $request)
    {
        $currentPage = $request->input('page', 1);
        $cacheKey = 'rekapan_tanpa_wali_kelas_page_' . $currentPage;

        $setoranTanpaWaliKelas = Cache::remember($cacheKey, now()->addMinutes(60), function () {
            return $this->getSiswaTanpaWaliKelasQuery()->paginate(15);
        });

        return view('pages.rekapan.siswa-tanpa-wali-kelas', compact('setoranTanpaWaliKelas'));
    }

    public function exportSiswaTanpaWaliKelasPdf()
    {
        $cacheKey = 'export_rekapan_tanpa_wali_kelas';

        $data = Cache::remember($cacheKey, now()->addMinutes(60), function () {
            return $this->getSiswaTanpaWaliKelasQuery()->get();
        });

        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-tanpa-wali-kelas-pdf', ['data' => $data]);
        return $pdf->download('rekapan-setoran-tanpa-insentif-'.date('Y-m-d').'.pdf');
    }
    
    /**
     * Membuat query dasar untuk laporan setoran guru dengan filter tanggal.
     */
    private function getGuruQuery(Request $request)
    {
        $query = Setoran::with(['siswa.pengguna', 'jenisSampah'])
            ->whereHas('siswa.kelas', fn($q) => $q->where('nama_kelas', 'like', '%guru%'));

        if ($request->filled('start_date') && $request->filled('end_date')) {
            $query->whereBetween('created_at', [$request->start_date, $request->end_date]);
        }

        return $query->latest();
    }

    public function indexGuru(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());
        
        $currentPage = $request->input('page', 1);
        $cacheKey = 'rekapan_guru_page_' . $currentPage . '_' . md5($startDate.$endDate);

        $setoranGuru = Cache::remember($cacheKey, now()->addMinutes(60), function() use ($request) {
            return $this->getGuruQuery($request)->paginate(10);
        });

        return view('pages.rekapan.rekapan-guru', compact('setoranGuru', 'startDate', 'endDate'));
    }

    public function exportGuruPdf(Request $request)
    {
        $startDate = $request->input('start_date', Carbon::now()->startOfMonth()->toDateString());
        $endDate = $request->input('end_date', Carbon::now()->endOfMonth()->toDateString());
        
        $cacheKey = 'export_rekapan_guru_pdf_data_' . md5($startDate.$endDate);

        $pdfData = Cache::remember($cacheKey, now()->addMinutes(60), function () use ($request, $startDate, $endDate) {
            $setoranGuru = $this->getGuruQuery($request)->get();
            $rekapData = [];
            foreach ($setoranGuru as $setoran) {
                $guruId = $setoran->siswa->id;
                $namaGuru = $setoran->siswa->pengguna->nama_lengkap;

                if (!isset($rekapData[$guruId])) {
                    $rekapData[$guruId] = [
                        'nama_guru' => $namaGuru,
                        'total_harga' => 0,
                        'sampah' => [],
                    ];
                }

                $rekapData[$guruId]['total_harga'] += $setoran->total_harga;

                $jenisSampah = $setoran->jenisSampah->nama_sampah;
                $satuan = $setoran->jenisSampah->satuan;
                if (!isset($rekapData[$guruId]['sampah'][$jenisSampah])) {
                    $rekapData[$guruId]['sampah'][$jenisSampah] = [
                        'jumlah' => 0,
                        'satuan' => $satuan,
                    ];
                }
                $rekapData[$guruId]['sampah'][$jenisSampah]['jumlah'] += $setoran->jumlah;
            }

            $rekapJenisSampahKeseluruhan = $setoranGuru->groupBy('jenisSampah.nama_sampah')
                ->map(function ($items, $namaSampah) {
                    return [
                        'nama_sampah' => $namaSampah,
                        'total_pcs' => $items->sum('jumlah'),
                        'total_harga' => $items->sum('total_harga'),
                    ];
                })->values();

            $totalSetoranKeseluruhan = $setoranGuru->sum('total_harga');

            $totalPenarikanKeseluruhan = Penarikan::whereHas('siswa.pengguna', function ($query) {
                $query->whereIn('role', ['guru', 'wali-kelas']);
            })
            ->where('status', 'disetujui')
            ->whereBetween('created_at', [$startDate, $endDate])
            ->sum('jumlah_penarikan');

            return [
                'rekapData' => $rekapData,
                'rekapJenisSampahGuru' => $rekapJenisSampahKeseluruhan,
                'totalSetoranGuru' => $totalSetoranKeseluruhan,
                'totalPenarikanGuru' => $totalPenarikanKeseluruhan,
                'startDate' => $startDate,
                'endDate' => $endDate,
            ];
        });

        $pdf = Pdf::loadView('pages.rekapan.pdf.rekapan-guru-summary-pdf', $pdfData);
        return $pdf->download('rekapitulasi-setoran-guru-'.date('Y-m-d').'.pdf');
    }
    
    /**
     * ===================================================================
     * FITUR BARU: REKAPAN MENYELURUH
     * ===================================================================
     */

    /**
     * Menampilkan halaman rekapitulasi menyeluruh.
     */
    public function rekapMenyeluruh(Request $request)
    {
        // 1. Setoran Siswa (berdasarkan role 'siswa')
        $setoranSiswa = Setoran::join('siswa', 'setoran.siswa_id', '=', 'siswa.id')
            ->join('pengguna', 'siswa.id_pengguna', '=', 'pengguna.id')
            ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
            ->where('pengguna.role', 'siswa')
            ->selectRaw('jenis_sampah.nama_sampah as jenis_sampah, SUM(setoran.jumlah) as total_jumlah, SUM(setoran.total_harga) as total_harga')
            ->groupBy('jenis_sampah.nama_sampah')
            ->get();

        // 2. Setoran Guru (berdasarkan role 'guru' atau 'wali-kelas')
        $setoranGuru = Setoran::join('siswa', 'setoran.siswa_id', '=', 'siswa.id')
            ->join('pengguna', 'siswa.id_pengguna', '=', 'pengguna.id')
            ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id')
            ->whereIn('pengguna.role', ['guru', 'wali-kelas'])
            ->selectRaw('jenis_sampah.nama_sampah as jenis_sampah, SUM(setoran.jumlah) as total_jumlah, SUM(setoran.total_harga) as total_harga')
            ->groupBy('jenis_sampah.nama_sampah')
            ->get();

        // 3. Insentif Walas (hanya yang sudah dibayarkan)
        $totalInsentifWalas = Insentif::where('jenis', 'wali-kelas')
            ->where('status_pembayaran', 'sudah dibayar')
            ->sum('jumlah_insentif');

        // 4. Insentif Sekolah (hanya yang sudah didapat/dibayarkan)
        $totalInsentifSekolah = Insentif::where('jenis', 'sekolah')
            ->where('status_pembayaran', 'sudah dibayar')
            ->sum('jumlah_insentif');

        // 5. Pengeluaran (dari Buku Kas)
        $totalPengeluaran = BukuKas::where('tipe', 'pengeluaran')->sum('jumlah'); // <-- PERBAIKAN

        // 6. Hasil Penjualan
        $totalPenjualan = Penjualan::sum('total_harga');

        // 7. Hitung Kas
        $kas = $totalPenjualan - ($totalPengeluaran + $totalInsentifWalas + $totalInsentifSekolah);

        return view('pages.rekapan.menyeluruh', compact(
            'setoranSiswa',
            'setoranGuru',
            'totalInsentifWalas',
            'totalInsentifSekolah',
            'totalPengeluaran',
            'totalPenjualan',
            'kas'
        ));
    }
}