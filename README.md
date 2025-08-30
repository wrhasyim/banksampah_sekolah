#  Aplikasi Manajemen Bank Sampah Sekolah 🏫♻️

Aplikasi Manajemen Bank Sampah Sekolah adalah sebuah platform digital berbasis web yang dibangun menggunakan **Laravel 12** untuk mengelola seluruh alur kerja program bank sampah di lingkungan sekolah. Aplikasi ini bertujuan untuk mendidik siswa tentang pentingnya pengelolaan sampah, menumbuhkan kebiasaan menabung, sekaligus memberikan kemudahan bagi pengelola dalam administrasi dan pelaporan.

## ✨ Fitur Utama

Aplikasi ini dilengkapi dengan berbagai fitur canggih untuk mendukung operasional bank sampah secara efisien dan transparan.

#### 📊 Dashboard & Analitik
- **Dashboard Admin Interaktif:** Menampilkan statistik kunci seperti total kas, total stok sampah, jumlah siswa, serta grafik transaksi dinamis dengan filter rentang waktu (harian, mingguan, bulanan).
- **Dashboard Sederhana untuk Siswa:** Memungkinkan siswa untuk melihat saldo tabungan mereka.
- **Papan Peringkat (Leaderboard):** Menampilkan peringkat siswa dan kelas berdasarkan jumlah setoran terbanyak untuk meningkatkan motivasi.

#### 🗂️ Manajemen Data (Master Data)
- **Manajemen Pengguna:** CRUD (Create, Read, Update, Delete) untuk pengguna dengan role **Admin** dan **Wali Kelas**, menggunakan *username* sebagai identitas unik.
- **Manajemen Siswa:** CRUD untuk data siswa, termasuk fitur **Impor Siswa dari file Excel** untuk pendaftaran massal.
- **Manajemen Kelas:** CRUD untuk data kelas dengan fungsionalitas untuk **menugaskan satu wali kelas ke satu kelas**, di mana wali kelas yang sudah ditugaskan tidak akan muncul di pilihan.
- **Manajemen Jenis Sampah:** Mengelola daftar jenis sampah yang diterima beserta harganya.

#### 💸 Transaksi Keuangan
- **Setoran Sampah:** Mencatat setoran sampah dari siswa, dengan saldo otomatis masuk ke tabungan siswa.
- **Penarikan Saldo:** Memfasilitasi penarikan saldo baik secara **individu per siswa** maupun **kolektif per kelas**.
- **Penjualan ke Pengepul:** Mencatat transaksi penjualan akumulasi sampah ke pengepul.
- **Buku Kas Umum:** Semua transaksi (pemasukan & pengeluaran) tercatat secara otomatis di buku kas dengan paginasi dan urutan data terbaru.

#### 💰 Sistem Insentif Otomatis
- **Pengaturan Persentase:** Admin dapat mengatur persentase pembagian insentif untuk **pengelola**, **sekolah**, dan **wali kelas** melalui halaman Pengaturan.
- **Distribusi Proporsional:** Insentif untuk wali kelas dibagikan secara otomatis dan **proporsional** berdasarkan total nilai setoran dari masing-masing kelas pada setiap transaksi penjualan.
- **Riwayat & Rekap Insentif:** Terdapat halaman khusus untuk melihat riwayat insentif yang diterima oleh setiap wali kelas, serta rekapitulasi total insentif untuk pengelola dan sekolah dengan filter tanggal.

#### 📄 Pelaporan & Ekspor
- **Laporan Dinamis:** Halaman laporan terintegrasi dengan filter **rentang waktu kustom** untuk semua modul (Laba Rugi, Transaksi Siswa, Penjualan).
- **Cetak Nota per Kelas:** Fitur untuk mencetak nota (rekapitulasi setoran) per kelas berdasarkan rentang tanggal kustom, lengkap dengan rincian per jenis sampah dan total insentif untuk wali kelas.
- **Ekspor Data:** Semua laporan utama dapat diekspor ke format **PDF** dan **Excel**.

## 🛠️ Teknologi yang Digunakan

- **Framework:** Laravel 12
- **Bahasa:** PHP 8.2
- **Database:** MySQL
- **Frontend:** Tailwind CSS, Alpine.js
- **Lainnya:** Chart.js, Laravel DOMPDF, Maatwebsite/Excel

## 🚀 Instalasi & Setup Lokal

1.  **Clone repository ini:**
    ```bash
    git clone [URL_REPOSITORY_ANDA]
    cd [NAMA_FOLDER_PROYEK]
    ```

2.  **Install dependensi Composer:**
    ```bash
    composer install
    ```

3.  **Salin file environment:**
    ```bash
    copy .env.example .env
    ```

4.  **Generate application key:**
    ```bash
    php artisan key:generate
    ```

5.  **Konfigurasi database Anda di file `.env`:**
    ```env
    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=db_banksampah
    DB_USERNAME=root
    DB_PASSWORD=
    ```

6.  **Jalankan migrasi dan seeder database:**
    Perintah ini akan membuat semua tabel dan mengisi data awal yang diperlukan (seperti akun admin default).
    ```bash
    php artisan migrate --seed
    ```
    - **Akun Admin Default:** `username: admin`, `password: password`

7.  **Install dependensi NPM dan build assets:**
    ```bash
    npm install
    npm run dev
    ```

8.  **Jalankan server development:**
    ```bash
    php artisan serve
    ```

Aplikasi sekarang akan berjalan di `http://127.0.0.1:8000`.

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
