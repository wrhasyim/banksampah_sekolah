# Bank Sampah Sekolah Digital ♻️

<p align="center">
  <img src="https://img.shields.io/badge/Laravel-12.x-FF2D20?style=for-the-badge&logo=laravel" alt="Laravel 12">
  <img src="https://img.shields.io/badge/PHP-8.2%2B-777BB4?style=for-the-badge&logo=php" alt="PHP 8.2+">
  <img src="https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge" alt="License MIT">
</p>

Selamat datang di Proyek **Bank Sampah Sekolah Digital**! Aplikasi web ini dirancang untuk memodernisasi dan menyederhanakan pengelolaan bank sampah di lingkungan sekolah. Tujuannya adalah untuk mendorong kesadaran lingkungan, mengajarkan siswa tentang nilai ekonomi dari sampah, serta memberikan sistem administrasi yang efisien dan transparan bagi pengelola.

Aplikasi ini dibangun menggunakan **Laravel 12** dan **Tailwind CSS**, menghasilkan sistem yang modern, responsif, dan mudah digunakan.

> [!NOTE]
> Proyek ini adalah contoh implementasi sistem informasi manajemen yang dapat diadaptasi untuk berbagai kebutuhan di lingkungan pendidikan atau komunitas.

---

## 🌟 Fitur Utama

Aplikasi ini dilengkapi dengan berbagai fitur canggih untuk melayani kebutuhan tiga peran pengguna utama: **Admin**, **Wali Kelas**, dan **Siswa**.

### Fitur untuk Admin (Pengelola)
* **Dashboard Analitik**: Tampilan ringkasan data penting seperti total saldo siswa, total sampah terkumpul, jumlah transaksi, dan grafik tren setoran serta penarikan.
* **Manajemen Data Master**:
    * **Pengguna**: Mengelola akun untuk Admin, Siswa, dan Guru/Wali Kelas.
    * **Siswa**: Manajemen data siswa komprehensif dengan fitur:
        * CRUD data siswa lengkap.
        * Impor massal dari file Excel.
        * **[BARU] Filter Siswa Tidak Aktif**: Memantau partisipasi siswa dengan filter (tidak setor > 1 minggu, 1 bulan, 2 bulan).
        * **[BARU] Ekspor Laporan**: Mengekspor data siswa yang sudah difilter ke format PDF dan XLSX.
    * **Kelas**: Mengelola daftar kelas dan menetapkan wali kelas.
    * **Jenis Sampah**: Mengatur jenis sampah yang diterima, lengkap dengan harga dan status aktif/nonaktif.
* **Manajemen Transaksi**:
    * **Setoran Sampah**: Fitur input setoran per-individu,
    * **Setoran Massal** per-kelas, dan
    * **Edit Massal** untuk koreksi data yang efisien.
    * **Penarikan Saldo**: Mengelola permintaan penarikan tabungan oleh siswa, baik individu maupun per kelas.
    * **Penjualan Sampah**: Mencatat hasil penjualan sampah yang terkumpul ke pengepul.
* **Manajemen Keuangan**:
    * **Buku Kas Digital**: Mencatat semua pemasukan dan pengeluaran bank sampah secara terperinci.
    * **Insentif Wali Kelas**: Sistem otomatis untuk menghitung, membayar, dan merekapitulasi insentif bagi wali kelas.
* **Laporan Lengkap**:
    * Cetak dan ekspor (PDF/Excel) laporan transaksi, laporan penjualan, dan laporan laba rugi.
* **Pengaturan Aplikasi**: Mengonfigurasi parameter sistem seperti persentase insentif, nama sekolah, dan lainnya.

### Fitur untuk Siswa & Wali Kelas
* **Dashboard Personal**: Melihat saldo tabungan, total poin, dan riwayat transaksi terakhir.
* **Buku Tabungan Digital**: Melihat rincian riwayat setoran dan penarikan pribadi.
* **Leaderboard & Gamifikasi**: Tampilan peringkat siswa berdasarkan poin dan lencana yang terkumpul untuk mendorong partisipasi aktif.
* **Profil**: Mengelola informasi akun pribadi.

---

## 🚀 Perkembangan Terbaru (Oktober 2025)

Untuk meningkatkan skalabilitas dan responsivitas aplikasi, serangkaian optimasi performa dan penambahan fitur telah diimplementasikan.

### 1. Optimasi Performa
-   **Implementasi Eager Loading**: Mengatasi masalah **N+1 Query** di seluruh modul utama, termasuk Laporan, Rekapan, dan halaman daftar (indeks) lainnya. Ini secara drastis mengurangi jumlah *query* ke *database*.
-   **Penerapan Caching**:
    -   **Dashboard**: Seluruh data analitik di *dashboard* admin (statistik, grafik, aktivitas terakhir) kini disimpan dalam *cache* untuk mengurangi beban *database* pada halaman yang paling sering diakses.
    -   **Laporan & Rekapan**: Semua halaman laporan dan rekapan kini menggunakan *cache* dinamis yang sensitif terhadap filter. Ini membuat pembuatan laporan yang sama berulang kali menjadi instan.
    -   **Data Master**: Halaman daftar data yang jarang berubah (seperti daftar siswa, kelas, dan pengguna) juga di-*cache* untuk mempercepat waktu muat.

