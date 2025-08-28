-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 28, 2025 at 11:14 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_banksampah`
--

-- --------------------------------------------------------

--
-- Table structure for table `badges`
--

CREATE TABLE `badges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `min_points` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `badge_siswa`
--

CREATE TABLE `badge_siswa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `siswa_id` bigint(20) UNSIGNED NOT NULL,
  `badge_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `buku_kas`
--

CREATE TABLE `buku_kas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` date NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `tipe` enum('pemasukan','pengeluaran') NOT NULL,
  `jumlah` decimal(10,2) NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id_kategori` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-admin@gmail.com|127.0.0.1', 'i:1;', 1756372143),
('laravel-cache-admin@gmail.com|127.0.0.1:timer', 'i:1756372143;', 1756372143);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_penjualan` bigint(20) UNSIGNED NOT NULL,
  `id_jenis_sampah` bigint(20) UNSIGNED NOT NULL,
  `jumlah` int(11) NOT NULL,
  `subtotal_harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_sampah`
--

CREATE TABLE `jenis_sampah` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_sampah` varchar(50) NOT NULL,
  `satuan` varchar(255) NOT NULL DEFAULT 'pcs',
  `harga_per_satuan` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_sampah`
--

INSERT INTO `jenis_sampah` (`id`, `nama_sampah`, `satuan`, `harga_per_satuan`, `stok`, `created_at`, `updated_at`) VALUES
(1, 'Botol Plastik', 'pcs', 35.00, 0, NULL, NULL),
(2, 'Gelas Plastik', 'pcs', 20.00, 0, NULL, NULL),
(3, 'Kardus', 'kg', 2000.00, 0, NULL, '2025-08-28 02:13:35');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategori_transaksi`
--

CREATE TABLE `kategori_transaksi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kategori` varchar(255) NOT NULL,
  `tipe` enum('pemasukan','pengeluaran') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori_transaksi`
--

INSERT INTO `kategori_transaksi` (`id`, `nama_kategori`, `tipe`, `created_at`, `updated_at`) VALUES
(1, 'Transportasi', 'pengeluaran', '2025-08-28 02:13:53', '2025-08-28 02:13:53'),
(2, 'Operasional', 'pengeluaran', '2025-08-28 02:13:57', '2025-08-28 02:13:57'),
(3, 'Hasil Penjualan', 'pemasukan', '2025-08-28 02:14:01', '2025-08-28 02:14:01'),
(4, 'Saldo Awal', 'pemasukan', '2025-08-28 02:14:06', '2025-08-28 02:14:06');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kelas` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `nama_kelas`, `created_at`, `updated_at`) VALUES
(1, 'Guru', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(2, 'X MPLB 1', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(3, 'X MPLB 2', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(4, 'X TM 1', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(5, 'X TM 2', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(6, 'X TM 3', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(7, 'X TM 4', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(8, 'X TM 5', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(9, 'X TM 6', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(10, 'XI MPLB 1', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(11, 'XI MPLB 2', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(12, 'XI TM 1', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(13, 'XI TM 2', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(14, 'XI TM 3', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(15, 'XI TM 4', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(16, 'XI TM 5', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(17, 'XI TM 6', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(18, 'XI TM 7', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(19, 'XII MPLB 1', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(20, 'XII MPLB 2', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(21, 'XII TM 1', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(22, 'XII TM 2', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(23, 'XII TM 3', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(24, 'XII TM 4', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(25, 'XII TM 5', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(26, 'XII TM 6', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(27, 'XII TM 7', '2025-08-28 02:07:56', '2025-08-28 02:07:56');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_08_23_090825_create_kelas_table', 1),
(2, '2025_08_23_091448_create_sessions_table', 1),
(3, '2025_08_23_092449_create_jenis_sampah_table', 1),
(4, '2025_08_23_092451_create_pengguna_table', 1),
(5, '2025_08_23_092452_create_siswa_table', 1),
(6, '2025_08_23_092454_create_setoran_table', 1),
(7, '2025_08_23_092455_create_penarikan_table', 1),
(8, '2025_08_23_103533_create_personal_access_tokens_table', 1),
(9, '2025_08_23_125708_create_cache_table', 1),
(10, '2025_08_24_181005_create_penjualan_tables', 1),
(11, '2025_08_24_193128_modify_penarikan_table_for_class_withdrawal', 1),
(12, '2025_08_25_040516_create_jobs_table', 1),
(13, '2025_08_25_050048_create_settings_table', 1),
(14, '2025_08_25_232512_create_buku_kas_table', 1),
(15, '2025_08_26_055331_add_deleted_at_to_buku_kas_table', 1),
(16, '2025_08_26_055732_create_kategori_transaksi_table', 1),
(17, '2025_08_26_074727_add_points_to_siswa_table', 1),
(18, '2025_08_26_074753_create_badges_table', 1),
(19, '2025_08_26_074848_create_badge_siswa_table', 1),
(20, '2025_08_27_100132_rename_total_in_penjualan_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `penarikan`
--

CREATE TABLE `penarikan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `siswa_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tanggal_penarikan` date NOT NULL,
  `jumlah_penarikan` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_kelas` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','siswa') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'admin', '$2y$12$N6FdEOPE.incDYDKYP2HLeBLvxoKUZUfwbV14rtlGoMa584Rw81vu', 'admin', '2025-08-28 02:07:56', '2025-08-28 02:07:56'),
(2, 'ADILAH', '252610001', '$2y$12$8ceAdKtSqCuoa7u4mH2nH.NLtQbzjehKjpgaWT2Xuq2V2B0LHVFYm', 'siswa', '2025-08-28 02:08:17', '2025-08-28 02:08:17'),
(3, 'ADINDA OKTAVIANA', '252610002', '$2y$12$gxlMDjS4k0fNXt6aE8Ne3e8Krfel8c.eWKLwe4.xOitjXY6urE7we', 'siswa', '2025-08-28 02:08:17', '2025-08-28 02:08:17'),
(4, 'ATIK CANTIKA', '252610003', '$2y$12$oIFQrC78rj/9aEyZkM2C.e8TCAH5nt/GzBduMA/bZuMsa.E1G4ReC', 'siswa', '2025-08-28 02:08:17', '2025-08-28 02:08:17'),
(5, 'AYU FADILLAH', '252610004', '$2y$12$o29BkPgVeA3LVgxKD9RmO.6KaJpyWTZe/9j1bkkcVvwTZJZtbZ6CS', 'siswa', '2025-08-28 02:08:18', '2025-08-28 02:08:18'),
(6, 'BINTANG SAMUDRA SATYABUDIE', '252610005', '$2y$12$YWyGBiBMx0E/znrUncaAmuqa7Boqe1olXmJ8JT2IEfuNos55yKvr2', 'siswa', '2025-08-28 02:08:18', '2025-08-28 02:08:18'),
(7, 'DESFA NAILATUL NAFISA', '252610006', '$2y$12$QzlMCKkVk/X7N9CqLy2pZ.t8xDKr8oYWFK193LPDdz48PTT6S08y.', 'siswa', '2025-08-28 02:08:18', '2025-08-28 02:08:18'),
(8, 'DONI RAMADHANI', '252610007', '$2y$12$7aPtvGrLZiHOwhzrF34hr.R.IMIu7O3ISQUFpVyHI.qkmb4TPZW76', 'siswa', '2025-08-28 02:08:18', '2025-08-28 02:08:18'),
(9, 'FITRIA ZAHRATUNNAJA', '252610008', '$2y$12$nu0mvSHvNgtSHVhw8qfrIeJ9TWSxtaF4QNUKXEiMueyGcx9mfI6li', 'siswa', '2025-08-28 02:08:19', '2025-08-28 02:08:19'),
(10, 'INDAH AFIFA', '252610009', '$2y$12$4aRYrwgqGFhEKkHYkE1C3.oyMRNYGTLbEiERYethfgc.QVCcjanJW', 'siswa', '2025-08-28 02:08:19', '2025-08-28 02:08:19'),
(11, 'INDAH LISNAWATI', '252610010', '$2y$12$2rmg9p9upVjW.lnmBYQ4VOk2mEbUz/cquh4kAdvu9cbYr0DgXDJWm', 'siswa', '2025-08-28 02:08:19', '2025-08-28 02:08:19'),
(12, 'INDRI PUSPITASARI', '252610011', '$2y$12$BrkmWIF0BEsOhqzcOsFXsOaiXOEWeKnXfqqzDDuefJ5gljKjh3rh2', 'siswa', '2025-08-28 02:08:19', '2025-08-28 02:08:19'),
(13, 'IQBAL MAULANA', '252610012', '$2y$12$V9hePjgQO7Whj3luuYIk.uOu6ho4MCXur6vteOYZZdXbx.bUMeCH2', 'siswa', '2025-08-28 02:08:20', '2025-08-28 02:08:20'),
(14, 'JIHAN KHOLILAH', '252610013', '$2y$12$W0hCIJoK4W5fWxmeMRYRyeW9COpPr/.ibQKHNzjFTH6W0.y0xvxBS', 'siswa', '2025-08-28 02:08:20', '2025-08-28 02:08:20'),
(15, 'KARLINA', '252610014', '$2y$12$DEFbPFD3uGes5AZxKd/ANeM73kwasyXW6GOJEx8KzfN18B3Q7O5VC', 'siswa', '2025-08-28 02:08:20', '2025-08-28 02:08:20'),
(16, 'KHOLIFAH RIZKA NURSAADAH', '252610015', '$2y$12$S7N3d12zM4qsLnGD1yjxmupu7vwRWV4cNzGtv5wMEE0HINfzsDWVG', 'siswa', '2025-08-28 02:08:21', '2025-08-28 02:08:21'),
(17, 'KOMARIAH', '252610016', '$2y$12$AbfWHSKSBMcifGMxueKnLu/fkXFAfVunjy.X3TQFfbvWRf/AyWUk.', 'siswa', '2025-08-28 02:08:21', '2025-08-28 02:08:21'),
(18, 'NURUL HABIBAH', '252610017', '$2y$12$p6JoXRJEg.QNmK9Ja9HUbePM8gvMM2QDzTNwixeLLuA7aNu/9HHqa', 'siswa', '2025-08-28 02:08:21', '2025-08-28 02:08:21'),
(19, 'RISMA NURMALA', '252610018', '$2y$12$/ReufHloRKyB1nUGpogZtOvCwnE645ocOn.wQqlhXy3/.T/mjy9ea', 'siswa', '2025-08-28 02:08:21', '2025-08-28 02:08:21'),
(20, 'SALWA ANUROH', '252610019', '$2y$12$zRa187w84636hUutukjna.GulGjxPQDB/GBLb9YDvpTuckEfbXlgK', 'siswa', '2025-08-28 02:08:22', '2025-08-28 02:08:22'),
(21, 'SHIPA', '252610020', '$2y$12$eQy72.V0o7h8aIWDqB2Cvu/nJBlfarqsO3REP2jwUJNX7te6Khh0G', 'siswa', '2025-08-28 02:08:22', '2025-08-28 02:08:22'),
(22, 'SHOFIA AISYAH MUSAFAAH', '252610021', '$2y$12$S9zrsApxIP2kAD8I9RdZvuZgNzkRkEzQTLCSjX3GTxh/ijNzFoLE.', 'siswa', '2025-08-28 02:08:22', '2025-08-28 02:08:22'),
(23, 'SITI ALISA', '252610022', '$2y$12$CXqqUtPyF.peV2kMTf4ID.jyod0IhRb.k7F5xNhURQelA65VmfYEO', 'siswa', '2025-08-28 02:08:22', '2025-08-28 02:08:22'),
(24, 'SITI AMINAH', '252610023', '$2y$12$h.J7xeoLB0CEFXrCyyk0M./TLuUwoL7.U9yyhSLXPyAH3jEessQ4i', 'siswa', '2025-08-28 02:08:23', '2025-08-28 02:08:23'),
(25, 'SITI FATIMAH', '252610024', '$2y$12$ErBfp0N2n/qf4WReR0U0auGSlh9yMQlL.iSTrYzI0L2dL6eAWI9OO', 'siswa', '2025-08-28 02:08:23', '2025-08-28 02:08:23'),
(26, 'WARNIH MELINDA', '252610025', '$2y$12$OFa3nxiH1MTbP4p5q60tEOZ9.uqJ//QLzdoJcyGMwWrE0brvu2dX2', 'siswa', '2025-08-28 02:08:23', '2025-08-28 02:08:23'),
(27, 'WINA', '252610026', '$2y$12$GGalvISUBvhkfI9RIwCvuuSAXrwrE/EQTkhCW3nd.pCAlCOnrPcV6', 'siswa', '2025-08-28 02:08:24', '2025-08-28 02:08:24'),
(28, 'ZASKIA PUTRI', '252610027', '$2y$12$oySQuplVtG/I9RWhUu7O1ujGbZzD0hGZNw.UBDObTc4a9kSR9G6D.', 'siswa', '2025-08-28 02:08:24', '2025-08-28 02:08:24'),
(29, 'ALLEEISYA DAVINA KAMANDHANIKA', '252610028', '$2y$12$wHca72g5YJlaUYfYAS48UeFUtg0GRUg8APAPabjzCPJLqnZbMvCEW', 'siswa', '2025-08-28 02:08:24', '2025-08-28 02:08:24'),
(30, 'ALYA HANDAYANI', '252610029', '$2y$12$bEJDztx/TC3/4lIi.E0qm.F0mqjr3HtEKBFajSzHm53gO2qavcqE6', 'siswa', '2025-08-28 02:08:24', '2025-08-28 02:08:24'),
(31, 'ANI SUHAENI', '252610030', '$2y$12$y74HxwedQYiRjLlAlqKG7eBHtUSNkJD5wztjutWVng6DgEKb5kvze', 'siswa', '2025-08-28 02:08:25', '2025-08-28 02:08:25'),
(32, 'ANITA', '252610031', '$2y$12$A79ckyP1b00CCx5gjBphtezkfKQKuB.43wtnvLqpBwNgX2EsYyr86', 'siswa', '2025-08-28 02:08:25', '2025-08-28 02:08:25'),
(33, 'APRILLIA ANATASYA', '252610032', '$2y$12$xl20.rQs.fLfapackutR0Ovo1D62NHvp3CJZL0s4C9.KIZRdTkvw2', 'siswa', '2025-08-28 02:08:25', '2025-08-28 02:08:25'),
(34, 'AULIA ISHAQUE', '252610033', '$2y$12$LVGhrECT1lVGykm3rPUrpeWGbBMWRf3dyzThVapmA5YrcZubqHcbG', 'siswa', '2025-08-28 02:08:25', '2025-08-28 02:08:25'),
(35, 'AVRIL AVPRIDA HARIYANA', '252610034', '$2y$12$ZD3XcInZuafQ3OKuiFU0auGlzXtCFZXliMO5mLqyXu.JfPgWxG0r.', 'siswa', '2025-08-28 02:08:26', '2025-08-28 02:08:26'),
(36, 'CITRA LESTARI ROHIMAH', '252610035', '$2y$12$/x5HUx/DU9CGLtWEar1QleBkvRzqI7r0DLwnejbhyzR3pwBmYN5lm', 'siswa', '2025-08-28 02:08:26', '2025-08-28 02:08:26'),
(37, 'DINA', '252610036', '$2y$12$MM1wcXT9CYUcgbsxaWXqTuvymgnwYMZeCGgaXEtGFN/zRxD2C3goi', 'siswa', '2025-08-28 02:08:26', '2025-08-28 02:08:26'),
(38, 'ENENG JUMARIYAH', '252610037', '$2y$12$QoxlY8Xdgx9eNRVhhLuCd.pgvx0tH6LYsIT2Ss3fQbq0GxdAC0DXq', 'siswa', '2025-08-28 02:08:27', '2025-08-28 02:08:27'),
(39, 'ENGKOM KOMARIAH', '252610038', '$2y$12$aufDMUaJqcdqbb3ltjCSmOGJ4GONzKDli.Oznim2IPRIXCFHy4VUO', 'siswa', '2025-08-28 02:08:27', '2025-08-28 02:08:27'),
(40, 'HENA ALI', '252610039', '$2y$12$/xHyd49yyVYYROF3ppg5weS0uNn0WeZ1e.4w2W6uWDMijEULrPxg2', 'siswa', '2025-08-28 02:08:27', '2025-08-28 02:08:27'),
(41, 'JIHAN ANNASTASYA', '252610040', '$2y$12$YSNL6sDDkwCk/6JIIDFM7epEOOQnoBFsogRhcmlJQRDa39I5DghTC', 'siswa', '2025-08-28 02:08:28', '2025-08-28 02:08:28'),
(42, 'KURNIA HANAPIAH ISWANDI', '252610041', '$2y$12$6UBYGLn1On..uoX4Hk8FgObd.Xuwp/f69HV9cGRIwZm.yyIyJ5noi', 'siswa', '2025-08-28 02:08:28', '2025-08-28 02:08:28'),
(43, 'LATIFAH', '252610042', '$2y$12$dXCoTpfxZCefcK0D5qZq1uZyJddWPY0yv.1y5S2AHKA6pQ4hnQ5wK', 'siswa', '2025-08-28 02:08:28', '2025-08-28 02:08:28'),
(44, 'NASYA MAHARANI', '252610043', '$2y$12$OpJPCxxRQhJ233IebQl6We2NQEFvXIdAeGL30dhgYFe6W2oAlNtNm', 'siswa', '2025-08-28 02:08:28', '2025-08-28 02:08:28'),
(45, 'NUR ALBIAH SALWA', '252610044', '$2y$12$hNUGKGMNqdsP0Sv2/XjPEeWGW2TAZB4EbMD8.L4gfivaZZkKVV8zm', 'siswa', '2025-08-28 02:08:29', '2025-08-28 02:08:29'),
(46, 'NUR SIFA ANGGAENI', '252610045', '$2y$12$PQAYiWdgZHb2v/qozn3r9uTUcRUcvGQN2DhCSchL9O8IS8eRZyJ3O', 'siswa', '2025-08-28 02:08:29', '2025-08-28 02:08:29'),
(47, 'PUTRI SASKIA', '252610046', '$2y$12$DiLXt3lgbq9rW0LwycRDj.p03lzuzXPECXr1d.hbS7zs2wSQbnLDe', 'siswa', '2025-08-28 02:08:29', '2025-08-28 02:08:29'),
(48, 'RAHMA YANTI', '252610047', '$2y$12$eYrOnXfrNP6D0PVjCHw3euF3mqwr0XVRRsvRHJkl9HtXR2pfW.jfa', 'siswa', '2025-08-28 02:08:30', '2025-08-28 02:08:30'),
(49, 'RANI AMELIA', '252610048', '$2y$12$UdOndygr10UTD.WUwgWO9O.enJ2sH0S1CdDhejeH9Q0vlgsRkygHS', 'siswa', '2025-08-28 02:08:30', '2025-08-28 02:08:30'),
(50, 'SAHAR SYAFITRI', '252610049', '$2y$12$OaKsdCRCuFHdXJaYTVNcIOu9r4VNuuxnFJGvRLBjFWYiiclW4rMLC', 'siswa', '2025-08-28 02:08:30', '2025-08-28 02:08:30'),
(51, 'SALSA BILA AZZAHRA', '252610050', '$2y$12$mRXOgMVjH.X/YM7Uqmc1L.wQU94QNx/mIDmJSsR5/ibJ55HgpJH8.', 'siswa', '2025-08-28 02:08:30', '2025-08-28 02:08:30'),
(52, 'SHIFA ADELIA MAWAR', '252610051', '$2y$12$YRzNgdGFgtzQ47MHJnelAeEyst1Q1wDv4vVA4Iwz/ePef9dcGc99a', 'siswa', '2025-08-28 02:08:31', '2025-08-28 02:08:31'),
(53, 'SINTA SUTIA', '252610052', '$2y$12$EJjDgIgAvA14pEurmFWvceiA6djYX/2wJ9jaz7YzHjCCKTwjKSfk6', 'siswa', '2025-08-28 02:08:31', '2025-08-28 02:08:31'),
(54, 'SITI NURZAHRA', '252610053', '$2y$12$BQrheXw2M6a8BgGJiDZ//O69IUrE4EfMnDMEzI83tVe5qw8mlZdO.', 'siswa', '2025-08-28 02:08:31', '2025-08-28 02:08:31'),
(55, 'SITI ROMLAH', '252610054', '$2y$12$eaug1epp7VLTPF.i/UQiu.qttHeNXoisGR0nj6Pt3sPULjb9NlqEu', 'siswa', '2025-08-28 02:08:32', '2025-08-28 02:08:32'),
(56, 'TANIA OKTAVIANI', '252610055', '$2y$12$BHal2.WhL7Ab6sKna1l.YOhVBSWWdNNFoPKCX2HqDWtfKxvlS/66S', 'siswa', '2025-08-28 02:08:32', '2025-08-28 02:08:32'),
(57, 'WINDI ALTIYAH', '252610056', '$2y$12$XDpbsm1IZyzq7Ur5SfjG7uJua8VWP4LIxAx8fW67izVr29Cfx6gMa', 'siswa', '2025-08-28 02:08:32', '2025-08-28 02:08:32'),
(58, 'ABU HAMAD MASKURI', '252610057', '$2y$12$DEQyc82Av5/yGiSSWPw1.OezDl.Xsz45fZyo3AoHHWVRaIRfR2qFi', 'siswa', '2025-08-28 02:08:32', '2025-08-28 02:08:32'),
(59, 'ADE IRWANSYAH', '252610058', '$2y$12$7wk6AKYC90j7oxLooEYtv.T92a3Rtd7cmZLmcRyuqUPZ3yQkCiZ4q', 'siswa', '2025-08-28 02:08:33', '2025-08-28 02:08:33'),
(60, 'ALDO SUTISNA', '252610059', '$2y$12$ZAYPLBOwQQgb2aN9r5WrnuQHJT1LJ7WnqKLkFwRWN.x30iqQp9Hm.', 'siswa', '2025-08-28 02:08:33', '2025-08-28 02:08:33'),
(61, 'ANDIKA PAJAR MAHDI', '252610060', '$2y$12$3mNAd2KHs3adZFWKU7GS1OixUsx7FG3wsTN.b7rtw3aVexo17EhQS', 'siswa', '2025-08-28 02:08:33', '2025-08-28 02:08:33'),
(62, 'ANDINI ANGGRAENI', '252610061', '$2y$12$piZoLJcAh3mkWHYDqNXuQ.7joYqSU3NFRietrGdL86QbSAKV3XEqS', 'siswa', '2025-08-28 02:08:34', '2025-08-28 02:08:34'),
(63, 'BAGAS ARDIWINATA', '252610062', '$2y$12$hfd/9vLWzMDLFGyT4eJpQ.lL4zlCv5LvV3oWwwIwHV0MIpopVoH.m', 'siswa', '2025-08-28 02:08:34', '2025-08-28 02:08:34'),
(64, 'CHIKA SIPA ANGGITA', '252610063', '$2y$12$dZVCdYsxHget1aomaCz36O.RSzkH3OBiFnZPKLegEjTV.ftFM7AGe', 'siswa', '2025-08-28 02:08:34', '2025-08-28 02:08:34'),
(65, 'DANI SETIAWAN', '252610064', '$2y$12$grcCRRPizDG02Or99MmdKen/tkCyOqKyVV3u6q7FcBdADr1eN5yEa', 'siswa', '2025-08-28 02:08:34', '2025-08-28 02:08:34'),
(66, 'DANI SUTISNA', '252610065', '$2y$12$AH2aP0Bjx.tXCPH8yt7WteHUEvPHr/oGBtAGZm4S38XVTx82sHsc.', 'siswa', '2025-08-28 02:08:35', '2025-08-28 02:08:35'),
(67, 'DANIA OKTAVIA', '252610066', '$2y$12$Gj9YTQadmitcjQgh37mou.Zw1QnZlHvGP/MoZX8V1GIFJtwQmNaAa', 'siswa', '2025-08-28 02:08:35', '2025-08-28 02:08:35'),
(68, 'DIMAS AHMAD RAMADAN', '252610067', '$2y$12$1jL5WQkCe/Mgj4cFpp6BV.8rpQvQTGnfbhSYcoDRt0U.PKIlGO/Iq', 'siswa', '2025-08-28 02:08:35', '2025-08-28 02:08:35'),
(69, 'DIRLY ANGGADITA', '252610068', '$2y$12$04gMXnCX.ZPEncz2fELbBexag.P/mm8wmvEfkVwVhc0OByph81qwa', 'siswa', '2025-08-28 02:08:36', '2025-08-28 02:08:36'),
(70, 'EDI SETIA GUNAWAN', '252610069', '$2y$12$Zss9f6Cbor2rUXcZFst/6OKNm1EWf4UzxeBklSd/7wFJKjW/bA12q', 'siswa', '2025-08-28 02:08:36', '2025-08-28 02:08:36'),
(71, 'EKA BAMBANG SAPUTRA', '252610070', '$2y$12$LyFmY73jLk8mLo73HJZ0qeNeHO16HwbU2VlNcwRC/5NbbE6ow/FrS', 'siswa', '2025-08-28 02:08:36', '2025-08-28 02:08:36'),
(72, 'ENDRIK PURNAMA', '252610071', '$2y$12$cscf7H0DL47tnef01UmkPumMynNS2uYwmusCAr7FN0K1zINqlZSdm', 'siswa', '2025-08-28 02:08:37', '2025-08-28 02:08:37'),
(73, 'HERMANSYAH', '252610072', '$2y$12$y.JRS6UC17AFe1prEzhs1e9KnEGdHyR4SMcUTpJcoZTAm1Tl7fmhu', 'siswa', '2025-08-28 02:08:37', '2025-08-28 02:08:37'),
(74, 'HIDAYATULLAH', '252610073', '$2y$12$R.nuv7yg/ZFqohO5Sy1OCeSb29OeRJERsfX7hczlelBGCxmcM3b6O', 'siswa', '2025-08-28 02:08:37', '2025-08-28 02:08:37'),
(75, 'JAEN', '252610074', '$2y$12$Zv/iWrvYDEiGw2RQTPuIZOYSoeYznTGUzgKYg5jm5e6pjTWtzPrYW', 'siswa', '2025-08-28 02:08:38', '2025-08-28 02:08:38'),
(76, 'JULIYANTO', '252610075', '$2y$12$6GZfp6Y/jjmr1m8bV/M3z.bcBGUMQww/VxlWjTLM0XO3bihcec.tq', 'siswa', '2025-08-28 02:08:38', '2025-08-28 02:08:38'),
(77, 'MIFTAHUL ARIFIN', '252610076', '$2y$12$Iv/6dLR299J/zQwuhoscl.pnIVr7cPA82IfNNRu4eHdu5mQ.8rRF2', 'siswa', '2025-08-28 02:08:38', '2025-08-28 02:08:38'),
(78, 'MIT F FELIX GUSNA', '252610077', '$2y$12$vgFr3O8ApQEqv/Ro/UlOJOQeC93wc2rqXLUrYfDylcneBMFYhEi0C', 'siswa', '2025-08-28 02:08:38', '2025-08-28 02:08:38'),
(79, 'MUHAMAD MUHIBIN', '252610078', '$2y$12$3RmbuoofX1OV3.l.dv2SYeKX0Udzo4/3j3GKzy77NGtHv0VAiKg5W', 'siswa', '2025-08-28 02:08:39', '2025-08-28 02:08:39'),
(80, 'MUHAMAD RADITIYA', '252610079', '$2y$12$GZqv7SJQo6MTy7On/Xuri.KYgMfV3ic3TDmUea85ywY15YtYygusC', 'siswa', '2025-08-28 02:08:39', '2025-08-28 02:08:39'),
(81, 'MUHAMAD RIZKI BAEHAKI', '252610080', '$2y$12$pTFsyDrqJiEIZ4yfZw1rrO40frmregzBrJV3wWhtDkjuI2ZsFY3Iu', 'siswa', '2025-08-28 02:08:39', '2025-08-28 02:08:39'),
(82, 'MUHAMAD RIZKY HABIBI', '252610081', '$2y$12$R2I.w3nsLpDAEsiPANwwm.emUsfbAaUeXVA621X2cpgvFvb8oBjHu', 'siswa', '2025-08-28 02:08:39', '2025-08-28 02:08:39'),
(83, 'MUHAMMAD AL ISRA FIRMANSYAH', '252610082', '$2y$12$XLK/x5Kr0LUOM6em8gKxZOuy1lONHJZ0WiZuGPDR5HfrJmxocaSjW', 'siswa', '2025-08-28 02:08:40', '2025-08-28 02:08:40'),
(84, 'MUHAMMAD FARHAN ADI PUTRA', '252610083', '$2y$12$9mEAU7rVmqEfF2usa/BwoenS6RJxNpt8ge6AusCQkXWPJH3y5CeQm', 'siswa', '2025-08-28 02:08:40', '2025-08-28 02:08:40'),
(85, 'RIFALDI JULIANSYAH', '252610084', '$2y$12$neNdXY25Mm5lnOVR162ktOO5PbpVYylYNRlk7j6VS/qLu8fHT1X1m', 'siswa', '2025-08-28 02:08:40', '2025-08-28 02:08:40'),
(86, 'RINDI', '252610085', '$2y$12$MP1gm7boSQ/HTVRRgHPK0e964g/.f9ebNUw.Ho7IybJ27uFvey5JO', 'siswa', '2025-08-28 02:08:41', '2025-08-28 02:08:41'),
(87, 'RISFI HIDAYAT', '252610086', '$2y$12$qYj7kR8OrAz0MSL2Hnjuje6aSUI5KawSG/T0BXl4mNjSGTkX6ip7q', 'siswa', '2025-08-28 02:08:41', '2025-08-28 02:08:41'),
(88, 'TAOPIK HIDAYAH', '252610087', '$2y$12$uacVGNGiIhgi6aiqTq6G..GHFigRSqDRTZ.mZASzBlLYx2JkznOvG', 'siswa', '2025-08-28 02:08:41', '2025-08-28 02:08:41'),
(89, 'WISNU HASLAN FARID', '252610088', '$2y$12$9VUdlKgRF3SeJudAngbTEeKD4mFAmQTtTybf1VihdRKCIy2E2lDzq', 'siswa', '2025-08-28 02:08:41', '2025-08-28 02:08:41'),
(90, 'YOMI ABDUL MANAH', '252610089', '$2y$12$Q3kGlTXzi5FapKhxST6M7uoyni5XGFvVadWdcMamwUxpX5oPzO2FC', 'siswa', '2025-08-28 02:08:42', '2025-08-28 02:08:42'),
(91, 'ZAKI IBNU KHAIRI', '252610090', '$2y$12$sNY7AZkW8p64dXL1QPvLQ.mL2NS6c56f4nbSLKhENNAPO5Eq.enZu', 'siswa', '2025-08-28 02:08:42', '2025-08-28 02:08:42'),
(92, 'ABDUL LATIF', '252610091', '$2y$12$8gvDtVdDnwXi4QCciv8dvuu7GcTi4oeAjV4jXpEoDP0yRgYN4zPcC', 'siswa', '2025-08-28 02:08:42', '2025-08-28 02:08:42'),
(93, 'ADE IRFAN', '252610092', '$2y$12$TWdR7EsKmcVXJzrNSutRNeKyJsQIk5TZRjcleZ8P27dB0S7svKZ52', 'siswa', '2025-08-28 02:08:43', '2025-08-28 02:08:43'),
(94, 'ADE KRISYANTO', '252610093', '$2y$12$kC0guQ8M3nN/OshAzYJZQuSXZQniPgjhw.p5ANvU6sQg3wfemN4ty', 'siswa', '2025-08-28 02:08:43', '2025-08-28 02:08:43'),
(95, 'ADITIA SIMATUPANG', '252610094', '$2y$12$3Tu8FvV292mFLMJ8ENXKlOMtZUsYVqtN9UxoLQtbJtHTQfejDTyzq', 'siswa', '2025-08-28 02:08:43', '2025-08-28 02:08:43'),
(96, 'AHMAD FAUZAN', '252610095', '$2y$12$fay1EqmmQvFjzLTe9njMVevT/sf7biXDtIBXuh7ztkvwxv2qChJ8q', 'siswa', '2025-08-28 02:08:43', '2025-08-28 02:08:43'),
(97, 'AHMAD FAUZI', '252610096', '$2y$12$7Q5JsE.jideWcOepufvjn..HCKBRW3taN78zeVuzy84t6ljN0a37S', 'siswa', '2025-08-28 02:08:44', '2025-08-28 02:08:44'),
(98, 'AKBAR JUNIARDI', '252610097', '$2y$12$S6vmjRzPtsIS.sjuTglbceJUoAs3WtRthAiQ2s/hcdEeGyKGln2fa', 'siswa', '2025-08-28 02:08:44', '2025-08-28 02:08:44'),
(99, 'ALDI', '252610098', '$2y$12$XXvCB2oI6ZcPLvpvHMtTwOx1QxcDB1t3DToo3S6OwKUTTfGicZ/uG', 'siswa', '2025-08-28 02:08:44', '2025-08-28 02:08:44'),
(100, 'BUNGA IRMA REFALIA', '252610099', '$2y$12$iJ/qhThOviEDmR.w2F9Dk.mw9r4CrTONIYajmZWr8UROUZgKNPDpa', 'siswa', '2025-08-28 02:08:44', '2025-08-28 02:08:44'),
(101, 'DENIS', '252610100', '$2y$12$qbGA75lQVQPBxfRYiYHxNuevp75MyNEvT.SFqS/VCYYZ2PUP6kBkq', 'siswa', '2025-08-28 02:08:45', '2025-08-28 02:08:45'),
(102, 'DIDI FIRJATULLOH FADIB', '252610101', '$2y$12$kintoCiJsRzr5HiHSBs7x.BigXDqr5/mcKDq8Vr1W4MYO4mo2evxm', 'siswa', '2025-08-28 02:08:45', '2025-08-28 02:08:45'),
(103, 'DIMAS HAFIDDUDIN', '252610102', '$2y$12$rZLOiiw2Z41qxzuANMriKeB7/mJtSY78bfCMdR4ohbqH5wDmBXA9S', 'siswa', '2025-08-28 02:08:45', '2025-08-28 02:08:45'),
(104, 'DINI AMELIA PUTRI', '252610103', '$2y$12$O5JQ4TepwBP8OC88ciaA7eb7ZBHUGUO3cCWsrztbjPKvUd0WrHmwW', 'siswa', '2025-08-28 02:08:46', '2025-08-28 02:08:46'),
(105, 'ENJELIKA APRIDA', '252610104', '$2y$12$iVdE41zAG0yU1KfosBOZyez1xizOdAeR3DcpcB/HB.JFT.u9ApDu.', 'siswa', '2025-08-28 02:08:46', '2025-08-28 02:08:46'),
(106, 'FAISAL AKBAR', '252610105', '$2y$12$slzi4Pe0XpIJNIFb52NHxeonqmHXuMfv8nwZa99Mv4tvAuDDAHmPK', 'siswa', '2025-08-28 02:08:46', '2025-08-28 02:08:46'),
(107, 'GIAN JANU PANDU SAPUTRA', '252610106', '$2y$12$9CHO324RxDJD1Tc/ID6TNOisdoGTughzWgJM6/OkzP0PwWwLTeblm', 'siswa', '2025-08-28 02:08:46', '2025-08-28 02:08:46'),
(108, 'HAFID JULIANA', '252610107', '$2y$12$F8DRiffaU4O1gL0hOKflJ.dH8N5jsUdL89fEbXzNycwWSDQP/oA4e', 'siswa', '2025-08-28 02:08:47', '2025-08-28 02:08:47'),
(109, 'IQBAL ALBIANSYAH', '252610108', '$2y$12$qtAEblJJanfD3wD1MCOUXu6zSjPVIcZq7c2GplXSF.bgLsiYgVrNi', 'siswa', '2025-08-28 02:08:47', '2025-08-28 02:08:47'),
(110, 'IRWAN SAPUTRA', '252610109', '$2y$12$0cHiRiJXAsJMe6dWzHhFyua1iY5LuhCHTO/qW2uHPXQdYAcgSDEOK', 'siswa', '2025-08-28 02:08:47', '2025-08-28 02:08:47'),
(111, 'MUHAMAD FAZRI', '252610110', '$2y$12$eRwokljjI/oqryJy0Q6qTeu7mGvY80eMiqtsZQtNIRc12BP0KY3wy', 'siswa', '2025-08-28 02:08:47', '2025-08-28 02:08:47'),
(112, 'MUHAMAD HUSAIN HAFIZHULLAH', '252610111', '$2y$12$JolPFKNHkfr.baQArlqOAuFQFcnT8ifxS74iGODHvRICIA68wAZFu', 'siswa', '2025-08-28 02:08:48', '2025-08-28 02:08:48'),
(113, 'MUHAMAD SOLEH ALFIKRI', '252610112', '$2y$12$1MQCH32Eapkg/n.Qd0H.2ubOyMRzpVwUB6kfZjwbgydxglv1a8xna', 'siswa', '2025-08-28 02:08:48', '2025-08-28 02:08:48'),
(114, 'MUHAMMAD REFAN REPIS', '252610113', '$2y$12$mCTTu2h7LAm1H346.wJuIOEomsc4FKKdIV0IoRW6Ktd/FMhuIBUZe', 'siswa', '2025-08-28 02:08:48', '2025-08-28 02:08:48'),
(115, 'NIZAR NASIHUDIN', '252610114', '$2y$12$YlByiNtfIRwhW9DYRUWQp.bNe24QkVZPdO3KYivFN051gc9IfTBvy', 'siswa', '2025-08-28 02:08:49', '2025-08-28 02:08:49'),
(116, 'RAHMAT MURTI UMAY PUTRA', '252610115', '$2y$12$pIOHwfhIBxur4iy2zaIBg.7VXEUPKG/OVuy2SrXvPIkeg5FF7XBli', 'siswa', '2025-08-28 02:08:49', '2025-08-28 02:08:49'),
(117, 'REYHAN ABIDIN', '252610116', '$2y$12$7FxKXhh6aeboR3HHmWgdpOj2ehFFVBJDT43MvPh2FL09mNQlan7Y.', 'siswa', '2025-08-28 02:08:49', '2025-08-28 02:08:49'),
(118, 'REZA ARDIANSAH', '252610117', '$2y$12$ZxD/Z1zDydx8KOLDiILKAeIHdaClcXEOGVZSmmLsRUtUSGZhMSDqK', 'siswa', '2025-08-28 02:08:49', '2025-08-28 02:08:49'),
(119, 'RHEDY AFRILIANS NUGRAHA', '252610118', '$2y$12$T5RXzUhZQpOHD6tGRzwedeUUTKNoKW8iF38b8wxAZpdlNMUSL5Ddy', 'siswa', '2025-08-28 02:08:50', '2025-08-28 02:08:50'),
(120, 'ROSALINDA', '252610119', '$2y$12$OXLu/6FY5tW5/QJD.z1kBOV.EfkCpuo3jfHcfnfvePEfnnYZ6VIZW', 'siswa', '2025-08-28 02:08:50', '2025-08-28 02:08:50'),
(121, 'SITI MARYAM', '252610120', '$2y$12$HuT1ZLmzzmZ55O1Xt33hHObNvH2lOrT4yQJ/Y1XV56hGw1W4ogSTC', 'siswa', '2025-08-28 02:08:50', '2025-08-28 02:08:50'),
(122, 'SITI PAIDAH', '252610121', '$2y$12$XUsBZQMGdmjockRLOWJbne4W5S8FBTuAqMIyYxz6ILN1pWSwnyuG2', 'siswa', '2025-08-28 02:08:51', '2025-08-28 02:08:51'),
(123, 'SRI LESTARI', '252610122', '$2y$12$RNzVEVbGszHFaXJkgEOBg.O/2lPIgGX4QcVQynfRgELhQt2sjcY4u', 'siswa', '2025-08-28 02:08:51', '2025-08-28 02:08:51'),
(124, 'TRYO ABDULGONI', '252610123', '$2y$12$hsXJ9f8wV40RwPd2ffVMZuHp.M03I4lBlpRpkuXHgYGrKMIS2OaCu', 'siswa', '2025-08-28 02:08:51', '2025-08-28 02:08:51'),
(125, 'TUBAGUS NAWAWI', '252610124', '$2y$12$eaMlnvPhjuHFpmYOrCvSq.XWA.V5ls65lV.dHqeczKEIO8nt/5qsW', 'siswa', '2025-08-28 02:08:51', '2025-08-28 02:08:51'),
(126, 'AHLIS ARFA NAOZA', '252610125', '$2y$12$jrwJckv1qPcMuLGOgb/GJ.Fk87e4D8Z5NobGijjtAe14Cw6ctmERi', 'siswa', '2025-08-28 02:08:52', '2025-08-28 02:08:52'),
(127, 'AHMAD FAUZI', '252610126', '$2y$12$.9OhvZROiSfguW0An3t2QeOap27cHFsLgevK8ykh.B3DpBH.KE0H6', 'siswa', '2025-08-28 02:08:52', '2025-08-28 02:08:52'),
(128, 'AHMAD RIDWAN', '252610127', '$2y$12$gNV40qWNxtLpvOyJlM.z.OjJHzkaT88el0L98BT/snTxULIJShreu', 'siswa', '2025-08-28 02:08:52', '2025-08-28 02:08:52'),
(129, 'AHMAD RIFAI', '252610128', '$2y$12$xIgS7AnLGt3.xoRwcq.Rg.NadWXj5lE8tIDEARYjX9YJZI4YU8bsG', 'siswa', '2025-08-28 02:08:53', '2025-08-28 02:08:53'),
(130, 'AKBAR MAULIANSYACH', '252610129', '$2y$12$Kr1fJpp9ItJ19INifZdUz.x/DcT.zWTqsgXxPluvfIkYFcKFl/ANC', 'siswa', '2025-08-28 02:08:53', '2025-08-28 02:08:53'),
(131, 'ANDINI', '252610130', '$2y$12$K5whVGEQCpwByoSsT70Zle.MSmsRQTMvhrOyx9lhKaTOd8ud/oWoC', 'siswa', '2025-08-28 02:08:53', '2025-08-28 02:08:53'),
(132, 'AYU ADIRA', '252610131', '$2y$12$WZ7TaGZ8kyZmBX3e/NIvIuuki.wNfU72AEUMiWKMXUSGzcoy8lU7K', 'siswa', '2025-08-28 02:08:53', '2025-08-28 02:08:53'),
(133, 'CANDRA MAULANA', '252610132', '$2y$12$U5Dgj9seNjs7ClccjidV.eZIXqEqTaKSSDgsv2rGSNw8yyCBhV.TW', 'siswa', '2025-08-28 02:08:54', '2025-08-28 02:08:54'),
(134, 'CIKAL ERLANGGA', '252610133', '$2y$12$M11vWVGlPkurJKMMJLCB3udWjqtf6CSDT2WhJxLqIN/y5CBzFQa/q', 'siswa', '2025-08-28 02:08:54', '2025-08-28 02:08:54'),
(135, 'DENI RIZKY PRATAMA', '252610134', '$2y$12$4st.e/O9uzPCKJkxewlCqeB.DP7GaQI9mjSAZVadRVu2JSWZQZIVO', 'siswa', '2025-08-28 02:08:54', '2025-08-28 02:08:54'),
(136, 'FAHRI ALIF FADILLAH', '252610135', '$2y$12$9cuZAPtY.qpfIPTCo3GroesXrPOzRBT9WNeKr4/Cn9xE6PP5/.OP2', 'siswa', '2025-08-28 02:08:54', '2025-08-28 02:08:54'),
(137, 'GALANG RAMDANI', '252610136', '$2y$12$CKZHvcs4tn2Jj/FWxVsFIeWHpL2aFoFI4amTKI1Es5SKTzMp8fbz.', 'siswa', '2025-08-28 02:08:55', '2025-08-28 02:08:55'),
(138, 'HADID SWARA GUMILANG', '252610137', '$2y$12$Xk/e.wwXFeHFvQQm0FkAGORgFqSKqpGbNELyllWsjDomYtV8RH9/O', 'siswa', '2025-08-28 02:08:55', '2025-08-28 02:08:55'),
(139, 'KARTIKA SARI', '252610138', '$2y$12$BTie9f0AmZoStxtvYFhwXOjviO9i9nWjdqpUUyhYVvcR3q4a8EXd.', 'siswa', '2025-08-28 02:08:55', '2025-08-28 02:08:55'),
(140, 'MARSHALL MILANIZT STILL Z', '252610139', '$2y$12$0yAJXavEyTZ4bFSfTWCUuOxxUzmdyD95RBYkknCJOwzS3PEiriLbm', 'siswa', '2025-08-28 02:08:56', '2025-08-28 02:08:56'),
(141, 'MEISYA EUIS SADIAH', '252610140', '$2y$12$JzZWjccEEneFnbSt9j3G9.qPNCgWohpsWWQoqQrDY5n9RFEEXnGXW', 'siswa', '2025-08-28 02:08:56', '2025-08-28 02:08:56'),
(142, 'MOHAMMAD ZEYAD', '252610141', '$2y$12$6zmyYT5QNlP4t9SPr2Au0eM8yB4odyps9DCxjh6L6gdZmn2Odt/qm', 'siswa', '2025-08-28 02:08:56', '2025-08-28 02:08:56'),
(143, 'MUHAMAD FARHAN', '252610142', '$2y$12$F0XwEAQXTir/iV7WYZi1uewzvh9lxgFrolnoG.9QP1VKz293dqAYO', 'siswa', '2025-08-28 02:08:56', '2025-08-28 02:08:56'),
(144, 'MUHAMAD IRFAN MAULANA', '252610143', '$2y$12$FBjCGzsemCOp/2KpU78/zenTd.DKc0ZvlXZ2zCQtPl6WbyPkTrwju', 'siswa', '2025-08-28 02:08:57', '2025-08-28 02:08:57'),
(145, 'MUHAMAD JIHAD ILMA ATTAMIMI', '252610144', '$2y$12$8bsQ49fpd30puXI9xp7gu.fWeij8JHDiqi2cQDIivD14z2imyt85K', 'siswa', '2025-08-28 02:08:57', '2025-08-28 02:08:57'),
(146, 'MUHAMAD RIZKI', '252610145', '$2y$12$FfTLPqQ.AfXpYqzV3SHxD.xb547RWXyGANJRWcVupv3uh3Gf2S.Ie', 'siswa', '2025-08-28 02:08:57', '2025-08-28 02:08:57'),
(147, 'MUHAMMAD ZAELANI', '252610146', '$2y$12$WGgubdmaiCd7KpP/c5GTYe9/4qEJXupJzJ8gdQa0vQ5pXcmz02k5y', 'siswa', '2025-08-28 02:08:57', '2025-08-28 02:08:57'),
(148, 'NURJATI', '252610147', '$2y$12$yXZmeD1xcPzf56zt1M6Bg.sNgTkgisRf2cGEE2EpWTBDJBcqZqhCS', 'siswa', '2025-08-28 02:08:58', '2025-08-28 02:08:58'),
(149, 'RAMADAN', '252610148', '$2y$12$mm5PmmeGBk34gIWSjSzIUOFOE8Gcm7Jq3U2v1RXUwWmhA3Z8mA.US', 'siswa', '2025-08-28 02:08:58', '2025-08-28 02:08:58'),
(150, 'RIFQI QHAIRUL HASAN', '252610149', '$2y$12$ho74TFVZENA8OttxRRAvUO4aQDtX4JthacLFacY0efDDsgY1ihs5K', 'siswa', '2025-08-28 02:08:58', '2025-08-28 02:08:58'),
(151, 'RIZKI NUR AL FAHRI', '252610150', '$2y$12$D9Pq0aPF151bAE6oC19BUet6dJLEwMas9Ap6PzZ2MfDlXI/I4M7Tm', 'siswa', '2025-08-28 02:08:59', '2025-08-28 02:08:59'),
(152, 'SALSA NABILA', '252610151', '$2y$12$3joI9B0tTCVP6yEVWZTgIecIYMnRl.LqM./0jaz9D6qJvtZWZ11Ca', 'siswa', '2025-08-28 02:08:59', '2025-08-28 02:08:59'),
(153, 'SITI HASANAH', '252610152', '$2y$12$1ND7K6ZN5WJtH91xjVs7deiJzokg5TeoMqmsUvyiXnGAc1ysAtQM6', 'siswa', '2025-08-28 02:08:59', '2025-08-28 02:08:59'),
(154, 'SUHENDRA', '252610153', '$2y$12$RjD3qIxZjYYzFFGw/v5NZ.HlaSHcX.KvM33nQuM1gxpwV3UC6uhmy', 'siswa', '2025-08-28 02:08:59', '2025-08-28 02:08:59'),
(155, 'SUTISNA PRATAMA', '252610154', '$2y$12$iQGqP3sAF1Zj91/ZymAm7.qHIdkazJ1CWwhHMGTPM/vhL.G.EVfi.', 'siswa', '2025-08-28 02:09:00', '2025-08-28 02:09:00'),
(156, 'TEDI MAULANA', '252610155', '$2y$12$yEGfzTk02sAtcEQMvKQ2ieHC.KfwahWZ8mhS5iZChLzk1/Zbt6pGa', 'siswa', '2025-08-28 02:09:00', '2025-08-28 02:09:00'),
(157, 'WAHYU SUPRIATNA', '252610156', '$2y$12$8yqiV.WM4av/xWHDIhk.guSVtJgb9NUwEozOe/SWycmqKkl7v2bzy', 'siswa', '2025-08-28 02:09:00', '2025-08-28 02:09:00'),
(158, 'WALID FAJAR RAMADHAN', '252610157', '$2y$12$iF75/0ORLsb89fCUSDHfFuGsiEyawfX.YwS73tbvNtUOxeLo9LyxC', 'siswa', '2025-08-28 02:09:01', '2025-08-28 02:09:01'),
(159, 'YUSUP', '252610158', '$2y$12$jO8UkatmIZYzW7Wc2xVXMOx3akqVfl9tivlolD6Hy4jvAC2.IyQNq', 'siswa', '2025-08-28 02:09:01', '2025-08-28 02:09:01'),
(160, 'ABDUL FIKRI', '252610159', '$2y$12$BZ8p7lfwZ20mdUXohL7ruOmFTHt9WlNeReX.iuP2DNooS/CXi3DRK', 'siswa', '2025-08-28 02:09:01', '2025-08-28 02:09:01'),
(161, 'ADIL ALZULFA', '252610160', '$2y$12$Xmh1cCsQDRfdY3AQOcnbWe7lDpd.EATYc7vYaixyVzqMTp8emh9s.', 'siswa', '2025-08-28 02:09:01', '2025-08-28 02:09:01'),
(162, 'AGAM MADANI', '252610161', '$2y$12$mRLwoTAxNywCtLYBnLoGI.krHHDc5nsgKh.iM5sOtsoT.N0IzknrG', 'siswa', '2025-08-28 02:09:02', '2025-08-28 02:09:02'),
(163, 'AGUS SAPUTRA', '252610162', '$2y$12$mA33Rcc7dM1auv2EwXX96O.Ep21DZLXQIfIBXIm2/eWiyJsTlKwhS', 'siswa', '2025-08-28 02:09:02', '2025-08-28 02:09:02'),
(164, 'AHMAD AZMI KHOERUNNIZAR', '252610163', '$2y$12$Z.1EcAnqywSJUB0wnQdCHOeGGKO8l9zeNLyianWqiHhFjMvFmDwoS', 'siswa', '2025-08-28 02:09:02', '2025-08-28 02:09:02'),
(165, 'AHMAD RIZKY KURNIAWAN', '252610164', '$2y$12$crromGYSV9tDoZvOSTGA6OxITbBOEXNuKgyaeadCWNdCTjfTuPBpK', 'siswa', '2025-08-28 02:09:03', '2025-08-28 02:09:03'),
(166, 'AHMAD SYAFIQ', '252610165', '$2y$12$6HWWdGVrRBNGGRUUOCXZ7.enapGOnBKiLncvaL/uBrgk7woHaAcmS', 'siswa', '2025-08-28 02:09:03', '2025-08-28 02:09:03'),
(167, 'ANGGA MAULANA', '252610166', '$2y$12$3fjg0UsaS31Yn2a64naGy.o4tR6BTFwDknsP6hhRHO37PGAunU3jG', 'siswa', '2025-08-28 02:09:03', '2025-08-28 02:09:03'),
(168, 'DENI KUSMANA', '252610167', '$2y$12$EncpuPlMnhGK0SHq2yQvEOSAEzQRO6Rk3T1SQ5gB18H3ymtiOvqcm', 'siswa', '2025-08-28 02:09:03', '2025-08-28 02:09:03'),
(169, 'DIANA RAHAYU', '252610168', '$2y$12$4dHGMVJb65GC90AQLV1gk.CVOsXrqnkfYTc.gSVSHMZNW1vxQ60NW', 'siswa', '2025-08-28 02:09:04', '2025-08-28 02:09:04'),
(170, 'EPITASARI', '252610169', '$2y$12$NX2yl1G2Zj3HZBjZTPRmmON2G3myCC.UHXF8lN6Ah4iLmgra.m.le', 'siswa', '2025-08-28 02:09:04', '2025-08-28 02:09:04'),
(171, 'FARHANNABIL', '252610170', '$2y$12$W5wHKNFH4bg0rcDxhNLyWup6hXRBRS6st0ZYQ76KNDcAqaVj51E2u', 'siswa', '2025-08-28 02:09:04', '2025-08-28 02:09:04'),
(172, 'HABIL NUR ALDIN', '252610171', '$2y$12$dqaBgRKsXhlJumoubv.0rOP8HuIBeuJmbNkdMVlw5MCvubAiDQnvW', 'siswa', '2025-08-28 02:09:04', '2025-08-28 02:09:04'),
(173, 'KARDA PUTRA ADIANSYAH', '252610172', '$2y$12$Ue7CUPLBZnwE9R4/52fW0Oe40Oft4e6S8Mm8DsKY19VDJaQM0OxOC', 'siswa', '2025-08-28 02:09:05', '2025-08-28 02:09:05'),
(174, 'MARYONO', '252610173', '$2y$12$Q7qRbJ89JLFVRsHUGCj1X.lBEKp67nFljueiPQBN.Q4CUBAECqlPe', 'siswa', '2025-08-28 02:09:05', '2025-08-28 02:09:05'),
(175, 'MASITOH NURUL SYIFA', '252610174', '$2y$12$Fd.UYHP1nkroXTQTtaD45uw7ws5UVXDqdON1qkg9MtHBS4S7/DT1S', 'siswa', '2025-08-28 02:09:05', '2025-08-28 02:09:05'),
(176, 'MOHAMAD FAJAR ALFAZRY', '252610175', '$2y$12$vox6OxdT7trJGezsJmKdVueFtKCApC30kCUKHOP5dO4Z60I2okrTG', 'siswa', '2025-08-28 02:09:06', '2025-08-28 02:09:06'),
(177, 'MUHAMAD KHOLBY SAHIH', '252610176', '$2y$12$/lzh/.s/L/IJacWiww070.Fs4DSbPXKuemoNH8vf1xj6KmWqkd.I.', 'siswa', '2025-08-28 02:09:06', '2025-08-28 02:09:06'),
(178, 'MUHAMAD RIDWAN SAPII', '252610177', '$2y$12$igMG3XhinbsLopJ6uigyuegX5EnESLiF0wORH.giK.2DaTzB6VEuO', 'siswa', '2025-08-28 02:09:06', '2025-08-28 02:09:06'),
(179, 'MUHAMMAD ALDIANSYAH', '252610178', '$2y$12$IE4PtjR3Cj7Cwi1If5A0G.kIoMWvcaUqKIY7.XRrJtfC0/mgLoRvW', 'siswa', '2025-08-28 02:09:06', '2025-08-28 02:09:06'),
(180, 'MUHAMMAD RIDWAN AL KHADAFI', '252610179', '$2y$12$h5RVazK.hIjaN4RELMQBhuTsgGDRHXavknSpBF2DijBD.zKfDSp0m', 'siswa', '2025-08-28 02:09:07', '2025-08-28 02:09:07'),
(181, 'NOVAL MALIKI', '252610180', '$2y$12$eSpdFNuZQAQRZDt5714EXOjd0C5613lar3FNvkDUfBBnmwYg4pLV.', 'siswa', '2025-08-28 02:09:07', '2025-08-28 02:09:07'),
(182, 'NURWULAN', '252610181', '$2y$12$CEPoBt99Snadl.ct1dFfNOA9UXcb0.CTTCJyER9v4SIfkNsbEVN3S', 'siswa', '2025-08-28 02:09:07', '2025-08-28 02:09:07'),
(183, 'OBAY SOBARNA', '252610182', '$2y$12$rO9RLziKWdB0oJTb.IEBw.ckd.k/fQtyfYPzI1ryV8ewRKtXj6//y', 'siswa', '2025-08-28 02:09:08', '2025-08-28 02:09:08'),
(184, 'PATONAH', '252610183', '$2y$12$EPiijAeaqnr7PEfkqlP4gekTWE37FEvVlMtIYqPumMZSG34i4C/0G', 'siswa', '2025-08-28 02:09:08', '2025-08-28 02:09:08'),
(185, 'RAGIL GOJALI', '252610184', '$2y$12$ZfpOOb.PNTKKYrikttXFWecHbpWjhcwti6Sj.Lb5rFZi2t/UzDQHW', 'siswa', '2025-08-28 02:09:08', '2025-08-28 02:09:08'),
(186, 'RAJIF JULIAWAN', '252610185', '$2y$12$rg0erEo7caWmyHrwkD8Mh.bvQ0s.4P0JbCtbjWGdtKjm4Gppp9Z3y', 'siswa', '2025-08-28 02:09:08', '2025-08-28 02:09:08'),
(187, 'RIO SUSANTO', '252610186', '$2y$12$xOFxrVJ6bWzpIUBVO8Tyhezm8aRggvx/i98zg0c62oxauPpsqM.cK', 'siswa', '2025-08-28 02:09:09', '2025-08-28 02:09:09'),
(188, 'RIZKY RAMDANI', '252610187', '$2y$12$inh/hCvcjjIyuWNnv6z6Cu3Dig3xVAQtSPHmoJCpkQ47OWo40WwUu', 'siswa', '2025-08-28 02:09:09', '2025-08-28 02:09:09'),
(189, 'RUSLAN', '252610188', '$2y$12$25tA/yoskQgh0ur8SbmqbuMQutczBvk/UhFQab4apYzdnIlawMTge', 'siswa', '2025-08-28 02:09:09', '2025-08-28 02:09:09'),
(190, 'RYAN HIDAYAT', '252610189', '$2y$12$afjOXNRYz3CMfxC1w7hO9.1/LD9h81e1MTvxa0fFQsjBm8p.9be3y', 'siswa', '2025-08-28 02:09:09', '2025-08-28 02:09:09'),
(191, 'TAUPIK UROHMAN', '252610190', '$2y$12$PwYQQ7Ooub8LvulCnsaJVeHM6JN4/75wFGdZv702xWoRTC7f636oO', 'siswa', '2025-08-28 02:09:10', '2025-08-28 02:09:10'),
(192, 'WILLIYANA ADISTIA', '252610191', '$2y$12$.OxVg5TqIHs9MV9ml.cYT.Kx.mBFAWQXDbsaL/w8qsu/uYAXBgTWC', 'siswa', '2025-08-28 02:09:10', '2025-08-28 02:09:10'),
(193, 'YUSUF RAMADAN', '252610192', '$2y$12$z93bDE9qy5AAPLXQk0.S..i4m8sA103Qq7EBvr98kdRgQA1f9p7Yq', 'siswa', '2025-08-28 02:09:10', '2025-08-28 02:09:10'),
(194, 'AHMAD GUNAWAN', '252610193', '$2y$12$gz6Asc7msRLEprS5cfx1KOb0sKOywAIAQ7mVPtEqBLqYWRMCSlYxe', 'siswa', '2025-08-28 02:09:11', '2025-08-28 02:09:11'),
(195, 'AKBAR ALVIAN', '252610194', '$2y$12$4r8za8ONB8xpt.H6RDn5dOW4mZ6rV0dg4UfxmFcDJlZDsma5MT8Yy', 'siswa', '2025-08-28 02:09:11', '2025-08-28 02:09:11'),
(196, 'AL AZIS MUBAROK', '252610195', '$2y$12$3gkd/RuoWbz2DShWw86BFeWUmim9UEGDluxrAc5c6H3f.t05QRjgi', 'siswa', '2025-08-28 02:09:11', '2025-08-28 02:09:11'),
(197, 'ALIF QIZWINI', '252610196', '$2y$12$5Iu/5L2.kiP0dyyGk3ETdOv72KuE0v0V7emNCUKYLMYTWuVY8211e', 'siswa', '2025-08-28 02:09:12', '2025-08-28 02:09:12'),
(198, 'CARSADI', '252610197', '$2y$12$/Ya4cr92zRZHLh2JUxvpieI1s5RZ55qbhvdKdxHj5W1c4AlxOrdtK', 'siswa', '2025-08-28 02:09:12', '2025-08-28 02:09:12'),
(199, 'CHIKA RAHMAWATI', '252610198', '$2y$12$03WQBwUib827BfJsbc2ZRu6ojffUz997DgngHK.iDFm3AY0MuUXQO', 'siswa', '2025-08-28 02:09:12', '2025-08-28 02:09:12'),
(200, 'DEFNE MAULLANA EL SYARIF', '252610199', '$2y$12$V93rxYo8kzLaIyliLtmg2OWNmimnGj/BmMqYpj9Vz578APwRlJUyu', 'siswa', '2025-08-28 02:09:12', '2025-08-28 02:09:12'),
(201, 'DEVI DESVITASARI', '252610200', '$2y$12$TRnN81tC1VfqJsKF9R8tTOxZRxSAEUcWA2TP9BYI4DXKnncSUOygC', 'siswa', '2025-08-28 02:09:20', '2025-08-28 02:09:20'),
(202, 'DIKA NANDA', '252610201', '$2y$12$1g5j3NrDb3ST3sK9W2iemeyAONK52bWxBaHZL/32PoYNq39YTBa7q', 'siswa', '2025-08-28 02:09:20', '2025-08-28 02:09:20'),
(203, 'EKA FEBRIANA', '252610202', '$2y$12$mvbi3vON4PCy0t1o4SWQ8OHKnqb5gWyfKPlWq1dvHdiHgk9GuKvX.', 'siswa', '2025-08-28 02:09:21', '2025-08-28 02:09:21'),
(204, 'GALANG FIRMANSYAH', '252610203', '$2y$12$EPEaKQhZj/POcr4qfV/d4OWE2wJH4MpbK6KV2lOzyHAkVPk6Xtqg6', 'siswa', '2025-08-28 02:09:21', '2025-08-28 02:09:21'),
(205, 'HALIMATU ZAHRA', '252610204', '$2y$12$sKikpyLoK1t7E9jyvdTN2.Zs8JSdM3DE5reDZ1jz1joLmOia2I7/u', 'siswa', '2025-08-28 02:09:21', '2025-08-28 02:09:21'),
(206, 'HASBI ASHIDIQI', '252610205', '$2y$12$spHQRloaKjOpzeVAErDp2.KgZN0xMVBvNWG6sZ5aH2Yo7dGforBkW', 'siswa', '2025-08-28 02:09:21', '2025-08-28 02:09:21'),
(207, 'HERDIYAN NUGRAHA', '252610206', '$2y$12$oDos3baHabhd9EzX0ddvMeKSmcL7O5lBY4TU9p0CxFGtISiAU1ZyS', 'siswa', '2025-08-28 02:09:22', '2025-08-28 02:09:22'),
(208, 'JEJE', '252610207', '$2y$12$746FPDQgBBkJmAarcqWJFeNo/IGECehvMouwV29i0vv6DEsmt4riC', 'siswa', '2025-08-28 02:09:22', '2025-08-28 02:09:22'),
(209, 'MARINA F SIMATUPANG', '252610208', '$2y$12$jyC4YoTcVf1zMOvR6kBXQOCeQiDYeJotlt4KJB3bJceQmMN8urM2m', 'siswa', '2025-08-28 02:09:22', '2025-08-28 02:09:22'),
(210, 'MUHAMAD IHSAN MUBAROK', '252610209', '$2y$12$3lOF77Eol2wz6o4yZBrcaOTKfUanO9FCY8WgyBwX4qhpWYubUR/KC', 'siswa', '2025-08-28 02:09:23', '2025-08-28 02:09:23'),
(211, 'MUHAMAD IQBAL ALFAQIH', '252610210', '$2y$12$MgRsFO1be.XPGS7YpywYNOeeHWzNpsrjoNxb6/JOj/pv10ezRxzYa', 'siswa', '2025-08-28 02:09:23', '2025-08-28 02:09:23'),
(212, 'MUHAMAD KAMAL', '252610211', '$2y$12$BfYYHakJjp3wURsDZoVSJ.vBWJGwK6Jx8xCyC992BnsA8zbiaxGe.', 'siswa', '2025-08-28 02:09:23', '2025-08-28 02:09:23'),
(213, 'MUHAMAD REHAN', '252610212', '$2y$12$/EGL0GAVfrhG1sq3F1pJmehhkLv2wKh5axl47KZh25ZW0q6ghSWTe', 'siswa', '2025-08-28 02:09:23', '2025-08-28 02:09:23'),
(214, 'MUHAMMAD WAROSATUL AMBIYA', '252610213', '$2y$12$/M4WesVpAL.lZcr4c/JmMeNoUDbe8uTQjRx3PH5ePyr46.xwkYiyO', 'siswa', '2025-08-28 02:09:24', '2025-08-28 02:09:24'),
(215, 'NURFRIAN SYAHRONY', '252610214', '$2y$12$ch9e/nakVNHNzb012eE4D.4UQw0lvxQZt70.KIQS51ZRZ1ES4jZAO', 'siswa', '2025-08-28 02:09:24', '2025-08-28 02:09:24'),
(216, 'RAELAN MUTABAROQ', '252610215', '$2y$12$r97m7Ki5oWy4HLm1dCnCyu09iLbfl.wFT5pc9c7Z1QPzjAhaie7aq', 'siswa', '2025-08-28 02:09:24', '2025-08-28 02:09:24'),
(217, 'RAMLI', '252610216', '$2y$12$RC5qTyA0CxfAIL.aw8j6xugh87Qs.4Cp9LsfaxNDZSSADnr8kduku', 'siswa', '2025-08-28 02:09:24', '2025-08-28 02:09:24'),
(218, 'RIFQIANSAH', '252610217', '$2y$12$Ee.GyqtHiZHHdyuzsIfeEuFs5QAx1d/qhB7hqVNPI0LQ1fW1i9yHC', 'siswa', '2025-08-28 02:09:25', '2025-08-28 02:09:25'),
(219, 'RINTO', '252610218', '$2y$12$G4wzWjBkZOywjlDLx6SzoOAfeZZPZpsFDEaLQWk5Yu0Z2azq5R5B6', 'siswa', '2025-08-28 02:09:25', '2025-08-28 02:09:25'),
(220, 'RISMA', '252610219', '$2y$12$IWlvCKPYRLIm1uGy5PF08eGF4xzLT9GMhiCTWmWqG.Wa6BPY8CWnC', 'siswa', '2025-08-28 02:09:25', '2025-08-28 02:09:25'),
(221, 'SIVA YULYANTI', '252610220', '$2y$12$6GKkRCZaUwHatPcLwYQ5/.haTrBsQ6GDveBES8WrpPQSfjhckCZBC', 'siswa', '2025-08-28 02:09:26', '2025-08-28 02:09:26'),
(222, 'SUHERMAN', '252610221', '$2y$12$P3FCGeZoyBm6RSXqtrPiQ.PUW/Wnqw0kqtZJDyZWeV7MU2q/wnUFW', 'siswa', '2025-08-28 02:09:26', '2025-08-28 02:09:26'),
(223, 'SUNANTA', '252610222', '$2y$12$vzVEl/mxk/xSJvTSMt7NneIT707pY/mZ3FcSd9TPzQoDlkMuAT5Jy', 'siswa', '2025-08-28 02:09:26', '2025-08-28 02:09:26'),
(224, 'SURYANI WIDYA PUTRI', '252610223', '$2y$12$O6gQMGHMCOmQb17rdu/GBOXlveO3O.HskHiUtRIS5rvuTZw5ZXYhq', 'siswa', '2025-08-28 02:09:26', '2025-08-28 02:09:26'),
(225, 'ULFIA ANGGIA PUTRI', '252610224', '$2y$12$qgawGQTRA3dXPSWiM5MltORv60K956UWS4uM7yaCJOyYuv1MMc66y', 'siswa', '2025-08-28 02:09:27', '2025-08-28 02:09:27'),
(226, 'WARDI', '252610225', '$2y$12$4p58mGm6gDDoI2y0w9DprOZ5Cua91L9s5xePxJtrAU2lt/VioaC7G', 'siswa', '2025-08-28 02:09:27', '2025-08-28 02:09:27'),
(227, 'WARDIMAN', '252610226', '$2y$12$7CrzK.WP8aOGOQQCsnQCuuhIBcLf8gvoAzU0Z3FhnLVAYqz9cmewm', 'siswa', '2025-08-28 02:09:27', '2025-08-28 02:09:27'),
(228, 'ZAHRAN MAHESWARI', '252610227', '$2y$12$H9FfOWvfHZ2zCrY5DJ9UdO61ePTSF1RbcOGk31qQEjBS8adrWwRFq', 'siswa', '2025-08-28 02:09:28', '2025-08-28 02:09:28'),
(229, 'AHMAD RANDIKA', '252610228', '$2y$12$Tu5V4rWM1/FqWsPuVsMcN.1xtyUAXXLP7LiZhFeo3P0/OMRWI37.K', 'siswa', '2025-08-28 02:09:28', '2025-08-28 02:09:28'),
(230, 'AHMAD SAEPUDIN', '252610229', '$2y$12$JtMSVAQbSXkwBQjvjG5jw.gTxH82qNeF33n5CcNS8HWOF/h6Sm3Ta', 'siswa', '2025-08-28 02:09:28', '2025-08-28 02:09:28'),
(231, 'AHMAD SOFWAN ISMAIL', '252610230', '$2y$12$lBgueKGBRPSy.DvQt5Mmf.3lPXR2XfJHFpBkrlay0ee1cQgatQO9G', 'siswa', '2025-08-28 02:09:29', '2025-08-28 02:09:29'),
(232, 'ANDHIKA RAMADHAN', '252610231', '$2y$12$bhYb8L9TTMsBnYL.oby7ius9VaKi3ROL5pZJ9i/j37O6/drzMDLlK', 'siswa', '2025-08-28 02:09:29', '2025-08-28 02:09:29'),
(233, 'ANDIH SAEPUL BAHRI', '252610232', '$2y$12$dcJO61uIb8YzTCnbtlUchOR6EFqtBMLV5cyDtUvC6YBubcREO2C3S', 'siswa', '2025-08-28 02:09:29', '2025-08-28 02:09:29'),
(234, 'ANDIKA PRATAMA', '252610233', '$2y$12$CraL9pqoznzbvZ.cbUyxGuJIwm6qJkVpkwck6JYici7qGkcQ856YS', 'siswa', '2025-08-28 02:09:29', '2025-08-28 02:09:29'),
(235, 'ARIYA DARMAWANSYAH', '252610234', '$2y$12$v3XG7W/jW2CRrJEGIlHP9.WkER3x22VGspWrshXgbyEdxWNQkQZTu', 'siswa', '2025-08-28 02:09:30', '2025-08-28 02:09:30'),
(236, 'ARSYA NUR HARLY HASAN', '252610235', '$2y$12$/O0rBF1/y5x9DCFr/J/oCu4OnU7vWP/oRDfL1b5zG1TOloA06oKia', 'siswa', '2025-08-28 02:09:30', '2025-08-28 02:09:30'),
(237, 'BENI KURNIA', '252610236', '$2y$12$qbJpD68AdCiPHyZWo0onLOSBWrkiwoZlvTV/F104m1odjKNUyypmm', 'siswa', '2025-08-28 02:09:30', '2025-08-28 02:09:30'),
(238, 'CANDRA AKBAR', '252610237', '$2y$12$L27y7SH/CmcbXfrKIhUUjOva.DTUYUkZF.PYPe2qibhdzO5KgxV3K', 'siswa', '2025-08-28 02:09:30', '2025-08-28 02:09:30'),
(239, 'CINTIA', '252610238', '$2y$12$0ShhQ6NGefm4BN4LW1f5g.7L///5.FiE2j5LtCpMAEEA9sr40JHBm', 'siswa', '2025-08-28 02:09:31', '2025-08-28 02:09:31'),
(240, 'DEWI CUT NADIN', '252610239', '$2y$12$AjN.6NXyLRgQ3Sa38ZYYPOtrqfIxH9loiX4dAB8YiFch/JBK1jbVC', 'siswa', '2025-08-28 02:09:31', '2025-08-28 02:09:31'),
(241, 'DIKA BAEHAKI', '252610240', '$2y$12$MvMw09ed2/Cv2k5EAqzBo.jgVffuiOI2R3e4gCO3Ty1jOa2Az1RBK', 'siswa', '2025-08-28 02:09:31', '2025-08-28 02:09:31'),
(242, 'DIMAS SETO', '252610241', '$2y$12$G8M9pJqSJ4Qa0cQ6TAYz8eakVxg8/IhBpQ1C4bsBlSehKj1XUqZIW', 'siswa', '2025-08-28 02:09:32', '2025-08-28 02:09:32'),
(243, 'FAIQ SUGILAR', '252610242', '$2y$12$41lF2CVvptawwiIeKNrAsuf0vaqPXy9RTH3tpRfcPhiiceSW6znR6', 'siswa', '2025-08-28 02:09:32', '2025-08-28 02:09:32'),
(244, 'FAJRUL MA ANI', '252610243', '$2y$12$Qn7NyjRueZlyU/yr8NJgMuN4hhM8tbiApyqukYGkclrnE8izYzZ9.', 'siswa', '2025-08-28 02:09:32', '2025-08-28 02:09:32'),
(245, 'FUJA SAEPULLOH', '252610244', '$2y$12$lJNnUhTVx1Fvf62Mfn3WWekQrERd1v/ik6cO5PY6uF7wJZiJj/uCK', 'siswa', '2025-08-28 02:09:32', '2025-08-28 02:09:32'),
(246, 'HENDI SETIAWAN', '252610245', '$2y$12$WE3ILZAVynQrYofevxk1JOLyUd9DXnB5bf3HHgkJkWIeynv5i5756', 'siswa', '2025-08-28 02:09:33', '2025-08-28 02:09:33'),
(247, 'KARNATA JAYADI NINGRAT', '252610246', '$2y$12$r/5yjwHLycbXpfkRaZwSSeRO1qWaqFFw8yXvOVpSPVkkkzcepNj/q', 'siswa', '2025-08-28 02:09:33', '2025-08-28 02:09:33'),
(248, 'MUHAMAD KHAIRUL INIESTA', '252610247', '$2y$12$xvjhbgb0v96OhUjAbWlL1esKEEIzNpkVdMPPlwXWSKg.yAPvL1lKC', 'siswa', '2025-08-28 02:09:33', '2025-08-28 02:09:33'),
(249, 'MUHAMMAD DANIAL ALPIKRI', '252610248', '$2y$12$18thrwaVTlgupM9dkiD/5eHOuKECIlgTIEiKVRxi3I1tpxoCzoeQ6', 'siswa', '2025-08-28 02:09:34', '2025-08-28 02:09:34'),
(250, 'NENENG HABIBAH', '252610249', '$2y$12$AG7iLuW8GAqoqmmHrDFF8ueDQOq8dwGigRX82AZeQmy46XYaJs4AS', 'siswa', '2025-08-28 02:09:34', '2025-08-28 02:09:34'),
(251, 'NOVAL JUNIAN SALEH', '252610250', '$2y$12$SzYMvZdX3x6hrJ9czl.Gj.ZMPmpOzOQrzdCrHafmnDdEEsmk7VHii', 'siswa', '2025-08-28 02:09:34', '2025-08-28 02:09:34'),
(252, 'NUAF DHANU WINATA', '252610251', '$2y$12$O4PfOmEvAy3vxZ9ohzKBNeKxIZRGPD2Kf6uoOkUDa832XUQi1a3zS', 'siswa', '2025-08-28 02:09:34', '2025-08-28 02:09:34'),
(253, 'RAIHAN ABDUL YAFIDZ', '252610252', '$2y$12$rjeK68u0eWjOjPYNd14juuMRlDgCFJq88qhJgMOREOxs4pUNnn6la', 'siswa', '2025-08-28 02:09:35', '2025-08-28 02:09:35'),
(254, 'REIHAN FIRMANSYAH', '252610253', '$2y$12$fIi2nqHQsdAEX3PwG6jyJOHSkquOL6T8cT9OBnX1QnAvW0pV8dYCu', 'siswa', '2025-08-28 02:09:35', '2025-08-28 02:09:35'),
(255, 'RIO RAMA', '252610254', '$2y$12$N9S.xjDygop6UUTf6hHtDuOthyvW./.JhHEP0l/6SGGE3ieT7GvhK', 'siswa', '2025-08-28 02:09:35', '2025-08-28 02:09:35'),
(256, 'RITA FITRIA', '252610255', '$2y$12$qWdYmu247iYbdW2oHLWkUOs6SPksmXvOjxvJXSh/Rkj4AmnYEqmAa', 'siswa', '2025-08-28 02:09:35', '2025-08-28 02:09:35'),
(257, 'ROFIKOH ALIYATUL SUNIAH', '252610256', '$2y$12$KxQz1cBwgbHqsdvLpQiUmeU..tJ5YVhp3nKmR2d2jticI1WLb0VEK', 'siswa', '2025-08-28 02:09:36', '2025-08-28 02:09:36'),
(258, 'ROSAM CAKRA WINATA', '252610257', '$2y$12$SF0lD0RwZ0Mm.dKV1jupeegl7.4Rg88Ptpmn4USuQJSHP8BRoyg2G', 'siswa', '2025-08-28 02:09:36', '2025-08-28 02:09:36'),
(259, 'SAEFUL GOFAR', '252610258', '$2y$12$H7PJw6FU5TiisfCudpK4Y.TuxNep6CRC3ylbONv1B4khDineYnBjC', 'siswa', '2025-08-28 02:09:36', '2025-08-28 02:09:36'),
(260, 'SAEPUL MAULANA', '252610259', '$2y$12$GjI76k1eoD8nDPlQ96Rks.Ir50dnAdmILeCP65G0wreIlrTXz0J1e', 'siswa', '2025-08-28 02:09:37', '2025-08-28 02:09:37'),
(261, 'SETIYAJI AHMAD FAUZI', '252610260', '$2y$12$boSUnOSeqGjUNN6dNq6MluXYU9STP9YVNq4.mv9XBX85FpjzR8Xui', 'siswa', '2025-08-28 02:09:37', '2025-08-28 02:09:37'),
(262, 'WINDY OCTOVIYA', '252610261', '$2y$12$DUBzcR9suw06y848mGys0u5hdMX2Pj3xGJMq128omDtC385u5vwru', 'siswa', '2025-08-28 02:09:37', '2025-08-28 02:09:37'),
(263, 'YUDI ADITIA', '252610262', '$2y$12$gRpgNKSZa60a.hat0Bhpju3V3XhPe73oiNEeSq1Wxe.vJwbLg7Xdu', 'siswa', '2025-08-28 02:09:37', '2025-08-28 02:09:37'),
(264, 'AMELIA', '242510001', '$2y$12$Ab7iyOGsZjL3Yi7PBZVj4erVIKXP.6Xx8iDWobzaHqqoG1IQ4AOJC', 'siswa', '2025-08-28 02:09:44', '2025-08-28 02:09:44'),
(265, 'ANISA RHAMADANI', '242510002', '$2y$12$DN4502rmJe2PZG060GTj3.EqN2K/2Gah4mU5UX41b/U/tAEaXszRa', 'siswa', '2025-08-28 02:09:44', '2025-08-28 02:09:44'),
(266, 'AYU NINGRAT', '242510003', '$2y$12$Wx0.5up6KK7ODnH.xGgsyOgvSl0HCq5eFTt8BTgPNvH3Z/hKN7WuG', 'siswa', '2025-08-28 02:09:44', '2025-08-28 02:09:44'),
(267, 'CINDI LESTARI', '242510004', '$2y$12$D0l/70KpDMo9Xt7Rzf.Xguzf0ngBcjIlwlCh3fdOfFxS0mHvcUisy', 'siswa', '2025-08-28 02:09:45', '2025-08-28 02:09:45'),
(268, 'CITRA SHABILA IRAWAN', '242510005', '$2y$12$QT2ID8aNdClFyZFRyZyLWeY8BgJTW24njHDcyCuKMAtTOG6jJ/Cg6', 'siswa', '2025-08-28 02:09:45', '2025-08-28 02:09:45'),
(269, 'DENITA SARI', '242510006', '$2y$12$gzO366XeSaFBSQ4GDVjBV.MoVcpTavsHYQswXocokAYs8i3/Tg1dK', 'siswa', '2025-08-28 02:09:45', '2025-08-28 02:09:45'),
(270, 'EVI NURAENDI', '242510007', '$2y$12$Wx8C.NcjQetFQmstK/lo1OoD/fY9xKgsyLN.vkBT4Rhh77EpcSAly', 'siswa', '2025-08-28 02:09:46', '2025-08-28 02:09:46'),
(271, 'INTAN LESTARI', '242510008', '$2y$12$TgQjz38zSnS8UaOkTuVhMu7rXPeQ6n5tmIyzY/K/1WNXwrVBmKwra', 'siswa', '2025-08-28 02:09:46', '2025-08-28 02:09:46'),
(272, 'INTAN RASJI RAMADHANY', '242510009', '$2y$12$e9c81G1UcW7dkFf.9ElMXuxG3Eq3UgRCSgWU/T6Pksb9/sQlCzHzC', 'siswa', '2025-08-28 02:09:46', '2025-08-28 02:09:46'),
(273, 'KARLINA', '242510010', '$2y$12$E4aUvQgbLjzmojxJX9326OjfoYW1UzF0Zcui8hDgQxVQb2r0ksby6', 'siswa', '2025-08-28 02:09:46', '2025-08-28 02:09:46'),
(274, 'KURNIA', '242510011', '$2y$12$7w6jg2bZVZotur.JG4R28.de5GoVWQDBXYy78ms48VimwwcvmKa7.', 'siswa', '2025-08-28 02:09:47', '2025-08-28 02:09:47'),
(275, 'MAHENDRA', '242510012', '$2y$12$PXQ5Vbuw9axgM1ZcQEMXauxZxKMBr9IZnGjPUy9w05kM11i3TWX36', 'siswa', '2025-08-28 02:09:47', '2025-08-28 02:09:47'),
(276, 'MARPUAH', '242510013', '$2y$12$yOde1xzx0eeqyzAyO/m50uiLjeGld7RroAIurw.I6hMGsVr1EPf9C', 'siswa', '2025-08-28 02:09:47', '2025-08-28 02:09:47'),
(277, 'MAULANA ANSORI SURYANA', '242510014', '$2y$12$gMzMhR/GjQQiXnQxZ6eEmuar4UWdexZn8NC8yYk4IY03oCy1CRkVG', 'siswa', '2025-08-28 02:09:48', '2025-08-28 02:09:48'),
(278, 'MAYLANI', '242510015', '$2y$12$3Gb/rMkWm3.TH.REH31w8uHStmXN7m9FQyPoVhF5f15557qQi.aS2', 'siswa', '2025-08-28 02:09:48', '2025-08-28 02:09:48'),
(279, 'MUHAMAD ADHI SATRIO', '242510016', '$2y$12$gxkHXrU4jTINCmjB8wQ5me48E6g0BtAEeTteVQ5eHm6c.q/TZ.fiO', 'siswa', '2025-08-28 02:09:48', '2025-08-28 02:09:48'),
(280, 'NUR SILVA OCTAVIA', '242510017', '$2y$12$z29sDeIqLhlR4WS0B6tWuOuVg89kHo9Ur6ai2zQNrIqYwJmCfLNQ2', 'siswa', '2025-08-28 02:09:49', '2025-08-28 02:09:49'),
(281, 'NURMALA PUSPITASARI', '242510018', '$2y$12$kdR/4b.8UNZCVHMcU.iOF.3O4Xcpm3GID68kUjED1kezsUuRY0irC', 'siswa', '2025-08-28 02:09:49', '2025-08-28 02:09:49'),
(282, 'QORIATUL FITRIYAH', '242510019', '$2y$12$SYr0/zewe7bbEzSLooC7fOiEkHfo4Okrg9v7xd6SBYFwjDF8W85hK', 'siswa', '2025-08-28 02:09:49', '2025-08-28 02:09:49'),
(283, 'RAHMA PUSPITASARI', '242510020', '$2y$12$IERFIrgemrYvBuaCsmKymeZ3XHbW838g.IPcWgiGJ2Zfdnrf5EtFK', 'siswa', '2025-08-28 02:09:50', '2025-08-28 02:09:50'),
(284, 'RISKA APRILIA', '242510021', '$2y$12$A81fi9EP8umJ/zSGU.KF/erH7yzBDTh6HDdHmChdYkAgXrJVFiKAi', 'siswa', '2025-08-28 02:09:50', '2025-08-28 02:09:50'),
(285, 'RISMAYANTI', '242510022', '$2y$12$eUYEK365WmygblRdxepzZu/GDaJp3emE5yIKzXffuCGzQReSPHVTG', 'siswa', '2025-08-28 02:09:50', '2025-08-28 02:09:50'),
(286, 'SARAH INDRIYANTI', '242510023', '$2y$12$i3OKsGdkX34dK0pqcxeXlOyVKErSX20I45/o5Y38HSuOosMJ62eDi', 'siswa', '2025-08-28 02:09:51', '2025-08-28 02:09:51'),
(287, 'SITI JAHROTULSYITTA', '242510024', '$2y$12$5ipagXTTYtAFtf0iCMTQ6OAacAerwymDpCVgG6vv8qmZt4nmNWUYe', 'siswa', '2025-08-28 02:09:51', '2025-08-28 02:09:51'),
(288, 'SITI NURHASANAH', '242510025', '$2y$12$aTMywPFkbv7KhxCdf6Xo9OU3QRc/DRHdRYLtcT8jCsA3plgQhXcZK', 'siswa', '2025-08-28 02:09:51', '2025-08-28 02:09:51'),
(289, 'SITI NURPADILAH', '242510026', '$2y$12$wexy9lOIr4HvaQCOq3bxV.guc1Q2mf6dWifuvAR8AOe86EneEXtoa', 'siswa', '2025-08-28 02:09:51', '2025-08-28 02:09:51'),
(290, 'SITI SALAMAH', '242510027', '$2y$12$ishw.x0c8NL7bSvnmkIRs.5OM2hwHKvyM/TU/tTBhpfPdSdmDUQFC', 'siswa', '2025-08-28 02:09:52', '2025-08-28 02:09:52'),
(291, 'SITI ZENAB', '242510028', '$2y$12$EjrP8q35SwKOfTLk9r53S.Wn/.LbuuJ0X1EHgx7oSfFOI7H3zC18m', 'siswa', '2025-08-28 02:09:52', '2025-08-28 02:09:52'),
(292, 'SYAVIRA DWI NOVIANTI', '242510029', '$2y$12$Ggnt1dYhKanftypF8ql3JOi4VJ8ZerPGNGhNWY8pnVdPNz1gWxzsO', 'siswa', '2025-08-28 02:09:52', '2025-08-28 02:09:52'),
(293, 'SYIFAUDZIHNI', '242510030', '$2y$12$qDJsIGZNIElFNytNUr4KxuG.04Fu1DHzjz/2oYzOKUCIn3OvYYUqK', 'siswa', '2025-08-28 02:09:53', '2025-08-28 02:09:53'),
(294, 'TASYA ANANDA', '242510031', '$2y$12$WI01XnGa4aQQCxfgCJ/biOIJ4mP7DhcL5wJsUTV1OcKUD8WqxeshG', 'siswa', '2025-08-28 02:09:53', '2025-08-28 02:09:53'),
(295, 'TIKA DEWI', '242510032', '$2y$12$IP4YBzTHK1RPwekpe3EXkezAII.hvy.U2ZdpmZDdDSDu6m6SO.gtK', 'siswa', '2025-08-28 02:09:53', '2025-08-28 02:09:53'),
(296, 'WILDA CAHYANI', '242510033', '$2y$12$4fgx/J4KVcnPBZbYAyzNguoxYbHqtnw68k5G4qUvNAdUpPK7BEzJ.', 'siswa', '2025-08-28 02:09:54', '2025-08-28 02:09:54'),
(297, 'AISAH WALINAYAH', '242510034', '$2y$12$rF8EZnHRbVYVdUk5p151BuZC6H4WvnQv1sh078S7xTux4WIT9PSUC', 'siswa', '2025-08-28 02:09:54', '2025-08-28 02:09:54'),
(298, 'ANGGUN DARA CANTIKA', '242510035', '$2y$12$7TB2k3q5eUgp32uHlzx65.vi8IHgKOZgn0lEYiC1lVprm5cMmOx6m', 'siswa', '2025-08-28 02:09:54', '2025-08-28 02:09:54'),
(299, 'APRILIANI', '242510036', '$2y$12$KorPsW8TAjIclNzTpnoKOOY6j3ZgcMHG1WGn9sibpTM0.AQNHv9Z.', 'siswa', '2025-08-28 02:09:54', '2025-08-28 02:09:54'),
(300, 'ARUM', '242510037', '$2y$12$iIW4xMQQ3azlxExwSPLqJetdLWtQ6w/3bn0Z1Xu2zoAk3fZVE.CKG', 'siswa', '2025-08-28 02:09:55', '2025-08-28 02:09:55'),
(301, 'CITRA NURY RAHMAN', '242510038', '$2y$12$TKFW1i1jsvq5BfJQjq5fOOcjCujZx4sA6L40soG1N1pZI0EYrhwdu', 'siswa', '2025-08-28 02:09:55', '2025-08-28 02:09:55'),
(302, 'DEDEH FAUZIYAH', '242510039', '$2y$12$u2EGvq3fjhq7QjQIQUB/tujw.mY9Hl3odjeiMUJRYlkE9zex.YCdm', 'siswa', '2025-08-28 02:09:56', '2025-08-28 02:09:56'),
(303, 'DEVI YULIANI KUSMANTO', '242510040', '$2y$12$cUcabH1nX2g8SByQ59nVkO5dHT5tNK4JojEWcAMrFi.srZGM5EYya', 'siswa', '2025-08-28 02:09:56', '2025-08-28 02:09:56'),
(304, 'DINDA LESTARI', '242510041', '$2y$12$3FNmLnVPDSobW8hXnV4oeev36GEPFsrCSduH6/Qohvplm4uBDIw/K', 'siswa', '2025-08-28 02:09:56', '2025-08-28 02:09:56'),
(305, 'ERNAWATI', '242510042', '$2y$12$KdVV4VSe91Hn9g1I0f1w0ea7.RTJybgmn.vNA4TRxfYrZEUB4M9sG', 'siswa', '2025-08-28 02:09:57', '2025-08-28 02:09:57'),
(306, 'INAYAH', '242510043', '$2y$12$XL7mz7i3gWzA/ELW7MpSOOBuCHNtuQ2dLbCSEk2byyXsqfnt4J4IC', 'siswa', '2025-08-28 02:09:57', '2025-08-28 02:09:57'),
(307, 'LAILA', '242510044', '$2y$12$CjqzEBRgdmRUjyY76TlVl.A/IiMlqnxybtXXQuyf0Bs.Scmv/hfiK', 'siswa', '2025-08-28 02:09:57', '2025-08-28 02:09:57'),
(308, 'LUTIKA SUNDAWA', '242510045', '$2y$12$rx./jJbKz1Z2/Jx4/.jQgewMHpxRlu0t/jQBbZzHifI1XfE7Glfd6', 'siswa', '2025-08-28 02:09:58', '2025-08-28 02:09:58'),
(309, 'MAULIDDIVA NAWWAROH', '242510046', '$2y$12$1lNjoUadgm.3YBr4ZtOM4.FwvY3HJIrTgQW3odumqxsUdLB23Oak6', 'siswa', '2025-08-28 02:09:58', '2025-08-28 02:09:58'),
(310, 'MAYA MAESAROH', '242510047', '$2y$12$OFnnt24lwjmYeAyVXXP7b.Id6a53xlq6FcV0ako2bH9VlrlQhXSem', 'siswa', '2025-08-28 02:09:58', '2025-08-28 02:09:58'),
(311, 'MELYANI', '242510048', '$2y$12$nn9j63OeuaUSUT8JJYHNhOkdHf5ZpchcUKKpST7F/H35w0.MVNctW', 'siswa', '2025-08-28 02:09:58', '2025-08-28 02:09:58'),
(312, 'MIA BIATUL QOYA', '242510049', '$2y$12$iDbu9n.Th3ZKVq6v6.wxOuaifgvKv.K7ek2ttxlFPgw2koW0cFBoq', 'siswa', '2025-08-28 02:09:59', '2025-08-28 02:09:59'),
(313, 'MUHAMMAD RAFFA RODIYANA', '242510050', '$2y$12$F.sQD5mZwNeRCaF2Urw6O.Q32vnAHF0uBi0C0UfTDgtMU/6WXDKQ2', 'siswa', '2025-08-28 02:09:59', '2025-08-28 02:09:59'),
(314, 'NAJWA FITRIA AZZAHRA', '242510051', '$2y$12$lefPjVBRLqztE/jtG8BlgO2LTObkWca5.MQO8zZhtMP3nI44Fwm6O', 'siswa', '2025-08-28 02:09:59', '2025-08-28 02:09:59'),
(315, 'NINING NURFALAH', '242510052', '$2y$12$3Ew/cOjgozEfHs46Cz4S.ejclMU8uFeg..GGWlQmEzi1tTFMoIKBe', 'siswa', '2025-08-28 02:10:00', '2025-08-28 02:10:00'),
(316, 'NORMAN HIDAYATULLAH', '242510053', '$2y$12$SAqy9HNz9dBsJ.XwlC3/Puiykm22ds27GBALrqr5732GvcCghAjQ.', 'siswa', '2025-08-28 02:10:00', '2025-08-28 02:10:00'),
(317, 'NOVI SEPTIANA RAHMADANI', '242510054', '$2y$12$QqvqnWRvvBT3Pu7yZ.oA2eLbLnclqa8MWOS2lE46pax74RNLqWlfa', 'siswa', '2025-08-28 02:10:00', '2025-08-28 02:10:00'),
(318, 'NURMALA', '242510055', '$2y$12$7B2sOQK8V43SjcRVhu4qD.C4/IyMbvTnKSGzk.7tozdlMsNm0C7AS', 'siswa', '2025-08-28 02:10:00', '2025-08-28 02:10:00'),
(319, 'PUTRI SALSABELA', '242510056', '$2y$12$nNYZ1mkVIOdferdu7gdBOuuk8rOQds3Q9Cfqe/NI46fz0bpSxZhPG', 'siswa', '2025-08-28 02:10:01', '2025-08-28 02:10:01'),
(320, 'RANI', '242510057', '$2y$12$Y4P3HD/i7nDJdeKjSOfNluZAzByd.6NGLjVONzV/U5p0MXFKYdlpy', 'siswa', '2025-08-28 02:10:01', '2025-08-28 02:10:01'),
(321, 'RIRIN EKAWATI', '242510058', '$2y$12$lJwBXLTisiIG4Cl9ZXRj0eRPNMNcKLh./94bOlRs/LkHw.3Ym0wwC', 'siswa', '2025-08-28 02:10:01', '2025-08-28 02:10:01'),
(322, 'SARASWATI', '242510059', '$2y$12$F3X2p9LYm3S.VBOaqCaIr.Mwan2pdbqWtv12aNw2sQPK.N6uKAsdy', 'siswa', '2025-08-28 02:10:02', '2025-08-28 02:10:02');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(323, 'SITI NURJAMILAH', '242510060', '$2y$12$PTnw4f1KhkSAXJxDBsmFGu3CD5WLXXTkYeECSyhHSXF8qfD9KqrMu', 'siswa', '2025-08-28 02:10:02', '2025-08-28 02:10:02'),
(324, 'WIWIN NURMAULIDA', '242510061', '$2y$12$mzD.fmxI41WfQZGBlyVrXuo88cVSNxzPGY2rRtuqrCmA8MFIRpI46', 'siswa', '2025-08-28 02:10:02', '2025-08-28 02:10:02'),
(325, 'WULAN SARI', '242510062', '$2y$12$Lm3YSm6p6l910tj507eEgONb2/5fNWb0IsdiJ.AXLH.hlQb6DeNfK', 'siswa', '2025-08-28 02:10:02', '2025-08-28 02:10:02'),
(326, 'ZAHRA AYUMI', '242510063', '$2y$12$jcTKeVwfDTMJfXO6RuDxKOUN/Ysbdj0d63ZUKYEZSO7tHx4fs29Wu', 'siswa', '2025-08-28 02:10:03', '2025-08-28 02:10:03'),
(327, 'ZAHWA AENURROHMAH', '242510064', '$2y$12$tauCcvZYt76bYpR.e0FWTumgOH0RrXlZ/.AoJpPZ7z7MZ4ZnGipmO', 'siswa', '2025-08-28 02:10:03', '2025-08-28 02:10:03'),
(328, 'ABDUL SODIK', '242510065', '$2y$12$w7PRDpMoQyxAFBs9aAl1UO52Wq3n6a9ihxKqMKCjlBXB2x0pRRTfe', 'siswa', '2025-08-28 02:10:03', '2025-08-28 02:10:03'),
(329, 'AGNAN HAMBALI', '242510066', '$2y$12$nCI5p8vxrNY13r8wlc3apOAHuCPeTPhCCAMT9.8z1ST4zw2ECsB7G', 'siswa', '2025-08-28 02:10:03', '2025-08-28 02:10:03'),
(330, 'AGUS MULYANA', '242510067', '$2y$12$ecxXpTIgp0qKp/SNuzYDIupzXucFkUutQVnq/9UVa1DLO6fELEaF6', 'siswa', '2025-08-28 02:10:04', '2025-08-28 02:10:04'),
(331, 'AKBAR DHANI', '242510068', '$2y$12$0aVUB/sZW7Sc9USDN/SnNehMQ6Be4pZT2nslT6szo8wQcKcT4pYyu', 'siswa', '2025-08-28 02:10:04', '2025-08-28 02:10:04'),
(332, 'ALDI FAUZAN', '242510069', '$2y$12$ghWe5Lck6ed7m35QJOhWCOCfty2Z2stTOIod05ABEIN3ZEavGUXxK', 'siswa', '2025-08-28 02:10:04', '2025-08-28 02:10:04'),
(333, 'ALDIEN AKBAR', '242510070', '$2y$12$EivHPgL61jObp4azVtUnFedqKQcKJg1tSzHDmiTOSSXQydvt/rsr2', 'siswa', '2025-08-28 02:10:04', '2025-08-28 02:10:04'),
(334, 'ALPI SAEPUL AKBAR', '242510071', '$2y$12$9g3/.razKE3GYxiH91NB.ex1TQ11blWe0T4uKoxGq7DVZsTKiOtM.', 'siswa', '2025-08-28 02:10:05', '2025-08-28 02:10:05'),
(335, 'ANDIKA SYAPUTRA', '242510072', '$2y$12$X6V5lKJ1YEy3oHlixDs.3uVHLblclC/Do2uI/mNHe4kCPd6A/gayW', 'siswa', '2025-08-28 02:10:05', '2025-08-28 02:10:05'),
(336, 'AYOM PRAYOGA', '242510073', '$2y$12$S/mtHrFpSNrAQ46e8.CxcuDbYoRpddogh4/8zMPC4Yf02wRxvDE5O', 'siswa', '2025-08-28 02:10:05', '2025-08-28 02:10:05'),
(337, 'CAHYONO MAULANA', '242510074', '$2y$12$jXAinA1tJCnk4HeIETSjsOF8Dk9/5uXJtELarj/BAiQlfLJabpciC', 'siswa', '2025-08-28 02:10:06', '2025-08-28 02:10:06'),
(338, 'DIMAS PRADIPTA FUDHOLI', '242510075', '$2y$12$d1fql51Kx1GyeGyyLuqtOeV5gRHng/kcFxGEvQ0l9PJe7u.c3q/5K', 'siswa', '2025-08-28 02:10:06', '2025-08-28 02:10:06'),
(339, 'EKA RAMDANI JUNAEDI', '242510076', '$2y$12$IY3m.7T3FpuXwOsglzOzBut/Xjlq4t.0EowCO7a8l2x7XUk6Sjp5K', 'siswa', '2025-08-28 02:10:06', '2025-08-28 02:10:06'),
(340, 'EVA NURAENDI', '242510077', '$2y$12$PsLg1ui7GBgAIanY.WrG/.ypgG9zIlcXZEXLKz3n.5Cf.ge1oRhy6', 'siswa', '2025-08-28 02:10:06', '2025-08-28 02:10:06'),
(341, 'GENTA TENGGARA BADAY', '242510078', '$2y$12$754djZSy6YFPGWGaRHo8peIbltFlVfdNis4wzDJi2maY8p3lhTytG', 'siswa', '2025-08-28 02:10:07', '2025-08-28 02:10:07'),
(342, 'INTAN NURJANAH', '242510079', '$2y$12$xRQOi5GlhOkzxoCi0bXueOwQHlQHNuroAoluLuDe1VcX2Ch318QpS', 'siswa', '2025-08-28 02:10:07', '2025-08-28 02:10:07'),
(343, 'IRPAN HERMAWAN', '242510080', '$2y$12$XpbaWkivd5tvMPP0ajVsmOI0DYAQ7VKnBxuHyQDFGnGp4b1mEvJOW', 'siswa', '2025-08-28 02:10:07', '2025-08-28 02:10:07'),
(344, 'MUHAMAD YAHYA', '242510081', '$2y$12$6jyD6e4aW4bDOmeHl29RNuADdKqZYRzfgzu6iFSw.v0q4jmASDPBK', 'siswa', '2025-08-28 02:10:07', '2025-08-28 02:10:07'),
(345, 'NABILA JULIANY', '242510082', '$2y$12$4h58nvn6APNpwUqPv12OtuWa2qZGRbfyoKKHCrGwR1AxVofZwpXzy', 'siswa', '2025-08-28 02:10:08', '2025-08-28 02:10:08'),
(346, 'RAFI MAULANA LILAH', '242510083', '$2y$12$ga4kja0UNKIhmgK5JiFTtu2NlSbSH.cVyFz/GVropBpP3Lf4F0CVK', 'siswa', '2025-08-28 02:10:08', '2025-08-28 02:10:08'),
(347, 'RAMA ALDIANSYAH', '242510084', '$2y$12$0NcjC76MB1WlxCuZzIdsjuOcgrd.PB/ZU1Obl8TkhGZLVNBsTT4Py', 'siswa', '2025-08-28 02:10:08', '2025-08-28 02:10:08'),
(348, 'RAMA HERDIANSYAH', '242510085', '$2y$12$weZ.noNcN9rhaA4p1ErF0Oc3QGrBA6dgxKMJp.plPPzpMftZ9yvd.', 'siswa', '2025-08-28 02:10:09', '2025-08-28 02:10:09'),
(349, 'REDI', '242510086', '$2y$12$DOJtwVqZ3ffnF0Smv8IGkeiaQ.NmaeJ6n78xapAWPvBU/g3OvtA..', 'siswa', '2025-08-28 02:10:09', '2025-08-28 02:10:09'),
(350, 'REGIA NANDA FEBRIATAMA', '242510087', '$2y$12$cBzyvG7wpkIOZ/qroe6gmu4uZHzq5j0/xfhsDX455LadvnqaRPtvS', 'siswa', '2025-08-28 02:10:09', '2025-08-28 02:10:09'),
(351, 'RIFKI MULYANA', '242510088', '$2y$12$LXXIV30QvBwUBJl.gLpo1uPTZ9HD3yhD1zSDfRerFIxyif6qtiMnG', 'siswa', '2025-08-28 02:10:09', '2025-08-28 02:10:09'),
(352, 'RIZKY ADITIYA', '242510089', '$2y$12$9O.AXdPr7/lAsp5gLi7aNOvlOl0BaxF1weMcuXSdsisp1NYsTJuWe', 'siswa', '2025-08-28 02:10:10', '2025-08-28 02:10:10'),
(353, 'RIZKY AZIZ MAULANA', '242510090', '$2y$12$5B5D5uOm0nWT7FRB6vfGleC.WvxV1a.3WSRP5bbjLH8wBWT8XTTnm', 'siswa', '2025-08-28 02:10:10', '2025-08-28 02:10:10'),
(354, 'SITI MARIYAM', '242510091', '$2y$12$dvsaMdeH1yLPjOfx8wiAqOWuVMND78..edv4qCaV.Ry5p4Ba0kPje', 'siswa', '2025-08-28 02:10:10', '2025-08-28 02:10:10'),
(355, 'SYAHRILLA PERMATA NUSANTARA', '242510092', '$2y$12$MhtJOpPpa5Zxhr5OjclX9uIk9v2DZAEYiAe/Cb9Ak8g2os.9Ea792', 'siswa', '2025-08-28 02:10:10', '2025-08-28 02:10:10'),
(356, 'WIBY KURNIAWAN', '242510093', '$2y$12$DR0gLd7PNmNbrKm2y.6YvuKzbaMaEEmrGERFLx.YLotFCEDhM1eR.', 'siswa', '2025-08-28 02:10:11', '2025-08-28 02:10:11'),
(357, 'WIDIYA ANISA PUTRI', '242510094', '$2y$12$KUDiyirwF8x8Jcn3rs8FEe6O07b7XFVn7rghD8Pt8m8CBoBx9bUOm', 'siswa', '2025-08-28 02:10:11', '2025-08-28 02:10:11'),
(358, 'WINDY DANUARTA', '242510095', '$2y$12$OInYs9h9pQaxVSCoVq2Fz.ajaOohrHKrdkibhsdf3vQBeUd2e8.aa', 'siswa', '2025-08-28 02:10:11', '2025-08-28 02:10:11'),
(359, 'YUDI MULYANA', '242510096', '$2y$12$/WF9o3Ve4LBVfvR7.p3Pre2bgLjfEWqJbY/JezL7IOmb9d6keqsEW', 'siswa', '2025-08-28 02:10:12', '2025-08-28 02:10:12'),
(360, 'ADITTIYA SAPUTRA', '242510097', '$2y$12$wqYE46UeifuMjTJMH8a6W.xlIPnxLtb.zjqIesEBRzNyc5H/QXuiS', 'siswa', '2025-08-28 02:10:12', '2025-08-28 02:10:12'),
(361, 'AFDAL ZIQRI RAMADAN', '242510098', '$2y$12$Lm52OT.6GG4RyZA0ps5/leEac..npHTnUdMRPIFmfZ2gKvt0Ikn..', 'siswa', '2025-08-28 02:10:12', '2025-08-28 02:10:12'),
(362, 'ANDIKA EKA SAPUTRA', '242510099', '$2y$12$jV2KdOz4rPCJo1aD2rWmremnz.3gfTApD0byuUpIWp7xeAqTTxpSK', 'siswa', '2025-08-28 02:10:12', '2025-08-28 02:10:12'),
(363, 'ANGGUN RIANA PUTRI', '242510100', '$2y$12$06WocwoZrQzQalV/lkJsr.PnN8WXnNKxMMafBg8Rfr6SDiXse4LCO', 'siswa', '2025-08-28 02:10:13', '2025-08-28 02:10:13'),
(364, 'APRIZAL SUGANDA', '242510101', '$2y$12$0f02CoJ0aJcKEglyY2l4C.pazKmN.dt/TjQhbRFfddEy2D5KKCA.G', 'siswa', '2025-08-28 02:10:13', '2025-08-28 02:10:13'),
(365, 'ARDIANSYAH', '242510102', '$2y$12$qwAnj4mTnttGCNXE.gkGRODx5rW9X/X9TI/.V2W8c2v1gQOiN5Wi.', 'siswa', '2025-08-28 02:10:13', '2025-08-28 02:10:13'),
(366, 'ARIF JUNAEDI ABDILAH', '242510103', '$2y$12$vfkBg.8WaGNhi9n63AWXPuBc5f.tFoeOVz5zHv9k2ryMKEcXLBQ9q', 'siswa', '2025-08-28 02:10:13', '2025-08-28 02:10:13'),
(367, 'ASIAH NURAZIZAH', '242510104', '$2y$12$FoGeWIVT.3GGcs2JLMwi8Oyu6sB9D/DySciIPpzw6J3FFitkFG4ga', 'siswa', '2025-08-28 02:10:14', '2025-08-28 02:10:14'),
(368, 'DIMAS', '242510105', '$2y$12$/qX838lN1Hn5zTLZO9XPSeRzwxDvh7ULqHM0athLrnV3siYYtlJuK', 'siswa', '2025-08-28 02:10:14', '2025-08-28 02:10:14'),
(369, 'DIO PRATAMA', '242510106', '$2y$12$xwazhEL3x4hLlsh0qYPqTOValIIrj/sgC7Anew/DXpqkTrxfupQfm', 'siswa', '2025-08-28 02:10:14', '2025-08-28 02:10:14'),
(370, 'FACHRI MUHAMAD SOFYAN', '242510107', '$2y$12$NwtDhv4iMfqcpriQOtVmm.OppT.kIxj/IwDpYdG6Wo9.8VUVhZSa2', 'siswa', '2025-08-28 02:10:15', '2025-08-28 02:10:15'),
(371, 'FAHRI HAMDANI', '242510108', '$2y$12$TpcbqzhmOVCH7/GVhVT6pOx7snEQqagKoE5jhQJ3zTa5oLAjJjJyq', 'siswa', '2025-08-28 02:10:15', '2025-08-28 02:10:15'),
(372, 'FERRY SEM JULIANTO', '242510109', '$2y$12$meyX1TIBDXH5oD/Vwex/1u1SVLKcjGon4wouiVbBGcha57E.k8uZ2', 'siswa', '2025-08-28 02:10:15', '2025-08-28 02:10:15'),
(373, 'GUNAWAN GUNTUR', '242510110', '$2y$12$l4/CMAKPrH/f0mV5LJJ57uo1gmVsSEbU5xhkJAjQ/BB2rkUCpNlDS', 'siswa', '2025-08-28 02:10:15', '2025-08-28 02:10:15'),
(374, 'IRMAWATI', '242510111', '$2y$12$IYQW2k98wNGJgRrA5dtkwesLBpQ2JYTegQSqtaIqo7swNrz8g6HSq', 'siswa', '2025-08-28 02:10:16', '2025-08-28 02:10:16'),
(375, 'ISMAIL NURJAYA', '242510112', '$2y$12$BQ3V7Y2hsTM7VQwh12wqz.M/4HkmKdjpYusOwh1LwLgjV5qnkogtW', 'siswa', '2025-08-28 02:10:16', '2025-08-28 02:10:16'),
(376, 'LUTPIAH', '242510113', '$2y$12$vNH3fxwDaqqWJqqcWq2e8.nnAoFWkKU8mrKJsmorIu3wejy1RVMCC', 'siswa', '2025-08-28 02:10:16', '2025-08-28 02:10:16'),
(377, 'MUHAMAD FAIS', '242510114', '$2y$12$Vd0QXKEbs5e7HErv/1IjLe/LbWrurQ00esS5rykoqmBMcrbzedRL.', 'siswa', '2025-08-28 02:10:17', '2025-08-28 02:10:17'),
(378, 'MUHAMAD MUMIN', '242510115', '$2y$12$9MBqsjIiBQMTEeWigGDKt.3hEkwAdLcKWYTASaeV6Ywg3RCtHSVIi', 'siswa', '2025-08-28 02:10:17', '2025-08-28 02:10:17'),
(379, 'MUHAMAD NUSHA BADARI', '242510116', '$2y$12$oROcggDGt4Va0swV1e3mJebzEcvorgVbl0hNjdlS3cvwMpmHKt1BK', 'siswa', '2025-08-28 02:10:17', '2025-08-28 02:10:17'),
(380, 'MUHAMMAD PALESTIN', '242510117', '$2y$12$76adKE9ZSRNR5s19RmkxW.WXOrl1aH1fcFcMRGuhmdNRl9sGOg7de', 'siswa', '2025-08-28 02:10:17', '2025-08-28 02:10:17'),
(381, 'MUHAMMAD RAFFI ALFARIS', '242510118', '$2y$12$/2RzannJXM5sIua5pmlefueyPBELL7Ad66QQrhtqo.m422G8H6Unm', 'siswa', '2025-08-28 02:10:18', '2025-08-28 02:10:18'),
(382, 'MUHIDIN', '242510119', '$2y$12$i9syzxKpBs6QIquNYOYKX.6R/Qwbkf2P30cP6MiKc0AbZXgLySUqe', 'siswa', '2025-08-28 02:10:18', '2025-08-28 02:10:18'),
(383, 'NURHAYATI', '242510120', '$2y$12$hQX0wgqZOlnet.72p0d3MuYFPYD8Py3hsq4zWH.N.h5K7lhxMJfY6', 'siswa', '2025-08-28 02:10:18', '2025-08-28 02:10:18'),
(384, 'NURSIAH', '242510121', '$2y$12$IHN88lIxp1xtYWNZ3l91wecCSKVUiNwtQdZ0PG1JAj9WFd9sBRFwS', 'siswa', '2025-08-28 02:10:19', '2025-08-28 02:10:19'),
(385, 'ROHMANA', '242510122', '$2y$12$85P2XSN6DPyahqhlNCZ84.zYTJ/D0TlITX8NwPlYaYxGeHlOSkiSy', 'siswa', '2025-08-28 02:10:19', '2025-08-28 02:10:19'),
(386, 'SYARIP NASRULLOH', '242510123', '$2y$12$0LZ8yYs3.2w3RvoBW/.nTOiH3NQ.M7QAvkbG2fR.GUNCC5Jcc2UqG', 'siswa', '2025-08-28 02:10:19', '2025-08-28 02:10:19'),
(387, 'TAMAMI', '242510124', '$2y$12$Uep8HUlKouHKMDX0D4BB9O9XHPtKFkSYqmdXfAbyMy7ABBl7DVTT.', 'siswa', '2025-08-28 02:10:19', '2025-08-28 02:10:19'),
(388, 'ABDUL GANI', '242510125', '$2y$12$KSw9w3geUIrL3KFQv49ifef7JHHQHicyjGQgC5MxwDoFAatP2LqTW', 'siswa', '2025-08-28 02:10:20', '2025-08-28 02:10:20'),
(389, 'AHMAD DANU', '242510126', '$2y$12$ym9xixO3lsDFbGIzG3q2iehDcBa544hT9qwd50LmIgxD3IZsyu91K', 'siswa', '2025-08-28 02:10:20', '2025-08-28 02:10:20'),
(390, 'ALMASUL ANAM', '242510127', '$2y$12$BgEl2FTNylUxh3yud6ltd.J5XLnzyPK143ILQKYizaguZBeNm/jXK', 'siswa', '2025-08-28 02:10:20', '2025-08-28 02:10:20'),
(391, 'APRIANSYAH KARIM', '242510128', '$2y$12$DR.gqPbHf2TnyBJFyrR8Suh4DswxfbYEGoRrGVpYWWVeHEZv4Uaeu', 'siswa', '2025-08-28 02:10:21', '2025-08-28 02:10:21'),
(392, 'APRIYANSYAH', '242510129', '$2y$12$zd0KtgjmxkGIFdiFAYZK9.9.zEWMlXVu3lSIFHhI09rjAqWPHWqFq', 'siswa', '2025-08-28 02:10:21', '2025-08-28 02:10:21'),
(393, 'ARYO SAPUTRA', '242510130', '$2y$12$ZtJQDmcBG1Msp3WdelPMf.8LehE/ultP0E6QEHNF19l4/RgG1Om.2', 'siswa', '2025-08-28 02:10:21', '2025-08-28 02:10:21'),
(394, 'BELA CANTIKA', '242510131', '$2y$12$HDWpp9eR.7pqWq6HoUBGeOi8gwwyz.oxNU0eihXF3a5U0U1YYJGcG', 'siswa', '2025-08-28 02:10:21', '2025-08-28 02:10:21'),
(395, 'CASTIMAN', '242510132', '$2y$12$ZOEeutl8SS2vlnMuBJeGnuaQFKdGL1oQbzzkA8xFfn3.yN4KiI1yO', 'siswa', '2025-08-28 02:10:22', '2025-08-28 02:10:22'),
(396, 'DAVI BAHTIAR', '242510133', '$2y$12$7E0WWQXXRnYvXA9z9eS1COfcif2Yg9KNjnOTSpy3GkJwdoQk3kbMW', 'siswa', '2025-08-28 02:10:22', '2025-08-28 02:10:22'),
(397, 'DELIMA', '242510134', '$2y$12$mmu9ZqxM3Q6/hLn5BkyDb.olvWLeGihUgId55us8dbHbdmNXVvfxi', 'siswa', '2025-08-28 02:10:22', '2025-08-28 02:10:22'),
(398, 'EKO ADI SUCIPTO', '242510135', '$2y$12$IgK/KVHHCz5FI3lcTpvYl.496rQx0/MozKxnoSA5KfZsIjVBG6FEy', 'siswa', '2025-08-28 02:10:23', '2025-08-28 02:10:23'),
(399, 'IBRAHIM SIDIK JAELANI', '242510136', '$2y$12$wC3vb8JdOH4.PKd1kc7Os.N5rkHHS.CuTp6VOY9IzaaTNwK18.xBm', 'siswa', '2025-08-28 02:10:23', '2025-08-28 02:10:23'),
(400, 'ICANA', '242510137', '$2y$12$/O2yXmmbSXEvJHgQZaqx1OR36jgjRLC6VDu5Ky/nobqLUVoq0cWCG', 'siswa', '2025-08-28 02:10:23', '2025-08-28 02:10:23'),
(401, 'IRPAN', '242510138', '$2y$12$Ib8KKOvPOiiBgXeZFmH3SOTxJKJF1oWHEdDP9E9wh0Z.aE.RJURAe', 'siswa', '2025-08-28 02:10:23', '2025-08-28 02:10:23'),
(402, 'KHAILA SABINA', '242510139', '$2y$12$LV8id6VQSwD35MA5OWse8.mHrFVIZlOr0y3oDCgN.nhOk94gvHoF.', 'siswa', '2025-08-28 02:10:24', '2025-08-28 02:10:24'),
(403, 'MUHANAD ABDULHADI', '242510140', '$2y$12$wyJ0gJ.ufMYquCAplIMlYO2HMm.0VjsuC4Pgdqc3OWvrYNzZVeBRO', 'siswa', '2025-08-28 02:10:24', '2025-08-28 02:10:24'),
(404, 'NURLELA APRIYANTI', '242510141', '$2y$12$s3h03s0Esg1TRzuFH99cSum8F0Qr/.bp47Hg/x6Qkh6D2svdWkYH.', 'siswa', '2025-08-28 02:10:24', '2025-08-28 02:10:24'),
(405, 'PARIDHAH', '242510142', '$2y$12$hdcJHYbBBrTJpC65vzorQOgXn/OesxkmhsvQaLCFG.0yVK5hGgKYa', 'siswa', '2025-08-28 02:10:25', '2025-08-28 02:10:25'),
(406, 'PASA NUR PADILAH', '242510143', '$2y$12$jTNbTw7J2VoR5Wz0OYO21ObvQfZnGhnc/QwLpmtsD5q6MnODJznbO', 'siswa', '2025-08-28 02:10:25', '2025-08-28 02:10:25'),
(407, 'RAISYA ADITIA', '242510144', '$2y$12$TJ/lHcCiFE8.8nskG1hOe.kOBPt1Q3NouKvknn7VPwBevCk1RK23W', 'siswa', '2025-08-28 02:10:25', '2025-08-28 02:10:25'),
(408, 'RANATA', '242510145', '$2y$12$8Uhj0Rgyi/q.OgPspEsRlOT5HOzco0WK/vZBblMtA8/KbKKfNT8x2', 'siswa', '2025-08-28 02:10:26', '2025-08-28 02:10:26'),
(409, 'RAPI RIPANSYAH', '242510146', '$2y$12$RQNdI3HmmkCQ7b/FT9bmGuzAXBtxH6EPWUpcFE/HYhunyRLSB66Gq', 'siswa', '2025-08-28 02:10:26', '2025-08-28 02:10:26'),
(410, 'RIPAT', '242510147', '$2y$12$KHYC0sGPaRxUko4YPdOoN.0vPU31dy4ZMIJ1ZYCYFq5rD21VVf.pW', 'siswa', '2025-08-28 02:10:26', '2025-08-28 02:10:26'),
(411, 'RIZIQ ABDUL WAHID', '242510148', '$2y$12$c8.WH5VIq.KO/VyfjAfn5ufr4wUj4Oexj7AWc8N7Z01V5AawDi8v.', 'siswa', '2025-08-28 02:10:26', '2025-08-28 02:10:26'),
(412, 'SUCIKOH MAHARANI', '242510149', '$2y$12$dMLDyGk7xWPWJ7XwtBXgo.2bNN2VowWsiB0FxyNSOdZqbI/D2yn4y', 'siswa', '2025-08-28 02:10:27', '2025-08-28 02:10:27'),
(413, 'SUKARDI', '242510150', '$2y$12$onj0ykHKz3IB7In1hfJaieNESjJIDQGgrwoaxLkQ4IJ5FEfaiPsz2', 'siswa', '2025-08-28 02:10:27', '2025-08-28 02:10:27'),
(414, 'TIANI', '242510151', '$2y$12$FlcOWNMUkufkwVnUik4qcezNdPHt2TTXVmSV3Ro5cHQGPNgJPD32K', 'siswa', '2025-08-28 02:10:27', '2025-08-28 02:10:27'),
(415, 'WAHAB TAJUDIN', '242510152', '$2y$12$fLvmz76IrMwO5hgUTn7AI.a9IBSj3r5otg8i9EdeG7Fwg1Ev7zp2u', 'siswa', '2025-08-28 02:10:28', '2025-08-28 02:10:28'),
(416, 'AHMAD RIFKI RIFAI', '242510153', '$2y$12$rBUCaQux0kX61AJXiy1p2./igaXMy4xi44FHTLsBzPQHvxOyfTv/G', 'siswa', '2025-08-28 02:10:28', '2025-08-28 02:10:28'),
(417, 'ALDO PRASETYO ADAM', '242510154', '$2y$12$HJL.6/qc3PXI8GxFklabMO2Xi9Lhs0hqncBBf4WgRrCnqgxpUR6cS', 'siswa', '2025-08-28 02:10:28', '2025-08-28 02:10:28'),
(418, 'ARIS MUKTIA', '242510155', '$2y$12$krupc3wLbtVTdoKsXgBkEOLN0Vf0CkpXgwOarMHgUWKumRXPd7egi', 'siswa', '2025-08-28 02:10:28', '2025-08-28 02:10:28'),
(419, 'ARMAN RAMADHAN', '242510156', '$2y$12$JIptzobNXPGpbDs0eY3reu2zx8/TQ3qNEBQjsvgsJv/xKpSl1TIuu', 'siswa', '2025-08-28 02:10:29', '2025-08-28 02:10:29'),
(420, 'DARMAWAN', '242510157', '$2y$12$SZ9CHuXn5Tr5C4dqqxN6vuSWer58ez6bif44rGC2ca.WECjyPWhUe', 'siswa', '2025-08-28 02:10:29', '2025-08-28 02:10:29'),
(421, 'DENI HARUN', '242510158', '$2y$12$q28SFb0fnfJeIU7/1jg3h.3ECqMM2WI8rAuiPGVg2QKel9rIvtU3q', 'siswa', '2025-08-28 02:10:29', '2025-08-28 02:10:29'),
(422, 'DIMAS', '242510159', '$2y$12$5SrX4nRqhNZ43065s54EHuLA2ysUOhF78Y.Iw4dsWkNAaD2xc1T8a', 'siswa', '2025-08-28 02:10:29', '2025-08-28 02:10:29'),
(423, 'FAISAL ABDUL AZIS', '242510160', '$2y$12$jxJcs2/X/lEZBW6j85RzC.DpvSD.jzyYG/nkpbq.M3HJtNwsxBGpS', 'siswa', '2025-08-28 02:10:30', '2025-08-28 02:10:30'),
(424, 'GALIH WARDANA', '242510161', '$2y$12$MNTRBhEecY.wLa8SzoSm3.5KSY7r7m9eaS1LplEx4tCKr7F81o3.u', 'siswa', '2025-08-28 02:10:30', '2025-08-28 02:10:30'),
(425, 'GILANG PERMANA', '242510162', '$2y$12$acreMBYRYenvvup5urvxZeYCg6m00HDgKn5SaAEAafptrMopxrJe6', 'siswa', '2025-08-28 02:10:30', '2025-08-28 02:10:30'),
(426, 'HOTIMAH', '242510163', '$2y$12$gFlx9FWvlH5tKFesVlG5DOb330nkJgmWv5PhBJ.VNaYce8aGXwLGG', 'siswa', '2025-08-28 02:10:31', '2025-08-28 02:10:31'),
(427, 'ILYAS SUPANDI', '242510164', '$2y$12$BJzpZpRUIyhnGJnJv1K2zeHglOnAXDzCQi2VGChF9QgVTXhvuEcY6', 'siswa', '2025-08-28 02:10:31', '2025-08-28 02:10:31'),
(428, 'IRKI', '242510165', '$2y$12$Bk3XL9xO52lKl5MLbIi//uarqIUnfPZDSiH8qpwtZHBYh9RlW6AXS', 'siswa', '2025-08-28 02:10:31', '2025-08-28 02:10:31'),
(429, 'IRWAN', '242510166', '$2y$12$nVUES9a3/YQKv1zn2RLUo.d/cwRza5V8NjIZQvXGEjXtRvzSIrTyq', 'siswa', '2025-08-28 02:10:31', '2025-08-28 02:10:31'),
(430, 'KARDIANSYAH', '242510167', '$2y$12$0p9ly/3ORYplB/IVY2p7I.yB9UUtARlPSECl.yKt5v2cSHNM9N2qG', 'siswa', '2025-08-28 02:10:32', '2025-08-28 02:10:32'),
(431, 'MEYFHA AKILAH', '242510168', '$2y$12$O4dAQWZW6RI/CDtDtGRUdunyTA3W4thKOTe29RmMo3b7ka/RCoepO', 'siswa', '2025-08-28 02:10:32', '2025-08-28 02:10:32'),
(432, 'MOHAMAD AKBAR', '242510169', '$2y$12$uFFPjG0km.oCt/65EL1b9OfFoWVdW2YbdVoRDrGBgSMNP0qPllChS', 'siswa', '2025-08-28 02:10:32', '2025-08-28 02:10:32'),
(433, 'MUTIARA', '242510170', '$2y$12$juUuQEdYl95pXQ2kXMR7r.p15iYypoIb4bwimTHjTSax1JpFnaqvu', 'siswa', '2025-08-28 02:10:32', '2025-08-28 02:10:32'),
(434, 'NANANG ALDIANSYAH', '242510171', '$2y$12$h9qQu0Uf832l2McGHdZcweaa.dN6msB6PCd5UtPFkoIyq40a/G/gW', 'siswa', '2025-08-28 02:10:33', '2025-08-28 02:10:33'),
(435, 'PAHRUDIN', '242510172', '$2y$12$WtpnVhaMIjq.3XHaayNkceopc/NLWtyw4dq1fCVlVtBpZFxUlvcle', 'siswa', '2025-08-28 02:10:33', '2025-08-28 02:10:33'),
(436, 'SAPRUDIN', '242510173', '$2y$12$gu3uYS8fqmbCUPMPSnjhye4prSyyfldxgt9m4YPL8pJE8lJOJQXIK', 'siswa', '2025-08-28 02:10:33', '2025-08-28 02:10:33'),
(437, 'SIFAH FAUZIAH', '242510174', '$2y$12$0.Tdm43waNhFHhs8kVNUROg1HrZxHf8RZ7WxHinPqz88hfxY0uJsm', 'siswa', '2025-08-28 02:10:34', '2025-08-28 02:10:34'),
(438, 'TANIA LAURA', '242510175', '$2y$12$at6LgUNIHKGpubOJWEwsZOuj6/.HNbM6NqR0vvm56OQ2YPZA5gmFC', 'siswa', '2025-08-28 02:10:34', '2025-08-28 02:10:34'),
(439, 'TEGAR ANANDA PRATAMA', '242510176', '$2y$12$/gbeICKFKDk//Mr3CKf22ORN94HPJgjZNNo1qXnuFxX.3HOvWGSQS', 'siswa', '2025-08-28 02:10:34', '2025-08-28 02:10:34'),
(440, 'WIRANATA', '242510177', '$2y$12$ISeI0fdRncGVSwnJs4c8EOvuA54MYt62ozUBIwotQSJtacf6V12c2', 'siswa', '2025-08-28 02:10:34', '2025-08-28 02:10:34'),
(441, 'YUSUP HABIBI', '242510178', '$2y$12$cnGLHErPwolxtVnVxxSmC.sqpuqEtXuGj/ayRBdZj/kqRg2cj1/eC', 'siswa', '2025-08-28 02:10:35', '2025-08-28 02:10:35'),
(442, 'AHMAD NURACA', '242510179', '$2y$12$MXOJWxs5qEBjTN1Fa7ZAbuQtgHZGjpZ9EkdJWisKOhyV1H5NPfGN6', 'siswa', '2025-08-28 02:10:35', '2025-08-28 02:10:35'),
(443, 'ALVIAN NURFADILAH AGUSTIN', '242510180', '$2y$12$dc5K7SFZyUc8xWYW3zr5zOEd3P1DhfkOIh2ZoHMBugo1Kj2Xric1W', 'siswa', '2025-08-28 02:10:35', '2025-08-28 02:10:35'),
(444, 'CARTIKA AYU', '242510181', '$2y$12$2lSNmAZQlMu9fkSh8Bly5uiBvxY2Ce6L6AYQPnONlOcaIcFn0AT8G', 'siswa', '2025-08-28 02:10:36', '2025-08-28 02:10:36'),
(445, 'DIMAS', '242510182', '$2y$12$CzayZ1k0zhvLILdDygMo7.uzAShGausIyObXAHdbmJhzvIPkBxpBO', 'siswa', '2025-08-28 02:10:36', '2025-08-28 02:10:36'),
(446, 'DIRLY KUSUMAH', '242510183', '$2y$12$bwMLy9IpnLzqwdbxARFU9OQTbn1PWzeSfOgXyXndcPA8xAx9e1RyO', 'siswa', '2025-08-28 02:10:36', '2025-08-28 02:10:36'),
(447, 'FAISAL SETYO NUGROHO', '242510184', '$2y$12$PhKHGUTwjDyDitxoRFG3zuoMA1rOrvGE/LuvmYdKoCXwFSbwR/tPW', 'siswa', '2025-08-28 02:10:36', '2025-08-28 02:10:36'),
(448, 'FARID RIZKY RAMDANI', '242510185', '$2y$12$DyF3nUGinCfIqRBRpHjh/eMynpvuxDTaWfQ5ndZ0.784Tv3BjQ.6C', 'siswa', '2025-08-28 02:10:37', '2025-08-28 02:10:37'),
(449, 'IIN DWI DIKA', '242510186', '$2y$12$u8UIXZGpOeTI31tAee/G7.Jw0HtYKo1md.ioGi0dAH.1HwyOOG/aK', 'siswa', '2025-08-28 02:10:37', '2025-08-28 02:10:37'),
(450, 'ILYAS EFENDI', '242510187', '$2y$12$elXIn9NhI2dZLwIdeHa9hOpXHMJslOJnACoPl8Ms/ogS.jNRQIKbm', 'siswa', '2025-08-28 02:10:38', '2025-08-28 02:10:38'),
(451, 'IRWAN', '242510188', '$2y$12$K9xUM3NQXfT19uv1g0/OM.e5C.ApHZZqNg9DcLIPdHg4aPqcghrki', 'siswa', '2025-08-28 02:10:38', '2025-08-28 02:10:38'),
(452, 'JAMAL MAULANA', '242510189', '$2y$12$PZWe3jjhrzVH3sE6Foej8OIE449rA1E339DIG7V5T3JrQX9TwSLeS', 'siswa', '2025-08-28 02:10:38', '2025-08-28 02:10:38'),
(453, 'LUTHFI YANSYAH', '242510190', '$2y$12$S50tAl83nqO9Kw5vhjNkSusS7XWB1jqUsg.f5T0yJ3m0RqLT70KRy', 'siswa', '2025-08-28 02:10:38', '2025-08-28 02:10:38'),
(454, 'MUHAMAD ANDRE ALPHIANSYAH', '242510191', '$2y$12$0qrxxi1R97L/HEbxeWSLreZCEAvzJW2A6vHhI.C6itwxcwcbCSImy', 'siswa', '2025-08-28 02:10:39', '2025-08-28 02:10:39'),
(455, 'MUHAMAD BOBY FRAYUDA', '242510192', '$2y$12$.y55RBCWVojCEeF.knCAx.Lzm.UI/vcQhNKi5BbZvL0WcV5zQW48i', 'siswa', '2025-08-28 02:10:39', '2025-08-28 02:10:39'),
(456, 'MUHAMAD FAISAL', '242510193', '$2y$12$y6ehUfRk19AsYTONOqwftOjZQLgUSbCgmIInpHGbtHv5k7sEaMM/2', 'siswa', '2025-08-28 02:10:39', '2025-08-28 02:10:39'),
(457, 'MUHAMAD RAIHAN', '242510194', '$2y$12$w6R1CuqCseS22ptt16TSOOFgL2JgMMB.HnLAsw9ZDQDonCZc6hA8m', 'siswa', '2025-08-28 02:10:39', '2025-08-28 02:10:39'),
(458, 'MUHAMAD RIKI ALFATUR RIZKI', '242510195', '$2y$12$f0acgAw9B09wTDYGLq0ifujaCfHSyVANUnJ26GuZll4IvlAIqD1G2', 'siswa', '2025-08-28 02:10:40', '2025-08-28 02:10:40'),
(459, 'MUHAMAD SAUD', '242510196', '$2y$12$qF4oZWkrjWwjyiAOFKrgm.buFc97z/xw1NsE5J5r.R8lGGPE8xKq6', 'siswa', '2025-08-28 02:10:40', '2025-08-28 02:10:40'),
(460, 'MUHAMAD TIRTA RUKMANA', '242510197', '$2y$12$0EQheqrr/k/k8wIRjhAT4OkCdEbN0L0o22ZOE8.QR5QL4uzNdYPDO', 'siswa', '2025-08-28 02:10:40', '2025-08-28 02:10:40'),
(461, 'MUHAMMAD FARHAN MIFTAHUL ROJAK', '242510198', '$2y$12$m9pXHKPc9wP4ZXPtYdhxrO8he0vnr1MF/wnYG/1fhg/nbsmdEeVJu', 'siswa', '2025-08-28 02:10:41', '2025-08-28 02:10:41'),
(462, 'MUHAMMAD HASAN BASRI', '242510199', '$2y$12$ULym.DvQMjkaJL8.KEEE2OH2n3OlQGnKurHmPW119BAJY9NU4LPXO', 'siswa', '2025-08-28 02:10:41', '2025-08-28 02:10:41'),
(463, 'NAJRIL ILHAM', '242510200', '$2y$12$tPi84BFQwP2znFbnhJjhj.e31GkGRXfuIJva5J6NnPmnIFoH2dL.m', 'siswa', '2025-08-28 02:11:00', '2025-08-28 02:11:00'),
(464, 'NANANG KOSIM', '242510201', '$2y$12$Juyvna0OCls17u/CrUyf3OV9gweWe6/jR1Bh8hFT9XsMVV5p6LDaS', 'siswa', '2025-08-28 02:11:01', '2025-08-28 02:11:01'),
(465, 'RIPA HAMDANI', '242510202', '$2y$12$f6ELGP8gswDhREoNvCMQKuuS8NkkKn48dVnmaWmcv9WvZvC7sDJhe', 'siswa', '2025-08-28 02:11:01', '2025-08-28 02:11:01'),
(466, 'RIZKI AHMAD HAMBALI', '242510203', '$2y$12$RO0x73ocgFqEvYv8DX9D/u1679GbMPt/uuFKVsp2IY9uBTNSLmB3i', 'siswa', '2025-08-28 02:11:01', '2025-08-28 02:11:01'),
(467, 'SAEPUDIN', '242510204', '$2y$12$SowS0zGK6Pc09QoE2mdEG.6I3au9LDUg3DdBumdN1M..oXPHovF.i', 'siswa', '2025-08-28 02:11:01', '2025-08-28 02:11:01'),
(468, 'SAKTI GENTA AIRLANGGA', '242510205', '$2y$12$LytuknPCvpupp8T9F2gbAuwH495yMYzBlzo2JNTaAoH3QRgrnxhb6', 'siswa', '2025-08-28 02:11:02', '2025-08-28 02:11:02'),
(469, 'SASKIA MURNI ATI JUANDI', '242510206', '$2y$12$.Wx3G9aDs6kgacMSD20S1Oftg59sSSFrWwTQo.4TBEIj36DsKr0HS', 'siswa', '2025-08-28 02:11:02', '2025-08-28 02:11:02'),
(470, 'SITI HALIMAH SADIYAH', '242510207', '$2y$12$xQNEzqYap0MBg6UgT7OZgeGwpdKmQRGhJY6XAOx9mUIg4Kj5RROX6', 'siswa', '2025-08-28 02:11:02', '2025-08-28 02:11:02'),
(471, 'SODIK RIFAI', '242510208', '$2y$12$fIHKB/Q5uAG7MPcDRS/fmekfYjA.TIE7IGgFRUiyhvAEwu21w6y2q', 'siswa', '2025-08-28 02:11:03', '2025-08-28 02:11:03'),
(472, 'WIDIA RAHMA SARI', '242510209', '$2y$12$OR9dz0x59ghQqP6ibm/WY.BkDW9g3oHlt9wQK64gQaboSnbufbqvq', 'siswa', '2025-08-28 02:11:03', '2025-08-28 02:11:03'),
(473, 'WILDATUL RAHMATUL UMMAH', '242510210', '$2y$12$pCvq3LtBdPjIbeM3HvBPZuXoiK/BTp6zZLFytHzx3bHMGo02fd0XC', 'siswa', '2025-08-28 02:11:03', '2025-08-28 02:11:03'),
(474, 'AGNA FATHURROHMAN', '242510211', '$2y$12$RfmxJ2g8m5LtOUGIF8DWlekkaDaXU38H5RAlXPfKtbrK/Njwwl4rS', 'siswa', '2025-08-28 02:11:03', '2025-08-28 02:11:03'),
(475, 'ALI AHMAD DINEZAD', '242510212', '$2y$12$kw1gbyzUUn.1AEkOm6FyKO5gdX9xE27WV8YtuYuy52gwT1M9blRI6', 'siswa', '2025-08-28 02:11:04', '2025-08-28 02:11:04'),
(476, 'ALNAZRIL ANASSYAH', '242510213', '$2y$12$4BpYrMboX1.WrS5gBhShgeKeVkGh/KBk8FTUxSpbBIySnP.bZC.tS', 'siswa', '2025-08-28 02:11:04', '2025-08-28 02:11:04'),
(477, 'ANGGA', '242510214', '$2y$12$QY50PgGoKCKCVAcnoMSDiu//NJTdMIKwPOVWFn3Hs9xQ4ctE.GtaG', 'siswa', '2025-08-28 02:11:04', '2025-08-28 02:11:04'),
(478, 'DERI SAEPUDIN', '242510215', '$2y$12$ZhQeMwwC0xmbFW0rVpPRdekl5uYwPGrCzJTds2XxGlNck4scsPq.u', 'siswa', '2025-08-28 02:11:05', '2025-08-28 02:11:05'),
(479, 'DIKI PURNAMA', '242510216', '$2y$12$ce5uKVYkMsOUI1Y8NmxLo.bekVp0NaPFsj5B7xhd9hx3c8pu4umkq', 'siswa', '2025-08-28 02:11:05', '2025-08-28 02:11:05'),
(480, 'FAUZI RIDWAN', '242510217', '$2y$12$bnDkWOZ9RjIMvEFXBZAsTun0dubUe32OBKeQL3vUnXvRgZrGWxZei', 'siswa', '2025-08-28 02:11:05', '2025-08-28 02:11:05'),
(481, 'GILANG ANGGA KUSUMAH', '242510218', '$2y$12$XJ5gmN7wGh88P3hgMDoMmeN.isg732xEBb6JlQjua61oNitib6fDu', 'siswa', '2025-08-28 02:11:05', '2025-08-28 02:11:05'),
(482, 'IMARRUL UMMARA', '242510219', '$2y$12$pNDMsMQhrPcCw/3P8kUcneqj8jRnRimmXfXFf/n4szMGLEgXAClhq', 'siswa', '2025-08-28 02:11:06', '2025-08-28 02:11:06'),
(483, 'KARTOBI', '242510220', '$2y$12$BOIUerXIL8XusNOQwHsfGeBmoNPiCuiYw6b3xg8Czco0kDk8zhNQm', 'siswa', '2025-08-28 02:11:06', '2025-08-28 02:11:06'),
(484, 'MALIK IBRAHIM', '242510221', '$2y$12$7uVffOmRDhfY9cTcIoWT7.7y8vVu0SuXYzDurvLMd1bswTc0Krpze', 'siswa', '2025-08-28 02:11:06', '2025-08-28 02:11:06'),
(485, 'MARSELA', '242510222', '$2y$12$Q1QXfE/ouJevpGP2sjvfOOae2h6KBI5hF6r8hjUJqcV7TI1b34dKC', 'siswa', '2025-08-28 02:11:06', '2025-08-28 02:11:06'),
(486, 'MUHAMAD FARIS DZULFIKAR', '242510223', '$2y$12$vGzcyLqZJ0gOb2ZQvInuQOiQrBaqyEWBSgaqksnzWmFkQfJeD47Rq', 'siswa', '2025-08-28 02:11:07', '2025-08-28 02:11:07'),
(487, 'MUHAMAD REHAN BAROKAH', '242510224', '$2y$12$jCUhVysVoCK7gJJU4eiY3OisTE8YsqMGwiKrSu6Q8KcpPik/mMVBu', 'siswa', '2025-08-28 02:11:07', '2025-08-28 02:11:07'),
(488, 'MUHAMMAD RAIHAN FEBRIAN', '242510225', '$2y$12$uzIpGREP5ZF0QclWSjz5cO03NCZTD4DEk1OUaxwlJKb6rABWCG322', 'siswa', '2025-08-28 02:11:07', '2025-08-28 02:11:07'),
(489, 'RADIT RAMDANI', '242510226', '$2y$12$PNEcyyqMZ0H338S7K0SCxe/Ec10ozw8PGS/jfoFTI6xrF4AG/w4m.', 'siswa', '2025-08-28 02:11:08', '2025-08-28 02:11:08'),
(490, 'RAMDANI', '242510227', '$2y$12$IXHwK3H74fXQsC3jNstmSO2FrZIWcIYtFXNU0dzPDYtscJcUhGIeK', 'siswa', '2025-08-28 02:11:08', '2025-08-28 02:11:08'),
(491, 'REHAN MAULANA RIZKY', '242510228', '$2y$12$LyLLZV/1AZPhSmi.ODAxnOVKIjw38BmB8CwG/wcuS3sIXWbUXPqiO', 'siswa', '2025-08-28 02:11:08', '2025-08-28 02:11:08'),
(492, 'RENO APRIAN', '242510229', '$2y$12$MUtVWdIGs1HGcV5HuPfuauKnH8nyh8Hfz0JeSIWn0rx5WNi4mrVW2', 'siswa', '2025-08-28 02:11:08', '2025-08-28 02:11:08'),
(493, 'REYSSA PRIYUNITHA IVANA', '242510230', '$2y$12$LrcGgQ5soV18cPBs6PjWgex/r4/0Ui1mX2zq7qkpM3TWg4ZUwDSmC', 'siswa', '2025-08-28 02:11:09', '2025-08-28 02:11:09'),
(494, 'RIZKI', '242510231', '$2y$12$3PRArOfSBtZAtfheGnjfdeUuBXeIsTSTPPaUqw9sWrHP.Cmc.eqpm', 'siswa', '2025-08-28 02:11:09', '2025-08-28 02:11:09'),
(495, 'SRI ANGGRAENI PEBRIANTI', '242510232', '$2y$12$EzEG46eKq1av0oEmypfN2uQ5mCgBVfvNbqvfgRu7wfB/8BSeOdBV2', 'siswa', '2025-08-28 02:11:09', '2025-08-28 02:11:09'),
(496, 'TASYA', '242510233', '$2y$12$7lKc6vy.T5Yv.KWvxKNFdeyPTCvpoRCXnKe5SIfzJJbVTGE7d3hES', 'siswa', '2025-08-28 02:11:10', '2025-08-28 02:11:10'),
(497, 'TAUFIQ HIDAYATULAH', '242510234', '$2y$12$K7Nvj3XROLSJeFyj8pfGUuvi6XUatn3Yih/ctEgQNxuK3nA0sREnK', 'siswa', '2025-08-28 02:11:10', '2025-08-28 02:11:10'),
(498, 'TRISTANTO', '242510235', '$2y$12$GCtmNaOfW4yWQsfDwE3rD.Xu8Wt5gKtUyVhDbCQPpdkK7HB1YZfc6', 'siswa', '2025-08-28 02:11:10', '2025-08-28 02:11:10'),
(499, 'WHILDAN SYAHRIZAL WAHYUDI', '242510236', '$2y$12$9wda9h/PqZkFrZJU0qFvoeyYOQQRpQxkukgDtc5b8G7Gcfu8CljvS', 'siswa', '2025-08-28 02:11:10', '2025-08-28 02:11:10'),
(500, 'ABDUL AZIS', '242510237', '$2y$12$cpsM5NrNRTHjUHsxaryGhO.yzKz495inXUM8XdfS555N2UvKs5MaS', 'siswa', '2025-08-28 02:11:11', '2025-08-28 02:11:11'),
(501, 'ABDUL RAHMAN WAHYUDIN', '242510238', '$2y$12$3urcGPtTyWLJTBvb5UxxLOvrKbuitY7sl2qDbx6f4C6dK.54qKReq', 'siswa', '2025-08-28 02:11:11', '2025-08-28 02:11:11'),
(502, 'AHMAD FANANI', '242510239', '$2y$12$WDNqV6vjXbLs5w0CrnUwRu5P27qZfqt5aAa65QgTgPKSyR.XjboKi', 'siswa', '2025-08-28 02:11:11', '2025-08-28 02:11:11'),
(503, 'ALFA NURHIKMAH', '242510240', '$2y$12$wh7hptxUZ7iBrZNyTcNVBOG/uf4BMvKTHvTNnDRhAhtUMeBfIn1m6', 'siswa', '2025-08-28 02:11:11', '2025-08-28 02:11:11'),
(504, 'ANDRA PURNAMA', '242510241', '$2y$12$0KHxGVOFJuawCfFGzNXGFOSQtpKpOU3z.glzka32mDgp5K1ywyoW6', 'siswa', '2025-08-28 02:11:12', '2025-08-28 02:11:12'),
(505, 'ARINO ARDAN ARUBETH', '242510242', '$2y$12$F853rv3yj8d0yQP10RB9LuDVg2HkFt.o/veRnMUclmKvBo9.c1DdS', 'siswa', '2025-08-28 02:11:12', '2025-08-28 02:11:12'),
(506, 'CARSIYAH', '242510243', '$2y$12$xNHK/HPI9D137zLk05QsA.WooR2gUSgZYAoPHp8XZTbwAZJIvPFRS', 'siswa', '2025-08-28 02:11:12', '2025-08-28 02:11:12'),
(507, 'CHICI NURSELA', '242510244', '$2y$12$0WTLenPvFbXFXiaMg2JdnuXKkJcjQntYqTBUgiFbI/jC6EQn5Ig1G', 'siswa', '2025-08-28 02:11:13', '2025-08-28 02:11:13'),
(508, 'DALAL IRWANSYAH', '242510245', '$2y$12$Ak7gUxe9xMyRh64u.vtWqeEMDXapKerisKUWSwEh1e8UceJ42Q36.', 'siswa', '2025-08-28 02:11:13', '2025-08-28 02:11:13'),
(509, 'DODO WIJAYA', '242510246', '$2y$12$YDxdgwqhAQOuTEXp1o/Wce2dEnLBNWFgBTKVsSlux2w/Jp3k7DjyC', 'siswa', '2025-08-28 02:11:13', '2025-08-28 02:11:13'),
(510, 'ELI HAYATI', '242510247', '$2y$12$0S7ye3ouIuVe3hiR0T48xu.rAYAP3JDJWfKAm8O5fLC5hZs0DNOfe', 'siswa', '2025-08-28 02:11:13', '2025-08-28 02:11:13'),
(511, 'INDRA', '242510248', '$2y$12$HDoRCBPkoQ9RO9vyJ77EFuU9CxHABvwsc2DOenoi7Sara6twEgvQ2', 'siswa', '2025-08-28 02:11:14', '2025-08-28 02:11:14'),
(512, 'LAILA SAFITRI', '242510249', '$2y$12$F0MYrXDqnCviYVCMOFCfC.tH4ws.cDA.klu41aYzRZ9QCC8o9N606', 'siswa', '2025-08-28 02:11:14', '2025-08-28 02:11:14'),
(513, 'MAESAROH', '242510250', '$2y$12$bL.AE94XaTCSRIvMr9M9TuV20CxPPUhXaRQoc12m/A8tMSxIvJDrW', 'siswa', '2025-08-28 02:11:14', '2025-08-28 02:11:14'),
(514, 'MUHAMAD RASYA RAMADHAN', '242510251', '$2y$12$L.louYAVaMORhY1tNEqhuOIUDO5Eeli5wgZar.L3J4w0UH6B1UOEa', 'siswa', '2025-08-28 02:11:15', '2025-08-28 02:11:15'),
(515, 'MUHAMAD WAKAB', '242510252', '$2y$12$aUenp4W4aHVlFgnYuBi7BelhaLdkXoviZoxzFelelZTVJQG5.Q7B6', 'siswa', '2025-08-28 02:11:15', '2025-08-28 02:11:15'),
(516, 'MUHAMAD WAKUB', '242510253', '$2y$12$K9WnyPgs314qwU01Qb9Vhelrci49UewUqE1y2YQOFedwCoX7y7mO6', 'siswa', '2025-08-28 02:11:15', '2025-08-28 02:11:15'),
(517, 'MUHAMMAD RIDO RIDWANULAH', '242510254', '$2y$12$ld1iOxOwUsGW3XGLyYgmSe.tHWtzP/3XzmoInFIXfjbtzSOF1LazO', 'siswa', '2025-08-28 02:11:15', '2025-08-28 02:11:15'),
(518, 'NAJRIL ILHAM', '242510255', '$2y$12$2RvJTDRmu.aR5ldW3CKwu.PwtBLcuGoiRsbxiHyblsDEaDrJsuP8e', 'siswa', '2025-08-28 02:11:16', '2025-08-28 02:11:16'),
(519, 'NIA RAMADHANI', '242510256', '$2y$12$tNXqrhSkw4Ca04CnwBIinuLZvxNhiuu5gxT9wJuQn.jVV2tMmTcBq', 'siswa', '2025-08-28 02:11:16', '2025-08-28 02:11:16'),
(520, 'RANGGA ARDIAN', '242510257', '$2y$12$NmSDtI28Dn0LXURe1ddrYOM4Zn/nnL7n4i17p3UzfDQl17c0ILwk6', 'siswa', '2025-08-28 02:11:16', '2025-08-28 02:11:16'),
(521, 'RIZKI MAULANA', '242510258', '$2y$12$.nZbPcQBDXMHS7hDtAJHVOdLfBTOqfKVo/6w7/bOtYXbnqWuYCdum', 'siswa', '2025-08-28 02:11:17', '2025-08-28 02:11:17'),
(522, 'SOPIAN GUNAWAN', '242510259', '$2y$12$F68tRKjR1spBzoweGfoE9uoMGmEMmvxA4sMq9EfwkSGxPnvrub.8G', 'siswa', '2025-08-28 02:11:17', '2025-08-28 02:11:17'),
(523, 'SUPRIYATNA RAMADAN PRASTIYO', '242510260', '$2y$12$35o1dUekYFrJ/27aNP2qQOz0NfxZc0il1oP82uXGmlj/3Rg26Ra0q', 'siswa', '2025-08-28 02:11:17', '2025-08-28 02:11:17'),
(524, 'VICRY APRIANSYAH', '242510261', '$2y$12$Nx5G5whHRIOeHsfTZoO5w.49QQlSlAv1zudV7uetgRGoIVUHAuVh2', 'siswa', '2025-08-28 02:11:17', '2025-08-28 02:11:17'),
(525, 'WANA MAULANA', '242510262', '$2y$12$/HAF8pBLeukCEdDWHGZ2H.u3lQ/SoK3ofpqrzqrJpqInItmsx9lwG', 'siswa', '2025-08-28 02:11:18', '2025-08-28 02:11:18'),
(526, 'WIRA ATMAJA', '242510263', '$2y$12$VSg6oKQzjOOhrq5F2B6oB.V7txdt8Xa/US3lLlP1Q30SZ1XB5rjOW', 'siswa', '2025-08-28 02:11:18', '2025-08-28 02:11:18'),
(527, 'YUDA PRATAMA', '242510264', '$2y$12$6Myg1ajVnvLVK.lH5.D1rOLa/cpeoS7QeOp5rsKCcwxUXk/vudwoq', 'siswa', '2025-08-28 02:11:18', '2025-08-28 02:11:18'),
(528, 'AISAH', '232410001', '$2y$12$GsfGeT0hJ1S3MbINyHZY6esSq4B07/UVh7L2pzL01pSuppcIjGZ0W', 'siswa', '2025-08-28 02:11:25', '2025-08-28 02:11:25'),
(529, 'AISAH FITRIYAH', '232410002', '$2y$12$xn1/ZsEVC1FxUeBc7JOnKeMvuvumvbWNF0dRSBZFJcdkkDN0.J9ny', 'siswa', '2025-08-28 02:11:25', '2025-08-28 02:11:25'),
(530, 'ALDI REPALDI', '232410003', '$2y$12$1AeJaNME4PdLOvpVU4F8/OT7VZFHXSOwaZogUtKOAHLEL6IvNdq1S', 'siswa', '2025-08-28 02:11:25', '2025-08-28 02:11:25'),
(531, 'ANISA TRI WAHYUNI', '232410004', '$2y$12$wZVVjCNeo0GIkmNXKCb0i.N4cLMZsXABAhnEr6Y4jYr1DoAw90.yu', 'siswa', '2025-08-28 02:11:25', '2025-08-28 02:11:25'),
(532, 'AYU ARISKA', '232410005', '$2y$12$HY4ja5M7z.cF5plZlalOAOBt.RGMyc8zHU23zjGnYJGdjXj/.EJaG', 'siswa', '2025-08-28 02:11:26', '2025-08-28 02:11:26'),
(533, 'DEA AULIYA', '232410006', '$2y$12$lmZEdZwyHEOZVEL1oRc39OdemWERVq9dZD6BSvKF0AH.29SwHrAES', 'siswa', '2025-08-28 02:11:26', '2025-08-28 02:11:26'),
(534, 'Dedeh', '232410007', '$2y$12$OSHsvVcz.xU.wdV6dfURF.rTQA97fk3QAqIPUYVzMoeH0AOOdqsY.', 'siswa', '2025-08-28 02:11:26', '2025-08-28 02:11:26'),
(535, 'Entin Julyani', '232410008', '$2y$12$OKLa9jo0H7eG4Mor5BcpH.lG3wZV9w1Obxhcdd.SeUd6x2TmNq70G', 'siswa', '2025-08-28 02:11:27', '2025-08-28 02:11:27'),
(536, 'HALISA HUMAIRA', '232410009', '$2y$12$Y6aNrkcFp1Cw65j9ceFipuO5TiIlod8ZbJfusGJX59LWlNmmBeZ9q', 'siswa', '2025-08-28 02:11:27', '2025-08-28 02:11:27'),
(537, 'HANIPAH PAUJIAH', '232410010', '$2y$12$YcdNYCF67q879yR8pnhv0.NPsWQvPIYXn2k1/RG4XI0wIVLYWA2kC', 'siswa', '2025-08-28 02:11:27', '2025-08-28 02:11:27'),
(538, 'HASBY MAHEZA', '232410011', '$2y$12$8Osqsk9jMzILUpKG7VXW..5zUsPLKM5LcHPv.vcal/deVGvhgWHNu', 'siswa', '2025-08-28 02:11:27', '2025-08-28 02:11:27'),
(539, 'INTAN AOLIA', '232410012', '$2y$12$4pfWW9hZ87.2eBviPPNAu.YOQ1LgTYwn.smWLIST1lAtcHtrC8znO', 'siswa', '2025-08-28 02:11:28', '2025-08-28 02:11:28'),
(540, 'INTAN NURAINI', '232410013', '$2y$12$ukDqW0BkQsuDk6/R4GpVcO48m0iWfpL/B1m50pt75vCreCVKFcIPK', 'siswa', '2025-08-28 02:11:28', '2025-08-28 02:11:28'),
(541, 'IRMA SULISTIA', '232410014', '$2y$12$02YwWtrUUl/01eDhvSBZ8.6P9TbOoiaI0RXsdfxuuS8rGHfF3aPIq', 'siswa', '2025-08-28 02:11:28', '2025-08-28 02:11:28'),
(542, 'JAHRATUSSYITA', '232410015', '$2y$12$DWEVfLG4UB3/Sdv.743KRuCqmRrUUIsHscc2OOZh5TvtHmQGp8zG2', 'siswa', '2025-08-28 02:11:28', '2025-08-28 02:11:28'),
(543, 'JIHAN', '232410016', '$2y$12$epHfFYBP6hnjrekeKDew8uqgMKuWF8MiVwyuN4SQG6Wqo7G5cViJS', 'siswa', '2025-08-28 02:11:29', '2025-08-28 02:11:29'),
(544, 'KURNIA FEBRIANTI', '232410017', '$2y$12$0y.42hFVEF6mcMGbpMrs.eIa8QT/zf6OcZC.ehNEJijL0VutdEVd.', 'siswa', '2025-08-28 02:11:29', '2025-08-28 02:11:29'),
(545, 'LALA PADILAH', '232410018', '$2y$12$qHEouSDImfl3CDgt5YmTzub2wQZejx/0mc.vqzi9C6pH.J8p3CKLi', 'siswa', '2025-08-28 02:11:29', '2025-08-28 02:11:29'),
(546, 'NOVITASARI', '232410019', '$2y$12$uKUBwF8tOFYoAx7bIJDjJu4ar7rx0dRYP6ko0y3Ka/lEpVgR.rFhG', 'siswa', '2025-08-28 02:11:29', '2025-08-28 02:11:29'),
(547, 'NURLELAH', '232410020', '$2y$12$vVMDptOYnyWiNBFPxdyJRe4fGnDTufhRDNBrYpVobbvQ3eqBavLFm', 'siswa', '2025-08-28 02:11:30', '2025-08-28 02:11:30'),
(548, 'NURUL FARHAH', '232410021', '$2y$12$SR.wf6ACKcgIRnI8K0Yy1.ERGoDDyuaGla79NZ8Kx2xz.UgHoBtoa', 'siswa', '2025-08-28 02:11:30', '2025-08-28 02:11:30'),
(549, 'RAHMA AULIA AGUSTIN', '232410022', '$2y$12$jxoDhn931i8AwazqAFCU4.m8IGKDbF5xCCjITbsjZ/49LqYBC.0N6', 'siswa', '2025-08-28 02:11:30', '2025-08-28 02:11:30'),
(550, 'RIYAN', '232410023', '$2y$12$9cFx3tRvSEjvMr8OXwOJ.uaD3UuxzKExrnQFy/ZXt/rsMqkX.VbHS', 'siswa', '2025-08-28 02:11:31', '2025-08-28 02:11:31'),
(551, 'SINDI ARISKA', '232410024', '$2y$12$Is8zZn9QsbWZ/744EsD67./hQELtwd8185KT/gjUskXmiDPW31CLS', 'siswa', '2025-08-28 02:11:31', '2025-08-28 02:11:31'),
(552, 'SITI NURAENI', '232410025', '$2y$12$MWnujQDbylZy644yC0lhteNVsv9mVXcDKT.b4DsZpbYDUMOOGnKP2', 'siswa', '2025-08-28 02:11:31', '2025-08-28 02:11:31'),
(553, 'TRI NOVITA SARI', '232410026', '$2y$12$A5U/w0ppX2lQuD75YeexKedl62QFc6h2DstsTLMwjJjchQJts8I.q', 'siswa', '2025-08-28 02:11:31', '2025-08-28 02:11:31'),
(554, 'ALVIANI', '232410027', '$2y$12$oR5UxsrIe3j.dN4Yoxqwl.xL2HoqmRCljhKMNRpGSsZfcx7vn/nWu', 'siswa', '2025-08-28 02:11:32', '2025-08-28 02:11:32'),
(555, 'DECA LESMANASARI', '232410028', '$2y$12$dZAFvAcPyczJsqJYZcUMy.xNVi.u.pDubx7A0WGwxRp8bqe6fL7hW', 'siswa', '2025-08-28 02:11:32', '2025-08-28 02:11:32'),
(556, 'GINA HERAWATI', '232410029', '$2y$12$ryavio4DLe7CufjreCVAzuvSgqaUWvDcPD5SIjro.XLBQGCQh83by', 'siswa', '2025-08-28 02:11:32', '2025-08-28 02:11:32'),
(557, 'INDI LESTARI', '232410030', '$2y$12$58Wrxqp0gQXIlzDZRgnJ2ePEMDTiig69hRuojatu1dLCDzd9HDUam', 'siswa', '2025-08-28 02:11:32', '2025-08-28 02:11:32'),
(558, 'JENY SAFIRA', '232410031', '$2y$12$6a3cOZas5D6cj3JiME0TrOrByBufq059pDn.qXAHwitakmRqdnrOW', 'siswa', '2025-08-28 02:11:33', '2025-08-28 02:11:33'),
(559, 'KHILDA SYAFA`AH', '232410032', '$2y$12$/0FPvXtk6x0uGZRyjdOe.ulJvDkpKKvuBuFvxKIDfpEsKISEGhqka', 'siswa', '2025-08-28 02:11:33', '2025-08-28 02:11:33'),
(560, 'LAELA', '232410033', '$2y$12$mYATAMLwtmt0AwQebEdBJOPKg3Tq1E.ct7UiUQosmG8Tv8LBRlUm6', 'siswa', '2025-08-28 02:11:33', '2025-08-28 02:11:33'),
(561, 'NAILA ADZKYA MAULA', '232410034', '$2y$12$IfF41B/dgKjfQwW7gPOu5O24BiPnxcmO.vIfgAb6ATTYMAznHX8dW', 'siswa', '2025-08-28 02:11:33', '2025-08-28 02:11:33'),
(562, 'NAJWA', '232410035', '$2y$12$YCgfC/XtFut7vitkSmxU3eLRZDTAPq5ZDYmvJxIDGOSbQjs/u9sbS', 'siswa', '2025-08-28 02:11:34', '2025-08-28 02:11:34'),
(563, 'NARSIH', '232410036', '$2y$12$O0eHgiHehN0et2Vcp6KiAOCRgySdhN1uPUH6L7sE2YrJvTWWeMdvK', 'siswa', '2025-08-28 02:11:34', '2025-08-28 02:11:34'),
(564, 'NIKEN RIZKIA NINTIAS', '232410037', '$2y$12$4cjz8H9tA78XrQ4yHpDyBuqVB6k3CeyqBYncMe84E2yFjGHSg6B/u', 'siswa', '2025-08-28 02:11:34', '2025-08-28 02:11:34'),
(565, 'PUTRI JULIANTI LESTARI', '232410038', '$2y$12$vQm1TrE8Ygk6HSRKWKQFJuEyH9lL6mhHHv2uvPS1cbMj695PJ7gYa', 'siswa', '2025-08-28 02:11:35', '2025-08-28 02:11:35'),
(566, 'RAHMAWATI', '232410039', '$2y$12$ymkRgCVBJLH61ewXkvjfBuYdxDnqqu/e1fWE61WwrxU7gPLIHFCoC', 'siswa', '2025-08-28 02:11:35', '2025-08-28 02:11:35'),
(567, 'RATNA DEWI WULAN SARI', '232410040', '$2y$12$1s.GZwAh2fyGXJV8ds.9Su9jA3QL6kBEIfqHw9wBLcMT21Qfn0J/y', 'siswa', '2025-08-28 02:11:35', '2025-08-28 02:11:35'),
(568, 'REFFA AMELIA', '232410041', '$2y$12$29Zq0GnhCRPd1XUOV0UzhOlSjEzal6wkbM0L4iQFtepE2.PLE3b4e', 'siswa', '2025-08-28 02:11:35', '2025-08-28 02:11:35'),
(569, 'SAWI', '232410042', '$2y$12$1RBgV6H01J7ng0U1OQanDeKEvzi3UKxDS7NPNemjHm7RUyqis3eM.', 'siswa', '2025-08-28 02:11:36', '2025-08-28 02:11:36'),
(570, 'SEPTIANI', '232410043', '$2y$12$PLmpamNr60Uv/xkmeeO7r.uJScgVkqcUeH6..czNfeYOYPJbtM.US', 'siswa', '2025-08-28 02:11:36', '2025-08-28 02:11:36'),
(571, 'SITI HILDA MAESAROH', '232410044', '$2y$12$6a.PAXwYTc6QZDcY4RNIN.EuNz4DyDXydD66T2LLyIc28k4zdbITy', 'siswa', '2025-08-28 02:11:36', '2025-08-28 02:11:36'),
(572, 'SITI SOVIYAH', '232410045', '$2y$12$XKOoTVzy6x8Q9k784XwTUe2Cdzk7ssr8YJ5NFv162JmcCuNjYG7du', 'siswa', '2025-08-28 02:11:36', '2025-08-28 02:11:36'),
(573, 'SITRA ADILA', '232410046', '$2y$12$7XFbadB29VLoeixYWB100.tSwmPZk2sMdsIE1wV484c4nHiPxJJIa', 'siswa', '2025-08-28 02:11:37', '2025-08-28 02:11:37'),
(574, 'SRI NURHAYATI', '232410047', '$2y$12$YCD5Eg0uh8wSYC3ot.wHROU2XzyrYdQ5v3vg7ax6HSB.kdm1ra0tm', 'siswa', '2025-08-28 02:11:37', '2025-08-28 02:11:37'),
(575, 'WARI', '232410048', '$2y$12$i8AfcPGhOeOoRikf2isvSeR4xHJazfyyJ5h/SkZeSzRkuWm.EhOSa', 'siswa', '2025-08-28 02:11:37', '2025-08-28 02:11:37'),
(576, 'WULAN NURUL ARIFAH', '232410049', '$2y$12$tuUH69on3A9qWBNBCzrkn./SYweMRIybAWLuroCQd1yazMSc1L0TK', 'siswa', '2025-08-28 02:11:38', '2025-08-28 02:11:38'),
(577, 'YUSTIKA DEWI', '232410050', '$2y$12$xmPwU1oXoCl.7/23tINeNerQJYJH34cOQFfTrcHzkZYDU2qdBYPM.', 'siswa', '2025-08-28 02:11:38', '2025-08-28 02:11:38'),
(578, 'ZAHRA NURI SURYA', '232410051', '$2y$12$YAXobsQ.y8OBY8QcdN2KvOHO5mFC3Z1OzEai4HYSeT71qfpt6/9C2', 'siswa', '2025-08-28 02:11:38', '2025-08-28 02:11:38'),
(579, 'ADAM PRIAMUGA', '232410052', '$2y$12$CcHCUGOEX2KJbxMXz9sCU.apMsbUfXMjK1FIZ2rc.8UEJt2n3KKqC', 'siswa', '2025-08-28 02:11:38', '2025-08-28 02:11:38'),
(580, 'ADARSONO', '232410053', '$2y$12$qgNdLHkTIcVqmDWyfbWET.CDc5x6gvOe3L.BGAv0za6ttTXDntCFS', 'siswa', '2025-08-28 02:11:39', '2025-08-28 02:11:39'),
(581, 'AFAHRI SATYA ABDUL', '232410054', '$2y$12$1XV4PoIKvK1LZD69fVMe0u.FaNTsebA.Cf4vbsxNcMzsMT4G3cIAG', 'siswa', '2025-08-28 02:11:39', '2025-08-28 02:11:39'),
(582, 'AHMAD RIZKI ADITIA', '232410055', '$2y$12$8G0dw7iaBfVBtOoMl8M29OL1zlrMamti5yQ76gjVTRpb4ZqwUvHwK', 'siswa', '2025-08-28 02:11:39', '2025-08-28 02:11:39'),
(583, 'AHMAD RIZKY AL MAHMOD', '232410056', '$2y$12$tNWF.GAJ98a5eaeFUVkNCuWgrRSxcqkcbjFN14nQiO0OSJiE5Kx7e', 'siswa', '2025-08-28 02:11:39', '2025-08-28 02:11:39'),
(584, 'AJI PANGESTU', '232410057', '$2y$12$MjugyYG0ep8UAJL4ytwG5O6GhkQRc.qEKm8RRY5GG45L8955rOKp.', 'siswa', '2025-08-28 02:11:40', '2025-08-28 02:11:40'),
(585, 'AKMAL KUSRORI', '232410058', '$2y$12$ETmY2hKPJWPW3rVrlwCNCef.sv12XYMKvTkUJ.7zoWe1NvfVCLbca', 'siswa', '2025-08-28 02:11:40', '2025-08-28 02:11:40'),
(586, 'ANGGA ADITIA', '232410059', '$2y$12$5BfyJehhTnpzLj779shCFufpByuqmJxm55HDkSI2LByPa.CQoY8zm', 'siswa', '2025-08-28 02:11:40', '2025-08-28 02:11:40'),
(587, 'ANNISA TUL AULIA', '232410060', '$2y$12$QRloSULaaia89tLYFKIEYedXzUwcNcDTKVPsOYMnZfafbaGBBwK0a', 'siswa', '2025-08-28 02:11:40', '2025-08-28 02:11:40'),
(588, 'AYAN SUPRIATNA', '232410061', '$2y$12$q12fjDlHfJHeX6InY28IYO0//fAN8Fwbt84JNQlgIsP.v8d3qxHum', 'siswa', '2025-08-28 02:11:41', '2025-08-28 02:11:41'),
(589, 'CACA AULIANA', '232410062', '$2y$12$KfxaYnJVMg8p4vAgqvewq.US8IbXksEzmQbBZJIPo4/05dMxKudIG', 'siswa', '2025-08-28 02:11:41', '2025-08-28 02:11:41'),
(590, 'DIKI SOMANTRI', '232410063', '$2y$12$oJEr5BTtDazXIjd6zWuyZuvRIq5VRJ3oSAAJo7IHdHbnYT/fmQmMC', 'siswa', '2025-08-28 02:11:41', '2025-08-28 02:11:41'),
(591, 'DIRGA RAGIL PUTRA RUKMANA', '232410064', '$2y$12$.DObwMQ4SIq8Xk0ILmDk7.Yl.Csc1BfiR8jS7pkJNALjYeVpSeLBa', 'siswa', '2025-08-28 02:11:42', '2025-08-28 02:11:42'),
(592, 'EVA ALEXA', '232410065', '$2y$12$OtBsUNihx33jTPbOo3hWRuIptCAc3zdbi6RHQiVVT2b1qOe4x5fqW', 'siswa', '2025-08-28 02:11:42', '2025-08-28 02:11:42'),
(593, 'FAIRUZ FIKHAR FUADI', '232410066', '$2y$12$FVzOburgyGK0xGLPQfvjB.h6/xflMs2mG/g60jJPM01HOwjkVzC0i', 'siswa', '2025-08-28 02:11:42', '2025-08-28 02:11:42'),
(594, 'FITRIYANI', '232410067', '$2y$12$wnPfUVsqUzY38O4SrfLAwO4maaT55/N2yCOSRDeKcVs7D8u.q.7OC', 'siswa', '2025-08-28 02:11:42', '2025-08-28 02:11:42'),
(595, 'HIDAYAT AHMAD SIDIK', '232410068', '$2y$12$JILB3IWUdPVSGbPDbQt9d.6Yfw4m/uEuHMeApS8Mcdi/jRX7C07vK', 'siswa', '2025-08-28 02:11:43', '2025-08-28 02:11:43'),
(596, 'IRWAN ISKANDAR', '232410069', '$2y$12$kjC0tKuI2bWm4WMCvlDvYepqcCUZ0gn6ksu5W8nl0Rkq/DLm5o8Za', 'siswa', '2025-08-28 02:11:43', '2025-08-28 02:11:43'),
(597, 'KHOERUL APANDI', '232410070', '$2y$12$fPAPU6LubUCkcEVkie7OUeNo1lNmLNwRvnBSZqeJOQzNyGn53e6jG', 'siswa', '2025-08-28 02:11:43', '2025-08-28 02:11:43'),
(598, 'KUSNATA', '232410071', '$2y$12$h0PFw1F8QRTwVzW8YwImz.gvLRIhZOxqnM2xwlLzlI9.6TbhRAE1e', 'siswa', '2025-08-28 02:11:43', '2025-08-28 02:11:43'),
(599, 'MUHAMAD EGA OKTAVIAN', '232410072', '$2y$12$6Z5RQL5QNOZ6oO2a6vhjxuCYqRFh4do4N3M7bIKdHClmPXkSGPjUa', 'siswa', '2025-08-28 02:11:44', '2025-08-28 02:11:44'),
(600, 'MUHAMAD YUNUS', '232410073', '$2y$12$./xJ/mJHx99.xsVb9.Yy4uv6I/j8BTNowr/8teY8p2nsW9CMD0Eqa', 'siswa', '2025-08-28 02:11:44', '2025-08-28 02:11:44'),
(601, 'MUHAMMAD RAMDANI', '232410074', '$2y$12$jau7dAmlrGnEADBCijeSdeuDo/e0b4YLbMwgz8zbqYGV.WxZOljS.', 'siswa', '2025-08-28 02:11:44', '2025-08-28 02:11:44'),
(602, 'MUHAMMAD RAYHAN RAMDHAN', '232410075', '$2y$12$w4bLnCKnujugSJilT51/Fuvd0gShPdVa5aUIsSz2h5M9l31kpWAIy', 'siswa', '2025-08-28 02:11:45', '2025-08-28 02:11:45'),
(603, 'RANIA NURDIAN', '232410076', '$2y$12$WqtYIK3GqrbgxlwTE6szEu3ASQ1DsRnacK3KSd3sovsFUxMVnPS5u', 'siswa', '2025-08-28 02:11:45', '2025-08-28 02:11:45'),
(604, 'ROMLAH', '232410077', '$2y$12$xJw04WRS5YyGCQ/IoONQT.RtZwT5NyzYVltfWHpeOe85yjyf.kub2', 'siswa', '2025-08-28 02:11:45', '2025-08-28 02:11:45'),
(605, 'SAAD APRIANSYAH', '232410078', '$2y$12$GZXkLRSMslT0FHb3iOps4uWTHmP7Sf2dekqtq8OvA0ZGh8uDje77q', 'siswa', '2025-08-28 02:11:45', '2025-08-28 02:11:45'),
(606, 'SANTANA WIDI BAHARI', '232410079', '$2y$12$0wfsnXvzrx5WV/RbTH2aQeVj7HT8KVQTu003KarChLzMoPVXEUdeK', 'siswa', '2025-08-28 02:11:46', '2025-08-28 02:11:46'),
(607, 'SANTI', '232410080', '$2y$12$v8XDW8BNI9/kUYOZeoiW9uRk3O1x4WJTEcfurwzLn9Xq9i4WMcWi.', 'siswa', '2025-08-28 02:11:46', '2025-08-28 02:11:46'),
(608, 'SITI PATIMAH', '232410081', '$2y$12$iDshDsc.lEVbM6Gh6jk.regzCMoaM.BwR35rIodaiGJMg6v5WwAHq', 'siswa', '2025-08-28 02:11:46', '2025-08-28 02:11:46'),
(609, 'TAHRI RAHMADANI', '232410082', '$2y$12$UR/4Ei3Q8aJPOK7JWXxQi.JRaRgPatP/0MtAlR.Y6fhusr8rBqtBW', 'siswa', '2025-08-28 02:11:46', '2025-08-28 02:11:46'),
(610, 'TANGGUH AZIZI', '232410083', '$2y$12$KklQIHurITKmlC0SHqWRCeFlyktAMQck2v0uHdkz87ZWeA4S6yaTm', 'siswa', '2025-08-28 02:11:47', '2025-08-28 02:11:47'),
(611, 'TARVIN', '232410084', '$2y$12$4Lq9BhDypqZrBDCMXPCZOe3ec7qlPpM8es7c4xZ2VcAUiFbn0bte2', 'siswa', '2025-08-28 02:11:47', '2025-08-28 02:11:47'),
(612, 'AGUSTIAN ABDUR ROFIQ', '232410085', '$2y$12$knU5tZW8pMUp/zLUi60R2OHR5C.UrsJOUevivDjkyFtjTLL75XujO', 'siswa', '2025-08-28 02:11:47', '2025-08-28 02:11:47'),
(613, 'AHMAD REKSA', '232410086', '$2y$12$TKbbFerAptiqDBU.gR0BM.XsT4GDSIB49.S64BuLXD5u.57y27j0y', 'siswa', '2025-08-28 02:11:48', '2025-08-28 02:11:48'),
(614, 'AKBAR RAMADANI', '232410087', '$2y$12$Y2aYWe4on4l/hQAu5wYodeOkBDTDFQyh8TfTs3PzkEX2eB9TyR8qm', 'siswa', '2025-08-28 02:11:48', '2025-08-28 02:11:48'),
(615, 'ANDREYAN SURYANA SAPUTRA', '232410088', '$2y$12$YVgcXXVlkbli6vvg2UfekORmscmDyePPxg4WAhSCjmUiD.mR.v7Ym', 'siswa', '2025-08-28 02:11:48', '2025-08-28 02:11:48'),
(616, 'ARIF PERMANA SIDIK', '232410089', '$2y$12$MJT7zZ3W9IQ1mB1lJC1A/.FLo7X4yP09HoAVmWhhr4wts4u1lx06q', 'siswa', '2025-08-28 02:11:48', '2025-08-28 02:11:48'),
(617, 'AYU ARYANAH', '232410090', '$2y$12$4AQpcCa1eIb4kB3PksI2L.66yQQum5Z3scraU9xmT9LMdceXoL/o.', 'siswa', '2025-08-28 02:11:49', '2025-08-28 02:11:49'),
(618, 'BUSYAERI MAJID', '232410091', '$2y$12$A3BC8fxSgntjbFJ8UGvNsumFdwiSbWnnyMimqWcAYRAm9LRrz0EAG', 'siswa', '2025-08-28 02:11:49', '2025-08-28 02:11:49'),
(619, 'CARTIWAN', '232410092', '$2y$12$Hy7XmrKiACc6gSrb6ewbUOufvG2/xfiCc1cqp0JDU40/BLvISh51e', 'siswa', '2025-08-28 02:11:49', '2025-08-28 02:11:49'),
(620, 'DAHLIA SRI RAHAYU', '232410093', '$2y$12$vm6vQ.GRgAAgzd27ZnctUO.r.nkrop7jcFPDeBWHCuNnQHZRAvOb.', 'siswa', '2025-08-28 02:11:49', '2025-08-28 02:11:49'),
(621, 'DERLY PRASETYO', '232410094', '$2y$12$B0E5E163vy6BKmwxhOPq1ezzogD67ybeNsTJVsGaHthN6vS5aT1NG', 'siswa', '2025-08-28 02:11:50', '2025-08-28 02:11:50'),
(622, 'DETIYA KUSMAYADI', '232410095', '$2y$12$Ok3uAUDK134Zie/BzyPzHOZhmy6Sa8HAZZLt11Hguj0kpujH3.RcO', 'siswa', '2025-08-28 02:11:50', '2025-08-28 02:11:50'),
(623, 'DIMAS ROHMAN SAPUTRA', '232410096', '$2y$12$DBy3ousSE9j7z24fQ/OxAuhQ1JLe4yInppRM21uzoA8eme.J7NHJi', 'siswa', '2025-08-28 02:11:50', '2025-08-28 02:11:50'),
(624, 'FAJAR FADILLAH', '232410097', '$2y$12$MdBFvmbaJLRr8JWve/6d.uEELA2ilazNGgQHk08DzmfGqmcYtVfOi', 'siswa', '2025-08-28 02:11:50', '2025-08-28 02:11:50'),
(625, 'FIKRI AHMAD MUBAROK', '232410098', '$2y$12$Dr0J6JD2d.fZh2QZ.s.fluW87DNg7CBCMKiXEBIxt2M6HXAuMQEIa', 'siswa', '2025-08-28 02:11:51', '2025-08-28 02:11:51'),
(626, 'GUNAWAN', '232410099', '$2y$12$iEPpZi.ypP64eAyfMcf3t.uk25D6l5Y73yEUYOV.S20WgUdStu1B6', 'siswa', '2025-08-28 02:11:51', '2025-08-28 02:11:51'),
(627, 'HADI HOERUDIN', '232410100', '$2y$12$PMNnddbDp/GXkkLfwqRH6ORTPVPJJDHgWngUeZ78kdjqETr40EaPi', 'siswa', '2025-08-28 02:11:51', '2025-08-28 02:11:51'),
(628, 'IBNU QODA', '232410101', '$2y$12$A26RO9alueJNdLWT2I8cyOJArIy7bc9b2.pek72e5hNR6kdIaeHvi', 'siswa', '2025-08-28 02:11:52', '2025-08-28 02:11:52'),
(629, 'IHYA ULUMUDIN', '232410102', '$2y$12$6C/ZuzdNWjzOraKx9TIpSuCekYn2Xf5JxVKybJxCCDdUCv95GBXNK', 'siswa', '2025-08-28 02:11:52', '2025-08-28 02:11:52'),
(630, 'INTAN DAHLIA', '232410103', '$2y$12$DlrgWiMFDmSClftT/DVMyeJtKOJhn579a.KR1qNljbfawzdgjnlBC', 'siswa', '2025-08-28 02:11:52', '2025-08-28 02:11:52'),
(631, 'INTAN NURAENI', '232410104', '$2y$12$.xE6FkqSf//JfEjHypVoVuowsaSgt1j0hIbSQRvwUMQ6D4XfgkHkK', 'siswa', '2025-08-28 02:11:52', '2025-08-28 02:11:52'),
(632, 'LISNAWATI', '232410105', '$2y$12$b6/BeqPE0Stqy/YB5Ri2yOYkMnhErSJGe0GrDb1ylJfVvkWr2v5S2', 'siswa', '2025-08-28 02:11:53', '2025-08-28 02:11:53'),
(633, 'MAMAN ABDUL RAHMAN', '232410106', '$2y$12$/nec5kAoTKegYXr2mQF9RulYyHyT5GqNduPfZ6vGkMhjlJsDSTKay', 'siswa', '2025-08-28 02:11:53', '2025-08-28 02:11:53'),
(634, 'MEILANI PUSPITA SARI', '232410107', '$2y$12$Ah.cT0fD0YhDT8iPXbqUS.FHjUH1sM4.hpzZPa4RZ1ZguQN96fZF.', 'siswa', '2025-08-28 02:11:53', '2025-08-28 02:11:53'),
(635, 'MUHAMAD AL NAZIB', '232410108', '$2y$12$DDC8led27Mhxv/2/FpKBbe3pkfHGJdpEj7/TitCIRJtY6wb2GQh7S', 'siswa', '2025-08-28 02:11:54', '2025-08-28 02:11:54'),
(636, 'NADIA ASMIRANDAH', '232410109', '$2y$12$xNzedIzAbodTXGKuO.fhXeOV3xQJJ30x/ijfpdmZtulRhBeQO.XLO', 'siswa', '2025-08-28 02:11:54', '2025-08-28 02:11:54'),
(637, 'NATA ADITIYA', '232410110', '$2y$12$Aa9XSAPe4DLPQ.HGmUYdo.qqtuyWrvsNUgkeRepN/jETXNR8U.JAG', 'siswa', '2025-08-28 02:11:54', '2025-08-28 02:11:54'),
(638, 'NOFITA DEWAN TARI', '232410111', '$2y$12$QuiyqZXtrqTQt8gs4lPOMeLAqioXnSRS36/Ytr0jZZl99/4pqM6I6', 'siswa', '2025-08-28 02:11:54', '2025-08-28 02:11:54'),
(639, 'NOPAL BUKHORI', '232410112', '$2y$12$yjdJ7YYdi29o7HBjV4PXzOAmJa8bQKf0G6AMTBbRbh76s2IRxF43.', 'siswa', '2025-08-28 02:11:55', '2025-08-28 02:11:55'),
(640, 'NOVIANTI', '232410113', '$2y$12$9npBDvg6rwxPc1XeeEAht.PSiD1KX2JKT3YMhpZEZrRVOPCIdxndC', 'siswa', '2025-08-28 02:11:55', '2025-08-28 02:11:55'),
(641, 'RIDWAN FADILAH', '232410114', '$2y$12$dC1oH84Yc4nFvlNgS5PLNOmO4Pi6VVnsHG7r.yvTjnrn7jLdI4H6y', 'siswa', '2025-08-28 02:11:55', '2025-08-28 02:11:55'),
(642, 'SISKA AULIA', '232410115', '$2y$12$4WrokteFsOGtR69gvlcaQ.DlpVPp19j3yGotO2gn.lu6C.UyMd0l6', 'siswa', '2025-08-28 02:11:56', '2025-08-28 02:11:56'),
(643, 'SUHENDAR', '232410116', '$2y$12$vNYdxHzwRozX7OBW8CHjyelF.me//p08R/y0kX9nWrhypSqE0nooS', 'siswa', '2025-08-28 02:11:56', '2025-08-28 02:11:56'),
(644, 'TOMI', '232410117', '$2y$12$zyOVEqovvxtzq/tjvhpG3eq6LwUQzpqSX7jIIgc1Pa/LK8ysLt4AK', 'siswa', '2025-08-28 02:11:56', '2025-08-28 02:11:56');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(645, 'WARTA', '232410118', '$2y$12$2EzwK9xWaz1LQf.R/hPr2u6pqoBl3IbCM4Cm3kqNWd4ugG4iTvhy2', 'siswa', '2025-08-28 02:11:56', '2025-08-28 02:11:56'),
(646, 'ADAM MARIANSYAH', '232410119', '$2y$12$5JddczdEyPnJ5DAYkNk1YOx1fOg2TLywaCBwo.Snh.EtGnBtFaDK2', 'siswa', '2025-08-28 02:11:57', '2025-08-28 02:11:57'),
(647, 'AJIJAH LESTARI', '232410120', '$2y$12$uTEJyUnht5kaOELpfqNM1eq4mW56kErfJGasAOsjUqRyZrsQKHuFq', 'siswa', '2025-08-28 02:11:57', '2025-08-28 02:11:57'),
(648, 'ANDRIAN', '232410121', '$2y$12$y5Wxo9llO8XvBYr7bHmrt.LkhVPkvGqOWfIXalOdNwgDzaI/V9UzO', 'siswa', '2025-08-28 02:11:57', '2025-08-28 02:11:57'),
(649, 'DENDI PRASETYO', '232410122', '$2y$12$sKxcb7T4GPofcurojEaYXOWQj4jgac7xQyhMvXw4yCUBwHnVgIVSm', 'siswa', '2025-08-28 02:11:57', '2025-08-28 02:11:57'),
(650, 'DIANA PUTRI AWALIAYAH', '232410123', '$2y$12$pi2sV./QKIy7Nxy7kEy4F.aJZsSBHn6f3zMUJmpnZN7tVjl5AzoRm', 'siswa', '2025-08-28 02:11:58', '2025-08-28 02:11:58'),
(651, 'DIFA HARIKURNIA', '232410124', '$2y$12$EyWAiponf2pdup/vL.GkbehFTe0ax0ZjXm1nLKzfsdEoY60MGhyEq', 'siswa', '2025-08-28 02:11:58', '2025-08-28 02:11:58'),
(652, 'ENAH MAEMUNAH', '232410125', '$2y$12$9qd4AaK1eRMSxKJCTj/kru/YDFsN3wkw8VZo2ZPN6RByZxuIpDIzG', 'siswa', '2025-08-28 02:11:58', '2025-08-28 02:11:58'),
(653, 'FAIQ AHMAD NAUFAL', '232410126', '$2y$12$LQYosMyhloZ9CPNoLP9dsug4ob/BD1qkYK/YILRwEjq/UyD8nheum', 'siswa', '2025-08-28 02:11:59', '2025-08-28 02:11:59'),
(654, 'FERI SOPANDI', '232410127', '$2y$12$IjtmSm.E8swrYbUI4nto4eI.HvM4gx/mXymJmGFYGAjNhxJntBrlu', 'siswa', '2025-08-28 02:11:59', '2025-08-28 02:11:59'),
(655, 'IKBAL MAULANA IBROHIM', '232410128', '$2y$12$ZzPF91SK2UtUM8BUueG.aupivoTHgDMvgUfqx9GjxhiKPRuaf.9mi', 'siswa', '2025-08-28 02:11:59', '2025-08-28 02:11:59'),
(656, 'KASMINAH', '232410129', '$2y$12$ZquyKY.MhmkMb.y6KLXxU.YSLIBMMBTAmTRqUWL4SAzleiGoN6dBq', 'siswa', '2025-08-28 02:11:59', '2025-08-28 02:11:59'),
(657, 'KATIMAH', '232410130', '$2y$12$e2843hHmt89dZlWCDAdKTu3OMtHXrv5sUUCHqqqJhjlxnBI9.Ux.e', 'siswa', '2025-08-28 02:12:00', '2025-08-28 02:12:00'),
(658, 'LIGAR', '232410131', '$2y$12$VMGRXL4nW3yVHorQGO56ZuKI9VIrpYdXA8GhpaDVUGTL./XdOznAm', 'siswa', '2025-08-28 02:12:00', '2025-08-28 02:12:00'),
(659, 'MAYA', '232410132', '$2y$12$EhbDRYMvJaYb7D.rFYIPsevsp50ScoYqHNW2FezuqoyMtA/ZETWHK', 'siswa', '2025-08-28 02:12:00', '2025-08-28 02:12:00'),
(660, 'MOH THOLIB RIVKI', '232410133', '$2y$12$GLfZVA.HY7r9QNdDUF59BOXaI7Gy9LKptN878SsaItEXlyOlZMOLi', 'siswa', '2025-08-28 02:12:00', '2025-08-28 02:12:00'),
(661, 'MOHAMAD FEBRY AULIA', '232410134', '$2y$12$54oTI1lOqX14dHk7BngqGOGXVy0J88QTGx/8pv0yPSIcG22pWJZYq', 'siswa', '2025-08-28 02:12:01', '2025-08-28 02:12:01'),
(662, 'MOHAMAD RIDWAN', '232410135', '$2y$12$NumkzVkdbf20.xpZMDBRouJW9F1OKevvwI4Kl/iOSLsA.bF6T2sEC', 'siswa', '2025-08-28 02:12:01', '2025-08-28 02:12:01'),
(663, 'MUHAMAD HAIDAR RIFAI', '232410136', '$2y$12$tyvFxXdPdIqsVI12sB.5t.ND5KfOO/lHymzbpxdHBuPNdx/aOeBGe', 'siswa', '2025-08-28 02:12:01', '2025-08-28 02:12:01'),
(664, 'MUHAMMAD WAHYUDI', '232410137', '$2y$12$BpVJ6jbMmGh9ZRJIvWccyubk1Gf7NymVlxn5md8XJFtJMTZ/GL9zG', 'siswa', '2025-08-28 02:12:01', '2025-08-28 02:12:01'),
(665, 'NADILA LIESHARTANTI', '232410138', '$2y$12$hAePFv075HwcmhpatFJ5t.onYlFyJigHWwpk0dH4gWDIUnqwRSWiG', 'siswa', '2025-08-28 02:12:02', '2025-08-28 02:12:02'),
(666, 'NARMAN', '232410139', '$2y$12$tW9EHxLLseGAmcpUYRn51.WZXaBRfaa4yi/arq1XHYW/UB3vg3bFu', 'siswa', '2025-08-28 02:12:02', '2025-08-28 02:12:02'),
(667, 'NOVA YANTO', '232410140', '$2y$12$0tvWz3FJwk02GX9E.bPlhOjiNHCn6wraE6VFeTPOLIUZrguvXvL2q', 'siswa', '2025-08-28 02:12:02', '2025-08-28 02:12:02'),
(668, 'OGI WIRAGUNA NAMRAIH', '232410141', '$2y$12$BtmuvkKdWuxIbVEo50y7Le8LDrVjevr8B9so91x0KsyIEfKFdLkDu', 'siswa', '2025-08-28 02:12:03', '2025-08-28 02:12:03'),
(669, 'PEPEN FAISAL AGUSTIAN', '232410142', '$2y$12$ovhwYxcMpRYNmP405MFnYOJTVL3v/gXLErUIp5Zp4AxwOo1EhJuau', 'siswa', '2025-08-28 02:12:03', '2025-08-28 02:12:03'),
(670, 'RAHIL TRISNA', '232410143', '$2y$12$ZoUJkuQ0wP7OVM7NZlAoa.x2xLIhknJYHwpvAU9n5.X8rRnfH1WMy', 'siswa', '2025-08-28 02:12:03', '2025-08-28 02:12:03'),
(671, 'RAMDANI', '232410144', '$2y$12$FX8QMqSHHUvAoxJ/NSQ3u.5fWoegV3z.3pY/lrlE5vrMMNUp.1RVO', 'siswa', '2025-08-28 02:12:03', '2025-08-28 02:12:03'),
(672, 'RANGGA MUHAMAD FARHAN', '232410145', '$2y$12$VEV7kEznvBwXOu6TZM.oruiBomQAnuOhYCZW.vc3nztMZC4h1HowK', 'siswa', '2025-08-28 02:12:04', '2025-08-28 02:12:04'),
(673, 'RATU AYU SARI', '232410146', '$2y$12$Tyachqwuo2kQRLqQu27bHuistC77QlqsfqCpzQ1je8u2XicyLcvbK', 'siswa', '2025-08-28 02:12:04', '2025-08-28 02:12:04'),
(674, 'RENDI SUJAYA', '232410147', '$2y$12$7S8pP7eJt0FAyl69wM/ne.A71ohhg1rRYExTY47Mhhgx556qP/lzu', 'siswa', '2025-08-28 02:12:04', '2025-08-28 02:12:04'),
(675, 'RENO AL FAUZI', '232410148', '$2y$12$Dbi.r.UjpH3ruIlndI6yVOFbWoW0t2yI.cK7IE.Ov47sBWqYQuvEy', 'siswa', '2025-08-28 02:12:04', '2025-08-28 02:12:04'),
(676, 'RIDWAN IBNU AL FARIJI', '232410149', '$2y$12$MB2itCtrkKKKXuP0bsdOMO7SinaJGfFD2xLHlwbN6T7dCwZE2pFw.', 'siswa', '2025-08-28 02:12:05', '2025-08-28 02:12:05'),
(677, 'RIFA AHMAD SOFYAN', '232410150', '$2y$12$mYm/.XGy5MnkI4fJ8r6CtOTM/lF5aV/PHHvP/42zDMJvgK1tDQn/y', 'siswa', '2025-08-28 02:12:05', '2025-08-28 02:12:05'),
(678, 'SULTAN PERMANA PUTRA', '232410151', '$2y$12$QZEKK73c81mmItftdCsC8O9ARAFw.yv4goUL3MqTHQ3.8kQWRE6uu', 'siswa', '2025-08-28 02:12:05', '2025-08-28 02:12:05'),
(679, 'SUPARDI', '232410152', '$2y$12$4dm5C02n4oH93alwf88opODlNA56MLInWOJ751H5xz.TJzXRA6JWe', 'siswa', '2025-08-28 02:12:06', '2025-08-28 02:12:06'),
(680, 'WIDIA', '232410153', '$2y$12$kHNtVIbKx6hd8LHck7mzsuY9WgRxbRtZWApeg2G7iilQ3Th/.1uVW', 'siswa', '2025-08-28 02:12:06', '2025-08-28 02:12:06'),
(681, 'ABDUL ROSID', '232410154', '$2y$12$7UK/0L8UXjflbMjdGDGFEubMOx7exxNSzqr2BQWNVddLqy/iB8FEO', 'siswa', '2025-08-28 02:12:06', '2025-08-28 02:12:06'),
(682, 'AGUS', '232410155', '$2y$12$nXFy4idUCbRGOhnkH./xmO0wOMesscrLpm2EpXPNyVcNjumDmwCuC', 'siswa', '2025-08-28 02:12:06', '2025-08-28 02:12:06'),
(683, 'AHMAD BAGIR', '232410156', '$2y$12$gmocwuFfT2Fp/nhfpuWIcO0wc4c0/CiX5XHjbFOCFudJGdcnaqIw.', 'siswa', '2025-08-28 02:12:07', '2025-08-28 02:12:07'),
(684, 'AKBAR BAIDILLAH SATORIK', '232410157', '$2y$12$bhwNmhuupTCjSHVAvCSuC.9WRxaLVG5VLyjIA5LHmnIG1PbWx2VVi', 'siswa', '2025-08-28 02:12:07', '2025-08-28 02:12:07'),
(685, 'AMIRAH YULYANTI', '232410158', '$2y$12$euewdBN0YLVGc0EDxNdTcOfDrTpke8/YWXmUtC5fDMURHIM09L7DK', 'siswa', '2025-08-28 02:12:07', '2025-08-28 02:12:07'),
(686, 'ANGGUN LESTARI', '232410159', '$2y$12$EyNxyEmIJX.pwJPCyIqJQOkrlFE7OTertq3/MdQo5CCS1dNPtnOvm', 'siswa', '2025-08-28 02:12:07', '2025-08-28 02:12:07'),
(687, 'DAHVA DERIANSAH', '232410160', '$2y$12$bQCYbCAVAfCYMU/c3fQhkeNjdm68SkOexu17K7XjK3hZII30r3.c6', 'siswa', '2025-08-28 02:12:08', '2025-08-28 02:12:08'),
(688, 'DANA MAULANA', '232410161', '$2y$12$BjYdrzl/Gj0lJktUB4Bf7.3jA3Rw9/KylOVlsSNzRcxqgbkQc8XRG', 'siswa', '2025-08-28 02:12:08', '2025-08-28 02:12:08'),
(689, 'DEA NOVITA', '232410162', '$2y$12$.KFvV53xMbM2nPZpkfeXVOxqqs0sdvMmrUrc.jhkfVE77DSvJtM3y', 'siswa', '2025-08-28 02:12:08', '2025-08-28 02:12:08'),
(690, 'ELVIRA SELOMITHA ALENA', '232410163', '$2y$12$whV/BBZJq.5ZezRlk5Qo8esMkvIh/ZrUyWxJKgqFje9FWbCzve7Wa', 'siswa', '2025-08-28 02:12:08', '2025-08-28 02:12:08'),
(691, 'FACHRY HABIBURROHMAN', '232410164', '$2y$12$sphpI7sjDSk7DPgUrhB5j.W0twCY.GEXc23yEk/F1aZeejr.6hvu2', 'siswa', '2025-08-28 02:12:09', '2025-08-28 02:12:09'),
(692, 'FEBRIAN', '232410165', '$2y$12$z2H//yZwyGkQ2i2kfMcXgukIChXULmh3/st750Tgb0Mz/jSTjPCb.', 'siswa', '2025-08-28 02:12:09', '2025-08-28 02:12:09'),
(693, 'JANE DIKE PUTRI ARIAWAN', '232410166', '$2y$12$cfmodftqLNTWVFAlsYziseGZQXryVTeN8stlDUQ5izCOzNXOsfYs.', 'siswa', '2025-08-28 02:12:09', '2025-08-28 02:12:09'),
(694, 'KOMALASARI', '232410167', '$2y$12$PR46sf0UNmwHipuju6i.tufdB1ZdjS5RmohG/SqxQWCGKgiWJFy/m', 'siswa', '2025-08-28 02:12:10', '2025-08-28 02:12:10'),
(695, 'LUVITA RAHMA SARI', '232410168', '$2y$12$O3VjnjoaNIfJFIXWEKhhR.cqttrlo4doJCYn.aAHbFjhVmAowS7va', 'siswa', '2025-08-28 02:12:10', '2025-08-28 02:12:10'),
(696, 'MAHMUD MUNANDAR', '232410169', '$2y$12$U7mdh0CwKd3bMU3Ozw.06elOyoUw4HHTkeCbcuHQ5UOiji4VszSom', 'siswa', '2025-08-28 02:12:10', '2025-08-28 02:12:10'),
(697, 'MARISA LINDA LESTARI', '232410170', '$2y$12$/Y6ibGZOYZlL5XhAwBJ8V.j80kBPxVhpyspqu8zXRHbpocHRnDAwO', 'siswa', '2025-08-28 02:12:10', '2025-08-28 02:12:10'),
(698, 'MILA SARI', '232410171', '$2y$12$RFKdKYd3VEmz6rfwWzJQFO0lwDgRum7KwFZs4RFRK9NenhlhXohbG', 'siswa', '2025-08-28 02:12:11', '2025-08-28 02:12:11'),
(699, 'MUHAMAD RAIHAN GUMILAR', '232410172', '$2y$12$dTN6DlfxlGHX3f1Jb/AC7OKLLYKkuZ9UQQUI0NCIIuK4VQb7ALsNq', 'siswa', '2025-08-28 02:12:11', '2025-08-28 02:12:11'),
(700, 'MUHAMAD YUGA', '232410173', '$2y$12$MZzc5cMvOqBDN/svOrPQB.1RV6aP3zqOxi9zngYWay9JUUzdgmAxm', 'siswa', '2025-08-28 02:12:11', '2025-08-28 02:12:11'),
(701, 'RAFI ALHABSY', '232410174', '$2y$12$wKNIhsmpOlqn5bjRwfu3O.0YtjZH9IffjWqqhmpo2hny6ijLJ9e5a', 'siswa', '2025-08-28 02:12:11', '2025-08-28 02:12:11'),
(702, 'RAHMAN', '232410175', '$2y$12$R35KWElmUSdjymD.pohev.9ZA9NCReZh8OzcVOQAZftLZCCRyxa0K', 'siswa', '2025-08-28 02:12:12', '2025-08-28 02:12:12'),
(703, 'RAZAN MUHAMMAD IHSAN', '232410176', '$2y$12$k4Gh0TdJNqq3FKcCrkwYVuDm/nDsiRkKC3IZy9QAqS87rHfxEhNRm', 'siswa', '2025-08-28 02:12:12', '2025-08-28 02:12:12'),
(704, 'RIAN ADRIANSYAH', '232410177', '$2y$12$XgfuaAWYMSxhfmYDwo89Bud90XD45/O470s37bSk67pw8ic8Zvdnq', 'siswa', '2025-08-28 02:12:12', '2025-08-28 02:12:12'),
(705, 'RIAN FIKRIANSAH', '232410178', '$2y$12$OMc4ZDpoXGHD4qiVbqasEufr0GRC5gEtJwErrrrJsYU440p0ZVRCa', 'siswa', '2025-08-28 02:12:13', '2025-08-28 02:12:13'),
(706, 'RIF AN RIZIQ', '232410179', '$2y$12$w5O2GDkuJGoBttx4lHxfY.8frvd.ckHFi/xZAQVZvPJHr5yYOXqEW', 'siswa', '2025-08-28 02:12:13', '2025-08-28 02:12:13'),
(707, 'ROHMAT HIDAYAT', '232410180', '$2y$12$OD18hYT4Sy9VBwFHKVdAmOjCENr4l8QM9co6Ndk5SmahQ5ZglLs8q', 'siswa', '2025-08-28 02:12:13', '2025-08-28 02:12:13'),
(708, 'RUDITA PRATAMA', '232410181', '$2y$12$z/hrL5OkvGCTPB1BKIEV6uo.MUGDow3eO2Z2s6MNMa1cw1PwtU.J2', 'siswa', '2025-08-28 02:12:13', '2025-08-28 02:12:13'),
(709, 'SOPAN SOPIAN', '232410182', '$2y$12$jYhrzFfuEJBpfvkZ1NiyQesiKvatILi1M0YHbI0/LUSgcsLHsQ8vS', 'siswa', '2025-08-28 02:12:14', '2025-08-28 02:12:14'),
(710, 'SRI WULANDARI', '232410183', '$2y$12$eTa8xz7my.4u7FCvEbqHsePXrN4WATpoSonrId0sshNUZc/8SyZ6S', 'siswa', '2025-08-28 02:12:14', '2025-08-28 02:12:14'),
(711, 'TONI JAYA SAPUTRA', '232410184', '$2y$12$Gn4by0yzUmXKgPS.qalGIuLyJUS2/v6PUV/K2PAUmpFW8XXD5bffe', 'siswa', '2025-08-28 02:12:14', '2025-08-28 02:12:14'),
(712, 'USUP', '232410185', '$2y$12$AJJN9rfSf3W4uUg5teLbZ.nksrmZ4MUMQDRw.V67dqcGEUz7qr.CS', 'siswa', '2025-08-28 02:12:14', '2025-08-28 02:12:14'),
(713, 'WAHYU REKSA DIFA', '232410186', '$2y$12$cL5nwqpQoxG2TMfOCFtLkeuVFVw1opMSXecZIKsMOqJPToyaQP/sm', 'siswa', '2025-08-28 02:12:15', '2025-08-28 02:12:15'),
(714, 'YAYAN HERMANTO', '232410187', '$2y$12$pdr4Hy/vL05/3AOJOKi68.Et14kAcDsPtU1qZEqgXqCZPgn6XVSP.', 'siswa', '2025-08-28 02:12:15', '2025-08-28 02:12:15'),
(715, 'AHMAD FAUZAN', '232410188', '$2y$12$NhSSBkk5gyqahefDQ6XZa.lvI.6LOS3A3pxcuKZ/SwOiek8noQyaC', 'siswa', '2025-08-28 02:12:15', '2025-08-28 02:12:15'),
(716, 'AKBAR NANDA RUKMANA', '232410189', '$2y$12$7lyRCVeP.qQNDZKD6ELBLuO/2qTm/2pMhDWVcw7eZW2.hnQYNhci2', 'siswa', '2025-08-28 02:12:15', '2025-08-28 02:12:15'),
(717, 'ANGELLYA', '232410190', '$2y$12$Gts/Njn4ss680KudpZiMcO3AgvLoiyoIUQoMej.h1vpx4ccAI90VS', 'siswa', '2025-08-28 02:12:16', '2025-08-28 02:12:16'),
(718, 'APID', '232410191', '$2y$12$f4THyIYfbFsDeamGrmgaZOuHVt4nxNoYiyY6mRyebjGnFiGRqo7Ou', 'siswa', '2025-08-28 02:12:16', '2025-08-28 02:12:16'),
(719, 'DIAN MUHLISOTUL ULFIAH', '232410192', '$2y$12$jvDQKMPzWqEQtpriuHhABOwNX3qGqNqMCgdXpzrVhEKTPhEDqMf5e', 'siswa', '2025-08-28 02:12:16', '2025-08-28 02:12:16'),
(720, 'DIAN PERMATASARI', '232410193', '$2y$12$vExgZwWaK6QMKWKrr9JWn.RHQgV.kzlgD.rEQPw8O/J.974CGYEEu', 'siswa', '2025-08-28 02:12:17', '2025-08-28 02:12:17'),
(721, 'EKA PURWANA', '232410194', '$2y$12$OwEjuhpeujnZhcJM0tDV7.zrrpNf1XaU.jZAoW6pfnV6bOEZXy4NK', 'siswa', '2025-08-28 02:12:17', '2025-08-28 02:12:17'),
(722, 'FAISHAL FAKHRI', '232410195', '$2y$12$9Mzp3MIQc.NHdSnqNYUlIuihmrfgFHrIl9gHDDyO4cB8EGNW2B88u', 'siswa', '2025-08-28 02:12:17', '2025-08-28 02:12:17'),
(723, 'HADI RAHMAN', '232410196', '$2y$12$nB/wD8RGVezgPTnfprZgbePxTgQ0ksNhLc68KZyEOx1IFeeTuVFre', 'siswa', '2025-08-28 02:12:17', '2025-08-28 02:12:17'),
(724, 'INTAN', '232410197', '$2y$12$as27rnRfu8Bn0FSekhoKd.dLuUKPorsV3pYn24OfpFwY6IB3V49MC', 'siswa', '2025-08-28 02:12:18', '2025-08-28 02:12:18'),
(725, 'IRSAN TICKNO', '232410198', '$2y$12$N03AJ6aWXN.g2/hlpXOq9OO/J8ywkxd0k8lCBSzBn5GeHTHnFb1fy', 'siswa', '2025-08-28 02:12:18', '2025-08-28 02:12:18'),
(726, 'JAJANG KOSWARA', '232410199', '$2y$12$BE25.dBz565m36kUL7/kP.zsttb7RUPJuj8DaKCcPGQkuTb1ex3TG', 'siswa', '2025-08-28 02:12:18', '2025-08-28 02:12:18'),
(727, 'JIHAN HOLIYANA', '232410200', '$2y$12$0QjXb3H2yF78j/0hmp0YWOdi2zARQXmNNCqHLUlS0QmSRVmUvA17W', 'siswa', '2025-08-28 02:12:25', '2025-08-28 02:12:25'),
(728, 'MARYADI', '232410201', '$2y$12$D8O.MwWxI0TZtOlmXsRHdOBTnZ36PqkV5UiAw9euP86LiBI93xWAG', 'siswa', '2025-08-28 02:12:25', '2025-08-28 02:12:25'),
(729, 'MUHAMAD ALIN', '232410202', '$2y$12$4UhS.acn7p1xK9x/C5wEx.TY9OOMsLJ6.iOsfm0NysQ/XdOr4rqdm', 'siswa', '2025-08-28 02:12:25', '2025-08-28 02:12:25'),
(730, 'MUHAMAD RONI ADITIA', '232410203', '$2y$12$kXmAhksQZH/mpzBebLThxunC6m6qa6xd1KQZnK0718M6kTTobK24y', 'siswa', '2025-08-28 02:12:26', '2025-08-28 02:12:26'),
(731, 'MUHAMMAD REIVANDI', '232410204', '$2y$12$lSmw.37io4yeuv6Pq5vaB.O5UJJxceEcefkbxlYzdAea.rdd8D5g6', 'siswa', '2025-08-28 02:12:26', '2025-08-28 02:12:26'),
(732, 'MUKHAMAD MARUF', '232410205', '$2y$12$H.kf/nKt/8eJGDeLg33Kee9LSCywTZfIj7gIpeFOH3ULxznjTqCNy', 'siswa', '2025-08-28 02:12:26', '2025-08-28 02:12:26'),
(733, 'NURI AGUSTINA', '232410206', '$2y$12$.WFCvi/Zm9oiwe0Uid0JI.P20./z4yXQnFplOpfFx4cE4K24ah3By', 'siswa', '2025-08-28 02:12:27', '2025-08-28 02:12:27'),
(734, 'RAHMAT HIDAYAT', '232410207', '$2y$12$XnYVdDc20t27RUO4ik38g.46NRewaTMwEuUZqwfUSR7T60wvZnVBu', 'siswa', '2025-08-28 02:12:27', '2025-08-28 02:12:27'),
(735, 'RAMDANI', '232410208', '$2y$12$jT59zn6Ih28jRDdsauClMurBXfy7Y6l1Z.O8.Vp4/f3oPm30pJJdG', 'siswa', '2025-08-28 02:12:27', '2025-08-28 02:12:27'),
(736, 'REYJA', '232410209', '$2y$12$8uCH5tF5JTWmRct7nys/M.hKJHQA4Xl9Qrfy03w7Ma209X.wA2NgW', 'siswa', '2025-08-28 02:12:27', '2025-08-28 02:12:27'),
(737, 'RIYAN ARYANTO', '232410210', '$2y$12$PJGfCzHv2kfnIJpZeNcLTOYsaPDjpl3JCz0kuRPsxpbeynsu0xC8u', 'siswa', '2025-08-28 02:12:28', '2025-08-28 02:12:28'),
(738, 'RIZZKI AKBAR ALFATIRI', '232410211', '$2y$12$OeIzU.D2bSGOYIEWRnY7AevEjE2ahYwYqikXeMWwIcSxWmfyi7NAq', 'siswa', '2025-08-28 02:12:28', '2025-08-28 02:12:28'),
(739, 'ROPI LORO SOPANJI', '232410212', '$2y$12$P4ZvUPOvvzi9s7senMJf7OKqWMMRodGcQ0AD38tmVxazQlTJQwsY2', 'siswa', '2025-08-28 02:12:28', '2025-08-28 02:12:28'),
(740, 'SUYUTI AHMAD BUSAERI', '232410213', '$2y$12$WOLOcAQ6HP.E4NLstixIH.RMPmPocZ1rSwk0dojN4T.sqBUOCu.dG', 'siswa', '2025-08-28 02:12:28', '2025-08-28 02:12:28'),
(741, 'TITI NURJANAH', '232410214', '$2y$12$AZc3SvrfQ6/xLXbdKQzDKOTlOfk67d3MKvLgnlbTqXEPDduvhQiBq', 'siswa', '2025-08-28 02:12:29', '2025-08-28 02:12:29'),
(742, 'WIRANATA', '232410215', '$2y$12$y/l0aJSw4VR6QhJ6j3x0jOHOpnoLOK75PDLrADy0EJikQPRmPQHQy', 'siswa', '2025-08-28 02:12:29', '2025-08-28 02:12:29'),
(743, 'YAZID RAHMAT HIDAYAT', '232410216', '$2y$12$4NLmB9VXftxvoGEmgezQzuO5mm5qdtfXTXNgbIlbe7UdJzvPV94ay', 'siswa', '2025-08-28 02:12:29', '2025-08-28 02:12:29'),
(744, 'YUDIS TIRA ROMANSAH', '232410217', '$2y$12$jRLwUR6je2hAcYsH0lTX.O14obegwqbhpgTdn2qLXRCCcQDtXEcC6', 'siswa', '2025-08-28 02:12:30', '2025-08-28 02:12:30'),
(745, 'YULI DEWIYANTI', '232410218', '$2y$12$xOoGAWeK0kpKWJ//sDcTlus/fiADaKPiUxRF8Ws8ZpiGVc5yBzWaK', 'siswa', '2025-08-28 02:12:30', '2025-08-28 02:12:30'),
(746, 'YULITA', '232410219', '$2y$12$V1Xf6RN/.26aAhZqn90WCe1Hh3hREfos.ztMQkgtUfuAhpHlyR77e', 'siswa', '2025-08-28 02:12:30', '2025-08-28 02:12:30'),
(747, 'ABDUL RONI', '232410220', '$2y$12$z72S6cAsrvBTaaC.gGlKdudRQSsNByDMEZT79V.5ngJmEsC0SmYRy', 'siswa', '2025-08-28 02:12:30', '2025-08-28 02:12:30'),
(748, 'ABDUL SIDIK', '232410221', '$2y$12$JkWl6VQ7bzca51ysWSM9/.qPT5RfULgNhecZ66VNnKxQEzTQw4sia', 'siswa', '2025-08-28 02:12:31', '2025-08-28 02:12:31'),
(749, 'AEL GHAZALI', '232410222', '$2y$12$22QY2XJCqprYwEWi.t1qG.x49rAGnRCL.snyfyRFkcwcFjHzwjzbu', 'siswa', '2025-08-28 02:12:31', '2025-08-28 02:12:31'),
(750, 'AHMAD FAHRI YUNMAR', '232410223', '$2y$12$Qkq/zIn2lHN00YTz3S1dF.vUMEb4ziUd/1Ofrfl2MkjQjHs7Iz7wC', 'siswa', '2025-08-28 02:12:31', '2025-08-28 02:12:31'),
(751, 'AHMAD ZAKKY JAELANI', '232410224', '$2y$12$8CtTN7nPBG2vHht5YCTp5uC9JpQwiGux6.CwEp6XqCAMvd9IiTpSO', 'siswa', '2025-08-28 02:12:32', '2025-08-28 02:12:32'),
(752, 'AHMAL', '232410225', '$2y$12$gRBlKla.C2lG2.fMSJjobO90hAUWpJ3ZDFZJUC7FUsNCQrbBWBOVO', 'siswa', '2025-08-28 02:12:32', '2025-08-28 02:12:32'),
(753, 'AKBAR SUGIHARTONO', '232410226', '$2y$12$8D7ZLqKA5/mUrOAmhoBYTuLpuMuUI/0DFaDcXuDn1eboRrkKdc4YG', 'siswa', '2025-08-28 02:12:32', '2025-08-28 02:12:32'),
(754, 'AMELDA FIKRIA', '232410227', '$2y$12$Jne7TTAK/HJ9XpcXNXjz..oubzJIoYc8VCUgKv.WZgEZaTIeUfW9m', 'siswa', '2025-08-28 02:12:33', '2025-08-28 02:12:33'),
(755, 'ARHAM SODIK', '232410228', '$2y$12$oY0w5rNNeRi/cTU/9FvFxej/6lKNVpIzx86IzdJag/hMk1UIcRegS', 'siswa', '2025-08-28 02:12:33', '2025-08-28 02:12:33'),
(756, 'ATISAH', '232410229', '$2y$12$AnCPxPLo9hWdZTk9sXc7hu0TQHLinPHS3RScB4cE7Rp9nST9.0Rg.', 'siswa', '2025-08-28 02:12:33', '2025-08-28 02:12:33'),
(757, 'CAHYA KOMARA', '232410230', '$2y$12$dx.2230J90JdgZwqfMUG0u1yGtPM1QgtG4H3YgaJcBthJyIifguPW', 'siswa', '2025-08-28 02:12:34', '2025-08-28 02:12:34'),
(758, 'DEDEN', '232410231', '$2y$12$fLOje6hRAZLXcRAvQgIMvevZlBx1DZUq1j0mBemiTKFGyl5pf.7Aq', 'siswa', '2025-08-28 02:12:34', '2025-08-28 02:12:34'),
(759, 'FITRIA ANGGRAENI', '232410232', '$2y$12$Rgm5.mBbN3bsBUfnfmrgseE0o70nm2xRKlMxS5ihTj.HJWzaqLcTu', 'siswa', '2025-08-28 02:12:34', '2025-08-28 02:12:34'),
(760, 'FITRIA RAMADANI', '232410233', '$2y$12$3HPFoGZaA9uaPnswgNIl1eImVIW9/xhyhXr2V586FtdsJ.Nfj.tUa', 'siswa', '2025-08-28 02:12:34', '2025-08-28 02:12:34'),
(761, 'GITA MELINDA SARI', '232410234', '$2y$12$hblaVXY3mqnFMpDoUVe3SuhO4sa47sjagrzR/bQpAH4eC1AkWZWyG', 'siswa', '2025-08-28 02:12:35', '2025-08-28 02:12:35'),
(762, 'IBNU HASAN', '232410235', '$2y$12$UGYNjAn/6xuescruXAtty.pZLWtrIAxtnGCLqSPPToTNSvkc/802m', 'siswa', '2025-08-28 02:12:35', '2025-08-28 02:12:35'),
(763, 'JAJANG SUTEJA', '232410236', '$2y$12$jG6uWl6v9xY3niAiNpTXWeh1m0wgOYIzu1Un5cCcrQCpb.R6FuXHW', 'siswa', '2025-08-28 02:12:35', '2025-08-28 02:12:35'),
(764, 'KARNOM', '232410237', '$2y$12$A4joOGPHcdDL84o44DcvhuoQddO5cxpZWsHkWZ2M7d8v6p8xW0LAG', 'siswa', '2025-08-28 02:12:35', '2025-08-28 02:12:35'),
(765, 'KARYA MULYANA', '232410238', '$2y$12$X6orZT/CwdW5NlqpEDUzc.OYKxLNE6YiVyHT.rOYozWzB8dQRIy2S', 'siswa', '2025-08-28 02:12:36', '2025-08-28 02:12:36'),
(766, 'KHAIRUL IKHWAN ABBASY', '232410239', '$2y$12$/kREGHVrpR7SJPQwI1wAReVkfDWSc3XF8vvSw/egbmJPtFm/yh//.', 'siswa', '2025-08-28 02:12:36', '2025-08-28 02:12:36'),
(767, 'MAULIDDANI AHMAD NURHANDIKA', '232410240', '$2y$12$7Io8H6NZMYYdDwsitt7KFe9oDKvde8DJlam5hyOfYx1.1gPxUwvM2', 'siswa', '2025-08-28 02:12:36', '2025-08-28 02:12:36'),
(768, 'MELI IMELDA', '232410241', '$2y$12$3pVBes5tp.TEXoFUQnNaOeoFEwRJjoNwMwiIM3WE0ik68/NeAwGQ2', 'siswa', '2025-08-28 02:12:37', '2025-08-28 02:12:37'),
(769, 'MUHAMAD ROSANDI', '232410242', '$2y$12$OY7FzOPJlk7fVskSgJuSL.SrK3./cyHzeDS9VCbDUNiUMgtSyZsuG', 'siswa', '2025-08-28 02:12:37', '2025-08-28 02:12:37'),
(770, 'MUHAMMAD RAFA FAUZAN', '232410243', '$2y$12$q8gDQIbokCkVIqttOxqPAePBrDIj1x22gjSiJ5YvtPvkElHziAFRS', 'siswa', '2025-08-28 02:12:37', '2025-08-28 02:12:37'),
(771, 'MUHAMMAD RAIHAN', '232410244', '$2y$12$2BKivigiROnfJewAAgxOUOVrvymI1xjJvpfRblb1mr9r7yUq3NEOG', 'siswa', '2025-08-28 02:12:37', '2025-08-28 02:12:37'),
(772, 'NOVIANI', '232410245', '$2y$12$P4Y0XwN0rUoKYNj/2BtU/O0XuJrXKlpvgx16CK10c6wO6R98KK/62', 'siswa', '2025-08-28 02:12:38', '2025-08-28 02:12:38'),
(773, 'PIRMANSAH', '232410246', '$2y$12$.krPCexU6E0F6hQT33gNs.COIJYcCUhBJP34PdBzYrP.V4Mm6EO1a', 'siswa', '2025-08-28 02:12:38', '2025-08-28 02:12:38'),
(774, 'RADO SAPERO', '232410247', '$2y$12$qahEokjjdgzOBNIbSJp6A.qJYMtXHsKqmEfv9uYFM5SXpypv0aP8K', 'siswa', '2025-08-28 02:12:38', '2025-08-28 02:12:38'),
(775, 'SAEPUL PIRDAUS', '232410248', '$2y$12$gJm/taE1mVn7bo4bMAViNub.vYpijY101MxahQcW8elMLIZHZ8cMe', 'siswa', '2025-08-28 02:12:39', '2025-08-28 02:12:39'),
(776, 'SUHENDAR', '232410249', '$2y$12$BmrB6sfadcKguqZVy/5UrOBSILIYRZCVEasARH6gJKNJDVU8njJNa', 'siswa', '2025-08-28 02:12:39', '2025-08-28 02:12:39'),
(777, 'WIDHI BAGASKORO', '232410250', '$2y$12$936y1o6ZKF3ExybuextOdOvsyifTO8DtsBe1K0DXa.gW3nN0u0RwW', 'siswa', '2025-08-28 02:12:39', '2025-08-28 02:12:39'),
(778, 'YULI', '232410251', '$2y$12$r.D/k5OYV7V8ZV4lHv.UxOSlndYXZHpae4z7sm9mvavSZycZUpvYq', 'siswa', '2025-08-28 02:12:39', '2025-08-28 02:12:39'),
(779, 'ZEN ANFASA HIDAYAT', '232410252', '$2y$12$cmAV.JNdlNz3uBQSFKugjOX5v0cd8jnWesmAnueQrnfGjTPlnCVPe', 'siswa', '2025-08-28 02:12:40', '2025-08-28 02:12:40'),
(780, 'ABDUL ROHMAN', '232410253', '$2y$12$mnumlTFPbsWFrO2j6Ql9J.5Z.ffP1i/4QOoTxVilCBT3VXfnlt1VC', 'siswa', '2025-08-28 02:12:40', '2025-08-28 02:12:40'),
(781, 'ASEP SUJANA', '232410254', '$2y$12$numMsq5Exi00j4HWXldfQeWTEx2ENUERl.DixgZJ7.gefdtyWb6xW', 'siswa', '2025-08-28 02:12:40', '2025-08-28 02:12:40'),
(782, 'DEDE RAFII', '232410255', '$2y$12$xn7Jjy8kAVAG.aB4OBuWseVXxZkmxLRj8Sr79SJ1av7bGSgbBTGNi', 'siswa', '2025-08-28 02:12:41', '2025-08-28 02:12:41'),
(783, 'DEDI WAHIDIN', '232410256', '$2y$12$h399k9SvB7vomzfuDO9ot.BKOZZS0PC0Qnpz55ps/VqNiN/CM9diy', 'siswa', '2025-08-28 02:12:41', '2025-08-28 02:12:41'),
(784, 'DETI DIAN TINI', '232410257', '$2y$12$Nxm2fDEPW0gr/efZtoq6OuMHFGSdrme1HXFRp.ZHzM8Au7O2enq9q', 'siswa', '2025-08-28 02:12:41', '2025-08-28 02:12:41'),
(785, 'ERNA WIDIAWATI S', '232410258', '$2y$12$lxHRixeJF.VZ40KQjiZAl.Y3t.zNi4V6B4MmycyZxxOpjWlu6z142', 'siswa', '2025-08-28 02:12:41', '2025-08-28 02:12:41'),
(786, 'ERNI WIDIAWATI S', '232410259', '$2y$12$U3x5d2EfvKM7lrVCCWXB9uxrLNg1H05cYh7QsNq038dy30RJEA47y', 'siswa', '2025-08-28 02:12:42', '2025-08-28 02:12:42'),
(787, 'HUSEN SOBARNA', '232410260', '$2y$12$fhBMc2BMbjOQW2yEYIN.FOdiQcW4IUYXQZPlbuRDVIhrKiOEBQoga', 'siswa', '2025-08-28 02:12:42', '2025-08-28 02:12:42'),
(788, 'IBNI MUHAJIR', '232410261', '$2y$12$Ky9mGtD/NF8k7htbk2GQT.qteDQUBh3ETpcvEYaPczAjqtqK/lWSm', 'siswa', '2025-08-28 02:12:42', '2025-08-28 02:12:42'),
(789, 'IIP IVANKA', '232410262', '$2y$12$5I0IJQ7BDYNLPiRlHiS3KO/3AA0WghLJKAS1YyTv8YITyO8C8aFeW', 'siswa', '2025-08-28 02:12:43', '2025-08-28 02:12:43'),
(790, 'IRFAN HIDAYAT', '232410263', '$2y$12$vkplI.ZJSPodjQhDjFLzQuiA2pYT/lnm25LM9MiLV/a1SUNR98z6S', 'siswa', '2025-08-28 02:12:43', '2025-08-28 02:12:43'),
(791, 'KARDIANTO', '232410264', '$2y$12$v4bd9sD0Ix54VNNC2Oqw0OMbhC/lg9cjUV2yQLe9dqViyvBhsgSza', 'siswa', '2025-08-28 02:12:43', '2025-08-28 02:12:43'),
(792, 'KISAR', '232410265', '$2y$12$g3Yz6VD4HBEKegzg8p7dmORfXT8TemM1ut2.i.fMzHvHBg58hADmi', 'siswa', '2025-08-28 02:12:43', '2025-08-28 02:12:43'),
(793, 'KORIYAH', '232410266', '$2y$12$qsdQ5yxb0yhuy4oor4/qXOXTFFWf3AtmE1D6qL0mgZYxUCmlIXGwe', 'siswa', '2025-08-28 02:12:44', '2025-08-28 02:12:44'),
(794, 'LINDA', '232410267', '$2y$12$fZV1L5I0j0G2rkRL8Kv8hO6vh883aVDwJqIb/9hOh2cV.Tx3ogsNi', 'siswa', '2025-08-28 02:12:44', '2025-08-28 02:12:44'),
(795, 'MAYA ANJELINA FRATAMA', '232410268', '$2y$12$Sk8Le7fBXQybbFdU9HePbO3fHRPECpN2VH94xivw3.SfFObNmA0AO', 'siswa', '2025-08-28 02:12:44', '2025-08-28 02:12:44'),
(796, 'MUHAMMAD ABDUL FAQIH', '232410269', '$2y$12$X1OKY/c7m1FI3tJ5bjsd4uW4hEFNQzPU1tiELJA.94EBl9F53FDSu', 'siswa', '2025-08-28 02:12:45', '2025-08-28 02:12:45'),
(797, 'MUHAMMAD AHDA AL MUSYAROF', '232410270', '$2y$12$HLyS.nkwQrdc7hzTkA7peu/X3V6HqTITRsz/f4/yEJNvTcJOOpK52', 'siswa', '2025-08-28 02:12:45', '2025-08-28 02:12:45'),
(798, 'MUHAMMAD FADLAN', '232410271', '$2y$12$zb3OilnIr7laFpGYljMrUOLN4WP7F91IHmRX/8u7kxRyjBVzJ84w2', 'siswa', '2025-08-28 02:12:45', '2025-08-28 02:12:45'),
(799, 'MUTIARA AZIZAH', '232410272', '$2y$12$eIFTHx9zIp7SQwqXHYOo9uFIYqAxzK3oEjOJ/WvE2qzPKfilKal6u', 'siswa', '2025-08-28 02:12:45', '2025-08-28 02:12:45'),
(800, 'NURAENI', '232410273', '$2y$12$fwATBQUopmXhfRRncF9X2uN2XT7cg6.ZZumKpmGhnd/2kIuEmzbFq', 'siswa', '2025-08-28 02:12:46', '2025-08-28 02:12:46'),
(801, 'RAKA', '232410274', '$2y$12$WeVb/R/qjFlOl8H6isP0p.zcMpIN.whJ.wcBejLNc6mMGkUyCw51a', 'siswa', '2025-08-28 02:12:46', '2025-08-28 02:12:46'),
(802, 'RIKI', '232410275', '$2y$12$2ENfBgfTYxGxE29vDI7Fd.pjN2j5GTE9MS7cKIXZf2RfVVtw08G4C', 'siswa', '2025-08-28 02:12:46', '2025-08-28 02:12:46'),
(803, 'SAEPUL ANWAR', '232410276', '$2y$12$w48Q8mYc5plyf9ATXfbLo.kwGsscG.FS5S9WDQJPbQlkkNSEfLH9m', 'siswa', '2025-08-28 02:12:47', '2025-08-28 02:12:47'),
(804, 'WARMAN', '232410277', '$2y$12$vKsdVuTY/cT.XoQkJt0ehuqV/uRroSBW4.usDeUKTM1GCt8WIl6Sq', 'siswa', '2025-08-28 02:12:47', '2025-08-28 02:12:47'),
(805, 'YASMIN', '232410278', '$2y$12$IXGfZu2ZKWZlhvJTc0K2vOHW8NBKYyblG1eHxreljCBAHjApXpSDS', 'siswa', '2025-08-28 02:12:47', '2025-08-28 02:12:47');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `nama_pengepul` varchar(255) NOT NULL,
  `tanggal_penjualan` date NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('jMyh0iv8G7uVG2p20vn5KpQJRq3brr1pBGEiUebI', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTHNhTUVLVVZXbUVFb3hkNlJUY1dRU3hpVTV1NW16SzVPWFN0NHhDdiI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMwOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvc2V0dGluZ3MiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1756372482);

-- --------------------------------------------------------

--
-- Table structure for table `setoran`
--

CREATE TABLE `setoran` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `siswa_id` bigint(20) UNSIGNED NOT NULL,
  `jenis_sampah_id` bigint(20) UNSIGNED NOT NULL,
  `jumlah` decimal(8,2) NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_pengguna` bigint(20) UNSIGNED NOT NULL,
  `id_kelas` bigint(20) UNSIGNED NOT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `saldo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `points` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id`, `id_pengguna`, `id_kelas`, `nis`, `saldo`, `points`, `created_at`, `updated_at`) VALUES
(1, 2, 2, '252610001', 0.00, 0, '2025-08-28 02:08:17', '2025-08-28 02:08:17'),
(2, 3, 2, '252610002', 0.00, 0, '2025-08-28 02:08:17', '2025-08-28 02:08:17'),
(3, 4, 2, '252610003', 0.00, 0, '2025-08-28 02:08:17', '2025-08-28 02:08:17'),
(4, 5, 2, '252610004', 0.00, 0, '2025-08-28 02:08:18', '2025-08-28 02:08:18'),
(5, 6, 2, '252610005', 0.00, 0, '2025-08-28 02:08:18', '2025-08-28 02:08:18'),
(6, 7, 2, '252610006', 0.00, 0, '2025-08-28 02:08:18', '2025-08-28 02:08:18'),
(7, 8, 2, '252610007', 0.00, 0, '2025-08-28 02:08:18', '2025-08-28 02:08:18'),
(8, 9, 2, '252610008', 0.00, 0, '2025-08-28 02:08:19', '2025-08-28 02:08:19'),
(9, 10, 2, '252610009', 0.00, 0, '2025-08-28 02:08:19', '2025-08-28 02:08:19'),
(10, 11, 2, '252610010', 0.00, 0, '2025-08-28 02:08:19', '2025-08-28 02:08:19'),
(11, 12, 2, '252610011', 0.00, 0, '2025-08-28 02:08:19', '2025-08-28 02:08:19'),
(12, 13, 2, '252610012', 0.00, 0, '2025-08-28 02:08:20', '2025-08-28 02:08:20'),
(13, 14, 2, '252610013', 0.00, 0, '2025-08-28 02:08:20', '2025-08-28 02:08:20'),
(14, 15, 2, '252610014', 0.00, 0, '2025-08-28 02:08:20', '2025-08-28 02:08:20'),
(15, 16, 2, '252610015', 0.00, 0, '2025-08-28 02:08:21', '2025-08-28 02:08:21'),
(16, 17, 2, '252610016', 0.00, 0, '2025-08-28 02:08:21', '2025-08-28 02:08:21'),
(17, 18, 2, '252610017', 0.00, 0, '2025-08-28 02:08:21', '2025-08-28 02:08:21'),
(18, 19, 2, '252610018', 0.00, 0, '2025-08-28 02:08:21', '2025-08-28 02:08:21'),
(19, 20, 2, '252610019', 0.00, 0, '2025-08-28 02:08:22', '2025-08-28 02:08:22'),
(20, 21, 2, '252610020', 0.00, 0, '2025-08-28 02:08:22', '2025-08-28 02:08:22'),
(21, 22, 2, '252610021', 0.00, 0, '2025-08-28 02:08:22', '2025-08-28 02:08:22'),
(22, 23, 2, '252610022', 0.00, 0, '2025-08-28 02:08:22', '2025-08-28 02:08:22'),
(23, 24, 2, '252610023', 0.00, 0, '2025-08-28 02:08:23', '2025-08-28 02:08:23'),
(24, 25, 2, '252610024', 0.00, 0, '2025-08-28 02:08:23', '2025-08-28 02:08:23'),
(25, 26, 2, '252610025', 0.00, 0, '2025-08-28 02:08:23', '2025-08-28 02:08:23'),
(26, 27, 2, '252610026', 0.00, 0, '2025-08-28 02:08:24', '2025-08-28 02:08:24'),
(27, 28, 2, '252610027', 0.00, 0, '2025-08-28 02:08:24', '2025-08-28 02:08:24'),
(28, 29, 3, '252610028', 0.00, 0, '2025-08-28 02:08:24', '2025-08-28 02:08:24'),
(29, 30, 3, '252610029', 0.00, 0, '2025-08-28 02:08:24', '2025-08-28 02:08:24'),
(30, 31, 3, '252610030', 0.00, 0, '2025-08-28 02:08:25', '2025-08-28 02:08:25'),
(31, 32, 3, '252610031', 0.00, 0, '2025-08-28 02:08:25', '2025-08-28 02:08:25'),
(32, 33, 3, '252610032', 0.00, 0, '2025-08-28 02:08:25', '2025-08-28 02:08:25'),
(33, 34, 3, '252610033', 0.00, 0, '2025-08-28 02:08:25', '2025-08-28 02:08:25'),
(34, 35, 3, '252610034', 0.00, 0, '2025-08-28 02:08:26', '2025-08-28 02:08:26'),
(35, 36, 3, '252610035', 0.00, 0, '2025-08-28 02:08:26', '2025-08-28 02:08:26'),
(36, 37, 3, '252610036', 0.00, 0, '2025-08-28 02:08:26', '2025-08-28 02:08:26'),
(37, 38, 3, '252610037', 0.00, 0, '2025-08-28 02:08:27', '2025-08-28 02:08:27'),
(38, 39, 3, '252610038', 0.00, 0, '2025-08-28 02:08:27', '2025-08-28 02:08:27'),
(39, 40, 3, '252610039', 0.00, 0, '2025-08-28 02:08:27', '2025-08-28 02:08:27'),
(40, 41, 3, '252610040', 0.00, 0, '2025-08-28 02:08:28', '2025-08-28 02:08:28'),
(41, 42, 3, '252610041', 0.00, 0, '2025-08-28 02:08:28', '2025-08-28 02:08:28'),
(42, 43, 3, '252610042', 0.00, 0, '2025-08-28 02:08:28', '2025-08-28 02:08:28'),
(43, 44, 3, '252610043', 0.00, 0, '2025-08-28 02:08:28', '2025-08-28 02:08:28'),
(44, 45, 3, '252610044', 0.00, 0, '2025-08-28 02:08:29', '2025-08-28 02:08:29'),
(45, 46, 3, '252610045', 0.00, 0, '2025-08-28 02:08:29', '2025-08-28 02:08:29'),
(46, 47, 3, '252610046', 0.00, 0, '2025-08-28 02:08:29', '2025-08-28 02:08:29'),
(47, 48, 3, '252610047', 0.00, 0, '2025-08-28 02:08:30', '2025-08-28 02:08:30'),
(48, 49, 3, '252610048', 0.00, 0, '2025-08-28 02:08:30', '2025-08-28 02:08:30'),
(49, 50, 3, '252610049', 0.00, 0, '2025-08-28 02:08:30', '2025-08-28 02:08:30'),
(50, 51, 3, '252610050', 0.00, 0, '2025-08-28 02:08:30', '2025-08-28 02:08:30'),
(51, 52, 3, '252610051', 0.00, 0, '2025-08-28 02:08:31', '2025-08-28 02:08:31'),
(52, 53, 3, '252610052', 0.00, 0, '2025-08-28 02:08:31', '2025-08-28 02:08:31'),
(53, 54, 3, '252610053', 0.00, 0, '2025-08-28 02:08:31', '2025-08-28 02:08:31'),
(54, 55, 3, '252610054', 0.00, 0, '2025-08-28 02:08:32', '2025-08-28 02:08:32'),
(55, 56, 3, '252610055', 0.00, 0, '2025-08-28 02:08:32', '2025-08-28 02:08:32'),
(56, 57, 3, '252610056', 0.00, 0, '2025-08-28 02:08:32', '2025-08-28 02:08:32'),
(57, 58, 4, '252610057', 0.00, 0, '2025-08-28 02:08:32', '2025-08-28 02:08:32'),
(58, 59, 4, '252610058', 0.00, 0, '2025-08-28 02:08:33', '2025-08-28 02:08:33'),
(59, 60, 4, '252610059', 0.00, 0, '2025-08-28 02:08:33', '2025-08-28 02:08:33'),
(60, 61, 4, '252610060', 0.00, 0, '2025-08-28 02:08:33', '2025-08-28 02:08:33'),
(61, 62, 4, '252610061', 0.00, 0, '2025-08-28 02:08:34', '2025-08-28 02:08:34'),
(62, 63, 4, '252610062', 0.00, 0, '2025-08-28 02:08:34', '2025-08-28 02:08:34'),
(63, 64, 4, '252610063', 0.00, 0, '2025-08-28 02:08:34', '2025-08-28 02:08:34'),
(64, 65, 4, '252610064', 0.00, 0, '2025-08-28 02:08:34', '2025-08-28 02:08:34'),
(65, 66, 4, '252610065', 0.00, 0, '2025-08-28 02:08:35', '2025-08-28 02:08:35'),
(66, 67, 4, '252610066', 0.00, 0, '2025-08-28 02:08:35', '2025-08-28 02:08:35'),
(67, 68, 4, '252610067', 0.00, 0, '2025-08-28 02:08:35', '2025-08-28 02:08:35'),
(68, 69, 4, '252610068', 0.00, 0, '2025-08-28 02:08:36', '2025-08-28 02:08:36'),
(69, 70, 4, '252610069', 0.00, 0, '2025-08-28 02:08:36', '2025-08-28 02:08:36'),
(70, 71, 4, '252610070', 0.00, 0, '2025-08-28 02:08:36', '2025-08-28 02:08:36'),
(71, 72, 4, '252610071', 0.00, 0, '2025-08-28 02:08:37', '2025-08-28 02:08:37'),
(72, 73, 4, '252610072', 0.00, 0, '2025-08-28 02:08:37', '2025-08-28 02:08:37'),
(73, 74, 4, '252610073', 0.00, 0, '2025-08-28 02:08:37', '2025-08-28 02:08:37'),
(74, 75, 4, '252610074', 0.00, 0, '2025-08-28 02:08:38', '2025-08-28 02:08:38'),
(75, 76, 4, '252610075', 0.00, 0, '2025-08-28 02:08:38', '2025-08-28 02:08:38'),
(76, 77, 4, '252610076', 0.00, 0, '2025-08-28 02:08:38', '2025-08-28 02:08:38'),
(77, 78, 4, '252610077', 0.00, 0, '2025-08-28 02:08:38', '2025-08-28 02:08:38'),
(78, 79, 4, '252610078', 0.00, 0, '2025-08-28 02:08:39', '2025-08-28 02:08:39'),
(79, 80, 4, '252610079', 0.00, 0, '2025-08-28 02:08:39', '2025-08-28 02:08:39'),
(80, 81, 4, '252610080', 0.00, 0, '2025-08-28 02:08:39', '2025-08-28 02:08:39'),
(81, 82, 4, '252610081', 0.00, 0, '2025-08-28 02:08:39', '2025-08-28 02:08:39'),
(82, 83, 4, '252610082', 0.00, 0, '2025-08-28 02:08:40', '2025-08-28 02:08:40'),
(83, 84, 4, '252610083', 0.00, 0, '2025-08-28 02:08:40', '2025-08-28 02:08:40'),
(84, 85, 4, '252610084', 0.00, 0, '2025-08-28 02:08:40', '2025-08-28 02:08:40'),
(85, 86, 4, '252610085', 0.00, 0, '2025-08-28 02:08:41', '2025-08-28 02:08:41'),
(86, 87, 4, '252610086', 0.00, 0, '2025-08-28 02:08:41', '2025-08-28 02:08:41'),
(87, 88, 4, '252610087', 0.00, 0, '2025-08-28 02:08:41', '2025-08-28 02:08:41'),
(88, 89, 4, '252610088', 0.00, 0, '2025-08-28 02:08:41', '2025-08-28 02:08:41'),
(89, 90, 4, '252610089', 0.00, 0, '2025-08-28 02:08:42', '2025-08-28 02:08:42'),
(90, 91, 4, '252610090', 0.00, 0, '2025-08-28 02:08:42', '2025-08-28 02:08:42'),
(91, 92, 5, '252610091', 0.00, 0, '2025-08-28 02:08:42', '2025-08-28 02:08:42'),
(92, 93, 5, '252610092', 0.00, 0, '2025-08-28 02:08:43', '2025-08-28 02:08:43'),
(93, 94, 5, '252610093', 0.00, 0, '2025-08-28 02:08:43', '2025-08-28 02:08:43'),
(94, 95, 5, '252610094', 0.00, 0, '2025-08-28 02:08:43', '2025-08-28 02:08:43'),
(95, 96, 5, '252610095', 0.00, 0, '2025-08-28 02:08:43', '2025-08-28 02:08:43'),
(96, 97, 5, '252610096', 0.00, 0, '2025-08-28 02:08:44', '2025-08-28 02:08:44'),
(97, 98, 5, '252610097', 0.00, 0, '2025-08-28 02:08:44', '2025-08-28 02:08:44'),
(98, 99, 5, '252610098', 0.00, 0, '2025-08-28 02:08:44', '2025-08-28 02:08:44'),
(99, 100, 5, '252610099', 0.00, 0, '2025-08-28 02:08:44', '2025-08-28 02:08:44'),
(100, 101, 5, '252610100', 0.00, 0, '2025-08-28 02:08:45', '2025-08-28 02:08:45'),
(101, 102, 5, '252610101', 0.00, 0, '2025-08-28 02:08:45', '2025-08-28 02:08:45'),
(102, 103, 5, '252610102', 0.00, 0, '2025-08-28 02:08:45', '2025-08-28 02:08:45'),
(103, 104, 5, '252610103', 0.00, 0, '2025-08-28 02:08:46', '2025-08-28 02:08:46'),
(104, 105, 5, '252610104', 0.00, 0, '2025-08-28 02:08:46', '2025-08-28 02:08:46'),
(105, 106, 5, '252610105', 0.00, 0, '2025-08-28 02:08:46', '2025-08-28 02:08:46'),
(106, 107, 5, '252610106', 0.00, 0, '2025-08-28 02:08:46', '2025-08-28 02:08:46'),
(107, 108, 5, '252610107', 0.00, 0, '2025-08-28 02:08:47', '2025-08-28 02:08:47'),
(108, 109, 5, '252610108', 0.00, 0, '2025-08-28 02:08:47', '2025-08-28 02:08:47'),
(109, 110, 5, '252610109', 0.00, 0, '2025-08-28 02:08:47', '2025-08-28 02:08:47'),
(110, 111, 5, '252610110', 0.00, 0, '2025-08-28 02:08:47', '2025-08-28 02:08:47'),
(111, 112, 5, '252610111', 0.00, 0, '2025-08-28 02:08:48', '2025-08-28 02:08:48'),
(112, 113, 5, '252610112', 0.00, 0, '2025-08-28 02:08:48', '2025-08-28 02:08:48'),
(113, 114, 5, '252610113', 0.00, 0, '2025-08-28 02:08:48', '2025-08-28 02:08:48'),
(114, 115, 5, '252610114', 0.00, 0, '2025-08-28 02:08:49', '2025-08-28 02:08:49'),
(115, 116, 5, '252610115', 0.00, 0, '2025-08-28 02:08:49', '2025-08-28 02:08:49'),
(116, 117, 5, '252610116', 0.00, 0, '2025-08-28 02:08:49', '2025-08-28 02:08:49'),
(117, 118, 5, '252610117', 0.00, 0, '2025-08-28 02:08:49', '2025-08-28 02:08:49'),
(118, 119, 5, '252610118', 0.00, 0, '2025-08-28 02:08:50', '2025-08-28 02:08:50'),
(119, 120, 5, '252610119', 0.00, 0, '2025-08-28 02:08:50', '2025-08-28 02:08:50'),
(120, 121, 5, '252610120', 0.00, 0, '2025-08-28 02:08:50', '2025-08-28 02:08:50'),
(121, 122, 5, '252610121', 0.00, 0, '2025-08-28 02:08:51', '2025-08-28 02:08:51'),
(122, 123, 5, '252610122', 0.00, 0, '2025-08-28 02:08:51', '2025-08-28 02:08:51'),
(123, 124, 5, '252610123', 0.00, 0, '2025-08-28 02:08:51', '2025-08-28 02:08:51'),
(124, 125, 5, '252610124', 0.00, 0, '2025-08-28 02:08:51', '2025-08-28 02:08:51'),
(125, 126, 6, '252610125', 0.00, 0, '2025-08-28 02:08:52', '2025-08-28 02:08:52'),
(126, 127, 6, '252610126', 0.00, 0, '2025-08-28 02:08:52', '2025-08-28 02:08:52'),
(127, 128, 6, '252610127', 0.00, 0, '2025-08-28 02:08:52', '2025-08-28 02:08:52'),
(128, 129, 6, '252610128', 0.00, 0, '2025-08-28 02:08:53', '2025-08-28 02:08:53'),
(129, 130, 6, '252610129', 0.00, 0, '2025-08-28 02:08:53', '2025-08-28 02:08:53'),
(130, 131, 6, '252610130', 0.00, 0, '2025-08-28 02:08:53', '2025-08-28 02:08:53'),
(131, 132, 6, '252610131', 0.00, 0, '2025-08-28 02:08:53', '2025-08-28 02:08:53'),
(132, 133, 6, '252610132', 0.00, 0, '2025-08-28 02:08:54', '2025-08-28 02:08:54'),
(133, 134, 6, '252610133', 0.00, 0, '2025-08-28 02:08:54', '2025-08-28 02:08:54'),
(134, 135, 6, '252610134', 0.00, 0, '2025-08-28 02:08:54', '2025-08-28 02:08:54'),
(135, 136, 6, '252610135', 0.00, 0, '2025-08-28 02:08:54', '2025-08-28 02:08:54'),
(136, 137, 6, '252610136', 0.00, 0, '2025-08-28 02:08:55', '2025-08-28 02:08:55'),
(137, 138, 6, '252610137', 0.00, 0, '2025-08-28 02:08:55', '2025-08-28 02:08:55'),
(138, 139, 6, '252610138', 0.00, 0, '2025-08-28 02:08:55', '2025-08-28 02:08:55'),
(139, 140, 6, '252610139', 0.00, 0, '2025-08-28 02:08:56', '2025-08-28 02:08:56'),
(140, 141, 6, '252610140', 0.00, 0, '2025-08-28 02:08:56', '2025-08-28 02:08:56'),
(141, 142, 6, '252610141', 0.00, 0, '2025-08-28 02:08:56', '2025-08-28 02:08:56'),
(142, 143, 6, '252610142', 0.00, 0, '2025-08-28 02:08:56', '2025-08-28 02:08:56'),
(143, 144, 6, '252610143', 0.00, 0, '2025-08-28 02:08:57', '2025-08-28 02:08:57'),
(144, 145, 6, '252610144', 0.00, 0, '2025-08-28 02:08:57', '2025-08-28 02:08:57'),
(145, 146, 6, '252610145', 0.00, 0, '2025-08-28 02:08:57', '2025-08-28 02:08:57'),
(146, 147, 6, '252610146', 0.00, 0, '2025-08-28 02:08:57', '2025-08-28 02:08:57'),
(147, 148, 6, '252610147', 0.00, 0, '2025-08-28 02:08:58', '2025-08-28 02:08:58'),
(148, 149, 6, '252610148', 0.00, 0, '2025-08-28 02:08:58', '2025-08-28 02:08:58'),
(149, 150, 6, '252610149', 0.00, 0, '2025-08-28 02:08:58', '2025-08-28 02:08:58'),
(150, 151, 6, '252610150', 0.00, 0, '2025-08-28 02:08:59', '2025-08-28 02:08:59'),
(151, 152, 6, '252610151', 0.00, 0, '2025-08-28 02:08:59', '2025-08-28 02:08:59'),
(152, 153, 6, '252610152', 0.00, 0, '2025-08-28 02:08:59', '2025-08-28 02:08:59'),
(153, 154, 6, '252610153', 0.00, 0, '2025-08-28 02:08:59', '2025-08-28 02:08:59'),
(154, 155, 6, '252610154', 0.00, 0, '2025-08-28 02:09:00', '2025-08-28 02:09:00'),
(155, 156, 6, '252610155', 0.00, 0, '2025-08-28 02:09:00', '2025-08-28 02:09:00'),
(156, 157, 6, '252610156', 0.00, 0, '2025-08-28 02:09:00', '2025-08-28 02:09:00'),
(157, 158, 6, '252610157', 0.00, 0, '2025-08-28 02:09:01', '2025-08-28 02:09:01'),
(158, 159, 6, '252610158', 0.00, 0, '2025-08-28 02:09:01', '2025-08-28 02:09:01'),
(159, 160, 7, '252610159', 0.00, 0, '2025-08-28 02:09:01', '2025-08-28 02:09:01'),
(160, 161, 7, '252610160', 0.00, 0, '2025-08-28 02:09:01', '2025-08-28 02:09:01'),
(161, 162, 7, '252610161', 0.00, 0, '2025-08-28 02:09:02', '2025-08-28 02:09:02'),
(162, 163, 7, '252610162', 0.00, 0, '2025-08-28 02:09:02', '2025-08-28 02:09:02'),
(163, 164, 7, '252610163', 0.00, 0, '2025-08-28 02:09:02', '2025-08-28 02:09:02'),
(164, 165, 7, '252610164', 0.00, 0, '2025-08-28 02:09:03', '2025-08-28 02:09:03'),
(165, 166, 7, '252610165', 0.00, 0, '2025-08-28 02:09:03', '2025-08-28 02:09:03'),
(166, 167, 7, '252610166', 0.00, 0, '2025-08-28 02:09:03', '2025-08-28 02:09:03'),
(167, 168, 7, '252610167', 0.00, 0, '2025-08-28 02:09:03', '2025-08-28 02:09:03'),
(168, 169, 7, '252610168', 0.00, 0, '2025-08-28 02:09:04', '2025-08-28 02:09:04'),
(169, 170, 7, '252610169', 0.00, 0, '2025-08-28 02:09:04', '2025-08-28 02:09:04'),
(170, 171, 7, '252610170', 0.00, 0, '2025-08-28 02:09:04', '2025-08-28 02:09:04'),
(171, 172, 7, '252610171', 0.00, 0, '2025-08-28 02:09:04', '2025-08-28 02:09:04'),
(172, 173, 7, '252610172', 0.00, 0, '2025-08-28 02:09:05', '2025-08-28 02:09:05'),
(173, 174, 7, '252610173', 0.00, 0, '2025-08-28 02:09:05', '2025-08-28 02:09:05'),
(174, 175, 7, '252610174', 0.00, 0, '2025-08-28 02:09:05', '2025-08-28 02:09:05'),
(175, 176, 7, '252610175', 0.00, 0, '2025-08-28 02:09:06', '2025-08-28 02:09:06'),
(176, 177, 7, '252610176', 0.00, 0, '2025-08-28 02:09:06', '2025-08-28 02:09:06'),
(177, 178, 7, '252610177', 0.00, 0, '2025-08-28 02:09:06', '2025-08-28 02:09:06'),
(178, 179, 7, '252610178', 0.00, 0, '2025-08-28 02:09:06', '2025-08-28 02:09:06'),
(179, 180, 7, '252610179', 0.00, 0, '2025-08-28 02:09:07', '2025-08-28 02:09:07'),
(180, 181, 7, '252610180', 0.00, 0, '2025-08-28 02:09:07', '2025-08-28 02:09:07'),
(181, 182, 7, '252610181', 0.00, 0, '2025-08-28 02:09:07', '2025-08-28 02:09:07'),
(182, 183, 7, '252610182', 0.00, 0, '2025-08-28 02:09:08', '2025-08-28 02:09:08'),
(183, 184, 7, '252610183', 0.00, 0, '2025-08-28 02:09:08', '2025-08-28 02:09:08'),
(184, 185, 7, '252610184', 0.00, 0, '2025-08-28 02:09:08', '2025-08-28 02:09:08'),
(185, 186, 7, '252610185', 0.00, 0, '2025-08-28 02:09:08', '2025-08-28 02:09:08'),
(186, 187, 7, '252610186', 0.00, 0, '2025-08-28 02:09:09', '2025-08-28 02:09:09'),
(187, 188, 7, '252610187', 0.00, 0, '2025-08-28 02:09:09', '2025-08-28 02:09:09'),
(188, 189, 7, '252610188', 0.00, 0, '2025-08-28 02:09:09', '2025-08-28 02:09:09'),
(189, 190, 7, '252610189', 0.00, 0, '2025-08-28 02:09:09', '2025-08-28 02:09:09'),
(190, 191, 7, '252610190', 0.00, 0, '2025-08-28 02:09:10', '2025-08-28 02:09:10'),
(191, 192, 7, '252610191', 0.00, 0, '2025-08-28 02:09:10', '2025-08-28 02:09:10'),
(192, 193, 7, '252610192', 0.00, 0, '2025-08-28 02:09:10', '2025-08-28 02:09:10'),
(193, 194, 8, '252610193', 0.00, 0, '2025-08-28 02:09:11', '2025-08-28 02:09:11'),
(194, 195, 8, '252610194', 0.00, 0, '2025-08-28 02:09:11', '2025-08-28 02:09:11'),
(195, 196, 8, '252610195', 0.00, 0, '2025-08-28 02:09:11', '2025-08-28 02:09:11'),
(196, 197, 8, '252610196', 0.00, 0, '2025-08-28 02:09:12', '2025-08-28 02:09:12'),
(197, 198, 8, '252610197', 0.00, 0, '2025-08-28 02:09:12', '2025-08-28 02:09:12'),
(198, 199, 8, '252610198', 0.00, 0, '2025-08-28 02:09:12', '2025-08-28 02:09:12'),
(199, 200, 8, '252610199', 0.00, 0, '2025-08-28 02:09:12', '2025-08-28 02:09:12'),
(200, 201, 8, '252610200', 0.00, 0, '2025-08-28 02:09:20', '2025-08-28 02:09:20'),
(201, 202, 8, '252610201', 0.00, 0, '2025-08-28 02:09:20', '2025-08-28 02:09:20'),
(202, 203, 8, '252610202', 0.00, 0, '2025-08-28 02:09:21', '2025-08-28 02:09:21'),
(203, 204, 8, '252610203', 0.00, 0, '2025-08-28 02:09:21', '2025-08-28 02:09:21'),
(204, 205, 8, '252610204', 0.00, 0, '2025-08-28 02:09:21', '2025-08-28 02:09:21'),
(205, 206, 8, '252610205', 0.00, 0, '2025-08-28 02:09:21', '2025-08-28 02:09:21'),
(206, 207, 8, '252610206', 0.00, 0, '2025-08-28 02:09:22', '2025-08-28 02:09:22'),
(207, 208, 8, '252610207', 0.00, 0, '2025-08-28 02:09:22', '2025-08-28 02:09:22'),
(208, 209, 8, '252610208', 0.00, 0, '2025-08-28 02:09:22', '2025-08-28 02:09:22'),
(209, 210, 8, '252610209', 0.00, 0, '2025-08-28 02:09:23', '2025-08-28 02:09:23'),
(210, 211, 8, '252610210', 0.00, 0, '2025-08-28 02:09:23', '2025-08-28 02:09:23'),
(211, 212, 8, '252610211', 0.00, 0, '2025-08-28 02:09:23', '2025-08-28 02:09:23'),
(212, 213, 8, '252610212', 0.00, 0, '2025-08-28 02:09:23', '2025-08-28 02:09:23'),
(213, 214, 8, '252610213', 0.00, 0, '2025-08-28 02:09:24', '2025-08-28 02:09:24'),
(214, 215, 8, '252610214', 0.00, 0, '2025-08-28 02:09:24', '2025-08-28 02:09:24'),
(215, 216, 8, '252610215', 0.00, 0, '2025-08-28 02:09:24', '2025-08-28 02:09:24'),
(216, 217, 8, '252610216', 0.00, 0, '2025-08-28 02:09:24', '2025-08-28 02:09:24'),
(217, 218, 8, '252610217', 0.00, 0, '2025-08-28 02:09:25', '2025-08-28 02:09:25'),
(218, 219, 8, '252610218', 0.00, 0, '2025-08-28 02:09:25', '2025-08-28 02:09:25'),
(219, 220, 8, '252610219', 0.00, 0, '2025-08-28 02:09:25', '2025-08-28 02:09:25'),
(220, 221, 8, '252610220', 0.00, 0, '2025-08-28 02:09:26', '2025-08-28 02:09:26'),
(221, 222, 8, '252610221', 0.00, 0, '2025-08-28 02:09:26', '2025-08-28 02:09:26'),
(222, 223, 8, '252610222', 0.00, 0, '2025-08-28 02:09:26', '2025-08-28 02:09:26'),
(223, 224, 8, '252610223', 0.00, 0, '2025-08-28 02:09:26', '2025-08-28 02:09:26'),
(224, 225, 8, '252610224', 0.00, 0, '2025-08-28 02:09:27', '2025-08-28 02:09:27'),
(225, 226, 8, '252610225', 0.00, 0, '2025-08-28 02:09:27', '2025-08-28 02:09:27'),
(226, 227, 8, '252610226', 0.00, 0, '2025-08-28 02:09:27', '2025-08-28 02:09:27'),
(227, 228, 8, '252610227', 0.00, 0, '2025-08-28 02:09:28', '2025-08-28 02:09:28'),
(228, 229, 9, '252610228', 0.00, 0, '2025-08-28 02:09:28', '2025-08-28 02:09:28'),
(229, 230, 9, '252610229', 0.00, 0, '2025-08-28 02:09:28', '2025-08-28 02:09:28'),
(230, 231, 9, '252610230', 0.00, 0, '2025-08-28 02:09:29', '2025-08-28 02:09:29'),
(231, 232, 9, '252610231', 0.00, 0, '2025-08-28 02:09:29', '2025-08-28 02:09:29'),
(232, 233, 9, '252610232', 0.00, 0, '2025-08-28 02:09:29', '2025-08-28 02:09:29'),
(233, 234, 9, '252610233', 0.00, 0, '2025-08-28 02:09:29', '2025-08-28 02:09:29'),
(234, 235, 9, '252610234', 0.00, 0, '2025-08-28 02:09:30', '2025-08-28 02:09:30'),
(235, 236, 9, '252610235', 0.00, 0, '2025-08-28 02:09:30', '2025-08-28 02:09:30'),
(236, 237, 9, '252610236', 0.00, 0, '2025-08-28 02:09:30', '2025-08-28 02:09:30'),
(237, 238, 9, '252610237', 0.00, 0, '2025-08-28 02:09:30', '2025-08-28 02:09:30'),
(238, 239, 9, '252610238', 0.00, 0, '2025-08-28 02:09:31', '2025-08-28 02:09:31'),
(239, 240, 9, '252610239', 0.00, 0, '2025-08-28 02:09:31', '2025-08-28 02:09:31'),
(240, 241, 9, '252610240', 0.00, 0, '2025-08-28 02:09:31', '2025-08-28 02:09:31'),
(241, 242, 9, '252610241', 0.00, 0, '2025-08-28 02:09:32', '2025-08-28 02:09:32'),
(242, 243, 9, '252610242', 0.00, 0, '2025-08-28 02:09:32', '2025-08-28 02:09:32'),
(243, 244, 9, '252610243', 0.00, 0, '2025-08-28 02:09:32', '2025-08-28 02:09:32'),
(244, 245, 9, '252610244', 0.00, 0, '2025-08-28 02:09:32', '2025-08-28 02:09:32'),
(245, 246, 9, '252610245', 0.00, 0, '2025-08-28 02:09:33', '2025-08-28 02:09:33'),
(246, 247, 9, '252610246', 0.00, 0, '2025-08-28 02:09:33', '2025-08-28 02:09:33'),
(247, 248, 9, '252610247', 0.00, 0, '2025-08-28 02:09:33', '2025-08-28 02:09:33'),
(248, 249, 9, '252610248', 0.00, 0, '2025-08-28 02:09:34', '2025-08-28 02:09:34'),
(249, 250, 9, '252610249', 0.00, 0, '2025-08-28 02:09:34', '2025-08-28 02:09:34'),
(250, 251, 9, '252610250', 0.00, 0, '2025-08-28 02:09:34', '2025-08-28 02:09:34'),
(251, 252, 9, '252610251', 0.00, 0, '2025-08-28 02:09:34', '2025-08-28 02:09:34'),
(252, 253, 9, '252610252', 0.00, 0, '2025-08-28 02:09:35', '2025-08-28 02:09:35'),
(253, 254, 9, '252610253', 0.00, 0, '2025-08-28 02:09:35', '2025-08-28 02:09:35'),
(254, 255, 9, '252610254', 0.00, 0, '2025-08-28 02:09:35', '2025-08-28 02:09:35'),
(255, 256, 9, '252610255', 0.00, 0, '2025-08-28 02:09:35', '2025-08-28 02:09:35'),
(256, 257, 9, '252610256', 0.00, 0, '2025-08-28 02:09:36', '2025-08-28 02:09:36'),
(257, 258, 9, '252610257', 0.00, 0, '2025-08-28 02:09:36', '2025-08-28 02:09:36'),
(258, 259, 9, '252610258', 0.00, 0, '2025-08-28 02:09:36', '2025-08-28 02:09:36'),
(259, 260, 9, '252610259', 0.00, 0, '2025-08-28 02:09:37', '2025-08-28 02:09:37'),
(260, 261, 9, '252610260', 0.00, 0, '2025-08-28 02:09:37', '2025-08-28 02:09:37'),
(261, 262, 9, '252610261', 0.00, 0, '2025-08-28 02:09:37', '2025-08-28 02:09:37'),
(262, 263, 9, '252610262', 0.00, 0, '2025-08-28 02:09:37', '2025-08-28 02:09:37'),
(263, 264, 10, '242510001', 0.00, 0, '2025-08-28 02:09:44', '2025-08-28 02:09:44'),
(264, 265, 10, '242510002', 0.00, 0, '2025-08-28 02:09:44', '2025-08-28 02:09:44'),
(265, 266, 10, '242510003', 0.00, 0, '2025-08-28 02:09:44', '2025-08-28 02:09:44'),
(266, 267, 10, '242510004', 0.00, 0, '2025-08-28 02:09:45', '2025-08-28 02:09:45'),
(267, 268, 10, '242510005', 0.00, 0, '2025-08-28 02:09:45', '2025-08-28 02:09:45'),
(268, 269, 10, '242510006', 0.00, 0, '2025-08-28 02:09:45', '2025-08-28 02:09:45'),
(269, 270, 10, '242510007', 0.00, 0, '2025-08-28 02:09:46', '2025-08-28 02:09:46'),
(270, 271, 10, '242510008', 0.00, 0, '2025-08-28 02:09:46', '2025-08-28 02:09:46'),
(271, 272, 10, '242510009', 0.00, 0, '2025-08-28 02:09:46', '2025-08-28 02:09:46'),
(272, 273, 10, '242510010', 0.00, 0, '2025-08-28 02:09:46', '2025-08-28 02:09:46'),
(273, 274, 10, '242510011', 0.00, 0, '2025-08-28 02:09:47', '2025-08-28 02:09:47'),
(274, 275, 10, '242510012', 0.00, 0, '2025-08-28 02:09:47', '2025-08-28 02:09:47'),
(275, 276, 10, '242510013', 0.00, 0, '2025-08-28 02:09:47', '2025-08-28 02:09:47'),
(276, 277, 10, '242510014', 0.00, 0, '2025-08-28 02:09:48', '2025-08-28 02:09:48'),
(277, 278, 10, '242510015', 0.00, 0, '2025-08-28 02:09:48', '2025-08-28 02:09:48'),
(278, 279, 10, '242510016', 0.00, 0, '2025-08-28 02:09:48', '2025-08-28 02:09:48'),
(279, 280, 10, '242510017', 0.00, 0, '2025-08-28 02:09:49', '2025-08-28 02:09:49'),
(280, 281, 10, '242510018', 0.00, 0, '2025-08-28 02:09:49', '2025-08-28 02:09:49'),
(281, 282, 10, '242510019', 0.00, 0, '2025-08-28 02:09:49', '2025-08-28 02:09:49'),
(282, 283, 10, '242510020', 0.00, 0, '2025-08-28 02:09:50', '2025-08-28 02:09:50'),
(283, 284, 10, '242510021', 0.00, 0, '2025-08-28 02:09:50', '2025-08-28 02:09:50'),
(284, 285, 10, '242510022', 0.00, 0, '2025-08-28 02:09:50', '2025-08-28 02:09:50'),
(285, 286, 10, '242510023', 0.00, 0, '2025-08-28 02:09:51', '2025-08-28 02:09:51'),
(286, 287, 10, '242510024', 0.00, 0, '2025-08-28 02:09:51', '2025-08-28 02:09:51'),
(287, 288, 10, '242510025', 0.00, 0, '2025-08-28 02:09:51', '2025-08-28 02:09:51'),
(288, 289, 10, '242510026', 0.00, 0, '2025-08-28 02:09:51', '2025-08-28 02:09:51'),
(289, 290, 10, '242510027', 0.00, 0, '2025-08-28 02:09:52', '2025-08-28 02:09:52'),
(290, 291, 10, '242510028', 0.00, 0, '2025-08-28 02:09:52', '2025-08-28 02:09:52'),
(291, 292, 10, '242510029', 0.00, 0, '2025-08-28 02:09:52', '2025-08-28 02:09:52'),
(292, 293, 10, '242510030', 0.00, 0, '2025-08-28 02:09:53', '2025-08-28 02:09:53'),
(293, 294, 10, '242510031', 0.00, 0, '2025-08-28 02:09:53', '2025-08-28 02:09:53'),
(294, 295, 10, '242510032', 0.00, 0, '2025-08-28 02:09:53', '2025-08-28 02:09:53'),
(295, 296, 10, '242510033', 0.00, 0, '2025-08-28 02:09:54', '2025-08-28 02:09:54'),
(296, 297, 11, '242510034', 0.00, 0, '2025-08-28 02:09:54', '2025-08-28 02:09:54'),
(297, 298, 11, '242510035', 0.00, 0, '2025-08-28 02:09:54', '2025-08-28 02:09:54'),
(298, 299, 11, '242510036', 0.00, 0, '2025-08-28 02:09:55', '2025-08-28 02:09:55'),
(299, 300, 11, '242510037', 0.00, 0, '2025-08-28 02:09:55', '2025-08-28 02:09:55'),
(300, 301, 11, '242510038', 0.00, 0, '2025-08-28 02:09:55', '2025-08-28 02:09:55'),
(301, 302, 11, '242510039', 0.00, 0, '2025-08-28 02:09:56', '2025-08-28 02:09:56'),
(302, 303, 11, '242510040', 0.00, 0, '2025-08-28 02:09:56', '2025-08-28 02:09:56'),
(303, 304, 11, '242510041', 0.00, 0, '2025-08-28 02:09:56', '2025-08-28 02:09:56'),
(304, 305, 11, '242510042', 0.00, 0, '2025-08-28 02:09:57', '2025-08-28 02:09:57'),
(305, 306, 11, '242510043', 0.00, 0, '2025-08-28 02:09:57', '2025-08-28 02:09:57'),
(306, 307, 11, '242510044', 0.00, 0, '2025-08-28 02:09:57', '2025-08-28 02:09:57'),
(307, 308, 11, '242510045', 0.00, 0, '2025-08-28 02:09:58', '2025-08-28 02:09:58'),
(308, 309, 11, '242510046', 0.00, 0, '2025-08-28 02:09:58', '2025-08-28 02:09:58'),
(309, 310, 11, '242510047', 0.00, 0, '2025-08-28 02:09:58', '2025-08-28 02:09:58'),
(310, 311, 11, '242510048', 0.00, 0, '2025-08-28 02:09:58', '2025-08-28 02:09:58'),
(311, 312, 11, '242510049', 0.00, 0, '2025-08-28 02:09:59', '2025-08-28 02:09:59'),
(312, 313, 11, '242510050', 0.00, 0, '2025-08-28 02:09:59', '2025-08-28 02:09:59'),
(313, 314, 11, '242510051', 0.00, 0, '2025-08-28 02:09:59', '2025-08-28 02:09:59'),
(314, 315, 11, '242510052', 0.00, 0, '2025-08-28 02:10:00', '2025-08-28 02:10:00'),
(315, 316, 11, '242510053', 0.00, 0, '2025-08-28 02:10:00', '2025-08-28 02:10:00'),
(316, 317, 11, '242510054', 0.00, 0, '2025-08-28 02:10:00', '2025-08-28 02:10:00'),
(317, 318, 11, '242510055', 0.00, 0, '2025-08-28 02:10:00', '2025-08-28 02:10:00'),
(318, 319, 11, '242510056', 0.00, 0, '2025-08-28 02:10:01', '2025-08-28 02:10:01'),
(319, 320, 11, '242510057', 0.00, 0, '2025-08-28 02:10:01', '2025-08-28 02:10:01'),
(320, 321, 11, '242510058', 0.00, 0, '2025-08-28 02:10:01', '2025-08-28 02:10:01'),
(321, 322, 11, '242510059', 0.00, 0, '2025-08-28 02:10:02', '2025-08-28 02:10:02'),
(322, 323, 11, '242510060', 0.00, 0, '2025-08-28 02:10:02', '2025-08-28 02:10:02'),
(323, 324, 11, '242510061', 0.00, 0, '2025-08-28 02:10:02', '2025-08-28 02:10:02'),
(324, 325, 11, '242510062', 0.00, 0, '2025-08-28 02:10:02', '2025-08-28 02:10:02'),
(325, 326, 11, '242510063', 0.00, 0, '2025-08-28 02:10:03', '2025-08-28 02:10:03'),
(326, 327, 11, '242510064', 0.00, 0, '2025-08-28 02:10:03', '2025-08-28 02:10:03'),
(327, 328, 12, '242510065', 0.00, 0, '2025-08-28 02:10:03', '2025-08-28 02:10:03'),
(328, 329, 12, '242510066', 0.00, 0, '2025-08-28 02:10:03', '2025-08-28 02:10:03'),
(329, 330, 12, '242510067', 0.00, 0, '2025-08-28 02:10:04', '2025-08-28 02:10:04'),
(330, 331, 12, '242510068', 0.00, 0, '2025-08-28 02:10:04', '2025-08-28 02:10:04'),
(331, 332, 12, '242510069', 0.00, 0, '2025-08-28 02:10:04', '2025-08-28 02:10:04'),
(332, 333, 12, '242510070', 0.00, 0, '2025-08-28 02:10:04', '2025-08-28 02:10:04'),
(333, 334, 12, '242510071', 0.00, 0, '2025-08-28 02:10:05', '2025-08-28 02:10:05'),
(334, 335, 12, '242510072', 0.00, 0, '2025-08-28 02:10:05', '2025-08-28 02:10:05'),
(335, 336, 12, '242510073', 0.00, 0, '2025-08-28 02:10:05', '2025-08-28 02:10:05'),
(336, 337, 12, '242510074', 0.00, 0, '2025-08-28 02:10:06', '2025-08-28 02:10:06'),
(337, 338, 12, '242510075', 0.00, 0, '2025-08-28 02:10:06', '2025-08-28 02:10:06'),
(338, 339, 12, '242510076', 0.00, 0, '2025-08-28 02:10:06', '2025-08-28 02:10:06'),
(339, 340, 12, '242510077', 0.00, 0, '2025-08-28 02:10:06', '2025-08-28 02:10:06'),
(340, 341, 12, '242510078', 0.00, 0, '2025-08-28 02:10:07', '2025-08-28 02:10:07'),
(341, 342, 12, '242510079', 0.00, 0, '2025-08-28 02:10:07', '2025-08-28 02:10:07'),
(342, 343, 12, '242510080', 0.00, 0, '2025-08-28 02:10:07', '2025-08-28 02:10:07'),
(343, 344, 12, '242510081', 0.00, 0, '2025-08-28 02:10:07', '2025-08-28 02:10:07'),
(344, 345, 12, '242510082', 0.00, 0, '2025-08-28 02:10:08', '2025-08-28 02:10:08'),
(345, 346, 12, '242510083', 0.00, 0, '2025-08-28 02:10:08', '2025-08-28 02:10:08'),
(346, 347, 12, '242510084', 0.00, 0, '2025-08-28 02:10:08', '2025-08-28 02:10:08'),
(347, 348, 12, '242510085', 0.00, 0, '2025-08-28 02:10:09', '2025-08-28 02:10:09'),
(348, 349, 12, '242510086', 0.00, 0, '2025-08-28 02:10:09', '2025-08-28 02:10:09'),
(349, 350, 12, '242510087', 0.00, 0, '2025-08-28 02:10:09', '2025-08-28 02:10:09'),
(350, 351, 12, '242510088', 0.00, 0, '2025-08-28 02:10:09', '2025-08-28 02:10:09'),
(351, 352, 12, '242510089', 0.00, 0, '2025-08-28 02:10:10', '2025-08-28 02:10:10'),
(352, 353, 12, '242510090', 0.00, 0, '2025-08-28 02:10:10', '2025-08-28 02:10:10'),
(353, 354, 12, '242510091', 0.00, 0, '2025-08-28 02:10:10', '2025-08-28 02:10:10'),
(354, 355, 12, '242510092', 0.00, 0, '2025-08-28 02:10:10', '2025-08-28 02:10:10'),
(355, 356, 12, '242510093', 0.00, 0, '2025-08-28 02:10:11', '2025-08-28 02:10:11'),
(356, 357, 12, '242510094', 0.00, 0, '2025-08-28 02:10:11', '2025-08-28 02:10:11'),
(357, 358, 12, '242510095', 0.00, 0, '2025-08-28 02:10:11', '2025-08-28 02:10:11'),
(358, 359, 12, '242510096', 0.00, 0, '2025-08-28 02:10:12', '2025-08-28 02:10:12'),
(359, 360, 13, '242510097', 0.00, 0, '2025-08-28 02:10:12', '2025-08-28 02:10:12'),
(360, 361, 13, '242510098', 0.00, 0, '2025-08-28 02:10:12', '2025-08-28 02:10:12'),
(361, 362, 13, '242510099', 0.00, 0, '2025-08-28 02:10:12', '2025-08-28 02:10:12'),
(362, 363, 13, '242510100', 0.00, 0, '2025-08-28 02:10:13', '2025-08-28 02:10:13'),
(363, 364, 13, '242510101', 0.00, 0, '2025-08-28 02:10:13', '2025-08-28 02:10:13'),
(364, 365, 13, '242510102', 0.00, 0, '2025-08-28 02:10:13', '2025-08-28 02:10:13'),
(365, 366, 13, '242510103', 0.00, 0, '2025-08-28 02:10:13', '2025-08-28 02:10:13'),
(366, 367, 13, '242510104', 0.00, 0, '2025-08-28 02:10:14', '2025-08-28 02:10:14'),
(367, 368, 13, '242510105', 0.00, 0, '2025-08-28 02:10:14', '2025-08-28 02:10:14'),
(368, 369, 13, '242510106', 0.00, 0, '2025-08-28 02:10:14', '2025-08-28 02:10:14'),
(369, 370, 13, '242510107', 0.00, 0, '2025-08-28 02:10:15', '2025-08-28 02:10:15'),
(370, 371, 13, '242510108', 0.00, 0, '2025-08-28 02:10:15', '2025-08-28 02:10:15'),
(371, 372, 13, '242510109', 0.00, 0, '2025-08-28 02:10:15', '2025-08-28 02:10:15'),
(372, 373, 13, '242510110', 0.00, 0, '2025-08-28 02:10:15', '2025-08-28 02:10:15'),
(373, 374, 13, '242510111', 0.00, 0, '2025-08-28 02:10:16', '2025-08-28 02:10:16'),
(374, 375, 13, '242510112', 0.00, 0, '2025-08-28 02:10:16', '2025-08-28 02:10:16'),
(375, 376, 13, '242510113', 0.00, 0, '2025-08-28 02:10:16', '2025-08-28 02:10:16'),
(376, 377, 13, '242510114', 0.00, 0, '2025-08-28 02:10:17', '2025-08-28 02:10:17'),
(377, 378, 13, '242510115', 0.00, 0, '2025-08-28 02:10:17', '2025-08-28 02:10:17'),
(378, 379, 13, '242510116', 0.00, 0, '2025-08-28 02:10:17', '2025-08-28 02:10:17'),
(379, 380, 13, '242510117', 0.00, 0, '2025-08-28 02:10:17', '2025-08-28 02:10:17'),
(380, 381, 13, '242510118', 0.00, 0, '2025-08-28 02:10:18', '2025-08-28 02:10:18'),
(381, 382, 13, '242510119', 0.00, 0, '2025-08-28 02:10:18', '2025-08-28 02:10:18'),
(382, 383, 13, '242510120', 0.00, 0, '2025-08-28 02:10:18', '2025-08-28 02:10:18'),
(383, 384, 13, '242510121', 0.00, 0, '2025-08-28 02:10:19', '2025-08-28 02:10:19'),
(384, 385, 13, '242510122', 0.00, 0, '2025-08-28 02:10:19', '2025-08-28 02:10:19'),
(385, 386, 13, '242510123', 0.00, 0, '2025-08-28 02:10:19', '2025-08-28 02:10:19'),
(386, 387, 13, '242510124', 0.00, 0, '2025-08-28 02:10:19', '2025-08-28 02:10:19'),
(387, 388, 14, '242510125', 0.00, 0, '2025-08-28 02:10:20', '2025-08-28 02:10:20'),
(388, 389, 14, '242510126', 0.00, 0, '2025-08-28 02:10:20', '2025-08-28 02:10:20'),
(389, 390, 14, '242510127', 0.00, 0, '2025-08-28 02:10:20', '2025-08-28 02:10:20'),
(390, 391, 14, '242510128', 0.00, 0, '2025-08-28 02:10:21', '2025-08-28 02:10:21'),
(391, 392, 14, '242510129', 0.00, 0, '2025-08-28 02:10:21', '2025-08-28 02:10:21'),
(392, 393, 14, '242510130', 0.00, 0, '2025-08-28 02:10:21', '2025-08-28 02:10:21'),
(393, 394, 14, '242510131', 0.00, 0, '2025-08-28 02:10:21', '2025-08-28 02:10:21'),
(394, 395, 14, '242510132', 0.00, 0, '2025-08-28 02:10:22', '2025-08-28 02:10:22'),
(395, 396, 14, '242510133', 0.00, 0, '2025-08-28 02:10:22', '2025-08-28 02:10:22'),
(396, 397, 14, '242510134', 0.00, 0, '2025-08-28 02:10:22', '2025-08-28 02:10:22'),
(397, 398, 14, '242510135', 0.00, 0, '2025-08-28 02:10:23', '2025-08-28 02:10:23'),
(398, 399, 14, '242510136', 0.00, 0, '2025-08-28 02:10:23', '2025-08-28 02:10:23'),
(399, 400, 14, '242510137', 0.00, 0, '2025-08-28 02:10:23', '2025-08-28 02:10:23'),
(400, 401, 14, '242510138', 0.00, 0, '2025-08-28 02:10:23', '2025-08-28 02:10:23'),
(401, 402, 14, '242510139', 0.00, 0, '2025-08-28 02:10:24', '2025-08-28 02:10:24'),
(402, 403, 14, '242510140', 0.00, 0, '2025-08-28 02:10:24', '2025-08-28 02:10:24'),
(403, 404, 14, '242510141', 0.00, 0, '2025-08-28 02:10:24', '2025-08-28 02:10:24'),
(404, 405, 14, '242510142', 0.00, 0, '2025-08-28 02:10:25', '2025-08-28 02:10:25'),
(405, 406, 14, '242510143', 0.00, 0, '2025-08-28 02:10:25', '2025-08-28 02:10:25'),
(406, 407, 14, '242510144', 0.00, 0, '2025-08-28 02:10:25', '2025-08-28 02:10:25'),
(407, 408, 14, '242510145', 0.00, 0, '2025-08-28 02:10:26', '2025-08-28 02:10:26'),
(408, 409, 14, '242510146', 0.00, 0, '2025-08-28 02:10:26', '2025-08-28 02:10:26'),
(409, 410, 14, '242510147', 0.00, 0, '2025-08-28 02:10:26', '2025-08-28 02:10:26'),
(410, 411, 14, '242510148', 0.00, 0, '2025-08-28 02:10:26', '2025-08-28 02:10:26'),
(411, 412, 14, '242510149', 0.00, 0, '2025-08-28 02:10:27', '2025-08-28 02:10:27'),
(412, 413, 14, '242510150', 0.00, 0, '2025-08-28 02:10:27', '2025-08-28 02:10:27'),
(413, 414, 14, '242510151', 0.00, 0, '2025-08-28 02:10:27', '2025-08-28 02:10:27'),
(414, 415, 14, '242510152', 0.00, 0, '2025-08-28 02:10:28', '2025-08-28 02:10:28'),
(415, 416, 15, '242510153', 0.00, 0, '2025-08-28 02:10:28', '2025-08-28 02:10:28'),
(416, 417, 15, '242510154', 0.00, 0, '2025-08-28 02:10:28', '2025-08-28 02:10:28'),
(417, 418, 15, '242510155', 0.00, 0, '2025-08-28 02:10:28', '2025-08-28 02:10:28'),
(418, 419, 15, '242510156', 0.00, 0, '2025-08-28 02:10:29', '2025-08-28 02:10:29'),
(419, 420, 15, '242510157', 0.00, 0, '2025-08-28 02:10:29', '2025-08-28 02:10:29'),
(420, 421, 15, '242510158', 0.00, 0, '2025-08-28 02:10:29', '2025-08-28 02:10:29'),
(421, 422, 15, '242510159', 0.00, 0, '2025-08-28 02:10:29', '2025-08-28 02:10:29'),
(422, 423, 15, '242510160', 0.00, 0, '2025-08-28 02:10:30', '2025-08-28 02:10:30'),
(423, 424, 15, '242510161', 0.00, 0, '2025-08-28 02:10:30', '2025-08-28 02:10:30'),
(424, 425, 15, '242510162', 0.00, 0, '2025-08-28 02:10:30', '2025-08-28 02:10:30'),
(425, 426, 15, '242510163', 0.00, 0, '2025-08-28 02:10:31', '2025-08-28 02:10:31'),
(426, 427, 15, '242510164', 0.00, 0, '2025-08-28 02:10:31', '2025-08-28 02:10:31'),
(427, 428, 15, '242510165', 0.00, 0, '2025-08-28 02:10:31', '2025-08-28 02:10:31'),
(428, 429, 15, '242510166', 0.00, 0, '2025-08-28 02:10:31', '2025-08-28 02:10:31'),
(429, 430, 15, '242510167', 0.00, 0, '2025-08-28 02:10:32', '2025-08-28 02:10:32'),
(430, 431, 15, '242510168', 0.00, 0, '2025-08-28 02:10:32', '2025-08-28 02:10:32'),
(431, 432, 15, '242510169', 0.00, 0, '2025-08-28 02:10:32', '2025-08-28 02:10:32'),
(432, 433, 15, '242510170', 0.00, 0, '2025-08-28 02:10:32', '2025-08-28 02:10:32'),
(433, 434, 15, '242510171', 0.00, 0, '2025-08-28 02:10:33', '2025-08-28 02:10:33'),
(434, 435, 15, '242510172', 0.00, 0, '2025-08-28 02:10:33', '2025-08-28 02:10:33'),
(435, 436, 15, '242510173', 0.00, 0, '2025-08-28 02:10:33', '2025-08-28 02:10:33'),
(436, 437, 15, '242510174', 0.00, 0, '2025-08-28 02:10:34', '2025-08-28 02:10:34'),
(437, 438, 15, '242510175', 0.00, 0, '2025-08-28 02:10:34', '2025-08-28 02:10:34'),
(438, 439, 15, '242510176', 0.00, 0, '2025-08-28 02:10:34', '2025-08-28 02:10:34'),
(439, 440, 15, '242510177', 0.00, 0, '2025-08-28 02:10:34', '2025-08-28 02:10:34'),
(440, 441, 15, '242510178', 0.00, 0, '2025-08-28 02:10:35', '2025-08-28 02:10:35'),
(441, 442, 16, '242510179', 0.00, 0, '2025-08-28 02:10:35', '2025-08-28 02:10:35'),
(442, 443, 16, '242510180', 0.00, 0, '2025-08-28 02:10:35', '2025-08-28 02:10:35'),
(443, 444, 16, '242510181', 0.00, 0, '2025-08-28 02:10:36', '2025-08-28 02:10:36'),
(444, 445, 16, '242510182', 0.00, 0, '2025-08-28 02:10:36', '2025-08-28 02:10:36'),
(445, 446, 16, '242510183', 0.00, 0, '2025-08-28 02:10:36', '2025-08-28 02:10:36'),
(446, 447, 16, '242510184', 0.00, 0, '2025-08-28 02:10:36', '2025-08-28 02:10:36'),
(447, 448, 16, '242510185', 0.00, 0, '2025-08-28 02:10:37', '2025-08-28 02:10:37'),
(448, 449, 16, '242510186', 0.00, 0, '2025-08-28 02:10:37', '2025-08-28 02:10:37'),
(449, 450, 16, '242510187', 0.00, 0, '2025-08-28 02:10:38', '2025-08-28 02:10:38'),
(450, 451, 16, '242510188', 0.00, 0, '2025-08-28 02:10:38', '2025-08-28 02:10:38'),
(451, 452, 16, '242510189', 0.00, 0, '2025-08-28 02:10:38', '2025-08-28 02:10:38'),
(452, 453, 16, '242510190', 0.00, 0, '2025-08-28 02:10:38', '2025-08-28 02:10:38'),
(453, 454, 16, '242510191', 0.00, 0, '2025-08-28 02:10:39', '2025-08-28 02:10:39'),
(454, 455, 16, '242510192', 0.00, 0, '2025-08-28 02:10:39', '2025-08-28 02:10:39'),
(455, 456, 16, '242510193', 0.00, 0, '2025-08-28 02:10:39', '2025-08-28 02:10:39'),
(456, 457, 16, '242510194', 0.00, 0, '2025-08-28 02:10:39', '2025-08-28 02:10:39'),
(457, 458, 16, '242510195', 0.00, 0, '2025-08-28 02:10:40', '2025-08-28 02:10:40'),
(458, 459, 16, '242510196', 0.00, 0, '2025-08-28 02:10:40', '2025-08-28 02:10:40'),
(459, 460, 16, '242510197', 0.00, 0, '2025-08-28 02:10:40', '2025-08-28 02:10:40'),
(460, 461, 16, '242510198', 0.00, 0, '2025-08-28 02:10:41', '2025-08-28 02:10:41'),
(461, 462, 16, '242510199', 0.00, 0, '2025-08-28 02:10:41', '2025-08-28 02:10:41'),
(462, 463, 16, '242510200', 0.00, 0, '2025-08-28 02:11:00', '2025-08-28 02:11:00'),
(463, 464, 16, '242510201', 0.00, 0, '2025-08-28 02:11:01', '2025-08-28 02:11:01'),
(464, 465, 16, '242510202', 0.00, 0, '2025-08-28 02:11:01', '2025-08-28 02:11:01'),
(465, 466, 16, '242510203', 0.00, 0, '2025-08-28 02:11:01', '2025-08-28 02:11:01'),
(466, 467, 16, '242510204', 0.00, 0, '2025-08-28 02:11:01', '2025-08-28 02:11:01'),
(467, 468, 16, '242510205', 0.00, 0, '2025-08-28 02:11:02', '2025-08-28 02:11:02'),
(468, 469, 16, '242510206', 0.00, 0, '2025-08-28 02:11:02', '2025-08-28 02:11:02'),
(469, 470, 16, '242510207', 0.00, 0, '2025-08-28 02:11:02', '2025-08-28 02:11:02'),
(470, 471, 16, '242510208', 0.00, 0, '2025-08-28 02:11:03', '2025-08-28 02:11:03'),
(471, 472, 16, '242510209', 0.00, 0, '2025-08-28 02:11:03', '2025-08-28 02:11:03'),
(472, 473, 16, '242510210', 0.00, 0, '2025-08-28 02:11:03', '2025-08-28 02:11:03'),
(473, 474, 17, '242510211', 0.00, 0, '2025-08-28 02:11:03', '2025-08-28 02:11:03'),
(474, 475, 17, '242510212', 0.00, 0, '2025-08-28 02:11:04', '2025-08-28 02:11:04'),
(475, 476, 17, '242510213', 0.00, 0, '2025-08-28 02:11:04', '2025-08-28 02:11:04'),
(476, 477, 17, '242510214', 0.00, 0, '2025-08-28 02:11:04', '2025-08-28 02:11:04'),
(477, 478, 17, '242510215', 0.00, 0, '2025-08-28 02:11:05', '2025-08-28 02:11:05'),
(478, 479, 17, '242510216', 0.00, 0, '2025-08-28 02:11:05', '2025-08-28 02:11:05'),
(479, 480, 17, '242510217', 0.00, 0, '2025-08-28 02:11:05', '2025-08-28 02:11:05'),
(480, 481, 17, '242510218', 0.00, 0, '2025-08-28 02:11:05', '2025-08-28 02:11:05'),
(481, 482, 17, '242510219', 0.00, 0, '2025-08-28 02:11:06', '2025-08-28 02:11:06'),
(482, 483, 17, '242510220', 0.00, 0, '2025-08-28 02:11:06', '2025-08-28 02:11:06'),
(483, 484, 17, '242510221', 0.00, 0, '2025-08-28 02:11:06', '2025-08-28 02:11:06'),
(484, 485, 17, '242510222', 0.00, 0, '2025-08-28 02:11:06', '2025-08-28 02:11:06'),
(485, 486, 17, '242510223', 0.00, 0, '2025-08-28 02:11:07', '2025-08-28 02:11:07'),
(486, 487, 17, '242510224', 0.00, 0, '2025-08-28 02:11:07', '2025-08-28 02:11:07'),
(487, 488, 17, '242510225', 0.00, 0, '2025-08-28 02:11:07', '2025-08-28 02:11:07'),
(488, 489, 17, '242510226', 0.00, 0, '2025-08-28 02:11:08', '2025-08-28 02:11:08'),
(489, 490, 17, '242510227', 0.00, 0, '2025-08-28 02:11:08', '2025-08-28 02:11:08'),
(490, 491, 17, '242510228', 0.00, 0, '2025-08-28 02:11:08', '2025-08-28 02:11:08'),
(491, 492, 17, '242510229', 0.00, 0, '2025-08-28 02:11:08', '2025-08-28 02:11:08'),
(492, 493, 17, '242510230', 0.00, 0, '2025-08-28 02:11:09', '2025-08-28 02:11:09'),
(493, 494, 17, '242510231', 0.00, 0, '2025-08-28 02:11:09', '2025-08-28 02:11:09'),
(494, 495, 17, '242510232', 0.00, 0, '2025-08-28 02:11:09', '2025-08-28 02:11:09'),
(495, 496, 17, '242510233', 0.00, 0, '2025-08-28 02:11:10', '2025-08-28 02:11:10'),
(496, 497, 17, '242510234', 0.00, 0, '2025-08-28 02:11:10', '2025-08-28 02:11:10'),
(497, 498, 17, '242510235', 0.00, 0, '2025-08-28 02:11:10', '2025-08-28 02:11:10'),
(498, 499, 17, '242510236', 0.00, 0, '2025-08-28 02:11:10', '2025-08-28 02:11:10'),
(499, 500, 18, '242510237', 0.00, 0, '2025-08-28 02:11:11', '2025-08-28 02:11:11'),
(500, 501, 18, '242510238', 0.00, 0, '2025-08-28 02:11:11', '2025-08-28 02:11:11'),
(501, 502, 18, '242510239', 0.00, 0, '2025-08-28 02:11:11', '2025-08-28 02:11:11'),
(502, 503, 18, '242510240', 0.00, 0, '2025-08-28 02:11:11', '2025-08-28 02:11:11'),
(503, 504, 18, '242510241', 0.00, 0, '2025-08-28 02:11:12', '2025-08-28 02:11:12'),
(504, 505, 18, '242510242', 0.00, 0, '2025-08-28 02:11:12', '2025-08-28 02:11:12'),
(505, 506, 18, '242510243', 0.00, 0, '2025-08-28 02:11:12', '2025-08-28 02:11:12'),
(506, 507, 18, '242510244', 0.00, 0, '2025-08-28 02:11:13', '2025-08-28 02:11:13'),
(507, 508, 18, '242510245', 0.00, 0, '2025-08-28 02:11:13', '2025-08-28 02:11:13'),
(508, 509, 18, '242510246', 0.00, 0, '2025-08-28 02:11:13', '2025-08-28 02:11:13'),
(509, 510, 18, '242510247', 0.00, 0, '2025-08-28 02:11:13', '2025-08-28 02:11:13'),
(510, 511, 18, '242510248', 0.00, 0, '2025-08-28 02:11:14', '2025-08-28 02:11:14'),
(511, 512, 18, '242510249', 0.00, 0, '2025-08-28 02:11:14', '2025-08-28 02:11:14'),
(512, 513, 18, '242510250', 0.00, 0, '2025-08-28 02:11:14', '2025-08-28 02:11:14'),
(513, 514, 18, '242510251', 0.00, 0, '2025-08-28 02:11:15', '2025-08-28 02:11:15'),
(514, 515, 18, '242510252', 0.00, 0, '2025-08-28 02:11:15', '2025-08-28 02:11:15'),
(515, 516, 18, '242510253', 0.00, 0, '2025-08-28 02:11:15', '2025-08-28 02:11:15'),
(516, 517, 18, '242510254', 0.00, 0, '2025-08-28 02:11:15', '2025-08-28 02:11:15'),
(517, 518, 18, '242510255', 0.00, 0, '2025-08-28 02:11:16', '2025-08-28 02:11:16'),
(518, 519, 18, '242510256', 0.00, 0, '2025-08-28 02:11:16', '2025-08-28 02:11:16'),
(519, 520, 18, '242510257', 0.00, 0, '2025-08-28 02:11:16', '2025-08-28 02:11:16'),
(520, 521, 18, '242510258', 0.00, 0, '2025-08-28 02:11:17', '2025-08-28 02:11:17'),
(521, 522, 18, '242510259', 0.00, 0, '2025-08-28 02:11:17', '2025-08-28 02:11:17'),
(522, 523, 18, '242510260', 0.00, 0, '2025-08-28 02:11:17', '2025-08-28 02:11:17'),
(523, 524, 18, '242510261', 0.00, 0, '2025-08-28 02:11:17', '2025-08-28 02:11:17'),
(524, 525, 18, '242510262', 0.00, 0, '2025-08-28 02:11:18', '2025-08-28 02:11:18'),
(525, 526, 18, '242510263', 0.00, 0, '2025-08-28 02:11:18', '2025-08-28 02:11:18'),
(526, 527, 18, '242510264', 0.00, 0, '2025-08-28 02:11:18', '2025-08-28 02:11:18'),
(527, 528, 19, '232410001', 0.00, 0, '2025-08-28 02:11:25', '2025-08-28 02:11:25'),
(528, 529, 19, '232410002', 0.00, 0, '2025-08-28 02:11:25', '2025-08-28 02:11:25'),
(529, 530, 19, '232410003', 0.00, 0, '2025-08-28 02:11:25', '2025-08-28 02:11:25'),
(530, 531, 19, '232410004', 0.00, 0, '2025-08-28 02:11:25', '2025-08-28 02:11:25'),
(531, 532, 19, '232410005', 0.00, 0, '2025-08-28 02:11:26', '2025-08-28 02:11:26'),
(532, 533, 19, '232410006', 0.00, 0, '2025-08-28 02:11:26', '2025-08-28 02:11:26'),
(533, 534, 19, '232410007', 0.00, 0, '2025-08-28 02:11:26', '2025-08-28 02:11:26'),
(534, 535, 19, '232410008', 0.00, 0, '2025-08-28 02:11:27', '2025-08-28 02:11:27'),
(535, 536, 19, '232410009', 0.00, 0, '2025-08-28 02:11:27', '2025-08-28 02:11:27'),
(536, 537, 19, '232410010', 0.00, 0, '2025-08-28 02:11:27', '2025-08-28 02:11:27'),
(537, 538, 19, '232410011', 0.00, 0, '2025-08-28 02:11:27', '2025-08-28 02:11:27'),
(538, 539, 19, '232410012', 0.00, 0, '2025-08-28 02:11:28', '2025-08-28 02:11:28'),
(539, 540, 19, '232410013', 0.00, 0, '2025-08-28 02:11:28', '2025-08-28 02:11:28'),
(540, 541, 19, '232410014', 0.00, 0, '2025-08-28 02:11:28', '2025-08-28 02:11:28'),
(541, 542, 19, '232410015', 0.00, 0, '2025-08-28 02:11:28', '2025-08-28 02:11:28'),
(542, 543, 19, '232410016', 0.00, 0, '2025-08-28 02:11:29', '2025-08-28 02:11:29'),
(543, 544, 19, '232410017', 0.00, 0, '2025-08-28 02:11:29', '2025-08-28 02:11:29'),
(544, 545, 19, '232410018', 0.00, 0, '2025-08-28 02:11:29', '2025-08-28 02:11:29'),
(545, 546, 19, '232410019', 0.00, 0, '2025-08-28 02:11:29', '2025-08-28 02:11:29'),
(546, 547, 19, '232410020', 0.00, 0, '2025-08-28 02:11:30', '2025-08-28 02:11:30'),
(547, 548, 19, '232410021', 0.00, 0, '2025-08-28 02:11:30', '2025-08-28 02:11:30'),
(548, 549, 19, '232410022', 0.00, 0, '2025-08-28 02:11:30', '2025-08-28 02:11:30'),
(549, 550, 19, '232410023', 0.00, 0, '2025-08-28 02:11:31', '2025-08-28 02:11:31'),
(550, 551, 19, '232410024', 0.00, 0, '2025-08-28 02:11:31', '2025-08-28 02:11:31'),
(551, 552, 19, '232410025', 0.00, 0, '2025-08-28 02:11:31', '2025-08-28 02:11:31'),
(552, 553, 19, '232410026', 0.00, 0, '2025-08-28 02:11:31', '2025-08-28 02:11:31'),
(553, 554, 20, '232410027', 0.00, 0, '2025-08-28 02:11:32', '2025-08-28 02:11:32'),
(554, 555, 20, '232410028', 0.00, 0, '2025-08-28 02:11:32', '2025-08-28 02:11:32'),
(555, 556, 20, '232410029', 0.00, 0, '2025-08-28 02:11:32', '2025-08-28 02:11:32'),
(556, 557, 20, '232410030', 0.00, 0, '2025-08-28 02:11:32', '2025-08-28 02:11:32'),
(557, 558, 20, '232410031', 0.00, 0, '2025-08-28 02:11:33', '2025-08-28 02:11:33'),
(558, 559, 20, '232410032', 0.00, 0, '2025-08-28 02:11:33', '2025-08-28 02:11:33'),
(559, 560, 20, '232410033', 0.00, 0, '2025-08-28 02:11:33', '2025-08-28 02:11:33'),
(560, 561, 20, '232410034', 0.00, 0, '2025-08-28 02:11:33', '2025-08-28 02:11:33'),
(561, 562, 20, '232410035', 0.00, 0, '2025-08-28 02:11:34', '2025-08-28 02:11:34'),
(562, 563, 20, '232410036', 0.00, 0, '2025-08-28 02:11:34', '2025-08-28 02:11:34'),
(563, 564, 20, '232410037', 0.00, 0, '2025-08-28 02:11:34', '2025-08-28 02:11:34'),
(564, 565, 20, '232410038', 0.00, 0, '2025-08-28 02:11:35', '2025-08-28 02:11:35'),
(565, 566, 20, '232410039', 0.00, 0, '2025-08-28 02:11:35', '2025-08-28 02:11:35'),
(566, 567, 20, '232410040', 0.00, 0, '2025-08-28 02:11:35', '2025-08-28 02:11:35'),
(567, 568, 20, '232410041', 0.00, 0, '2025-08-28 02:11:35', '2025-08-28 02:11:35'),
(568, 569, 20, '232410042', 0.00, 0, '2025-08-28 02:11:36', '2025-08-28 02:11:36'),
(569, 570, 20, '232410043', 0.00, 0, '2025-08-28 02:11:36', '2025-08-28 02:11:36'),
(570, 571, 20, '232410044', 0.00, 0, '2025-08-28 02:11:36', '2025-08-28 02:11:36'),
(571, 572, 20, '232410045', 0.00, 0, '2025-08-28 02:11:36', '2025-08-28 02:11:36'),
(572, 573, 20, '232410046', 0.00, 0, '2025-08-28 02:11:37', '2025-08-28 02:11:37'),
(573, 574, 20, '232410047', 0.00, 0, '2025-08-28 02:11:37', '2025-08-28 02:11:37'),
(574, 575, 20, '232410048', 0.00, 0, '2025-08-28 02:11:37', '2025-08-28 02:11:37'),
(575, 576, 20, '232410049', 0.00, 0, '2025-08-28 02:11:38', '2025-08-28 02:11:38'),
(576, 577, 20, '232410050', 0.00, 0, '2025-08-28 02:11:38', '2025-08-28 02:11:38'),
(577, 578, 20, '232410051', 0.00, 0, '2025-08-28 02:11:38', '2025-08-28 02:11:38'),
(578, 579, 21, '232410052', 0.00, 0, '2025-08-28 02:11:38', '2025-08-28 02:11:38'),
(579, 580, 21, '232410053', 0.00, 0, '2025-08-28 02:11:39', '2025-08-28 02:11:39'),
(580, 581, 21, '232410054', 0.00, 0, '2025-08-28 02:11:39', '2025-08-28 02:11:39'),
(581, 582, 21, '232410055', 0.00, 0, '2025-08-28 02:11:39', '2025-08-28 02:11:39'),
(582, 583, 21, '232410056', 0.00, 0, '2025-08-28 02:11:39', '2025-08-28 02:11:39'),
(583, 584, 21, '232410057', 0.00, 0, '2025-08-28 02:11:40', '2025-08-28 02:11:40'),
(584, 585, 21, '232410058', 0.00, 0, '2025-08-28 02:11:40', '2025-08-28 02:11:40'),
(585, 586, 21, '232410059', 0.00, 0, '2025-08-28 02:11:40', '2025-08-28 02:11:40'),
(586, 587, 21, '232410060', 0.00, 0, '2025-08-28 02:11:40', '2025-08-28 02:11:40'),
(587, 588, 21, '232410061', 0.00, 0, '2025-08-28 02:11:41', '2025-08-28 02:11:41'),
(588, 589, 21, '232410062', 0.00, 0, '2025-08-28 02:11:41', '2025-08-28 02:11:41'),
(589, 590, 21, '232410063', 0.00, 0, '2025-08-28 02:11:41', '2025-08-28 02:11:41'),
(590, 591, 21, '232410064', 0.00, 0, '2025-08-28 02:11:42', '2025-08-28 02:11:42'),
(591, 592, 21, '232410065', 0.00, 0, '2025-08-28 02:11:42', '2025-08-28 02:11:42'),
(592, 593, 21, '232410066', 0.00, 0, '2025-08-28 02:11:42', '2025-08-28 02:11:42'),
(593, 594, 21, '232410067', 0.00, 0, '2025-08-28 02:11:42', '2025-08-28 02:11:42'),
(594, 595, 21, '232410068', 0.00, 0, '2025-08-28 02:11:43', '2025-08-28 02:11:43'),
(595, 596, 21, '232410069', 0.00, 0, '2025-08-28 02:11:43', '2025-08-28 02:11:43'),
(596, 597, 21, '232410070', 0.00, 0, '2025-08-28 02:11:43', '2025-08-28 02:11:43'),
(597, 598, 21, '232410071', 0.00, 0, '2025-08-28 02:11:43', '2025-08-28 02:11:43'),
(598, 599, 21, '232410072', 0.00, 0, '2025-08-28 02:11:44', '2025-08-28 02:11:44'),
(599, 600, 21, '232410073', 0.00, 0, '2025-08-28 02:11:44', '2025-08-28 02:11:44'),
(600, 601, 21, '232410074', 0.00, 0, '2025-08-28 02:11:44', '2025-08-28 02:11:44'),
(601, 602, 21, '232410075', 0.00, 0, '2025-08-28 02:11:45', '2025-08-28 02:11:45'),
(602, 603, 21, '232410076', 0.00, 0, '2025-08-28 02:11:45', '2025-08-28 02:11:45'),
(603, 604, 21, '232410077', 0.00, 0, '2025-08-28 02:11:45', '2025-08-28 02:11:45'),
(604, 605, 21, '232410078', 0.00, 0, '2025-08-28 02:11:45', '2025-08-28 02:11:45'),
(605, 606, 21, '232410079', 0.00, 0, '2025-08-28 02:11:46', '2025-08-28 02:11:46'),
(606, 607, 21, '232410080', 0.00, 0, '2025-08-28 02:11:46', '2025-08-28 02:11:46'),
(607, 608, 21, '232410081', 0.00, 0, '2025-08-28 02:11:46', '2025-08-28 02:11:46'),
(608, 609, 21, '232410082', 0.00, 0, '2025-08-28 02:11:46', '2025-08-28 02:11:46'),
(609, 610, 21, '232410083', 0.00, 0, '2025-08-28 02:11:47', '2025-08-28 02:11:47'),
(610, 611, 21, '232410084', 0.00, 0, '2025-08-28 02:11:47', '2025-08-28 02:11:47'),
(611, 612, 22, '232410085', 0.00, 0, '2025-08-28 02:11:47', '2025-08-28 02:11:47'),
(612, 613, 22, '232410086', 0.00, 0, '2025-08-28 02:11:48', '2025-08-28 02:11:48'),
(613, 614, 22, '232410087', 0.00, 0, '2025-08-28 02:11:48', '2025-08-28 02:11:48'),
(614, 615, 22, '232410088', 0.00, 0, '2025-08-28 02:11:48', '2025-08-28 02:11:48');
INSERT INTO `siswa` (`id`, `id_pengguna`, `id_kelas`, `nis`, `saldo`, `points`, `created_at`, `updated_at`) VALUES
(615, 616, 22, '232410089', 0.00, 0, '2025-08-28 02:11:48', '2025-08-28 02:11:48'),
(616, 617, 22, '232410090', 0.00, 0, '2025-08-28 02:11:49', '2025-08-28 02:11:49'),
(617, 618, 22, '232410091', 0.00, 0, '2025-08-28 02:11:49', '2025-08-28 02:11:49'),
(618, 619, 22, '232410092', 0.00, 0, '2025-08-28 02:11:49', '2025-08-28 02:11:49'),
(619, 620, 22, '232410093', 0.00, 0, '2025-08-28 02:11:49', '2025-08-28 02:11:49'),
(620, 621, 22, '232410094', 0.00, 0, '2025-08-28 02:11:50', '2025-08-28 02:11:50'),
(621, 622, 22, '232410095', 0.00, 0, '2025-08-28 02:11:50', '2025-08-28 02:11:50'),
(622, 623, 22, '232410096', 0.00, 0, '2025-08-28 02:11:50', '2025-08-28 02:11:50'),
(623, 624, 22, '232410097', 0.00, 0, '2025-08-28 02:11:50', '2025-08-28 02:11:50'),
(624, 625, 22, '232410098', 0.00, 0, '2025-08-28 02:11:51', '2025-08-28 02:11:51'),
(625, 626, 22, '232410099', 0.00, 0, '2025-08-28 02:11:51', '2025-08-28 02:11:51'),
(626, 627, 22, '232410100', 0.00, 0, '2025-08-28 02:11:51', '2025-08-28 02:11:51'),
(627, 628, 22, '232410101', 0.00, 0, '2025-08-28 02:11:52', '2025-08-28 02:11:52'),
(628, 629, 22, '232410102', 0.00, 0, '2025-08-28 02:11:52', '2025-08-28 02:11:52'),
(629, 630, 22, '232410103', 0.00, 0, '2025-08-28 02:11:52', '2025-08-28 02:11:52'),
(630, 631, 22, '232410104', 0.00, 0, '2025-08-28 02:11:52', '2025-08-28 02:11:52'),
(631, 632, 22, '232410105', 0.00, 0, '2025-08-28 02:11:53', '2025-08-28 02:11:53'),
(632, 633, 22, '232410106', 0.00, 0, '2025-08-28 02:11:53', '2025-08-28 02:11:53'),
(633, 634, 22, '232410107', 0.00, 0, '2025-08-28 02:11:53', '2025-08-28 02:11:53'),
(634, 635, 22, '232410108', 0.00, 0, '2025-08-28 02:11:54', '2025-08-28 02:11:54'),
(635, 636, 22, '232410109', 0.00, 0, '2025-08-28 02:11:54', '2025-08-28 02:11:54'),
(636, 637, 22, '232410110', 0.00, 0, '2025-08-28 02:11:54', '2025-08-28 02:11:54'),
(637, 638, 22, '232410111', 0.00, 0, '2025-08-28 02:11:54', '2025-08-28 02:11:54'),
(638, 639, 22, '232410112', 0.00, 0, '2025-08-28 02:11:55', '2025-08-28 02:11:55'),
(639, 640, 22, '232410113', 0.00, 0, '2025-08-28 02:11:55', '2025-08-28 02:11:55'),
(640, 641, 22, '232410114', 0.00, 0, '2025-08-28 02:11:55', '2025-08-28 02:11:55'),
(641, 642, 22, '232410115', 0.00, 0, '2025-08-28 02:11:56', '2025-08-28 02:11:56'),
(642, 643, 22, '232410116', 0.00, 0, '2025-08-28 02:11:56', '2025-08-28 02:11:56'),
(643, 644, 22, '232410117', 0.00, 0, '2025-08-28 02:11:56', '2025-08-28 02:11:56'),
(644, 645, 22, '232410118', 0.00, 0, '2025-08-28 02:11:56', '2025-08-28 02:11:56'),
(645, 646, 23, '232410119', 0.00, 0, '2025-08-28 02:11:57', '2025-08-28 02:11:57'),
(646, 647, 23, '232410120', 0.00, 0, '2025-08-28 02:11:57', '2025-08-28 02:11:57'),
(647, 648, 23, '232410121', 0.00, 0, '2025-08-28 02:11:57', '2025-08-28 02:11:57'),
(648, 649, 23, '232410122', 0.00, 0, '2025-08-28 02:11:57', '2025-08-28 02:11:57'),
(649, 650, 23, '232410123', 0.00, 0, '2025-08-28 02:11:58', '2025-08-28 02:11:58'),
(650, 651, 23, '232410124', 0.00, 0, '2025-08-28 02:11:58', '2025-08-28 02:11:58'),
(651, 652, 23, '232410125', 0.00, 0, '2025-08-28 02:11:58', '2025-08-28 02:11:58'),
(652, 653, 23, '232410126', 0.00, 0, '2025-08-28 02:11:59', '2025-08-28 02:11:59'),
(653, 654, 23, '232410127', 0.00, 0, '2025-08-28 02:11:59', '2025-08-28 02:11:59'),
(654, 655, 23, '232410128', 0.00, 0, '2025-08-28 02:11:59', '2025-08-28 02:11:59'),
(655, 656, 23, '232410129', 0.00, 0, '2025-08-28 02:11:59', '2025-08-28 02:11:59'),
(656, 657, 23, '232410130', 0.00, 0, '2025-08-28 02:12:00', '2025-08-28 02:12:00'),
(657, 658, 23, '232410131', 0.00, 0, '2025-08-28 02:12:00', '2025-08-28 02:12:00'),
(658, 659, 23, '232410132', 0.00, 0, '2025-08-28 02:12:00', '2025-08-28 02:12:00'),
(659, 660, 23, '232410133', 0.00, 0, '2025-08-28 02:12:00', '2025-08-28 02:12:00'),
(660, 661, 23, '232410134', 0.00, 0, '2025-08-28 02:12:01', '2025-08-28 02:12:01'),
(661, 662, 23, '232410135', 0.00, 0, '2025-08-28 02:12:01', '2025-08-28 02:12:01'),
(662, 663, 23, '232410136', 0.00, 0, '2025-08-28 02:12:01', '2025-08-28 02:12:01'),
(663, 664, 23, '232410137', 0.00, 0, '2025-08-28 02:12:01', '2025-08-28 02:12:01'),
(664, 665, 23, '232410138', 0.00, 0, '2025-08-28 02:12:02', '2025-08-28 02:12:02'),
(665, 666, 23, '232410139', 0.00, 0, '2025-08-28 02:12:02', '2025-08-28 02:12:02'),
(666, 667, 23, '232410140', 0.00, 0, '2025-08-28 02:12:02', '2025-08-28 02:12:02'),
(667, 668, 23, '232410141', 0.00, 0, '2025-08-28 02:12:03', '2025-08-28 02:12:03'),
(668, 669, 23, '232410142', 0.00, 0, '2025-08-28 02:12:03', '2025-08-28 02:12:03'),
(669, 670, 23, '232410143', 0.00, 0, '2025-08-28 02:12:03', '2025-08-28 02:12:03'),
(670, 671, 23, '232410144', 0.00, 0, '2025-08-28 02:12:03', '2025-08-28 02:12:03'),
(671, 672, 23, '232410145', 0.00, 0, '2025-08-28 02:12:04', '2025-08-28 02:12:04'),
(672, 673, 23, '232410146', 0.00, 0, '2025-08-28 02:12:04', '2025-08-28 02:12:04'),
(673, 674, 23, '232410147', 0.00, 0, '2025-08-28 02:12:04', '2025-08-28 02:12:04'),
(674, 675, 23, '232410148', 0.00, 0, '2025-08-28 02:12:04', '2025-08-28 02:12:04'),
(675, 676, 23, '232410149', 0.00, 0, '2025-08-28 02:12:05', '2025-08-28 02:12:05'),
(676, 677, 23, '232410150', 0.00, 0, '2025-08-28 02:12:05', '2025-08-28 02:12:05'),
(677, 678, 23, '232410151', 0.00, 0, '2025-08-28 02:12:05', '2025-08-28 02:12:05'),
(678, 679, 23, '232410152', 0.00, 0, '2025-08-28 02:12:06', '2025-08-28 02:12:06'),
(679, 680, 23, '232410153', 0.00, 0, '2025-08-28 02:12:06', '2025-08-28 02:12:06'),
(680, 681, 24, '232410154', 0.00, 0, '2025-08-28 02:12:06', '2025-08-28 02:12:06'),
(681, 682, 24, '232410155', 0.00, 0, '2025-08-28 02:12:06', '2025-08-28 02:12:06'),
(682, 683, 24, '232410156', 0.00, 0, '2025-08-28 02:12:07', '2025-08-28 02:12:07'),
(683, 684, 24, '232410157', 0.00, 0, '2025-08-28 02:12:07', '2025-08-28 02:12:07'),
(684, 685, 24, '232410158', 0.00, 0, '2025-08-28 02:12:07', '2025-08-28 02:12:07'),
(685, 686, 24, '232410159', 0.00, 0, '2025-08-28 02:12:07', '2025-08-28 02:12:07'),
(686, 687, 24, '232410160', 0.00, 0, '2025-08-28 02:12:08', '2025-08-28 02:12:08'),
(687, 688, 24, '232410161', 0.00, 0, '2025-08-28 02:12:08', '2025-08-28 02:12:08'),
(688, 689, 24, '232410162', 0.00, 0, '2025-08-28 02:12:08', '2025-08-28 02:12:08'),
(689, 690, 24, '232410163', 0.00, 0, '2025-08-28 02:12:08', '2025-08-28 02:12:08'),
(690, 691, 24, '232410164', 0.00, 0, '2025-08-28 02:12:09', '2025-08-28 02:12:09'),
(691, 692, 24, '232410165', 0.00, 0, '2025-08-28 02:12:09', '2025-08-28 02:12:09'),
(692, 693, 24, '232410166', 0.00, 0, '2025-08-28 02:12:09', '2025-08-28 02:12:09'),
(693, 694, 24, '232410167', 0.00, 0, '2025-08-28 02:12:10', '2025-08-28 02:12:10'),
(694, 695, 24, '232410168', 0.00, 0, '2025-08-28 02:12:10', '2025-08-28 02:12:10'),
(695, 696, 24, '232410169', 0.00, 0, '2025-08-28 02:12:10', '2025-08-28 02:12:10'),
(696, 697, 24, '232410170', 0.00, 0, '2025-08-28 02:12:10', '2025-08-28 02:12:10'),
(697, 698, 24, '232410171', 0.00, 0, '2025-08-28 02:12:11', '2025-08-28 02:12:11'),
(698, 699, 24, '232410172', 0.00, 0, '2025-08-28 02:12:11', '2025-08-28 02:12:11'),
(699, 700, 24, '232410173', 0.00, 0, '2025-08-28 02:12:11', '2025-08-28 02:12:11'),
(700, 701, 24, '232410174', 0.00, 0, '2025-08-28 02:12:11', '2025-08-28 02:12:11'),
(701, 702, 24, '232410175', 0.00, 0, '2025-08-28 02:12:12', '2025-08-28 02:12:12'),
(702, 703, 24, '232410176', 0.00, 0, '2025-08-28 02:12:12', '2025-08-28 02:12:12'),
(703, 704, 24, '232410177', 0.00, 0, '2025-08-28 02:12:12', '2025-08-28 02:12:12'),
(704, 705, 24, '232410178', 0.00, 0, '2025-08-28 02:12:13', '2025-08-28 02:12:13'),
(705, 706, 24, '232410179', 0.00, 0, '2025-08-28 02:12:13', '2025-08-28 02:12:13'),
(706, 707, 24, '232410180', 0.00, 0, '2025-08-28 02:12:13', '2025-08-28 02:12:13'),
(707, 708, 24, '232410181', 0.00, 0, '2025-08-28 02:12:13', '2025-08-28 02:12:13'),
(708, 709, 24, '232410182', 0.00, 0, '2025-08-28 02:12:14', '2025-08-28 02:12:14'),
(709, 710, 24, '232410183', 0.00, 0, '2025-08-28 02:12:14', '2025-08-28 02:12:14'),
(710, 711, 24, '232410184', 0.00, 0, '2025-08-28 02:12:14', '2025-08-28 02:12:14'),
(711, 712, 24, '232410185', 0.00, 0, '2025-08-28 02:12:14', '2025-08-28 02:12:14'),
(712, 713, 24, '232410186', 0.00, 0, '2025-08-28 02:12:15', '2025-08-28 02:12:15'),
(713, 714, 24, '232410187', 0.00, 0, '2025-08-28 02:12:15', '2025-08-28 02:12:15'),
(714, 715, 25, '232410188', 0.00, 0, '2025-08-28 02:12:15', '2025-08-28 02:12:15'),
(715, 716, 25, '232410189', 0.00, 0, '2025-08-28 02:12:15', '2025-08-28 02:12:15'),
(716, 717, 25, '232410190', 0.00, 0, '2025-08-28 02:12:16', '2025-08-28 02:12:16'),
(717, 718, 25, '232410191', 0.00, 0, '2025-08-28 02:12:16', '2025-08-28 02:12:16'),
(718, 719, 25, '232410192', 0.00, 0, '2025-08-28 02:12:16', '2025-08-28 02:12:16'),
(719, 720, 25, '232410193', 0.00, 0, '2025-08-28 02:12:17', '2025-08-28 02:12:17'),
(720, 721, 25, '232410194', 0.00, 0, '2025-08-28 02:12:17', '2025-08-28 02:12:17'),
(721, 722, 25, '232410195', 0.00, 0, '2025-08-28 02:12:17', '2025-08-28 02:12:17'),
(722, 723, 25, '232410196', 0.00, 0, '2025-08-28 02:12:17', '2025-08-28 02:12:17'),
(723, 724, 25, '232410197', 0.00, 0, '2025-08-28 02:12:18', '2025-08-28 02:12:18'),
(724, 725, 25, '232410198', 0.00, 0, '2025-08-28 02:12:18', '2025-08-28 02:12:18'),
(725, 726, 25, '232410199', 0.00, 0, '2025-08-28 02:12:18', '2025-08-28 02:12:18'),
(726, 727, 25, '232410200', 0.00, 0, '2025-08-28 02:12:25', '2025-08-28 02:12:25'),
(727, 728, 25, '232410201', 0.00, 0, '2025-08-28 02:12:25', '2025-08-28 02:12:25'),
(728, 729, 25, '232410202', 0.00, 0, '2025-08-28 02:12:25', '2025-08-28 02:12:25'),
(729, 730, 25, '232410203', 0.00, 0, '2025-08-28 02:12:26', '2025-08-28 02:12:26'),
(730, 731, 25, '232410204', 0.00, 0, '2025-08-28 02:12:26', '2025-08-28 02:12:26'),
(731, 732, 25, '232410205', 0.00, 0, '2025-08-28 02:12:26', '2025-08-28 02:12:26'),
(732, 733, 25, '232410206', 0.00, 0, '2025-08-28 02:12:27', '2025-08-28 02:12:27'),
(733, 734, 25, '232410207', 0.00, 0, '2025-08-28 02:12:27', '2025-08-28 02:12:27'),
(734, 735, 25, '232410208', 0.00, 0, '2025-08-28 02:12:27', '2025-08-28 02:12:27'),
(735, 736, 25, '232410209', 0.00, 0, '2025-08-28 02:12:27', '2025-08-28 02:12:27'),
(736, 737, 25, '232410210', 0.00, 0, '2025-08-28 02:12:28', '2025-08-28 02:12:28'),
(737, 738, 25, '232410211', 0.00, 0, '2025-08-28 02:12:28', '2025-08-28 02:12:28'),
(738, 739, 25, '232410212', 0.00, 0, '2025-08-28 02:12:28', '2025-08-28 02:12:28'),
(739, 740, 25, '232410213', 0.00, 0, '2025-08-28 02:12:28', '2025-08-28 02:12:28'),
(740, 741, 25, '232410214', 0.00, 0, '2025-08-28 02:12:29', '2025-08-28 02:12:29'),
(741, 742, 25, '232410215', 0.00, 0, '2025-08-28 02:12:29', '2025-08-28 02:12:29'),
(742, 743, 25, '232410216', 0.00, 0, '2025-08-28 02:12:29', '2025-08-28 02:12:29'),
(743, 744, 25, '232410217', 0.00, 0, '2025-08-28 02:12:30', '2025-08-28 02:12:30'),
(744, 745, 25, '232410218', 0.00, 0, '2025-08-28 02:12:30', '2025-08-28 02:12:30'),
(745, 746, 25, '232410219', 0.00, 0, '2025-08-28 02:12:30', '2025-08-28 02:12:30'),
(746, 747, 26, '232410220', 0.00, 0, '2025-08-28 02:12:30', '2025-08-28 02:12:30'),
(747, 748, 26, '232410221', 0.00, 0, '2025-08-28 02:12:31', '2025-08-28 02:12:31'),
(748, 749, 26, '232410222', 0.00, 0, '2025-08-28 02:12:31', '2025-08-28 02:12:31'),
(749, 750, 26, '232410223', 0.00, 0, '2025-08-28 02:12:31', '2025-08-28 02:12:31'),
(750, 751, 26, '232410224', 0.00, 0, '2025-08-28 02:12:32', '2025-08-28 02:12:32'),
(751, 752, 26, '232410225', 0.00, 0, '2025-08-28 02:12:32', '2025-08-28 02:12:32'),
(752, 753, 26, '232410226', 0.00, 0, '2025-08-28 02:12:32', '2025-08-28 02:12:32'),
(753, 754, 26, '232410227', 0.00, 0, '2025-08-28 02:12:33', '2025-08-28 02:12:33'),
(754, 755, 26, '232410228', 0.00, 0, '2025-08-28 02:12:33', '2025-08-28 02:12:33'),
(755, 756, 26, '232410229', 0.00, 0, '2025-08-28 02:12:33', '2025-08-28 02:12:33'),
(756, 757, 26, '232410230', 0.00, 0, '2025-08-28 02:12:34', '2025-08-28 02:12:34'),
(757, 758, 26, '232410231', 0.00, 0, '2025-08-28 02:12:34', '2025-08-28 02:12:34'),
(758, 759, 26, '232410232', 0.00, 0, '2025-08-28 02:12:34', '2025-08-28 02:12:34'),
(759, 760, 26, '232410233', 0.00, 0, '2025-08-28 02:12:34', '2025-08-28 02:12:34'),
(760, 761, 26, '232410234', 0.00, 0, '2025-08-28 02:12:35', '2025-08-28 02:12:35'),
(761, 762, 26, '232410235', 0.00, 0, '2025-08-28 02:12:35', '2025-08-28 02:12:35'),
(762, 763, 26, '232410236', 0.00, 0, '2025-08-28 02:12:35', '2025-08-28 02:12:35'),
(763, 764, 26, '232410237', 0.00, 0, '2025-08-28 02:12:35', '2025-08-28 02:12:35'),
(764, 765, 26, '232410238', 0.00, 0, '2025-08-28 02:12:36', '2025-08-28 02:12:36'),
(765, 766, 26, '232410239', 0.00, 0, '2025-08-28 02:12:36', '2025-08-28 02:12:36'),
(766, 767, 26, '232410240', 0.00, 0, '2025-08-28 02:12:36', '2025-08-28 02:12:36'),
(767, 768, 26, '232410241', 0.00, 0, '2025-08-28 02:12:37', '2025-08-28 02:12:37'),
(768, 769, 26, '232410242', 0.00, 0, '2025-08-28 02:12:37', '2025-08-28 02:12:37'),
(769, 770, 26, '232410243', 0.00, 0, '2025-08-28 02:12:37', '2025-08-28 02:12:37'),
(770, 771, 26, '232410244', 0.00, 0, '2025-08-28 02:12:37', '2025-08-28 02:12:37'),
(771, 772, 26, '232410245', 0.00, 0, '2025-08-28 02:12:38', '2025-08-28 02:12:38'),
(772, 773, 26, '232410246', 0.00, 0, '2025-08-28 02:12:38', '2025-08-28 02:12:38'),
(773, 774, 26, '232410247', 0.00, 0, '2025-08-28 02:12:38', '2025-08-28 02:12:38'),
(774, 775, 26, '232410248', 0.00, 0, '2025-08-28 02:12:39', '2025-08-28 02:12:39'),
(775, 776, 26, '232410249', 0.00, 0, '2025-08-28 02:12:39', '2025-08-28 02:12:39'),
(776, 777, 26, '232410250', 0.00, 0, '2025-08-28 02:12:39', '2025-08-28 02:12:39'),
(777, 778, 26, '232410251', 0.00, 0, '2025-08-28 02:12:39', '2025-08-28 02:12:39'),
(778, 779, 26, '232410252', 0.00, 0, '2025-08-28 02:12:40', '2025-08-28 02:12:40'),
(779, 780, 27, '232410253', 0.00, 0, '2025-08-28 02:12:40', '2025-08-28 02:12:40'),
(780, 781, 27, '232410254', 0.00, 0, '2025-08-28 02:12:40', '2025-08-28 02:12:40'),
(781, 782, 27, '232410255', 0.00, 0, '2025-08-28 02:12:41', '2025-08-28 02:12:41'),
(782, 783, 27, '232410256', 0.00, 0, '2025-08-28 02:12:41', '2025-08-28 02:12:41'),
(783, 784, 27, '232410257', 0.00, 0, '2025-08-28 02:12:41', '2025-08-28 02:12:41'),
(784, 785, 27, '232410258', 0.00, 0, '2025-08-28 02:12:41', '2025-08-28 02:12:41'),
(785, 786, 27, '232410259', 0.00, 0, '2025-08-28 02:12:42', '2025-08-28 02:12:42'),
(786, 787, 27, '232410260', 0.00, 0, '2025-08-28 02:12:42', '2025-08-28 02:12:42'),
(787, 788, 27, '232410261', 0.00, 0, '2025-08-28 02:12:42', '2025-08-28 02:12:42'),
(788, 789, 27, '232410262', 0.00, 0, '2025-08-28 02:12:43', '2025-08-28 02:12:43'),
(789, 790, 27, '232410263', 0.00, 0, '2025-08-28 02:12:43', '2025-08-28 02:12:43'),
(790, 791, 27, '232410264', 0.00, 0, '2025-08-28 02:12:43', '2025-08-28 02:12:43'),
(791, 792, 27, '232410265', 0.00, 0, '2025-08-28 02:12:43', '2025-08-28 02:12:43'),
(792, 793, 27, '232410266', 0.00, 0, '2025-08-28 02:12:44', '2025-08-28 02:12:44'),
(793, 794, 27, '232410267', 0.00, 0, '2025-08-28 02:12:44', '2025-08-28 02:12:44'),
(794, 795, 27, '232410268', 0.00, 0, '2025-08-28 02:12:44', '2025-08-28 02:12:44'),
(795, 796, 27, '232410269', 0.00, 0, '2025-08-28 02:12:45', '2025-08-28 02:12:45'),
(796, 797, 27, '232410270', 0.00, 0, '2025-08-28 02:12:45', '2025-08-28 02:12:45'),
(797, 798, 27, '232410271', 0.00, 0, '2025-08-28 02:12:45', '2025-08-28 02:12:45'),
(798, 799, 27, '232410272', 0.00, 0, '2025-08-28 02:12:45', '2025-08-28 02:12:45'),
(799, 800, 27, '232410273', 0.00, 0, '2025-08-28 02:12:46', '2025-08-28 02:12:46'),
(800, 801, 27, '232410274', 0.00, 0, '2025-08-28 02:12:46', '2025-08-28 02:12:46'),
(801, 802, 27, '232410275', 0.00, 0, '2025-08-28 02:12:46', '2025-08-28 02:12:46'),
(802, 803, 27, '232410276', 0.00, 0, '2025-08-28 02:12:47', '2025-08-28 02:12:47'),
(803, 804, 27, '232410277', 0.00, 0, '2025-08-28 02:12:47', '2025-08-28 02:12:47'),
(804, 805, 27, '232410278', 0.00, 0, '2025-08-28 02:12:47', '2025-08-28 02:12:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `badges`
--
ALTER TABLE `badges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `badge_siswa`
--
ALTER TABLE `badge_siswa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `badge_siswa_siswa_id_foreign` (`siswa_id`),
  ADD KEY `badge_siswa_badge_id_foreign` (`badge_id`);

--
-- Indexes for table `buku_kas`
--
ALTER TABLE `buku_kas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buku_kas_id_admin_foreign` (`id_admin`),
  ADD KEY `buku_kas_id_kategori_foreign` (`id_kategori`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detail_penjualan_id_penjualan_foreign` (`id_penjualan`),
  ADD KEY `detail_penjualan_id_jenis_sampah_foreign` (`id_jenis_sampah`);

--
-- Indexes for table `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `kategori_transaksi`
--
ALTER TABLE `kategori_transaksi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `penarikan`
--
ALTER TABLE `penarikan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `penarikan_siswa_id_foreign` (`siswa_id`),
  ADD KEY `penarikan_id_kelas_foreign` (`id_kelas`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pengguna_username_unique` (`username`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `penjualan_id_admin_foreign` (`id_admin`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `setoran`
--
ALTER TABLE `setoran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `setoran_siswa_id_foreign` (`siswa_id`),
  ADD KEY `setoran_jenis_sampah_id_foreign` (`jenis_sampah_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `siswa_nis_unique` (`nis`),
  ADD KEY `siswa_id_pengguna_foreign` (`id_pengguna`),
  ADD KEY `siswa_id_kelas_foreign` (`id_kelas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `badges`
--
ALTER TABLE `badges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `badge_siswa`
--
ALTER TABLE `badge_siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buku_kas`
--
ALTER TABLE `buku_kas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategori_transaksi`
--
ALTER TABLE `kategori_transaksi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `penarikan`
--
ALTER TABLE `penarikan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=806;

--
-- AUTO_INCREMENT for table `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `setoran`
--
ALTER TABLE `setoran`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=805;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `badge_siswa`
--
ALTER TABLE `badge_siswa`
  ADD CONSTRAINT `badge_siswa_badge_id_foreign` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `badge_siswa_siswa_id_foreign` FOREIGN KEY (`siswa_id`) REFERENCES `siswa` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `buku_kas`
--
ALTER TABLE `buku_kas`
  ADD CONSTRAINT `buku_kas_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`),
  ADD CONSTRAINT `buku_kas_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategori_transaksi` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD CONSTRAINT `detail_penjualan_id_jenis_sampah_foreign` FOREIGN KEY (`id_jenis_sampah`) REFERENCES `jenis_sampah` (`id`),
  ADD CONSTRAINT `detail_penjualan_id_penjualan_foreign` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `penarikan`
--
ALTER TABLE `penarikan`
  ADD CONSTRAINT `penarikan_id_kelas_foreign` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id`),
  ADD CONSTRAINT `penarikan_siswa_id_foreign` FOREIGN KEY (`siswa_id`) REFERENCES `siswa` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`);

--
-- Constraints for table `setoran`
--
ALTER TABLE `setoran`
  ADD CONSTRAINT `setoran_jenis_sampah_id_foreign` FOREIGN KEY (`jenis_sampah_id`) REFERENCES `jenis_sampah` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `setoran_siswa_id_foreign` FOREIGN KEY (`siswa_id`) REFERENCES `siswa` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `siswa_id_kelas_foreign` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `siswa_id_pengguna_foreign` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
