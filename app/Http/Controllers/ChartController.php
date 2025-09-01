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
        $endDate = Carbon::now();
        $labels = [];
        $dataSetoran = [];
        $dataPenjualan = [];

        if ($period === 'monthly') {
            $startDate = Carbon::now()->startOfYear();
            // Inisialisasi label untuk 12 bulan
            for ($i = 1; $i <= 12; $i++) {
                $labels[] = Carbon::create(null, $i, 1)->format('F');
                $dataSetoran[date('Y-m', mktime(0, 0, 0, $i, 1, date('Y')))] = 0;
                $dataPenjualan[date('Y-m', mktime(0, 0, 0, $i, 1, date('Y')))] = 0;
            }

            $setoran = Setoran::whereBetween('created_at', [$startDate, $endDate])
                ->select(DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month"), DB::raw('SUM(total_harga) as total'))
                ->groupBy('month')->pluck('total', 'month')->all();

            $penjualan = Penjualan::whereBetween('created_at', [$startDate, $endDate])
                ->select(DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month"), DB::raw('SUM(total_harga) as total'))
                ->groupBy('month')->pluck('total', 'month')->all();
            
            foreach ($setoran as $month => $total) $dataSetoran[$month] = $total;
            foreach ($penjualan as $month => $total) $dataPenjualan[$month] = $total;

        } else {
            switch ($period) {
                case 'today':
                    $startDate = Carbon::today();
                    $days = 1;
                    $format = 'D, H:00';
                    $groupBy = DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d %H:00')");
                    $labelFormat = 'H:00';
                    break;
                case '7d':
                    $startDate = Carbon::now()->subDays(6)->startOfDay();
                    $days = 7;
                    $format = 'Y-m-d';
                    $groupBy = DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d')");
                    $labelFormat = 'D, M d';
                    break;
                case '30d':
                default:
                    $startDate = Carbon::now()->subDays(29)->startOfDay();
                    $days = 30;
                    $format = 'Y-m-d';
                    $groupBy = DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d')");
                    $labelFormat = 'M d';
                    break;
            }

            for ($i = 0; $i < $days; $i++) {
                $date = $startDate->copy()->addDays($i);
                $labels[] = $date->format($labelFormat);
                $key = $date->format($format);
                $dataSetoran[$key] = 0;
                $dataPenjualan[$key] = 0;
            }
            
            $setoran = Setoran::whereBetween('created_at', [$startDate, $endDate])
                ->select($groupBy.' as date', DB::raw('SUM(total_harga) as total'))
                ->groupBy('date')->pluck('total', 'date')->all();

            $penjualan = Penjualan::whereBetween('created_at', [$startDate, $endDate])
                ->select($groupBy.' as date', DB::raw('SUM(total_harga) as total'))
                ->groupBy('date')->pluck('total', 'date')->all();

            foreach ($setoran as $date => $total) $dataSetoran[$date] = $total;
            foreach ($penjualan as $date => $total) $dataPenjualan[$date] = $total;
        }

        return response()->json([
            'labels' => $labels,
            'dataSetoran' => array_values($dataSetoran),
            'dataPenjualan' => array_values($dataPenjualan),
        ]);
    }

    /**
     * Menyiapkan data jumlah sampah terkumpul per jenis untuk grafik.
     */
    private function getSampahChartData($period)
    {
        // Inisialisasi query builder
        $query = DB::table('setoran')
            ->join('jenis_sampah', 'setoran.id_jenis_sampah', '=', 'jenis_sampah.id');

        // Terapkan filter periode
        switch ($period) {
            case 'today':
                // Gunakan whereDate untuk memastikan semua data hari ini terambil tanpa peduli waktu
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
}