### 2. Fitur Baru
-   **[BARU] Laporan Siswa Tidak Aktif**: Penambahan fitur filter canggih di modul Siswa untuk melacak siswa yang tidak aktif menyetor (dalam 1 minggu, 1 bulan, 2 bulan) dan kemampuan untuk mengekspor hasil filter tersebut ke PDF/XLSX.
-   **README.md Lengkap**: Pembuatan file dokumentasi `README.md` yang komprehensif, mencakup deskripsi fitur, alur kerja, panduan instalasi, dan struktur teknologi untuk memudahkan developer baru bergabung dalam proyek.
-   **Symbolic Link untuk Storage**: Penambahan instruksi `php artisan storage:link` pada panduan instalasi untuk memastikan file yang di-upload dapat diakses secara publik oleh browser.

Perubahan ini memastikan aplikasi tidak hanya kaya fitur, tetapi juga cepat, efisien, dan siap untuk menangani volume data yang lebih besar di masa depan.

---

## 🛠️ Teknologi yang Digunakan

Proyek ini dibangun dengan tumpukan teknologi modern dan populer:

* **Backend**: PHP 8.2, Laravel 12
* **Frontend**: Blade Engine, Tailwind CSS, Alpine.js
* **Database**: MySQL
* **Library Utama**:
    * **Maatwebsite/Excel**: Untuk fungsionalitas impor dan ekspor data Excel.
    * **Barryvdh/DomPDF**: Untuk generate laporan dalam format PDF.
    * **Chart.js**: Untuk menampilkan grafik yang interaktif di dashboard.

---

## 🚀 Panduan Instalasi

Ikuti langkah-langkah di bawah ini untuk menjalankan proyek ini di lingkungan lokal Anda.

### Prasyarat
* PHP >= 8.2
* Composer
* Node.js & NPM
* Database Server (contoh: MySQL, MariaDB)

### Langkah-langkah Instalasi
1.  **Clone repository ini:**
    ```bash
    git clone [https://github.com/wrhasyim/banksampah_sekolah.git](https://github.com/wrhasyim/banksampah_sekolah.git)
    cd banksampah_sekolah
    ```

2.  **Install dependensi PHP (Composer):**
    ```bash
    composer install
    ```

3.  **Install dependensi JavaScript (NPM):**
    ```bash
    npm install
    ```

4.  **Salin dan konfigurasi file environment:**
    ```bash
    cp .env.example .env
    ```
    Buka file `.env` dan sesuaikan konfigurasi database Anda (`DB_DATABASE`, `DB_USERNAME`, `DB_PASSWORD`).

5.  **Generate application key:**
    ```bash
    php artisan key:generate
    ```

6.  **Jalankan migrasi dan seeder database:**
    > [!IMPORTANT]
    > Perintah ini akan membuat semua tabel yang dibutuhkan dan mengisinya dengan data awal (termasuk akun admin default, role, dan pengaturan dasar).
    ```bash
    php artisan migrate --seed
    ```

7.  **Buat Symbolic Link untuk Storage**
    ```bash
    php artisan storage:link
    ```

8.  **Jalankan build asset frontend:**
    ```bash
    npm run dev
    ```

9.  **Jalankan server pengembangan:**
    ```bash
    php artisan serve
    ```

Aplikasi sekarang akan berjalan di `http://127.0.0.1:8000`.

### Akun Default
Setelah menjalankan seeder, Anda dapat login menggunakan akun berikut:
* **Role**: Admin
* **Username**: `admin`
* **Password**: `password`

---

## 🤝 Kontribusi

Kontribusi untuk pengembangan proyek ini sangat diterima. Jika Anda memiliki ide untuk fitur baru atau perbaikan, silakan buat *fork* dari repositori ini dan ajukan *Pull Request*.

1.  Fork proyek ini.
2.  Buat branch fitur baru (`git checkout -b fitur/FiturBaru`).
3.  Commit perubahan Anda (`git commit -m 'Menambahkan FiturBaru'`).
4.  Push ke branch tersebut (`git push origin fitur/FiturBaru`).
5.  Buka Pull Request.

---

## 📄 Lisensi

Proyek ini dilisensikan di bawah **Lisensi MIT**.

---

## 👤 Kontak

**Wahyu Rusdiansyah**
* GitHub: `https://github.com/wrhasyim`

Dibuat dengan ❤️ untuk pendidikan dan lingkungan yang lebih baik.
