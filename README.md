# Aplikasi Bank Sampah Sekolah

Aplikasi web modern berbasis **Laravel 12** untuk mengelola operasional bank sampah di lingkungan sekolah secara efisien, transparan, dan interaktif.

## Deskripsi Proyek

Proyek ini dibangun sebagai solusi digital lengkap untuk memfasilitasi program bank sampah di sekolah. Aplikasi ini mendorong partisipasi siswa dalam memilah sampah melalui sistem gamifikasi, memberikan kemudahan bagi admin untuk mengelola seluruh alur transaksi dan keuangan, serta menyajikan data informatif melalui dashboard dan laporan yang komprehensif.

## Fitur Utama

Aplikasi ini memiliki dua peran pengguna utama: **Admin** dan **Siswa**, dengan fungsionalitas yang disesuaikan untuk masing-masing peran.

### Fitur untuk Admin

  - **Dashboard Analitis & Strategis:**

      - Menampilkan ringkasan data kunci: Total Siswa, Total Saldo Tabungan, Total Kas, dan Stok Sampah Siap Jual.
      - Grafik tren setoran dinamis yang dapat difilter berdasarkan jangka waktu.
      - Widget informatif: Peringkat 5 siswa teratas, 5 kelas teraktif, dan daftar transaksi penjualan terakhir.
      - Akses Cepat (Quick Actions) untuk fungsi esensial seperti Setoran, Penjualan, dan Transaksi Kas.

  - **Manajemen Data Master Terpusat:**

      - CRUD penuh untuk **Jenis Sampah**, dengan sistem satuan (pcs/kg) dan harga beli/jual.
      - CRUD penuh untuk **Kelas**.
      - CRUD penuh untuk **Siswa**, lengkap dengan informasi saldo dan poin.

  - **Manajemen Keuangan (Buku Kas):**

      - Pencatatan seluruh transaksi operasional di luar tabungan siswa (pemasukan dan pengeluaran).
      - Manajemen **Kategori Transaksi** untuk pengelompokan yang rapi.
      - Saldo kas terkelola secara otomatis dan akurat.

  - **Manajemen Transaksi Tabungan & Sampah:**

      - **Setoran Sampah:** Pencatatan per individu dengan perhitungan saldo otomatis dan penambahan poin. Stok sampah juga bertambah secara otomatis.
      - **Penarikan Saldo:** Fitur penarikan untuk individu maupun penarikan massal untuk seluruh siswa dalam satu kelas.
      - **Penjualan Sampah:** Transaksi penjualan sampah ke pengepul yang mengurangi stok secara otomatis dan mencatat pemasukan ke Buku Kas.

  - **Gamifikasi & Keterlibatan Siswa:**

      - **Sistem Poin:** Siswa mendapatkan poin dari setiap setoran sampah.
      - **Manajemen Lencana (Badges):** Admin dapat membuat lencana penghargaan berdasarkan target poin tertentu untuk memotivasi siswa.
      - **Leaderboard:** Halaman khusus untuk menampilkan peringkat siswa dan kelas berdasarkan total setoran, mendorong kompetisi yang sehat.

  - **Laporan Komprehensif:**

      - Halaman laporan terpadu dengan sistem *tab*.
      - **Laporan Transaksi Siswa:** Menggabungkan histori setoran (kredit) dan penarikan (debit).
      - **Laporan Penjualan:** Rincian semua transaksi penjualan sampah.
      - **Laporan Buku Kas:** Laporan keuangan operasional.
      - **Laporan Laba Rugi:** Perhitungan laba bersih yang akurat dari data Buku Kas.
      - Semua laporan dapat difilter berdasarkan rentang tanggal dan diekspor ke format `.xlsx` dan `.pdf`.

  - **Utilitas Impor & Ekspor:**

      - Impor data **Siswa** dan **Setoran** secara massal dari file Excel. Proses berjalan di latar belakang (*queue*) untuk menangani data besar tanpa hambatan.
      - Unduh template Excel untuk memudahkan proses impor.

  - **Pengaturan Website:** Halaman khusus untuk mengubah **Judul Website** dan **Favicon** secara dinamis.

### Fitur untuk Siswa

  - **Dashboard Pribadi:** Menampilkan total saldo, total poin, dan daftar lencana yang telah diraih.
  - **Buku Tabungan Digital:** Halaman khusus untuk melihat seluruh riwayat transaksi (setoran dan penarikan) secara mendetail.
  - **Manajemen Profil:** Siswa dapat mengelola informasi profil dan mengganti password mereka.

## Teknologi yang Digunakan

  - **Backend:** Laravel 12, PHP 8.2
  - **Frontend:** Blade, Tailwind CSS, Alpine.js, Chart.js
  - **Database:** MySQL
  - **Paket Tambahan:** Maatwebsite/Excel (untuk impor/ekspor), Pest (untuk testing), DomPDF (untuk ekspor PDF).

## Panduan Instalasi

1.  **Clone repositori ini:**

    ```bash
    git clone https://github.com/wrhasyim/banksampah_sekolah.git
    cd banksampah_sekolah
    ```

2.  **Install dependency Composer dan NPM:**

    ```bash
    composer install
    npm install
    ```

3.  **Salin dan konfigurasi file `.env`:**

    ```bash
    cp .env.example .env
    php artisan key:generate
    ```

      - Setelah itu, atur koneksi database Anda (DB\_DATABASE, DB\_USERNAME, DB\_PASSWORD).
      - Pastikan `QUEUE_CONNECTION=database` untuk fitur impor.

4.  **Jalankan migrasi dan seeder database:**
    Perintah ini akan membuat semua tabel dan mengisi data awal (akun admin, kelas, jenis sampah, lencana, dll).

    ```bash
    php artisan migrate --seed
    ```

5.  **Jalankan server dan "pekerja":**
    Buka **tiga** terminal terpisah di folder proyek:

      - Terminal 1 (Server Web): `php artisan serve`
      - Terminal 2 (Vite): `npm run dev`
      - Terminal 3 (Queue Worker): `php artisan queue:work`

    Aplikasi sekarang berjalan di `http://127.0.0.1:8000`.

## Akun Default

Setelah menjalankan *seeder*, Anda bisa login sebagai admin menggunakan:

  - **Username:** `admin`
  - **Password:** `password`
