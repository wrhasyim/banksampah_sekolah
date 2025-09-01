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
     * KHUSUS Menyiapkan data transaksi (Setoran & Penjualan) untuk grafik.
     */
    public function getTransaksiChartData(Request $request)
    {
        $period = $request->input('period', 'monthly');
        $endDate = Carbon::now();
        $labels = [];
        $dataSetoranData = [];
        $dataPenjualanData = [];

        if ($period === 'monthly') {
            $startDate = Carbon::now()->startOfYear();
            for ($i = 1; $i <= 12; $i++) {
                $monthKey = date('Y-m', mktime(0, 0, 0, $i, 1, date('Y')));
                $labels[] = Carbon::createFromFormat('!m', $i)->format('F');
                $dataSetoranData[$monthKey] = 0;
                $dataPenjualanData[$monthKey] = 0;
            }

            $setoran = Setoran::whereBetween('created_at', [$startDate, $endDate])
                ->select(DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month"), DB::raw('SUM(total_harga) as total'))
                ->groupBy('month')->pluck('total', 'month')->all();

            $penjualan = Penjualan::whereBetween('created_at', [$startDate, $endDate])
                ->select(DB::raw("DATE_FORMAT(created_at, '%Y-%m') as month"), DB::raw('SUM(total_harga) as total'))
                ->groupBy('month')->pluck('total', 'month')->all();
            
            foreach ($setoran as $month => $total) $dataSetoranData[$month] = $total;
            foreach ($penjualan as $month => $total) $dataPenjualanData[$month] = $total;

        } else {
            switch ($period) {
                case 'today':
                    $startDate = Carbon::today();
                    $days = 1;
                    $labelFormat = 'H:00'; // Untuk hari ini, kita tampilkan per jam
                    $groupBy = DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d %H:00')");
                    for ($i = 0; $i < 24; $i++) {
                        $date = $startDate->copy()->addHours($i);
                        $key = $date->format('Y-m-d H:00');
                        $labels[] = $date->format($labelFormat);
                        $dataSetoranData[$key] = 0;
                        $dataPenjualanData[$key] = 0;
                    }
                    break;
                case '7d':
                    $startDate = Carbon::now()->subDays(6)->startOfDay();
                    $days = 7;
                    $labelFormat = 'D, d M';
                    break;
                case '30d':
                default:
                    $startDate = Carbon::now()->subDays(29)->startOfDay();
                    $days = 30;
                    $labelFormat = 'd M';
                    break;
            }
            
            if ($period !== 'today') {
                 $groupBy = DB::raw("DATE_FORMAT(created_at, '%Y-%m-%d')");
                 for ($i = 0; $i < $days; $i++) {
                    $date = $startDate->copy()->addDays($i);
                    $key = $date->format('Y-m-d');
                    $labels[] = $date->format($labelFormat);
                    $dataSetoranData[$key] = 0;
                    $dataPenjualanData[$key] = 0;
                 }
            }
            
            $setoran = Setoran::whereBetween('created_at', [$startDate, $endDate])
                ->select($groupBy . ' as date', DB::raw('SUM(total_harga) as total'))
                ->groupBy('date')->pluck('total', 'date')->all();

            $penjualan = Penjualan::whereBetween('created_at', [$startDate, $endDate])
                ->select($groupBy . ' as date', DB::raw('SUM(total_harga) as total'))
                ->groupBy('date')->pluck('total', 'date')->all();

            foreach ($setoran as $date => $total) if(isset($dataSetoranData[$date])) $dataSetoranData[$date] = $total;
            foreach ($penjualan as $date => $total) if(isset($dataPenjualanData[$date])) $dataPenjualanData[$date] = $total;
        }

        return response()->json([
            'labels' => $labels,
            'dataSetoran' => array_values($dataSetoranData),
            'dataPenjualan' => array_values($dataPenjualanData),
        ]);
    }

    /**
     * KHUSUS Menyiapkan data jumlah sampah terkumpul per jenis untuk grafik.
     */
    public function getSampahChartData(Request $request)
    {
        $period = $request->input('period', 'monthly');
        $query = DB::table('setoran')
            ->join('jenis_sampah', 'setoran.id_sampah', '=', 'jenis_sampah.id');

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