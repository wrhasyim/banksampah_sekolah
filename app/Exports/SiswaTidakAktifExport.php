<?php
// File: app/Exports/SiswaTidakAktifExport.php

namespace App\Exports;

use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class SiswaTidakAktifExport implements FromView, ShouldAutoSize
{
    protected $siswa;

    public function __construct($siswa)
    {
        $this->siswa = $siswa;
    }

    public function view(): View
    {
        return view('pages.siswa.partials.export-table', [
            'siswa' => $this->siswa
        ]);
    }
}