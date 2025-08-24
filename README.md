# Aplikasi Bank Sampah Sekolah

Aplikasi web modern berbasis Laravel untuk mengelola operasional bank sampah di lingkungan sekolah secara efisien dan transparan.

## Deskripsi Proyek

Proyek ini dibangun sebagai solusi digital untuk memfasilitasi program bank sampah, mendorong partisipasi siswa dalam memilah sampah, dan memberikan kemudahan bagi admin untuk mengelola seluruh alur transaksi, mulai dari setoran, manajemen stok, hingga penjualan sampah ke pengepul.

## Fitur Utama

Aplikasi ini memiliki dua peran pengguna utama: **Admin** dan **Siswa**.

### Fitur untuk Admin
- **Dashboard Interaktif:** Menampilkan ringkasan data penting seperti total siswa, total saldo terkumpul, total penjualan, grafik tren setoran (dengan filter), serta peringkat siswa dan kelas teraktif.
- **Manajemen Data Master:** CRUD (Create, Read, Update, Delete) penuh untuk data **Jenis Sampah**, **Kelas**, dan **Siswa**.
- **Manajemen Stok:** Stok sampah (dalam pcs) bertambah secara otomatis saat ada setoran dan berkurang saat ada penjualan.
- **Manajemen Transaksi:**
    - Pencatatan **Setoran Sampah** per individu.
    - Pencatatan **Penarikan Saldo** per individu.
    - Pencatatan **Penarikan Seluruh Saldo** untuk satu kelas sekaligus.
    - Pencatatan **Penjualan Sampah** ke pengepul dengan harga jual kustom.
- **Laporan Terpusat:** Halaman laporan gabungan untuk melihat riwayat **Transaksi Siswa (Setoran & Penarikan)** dan **Penjualan**, dengan fitur filter berdasarkan tanggal dan kelas.
- **Ekspor ke Excel:** Semua laporan dapat diekspor ke format `.xlsx`.
- **Impor Data Massal:** Kemampuan untuk mengimpor data **Siswa** dan **Setoran** secara massal dari file Excel.

### Fitur untuk Siswa
- **Dashboard Pribadi:** Menampilkan total saldo tabungan saat ini dan 5 transaksi terakhir (setoran maupun penarikan).
- **Buku Tabungan Digital:** Halaman khusus untuk melihat **seluruh riwayat transaksi** secara mendetail dan terurut.
- **Manajemen Profil:** Siswa dapat mengelola informasi profil dan mengganti password mereka.

## Teknologi yang Digunakan
- **Backend:** Laravel 11, PHP 8.2
- **Frontend:** Blade, Tailwind CSS, Alpine.js, Chart.js
- **Database:** MySQL
- **Paket Tambahan:** Maatwebsite/Excel untuk fungsionalitas impor/ekspor.

## Panduan Instalasi

1.  **Clone repositori ini:**
    ```bash
    git clone [https://github.com/wrhasyim/banksampah_sekolah.git](https://github.com/wrhasyim/banksampah_sekolah.git)
    cd banksampah_sekolah
    ```
2.  **Install dependency Composer:**
    ```bash
    composer install
    ```
3.  **Install dependency NPM:**
    ```bash
    npm install && npm run dev
    ```
4.  **Salin file `.env`:**
    ```bash
    cp .env.example .env
    ```
5.  **Generate application key:**
    ```bash
    php artisan key:generate
    ```
6.  **Konfigurasi database Anda di file `.env`**.
7.  **Jalankan migrasi dan seeder database:**
    Perintah ini akan membuat semua tabel dan mengisi data awal (akun admin, kelas, jenis sampah).
    ```bash
    php artisan migrate --seed
    ```
8.  **Jalankan server pengembangan:**
    ```bash
    php artisan serve
    ```
    Aplikasi sekarang berjalan di `http://127.0.0.1:8000`.

## Akun Default
Setelah menjalankan *seeder*, Anda bisa login sebagai admin menggunakan:
- **Username:** `admin`
- **Password:** `password`
