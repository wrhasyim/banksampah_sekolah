<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setoran;
use App\Models\Penjualan;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ChartController extends Controller
{
    /**
     * Mengambil data untuk grafik multifungsi berdasarkan tipe dan periode.
     */
    public function getChartData(Request $request)
    {
        $type = $request->input('type', 'transaksi');
        $period = $request->input('period', 'monthly');

        switch ($type) {
            case 'sampah':
                return $this->getSampahChartData($period);
            case 'transaksi':
            default:
                return $this->getTransaksiChartData($period);
        }
    }

    /**
     * Menyiapkan data transaksi (Setoran & Penjualan) untuk grafik.
     */
    private function getTransaksiChartData($period)
    {
        // ... (Tidak ada perubahan di fungsi ini, biarkan seperti apa adanya)
    }

    /**
     * Menyiapkan data jumlah sampah terkumpul per jenis untuk grafik.
     */
    private function getSampahChartData($period)
    {
        // Inisialisasi query builder
        $query = DB::table('setoran')
            // PERBAIKAN DI SINI: Menggunakan kolom 'id_sampah' yang benar
            ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id');

        // Terapkan filter periode
        switch ($period) {
            case 'today':
                $query->whereDate('setoran.created_at', Carbon::today());
                break;
            case '7d':
                $startDate = Carbon::now()->subDays(6)->startOfDay();
                $query->where('setoran.created_at', '>=', $startDate);
                break;
            case '30d':
                $startDate = Carbon::now()->subDays(29)->startOfDay();
                $query->where('setoran.created_at', '>=', $startDate);
                break;
            case 'monthly':
            default:
                $startDate = Carbon::now()->startOfMonth();
                $query->where('setoran.created_at', '>=', $startDate);
                break;
        }

        // Eksekusi query setelah filter diterapkan
        $data = $query->select('jenis_sampah.nama_sampah', DB::raw('SUM(setoran.jumlah) as total_jumlah'))
            ->groupBy('jenis_sampah.nama_sampah')
            ->orderBy('total_jumlah', 'desc')
            ->get();

        return response()->json([
            'labels' => $data->pluck('nama_sampah'),
            'data' => $data->pluck('total_jumlah'),
        ]);
    }

    // Anda bisa menghapus method debugSampahChart jika sudah tidak diperlukan
    public function debugSampahChart(Request $request)
    {
     
        $period = $request->input('period', 'today'); // Ambil periode dari URL, default 'today'

        $query = DB::table('setoran')
            ->join('jenis_sampah', 'setoran.jenis_sampah_id', '=', 'jenis_sampah.id');

        if ($period == 'today') {
            $query->whereDate('setoran.created_at', now());
        } else {
            // Logika periode lain jika perlu di-debug
        }

        // Tampilkan SQL query dan hasilnya
        $data = $query->select(
                'jenis_sampah.nama_sampah',
                DB::raw('SUM(setoran.jumlah) as total_jumlah'),
                DB::raw('DATE(setoran.created_at) as tanggal_setoran') // Tambahkan ini untuk verifikasi tanggal
            )
            ->groupBy('jenis_sampah.nama_sampah', 'tanggal_setoran')
            ->get();

        // Dump and die: Tampilkan hasilnya dan hentikan eksekusi
        dd($data);
    }
    
}