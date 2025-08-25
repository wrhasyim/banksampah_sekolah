# Aplikasi Bank Sampah Sekolah

Aplikasi web modern berbasis **Laravel 12** untuk mengelola operasional bank sampah di lingkungan sekolah secara efisien, transparan, dan interaktif.

## Deskripsi Proyek

Proyek ini dibangun sebagai solusi digital lengkap untuk memfasilitasi program bank sampah di sekolah. Aplikasi ini mendorong partisipasi siswa dalam memilah sampah, memberikan kemudahan bagi admin untuk mengelola seluruh alur transaksi, dan menyajikan data informatif melalui dashboard interaktif.

## Fitur Utama

Aplikasi ini memiliki dua peran pengguna utama: **Admin** dan **Siswa**, dengan fungsionalitas yang disesuaikan untuk masing-masing peran.

### Fitur untuk Admin
- **Dashboard Analitis:**
    - Menampilkan ringkasan data kunci: Total Siswa, Total Saldo Siswa, Total Setoran Hari Ini, dan Total Penjualan.
    - Grafik tren setoran dinamis yang dapat difilter berdasarkan jangka waktu (7 hari, 30 hari, bulan ini) dan tipe data (nominal Rupiah atau jumlah sampah).
    - Peringkat 5 besar siswa dan kelas teraktif untuk mendorong partisipasi.
    - Daftar 5 transaksi penjualan terakhir.
- **Manajemen Data Terpusat (Kelola Bank Sampah):**
    - CRUD penuh untuk **Jenis Sampah**, dengan sistem satuan yang fleksibel (pcs atau kg).
    - CRUD penuh untuk **Kelas**.
    - CRUD penuh untuk **Siswa**, lengkap dengan informasi saldo.
- **Manajemen Stok Otomatis:**
    - Stok sampah bertambah secara otomatis saat ada setoran.
    - Stok sampah berkurang secara otomatis saat ada penjualan ke pengepul.
- **Manajemen Transaksi Lengkap:**
    - Pencatatan **Setoran Sampah** per individu dengan dropdown siswa dinamis berdasarkan kelas.
    - Pencatatan **Penarikan Saldo** per individu.
    - Pencatatan **Penarikan Seluruh Saldo** untuk satu kelas sekaligus.
    - Pencatatan **Penjualan Sampah** ke pengepul dengan input jumlah (pcs/kg) dan harga jual kustom.
- **Laporan Terpusat:**
    - Halaman laporan terpadu dengan sistem *tab*.
    - **Laporan Transaksi Siswa:** Menggabungkan histori setoran (kredit) dan penarikan (debit) dalam satu tampilan.
    - **Laporan Penjualan:** Menampilkan semua transaksi penjualan ke pengepul.
    - **Laporan Laba Rugi:** Menghitung laba bersih (`Total Penjualan - Total Penarikan`).
    - Semua laporan dapat difilter berdasarkan rentang tanggal.
- **Impor & Ekspor Data:**
    - Impor data **Siswa** dan **Setoran** secara massal dari file Excel, dengan proses yang berjalan di latar belakang (*queue*) untuk menangani data besar.
    - Ekspor data laporan ke format `.xlsx`.
- **Pengaturan Website:** Halaman khusus untuk mengubah **Judul Website** dan **Favicon** secara dinamis.

### Fitur untuk Siswa
- **Dashboard Pribadi:** Menampilkan total saldo tabungan saat ini dan 5 transaksi terakhir (setoran maupun penarikan).
- **Buku Tabungan Digital:** Halaman khusus untuk melihat **seluruh riwayat transaksi** secara mendetail dan terurut.
- **Manajemen Profil:** Siswa dapat mengelola informasi profil (nama, username) dan mengganti password mereka.

## Teknologi yang Digunakan
- **Backend:** Laravel 12, PHP 8.2
- **Frontend:** Blade, Tailwind CSS, Alpine.js, Chart.js
- **Database:** MySQL
- **Paket Tambahan:** Maatwebsite/Excel, Pest (untuk testing)

## Panduan Instalasi

1.  **Clone repositori ini:**
    ```bash
    git clone [https://github.com/wrhasyim/banksampah_sekolah.git](https://github.com/wrhasyim/banksampah_sekolah.git)
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
    - Setelah itu, atur koneksi database Anda (DB_DATABASE, DB_USERNAME, DB_PASSWORD).
    - Pastikan juga `QUEUE_CONNECTION=database` untuk fitur impor.

4.  **Jalankan migrasi dan seeder database:**
    Perintah ini akan membuat semua tabel dan mengisi data awal (akun admin, kelas, jenis sampah).
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
