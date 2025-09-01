-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 01, 2025 at 05:44 AM
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
-- Table structure for table `insentifs`
--

CREATE TABLE `insentifs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `penjualan_id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `jumlah_insentif` decimal(10,2) NOT NULL,
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
  `status` enum('aktif','tidak aktif') NOT NULL DEFAULT 'aktif',
  `satuan` varchar(255) NOT NULL DEFAULT 'pcs',
  `harga_per_satuan` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_sampah`
--

INSERT INTO `jenis_sampah` (`id`, `nama_sampah`, `status`, `satuan`, `harga_per_satuan`, `stok`, `created_at`, `updated_at`) VALUES
(1, 'Botol Plastik', 'aktif', 'pcs', 35.00, 0, '2025-08-31 18:33:07', '2025-08-31 18:33:07'),
(2, 'Gelas Plastik', 'aktif', 'pcs', 20.00, 0, '2025-08-31 18:33:07', '2025-08-31 18:33:07'),
(3, 'Kardus', 'aktif', 'kg', 2000.00, 0, '2025-08-31 18:33:07', '2025-08-31 18:33:07');

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
(1, 'Transportasi', 'pengeluaran', '2025-09-01 02:01:55', '2025-09-01 02:01:55'),
(2, 'Operasional', 'pengeluaran', '2025-09-01 02:01:59', '2025-09-01 02:01:59'),
(3, 'Hasil Penjualan', 'pemasukan', '2025-09-01 02:02:03', '2025-09-01 02:02:03'),
(4, 'Saldo Awal', 'pemasukan', '2025-09-01 02:02:07', '2025-09-01 02:02:07');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kelas` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_wali_kelas` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id`, `nama_kelas`, `created_at`, `updated_at`, `id_wali_kelas`) VALUES
(1, 'Guru', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(2, 'X MPLB 1', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(3, 'X MPLB 2', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(4, 'X TM 1', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(5, 'X TM 2', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(6, 'X TM 3', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(7, 'X TM 4', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(8, 'X TM 5', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(9, 'X TM 6', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(10, 'XI MPLB 1', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(11, 'XI MPLB 2', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(12, 'XI TM 1', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(13, 'XI TM 2', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(14, 'XI TM 3', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(15, 'XI TM 4', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(16, 'XI TM 5', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(17, 'XI TM 6', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(18, 'XI TM 7', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(19, 'XII MPLB 1', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(20, 'XII MPLB 2', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(21, 'XII TM 1', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(22, 'XII TM 2', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(23, 'XII TM 3', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(24, 'XII TM 4', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(25, 'XII TM 5', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(26, 'XII TM 6', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL),
(27, 'XII TM 7', '2025-08-31 18:33:07', '2025-08-31 18:33:07', NULL);

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
(20, '2025_08_27_100132_rename_total_in_penjualan_table', 1),
(21, '2025_08_30_022457_add_status_to_jenis_sampah_table', 1),
(22, '2025_08_30_164252_create_insentifs_table', 2),
(23, '2025_08_30_171811_modify_role_in_pengguna_table', 2),
(24, '2025_08_30_172022_add_id_wali_kelas_to_kelas_table', 2),
(25, '2025_08_30_172632_add_unique_constraint_to_id_wali_kelas_in_kelas_table', 2);

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
  `role` enum('admin','siswa','wali') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'admin', '$2y$12$Mvn5YMkvMpPSVkFIESlo0.NNI60Wlpg8JsAojEoTem6l0RDlJfkYe', 'admin', '2025-08-31 18:33:06', '2025-08-31 18:33:06'),
(2, 'ADILAH', '252610001', '$2y$12$sH.TrU/VkdRLKhrNMmtld.hhWER88KRfkXv33JbX77DHRf0u1oSXi', 'siswa', '2025-09-01 01:36:53', '2025-09-01 01:36:53'),
(3, 'ADINDA OKTAVIANA', '252610002', '$2y$12$5eS8XtQ7tcB69eWr.sdDJumRbNiCqe9v2lGN.blFxsr5UJAbYcNLC', 'siswa', '2025-09-01 01:36:53', '2025-09-01 01:36:53'),
(4, 'ATIK CANTIKA', '252610003', '$2y$12$qawB8mfK6GKVPKxOY2yjqOB.Rgf96Sp5CVhjfRVXE3jvUHXa6TBnu', 'siswa', '2025-09-01 01:36:54', '2025-09-01 01:36:54'),
(5, 'AYU FADILLAH', '252610004', '$2y$12$HFId0LNmW50tPXxmor56RuDOxzYOZ4kXPsKLmieAlamWuNw8OtXRm', 'siswa', '2025-09-01 01:36:54', '2025-09-01 01:36:54'),
(6, 'BINTANG SAMUDRA SATYABUDIE', '252610005', '$2y$12$7gcCU6fOOL2/orM46Tu80uWfSOiAO3AveaPDfAbWP00nU//Q2C3nG', 'siswa', '2025-09-01 01:36:54', '2025-09-01 01:36:54'),
(7, 'DESFA NAILATUL NAFISA', '252610006', '$2y$12$wy.BEyL0ENJLw14cTcTK.Owuu.4csDuSQdRRNtEWdg71MBzAtf9mO', 'siswa', '2025-09-01 01:36:54', '2025-09-01 01:36:54'),
(8, 'DONI RAMADHANI', '252610007', '$2y$12$wMv.RhDnNSTi3rsGrNedVeo3nLS8b9T3bnghizVbNpIu3CvVPp1Fm', 'siswa', '2025-09-01 01:36:55', '2025-09-01 01:36:55'),
(9, 'FITRIA ZAHRATUNNAJA', '252610008', '$2y$12$lRwBPLmphZOnT.Lty9qLduxf1Fb6NJgox1F20OeW0tRrfs7wYPWjW', 'siswa', '2025-09-01 01:36:55', '2025-09-01 01:36:55'),
(10, 'INDAH AFIFA', '252610009', '$2y$12$wZ0oL4WhjYyS2e5ZSBQjyOXkpZR73pth23qR5VAetnUZCWdqh1T1q', 'siswa', '2025-09-01 01:36:55', '2025-09-01 01:36:55'),
(11, 'INDAH LISNAWATI', '252610010', '$2y$12$pfAiTZjED2QiLvt/O1SCp.mjw9rfh3zk7tvRJxNWhF/FddSFIEYQS', 'siswa', '2025-09-01 01:36:55', '2025-09-01 01:36:55'),
(12, 'INDRI PUSPITASARI', '252610011', '$2y$12$3n8cSg3U63f3hxe3PAO92uvnOVlqQam/hA9mf0cZfe9kFe6.j6oAm', 'siswa', '2025-09-01 01:36:56', '2025-09-01 01:36:56'),
(13, 'IQBAL MAULANA', '252610012', '$2y$12$SIfA04JmeuEsw74qd8gJ6uJd9qfBW7zHKMHNdIT6sSp9V4w7w/6JW', 'siswa', '2025-09-01 01:36:56', '2025-09-01 01:36:56'),
(14, 'JIHAN KHOLILAH', '252610013', '$2y$12$N9MZNSe/ZjFN8UyOiEIDDeqq/FPV5.ccgSk0Vk4xVxcsg9BN9aOC.', 'siswa', '2025-09-01 01:36:56', '2025-09-01 01:36:56'),
(15, 'KARLINA', '252610014', '$2y$12$g2R6.s0K64nXHoKzxViVRerXykEBs/W/8wjszQDS.6uqw.zSA9iLO', 'siswa', '2025-09-01 01:36:56', '2025-09-01 01:36:56'),
(16, 'KHOLIFAH RIZKA NURSAADAH', '252610015', '$2y$12$Yso.Q8Sa50sscDj2DNwfqedKMk1t./BJDOvi/D/ck8lwQ4dokKGI6', 'siswa', '2025-09-01 01:36:57', '2025-09-01 01:36:57'),
(17, 'KOMARIAH', '252610016', '$2y$12$Y3LCPqqpmv7McKYU7ARO4uq3eDy0GafgSreRFvnZLdtRgNbc7qizi', 'siswa', '2025-09-01 01:36:57', '2025-09-01 01:36:57'),
(18, 'NURUL HABIBAH', '252610017', '$2y$12$SIf.NqxssA5PK5Pq8Xw.kOZSsei3IA022LZxrc60WpHqxhMozq4PW', 'siswa', '2025-09-01 01:36:57', '2025-09-01 01:36:57'),
(19, 'RISMA NURMALA', '252610018', '$2y$12$i7kCgXC0Jj0ivXkcL7NMKuPU2u0W5JiQsNRtHoBG9OAs.kW0Iz0J2', 'siswa', '2025-09-01 01:36:58', '2025-09-01 01:36:58'),
(20, 'SALWA ANUROH', '252610019', '$2y$12$NsKjiCHCPvYnVx8z75Ph..06AcS7eFSKiID3Ypq/zUJZ11loTBJ1q', 'siswa', '2025-09-01 01:36:58', '2025-09-01 01:36:58'),
(21, 'SHIPA', '252610020', '$2y$12$8hNZcmie2KlF6EgePj9TWuZX695U251qYt2saNF1tiPZdtGnMBSV2', 'siswa', '2025-09-01 01:36:58', '2025-09-01 01:36:58'),
(22, 'SHOFIA AISYAH MUSAFAAH', '252610021', '$2y$12$aeSlTaQkMRrNjLUhzP/E1OddwppSwT6hJIoLDntCLzh97vwfFaGw6', 'siswa', '2025-09-01 01:36:58', '2025-09-01 01:36:58'),
(23, 'SITI ALISA', '252610022', '$2y$12$GIxIkG4vu.fOIWktqQ8TgOp8ZnZEOqc8ta2N4om7D5GLQLJ1he5.m', 'siswa', '2025-09-01 01:36:59', '2025-09-01 01:36:59'),
(24, 'SITI AMINAH', '252610023', '$2y$12$SeeGLQKpJBKndxS8JOm/kO086efHITw8le2B4kLqVznXobdCbc8ku', 'siswa', '2025-09-01 01:36:59', '2025-09-01 01:36:59'),
(25, 'SITI FATIMAH', '252610024', '$2y$12$6HnMr5y5EzVwD48yZRqYgOxxeHNbAmhiKVtz1gnIuKMSBnjHO9mJ6', 'siswa', '2025-09-01 01:36:59', '2025-09-01 01:36:59'),
(26, 'WARNIH MELINDA', '252610025', '$2y$12$BhYR7QECYpcZ.PKcgwxPxuANCIIJhgZ794sed/XBvMAxDMxYPpzpu', 'siswa', '2025-09-01 01:36:59', '2025-09-01 01:36:59'),
(27, 'WINA', '252610026', '$2y$12$mm2hmXpr9Rlej6CwalshSeRsjlVBV3NSXnJH/t0KI.cEaCncbwmP.', 'siswa', '2025-09-01 01:37:00', '2025-09-01 01:37:00'),
(28, 'ZASKIA PUTRI', '252610027', '$2y$12$7b1mu5e5r/7Joak.dTZfhubKAjZxzqNyhW7iELzCAJq3PIjYrv5na', 'siswa', '2025-09-01 01:37:00', '2025-09-01 01:37:00'),
(29, 'ALLEEISYA DAVINA KAMANDHANIKA', '252610028', '$2y$12$G4H1M9f3vPgim8ix5k2GF.9s5fzBxiVQaGKiVXhxj7sJq/hQP4bTO', 'siswa', '2025-09-01 01:37:00', '2025-09-01 01:37:00'),
(30, 'ALYA HANDAYANI', '252610029', '$2y$12$gaiEHpuj5maGoiU6V1C3q.r7qhIb34kbjBD6bb.xrWP1b9L8NEide', 'siswa', '2025-09-01 01:37:01', '2025-09-01 01:37:01'),
(31, 'ANI SUHAENI', '252610030', '$2y$12$3fYHcQybT.Rc/3b03.kwo.0OVL.R6eskChStWF9sdSoOpDg9VdQ.y', 'siswa', '2025-09-01 01:37:01', '2025-09-01 01:37:01'),
(32, 'ANITA', '252610031', '$2y$12$/HwgR8nvthVUsJZZMhvlluV0PlgC.JDnl6mC1c25j1GXzN8DV2kGe', 'siswa', '2025-09-01 01:37:01', '2025-09-01 01:37:01'),
(33, 'APRILLIA ANATASYA', '252610032', '$2y$12$RNh5hAk0/3sCusA4DhuM4e4CbcBdT24SSXYeMrUNhAgIB4W7kMAlO', 'siswa', '2025-09-01 01:37:02', '2025-09-01 01:37:02'),
(34, 'AULIA ISHAQUE', '252610033', '$2y$12$G/hIh5Ot9gptpMpV2FU9COEXJQ2GILllOt.ky0XVqIRa6YnGp9aaW', 'siswa', '2025-09-01 01:37:02', '2025-09-01 01:37:02'),
(35, 'AVRIL AVPRIDA HARIYANA', '252610034', '$2y$12$vOSyeB10HMeINJsmcu/d8.cI.n5EqTmyYIuIjV5.orw935YPTZ0bq', 'siswa', '2025-09-01 01:37:02', '2025-09-01 01:37:02'),
(36, 'CITRA LESTARI ROHIMAH', '252610035', '$2y$12$bvDQ3I4Pmwot5VT.f5I5z.1/HB6zzFjZ4CIMHU2QtX/MulqYUpMle', 'siswa', '2025-09-01 01:37:02', '2025-09-01 01:37:02'),
(37, 'DINA', '252610036', '$2y$12$/M4TAcXfjWlFsGuIhsx.bey4HwzY7C6enALhN/nGRt2PSKShcu7ba', 'siswa', '2025-09-01 01:37:03', '2025-09-01 01:37:03'),
(38, 'ENENG JUMARIYAH', '252610037', '$2y$12$0FfpX22gXb0ONqPkTEsXoOOU2w3aFFd/LH9cUu0b1vNnwSKCUSzCC', 'siswa', '2025-09-01 01:37:03', '2025-09-01 01:37:03'),
(39, 'ENGKOM KOMARIAH', '252610038', '$2y$12$CDBrayi1T.HSEU2S.Ff8XuNPQa9m9uOFBTI9GUExnnY7cSAVDP/6y', 'siswa', '2025-09-01 01:37:03', '2025-09-01 01:37:03'),
(40, 'HENA ALI', '252610039', '$2y$12$YKLjRS33vEtS3ubnahVDfe9bmkZawTeVw6lz83uD53zL2oZu9Y3eC', 'siswa', '2025-09-01 01:37:04', '2025-09-01 01:37:04'),
(41, 'JIHAN ANNASTASYA', '252610040', '$2y$12$hLTyALq4MlkE200GFeEAu.uF.oMVeAVvW6dOmaJBiOZ082K/jllvC', 'siswa', '2025-09-01 01:37:04', '2025-09-01 01:37:04'),
(42, 'KURNIA HANAPIAH ISWANDI', '252610041', '$2y$12$2wtuyJT6rOU30TKa.fesI.qGf3q68PVDi9Bshg3Su98O4iCfpywuq', 'siswa', '2025-09-01 01:37:04', '2025-09-01 01:37:04'),
(43, 'LATIFAH', '252610042', '$2y$12$oSqG6j1k8auLs5IpIS0TTenvAujvsAXA./qZXgDxykz8eKZr8Sesu', 'siswa', '2025-09-01 01:37:04', '2025-09-01 01:37:04'),
(44, 'NASYA MAHARANI', '252610043', '$2y$12$PwX5UsgHtojRISg.F5YGPOkUC6o3sren4IW9SiUL6LA81R7uH859e', 'siswa', '2025-09-01 01:37:05', '2025-09-01 01:37:05'),
(45, 'NUR ALBIAH SALWA', '252610044', '$2y$12$4bZTVEMOt00qB/LzmYY2sOZ/e2q6y.c.8xBb0k/cPcwWGV20gsPXS', 'siswa', '2025-09-01 01:37:05', '2025-09-01 01:37:05'),
(46, 'NUR SIFA ANGGAENI', '252610045', '$2y$12$boLa4t82qeRhOpb/nvofAelDpfSRMZurNzhVqZEt/Gooq/wyltfmu', 'siswa', '2025-09-01 01:37:05', '2025-09-01 01:37:05'),
(47, 'PUTRI SASKIA', '252610046', '$2y$12$z6Bh3pJkgAv4Bj6Kxl8ohukYAGpoeUysU0SeGFTUbpPoBXTlhDtvK', 'siswa', '2025-09-01 01:37:05', '2025-09-01 01:37:05'),
(48, 'RAHMA YANTI', '252610047', '$2y$12$W8RHt/i/MfhPhL8L1vxlfurJ2j6B2EX4vamYPqUrsxy3kD9el689u', 'siswa', '2025-09-01 01:37:06', '2025-09-01 01:37:06'),
(49, 'RANI AMELIA', '252610048', '$2y$12$WGLMjnKaJlPTfUP0OZJVDOHYQJrGuff8yVCv3QT5vdIEkndsgNy7q', 'siswa', '2025-09-01 01:37:06', '2025-09-01 01:37:06'),
(50, 'SAHAR SYAFITRI', '252610049', '$2y$12$2/yUhI9knd07HVKr.hYc5.5nxmdWpNihQI1IwwgLFAmVbkJUDzaWC', 'siswa', '2025-09-01 01:37:06', '2025-09-01 01:37:06'),
(51, 'SALSA BILA AZZAHRA', '252610050', '$2y$12$VY8/0aSh5HYXo2v8noSwiuIS67fMx1A.Schb4tfr5PVqAtSUwpUXW', 'siswa', '2025-09-01 01:37:07', '2025-09-01 01:37:07'),
(52, 'SHIFA ADELIA MAWAR', '252610051', '$2y$12$kQRAZyd1fSg4W69DVAkSOe3wRv/G3s4FQMkFY79l9m3J7c8eXNg5G', 'siswa', '2025-09-01 01:37:07', '2025-09-01 01:37:07'),
(53, 'SINTA SUTIA', '252610052', '$2y$12$fXlqA25ky/uqjtum6W3XQO9EZ616PFQVtWQV53kK14FtwbIlgPMze', 'siswa', '2025-09-01 01:37:07', '2025-09-01 01:37:07'),
(54, 'SITI NURZAHRA', '252610053', '$2y$12$0pSrzjQHFYPwh9mIMREF7OY50F1mXTDVijvd4Ta8q6Vx.xB2b0rAm', 'siswa', '2025-09-01 01:37:07', '2025-09-01 01:37:07'),
(55, 'SITI ROMLAH', '252610054', '$2y$12$LyEjTWTsfMcbMYhiabAFNuxiHqxe.YwbL4yyTzHLklK/8nCtno0A6', 'siswa', '2025-09-01 01:37:08', '2025-09-01 01:37:08'),
(56, 'TANIA OKTAVIANI', '252610055', '$2y$12$HKS2di9EZxKm1yC7drrcouALJth/u.kxhcr1eKJSRLWeaREQtz4Rq', 'siswa', '2025-09-01 01:37:08', '2025-09-01 01:37:08'),
(57, 'WINDI ALTIYAH', '252610056', '$2y$12$oVEp0worQ7IulXwoY6Z1W.bEyxc2G4y8AaqXdyh6fM0/KqxV0mP8q', 'siswa', '2025-09-01 01:37:08', '2025-09-01 01:37:08'),
(58, 'ABU HAMAD MASKURI', '252610057', '$2y$12$1o4OPlOSbOYB0T5q7WFCPu5UKa3oCADMhwkcrwvPHPCX8C3NiGTG6', 'siswa', '2025-09-01 01:37:08', '2025-09-01 01:37:08'),
(59, 'ADE IRWANSYAH', '252610058', '$2y$12$Os6/bM9G6ZVnEPtywDYvUe0W1fqFCbS6eQvN/8tA9hDBaJwDWDd1e', 'siswa', '2025-09-01 01:37:09', '2025-09-01 01:37:09'),
(60, 'ALDO SUTISNA', '252610059', '$2y$12$RMt8JYB1.bsJ2UWvt6CChOOV2XKGboZVIhadufftuYEcwml28WjOW', 'siswa', '2025-09-01 01:37:09', '2025-09-01 01:37:09'),
(61, 'ANDIKA PAJAR MAHDI', '252610060', '$2y$12$QHh6.0FsA.bSmSyPo6Wo3OCsbTBzhml04RD.Qb28ofJP6OWflt5.O', 'siswa', '2025-09-01 01:37:09', '2025-09-01 01:37:09'),
(62, 'ANDINI ANGGRAENI', '252610061', '$2y$12$FWNuXNbNzAoCOfCzzuJGDuKRNwxt8Iq2ZfhtXUXxrXEE2fHmIbSoK', 'siswa', '2025-09-01 01:37:10', '2025-09-01 01:37:10'),
(63, 'BAGAS ARDIWINATA', '252610062', '$2y$12$26VkhwaNI0T6KTCYl8daR.Iy8cXYfbAQRHkZM6ay3gm/g0ySCuXxW', 'siswa', '2025-09-01 01:37:10', '2025-09-01 01:37:10'),
(64, 'CHIKA SIPA ANGGITA', '252610063', '$2y$12$giMgvVJFL999BjO8RSA4S.jLN/rt6fDTXAHohw8uuBHkkDeUG5r1y', 'siswa', '2025-09-01 01:37:10', '2025-09-01 01:37:10'),
(65, 'DANI SETIAWAN', '252610064', '$2y$12$linI9RWgSs3HeFSqax3okem/4T7oe5CIXngSbgN5Lxw2lWHO2n8La', 'siswa', '2025-09-01 01:37:10', '2025-09-01 01:37:10'),
(66, 'DANI SUTISNA', '252610065', '$2y$12$Mv93V8ozYuE5s48CpRM5x.146nJrjBI0oBqpc8Ey81k90voMvovPG', 'siswa', '2025-09-01 01:37:11', '2025-09-01 01:37:11'),
(67, 'DANIA OKTAVIA', '252610066', '$2y$12$4UVPdW5ljfJSMAGo2cdz0uLneFRCdlKlfF0L0I9Iulb2LtZ.TzfGe', 'siswa', '2025-09-01 01:37:11', '2025-09-01 01:37:11'),
(68, 'DIMAS AHMAD RAMADAN', '252610067', '$2y$12$iwGFIS3GaujFVAD2CBCxkehVn79SNht1nSmpjPxX.JRhFh1ios19G', 'siswa', '2025-09-01 01:37:11', '2025-09-01 01:37:11'),
(69, 'DIRLY ANGGADITA', '252610068', '$2y$12$YmISXwLBCUh0I8krqcqAL.Zdt8RZ.zqSXUsgx/PDjhdhzK78Wygom', 'siswa', '2025-09-01 01:37:11', '2025-09-01 01:37:11'),
(70, 'EDI SETIA GUNAWAN', '252610069', '$2y$12$Koa4MzUY6yrofSXgiVH95uFwJw3dd2k4kpqEtOP5prmg7zUnHqHOu', 'siswa', '2025-09-01 01:37:12', '2025-09-01 01:37:12'),
(71, 'EKA BAMBANG SAPUTRA', '252610070', '$2y$12$SuprdUvKaNsv8lk3oE4FBuvA1fYe0twglWMN/IRs57Ws.wzy2Syl.', 'siswa', '2025-09-01 01:37:12', '2025-09-01 01:37:12'),
(72, 'ENDRIK PURNAMA', '252610071', '$2y$12$ZXVXThH4vXn3FTUUFgdqg.vY1gMpH2J6/X4.8vMTBYwH9YPLOb02K', 'siswa', '2025-09-01 01:37:12', '2025-09-01 01:37:12'),
(73, 'HERMANSYAH', '252610072', '$2y$12$/bEBlY7oZhWpfkqY70mDd.Ocbk/fK1WNrUM7QQHNpoTknglel3Bdi', 'siswa', '2025-09-01 01:37:12', '2025-09-01 01:37:12'),
(74, 'HIDAYATULLAH', '252610073', '$2y$12$zb6oRHa1xpEzgJ8obzpvM.d2qENu7Dywl2qTkYijyy7XoyiEIO0pO', 'siswa', '2025-09-01 01:37:13', '2025-09-01 01:37:13'),
(75, 'JAEN', '252610074', '$2y$12$2GiLLVIhqjI/nxBVEYrbLeYLeS9Lu7QLbAl5Uemp.k1Q1WlvZXCB6', 'siswa', '2025-09-01 01:37:13', '2025-09-01 01:37:13'),
(76, 'JULIYANTO', '252610075', '$2y$12$J2XOXjsib2OfCC66sRHj9uixLnqwkjERPIPZ.vUuHbksPR1p6B29u', 'siswa', '2025-09-01 01:37:13', '2025-09-01 01:37:13'),
(77, 'MIFTAHUL ARIFIN', '252610076', '$2y$12$cq9aMEfhM3iQo/0cc6uj.uf.t1V1JQXr3JEYtB9huhUq9weGksoy6', 'siswa', '2025-09-01 01:37:13', '2025-09-01 01:37:13'),
(78, 'MIT F FELIX GUSNA', '252610077', '$2y$12$PQAScyQcSsTagVLxjwkAbeSvou/yOfzMBECmxg04U9IrBR5b17h1e', 'siswa', '2025-09-01 01:37:14', '2025-09-01 01:37:14'),
(79, 'MUHAMAD MUHIBIN', '252610078', '$2y$12$RmJZFuuhQkILcJXvHRYM5O8REIYTNF.tLUt7YjIngF18cM7Mu142m', 'siswa', '2025-09-01 01:37:14', '2025-09-01 01:37:14'),
(80, 'MUHAMAD RADITIYA', '252610079', '$2y$12$qY5UlyYsDtn9T7KtoS6ftObvRAw4tiuv3OCaVghPB4jhsMDN51NK6', 'siswa', '2025-09-01 01:37:14', '2025-09-01 01:37:14'),
(81, 'MUHAMAD RIZKI BAEHAKI', '252610080', '$2y$12$PLWgAu6xe8.WOyDFD4daOet4HK.Ll4CRUxuTVE0ZJ8O87UB3AA9aC', 'siswa', '2025-09-01 01:37:15', '2025-09-01 01:37:15'),
(82, 'MUHAMAD RIZKY HABIBI', '252610081', '$2y$12$tDFTM9LC643j8mFwKazDhec39Wk2sDNMxDg4GLpNFjJuzkUE9u7Ou', 'siswa', '2025-09-01 01:37:15', '2025-09-01 01:37:15'),
(83, 'MUHAMMAD AL ISRA FIRMANSYAH', '252610082', '$2y$12$DT.QBXComxHb252Aka8KAeQ3EkPcCZy6OmFgt4FpX9SZZmRR9ZULS', 'siswa', '2025-09-01 01:37:15', '2025-09-01 01:37:15'),
(84, 'MUHAMMAD FARHAN ADI PUTRA', '252610083', '$2y$12$3OPoCjuXGuxiRVkFQy2FEe0q03PSOIZYGYniBhtAiYoxAMDlyilS6', 'siswa', '2025-09-01 01:37:15', '2025-09-01 01:37:15'),
(85, 'RIFALDI JULIANSYAH', '252610084', '$2y$12$1UElWraGep7pOxu1DbBO5uVcX0SDs.LQl4POryX25tgWpceNiBdyG', 'siswa', '2025-09-01 01:37:16', '2025-09-01 01:37:16'),
(86, 'RINDI', '252610085', '$2y$12$5ECBveLIyXudag1Ut.BweOd8kYQ/4zPj94WbPQhipVAZzpSmxpRz6', 'siswa', '2025-09-01 01:37:16', '2025-09-01 01:37:16'),
(87, 'RISFI HIDAYAT', '252610086', '$2y$12$ggXXfXIAy/M8ldGNKXcS0OeA4QurKvFciHU0lD755khQfsbk35x6K', 'siswa', '2025-09-01 01:37:16', '2025-09-01 01:37:16'),
(88, 'TAOPIK HIDAYAH', '252610087', '$2y$12$Flqhr.GcK/e7d3EGrOR8YO76ej0mQ2cfmPinUt8d09KBqw0ikcJVC', 'siswa', '2025-09-01 01:37:16', '2025-09-01 01:37:16'),
(89, 'WISNU HASLAN FARID', '252610088', '$2y$12$OCStKV.33Z8hlSjzPPNE7Ov6hbcVH0dF1V5zwZE0gDuqwlTyfSPaK', 'siswa', '2025-09-01 01:37:17', '2025-09-01 01:37:17'),
(90, 'YOMI ABDUL MANAH', '252610089', '$2y$12$9.vMCFmJeLn4knPNPGRUUuA5puYVdDzjjUGtddKdADE/M6LFl0.e2', 'siswa', '2025-09-01 01:37:17', '2025-09-01 01:37:17'),
(91, 'ZAKI IBNU KHAIRI', '252610090', '$2y$12$knSmw1aWguekMRAUh5VYQeLzcUMC6Wq3jGNqs7VLKankg7bFgfhSu', 'siswa', '2025-09-01 01:37:17', '2025-09-01 01:37:17'),
(92, 'ABDUL LATIF', '252610091', '$2y$12$nod9x2xf77SmVDtJQzzWnuMugAtgw4Ip2by6D/S0r93IJLkkxKipe', 'siswa', '2025-09-01 01:37:17', '2025-09-01 01:37:17'),
(93, 'ADE IRFAN', '252610092', '$2y$12$2g0EBXdTyyOkPZFKAaKKIO0dL17OxeegDuBVymhe2P/Fwg.g.3W/q', 'siswa', '2025-09-01 01:37:18', '2025-09-01 01:37:18'),
(94, 'ADE KRISYANTO', '252610093', '$2y$12$sEkNL.4ySywYkBb/s9G1UOgvK87tJo9i8xK99P7heoE/9QiV9WC/O', 'siswa', '2025-09-01 01:37:18', '2025-09-01 01:37:18'),
(95, 'ADITIA SIMATUPANG', '252610094', '$2y$12$250SpXqA2Ergh4L8kTfy0.bbaruAUL/tUM9rwJmkqg45SKt.QiCNC', 'siswa', '2025-09-01 01:37:18', '2025-09-01 01:37:18'),
(96, 'AHMAD FAUZAN', '252610095', '$2y$12$p9eTZn6l.pBiuwBygi90kuLXP8FYqcefTdWM0Frx60Mt5pYREtnnK', 'siswa', '2025-09-01 01:37:18', '2025-09-01 01:37:18'),
(97, 'AHMAD FAUZI', '252610096', '$2y$12$qxBindxiFf/pDlqg4JndoeFGBoZ5bkpH8u0gBNgBpSl2xHv/XWQBm', 'siswa', '2025-09-01 01:37:19', '2025-09-01 01:37:19'),
(98, 'AKBAR JUNIARDI', '252610097', '$2y$12$L4WzMKNZn6PAeUy2r9jWZudUEKlpiNQFuyhb7gSBm9Kss.tO43/mm', 'siswa', '2025-09-01 01:37:19', '2025-09-01 01:37:19'),
(99, 'ALDI', '252610098', '$2y$12$/o6eCiPi1hu5/NHkWmRHp.S8dSbuQI0GjRpSOQ.scWRfKvPAcs.nW', 'siswa', '2025-09-01 01:37:19', '2025-09-01 01:37:19'),
(100, 'BUNGA IRMA REFALIA', '252610099', '$2y$12$OOGdmQznI1SfzmTdwSUO2uR.pT0GrGGtz/3ZN8WAD22OhVsYqhzbG', 'siswa', '2025-09-01 01:37:19', '2025-09-01 01:37:19'),
(101, 'DENIS', '252610100', '$2y$12$2wO2mSjO5lsMgIxe3wNub.aVpSL7oUdOjfL.So0fffYND40JLeiQe', 'siswa', '2025-09-01 01:37:20', '2025-09-01 01:37:20'),
(102, 'DIDI FIRJATULLOH FADIB', '252610101', '$2y$12$0q38DQUii2KhVEQTeXldw.uiDZYzbXAmSgsC62sYwNyTnJSzQZBUq', 'siswa', '2025-09-01 01:37:20', '2025-09-01 01:37:20'),
(103, 'DIMAS HAFIDDUDIN', '252610102', '$2y$12$QQ2CSWVG47bsBBuH/mrQne6DqxMjLuqIxKD/QRxOSu21nQapqas0e', 'siswa', '2025-09-01 01:37:20', '2025-09-01 01:37:20'),
(104, 'DINI AMELIA PUTRI', '252610103', '$2y$12$vge/W99JxBBTCSM/uM5YJuhfxMywTaFMjUxXvigyvTIy6YPG6q2eu', 'siswa', '2025-09-01 01:37:21', '2025-09-01 01:37:21'),
(105, 'ENJELIKA APRIDA', '252610104', '$2y$12$.onKHmj7m9MD7SLe0yG5AuO/ewPEnbvZNGksu6Y6HicULbmHsP6WS', 'siswa', '2025-09-01 01:37:21', '2025-09-01 01:37:21'),
(106, 'FAISAL AKBAR', '252610105', '$2y$12$ubh/8aZiB6Eoi8TB26t3XuOiIWIHnhGZVHajDq7A7PVd85.ZV53CS', 'siswa', '2025-09-01 01:37:21', '2025-09-01 01:37:21'),
(107, 'GIAN JANU PANDU SAPUTRA', '252610106', '$2y$12$t/MegRNHmIfLKdd7h3YGMek9I/KogIBj5RrDo5r.KH02ayRK63Gs6', 'siswa', '2025-09-01 01:37:21', '2025-09-01 01:37:21'),
(108, 'HAFID JULIANA', '252610107', '$2y$12$Thu/OIALxETJHLUIx4Vx4.eoouykIMcu8y0RA19HWnx3eMNAFfejO', 'siswa', '2025-09-01 01:37:22', '2025-09-01 01:37:22'),
(109, 'IQBAL ALBIANSYAH', '252610108', '$2y$12$PQPnIm3J4nbplthpJRP0uOoKJ6JxWMBsEidy/kX4C0Bs14dP3ND9m', 'siswa', '2025-09-01 01:37:22', '2025-09-01 01:37:22'),
(110, 'IRWAN SAPUTRA', '252610109', '$2y$12$jLfdba9aZvKww2/R3PijZ.GNLV2en76X.Vmf7YQ2aeT.9LeWeAImy', 'siswa', '2025-09-01 01:37:22', '2025-09-01 01:37:22'),
(111, 'MUHAMAD FAZRI', '252610110', '$2y$12$HtdwJqa2X0Y/NMCP8NdDMeBwTnLZdeZAPr4PGnYL6HoWjDZpDqE6C', 'siswa', '2025-09-01 01:37:22', '2025-09-01 01:37:22'),
(112, 'MUHAMAD HUSAIN HAFIZHULLAH', '252610111', '$2y$12$JNFJGega4x3hCHGvng1d8eoYRS8Obb.w8xJ2/N2R1SAVsRX/rSa4a', 'siswa', '2025-09-01 01:37:23', '2025-09-01 01:37:23'),
(113, 'MUHAMAD SOLEH ALFIKRI', '252610112', '$2y$12$jDzDi5rNT3YerdV/EtQvYO.dATAbypuMCKa5xuTsLVAOC4FIuViu2', 'siswa', '2025-09-01 01:37:23', '2025-09-01 01:37:23'),
(114, 'MUHAMMAD REFAN REPIS', '252610113', '$2y$12$9G4nRS5HpsByl427VGOp1OVu08sf6TDULr7cJibefcK7g10Cuh/o2', 'siswa', '2025-09-01 01:37:23', '2025-09-01 01:37:23'),
(115, 'NIZAR NASIHUDIN', '252610114', '$2y$12$gd/cEI6SnyhBugFPJzC.UeF68F2q/K0N6i5.5Q8ViOiwOgOiwcqYm', 'siswa', '2025-09-01 01:37:23', '2025-09-01 01:37:23'),
(116, 'RAHMAT MURTI UMAY PUTRA', '252610115', '$2y$12$MiqlfxbIyBYc55EO1mgLmeD0QLFhIfAnWgF0g0ZRQMVE5kIDtuSoa', 'siswa', '2025-09-01 01:37:24', '2025-09-01 01:37:24'),
(117, 'REYHAN ABIDIN', '252610116', '$2y$12$5HrUomFVkzlsX6oF2k71Nuc9.ZuceiSKKzocU.gDpOqcUAYiOISHq', 'siswa', '2025-09-01 01:37:24', '2025-09-01 01:37:24'),
(118, 'REZA ARDIANSAH', '252610117', '$2y$12$o8iq7h6NQUF5qEiL8EbLdeDPbhyKNYree3trDgVGULaWo5M9FIH1K', 'siswa', '2025-09-01 01:37:24', '2025-09-01 01:37:24'),
(119, 'RHEDY AFRILIANS NUGRAHA', '252610118', '$2y$12$TobcaF2bImI7wvnsA2EsHen7WcOQeY/AHFyfdddYz1SViOrOy7WxK', 'siswa', '2025-09-01 01:37:25', '2025-09-01 01:37:25'),
(120, 'ROSALINDA', '252610119', '$2y$12$O8TwjN8jQ8MsjKhyoxB1IOIrdjUbXsYbg4T4iR21Len3hawdYzIvy', 'siswa', '2025-09-01 01:37:25', '2025-09-01 01:37:25'),
(121, 'SITI MARYAM', '252610120', '$2y$12$0imVU6wUHbA3EdBt88DyMui2c2TlHBGkL55nS679TGhFC.GmSJfUm', 'siswa', '2025-09-01 01:37:25', '2025-09-01 01:37:25'),
(122, 'SITI PAIDAH', '252610121', '$2y$12$rVCbEzYNDrY063pMOivge.ezTX5kSJYEAlLxsrSFXS.wZiBYAVmby', 'siswa', '2025-09-01 01:37:25', '2025-09-01 01:37:25'),
(123, 'SRI LESTARI', '252610122', '$2y$12$Clc9koyfN5KVYc.1TX3jGuARz1x0Y.zAmfTuNytFSH7c0N2IFox1a', 'siswa', '2025-09-01 01:37:26', '2025-09-01 01:37:26'),
(124, 'TRYO ABDULGONI', '252610123', '$2y$12$X2xegmXxEgYP6Wpen1b8V.zTJzL1RN0caMV2f5J5p5893TEEJOaA.', 'siswa', '2025-09-01 01:37:26', '2025-09-01 01:37:26'),
(125, 'TUBAGUS NAWAWI', '252610124', '$2y$12$Bpx/tCwEN7mza4hkrIdu1uA3TrdEF2FpzGaPpadwbp2e.1jrtgZtO', 'siswa', '2025-09-01 01:37:26', '2025-09-01 01:37:26'),
(126, 'AHLIS ARFA NAOZA', '252610125', '$2y$12$1tfNmA39mNKAnVekSaTC3OBs7YSsK.Y/I8k3uFQoZb10KKAvKFJBW', 'siswa', '2025-09-01 01:37:26', '2025-09-01 01:37:26'),
(127, 'AHMAD FAUZI', '252610126', '$2y$12$v.P7nmo9QuOFeU2WTNRY2.3V/IgWmjH7nPzpifPivQSH2wTTGqQQ.', 'siswa', '2025-09-01 01:37:27', '2025-09-01 01:37:27'),
(128, 'AHMAD RIDWAN', '252610127', '$2y$12$MGdtOIsaaV8O6B3Fv0tGUekLfxhtDRtm1WhHT4a0UMwFtsRcMYuNu', 'siswa', '2025-09-01 01:37:27', '2025-09-01 01:37:27'),
(129, 'AHMAD RIFAI', '252610128', '$2y$12$Vx4QP3iuCdlw2xg3qgXnjOSYNc7yK2ollQ6XFo1SILd2e2dABXrpe', 'siswa', '2025-09-01 01:37:27', '2025-09-01 01:37:27'),
(130, 'AKBAR MAULIANSYACH', '252610129', '$2y$12$nQKdWX16phJwHmofsvWxDO9E3421AWITa/STQeN6IcqDaSki5y8gm', 'siswa', '2025-09-01 01:37:27', '2025-09-01 01:37:27'),
(131, 'ANDINI', '252610130', '$2y$12$Yir5cM2uCcMH8efEc4kFkuDHb.enlKUAXll7P363UYANlTUbB.tne', 'siswa', '2025-09-01 01:37:28', '2025-09-01 01:37:28'),
(132, 'AYU ADIRA', '252610131', '$2y$12$qou0JB9Kd98C/vkJStZ54eFg.r/Vl.w2bR.CEIzTX4FHq4D3LsDIC', 'siswa', '2025-09-01 01:37:28', '2025-09-01 01:37:28'),
(133, 'CANDRA MAULANA', '252610132', '$2y$12$FngmpXCz.AIZ9ttvBypigeDyqnKg/M75G.jLWi9Eo2LkLhkH08ZGK', 'siswa', '2025-09-01 01:37:28', '2025-09-01 01:37:28'),
(134, 'CIKAL ERLANGGA', '252610133', '$2y$12$1qifZwW4Wu1vSnpr0baAZ.U9xnsezREfxcWOtLieQB6HsHrUoCx/O', 'siswa', '2025-09-01 01:37:29', '2025-09-01 01:37:29'),
(135, 'DENI RIZKY PRATAMA', '252610134', '$2y$12$b7w8tiYReDKm6EYV9MHe/u6qkaSfuijmbnlUqKEcDPM3WMqJd/e9O', 'siswa', '2025-09-01 01:37:29', '2025-09-01 01:37:29'),
(136, 'FAHRI ALIF FADILLAH', '252610135', '$2y$12$Eki4Kk7pVsHkzlXRP0pXeuxJCFBnxFRqZ69cDhae8ZUfZ/AQx2Jve', 'siswa', '2025-09-01 01:37:29', '2025-09-01 01:37:29'),
(137, 'GALANG RAMDANI', '252610136', '$2y$12$ggzslb4GECAu3upLXGWSlOVmHsgH9P8kwPjdpQNaQ.NIvySs62IuK', 'siswa', '2025-09-01 01:37:29', '2025-09-01 01:37:29'),
(138, 'HADID SWARA GUMILANG', '252610137', '$2y$12$utgcBg2mSAPwtwq8sn5XJeNhtB9VmUwqQWm5OOLJ75ZntiQzaYq1a', 'siswa', '2025-09-01 01:37:30', '2025-09-01 01:37:30'),
(139, 'KARTIKA SARI', '252610138', '$2y$12$K0zBC9juevAi2Fg5.U/gp.YpmDVxLLYpHftWAjQTs8.IE7YQGvEq6', 'siswa', '2025-09-01 01:37:30', '2025-09-01 01:37:30'),
(140, 'MARSHALL MILANIZT STILL Z', '252610139', '$2y$12$N.MpM0M4vBF0xkpSP9GE9.T/HCGIe26n6fP3L7HenNMTnFstCuRFq', 'siswa', '2025-09-01 01:37:30', '2025-09-01 01:37:30'),
(141, 'MEISYA EUIS SADIAH', '252610140', '$2y$12$2n2rdgFUEVIw6wLlA.IjIOH2XB.L8CA/JNZ.T.NR4we2K4Eyqzrn.', 'siswa', '2025-09-01 01:37:30', '2025-09-01 01:37:30'),
(142, 'MOHAMMAD ZEYAD', '252610141', '$2y$12$R.WhOGaHeDwq/taE710OB.iwXZkNa3WbyxDpMk0OGLH.PAh8aaDXe', 'siswa', '2025-09-01 01:37:31', '2025-09-01 01:37:31'),
(143, 'MUHAMAD FARHAN', '252610142', '$2y$12$qr7Viu9n7f8Bo/pvn4Me6O65wb6J5Kpy5i5Hu2fLNIC8fFfBAOJ0S', 'siswa', '2025-09-01 01:37:31', '2025-09-01 01:37:31'),
(144, 'MUHAMAD IRFAN MAULANA', '252610143', '$2y$12$6M.ziyHH09ex4SzJWXjAXu.kq8DwJj7Hw20rVCNWwiQAEYNHUGtqG', 'siswa', '2025-09-01 01:37:31', '2025-09-01 01:37:31'),
(145, 'MUHAMAD JIHAD ILMA ATTAMIMI', '252610144', '$2y$12$SkATIwkmh/vmBIITBLKDe.KTDgtUTrZu9JuC1vTDcp/lsZomNaaE2', 'siswa', '2025-09-01 01:37:32', '2025-09-01 01:37:32'),
(146, 'MUHAMAD RIZKI', '252610145', '$2y$12$em0j4SD2l/bglFiVMa2Onu3Wl1smg0ixo6An7r8uAlK16iGrMaaua', 'siswa', '2025-09-01 01:37:32', '2025-09-01 01:37:32'),
(147, 'MUHAMMAD ZAELANI', '252610146', '$2y$12$GklIwZRvItRGGJTqQ1D.Y.Xr8eCAKfypseGRO0P.oVn8ErPH5EqxW', 'siswa', '2025-09-01 01:37:32', '2025-09-01 01:37:32'),
(148, 'NURJATI', '252610147', '$2y$12$KjCSsKjaD.Zz84/nRn1nI.kQ82rs1KI8wYYd2r4PgQLo9hCQocIkS', 'siswa', '2025-09-01 01:37:32', '2025-09-01 01:37:32'),
(149, 'RAMADAN', '252610148', '$2y$12$WMWKgDO/mYRq1hfhLrvjZ.Y945EQJ3CyBodimEEqB0rYhsmhISGK2', 'siswa', '2025-09-01 01:37:33', '2025-09-01 01:37:33'),
(150, 'RIFQI QHAIRUL HASAN', '252610149', '$2y$12$caVcOExJDUUvkfpLe9JfeOOBmFwdbuxxU3wWnGJiyBNqPl66PHfgG', 'siswa', '2025-09-01 01:37:33', '2025-09-01 01:37:33'),
(151, 'RIZKI NUR AL FAHRI', '252610150', '$2y$12$.ORPd/KxjuPHf1RxlZFS4e3ey3JPC2aXGpuRUlrX2wyfC9YxpkIWq', 'siswa', '2025-09-01 01:37:33', '2025-09-01 01:37:33'),
(152, 'SALSA NABILA', '252610151', '$2y$12$RiLQsdVA0I4sBOAcSaPpSOABkiDJwB0jVHpi3OFOiB2NQQQeRaIxW', 'siswa', '2025-09-01 01:37:34', '2025-09-01 01:37:34'),
(153, 'SITI HASANAH', '252610152', '$2y$12$P9f0BTr7Y/amen5mUWAqLullCq/0havHtZSDJqt3eYjk4e1r2qrxq', 'siswa', '2025-09-01 01:37:34', '2025-09-01 01:37:34'),
(154, 'SUHENDRA', '252610153', '$2y$12$w3i/W1Oao0vPt01iW.OGZ.InG4sYHmtmvRU5vPGTnpoYv629pCKxK', 'siswa', '2025-09-01 01:37:34', '2025-09-01 01:37:34'),
(155, 'SUTISNA PRATAMA', '252610154', '$2y$12$01lOtlu.MHS.U4wdbnFoJec2jCSgPXZhH8Shll3WqXZ8qRjk.MY2S', 'siswa', '2025-09-01 01:37:34', '2025-09-01 01:37:34'),
(156, 'TEDI MAULANA', '252610155', '$2y$12$zOVwbcvskUg2MMnuXUmpsuqt.JgwGF90N3YtEBgj3LTSyuPnvG4ku', 'siswa', '2025-09-01 01:37:35', '2025-09-01 01:37:35'),
(157, 'WAHYU SUPRIATNA', '252610156', '$2y$12$.lg4TLRXiwOBaWk8fDfGn.GBWFkIKB4KfSSt5pAFLmzr6zRDx3MXi', 'siswa', '2025-09-01 01:37:35', '2025-09-01 01:37:35'),
(158, 'WALID FAJAR RAMADHAN', '252610157', '$2y$12$XMQ42iCiEjfglFrpP.y42.DfXJCOsmZkpeTKevEGr05dYKZCJ3hKq', 'siswa', '2025-09-01 01:37:35', '2025-09-01 01:37:35'),
(159, 'YUSUP', '252610158', '$2y$12$dAj25cSbbQxTPMbRzRhWcuxVOUFEZDM.ByFG8djWIpzxqj2GIaRyi', 'siswa', '2025-09-01 01:37:36', '2025-09-01 01:37:36'),
(160, 'ABDUL FIKRI', '252610159', '$2y$12$jgEa6i0SxAiIgEme3bLyqewGXHBKZ3G21tA8pEEV.C0QLlTFh.FBW', 'siswa', '2025-09-01 01:37:36', '2025-09-01 01:37:36'),
(161, 'ADIL ALZULFA', '252610160', '$2y$12$/sG8.iZiYAFcPnvWd2aeyeQffQ93dEBNMRoWZUIBlURBESvE/jW52', 'siswa', '2025-09-01 01:37:36', '2025-09-01 01:37:36'),
(162, 'AGAM MADANI', '252610161', '$2y$12$nOM.yHnmaM1Hj7osmwnWuOwNiE1hzWDy0t9hN8zMf4I.5uhMX3IeS', 'siswa', '2025-09-01 01:37:36', '2025-09-01 01:37:36'),
(163, 'AGUS SAPUTRA', '252610162', '$2y$12$yNO4j3AnsJcanUexfGx/IOVC/2o1pB2wxWFciViz94x31c47qIjuS', 'siswa', '2025-09-01 01:37:37', '2025-09-01 01:37:37'),
(164, 'AHMAD AZMI KHOERUNNIZAR', '252610163', '$2y$12$CDqmpFsdNn0uX1uTr75eluvD5Kv7FSlPo5schvo6QDDKcdWOtgMxe', 'siswa', '2025-09-01 01:37:37', '2025-09-01 01:37:37'),
(165, 'AHMAD RIZKY KURNIAWAN', '252610164', '$2y$12$uQxg1JDjou/Mzcfu1bG2Fuf9WN17gmUqr4Jch6zBiIj8d90RH3bm.', 'siswa', '2025-09-01 01:37:37', '2025-09-01 01:37:37'),
(166, 'AHMAD SYAFIQ', '252610165', '$2y$12$KAmazvCkfkTCdIr5pivcR.ZQnqkZsq1yuFgdVJR2I0JmDgofKAhka', 'siswa', '2025-09-01 01:37:37', '2025-09-01 01:37:37'),
(167, 'ANGGA MAULANA', '252610166', '$2y$12$MM/InnbNp5IWncb5mFkwkecJPdh9.G8Laz0QdaUHmOtWi/O.xg9.i', 'siswa', '2025-09-01 01:37:38', '2025-09-01 01:37:38'),
(168, 'DENI KUSMANA', '252610167', '$2y$12$ULhG4kyLsxaDIP8hbDw0O.sEkbndjdmxWrdkHoc2240FEX1fl/BFO', 'siswa', '2025-09-01 01:37:38', '2025-09-01 01:37:38'),
(169, 'DIANA RAHAYU', '252610168', '$2y$12$RgO4TZmgmUiKro4G9GlOluwHuYxLj9LSakp23ReicxX3VyVSl3wcG', 'siswa', '2025-09-01 01:37:38', '2025-09-01 01:37:38'),
(170, 'EPITASARI', '252610169', '$2y$12$I6iaN3Z3POJRxwQb/hmYue7Rq4BDzpxwsY8s0SKfCm9KMysHtJVKq', 'siswa', '2025-09-01 01:37:38', '2025-09-01 01:37:38'),
(171, 'FARHANNABIL', '252610170', '$2y$12$Bs0cvjWI5tzIEnQ1TX4tZ.h3xZX.hq6bRh7eInL1SFALuTpaDddJW', 'siswa', '2025-09-01 01:37:39', '2025-09-01 01:37:39'),
(172, 'HABIL NUR ALDIN', '252610171', '$2y$12$uZftpc/syDM9yG2fwSByw.xs.piQic6yP0zpqAxiJbkzklKaI1vNu', 'siswa', '2025-09-01 01:37:39', '2025-09-01 01:37:39'),
(173, 'KARDA PUTRA ADIANSYAH', '252610172', '$2y$12$kXZbACXQiNQLTOKiJXhcW.apIwHTIeew/1EcVEg51qwvmD30UoN.K', 'siswa', '2025-09-01 01:37:39', '2025-09-01 01:37:39'),
(174, 'MARYONO', '252610173', '$2y$12$7P.ASqpUqvzW3TgYnxCI.eZQPWmyYUeGZAGO8BS8/CVZMqkWohaBu', 'siswa', '2025-09-01 01:37:40', '2025-09-01 01:37:40'),
(175, 'MASITOH NURUL SYIFA', '252610174', '$2y$12$p1Il2kV.VM3tbB7fFEXtdenKmC9cWGp4TixHap.fhhNsIEfv8fy5i', 'siswa', '2025-09-01 01:37:40', '2025-09-01 01:37:40'),
(176, 'MOHAMAD FAJAR ALFAZRY', '252610175', '$2y$12$Rsox.AbfDlJrrh8yGwXn4uVDGsNAT/iBb2x33gr/0TT8dTTODbnfa', 'siswa', '2025-09-01 01:37:40', '2025-09-01 01:37:40'),
(177, 'MUHAMAD KHOLBY SAHIH', '252610176', '$2y$12$GTAEm56G8dR1qv.KNs.10eyX0mtcRegrES76Nt1DCW4grGMxp9ehq', 'siswa', '2025-09-01 01:37:40', '2025-09-01 01:37:40'),
(178, 'MUHAMAD RIDWAN SAPII', '252610177', '$2y$12$A9/hf5GDk4D1pd/NV.S/HuTTVktu9Aus.A8MRd11XnzW29bsqIQoG', 'siswa', '2025-09-01 01:37:41', '2025-09-01 01:37:41'),
(179, 'MUHAMMAD ALDIANSYAH', '252610178', '$2y$12$rS96tEymSzpXWBFt/J/iXucbRtpBXVVhlsIvkFwwEcOAhan/FKEme', 'siswa', '2025-09-01 01:37:41', '2025-09-01 01:37:41'),
(180, 'MUHAMMAD RIDWAN AL KHADAFI', '252610179', '$2y$12$i43zbW0iNRCvqdVJifHDhOp.pDE1c42hUiOi8vCSxSDxv3xkDjHy.', 'siswa', '2025-09-01 01:37:41', '2025-09-01 01:37:41'),
(181, 'NOVAL MALIKI', '252610180', '$2y$12$6mCZgXRrQh1ITkdavDHlBuelB223buI6IVf2sBOH3JYRke8nFZ4Ga', 'siswa', '2025-09-01 01:37:41', '2025-09-01 01:37:41'),
(182, 'NURWULAN', '252610181', '$2y$12$5WUBleIDqh0MvgOOWEqCP.a/AXZW1nDk71mZzxpB8dnhXGRT/dHg.', 'siswa', '2025-09-01 01:37:42', '2025-09-01 01:37:42'),
(183, 'OBAY SOBARNA', '252610182', '$2y$12$Mp2dg79Gxx/nMoGekjWZbucjdj8YeQHKlqM95TnbONAg.kI8o06ma', 'siswa', '2025-09-01 01:37:42', '2025-09-01 01:37:42'),
(184, 'PATONAH', '252610183', '$2y$12$pWUnJBS4Yz0tpe99xmBstuwb21I1PSLjEcvH6LFny5HevJFoSnoq6', 'siswa', '2025-09-01 01:37:42', '2025-09-01 01:37:42'),
(185, 'RAGIL GOJALI', '252610184', '$2y$12$7r4.ex8GS71QptBRexUvpO/VZx5ltVFZt4OE/FzDokIToGZvCSLAS', 'siswa', '2025-09-01 01:37:42', '2025-09-01 01:37:42'),
(186, 'RAJIF JULIAWAN', '252610185', '$2y$12$yCZJfuiq8oV/0wpn5buhB.7Xs5pT0pkNztTXeaHNr5qnRKcvXL7KG', 'siswa', '2025-09-01 01:37:43', '2025-09-01 01:37:43'),
(187, 'RIO SUSANTO', '252610186', '$2y$12$J.IlMTDIF2IsiDbTe/TkWOO/5BqxgI5D6ZBnvveJr.Y5vtRgixwQC', 'siswa', '2025-09-01 01:37:43', '2025-09-01 01:37:43'),
(188, 'RIZKY RAMDANI', '252610187', '$2y$12$g9R999Q3KHREpbekKI503uDz1f4YxqgeaNIn/G1334FHf/gGbK/iu', 'siswa', '2025-09-01 01:37:43', '2025-09-01 01:37:43'),
(189, 'RUSLAN', '252610188', '$2y$12$SvJ2PtYl89Cft7VM0BSFrOiJzeAl2SAPX9ldIGRh7HfJzOI2RoBt.', 'siswa', '2025-09-01 01:37:43', '2025-09-01 01:37:43'),
(190, 'RYAN HIDAYAT', '252610189', '$2y$12$2.GNY90saoVNxFO07Rhmee0M4swexPXoIT7k3deo/SeXyuLhe9QyG', 'siswa', '2025-09-01 01:37:44', '2025-09-01 01:37:44'),
(191, 'TAUPIK UROHMAN', '252610190', '$2y$12$d6UoFE1AliNd4Bp1lx68m.ZeqzRDgq4Yb.6FTmOes7BF6uC5jY/xS', 'siswa', '2025-09-01 01:37:44', '2025-09-01 01:37:44'),
(192, 'WILLIYANA ADISTIA', '252610191', '$2y$12$RSepHTIUCCqaHy8lQavS1OrEMQon7/5Z9lNdxvXkDvXgaxzNUrdr6', 'siswa', '2025-09-01 01:37:44', '2025-09-01 01:37:44'),
(193, 'YUSUF RAMADAN', '252610192', '$2y$12$a4.DJWurcCEfL9vXKdkqVeB/JsMe3eFSOI/c5J6.qGn41F6Mzya/W', 'siswa', '2025-09-01 01:37:45', '2025-09-01 01:37:45'),
(194, 'AHMAD GUNAWAN', '252610193', '$2y$12$LBAk38HOAwGfUpaSNL.cWeXvUrJhG8HMr0KHyhSuvOK7TizBZGhQW', 'siswa', '2025-09-01 01:37:45', '2025-09-01 01:37:45'),
(195, 'AKBAR ALVIAN', '252610194', '$2y$12$l7f0GBI0XT9vCY/hgBidPu1CtBPyjzxaQzcnBvik1eIWERGuDMm.u', 'siswa', '2025-09-01 01:37:45', '2025-09-01 01:37:45'),
(196, 'AL AZIS MUBAROK', '252610195', '$2y$12$XUCQuJiKKwaZujnoj.QLbuIGt7aMEqu.xDgVQxpY9myXIFf/kSY3q', 'siswa', '2025-09-01 01:37:45', '2025-09-01 01:37:45'),
(197, 'ALIF QIZWINI', '252610196', '$2y$12$G98Km3Ud1iHFgxUO.fWpbuvpjN567Hdy3p5wWQB1.a/mnQHx/O7zm', 'siswa', '2025-09-01 01:37:46', '2025-09-01 01:37:46'),
(198, 'CARSADI', '252610197', '$2y$12$VU.qqsI99UmWCtj95mQ7qOvXxnnlFBIGCRuiRUjWK6BBG5WgcZSsy', 'siswa', '2025-09-01 01:37:46', '2025-09-01 01:37:46'),
(199, 'CHIKA RAHMAWATI', '252610198', '$2y$12$vM85i6jMojEXYAysaB56B.hcPIHMospdNjdu8gJNjX5yqyLxg4vFS', 'siswa', '2025-09-01 01:37:46', '2025-09-01 01:37:46'),
(200, 'DEFNE MAULLANA EL SYARIF', '252610199', '$2y$12$jhmQXpVE9hLR1HNkp/mNPuTI.jAiIyIeww1juRF/1j0RKp5MVh6AO', 'siswa', '2025-09-01 01:37:46', '2025-09-01 01:37:46'),
(201, 'DEVI DESVITASARI', '252610200', '$2y$12$4z0CZiwB/f1wItKDuBoJkOvq4HD2Dj4GmHX5kh36aeJeC7lfhgG5K', 'siswa', '2025-09-01 01:38:02', '2025-09-01 01:38:02'),
(202, 'DIKA NANDA', '252610201', '$2y$12$u7O9M7Xn/o47V01aLteNVOP829j.EFBDwQtZTBZj0bHpmE3Q3QjsG', 'siswa', '2025-09-01 01:38:03', '2025-09-01 01:38:03'),
(203, 'EKA FEBRIANA', '252610202', '$2y$12$.vZnYee8zw/Ve1i3ep9BQeS05MQdOOcGy5iXxFe5xWIN2oyxnuCRO', 'siswa', '2025-09-01 01:38:03', '2025-09-01 01:38:03'),
(204, 'GALANG FIRMANSYAH', '252610203', '$2y$12$nGXfH0xNwQCTNH3m7Tf1UutRaPvB2yTqPFYOweq35xNIj5oFyCv0q', 'siswa', '2025-09-01 01:38:03', '2025-09-01 01:38:03'),
(205, 'HALIMATU ZAHRA', '252610204', '$2y$12$Atli64.VZaVQPpGtnncwqOV9YiDDALPcSUUqjsS2i.QAqztaWLR46', 'siswa', '2025-09-01 01:38:03', '2025-09-01 01:38:03'),
(206, 'HASBI ASHIDIQI', '252610205', '$2y$12$dc2nId2a9zPm/UqyqN4kLOaeYQyTtDy/xVounEV.brOymarjAJrsu', 'siswa', '2025-09-01 01:38:04', '2025-09-01 01:38:04'),
(207, 'HERDIYAN NUGRAHA', '252610206', '$2y$12$J.Ts3fvmhb4FRHKJ//q7YeqvqBOtAWKT38Dg5XPNT8eNjO9Dji6F.', 'siswa', '2025-09-01 01:38:04', '2025-09-01 01:38:04'),
(208, 'JEJE', '252610207', '$2y$12$bSiw6Qr8Fxac9FS6k4SEG.XtQrH9d/YB89Ww5OtniaQg5TFANDYxS', 'siswa', '2025-09-01 01:38:04', '2025-09-01 01:38:04'),
(209, 'MARINA F SIMATUPANG', '252610208', '$2y$12$fWy9w0fQY1eLMwIsm9VDyO.H6JbDt4pt3bmN8VZOGWz3zTY.4kkeu', 'siswa', '2025-09-01 01:38:04', '2025-09-01 01:38:04'),
(210, 'MUHAMAD IHSAN MUBAROK', '252610209', '$2y$12$Ww6qtip4BwJiX4dm2QaUceN7BHYdiFuZTv6jgKLvn2cdp/8hMdGAS', 'siswa', '2025-09-01 01:38:05', '2025-09-01 01:38:05'),
(211, 'MUHAMAD IQBAL ALFAQIH', '252610210', '$2y$12$FrnW.nTQRJMcKgfTtFt2Xu62EpeHG6VI01nVGKvMJv8Xx2CyKvg.y', 'siswa', '2025-09-01 01:38:05', '2025-09-01 01:38:05'),
(212, 'MUHAMAD KAMAL', '252610211', '$2y$12$JlYnZO23gIhAjQO6H/QzBOwQM8BYpmOnujlZONshcYuniQddiYAfS', 'siswa', '2025-09-01 01:38:05', '2025-09-01 01:38:05'),
(213, 'MUHAMAD REHAN', '252610212', '$2y$12$qD.8vYk6rYAztT27WN.Mr.KmVGdHuznTe9sYTYFzy.aeAE0GBqlX6', 'siswa', '2025-09-01 01:38:05', '2025-09-01 01:38:05'),
(214, 'MUHAMMAD WAROSATUL AMBIYA', '252610213', '$2y$12$r6t8/GVJrkIrXOxx2Spt6OFv70SbFZZS5v7d.ROwEO6WSYcFywbkS', 'siswa', '2025-09-01 01:38:06', '2025-09-01 01:38:06'),
(215, 'NURFRIAN SYAHRONY', '252610214', '$2y$12$4obAsq3mgAWgOzMTWVXLtebBZCWB.DVeE2OYqehU9w7XrEL7X8zWi', 'siswa', '2025-09-01 01:38:06', '2025-09-01 01:38:06'),
(216, 'RAELAN MUTABAROQ', '252610215', '$2y$12$vQoauOM2x/HWdNwTij8pTu.a4PAMFxAYGg/HcU0GzQOPM2Sxjdpx2', 'siswa', '2025-09-01 01:38:06', '2025-09-01 01:38:06'),
(217, 'RAMLI', '252610216', '$2y$12$rE0LYGqcPr9k4MxtqLpUnu.yS1AY246jp5jW7gw0GzgVp6aads3T2', 'siswa', '2025-09-01 01:38:07', '2025-09-01 01:38:07'),
(218, 'RIFQIANSAH', '252610217', '$2y$12$DMnnj4osW5qIq/pGYzVuAuOZ4Ya2RnLBYZq99vYuJWGMXPhWDiPTO', 'siswa', '2025-09-01 01:38:07', '2025-09-01 01:38:07'),
(219, 'RINTO', '252610218', '$2y$12$YhoXucxPz2VbLB6o6Y71c.P5iqXx7T2fc5Btf9yINsKfw2oxO5qRO', 'siswa', '2025-09-01 01:38:07', '2025-09-01 01:38:07'),
(220, 'RISMA', '252610219', '$2y$12$YV3zvZKv97vZmGXFADLQoeaxy5zGd7Rv9fQDQvdjgeXmOhlpoJsea', 'siswa', '2025-09-01 01:38:07', '2025-09-01 01:38:07'),
(221, 'SIVA YULYANTI', '252610220', '$2y$12$hBc7HhB7J.mRO0aOBFKDxuNGckAOGquZ8cRNATpe5zgg7Nh4ddvYO', 'siswa', '2025-09-01 01:38:08', '2025-09-01 01:38:08'),
(222, 'SUHERMAN', '252610221', '$2y$12$WcVq1XTDTdgEz316z2yB6e5asqAGvuzfbDjzds2dt0wEvfjVVrxMG', 'siswa', '2025-09-01 01:38:08', '2025-09-01 01:38:08'),
(223, 'SUNANTA', '252610222', '$2y$12$MBzCEdaz.iBPQTjVdinWx.XQh5Zrl/d1uuiTIfJPTw8rNdENs5Slq', 'siswa', '2025-09-01 01:38:08', '2025-09-01 01:38:08'),
(224, 'SURYANI WIDYA PUTRI', '252610223', '$2y$12$7FzJ.hAlw2LX6ekPzixaaOQsf5U2Xq0/F3VcEk0pFRYh/aGDrrvQy', 'siswa', '2025-09-01 01:38:08', '2025-09-01 01:38:08'),
(225, 'ULFIA ANGGIA PUTRI', '252610224', '$2y$12$TbPC7eNHaLkhr343/BoTtO9uVrXykkF8lcyC0frglx2YY4PegMBU6', 'siswa', '2025-09-01 01:38:09', '2025-09-01 01:38:09'),
(226, 'WARDI', '252610225', '$2y$12$mEekHWZB19q4WSp2acoA7Obfg9Nq/VExUWCssRcufPpzBxqOQpZYe', 'siswa', '2025-09-01 01:38:09', '2025-09-01 01:38:09'),
(227, 'WARDIMAN', '252610226', '$2y$12$Svd8X7pq3U9bFcxXjF4YMeEUDeThUnMqIdDlg9i8rSycZoa9A6BlO', 'siswa', '2025-09-01 01:38:09', '2025-09-01 01:38:09'),
(228, 'ZAHRAN MAHESWARI', '252610227', '$2y$12$EXuzr1ZHYVl0cPBj0DooVu8SBCGaezca4iGwLX0NhLyHxlS7BVQZG', 'siswa', '2025-09-01 01:38:09', '2025-09-01 01:38:09'),
(229, 'AHMAD RANDIKA', '252610228', '$2y$12$7sK57hTKql5x.TeoSG28H.n8IRRBA1J7d0zHGuvDvkltUVu4zD8di', 'siswa', '2025-09-01 01:38:10', '2025-09-01 01:38:10'),
(230, 'AHMAD SAEPUDIN', '252610229', '$2y$12$e9T0U5HOw5yl2T7FgiGpTuB8pULYaiPTNRg4g4aCbOy7Kz0KDZ8jS', 'siswa', '2025-09-01 01:38:10', '2025-09-01 01:38:10'),
(231, 'AHMAD SOFWAN ISMAIL', '252610230', '$2y$12$HIDmi2gGpsnBR/h44MWJfe0L8wi/HXH0CCvmIvDB0uVrmnS4VXsbO', 'siswa', '2025-09-01 01:38:10', '2025-09-01 01:38:10'),
(232, 'ANDHIKA RAMADHAN', '252610231', '$2y$12$WpvNCG9MUuDIF3joLjQe8.0EA38p.qpTTkxTCAEM9T/BB8orZPfQq', 'siswa', '2025-09-01 01:38:10', '2025-09-01 01:38:10'),
(233, 'ANDIH SAEPUL BAHRI', '252610232', '$2y$12$zmZ93kRHk/i3IID5c059kePx1hO3JJ1TAhRIj7xcYcNZffUhHLBfK', 'siswa', '2025-09-01 01:38:11', '2025-09-01 01:38:11'),
(234, 'ANDIKA PRATAMA', '252610233', '$2y$12$seY3XTzzMC/uUR9MnT5l2e119ZI5hyOTcsxji8qYWi13UbqrUk3R.', 'siswa', '2025-09-01 01:38:11', '2025-09-01 01:38:11'),
(235, 'ARIYA DARMAWANSYAH', '252610234', '$2y$12$bkJMXDEdMItE.QaXfJJTue7EwuToIMafpfz1KwLJGdg3.jZ3/bkl.', 'siswa', '2025-09-01 01:38:11', '2025-09-01 01:38:11'),
(236, 'ARSYA NUR HARLY HASAN', '252610235', '$2y$12$qdyvpv67QelNHirStgu5B.vJCT6g7TNDr/2nPUIvUyVFe9asKjcM2', 'siswa', '2025-09-01 01:38:12', '2025-09-01 01:38:12'),
(237, 'BENI KURNIA', '252610236', '$2y$12$9fiaCTBvWUU4CaNwe3zrKuLqaAVu8nLkb/zdpMj4u6IvOG9TxPrT6', 'siswa', '2025-09-01 01:38:12', '2025-09-01 01:38:12'),
(238, 'CANDRA AKBAR', '252610237', '$2y$12$kkkmmQlA8ZrlcAO4e8uA4.H8s.lE4jjZ3T2JzCvhiF.8mk6pAhoXW', 'siswa', '2025-09-01 01:38:12', '2025-09-01 01:38:12'),
(239, 'CINTIA', '252610238', '$2y$12$9qBhJp/wjJ8avr3lfdisaOkaVYLhMkx9V7RrfVSL6Sb6JzeyIpk1y', 'siswa', '2025-09-01 01:38:12', '2025-09-01 01:38:12'),
(240, 'DEWI CUT NADIN', '252610239', '$2y$12$GyAAwY8FnYbsi1Y9YG.AwePbPZ8SjMjwou2BDGZVLn2ozabMLx7lC', 'siswa', '2025-09-01 01:38:13', '2025-09-01 01:38:13'),
(241, 'DIKA BAEHAKI', '252610240', '$2y$12$fumURHgEbGMN6BgECd1afuRZx/GVJNHy/aH/./dPQa8NlgtKoP1wC', 'siswa', '2025-09-01 01:38:13', '2025-09-01 01:38:13'),
(242, 'DIMAS SETO', '252610241', '$2y$12$YaY.9es72rYo.c9kFKmFZueoPIPsaVUqKawXIZRdre9yksKVVmiH2', 'siswa', '2025-09-01 01:38:13', '2025-09-01 01:38:13'),
(243, 'FAIQ SUGILAR', '252610242', '$2y$12$TJjUMIo80Ij1sCy359bw2uUkd5eBvZbrCiK5dbd/esWYM6kWOsuJS', 'siswa', '2025-09-01 01:38:13', '2025-09-01 01:38:13'),
(244, 'FAJRUL MA ANI', '252610243', '$2y$12$X4iKZyh6YmRcEUiJpbTWyeU7Zv.5AWp.bhBcJDalSiW4jrPhsp.za', 'siswa', '2025-09-01 01:38:14', '2025-09-01 01:38:14'),
(245, 'FUJA SAEPULLOH', '252610244', '$2y$12$4OVNl6/KW3O8Zbhcis3on.sZBFFvN0RV0WGOYWAMoyYUNWd4t5QFW', 'siswa', '2025-09-01 01:38:14', '2025-09-01 01:38:14'),
(246, 'HENDI SETIAWAN', '252610245', '$2y$12$9AxjZmUdzPA/XOVqM6wT.ON8.isCphT77SnDyGaa9p/o6pirapf4a', 'siswa', '2025-09-01 01:38:14', '2025-09-01 01:38:14'),
(247, 'KARNATA JAYADI NINGRAT', '252610246', '$2y$12$Hpz0Y7Er0jHGsYAzw16mNOCyp8CVEagAG26qdUHDFI3XI0rzRK22C', 'siswa', '2025-09-01 01:38:14', '2025-09-01 01:38:14'),
(248, 'MUHAMAD KHAIRUL INIESTA', '252610247', '$2y$12$kYcMGyLmOTzLN6YRwrRN7eOLwoMp1P0bi.XtykBc22qhmyT/q7.5G', 'siswa', '2025-09-01 01:38:15', '2025-09-01 01:38:15'),
(249, 'MUHAMMAD DANIAL ALPIKRI', '252610248', '$2y$12$pzQTIe0kDWstJWOSowug9.Y40D0PsHKUqSiyCOzIuDgJyj9UM9R5m', 'siswa', '2025-09-01 01:38:15', '2025-09-01 01:38:15'),
(250, 'NENENG HABIBAH', '252610249', '$2y$12$ljG4skCc45JGWMFwVAyTz.LMYX6Vy/YlLzmtjBJt1jaKuVNCzk4vq', 'siswa', '2025-09-01 01:38:15', '2025-09-01 01:38:15'),
(251, 'NOVAL JUNIAN SALEH', '252610250', '$2y$12$iKNjGEOizSF/l6Fpa7dua.f5786p5sejgVSGVyrrgfEYURnzYVF32', 'siswa', '2025-09-01 01:38:16', '2025-09-01 01:38:16'),
(252, 'NUAF DHANU WINATA', '252610251', '$2y$12$MnZrERgNf6S97lrpoDFLmOCJp/9esF./XJfWWvq37gla64myWQe52', 'siswa', '2025-09-01 01:38:16', '2025-09-01 01:38:16'),
(253, 'RAIHAN ABDUL YAFIDZ', '252610252', '$2y$12$a7JjH46NTYzgGxA0JtuS2uRo1J6Vik5.7hfZ.r1hwhIq9cEbv.0Hi', 'siswa', '2025-09-01 01:38:16', '2025-09-01 01:38:16'),
(254, 'REIHAN FIRMANSYAH', '252610253', '$2y$12$mSRBfaXViOVD5txyls3PWORpHoEJ5306zHOvD.YF12LcLY.bc6NT2', 'siswa', '2025-09-01 01:38:16', '2025-09-01 01:38:16'),
(255, 'RIO RAMA', '252610254', '$2y$12$/49VpLznqLbBctqQmvVY5.qOBrt2fIy2BymdoBHZ3lN6mBkfHnhkq', 'siswa', '2025-09-01 01:38:17', '2025-09-01 01:38:17'),
(256, 'RITA FITRIA', '252610255', '$2y$12$Jh8YlWLeQffEztEykpQHnO7HcoIoHGyWK8ngwbQpnDwlvYxJoI4yq', 'siswa', '2025-09-01 01:38:17', '2025-09-01 01:38:17'),
(257, 'ROFIKOH ALIYATUL SUNIAH', '252610256', '$2y$12$tHxV2G9Bmv6tIF.43SBLiun7Aq2m8qAptHhTeChKhuTDxHL2.Oc.G', 'siswa', '2025-09-01 01:38:17', '2025-09-01 01:38:17'),
(258, 'ROSAM CAKRA WINATA', '252610257', '$2y$12$CPwWfHX/wfybK9PSNPMtsuaLQRQ8.6CnyxkDKGfHKwLlHsy5LhXFy', 'siswa', '2025-09-01 01:38:17', '2025-09-01 01:38:17'),
(259, 'SAEFUL GOFAR', '252610258', '$2y$12$OyqYv2G.qPQegqzQjcVi1.q3yZHgPSz7/c5TKl9gbJBJLzttkBTfe', 'siswa', '2025-09-01 01:38:18', '2025-09-01 01:38:18'),
(260, 'SAEPUL MAULANA', '252610259', '$2y$12$cbcTX7u7l.FjIzBe0MbSw./f.Bc2zGt0d2V1.EQGP/ZMzg1AD.uqu', 'siswa', '2025-09-01 01:38:18', '2025-09-01 01:38:18'),
(261, 'SETIYAJI AHMAD FAUZI', '252610260', '$2y$12$HrKayVVMxlQt13IOs4uJ3.90wt9mDvw0ydhgzhl6TaS/7Z2HRw2IC', 'siswa', '2025-09-01 01:38:18', '2025-09-01 01:38:18'),
(262, 'WINDY OCTOVIYA', '252610261', '$2y$12$RIP85wdCnZqMi7MbCyVv0u0ljzg8/0wcrcQkLaZadx37ELbXkU1ci', 'siswa', '2025-09-01 01:38:18', '2025-09-01 01:38:18'),
(263, 'YUDI ADITIA', '252610262', '$2y$12$3RgWVrpn1f36O5.HJjyNROlBLNBCuum1fXNsPHPJvhTzkjrOYwQCy', 'siswa', '2025-09-01 01:38:19', '2025-09-01 01:38:19'),
(264, 'AMELIA', '242510001', '$2y$12$wUy3Fo72Q1iF1oItYkPbf.hxfJBE6BYk4Ga68k549g9.5e6PYHYEu', 'siswa', '2025-09-01 01:38:25', '2025-09-01 01:38:25'),
(265, 'ANISA RHAMADANI', '242510002', '$2y$12$8b06AMZendHN0somZ/7.tO/UMJ3BA9dlsied6fTSi54NkZnOizlFe', 'siswa', '2025-09-01 01:38:25', '2025-09-01 01:38:25'),
(266, 'AYU NINGRAT', '242510003', '$2y$12$7MAlg3FvvDXW6KL2q3MlaOy6wmMS2VP/x/0eJ5aO02O2jDP/iTTKO', 'siswa', '2025-09-01 01:38:25', '2025-09-01 01:38:25'),
(267, 'CINDI LESTARI', '242510004', '$2y$12$UnAnCcSb61KJT9r423DLa.ZM7Lp1UKMnzvm.oLZrbbiOibhR/2pZC', 'siswa', '2025-09-01 01:38:26', '2025-09-01 01:38:26'),
(268, 'CITRA SHABILA IRAWAN', '242510005', '$2y$12$4t3sC8lQEUdd5VzJYoB8Je5nOsgv32CKSx84DxY4eYwSHq8G3ZnDm', 'siswa', '2025-09-01 01:38:26', '2025-09-01 01:38:26'),
(269, 'DENITA SARI', '242510006', '$2y$12$pzLWYgY/zu2k1.ojYERKH.WM0vQzrdG7WE62diZawXHsRRda6V6cO', 'siswa', '2025-09-01 01:38:26', '2025-09-01 01:38:26'),
(270, 'EVI NURAENDI', '242510007', '$2y$12$a1I3zcv6J2Dla/mxUCwcNe9C1CeMtpiCZ1fCScfcPbJMVg7siTiBe', 'siswa', '2025-09-01 01:38:27', '2025-09-01 01:38:27'),
(271, 'INTAN LESTARI', '242510008', '$2y$12$lA3jKVOjlXI5H1WQWZAfBuQkUpoPk6Hpv6.MixDoRfnsWhssrDo6i', 'siswa', '2025-09-01 01:38:27', '2025-09-01 01:38:27'),
(272, 'INTAN RASJI RAMADHANY', '242510009', '$2y$12$tsmJP8l8PXhnVY1q1zIp5eyHOj.1StNKysJK2Uz5qErur4VvfRhIq', 'siswa', '2025-09-01 01:38:27', '2025-09-01 01:38:27'),
(273, 'KARLINA', '242510010', '$2y$12$8iHQHf5pb0KguLukH66n2O05x4Eq4ynJ3pT/4oJhbWYkFia5z2XPW', 'siswa', '2025-09-01 01:38:27', '2025-09-01 01:38:27'),
(274, 'KURNIA', '242510011', '$2y$12$5JEGS6.pDLMnF4GuPAzHIeDpclsxKTvEL.6qFCtMX8BLXxif4RpY.', 'siswa', '2025-09-01 01:38:28', '2025-09-01 01:38:28'),
(275, 'MAHENDRA', '242510012', '$2y$12$NuOazx.Y5LQpHmPfSNBKb.RCiRx9P/NQiPvDHjQ2K0y3YjNo5Ksr6', 'siswa', '2025-09-01 01:38:28', '2025-09-01 01:38:28'),
(276, 'MARPUAH', '242510013', '$2y$12$aEdiEQPyvt1qby76qsOQEuVjeVyNSAMozvW.Fnptbs.GzcS2/TY.e', 'siswa', '2025-09-01 01:38:29', '2025-09-01 01:38:29'),
(277, 'MAULANA ANSORI SURYANA', '242510014', '$2y$12$z/W21bgiciZcrpUuGa7KYO2nabNW/G3taSR.SCDnVxsu3qfznfr/C', 'siswa', '2025-09-01 01:38:29', '2025-09-01 01:38:29'),
(278, 'MAYLANI', '242510015', '$2y$12$h7lAqduBVSEQw7Qvbv7MWO2YaWTr1HfwQ5hASdRtK7Hpe5.PAV9k6', 'siswa', '2025-09-01 01:38:29', '2025-09-01 01:38:29'),
(279, 'MUHAMAD ADHI SATRIO', '242510016', '$2y$12$OP5z7M73YEzSPjleYSOK2.je2zY3jezwbpyW8CU7K.kD103YjU5ba', 'siswa', '2025-09-01 01:38:29', '2025-09-01 01:38:29'),
(280, 'NUR SILVA OCTAVIA', '242510017', '$2y$12$.5FAI9TuxHjF8/eGnwPYauD9VnlPL6YV9F1Wv/ArrXntxTIihQAxy', 'siswa', '2025-09-01 01:38:30', '2025-09-01 01:38:30'),
(281, 'NURMALA PUSPITASARI', '242510018', '$2y$12$Ov.CoxKp39.vA8DNLCRRgOFlAwrFlrckGz2cmXWItPYf.Zpycr9P2', 'siswa', '2025-09-01 01:38:30', '2025-09-01 01:38:30'),
(282, 'QORIATUL FITRIYAH', '242510019', '$2y$12$Dm9ptZ.GrqFZ4tERDeUeXeSd7OtbdQaIv363BpdUnz86Xx0XXXIoW', 'siswa', '2025-09-01 01:38:30', '2025-09-01 01:38:30'),
(283, 'RAHMA PUSPITASARI', '242510020', '$2y$12$x3gQWlln1RcXy9fAd8.CkONdTfKe/3WJgnIXBKRM85XR3I.TtuD/u', 'siswa', '2025-09-01 01:38:30', '2025-09-01 01:38:30'),
(284, 'RISKA APRILIA', '242510021', '$2y$12$IBV5VgF8r3uEn77zfTNAOOEsD8.sSJoFiAKUs52aGbLyiQ..1/cim', 'siswa', '2025-09-01 01:38:31', '2025-09-01 01:38:31'),
(285, 'RISMAYANTI', '242510022', '$2y$12$lrXAL.OuzPGhy0n0ql2/xum2OAotsd9P77mJL6jaN.snrdgztUmAi', 'siswa', '2025-09-01 01:38:31', '2025-09-01 01:38:31'),
(286, 'SARAH INDRIYANTI', '242510023', '$2y$12$ck5o6pEwtxfqL.3Q9/opF.tBsXp.qOchcBInjL7pdj1f4Ge2DnLWW', 'siswa', '2025-09-01 01:38:31', '2025-09-01 01:38:31'),
(287, 'SITI JAHROTULSYITTA', '242510024', '$2y$12$hEQi3UorkpfNQ1b3NS4BxeC/vm.GjCfmUGDWVyWkelMPqkaGyll8y', 'siswa', '2025-09-01 01:38:32', '2025-09-01 01:38:32'),
(288, 'SITI NURHASANAH', '242510025', '$2y$12$20Fp3yJTiaV9H7mrhibgSufgHFgUmGds7a3QxFIkUU/UiDNNcWoOW', 'siswa', '2025-09-01 01:38:32', '2025-09-01 01:38:32'),
(289, 'SITI NURPADILAH', '242510026', '$2y$12$tIhtPoIsGWtvcz7zCk.zeOKksDuahFrqZt4g7Tuabd23FtEZ1oKI.', 'siswa', '2025-09-01 01:38:32', '2025-09-01 01:38:32'),
(290, 'SITI SALAMAH', '242510027', '$2y$12$TBNYAL.kGcLIJteKZfdoBefOmVNjcysGufOKBU8nAgkFRYXaDebB6', 'siswa', '2025-09-01 01:38:32', '2025-09-01 01:38:32'),
(291, 'SITI ZENAB', '242510028', '$2y$12$qM7V.Qsm1zERcvUiSMeItOd1QijDNlKaFqNAPMQ9zGOTibP96hz9q', 'siswa', '2025-09-01 01:38:33', '2025-09-01 01:38:33'),
(292, 'SYAVIRA DWI NOVIANTI', '242510029', '$2y$12$ryqAZvoR6dVT33x1fY7sgehuBLFvyLhN57GJzrvFOH0NSJSdwKMmW', 'siswa', '2025-09-01 01:38:33', '2025-09-01 01:38:33'),
(293, 'SYIFAUDZIHNI', '242510030', '$2y$12$Ylp7Sqr.C2hhIHCnEgNwge3AGjdNklW.vTh5yzXAi3Og8XppIU7wS', 'siswa', '2025-09-01 01:38:33', '2025-09-01 01:38:33'),
(294, 'TASYA ANANDA', '242510031', '$2y$12$NL0r65bH8XjzqUS9jiVjoOt2YwkCEDd59vSB9f/DS5wJLABkQ.ZvS', 'siswa', '2025-09-01 01:38:34', '2025-09-01 01:38:34'),
(295, 'TIKA DEWI', '242510032', '$2y$12$hCNhVoiveqybv2r.oXrIvexO1/IlD9HOxcPGIb9OkBQzolVhr2GO.', 'siswa', '2025-09-01 01:38:34', '2025-09-01 01:38:34'),
(296, 'WILDA CAHYANI', '242510033', '$2y$12$lzMjrrZUylC09phlK3S6ZeMHzm8UmDICteZAijpCg/VfkiLbVvYPC', 'siswa', '2025-09-01 01:38:34', '2025-09-01 01:38:34'),
(297, 'AISAH WALINAYAH', '242510034', '$2y$12$JLeKRhW9gJyR5m0UXNwplOzDNYOUR0fJb7anD95Eyz671opNaAup2', 'siswa', '2025-09-01 01:38:35', '2025-09-01 01:38:35'),
(298, 'ANGGUN DARA CANTIKA', '242510035', '$2y$12$QWi7tnhe.qzUau8C2pY4mecu.5R2MrrSZ3uPOH8KgbfQ7mcfRdVxC', 'siswa', '2025-09-01 01:38:35', '2025-09-01 01:38:35'),
(299, 'APRILIANI', '242510036', '$2y$12$TJ4varSl.Ss83iHMs91rvere6XWFNLhabR23GXw93dmmtgLtc21Ve', 'siswa', '2025-09-01 01:38:35', '2025-09-01 01:38:35'),
(300, 'ARUM', '242510037', '$2y$12$lo75c9kU3Xw55qxETNSeJuQHtWGfCB2LNAFM7gshqwU5XOo8T8GpG', 'siswa', '2025-09-01 01:38:35', '2025-09-01 01:38:35'),
(301, 'CITRA NURY RAHMAN', '242510038', '$2y$12$tN6NMqkvGPd3TjjCU9v1PeUv76ZFqA7Pz8eLMLYGvDhbOYgKw2m4S', 'siswa', '2025-09-01 01:38:36', '2025-09-01 01:38:36'),
(302, 'DEDEH FAUZIYAH', '242510039', '$2y$12$9WNG6AwMcXwe1g7Au5R7We9orAKfMwepiCKJOAB2IqxGmW2g4q4A6', 'siswa', '2025-09-01 01:38:36', '2025-09-01 01:38:36'),
(303, 'DEVI YULIANI KUSMANTO', '242510040', '$2y$12$TmZlab685GJyHadx6Zg9luduLS546Re3Mze5VeQ655CQerLO9cH7G', 'siswa', '2025-09-01 01:38:36', '2025-09-01 01:38:36'),
(304, 'DINDA LESTARI', '242510041', '$2y$12$WO.bAZWRsngGKZymYaXbz.hveq55.t3f.ac5zzulFuBCK7vse1LO.', 'siswa', '2025-09-01 01:38:37', '2025-09-01 01:38:37'),
(305, 'ERNAWATI', '242510042', '$2y$12$ZbHAJhUGoim0BdlX3rQF5OLVAd/teHkfDE2BPyA5i0vaavK1RyCoO', 'siswa', '2025-09-01 01:38:37', '2025-09-01 01:38:37'),
(306, 'INAYAH', '242510043', '$2y$12$M.WgI8Z3cnp7gIy4NT03xeNcKXS5TMsErG3qv/4wV30mnZw3rvt8K', 'siswa', '2025-09-01 01:38:37', '2025-09-01 01:38:37'),
(307, 'LAILA', '242510044', '$2y$12$YPgr9KSCYm0ZS8ynfhyoj.v231nK/jNAV3QF1MfSQu5cG8jZJOnCG', 'siswa', '2025-09-01 01:38:37', '2025-09-01 01:38:37'),
(308, 'LUTIKA SUNDAWA', '242510045', '$2y$12$yrRwSldILRn0wJYjIhmx9OrBqim/QrGri0dZCUslY5i06bEc9drmC', 'siswa', '2025-09-01 01:38:38', '2025-09-01 01:38:38'),
(309, 'MAULIDDIVA NAWWAROH', '242510046', '$2y$12$X54G6.QXKxCaj0accUo72eS8T96HOKOaSkl9iSo9cP1Zn7msquwZO', 'siswa', '2025-09-01 01:38:38', '2025-09-01 01:38:38'),
(310, 'MAYA MAESAROH', '242510047', '$2y$12$9XPObYJDwb1MmIqUGZLzYO7ci/FKMCWNVuP6ZYivb19JYlLNnAEI.', 'siswa', '2025-09-01 01:38:38', '2025-09-01 01:38:38'),
(311, 'MELYANI', '242510048', '$2y$12$Oa8gdc3ysfebofc081IIS.fkGv5kWHP8toJ2a0IPKjAVpzYeZXTvq', 'siswa', '2025-09-01 01:38:39', '2025-09-01 01:38:39'),
(312, 'MIA BIATUL QOYA', '242510049', '$2y$12$G/nRdZM9.SVu6nutWCE8oOvg03IBYvk8Kfjnm8sE7nB1BEbj36zuK', 'siswa', '2025-09-01 01:38:39', '2025-09-01 01:38:39'),
(313, 'MUHAMMAD RAFFA RODIYANA', '242510050', '$2y$12$FhOY78F.iLsPhejT/OWGUuYE7rTI7tcCVPkCb6rPyk7CUEQdvH6be', 'siswa', '2025-09-01 01:38:39', '2025-09-01 01:38:39'),
(314, 'NAJWA FITRIA AZZAHRA', '242510051', '$2y$12$6qafd5HACAVHrE4SYjwHSuhoHCMRqkKAqt0Fo/wUItBc1o6v6RK4y', 'siswa', '2025-09-01 01:38:39', '2025-09-01 01:38:39'),
(315, 'NINING NURFALAH', '242510052', '$2y$12$2Q4UuziRkH/l0GtRBLMB6Oanf5oI3UDeA8N5PW8V.2PTO2oz8vbLi', 'siswa', '2025-09-01 01:38:40', '2025-09-01 01:38:40'),
(316, 'NORMAN HIDAYATULLAH', '242510053', '$2y$12$.Psw7erzdlYULKvQMxx4.e8vaDZ2n7p/PeM7BOlGb.q4EXS83FLb2', 'siswa', '2025-09-01 01:38:40', '2025-09-01 01:38:40'),
(317, 'NOVI SEPTIANA RAHMADANI', '242510054', '$2y$12$f.7huNcJHEB5bZl9aYg2B.w72u38l5sSu8xeXoWYZiMHJKnRyBHaC', 'siswa', '2025-09-01 01:38:40', '2025-09-01 01:38:40'),
(318, 'NURMALA', '242510055', '$2y$12$GKeBV8NhMmrkYajY4TBSPuGE7L0sWQZK38qbmok11Qcu07RWgqnEK', 'siswa', '2025-09-01 01:38:41', '2025-09-01 01:38:41'),
(319, 'PUTRI SALSABELA', '242510056', '$2y$12$QcI9vVO7TiCL0gC1I6QgeOmlM4KmHxN.0rBGlcJ9llgWpemO9A4o6', 'siswa', '2025-09-01 01:38:41', '2025-09-01 01:38:41'),
(320, 'RANI', '242510057', '$2y$12$WXJavkrm5OVbaFMruh5.Auh1VyO9MDsEG8Z3MhFO..Q41BDuljn7i', 'siswa', '2025-09-01 01:38:41', '2025-09-01 01:38:41'),
(321, 'RIRIN EKAWATI', '242510058', '$2y$12$ZBj7Vqto5FhB5YaTXM7zFOuf7F6DT8w0ogpIu0R0KqjbZ3BqI4J6i', 'siswa', '2025-09-01 01:38:41', '2025-09-01 01:38:41'),
(322, 'SARASWATI', '242510059', '$2y$12$KcCweruMks0yaZJUe7rC6.Z5SueHhr8YM6knTsyKjatWKl9d.CL76', 'siswa', '2025-09-01 01:38:42', '2025-09-01 01:38:42');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(323, 'SITI NURJAMILAH', '242510060', '$2y$12$UES4FnhWW2VfIH0nhA8MveiJ2UxpzShORtjuibPXgTVDaLVPNl/LO', 'siswa', '2025-09-01 01:38:42', '2025-09-01 01:38:42'),
(324, 'WIWIN NURMAULIDA', '242510061', '$2y$12$Xx1Q5oOzvrPjrLSTHMz8xO/UHxBHAksgauOq8BsyGXkaTc15B6JeS', 'siswa', '2025-09-01 01:38:42', '2025-09-01 01:38:42'),
(325, 'WULAN SARI', '242510062', '$2y$12$ykrBVoW4Cnr72PManxBL9enMxdQG5sVDrQmLpbEQyKbEMeW9/8CWK', 'siswa', '2025-09-01 01:38:42', '2025-09-01 01:38:42'),
(326, 'ZAHRA AYUMI', '242510063', '$2y$12$lB9UViBvxspLfK.rYBQWCevIfoRrvOJMrTxVs0bzmFPf8Z7Pccce6', 'siswa', '2025-09-01 01:38:43', '2025-09-01 01:38:43'),
(327, 'ZAHWA AENURROHMAH', '242510064', '$2y$12$MfNkovU/Qfam78KrNb2Nkux3I2Pj3lsr1Qq1ZQOrlabPu3a4jNQuu', 'siswa', '2025-09-01 01:38:43', '2025-09-01 01:38:43'),
(328, 'ABDUL SODIK', '242510065', '$2y$12$VMtm4v/7nSDEbOsfQmHZvupyFIDlVgroiJ97s1UiTFjq/StkQ3GzC', 'siswa', '2025-09-01 01:38:43', '2025-09-01 01:38:43'),
(329, 'AGNAN HAMBALI', '242510066', '$2y$12$G9wB3JVLoo0MAISkwF3oZudCCHGANU26ZLZAvnN3Wbk6teGIrmgU2', 'siswa', '2025-09-01 01:38:44', '2025-09-01 01:38:44'),
(330, 'AGUS MULYANA', '242510067', '$2y$12$4Xg4Sz4uuhd8kOOGaHphieUobdoP5Q.M1kUXtQ1wSKZGNhwt9jqgG', 'siswa', '2025-09-01 01:38:44', '2025-09-01 01:38:44'),
(331, 'AKBAR DHANI', '242510068', '$2y$12$TtsWCLAs6S/XiYpwzqviDerLLvoenjAAazfUrrcJu5gVLYhPVfy5K', 'siswa', '2025-09-01 01:38:44', '2025-09-01 01:38:44'),
(332, 'ALDI FAUZAN', '242510069', '$2y$12$WZhPixnB6sy/.QBxHwH6reoE/taWbmkhCt/RPLVicQ2bfrd5E569i', 'siswa', '2025-09-01 01:38:44', '2025-09-01 01:38:44'),
(333, 'ALDIEN AKBAR', '242510070', '$2y$12$pZMex2aGjhb9EMVmSMfIX.3pPe3mVv7qS91ji1LagY/T.AAJ5gyBa', 'siswa', '2025-09-01 01:38:45', '2025-09-01 01:38:45'),
(334, 'ALPI SAEPUL AKBAR', '242510071', '$2y$12$JW.TfPAZzR7aS5fwFboTAelD2XXOKSUGherGumhAqzqqWX6CU6zFC', 'siswa', '2025-09-01 01:38:45', '2025-09-01 01:38:45'),
(335, 'ANDIKA SYAPUTRA', '242510072', '$2y$12$oZIzHvSfJcD1PI2uo6gaSOmf3Re1KLQkz4PIoOQCT7RfwGSw9cnQ6', 'siswa', '2025-09-01 01:38:45', '2025-09-01 01:38:45'),
(336, 'AYOM PRAYOGA', '242510073', '$2y$12$cdQKF.q8nsQG.5p9kcBWuOxgB//03Kak1KMNcXmgJqyFjC2QJ6Qea', 'siswa', '2025-09-01 01:38:45', '2025-09-01 01:38:45'),
(337, 'CAHYONO MAULANA', '242510074', '$2y$12$CJWqy5w/6kzv0n0l6fFsM.4iatxcLIQAQkjcjkCm9bJ7FmoCH9YC2', 'siswa', '2025-09-01 01:38:46', '2025-09-01 01:38:46'),
(338, 'DIMAS PRADIPTA FUDHOLI', '242510075', '$2y$12$0OvwLaBJaTqXrA7ZtqJZ9eocvk2XRgp313KNjCfV11hRJof0oW5dW', 'siswa', '2025-09-01 01:38:46', '2025-09-01 01:38:46'),
(339, 'EKA RAMDANI JUNAEDI', '242510076', '$2y$12$lQxB9/FX0m3nL/h6qA0wSeYAkrB.tQvBafOzhhly0F/EOUkS20LX.', 'siswa', '2025-09-01 01:38:46', '2025-09-01 01:38:46'),
(340, 'EVA NURAENDI', '242510077', '$2y$12$vXsdpSkpsABHmkqZGzldUeAftv1rTYQJ6RxwqUIdMY43EW8y7BwCe', 'siswa', '2025-09-01 01:38:47', '2025-09-01 01:38:47'),
(341, 'GENTA TENGGARA BADAY', '242510078', '$2y$12$F/Gq7KNxMTrFXHfvUMEDhuqO/6hu/DpBaz8ayNHSBXCg2.AbaVKkK', 'siswa', '2025-09-01 01:38:47', '2025-09-01 01:38:47'),
(342, 'INTAN NURJANAH', '242510079', '$2y$12$KVFQ2prfZrrLK0tcoTIaJezqkBWiLdKLKL6oGBnODKtTUNSDJbHSO', 'siswa', '2025-09-01 01:38:47', '2025-09-01 01:38:47'),
(343, 'IRPAN HERMAWAN', '242510080', '$2y$12$0Vi58qYxYQHZbsFWvVjOUOO25zne6/S2xMhrKdA.w15.Pd8yGjGQG', 'siswa', '2025-09-01 01:38:47', '2025-09-01 01:38:47'),
(344, 'MUHAMAD YAHYA', '242510081', '$2y$12$/S/a8G8lS4gUc68W6Vbj2OFGJApPG4sIA1gJXd0N35oqR4w3tUt5K', 'siswa', '2025-09-01 01:38:48', '2025-09-01 01:38:48'),
(345, 'NABILA JULIANY', '242510082', '$2y$12$oMNjSmGRUvUb0RozRn9YSusxjrHCFyEc15tb7xkMETzJE3c6hMMTC', 'siswa', '2025-09-01 01:38:48', '2025-09-01 01:38:48'),
(346, 'RAFI MAULANA LILAH', '242510083', '$2y$12$ywk3u0TE7OxGqTxdYZ6F/.3RxnCssrYrptjex2zzzUbH77QSTPGji', 'siswa', '2025-09-01 01:38:48', '2025-09-01 01:38:48'),
(347, 'RAMA ALDIANSYAH', '242510084', '$2y$12$i47sqfSIkag/4fERGCil/O8Jf5J1e6SXffdgLI1cBOdvr49yrv4oK', 'siswa', '2025-09-01 01:38:48', '2025-09-01 01:38:48'),
(348, 'RAMA HERDIANSYAH', '242510085', '$2y$12$JhXCmeG0eCO.lFBULIvQqehmlHcsLLUlAdBZ5yZv7jxc6g1bEgFUi', 'siswa', '2025-09-01 01:38:49', '2025-09-01 01:38:49'),
(349, 'REDI', '242510086', '$2y$12$S4lT5jYOpI3meCE7TLmN7OOGy/3e5M9tnF3.YK.oPN8.XIfdkVRAe', 'siswa', '2025-09-01 01:38:49', '2025-09-01 01:38:49'),
(350, 'REGIA NANDA FEBRIATAMA', '242510087', '$2y$12$ee9nMmELJW0.IbnmZATW5.vkvQYBRIJb7dE1exU4j/8N/2CDMj89u', 'siswa', '2025-09-01 01:38:49', '2025-09-01 01:38:49'),
(351, 'RIFKI MULYANA', '242510088', '$2y$12$0RgxdjGB4d5iRhgs.0MXwuTbQ8GHBsCbc50KPTdMok7gOhYAZl0sS', 'siswa', '2025-09-01 01:38:50', '2025-09-01 01:38:50'),
(352, 'RIZKY ADITIYA', '242510089', '$2y$12$RWBJdqp/Q1xm/6m2PJPRU.EsOq5o/153w1KSNwBBq.Yp9WF1g./6a', 'siswa', '2025-09-01 01:38:50', '2025-09-01 01:38:50'),
(353, 'RIZKY AZIZ MAULANA', '242510090', '$2y$12$JVirKAQyhwfGYpAMCv4qM.rTd3U6LWGWYyJ2G1XXfSe7CBDalisky', 'siswa', '2025-09-01 01:38:50', '2025-09-01 01:38:50'),
(354, 'SITI MARIYAM', '242510091', '$2y$12$.Bv4SlbF8oY93t0HkB5Nr./lJ3eSZLnL1u/g9sdcaYIqZ1O1vPacK', 'siswa', '2025-09-01 01:38:50', '2025-09-01 01:38:50'),
(355, 'SYAHRILLA PERMATA NUSANTARA', '242510092', '$2y$12$xaojElie2m5bTwD328qiz.S7.9f9483fHiYIUH2Saxg4I/YxPKjOm', 'siswa', '2025-09-01 01:38:51', '2025-09-01 01:38:51'),
(356, 'WIBY KURNIAWAN', '242510093', '$2y$12$MUyZVK99z6AK87wd0CerEeoziQCMXhvQjkqyPXoeYzmxWSVL.GpzW', 'siswa', '2025-09-01 01:38:51', '2025-09-01 01:38:51'),
(357, 'WIDIYA ANISA PUTRI', '242510094', '$2y$12$unpE7Q.J5z0YiVkyIT7dCei0CfjhutkKJ8fsDo9TxExrVBzLuV.ki', 'siswa', '2025-09-01 01:38:51', '2025-09-01 01:38:51'),
(358, 'WINDY DANUARTA', '242510095', '$2y$12$acsUdjcgBML8AFOfTeU8HOUpW596.xioSFQSc3lvipYoAzZB4UN2e', 'siswa', '2025-09-01 01:38:51', '2025-09-01 01:38:51'),
(359, 'YUDI MULYANA', '242510096', '$2y$12$Enol55K5SVj8TQyTkcpyQOXilFwOoA7ul3DCwkPoNFuyc26hjyHwy', 'siswa', '2025-09-01 01:38:52', '2025-09-01 01:38:52'),
(360, 'ADITTIYA SAPUTRA', '242510097', '$2y$12$a44CEAL.TY5hw3QA46oZ1eLtEwQEgSip7mlKnHfMW1nZD8C1Qv03S', 'siswa', '2025-09-01 01:38:52', '2025-09-01 01:38:52'),
(361, 'AFDAL ZIQRI RAMADAN', '242510098', '$2y$12$.eMUnWcn1nlIdcGu0Hr6c.f8v5pfsdZC5UPYyGMsOQ7VkMzu1GZGO', 'siswa', '2025-09-01 01:38:52', '2025-09-01 01:38:52'),
(362, 'ANDIKA EKA SAPUTRA', '242510099', '$2y$12$P3O7x7ba4YvdguO7gCf7xuyUWREvH9wt6Eoa.Z1G6Y0QWkV8cKNo6', 'siswa', '2025-09-01 01:38:53', '2025-09-01 01:38:53'),
(363, 'ANGGUN RIANA PUTRI', '242510100', '$2y$12$VNQBywQs3FeTurjg69e8Dumz8Zltiqe4.1jRjNQtTpofZIDPs.c2W', 'siswa', '2025-09-01 01:38:53', '2025-09-01 01:38:53'),
(364, 'APRIZAL SUGANDA', '242510101', '$2y$12$i.qrRMREz0UD5xqhZNUu/esAiyW7JUMqk0XZlb70PqTmrzEGY96wa', 'siswa', '2025-09-01 01:38:53', '2025-09-01 01:38:53'),
(365, 'ARDIANSYAH', '242510102', '$2y$12$PvN0rLHqLa6RlUmSfyEFq.eNcPg6QltU0WWwaKYsY/id.YciAsxSq', 'siswa', '2025-09-01 01:38:53', '2025-09-01 01:38:53'),
(366, 'ARIF JUNAEDI ABDILAH', '242510103', '$2y$12$Uy8oS0Y8BTHOHF3MyNEES.Lu5r4mT7.XIvOcLHCaSWXlqIwA2hR6O', 'siswa', '2025-09-01 01:38:54', '2025-09-01 01:38:54'),
(367, 'ASIAH NURAZIZAH', '242510104', '$2y$12$S6MXI9KL0Lr4q5XyUrIGJOj4IYYS4CY4Y9hxpuYaDHe4rhKztyFGK', 'siswa', '2025-09-01 01:38:54', '2025-09-01 01:38:54'),
(368, 'DIMAS', '242510105', '$2y$12$4AroWNB3eL8Z76Eoto807ulQbhduDuq6OjXQByeCbBAeBCbAnF4C.', 'siswa', '2025-09-01 01:38:54', '2025-09-01 01:38:54'),
(369, 'DIO PRATAMA', '242510106', '$2y$12$W7aBDiWYSpCb.Gvaz24njuvaw6vLpNl.5.acJlV.LkSLPGJY8niIe', 'siswa', '2025-09-01 01:38:54', '2025-09-01 01:38:54'),
(370, 'FACHRI MUHAMAD SOFYAN', '242510107', '$2y$12$LJZsvq2KCeNX/bKS9KwEluf0doWa.sp9XY2b.L00Yl0A5PfCCVna2', 'siswa', '2025-09-01 01:38:55', '2025-09-01 01:38:55'),
(371, 'FAHRI HAMDANI', '242510108', '$2y$12$jjf7djf9pBhFR34vNjbWFOihTaGFX9FlJPEcraMhrgX3H0y8ew8T.', 'siswa', '2025-09-01 01:38:55', '2025-09-01 01:38:55'),
(372, 'FERRY SEM JULIANTO', '242510109', '$2y$12$Mip9SzDiCC/8Al2jyHWh/emw4eAzzM5bm3r2BEeWO2VbrI3akV5Xy', 'siswa', '2025-09-01 01:38:55', '2025-09-01 01:38:55'),
(373, 'GUNAWAN GUNTUR', '242510110', '$2y$12$qHB6/lDZj7Z2tAqASPBO9uRk/WpoeVaSLPw5zcPDULSCFXfOxHt2i', 'siswa', '2025-09-01 01:38:55', '2025-09-01 01:38:55'),
(374, 'IRMAWATI', '242510111', '$2y$12$XvoQHo5b7pXeHHrC7q6thOLYWQlbE8ty.m0Q05DVm47Pv65eDNAcu', 'siswa', '2025-09-01 01:38:56', '2025-09-01 01:38:56'),
(375, 'ISMAIL NURJAYA', '242510112', '$2y$12$HoI0JvJt27xCw/OrLfO1G.bJJkuZC0Rsc1OCiUpjl9p5qM7IDI0/y', 'siswa', '2025-09-01 01:38:56', '2025-09-01 01:38:56'),
(376, 'LUTPIAH', '242510113', '$2y$12$NhmPYBN/6/BOfm92B43eoe19A.7yyrmsSPL5Zj5L2DbMu7mtrEcZS', 'siswa', '2025-09-01 01:38:56', '2025-09-01 01:38:56'),
(377, 'MUHAMAD FAIS', '242510114', '$2y$12$rxv0X2MQzgzT10ec214Myu5DI6GlY99afD3Nwle7R3XWbJpgLaxHm', 'siswa', '2025-09-01 01:38:57', '2025-09-01 01:38:57'),
(378, 'MUHAMAD MUMIN', '242510115', '$2y$12$38WqrBV3tDGK9nE2BQPZqOv/F4kzMLOY00NaLVA88y5qbO1e3nGM2', 'siswa', '2025-09-01 01:38:57', '2025-09-01 01:38:57'),
(379, 'MUHAMAD NUSHA BADARI', '242510116', '$2y$12$f/l.3AfXlXbDfoP0oVzf.u7HRm7Q1MvpiZLxrlqakoOWIhptjdLnO', 'siswa', '2025-09-01 01:38:57', '2025-09-01 01:38:57'),
(380, 'MUHAMMAD PALESTIN', '242510117', '$2y$12$9/unjSyP7MVDTl9yaH7IE..xMq4nCWr/JW.jM4plecxHGUWbALONy', 'siswa', '2025-09-01 01:38:57', '2025-09-01 01:38:57'),
(381, 'MUHAMMAD RAFFI ALFARIS', '242510118', '$2y$12$LMTfiS76z1YyTZJ0jhsHQO.82TZU5ogDjDBcipl90kWR7BPxEqXD2', 'siswa', '2025-09-01 01:38:58', '2025-09-01 01:38:58'),
(382, 'MUHIDIN', '242510119', '$2y$12$S44FGEt.nAEbptVk.l5xiOrzcRx9aZR1sKmKl39cgGwyj0lzLRjLm', 'siswa', '2025-09-01 01:38:58', '2025-09-01 01:38:58'),
(383, 'NURHAYATI', '242510120', '$2y$12$kh48NpXh/9Nnhmu0uOven.SsN2sGUcBXhSHruT9im2YlA572W9CuK', 'siswa', '2025-09-01 01:38:58', '2025-09-01 01:38:58'),
(384, 'NURSIAH', '242510121', '$2y$12$0Pwmjx8/HkjcdGU2Ra6aDuKOyypYh67Q78DgCCxV/rvw8wf5yqrdO', 'siswa', '2025-09-01 01:38:58', '2025-09-01 01:38:58'),
(385, 'ROHMANA', '242510122', '$2y$12$nBlKh3/SLV9s3291pm/wyeLMeAYneEf92SpU8X9D9fvaURscHzcfW', 'siswa', '2025-09-01 01:38:59', '2025-09-01 01:38:59'),
(386, 'SYARIP NASRULLOH', '242510123', '$2y$12$oGSaG1SBq9zP6CSNoqeHkeWt2UO6YBLoRgcsS6KuykdiBLtzzs.my', 'siswa', '2025-09-01 01:38:59', '2025-09-01 01:38:59'),
(387, 'TAMAMI', '242510124', '$2y$12$myiq5b/N6nuqTZjhX4/Jz.INeLdXpA4Y4uvKmj1cPm95oqe/TIxH6', 'siswa', '2025-09-01 01:38:59', '2025-09-01 01:38:59'),
(388, 'ABDUL GANI', '242510125', '$2y$12$pYdsWnT3br1w7LhLX6bZeOpEe9bCLN.58Hb5bTd3BBCI.Ib1sM7xK', 'siswa', '2025-09-01 01:38:59', '2025-09-01 01:38:59'),
(389, 'AHMAD DANU', '242510126', '$2y$12$/5e8w/tRrDg/3L8IvOWwU.UhsC8W5z8ouivBox93f6.S9BYEKkBX.', 'siswa', '2025-09-01 01:39:00', '2025-09-01 01:39:00'),
(390, 'ALMASUL ANAM', '242510127', '$2y$12$uM3naPiAvXVs94yo15Kmo.dX03cWRpyHc.MpWSB9LrCz8/p9/l9ce', 'siswa', '2025-09-01 01:39:00', '2025-09-01 01:39:00'),
(391, 'APRIANSYAH KARIM', '242510128', '$2y$12$LwF5ruooEUOM6tt63/bbz.SfxZZxICILIsGgBWp2auTHADS2Wh75.', 'siswa', '2025-09-01 01:39:00', '2025-09-01 01:39:00'),
(392, 'APRIYANSYAH', '242510129', '$2y$12$nlzdBTrd4IocjGS41.86.Ou73dddESo6rjENreLHkZULcDWvVCmxG', 'siswa', '2025-09-01 01:39:01', '2025-09-01 01:39:01'),
(393, 'ARYO SAPUTRA', '242510130', '$2y$12$dr84h2ut206p5nLwImCCb.FFHJyXVXaGJ8BYYhvoHKXXvTzMX5.1G', 'siswa', '2025-09-01 01:39:01', '2025-09-01 01:39:01'),
(394, 'BELA CANTIKA', '242510131', '$2y$12$4pTlLwFyBiV5h1tpYZv42u5wccKi40MNztWVjZ7ERZoGpNRwuYed6', 'siswa', '2025-09-01 01:39:01', '2025-09-01 01:39:01'),
(395, 'CASTIMAN', '242510132', '$2y$12$m5KeWWowp2xdhOHB2NgSHuNRLiY626CVxDDOEYgakDiKXZZXVNAf2', 'siswa', '2025-09-01 01:39:01', '2025-09-01 01:39:01'),
(396, 'DAVI BAHTIAR', '242510133', '$2y$12$vYlUSIGHyuyu1SobZFzO2eZAiruY/brVgUfpD/v2xo18/S3ZbTKAe', 'siswa', '2025-09-01 01:39:02', '2025-09-01 01:39:02'),
(397, 'DELIMA', '242510134', '$2y$12$1Kx5FqZ9Q0cfcRMNMBPoauHFhCv58qr4XYbaOFhKUlE1dtKrx6A1K', 'siswa', '2025-09-01 01:39:02', '2025-09-01 01:39:02'),
(398, 'EKO ADI SUCIPTO', '242510135', '$2y$12$sB1H1tFFh8fDiqI7S2z6VOuK3wZCzHNDtf7JfHwmlxwptlmGOmw1W', 'siswa', '2025-09-01 01:39:02', '2025-09-01 01:39:02'),
(399, 'IBRAHIM SIDIK JAELANI', '242510136', '$2y$12$pW1kqd2h.EQNNHcLsSSQmeGeBLvcpI4gSe0cGbNe308oo6kvRS3NS', 'siswa', '2025-09-01 01:39:02', '2025-09-01 01:39:02'),
(400, 'ICANA', '242510137', '$2y$12$ReY0JJmkZjkJPYSNl3EoFewYg2ZxungSzRBRo5Z6RjZakVJb6vb6C', 'siswa', '2025-09-01 01:39:03', '2025-09-01 01:39:03'),
(401, 'IRPAN', '242510138', '$2y$12$U3WhyW5DmFCmvtz.mnAsk.sapeHONa9PaW4W/xvLRNPZVMZRUo05m', 'siswa', '2025-09-01 01:39:03', '2025-09-01 01:39:03'),
(402, 'KHAILA SABINA', '242510139', '$2y$12$gimOxPte0ApSLwnaDCJeVuxHLle/hdsZa4hQD/oTk28RfycrtPY7e', 'siswa', '2025-09-01 01:39:03', '2025-09-01 01:39:03'),
(403, 'MUHANAD ABDULHADI', '242510140', '$2y$12$wg/mxSFCwlRVTjHyHrXSNelIQ4EkJEK5FLZAmN/.QnsZlMYr4rJp2', 'siswa', '2025-09-01 01:39:03', '2025-09-01 01:39:03'),
(404, 'NURLELA APRIYANTI', '242510141', '$2y$12$dADaodkt/z.jBkzUWJ3ldul.6cejekHPYi9PsdEZ/INeK5LbM7A.i', 'siswa', '2025-09-01 01:39:04', '2025-09-01 01:39:04'),
(405, 'PARIDHAH', '242510142', '$2y$12$CIp2jQUFviOmuGf8vcNx4.PyelAnl9K32UZukRbCQ0kYG2tsjuxu2', 'siswa', '2025-09-01 01:39:04', '2025-09-01 01:39:04'),
(406, 'PASA NUR PADILAH', '242510143', '$2y$12$RGzKiuUsiyHyVCeF9RqnKuuHTGtC0sx/JMBCVd0LW4Tnw.4M5W0tC', 'siswa', '2025-09-01 01:39:04', '2025-09-01 01:39:04'),
(407, 'RAISYA ADITIA', '242510144', '$2y$12$j097L4V/6CHRFHsYanbsguuKs16K8opyNRX8Q/ljJRuEl6TFJIB/K', 'siswa', '2025-09-01 01:39:05', '2025-09-01 01:39:05'),
(408, 'RANATA', '242510145', '$2y$12$qaoUQlpd8TCLxnlW6fxDAuXtKuxeJfaret.ZWhUh0sOtZ4h4jtXJ2', 'siswa', '2025-09-01 01:39:05', '2025-09-01 01:39:05'),
(409, 'RAPI RIPANSYAH', '242510146', '$2y$12$6AJNglu.6iJRZuzowidCSeL53AgBLsFSffHfZFhkWu.7pkVA8G5UK', 'siswa', '2025-09-01 01:39:05', '2025-09-01 01:39:05'),
(410, 'RIPAT', '242510147', '$2y$12$5o6P/GjREEt4uzx8UG8/e.qdS9ydqEvNjz30tOPAYWScxrxpiCP8W', 'siswa', '2025-09-01 01:39:05', '2025-09-01 01:39:05'),
(411, 'RIZIQ ABDUL WAHID', '242510148', '$2y$12$zNE3TE5MiWW6SSSAyQNmE.AqKX1NbROn5qB0s5fJBzdDlJAUFyB6G', 'siswa', '2025-09-01 01:39:06', '2025-09-01 01:39:06'),
(412, 'SUCIKOH MAHARANI', '242510149', '$2y$12$VK07jwYNOVn/cQOs1SX3X.D8S.uGybOCL4fhp8SG4powR91QB8NKK', 'siswa', '2025-09-01 01:39:06', '2025-09-01 01:39:06'),
(413, 'SUKARDI', '242510150', '$2y$12$Z25MaXeZHFlnxSG/CrhTVuklNcAfBy0FHBkVI3SR8qEeeNFEUtAM6', 'siswa', '2025-09-01 01:39:06', '2025-09-01 01:39:06'),
(414, 'TIANI', '242510151', '$2y$12$yqpxE2w.c/6/lWdvehpqvux/fmYWxcLb2Aa8RE7QdoRXPGs6b6Vxa', 'siswa', '2025-09-01 01:39:06', '2025-09-01 01:39:06'),
(415, 'WAHAB TAJUDIN', '242510152', '$2y$12$IrTe3TsuUeNUh6UIuHSpQ.KKxLG.ENKHdOyvXZFw2wjLMzCOKjV8K', 'siswa', '2025-09-01 01:39:07', '2025-09-01 01:39:07'),
(416, 'AHMAD RIFKI RIFAI', '242510153', '$2y$12$1JPMol2kZCExqg5RWg7Edubfs6Q7hHt8TuNTo72RwxSzLmYjx2Bfi', 'siswa', '2025-09-01 01:39:07', '2025-09-01 01:39:07'),
(417, 'ALDO PRASETYO ADAM', '242510154', '$2y$12$DWrxKRQLbQ8S4ZBfCAdb1.QaH3Ou8yTo5yaSH7SMqFtW5ZoLNqQLu', 'siswa', '2025-09-01 01:39:07', '2025-09-01 01:39:07'),
(418, 'ARIS MUKTIA', '242510155', '$2y$12$wc.b.ziWw8oZfgfOZP5n0.tvNLjWOZ65d3fCN14rZNu/d617ftZke', 'siswa', '2025-09-01 01:39:07', '2025-09-01 01:39:07'),
(419, 'ARMAN RAMADHAN', '242510156', '$2y$12$hzHFfwU5XJisuLUxBiAWrOiYzHuLbzCjW1fPrILmkPGeKxlbtk6Ce', 'siswa', '2025-09-01 01:39:08', '2025-09-01 01:39:08'),
(420, 'DARMAWAN', '242510157', '$2y$12$hGP4gqWitsh/0fy7.DEejeeIYOcGIcpsWZTlCL2ON83FYjYB3bv4u', 'siswa', '2025-09-01 01:39:08', '2025-09-01 01:39:08'),
(421, 'DENI HARUN', '242510158', '$2y$12$kA.nS1pLJfFf7oPjNmoeL./dcBIPFS8A70NVPpbIYFbCOkfCi5eZ6', 'siswa', '2025-09-01 01:39:08', '2025-09-01 01:39:08'),
(422, 'DIMAS', '242510159', '$2y$12$o8L9ecS.h1ZOPvF6ylzupuD2TrjrqAs22Bz1NvtmLLzflB1eOhM3i', 'siswa', '2025-09-01 01:39:08', '2025-09-01 01:39:08'),
(423, 'FAISAL ABDUL AZIS', '242510160', '$2y$12$pcVKn08hEunImHqA7bA.nuNyqRGO4KIW95X63zeOYuQYwEAb3RpP2', 'siswa', '2025-09-01 01:39:09', '2025-09-01 01:39:09'),
(424, 'GALIH WARDANA', '242510161', '$2y$12$pxvwtU.7FnpcL2jut8SXgeDU5QhNLR6S.4oVo92aeRDDlyi5SDOuy', 'siswa', '2025-09-01 01:39:09', '2025-09-01 01:39:09'),
(425, 'GILANG PERMANA', '242510162', '$2y$12$z1oByLgPM.JGPpFQFksw0ufsAYiLDqTP2LgoYOhGsK8j7oG2w/aMe', 'siswa', '2025-09-01 01:39:09', '2025-09-01 01:39:09'),
(426, 'HOTIMAH', '242510163', '$2y$12$eqPFDpY2wpmv0TMkBaRreOuI7mRc0N18QL782bAFllXqO7wdYs8Y.', 'siswa', '2025-09-01 01:39:10', '2025-09-01 01:39:10'),
(427, 'ILYAS SUPANDI', '242510164', '$2y$12$Af.HKNy00RKljLqyX8Wl0.xhbvDt4ffOPsOMWwxoyC.ugXikhN1Su', 'siswa', '2025-09-01 01:39:10', '2025-09-01 01:39:10'),
(428, 'IRKI', '242510165', '$2y$12$mc4CcWRSjtxr8wDt3DV/3.2XqCwc/3Sy/F1eztmH4skhEbCvgWEsm', 'siswa', '2025-09-01 01:39:10', '2025-09-01 01:39:10'),
(429, 'IRWAN', '242510166', '$2y$12$7sC8bdbo0mrTyPbE1QWzbeUxuqUiVkHfm2vLpwKMBI6ueTPnAvvOi', 'siswa', '2025-09-01 01:39:10', '2025-09-01 01:39:10'),
(430, 'KARDIANSYAH', '242510167', '$2y$12$6DM1UkMmtHHIMa6/6VBA3uBikNIpn8Ll5hma/Vkjf7mYAmG.9tGMC', 'siswa', '2025-09-01 01:39:11', '2025-09-01 01:39:11'),
(431, 'MEYFHA AKILAH', '242510168', '$2y$12$um9HXyGLkpYlfSeEWg.Yuu8Ai/rVkqU0MqLWm7VSVuz01Kl0rOyeq', 'siswa', '2025-09-01 01:39:11', '2025-09-01 01:39:11'),
(432, 'MOHAMAD AKBAR', '242510169', '$2y$12$3YpnB3Vs/T/DGPP3s5hO9OrJwEAPtC/5Nxk0tMM4EKhRICuFwIrrW', 'siswa', '2025-09-01 01:39:11', '2025-09-01 01:39:11'),
(433, 'MUTIARA', '242510170', '$2y$12$ZbxciuWAXRxfrGApa08.Nez5GsaJXFJeech4DHo.ZpUFRWdI0Bvp2', 'siswa', '2025-09-01 01:39:11', '2025-09-01 01:39:11'),
(434, 'NANANG ALDIANSYAH', '242510171', '$2y$12$ovzo/QpmATWY6x5UI7HaruLn1qohcco7zNBSbRnMheOmUQDegyShW', 'siswa', '2025-09-01 01:39:12', '2025-09-01 01:39:12'),
(435, 'PAHRUDIN', '242510172', '$2y$12$w878BGbDKjxISQGE5RWzveBy/FIOzHXW1OYAL6kb.yFh2CTUbBmoS', 'siswa', '2025-09-01 01:39:12', '2025-09-01 01:39:12'),
(436, 'SAPRUDIN', '242510173', '$2y$12$/kVbMI3Yoqmj1CSHUwaeXuUnKjzbmV7ZnREQFm6EqQDVdlb/JBAXu', 'siswa', '2025-09-01 01:39:12', '2025-09-01 01:39:12'),
(437, 'SIFAH FAUZIAH', '242510174', '$2y$12$s851MoXYf2WBgXGWhfs74OGrzDyRfQS0XRmqCokUO0DHboan3W2p6', 'siswa', '2025-09-01 01:39:12', '2025-09-01 01:39:12'),
(438, 'TANIA LAURA', '242510175', '$2y$12$MDszvlixGtHFOV9q7kP7E.oI2RjnNPMorDBUIx4wXUQzK7.ghDAwK', 'siswa', '2025-09-01 01:39:13', '2025-09-01 01:39:13'),
(439, 'TEGAR ANANDA PRATAMA', '242510176', '$2y$12$WljNCHYWakZAzfCstXfioevlaGA1.SEEmEJSisvKoWcGaTuScJmsy', 'siswa', '2025-09-01 01:39:13', '2025-09-01 01:39:13'),
(440, 'WIRANATA', '242510177', '$2y$12$Rz7fo.7vAXeaey6////pyu24XZSfOVxyNcmvllhRxinzDMR3Y0hC.', 'siswa', '2025-09-01 01:39:13', '2025-09-01 01:39:13'),
(441, 'YUSUP HABIBI', '242510178', '$2y$12$ZaygWL4oNtJInXKxOMgN/u3p0KxSX.f9RtvM.mnbCsOwCFH9A6H1G', 'siswa', '2025-09-01 01:39:14', '2025-09-01 01:39:14'),
(442, 'AHMAD NURACA', '242510179', '$2y$12$X1dFteTs.vupo62MRueFAuTKU3JBJZLxuqytA8Y2insI/pbm51GD.', 'siswa', '2025-09-01 01:39:14', '2025-09-01 01:39:14'),
(443, 'ALVIAN NURFADILAH AGUSTIN', '242510180', '$2y$12$XF8NvhV09In2TXaFg//9hePM/7zbKjgUXWzF0BCkaYM7pGmALkIXu', 'siswa', '2025-09-01 01:39:14', '2025-09-01 01:39:14'),
(444, 'CARTIKA AYU', '242510181', '$2y$12$NbpN9ejWJvUPCdfuZkkMCOc8NEik3IxrkQBur.o2difdlJXShs9LO', 'siswa', '2025-09-01 01:39:14', '2025-09-01 01:39:14'),
(445, 'DIMAS', '242510182', '$2y$12$ehrWqTUM.IMbf97yHB4.RuIORHHczgsjpUqoL3iZDxcG66M3PJBnq', 'siswa', '2025-09-01 01:39:15', '2025-09-01 01:39:15'),
(446, 'DIRLY KUSUMAH', '242510183', '$2y$12$OGRWagcGDS2Auunwl3v/xOqDrPjsGfN3CaVE2eYGFDc.NJxS65rni', 'siswa', '2025-09-01 01:39:15', '2025-09-01 01:39:15'),
(447, 'FAISAL SETYO NUGROHO', '242510184', '$2y$12$uYVXUIrr2cGE1TQEl/N0Q.17C07g8x8RPAZQiS6SHBmn2azNhgsgy', 'siswa', '2025-09-01 01:39:15', '2025-09-01 01:39:15'),
(448, 'FARID RIZKY RAMDANI', '242510185', '$2y$12$UfAone5.U38Qh4JaeYJTm.IBmifk0ze0ZbonekRhZAwWTnevAqFJa', 'siswa', '2025-09-01 01:39:15', '2025-09-01 01:39:15'),
(449, 'IIN DWI DIKA', '242510186', '$2y$12$j0bVErEWc1tNtS3d/Lz7pO3LmyCAmemNqYvtx8PSo6sDHoLXDdKpO', 'siswa', '2025-09-01 01:39:16', '2025-09-01 01:39:16'),
(450, 'ILYAS EFENDI', '242510187', '$2y$12$WZkXZa8xBYrZVAliwTZaCOa7YBoxD5PK17wdHwgMr3Mojz0/t./lS', 'siswa', '2025-09-01 01:39:16', '2025-09-01 01:39:16'),
(451, 'IRWAN', '242510188', '$2y$12$xZjZoWnE0psnSbJYgeFqh.7b.akDwpTP6lQcfyFX/MC1O6l.EcDYW', 'siswa', '2025-09-01 01:39:16', '2025-09-01 01:39:16'),
(452, 'JAMAL MAULANA', '242510189', '$2y$12$DgP3mJ6FWPVjjivhHDAV6uckJTAwjP9g9VXw642HfMMeaW6sjrf/m', 'siswa', '2025-09-01 01:39:17', '2025-09-01 01:39:17'),
(453, 'LUTHFI YANSYAH', '242510190', '$2y$12$j9K7biR8.X4LA87m2pFmEu3MfI5gxEGjVw3lSup.YQ4H9XXL/AV36', 'siswa', '2025-09-01 01:39:17', '2025-09-01 01:39:17'),
(454, 'MUHAMAD ANDRE ALPHIANSYAH', '242510191', '$2y$12$pkpDqU.3gC7yKu5vFjuU5uAYyKPfAkurmQWY2MouPLlVr1ArZFY5e', 'siswa', '2025-09-01 01:39:17', '2025-09-01 01:39:17'),
(455, 'MUHAMAD BOBY FRAYUDA', '242510192', '$2y$12$aPW/zAML8.VuGtGCyfHv3.yM6/Sg4En.eHnw7vITDP1X9Blf9Ak/W', 'siswa', '2025-09-01 01:39:17', '2025-09-01 01:39:17'),
(456, 'MUHAMAD FAISAL', '242510193', '$2y$12$kox2LfTBTcajqBGpWOkEgelYh0TdWxulvJ6k1cKxnCjHszHc70s1W', 'siswa', '2025-09-01 01:39:18', '2025-09-01 01:39:18'),
(457, 'MUHAMAD RAIHAN', '242510194', '$2y$12$0Fa1gh9Z4bzfUy/OnwFEvOs3xX98XXxqpm3gxUMtBwmZb0eLTr9r.', 'siswa', '2025-09-01 01:39:18', '2025-09-01 01:39:18'),
(458, 'MUHAMAD RIKI ALFATUR RIZKI', '242510195', '$2y$12$90QxT5aF69uJXlFlK.x.Fecn/W9IgBpOTCw3AEpNveetHMnv7Nvqu', 'siswa', '2025-09-01 01:39:18', '2025-09-01 01:39:18'),
(459, 'MUHAMAD SAUD', '242510196', '$2y$12$HDkjEYReWIkYJ0P8eoNnoOYC05TVxesZXolIyXjfjXiEU6MY1bNBu', 'siswa', '2025-09-01 01:39:18', '2025-09-01 01:39:18'),
(460, 'MUHAMAD TIRTA RUKMANA', '242510197', '$2y$12$MGKeTRL/pG1hdxUkQYOa2eLkvwVlJv9u.IjO1UUj5TS4Ne4o0.l9G', 'siswa', '2025-09-01 01:39:19', '2025-09-01 01:39:19'),
(461, 'MUHAMMAD FARHAN MIFTAHUL ROJAK', '242510198', '$2y$12$iriuf3f7vmbjmMbJwrzv3.Dcgdm/9NJhTRXDvSpnxc3uY3Q/vHrMW', 'siswa', '2025-09-01 01:39:19', '2025-09-01 01:39:19'),
(462, 'MUHAMMAD HASAN BASRI', '242510199', '$2y$12$dHOmWX0SvuY23T2owiGzDOJ3cAAEr6yWuesGFlV/3vkwTXnooCH8C', 'siswa', '2025-09-01 01:39:19', '2025-09-01 01:39:19'),
(463, 'NAJRIL ILHAM', '242510200', '$2y$12$ivWxHLjszRIWhu3CxvY/BOAgxM.jhCEzl7CnGIlLtw1u8Utyziula', 'siswa', '2025-09-01 01:39:26', '2025-09-01 01:39:26'),
(464, 'NANANG KOSIM', '242510201', '$2y$12$l36Kcf/QMdN9gRTn84rwM.kv/EtMzQCtupxdRNEtMkhMI94s8fIlm', 'siswa', '2025-09-01 01:39:26', '2025-09-01 01:39:26'),
(465, 'RIPA HAMDANI', '242510202', '$2y$12$XUJG4mLMUYP8g3MhuIpGu.gm4Y6KVG0x2ofGKANKPE6t3is5ygesa', 'siswa', '2025-09-01 01:39:27', '2025-09-01 01:39:27'),
(466, 'RIZKI AHMAD HAMBALI', '242510203', '$2y$12$jyhqBJ7K31q9T/JrlcAGyO02gGSn46QjqZZB4CHH5EjjO7dUV4XMm', 'siswa', '2025-09-01 01:39:27', '2025-09-01 01:39:27'),
(467, 'SAEPUDIN', '242510204', '$2y$12$cQETrpHQlIMB.ra2KKVUjeCg2bWNJGh9zgSRiG3xOdR9pmoRQSYVG', 'siswa', '2025-09-01 01:39:27', '2025-09-01 01:39:27'),
(468, 'SAKTI GENTA AIRLANGGA', '242510205', '$2y$12$lXQGpIHNKcux4GSaDI1svuNJgFmYEb6j2ch.bUz5ZqTqyMzyMvq0i', 'siswa', '2025-09-01 01:39:28', '2025-09-01 01:39:28'),
(469, 'SASKIA MURNI ATI JUANDI', '242510206', '$2y$12$rZ/OOO8OC.HSOqGgF4UM0ODnDA7RsPUNUqbF.aPlkv/YWkQsmB9RS', 'siswa', '2025-09-01 01:39:28', '2025-09-01 01:39:28'),
(470, 'SITI HALIMAH SADIYAH', '242510207', '$2y$12$xTfJpHwEcprmIxXgshsLfuCT5LpOn4EhCRPOGeU.8GKsQRU0jC7dG', 'siswa', '2025-09-01 01:39:28', '2025-09-01 01:39:28'),
(471, 'SODIK RIFAI', '242510208', '$2y$12$2oVC1aWe/VjZYid8cj5R6.Qd4l1a2R5iU36Ca7U1DoBYSBK9T5mmi', 'siswa', '2025-09-01 01:39:28', '2025-09-01 01:39:28'),
(472, 'WIDIA RAHMA SARI', '242510209', '$2y$12$kmGFZdDWY3lsRHlfEbNLWuG0xTBMZt.zeXMf2WSNVmpAYLRIT4sVq', 'siswa', '2025-09-01 01:39:29', '2025-09-01 01:39:29'),
(473, 'WILDATUL RAHMATUL UMMAH', '242510210', '$2y$12$jMnPblbRnm3dOYNi9XRb1.ZHemWLe8w5M9g9mqIA08tbUOssdel.e', 'siswa', '2025-09-01 01:39:29', '2025-09-01 01:39:29'),
(474, 'AGNA FATHURROHMAN', '242510211', '$2y$12$sROWFXfgYQi9T7eyJZ362O7VhgNWk.9JXyibz.q2h4kH78oApdv4y', 'siswa', '2025-09-01 01:39:29', '2025-09-01 01:39:29'),
(475, 'ALI AHMAD DINEZAD', '242510212', '$2y$12$MT.dV1GjLlMqaE8.dyh1L.psfsacmnXc2Mcopnlm8r2ibpdlDr/Sy', 'siswa', '2025-09-01 01:39:30', '2025-09-01 01:39:30'),
(476, 'ALNAZRIL ANASSYAH', '242510213', '$2y$12$MUSKmdkoCjL1oFAhGuYFb.EeF3IYiQlStj8PLBA3qeq/Nd0AB5ri6', 'siswa', '2025-09-01 01:39:30', '2025-09-01 01:39:30'),
(477, 'ANGGA', '242510214', '$2y$12$7wHpbOApHzFH344OhMTUFusNWxfHp8cH2NO0TOGb./rAW/LIgiSZy', 'siswa', '2025-09-01 01:39:30', '2025-09-01 01:39:30'),
(478, 'DERI SAEPUDIN', '242510215', '$2y$12$wvEBBRWs9wtFLqdPD0OCzuwjBInCTj1OINNLqCNGcKNqA7/nVbb0a', 'siswa', '2025-09-01 01:39:30', '2025-09-01 01:39:30'),
(479, 'DIKI PURNAMA', '242510216', '$2y$12$NPXrVTuLwFF0b1jGeHJmW.U4XhDJqJ0NleY5r1PzEkQsjl2KCwpTG', 'siswa', '2025-09-01 01:39:31', '2025-09-01 01:39:31'),
(480, 'FAUZI RIDWAN', '242510217', '$2y$12$UGeDdRMnD2UPu231Df5F/Ot6LyUek9znRzCFQJ6OOhBAE05.cwlAu', 'siswa', '2025-09-01 01:39:31', '2025-09-01 01:39:31'),
(481, 'GILANG ANGGA KUSUMAH', '242510218', '$2y$12$QpM40c2R0A7hSuO522tI6ufvoID5Z8s9JtBYH2nSkYcx3n5M5IDai', 'siswa', '2025-09-01 01:39:31', '2025-09-01 01:39:31'),
(482, 'IMARRUL UMMARA', '242510219', '$2y$12$ypGa7v6SOoniRJjKaWzfHevjcMLOINguKcyObEggybd7gUenRq.Ba', 'siswa', '2025-09-01 01:39:32', '2025-09-01 01:39:32'),
(483, 'KARTOBI', '242510220', '$2y$12$kTFUiuVkGmJrK.29XLnDuODP/ZA0go2tktzY1a5LloZJKBOM4Tk5a', 'siswa', '2025-09-01 01:39:32', '2025-09-01 01:39:32'),
(484, 'MALIK IBRAHIM', '242510221', '$2y$12$z1OFDpvEseIB6Gszr.7pc.HQ5NCHcqZgRsdylwIE4KQ4j.JsP8xrK', 'siswa', '2025-09-01 01:39:32', '2025-09-01 01:39:32'),
(485, 'MARSELA', '242510222', '$2y$12$/Qo81NCMsoBhrxszjjhjl.tml2yzpclwEkfaknFoKY0kIz.oACWIi', 'siswa', '2025-09-01 01:39:32', '2025-09-01 01:39:32'),
(486, 'MUHAMAD FARIS DZULFIKAR', '242510223', '$2y$12$RxvmYYY9cB8aGPOCHEMiSOkelJrot8h1xh89sA5KZn08LRDDmWk2O', 'siswa', '2025-09-01 01:39:33', '2025-09-01 01:39:33'),
(487, 'MUHAMAD REHAN BAROKAH', '242510224', '$2y$12$QyTcVZaAVPtjtMyi.t.cUO0Dl1hKSVVlkIWZKvTkN4U1kcAENgsGW', 'siswa', '2025-09-01 01:39:33', '2025-09-01 01:39:33'),
(488, 'MUHAMMAD RAIHAN FEBRIAN', '242510225', '$2y$12$1fmUnYuPnXqnwWIz/Zh0YuFmfPeCiXDJn0LvYgX0uijrJ7jyEGtIS', 'siswa', '2025-09-01 01:39:33', '2025-09-01 01:39:33'),
(489, 'RADIT RAMDANI', '242510226', '$2y$12$ptucB4bvxpPb0Sq.XbsfLOz45jHAMgkNw0hh3fkt6NmfFg6LRypfe', 'siswa', '2025-09-01 01:39:33', '2025-09-01 01:39:33'),
(490, 'RAMDANI', '242510227', '$2y$12$68It4VhyhZAW/4Rd8yA0v.iI4Tumg/QggUitgRQLOYiyKQ5cnjY5C', 'siswa', '2025-09-01 01:39:34', '2025-09-01 01:39:34'),
(491, 'REHAN MAULANA RIZKY', '242510228', '$2y$12$KcsTilOMxSNRJo//M/i54.kiFRLZsTEz9KvZpJ8TovpmSJ.8lBige', 'siswa', '2025-09-01 01:39:34', '2025-09-01 01:39:34'),
(492, 'RENO APRIAN', '242510229', '$2y$12$I79a/pDrAGpLocmdPAey0u3sE.taHwxu5kkWgaTAHcghlbOikEPxW', 'siswa', '2025-09-01 01:39:34', '2025-09-01 01:39:34'),
(493, 'REYSSA PRIYUNITHA IVANA', '242510230', '$2y$12$YKCGE9fYUZT0R.SCUTwOQ.pXKXSg7BhsHAOOEMOnuB/8fS9TguUVy', 'siswa', '2025-09-01 01:39:35', '2025-09-01 01:39:35'),
(494, 'RIZKI', '242510231', '$2y$12$.D2i3aIpjUrtmViwtwwgE.dM/Ij.3tH8fThYque.ThI2eTWBhdnvC', 'siswa', '2025-09-01 01:39:35', '2025-09-01 01:39:35'),
(495, 'SRI ANGGRAENI PEBRIANTI', '242510232', '$2y$12$2.8Z45Cc2uzlllno.RfSTu8/xNZUcebpVGhUyprhYel3xC7B9KWmS', 'siswa', '2025-09-01 01:39:35', '2025-09-01 01:39:35'),
(496, 'TASYA', '242510233', '$2y$12$wQFGcV3lY1kSCh/oioQKpOwG1cB2ZNn6HagduyyQhZel13zD5OCbi', 'siswa', '2025-09-01 01:39:35', '2025-09-01 01:39:35'),
(497, 'TAUFIQ HIDAYATULAH', '242510234', '$2y$12$hE2xUzGKoHVAggojsDH.2OCE8TxSSLkZka/V6RAB6HS4XziSdSceK', 'siswa', '2025-09-01 01:39:36', '2025-09-01 01:39:36'),
(498, 'TRISTANTO', '242510235', '$2y$12$Ij.P7DXBXHgRSSghz3PQ8.Z4nYPZ6CAiUoKf2tv2tXc09Ga87WDO.', 'siswa', '2025-09-01 01:39:36', '2025-09-01 01:39:36'),
(499, 'WHILDAN SYAHRIZAL WAHYUDI', '242510236', '$2y$12$HvJPps4LXcPOXnX33VM6kOOTEWr/eHDfC060jha6rp7kKOF7/1mKa', 'siswa', '2025-09-01 01:39:36', '2025-09-01 01:39:36'),
(500, 'ABDUL AZIS', '242510237', '$2y$12$Uo89Ox/aICRKfsMKO1U4SuMpPki8zTzJgt1V6sxmfCwksrJUvABke', 'siswa', '2025-09-01 01:39:36', '2025-09-01 01:39:36'),
(501, 'ABDUL RAHMAN WAHYUDIN', '242510238', '$2y$12$ecHtOMj/ZosY2dPUSP7TiuOpaRORg29tk9SqNkZED/Og1cVGWfA2e', 'siswa', '2025-09-01 01:39:37', '2025-09-01 01:39:37'),
(502, 'AHMAD FANANI', '242510239', '$2y$12$lNcgd2VgIcSTLBX0v8nHJ.0RDesNp0RVidmGQ5F2UN.jRIjgIZ6EW', 'siswa', '2025-09-01 01:39:37', '2025-09-01 01:39:37'),
(503, 'ALFA NURHIKMAH', '242510240', '$2y$12$yGDBZ1kM8euLY19CoGi4jO26Kf2kLa3d9xqmuGK9EEl.8Fpi.lzxa', 'siswa', '2025-09-01 01:39:37', '2025-09-01 01:39:37'),
(504, 'ANDRA PURNAMA', '242510241', '$2y$12$GI5XzM11kWdgXM3d3pKIiOmb5P3RQ.yjFw4zOXrdOK7RLPskGK2GW', 'siswa', '2025-09-01 01:39:37', '2025-09-01 01:39:37'),
(505, 'ARINO ARDAN ARUBETH', '242510242', '$2y$12$oVVyK9A6A.QIIOdhOO41he6Fx2CYnpKbUo8gW/vB9kL20Uch.GLuy', 'siswa', '2025-09-01 01:39:38', '2025-09-01 01:39:38'),
(506, 'CARSIYAH', '242510243', '$2y$12$E4eCdGYMtVQm6GN4woYBP.tSFKxz82w/orLT8Jwc5Zivo3pHaAutW', 'siswa', '2025-09-01 01:39:38', '2025-09-01 01:39:38'),
(507, 'CHICI NURSELA', '242510244', '$2y$12$r.5j4K.rghcLOfjMzc7iy.9TPljdmdeRel17xD2u9j/UIASDSA44u', 'siswa', '2025-09-01 01:39:38', '2025-09-01 01:39:38'),
(508, 'DALAL IRWANSYAH', '242510245', '$2y$12$G7nHq2I5RlIfT4K/0L13DuKGYXJLlZe..D7Bklo51I3uYlr6wPRzC', 'siswa', '2025-09-01 01:39:38', '2025-09-01 01:39:38'),
(509, 'DODO WIJAYA', '242510246', '$2y$12$yZOnSgPik5IwWLgLJcZ0eu/DIVDk16eXnm2iOr/4ALsZBumU1vJNi', 'siswa', '2025-09-01 01:39:39', '2025-09-01 01:39:39'),
(510, 'ELI HAYATI', '242510247', '$2y$12$s5ok6bW0.qLwocLeNHZlsedXe63f0.tzE2QEeZjVFWta9N.dVQ/im', 'siswa', '2025-09-01 01:39:39', '2025-09-01 01:39:39'),
(511, 'INDRA', '242510248', '$2y$12$P8HybxhqErePEpfDjsptMekP22/DxdO7FX40VbsaOdsp8vgBvrQqa', 'siswa', '2025-09-01 01:39:39', '2025-09-01 01:39:39'),
(512, 'LAILA SAFITRI', '242510249', '$2y$12$OvPTa3XVNMxYa7/CUhGFiOxTtxv0xUzY99sc4RUKLLVtRG8vmnEfq', 'siswa', '2025-09-01 01:39:40', '2025-09-01 01:39:40'),
(513, 'MAESAROH', '242510250', '$2y$12$d75fG.8v.cOA44FNXKG9O.8K.gfhxe0XeVAErHKIHH5jfTDCmZx1u', 'siswa', '2025-09-01 01:39:40', '2025-09-01 01:39:40'),
(514, 'MUHAMAD RASYA RAMADHAN', '242510251', '$2y$12$AFkkKSnRcTxAU2LDx0ZwcOJtZ3MZC8IT8VfvtOPKzJSp.i4I6ySYK', 'siswa', '2025-09-01 01:39:40', '2025-09-01 01:39:40'),
(515, 'MUHAMAD WAKAB', '242510252', '$2y$12$5EXG5Oz8qI8zq9mB4Wp3BezWKdaE7kIPJQ/KKamS/PO.9FCZgR.oK', 'siswa', '2025-09-01 01:39:40', '2025-09-01 01:39:40'),
(516, 'MUHAMAD WAKUB', '242510253', '$2y$12$Mrp.OrXycByuGfS7dZncPOs2KSe2iFlr5nRNI9sdrTLuYjRrjZjBC', 'siswa', '2025-09-01 01:39:41', '2025-09-01 01:39:41'),
(517, 'MUHAMMAD RIDO RIDWANULAH', '242510254', '$2y$12$hWsgGBdx45m/sGVNgDSnquZDi64wXnUFMBtEZLhLOUJyd7d2j0JKC', 'siswa', '2025-09-01 01:39:41', '2025-09-01 01:39:41'),
(518, 'NAJRIL ILHAM', '242510255', '$2y$12$Cb1A0DeiV6G3jO8s1rIOSOx2cbn2L0vUBAQDPoag1EUe9aTkmuvvW', 'siswa', '2025-09-01 01:39:41', '2025-09-01 01:39:41'),
(519, 'NIA RAMADHANI', '242510256', '$2y$12$GqwJ3CPEfqwOKTnyeRCDo.uLmYUjJNvUp9tlv9IGQxAwW.8js5pl6', 'siswa', '2025-09-01 01:39:41', '2025-09-01 01:39:41'),
(520, 'RANGGA ARDIAN', '242510257', '$2y$12$6xZVjrQzrXsA7p/011555uqMUJgBmnYmkLWdkkwn3LDpcXQrwguT.', 'siswa', '2025-09-01 01:39:42', '2025-09-01 01:39:42'),
(521, 'RIZKI MAULANA', '242510258', '$2y$12$Y6oejUe4ItSwVVh8aY1GgOYGJJ0WZDRKiMOOqymyYvChVVGp9cz8q', 'siswa', '2025-09-01 01:39:42', '2025-09-01 01:39:42'),
(522, 'SOPIAN GUNAWAN', '242510259', '$2y$12$uKnwVnZkWhVodioLmFMBEuKs9ojhLkkCf1dzyl1X5l3DgdqC1c4ba', 'siswa', '2025-09-01 01:39:42', '2025-09-01 01:39:42'),
(523, 'SUPRIYATNA RAMADAN PRASTIYO', '242510260', '$2y$12$7HuD2aRgvwefqtcRtfhvne7g7z/de4utwPTeOlBxxl8XM4leR9U5.', 'siswa', '2025-09-01 01:39:42', '2025-09-01 01:39:42'),
(524, 'VICRY APRIANSYAH', '242510261', '$2y$12$hKIH55m/Pr9EbjZNPCNZG.h/o.eY5v7sjWFwvOYyxdFyAe0bsBMvm', 'siswa', '2025-09-01 01:39:43', '2025-09-01 01:39:43'),
(525, 'WANA MAULANA', '242510262', '$2y$12$oHdfAT0zoRINMxZgVwt1cuh1k2EyAiGSp9imtvbhl9T0xYCARhlMC', 'siswa', '2025-09-01 01:39:43', '2025-09-01 01:39:43'),
(526, 'WIRA ATMAJA', '242510263', '$2y$12$ftHCUKk/NLPuj99v9QpthuQSwQexdZ1OoIEOddY/1W8jiA53nWe4C', 'siswa', '2025-09-01 01:39:43', '2025-09-01 01:39:43'),
(527, 'YUDA PRATAMA', '242510264', '$2y$12$5/FVhc35PE9HUC1jRQE.c.DEGpt20DBNteaorsQtO/7RimTo9TnuS', 'siswa', '2025-09-01 01:39:44', '2025-09-01 01:39:44'),
(528, 'AISAH', '232410001', '$2y$12$DzvLd6I5gUXH0lhGUZMH9.EZCt0u9CQTgzRJ5OhslC0zYeEL2i74a', 'siswa', '2025-09-01 01:40:03', '2025-09-01 01:40:03'),
(529, 'AISAH FITRIYAH', '232410002', '$2y$12$kJroxlDG2Q6w.fBNuD6rrOJs1NXTLAr9ebFzAnNUqctENL9A/mEym', 'siswa', '2025-09-01 01:40:03', '2025-09-01 01:40:03'),
(530, 'ALDI REPALDI', '232410003', '$2y$12$yIY0KQoGOnJwjrGqxMPaYO947Uet4RfWeE7FNECl1mHrXB4qCe.rS', 'siswa', '2025-09-01 01:40:03', '2025-09-01 01:40:03'),
(531, 'ANISA TRI WAHYUNI', '232410004', '$2y$12$uGEb6M9sGNRpMrfHM48uo.Y/OCP8Sz1zYZD1E50pSLYr5cbqNi4Xm', 'siswa', '2025-09-01 01:40:03', '2025-09-01 01:40:03'),
(532, 'AYU ARISKA', '232410005', '$2y$12$ntQgCElwvVLf7CGE5TAF6.O1bQXYSMA3igdq7OREKj6Icz.Y96bkO', 'siswa', '2025-09-01 01:40:04', '2025-09-01 01:40:04'),
(533, 'DEA AULIYA', '232410006', '$2y$12$kpVGuVxuZxNPMCsjnQ8uKuf.6xBSC0yrgNpVloE1zGRyXijf.vgja', 'siswa', '2025-09-01 01:40:04', '2025-09-01 01:40:04'),
(534, 'Dedeh', '232410007', '$2y$12$3o2hIXi969XsVwd3c8NTDunaHZMYkht/YwassQNt3IHzqFYM6cjy2', 'siswa', '2025-09-01 01:40:04', '2025-09-01 01:40:04'),
(535, 'Entin Julyani', '232410008', '$2y$12$p5yvWsWeAI37na63yv3.j.qRlnzjX1TD2eLKDZqUHT/VdEPvDN/Vm', 'siswa', '2025-09-01 01:40:04', '2025-09-01 01:40:04'),
(536, 'HALISA HUMAIRA', '232410009', '$2y$12$2ONpiVrgplx0LKfobxqwZ.zTvVloHrOjdnj4CDl/qYe9a/hedT4Um', 'siswa', '2025-09-01 01:40:05', '2025-09-01 01:40:05'),
(537, 'HANIPAH PAUJIAH', '232410010', '$2y$12$2lH5lMxKcwIIwmcpQVeAx.SJEPjsr0kRWlC36kIcSCNTiHfTTOoHa', 'siswa', '2025-09-01 01:40:05', '2025-09-01 01:40:05'),
(538, 'HASBY MAHEZA', '232410011', '$2y$12$4Q1q0BaM1B.wxyxzlB74vO8hXKPR8/5wGPgzHQuaISRBSpO7uw4ua', 'siswa', '2025-09-01 01:40:05', '2025-09-01 01:40:05'),
(539, 'INTAN AOLIA', '232410012', '$2y$12$taM.goTPYs1TmCWs8uUJq.lMy2Uw6aSvA0P5wJeADagFMoPuQ1F4a', 'siswa', '2025-09-01 01:40:05', '2025-09-01 01:40:05'),
(540, 'INTAN NURAINI', '232410013', '$2y$12$e7PUuLONKNx4TE1WrU9QceItm3zlBae031fDSHJWm.u.tqxqz/IzK', 'siswa', '2025-09-01 01:40:06', '2025-09-01 01:40:06'),
(541, 'IRMA SULISTIA', '232410014', '$2y$12$9gM2IA98bDVKBxxYef6/7eVUYMqeisZd02F3.Y0f2XRYXrX7vYfn.', 'siswa', '2025-09-01 01:40:06', '2025-09-01 01:40:06'),
(542, 'JAHRATUSSYITA', '232410015', '$2y$12$oCzxCC4ihF7qzu9bWNVCRe8/sR87s6b.0WFO1uV5X5..nmf9Yb8S.', 'siswa', '2025-09-01 01:40:06', '2025-09-01 01:40:06'),
(543, 'JIHAN', '232410016', '$2y$12$W3aqJ9J1QCHohC3SjbfIuu2/Z0AgrS0mqOOUZn/w.Olrn/bHs2K.S', 'siswa', '2025-09-01 01:40:07', '2025-09-01 01:40:07'),
(544, 'KURNIA FEBRIANTI', '232410017', '$2y$12$vnIwqlOrH08waMh/b7z4OuqYM1vlEzo/WzVwiBHHuAl44lw14RbPO', 'siswa', '2025-09-01 01:40:07', '2025-09-01 01:40:07'),
(545, 'LALA PADILAH', '232410018', '$2y$12$R8iys3UVcfOIf1rGKarIROHwhOWvgi1PuDbOjJ0Hm5HmfxMkUsOsK', 'siswa', '2025-09-01 01:40:07', '2025-09-01 01:40:07'),
(546, 'NOVITASARI', '232410019', '$2y$12$Zvq4a42e671gqQfcq6HF8OHRDHvTyXV8K68JPmH1DNJjpmtuR9l8.', 'siswa', '2025-09-01 01:40:07', '2025-09-01 01:40:07'),
(547, 'NURLELAH', '232410020', '$2y$12$q.ure.S/YcM6GUTNsdZxieCoiQftqD0lcZY/OLIIOsevD09g0sbei', 'siswa', '2025-09-01 01:40:08', '2025-09-01 01:40:08'),
(548, 'NURUL FARHAH', '232410021', '$2y$12$lo2TOa1TU3DSi7KRcUYNv.Bc2RhAbWsArxbOQ/cGg9CUd0e5.CAcm', 'siswa', '2025-09-01 01:40:08', '2025-09-01 01:40:08'),
(549, 'RAHMA AULIA AGUSTIN', '232410022', '$2y$12$3hsYiwch3Zml/LWG7yR3l.4UaLZBKitvAeMF40N2XPNhitJ7WtWWG', 'siswa', '2025-09-01 01:40:08', '2025-09-01 01:40:08'),
(550, 'RIYAN', '232410023', '$2y$12$gnm57exS/m3h36qtI5YhjuaVFU//r.Nfq1g35Sed/zeXazKCQD0Km', 'siswa', '2025-09-01 01:40:08', '2025-09-01 01:40:08'),
(551, 'SINDI ARISKA', '232410024', '$2y$12$qFjz5M.UCqd8dzgVa70wZeuSD7Mm/.QsNrtO2qi79Mb7qDavAcdtq', 'siswa', '2025-09-01 01:40:09', '2025-09-01 01:40:09'),
(552, 'SITI NURAENI', '232410025', '$2y$12$bWjIwQLE9odt6PlRK4hF.ef5Qd2BBYJaWmEsJ2cvIvcVXCdfGR9la', 'siswa', '2025-09-01 01:40:09', '2025-09-01 01:40:09'),
(553, 'TRI NOVITA SARI', '232410026', '$2y$12$NwVz2.iulMNGpcC5L/jV/OEskTJ2wWdNKzJp0kI64mx3H4q0lsWHu', 'siswa', '2025-09-01 01:40:09', '2025-09-01 01:40:09'),
(554, 'ALVIANI', '232410027', '$2y$12$kt62S2HHPd/F3x1kH6aN6uA8VPCbiKsp5nYSvmo32Sz8ukldBl.wO', 'siswa', '2025-09-01 01:40:09', '2025-09-01 01:40:09'),
(555, 'DECA LESMANASARI', '232410028', '$2y$12$G7bCQJCcW9nEVL0q5N2Dxey3to1mlX2rZeuE7ai1EyYiLlKorxJhO', 'siswa', '2025-09-01 01:40:10', '2025-09-01 01:40:10'),
(556, 'GINA HERAWATI', '232410029', '$2y$12$VQ6jnNPVmUU.3GyNxrXohuQIaTZh3QtSofK2oJH3hq3uS3eQQUEx2', 'siswa', '2025-09-01 01:40:10', '2025-09-01 01:40:10'),
(557, 'INDI LESTARI', '232410030', '$2y$12$h6wJ6lq2EOf61N8izmlcSe7pKn7Kf5kcXnlwxFTkR.um8oPH4TI0y', 'siswa', '2025-09-01 01:40:10', '2025-09-01 01:40:10'),
(558, 'JENY SAFIRA', '232410031', '$2y$12$NvtVMIPtV3WbyXnka9nebutIXT5t/X7ahbeYdjBnTNZ7EVbLHxeqq', 'siswa', '2025-09-01 01:40:10', '2025-09-01 01:40:10'),
(559, 'KHILDA SYAFA`AH', '232410032', '$2y$12$mJwcpJ6/MMBTFx0KU9YcHeUDxOdIjZlJ34P90qB19WeAAuC9nI2mC', 'siswa', '2025-09-01 01:40:11', '2025-09-01 01:40:11'),
(560, 'LAELA', '232410033', '$2y$12$pVnlt5REqp8/HbGbx1fkDu6e6Tw6cbq4vszEzt3piRE9WLExWtIcm', 'siswa', '2025-09-01 01:40:11', '2025-09-01 01:40:11'),
(561, 'NAILA ADZKYA MAULA', '232410034', '$2y$12$0zmeYFS16iAsXE1WKLFIGu4V61eQrKcQnZob6i8gr8uhN99VNvm5S', 'siswa', '2025-09-01 01:40:11', '2025-09-01 01:40:11'),
(562, 'NAJWA', '232410035', '$2y$12$wfKYGFx7PK6kBXXGFt2PKuoCmL5UGq4/r6MUO5P6DfFJ13LfGg65O', 'siswa', '2025-09-01 01:40:12', '2025-09-01 01:40:12'),
(563, 'NARSIH', '232410036', '$2y$12$VOrwYrgKuavvdWX.RmegquEnKMb7xPzAlMTbT2KLr7MWDPcUU0QRu', 'siswa', '2025-09-01 01:40:12', '2025-09-01 01:40:12'),
(564, 'NIKEN RIZKIA NINTIAS', '232410037', '$2y$12$wYyMHc/CUrwBN4lVGGeYqu0P.SDnfgAFKjYk1NuguRobss5pHl02K', 'siswa', '2025-09-01 01:40:12', '2025-09-01 01:40:12'),
(565, 'PUTRI JULIANTI LESTARI', '232410038', '$2y$12$qwuPzCTDeinadOwyiZWPeOyqvHcgnV2.Al3lQaY2pON7dFQLfYXnS', 'siswa', '2025-09-01 01:40:12', '2025-09-01 01:40:12'),
(566, 'RAHMAWATI', '232410039', '$2y$12$oTGbOog0MJsmN4Gqh522jeUUKdPmswKHTgeaiOr/c6avb33hXwl2a', 'siswa', '2025-09-01 01:40:13', '2025-09-01 01:40:13'),
(567, 'RATNA DEWI WULAN SARI', '232410040', '$2y$12$r.Zmdfgek06kkufYZ49DHeKuaLlIxWmMCytqiIYdd.aobCcbvCHD2', 'siswa', '2025-09-01 01:40:13', '2025-09-01 01:40:13'),
(568, 'REFFA AMELIA', '232410041', '$2y$12$CFLtYHkl8leJR.QTUqTQlOqIuocEpM.hBChhTNxZPbljh9Prq7F2K', 'siswa', '2025-09-01 01:40:13', '2025-09-01 01:40:13'),
(569, 'SAWI', '232410042', '$2y$12$e/n9S3IyMO0IPeqtt79I4.qrQF8Qi6AvIFcPD3r1RK6uQqj7KivHe', 'siswa', '2025-09-01 01:40:13', '2025-09-01 01:40:13'),
(570, 'SEPTIANI', '232410043', '$2y$12$REqdXsFvKPZvOQCidX.kdO7p9yP7gqAy/gK4n6pgD8ENe.7NTizjO', 'siswa', '2025-09-01 01:40:14', '2025-09-01 01:40:14'),
(571, 'SITI HILDA MAESAROH', '232410044', '$2y$12$uotoPeGpknP1qUlSVPoDaeWK/TXfOf6YUFzDoP/dtJX2XpB8Kl/oe', 'siswa', '2025-09-01 01:40:14', '2025-09-01 01:40:14'),
(572, 'SITI SOVIYAH', '232410045', '$2y$12$qxswPGN3iXKZdURpIbJRv.2qgp.VqyJvgLB4LReACN3HSveVvw5Ua', 'siswa', '2025-09-01 01:40:14', '2025-09-01 01:40:14'),
(573, 'SITRA ADILA', '232410046', '$2y$12$vNPc17eqBdeVoBTEcMBr/ug6ImpHC9gq/vCG6YVtOm84DuWOqbDa6', 'siswa', '2025-09-01 01:40:14', '2025-09-01 01:40:14'),
(574, 'SRI NURHAYATI', '232410047', '$2y$12$N6Un5uVaX.6QloqngPJOfOvCdAjbsoJZT1jfk5LHn2U42v2sWrrAa', 'siswa', '2025-09-01 01:40:15', '2025-09-01 01:40:15'),
(575, 'WARI', '232410048', '$2y$12$dXjHgMcfjyR/veysqYDo8OxueoaCpj5gutctLXQMNTbPne4iFjPLW', 'siswa', '2025-09-01 01:40:15', '2025-09-01 01:40:15'),
(576, 'WULAN NURUL ARIFAH', '232410049', '$2y$12$l.YhUJYWFpi8BLo.cp49jezd/9Yga48XySQ.fW2jjCl7xfu7WvN3O', 'siswa', '2025-09-01 01:40:15', '2025-09-01 01:40:15'),
(577, 'YUSTIKA DEWI', '232410050', '$2y$12$FdlIEG2TD9.4RQf6uf2pO.fAweoPjSUMcXa04taWIq4KlwBi0v1pq', 'siswa', '2025-09-01 01:40:16', '2025-09-01 01:40:16'),
(578, 'ZAHRA NURI SURYA', '232410051', '$2y$12$sPTyJ.jiBSdEQB5RHUmzu.giAlYWE6UTDlwlbWzfwo3eI5fhYrEiG', 'siswa', '2025-09-01 01:40:16', '2025-09-01 01:40:16'),
(579, 'ADAM PRIAMUGA', '232410052', '$2y$12$wbBg8mdIPH89SrPKXpVHfeb9E9T2TO3SBjIVY5YSM6OTDWakdcpn2', 'siswa', '2025-09-01 01:40:16', '2025-09-01 01:40:16'),
(580, 'ADARSONO', '232410053', '$2y$12$LKu9WjjGmShmrqLUdMVLqeTdHMdmwzvWhXIU2gtmsap3tUvvm.ZDe', 'siswa', '2025-09-01 01:40:16', '2025-09-01 01:40:16'),
(581, 'AFAHRI SATYA ABDUL', '232410054', '$2y$12$z/XK37t7oDjaQlXQv6K6K.L0P0xKBQu0IY.utO/rmAXuvQM.eglXu', 'siswa', '2025-09-01 01:40:17', '2025-09-01 01:40:17'),
(582, 'AHMAD RIZKI ADITIA', '232410055', '$2y$12$jVAg6042t/7mE7g8Jk0xwOn.weoJ1y7Rdw51vFCucCJ3c3nlfwzti', 'siswa', '2025-09-01 01:40:17', '2025-09-01 01:40:17'),
(583, 'AHMAD RIZKY AL MAHMOD', '232410056', '$2y$12$6WuSAaGYGavUajdsJhxvveH9pHTuLNW4gVra3ql.X3ag3l2gJWVFK', 'siswa', '2025-09-01 01:40:17', '2025-09-01 01:40:17'),
(584, 'AJI PANGESTU', '232410057', '$2y$12$MJjaqaa3Yu.tKdHWdFHNguDYtGQ5IuNlx5LLsjdUMc.97qhLIjN9.', 'siswa', '2025-09-01 01:40:17', '2025-09-01 01:40:17'),
(585, 'AKMAL KUSRORI', '232410058', '$2y$12$2GrKqgqcZT1UeJkg3TxrBO/t8s4Sxnc3uI.3g20PSHFJyIfRlJAXS', 'siswa', '2025-09-01 01:40:18', '2025-09-01 01:40:18'),
(586, 'ANGGA ADITIA', '232410059', '$2y$12$riGOpNJr7ytQib07PgS49eMUV1FveD8zDhKSY1.6S9ZIuu0iDUYpu', 'siswa', '2025-09-01 01:40:18', '2025-09-01 01:40:18'),
(587, 'ANNISA TUL AULIA', '232410060', '$2y$12$lfQVNE0i2ossQ0lJIa78nOFQriKYoonKvEo1.TY7jS85n3mjRt/ey', 'siswa', '2025-09-01 01:40:18', '2025-09-01 01:40:18'),
(588, 'AYAN SUPRIATNA', '232410061', '$2y$12$l.n4htoxk6sxYL6SE5edk.RBbA94i/4S5m/vzj/ztySS6aqoNfhg6', 'siswa', '2025-09-01 01:40:19', '2025-09-01 01:40:19'),
(589, 'CACA AULIANA', '232410062', '$2y$12$bWa5WuIWQtxVgvA/OetduO327pIa.DbAH7MAhh4.Q6kvLR90NHyNS', 'siswa', '2025-09-01 01:40:19', '2025-09-01 01:40:19'),
(590, 'DIKI SOMANTRI', '232410063', '$2y$12$HWCW3ThIKyL5tDD6vkojEOHyksXmGvBdbAcgiYk.LzLWhuPAJHfuu', 'siswa', '2025-09-01 01:40:19', '2025-09-01 01:40:19'),
(591, 'DIRGA RAGIL PUTRA RUKMANA', '232410064', '$2y$12$amtInQvGzHcI6R2IS4XUqe.14Z6T/tfA8p63zqByMMv35cUs0eOfG', 'siswa', '2025-09-01 01:40:19', '2025-09-01 01:40:19'),
(592, 'EVA ALEXA', '232410065', '$2y$12$o.4tUT61mRYpbQ4YisHZHOjo7sWT4MHeum6sGNV1.RrelnOiK8IMS', 'siswa', '2025-09-01 01:40:20', '2025-09-01 01:40:20'),
(593, 'FAIRUZ FIKHAR FUADI', '232410066', '$2y$12$tlfn1DpgbtIU4NLZ92b1z.lGJjvN/c8X5edpXUjEmEjasfTlVJRUy', 'siswa', '2025-09-01 01:40:20', '2025-09-01 01:40:20'),
(594, 'FITRIYANI', '232410067', '$2y$12$PHG9so8pkLpb.rBU2QZGBOPgh6UYUjbA.dd1V4ZGPinE0UtMnenJy', 'siswa', '2025-09-01 01:40:20', '2025-09-01 01:40:20'),
(595, 'HIDAYAT AHMAD SIDIK', '232410068', '$2y$12$4J6qGpvFOiWcQ2X.8IQqu.mhjLgp8WdkUkKCnHnrKmGgJ6vGwoqM.', 'siswa', '2025-09-01 01:40:20', '2025-09-01 01:40:20'),
(596, 'IRWAN ISKANDAR', '232410069', '$2y$12$hoS2lW6lICwMLBX/VDnKNurju/dCJ/c8TYEFO/SL2MrpFGLb0qGue', 'siswa', '2025-09-01 01:40:21', '2025-09-01 01:40:21'),
(597, 'KHOERUL APANDI', '232410070', '$2y$12$nuY4Q9nPdOxWhLM0I9qFKOa5mKzvGNQzj2RO3qutLSHvuHBN2ESCS', 'siswa', '2025-09-01 01:40:21', '2025-09-01 01:40:21'),
(598, 'KUSNATA', '232410071', '$2y$12$HqyOfzeyQRgWs.onR92aQ.g34zkb4rmw7RUPKaoQw9uGR/TkmXFpW', 'siswa', '2025-09-01 01:40:21', '2025-09-01 01:40:21'),
(599, 'MUHAMAD EGA OKTAVIAN', '232410072', '$2y$12$1Yz7SkTO7beo9FB0YPbMJ.Jv9RO3YIXq8zZFaISRaooTTbsdv3owe', 'siswa', '2025-09-01 01:40:21', '2025-09-01 01:40:21'),
(600, 'MUHAMAD YUNUS', '232410073', '$2y$12$Dph3WpJ00N3uQJ7XfLWfEuf57DKiwQu/m0iFWRdOgD/gqKrhWaV5i', 'siswa', '2025-09-01 01:40:22', '2025-09-01 01:40:22'),
(601, 'MUHAMMAD RAMDANI', '232410074', '$2y$12$fUsVrnW.mx8OmOQjdZuc6.xS4maG72f/wsWufmVQZ7kMO7RMqqJGS', 'siswa', '2025-09-01 01:40:22', '2025-09-01 01:40:22'),
(602, 'MUHAMMAD RAYHAN RAMDHAN', '232410075', '$2y$12$Mt5/5tHSUyhc.CyUGg70/.4b57VYMpUSog.h8fSGZSRFOSU4h8Q52', 'siswa', '2025-09-01 01:40:22', '2025-09-01 01:40:22'),
(603, 'RANIA NURDIAN', '232410076', '$2y$12$KRy7DXk95dnx99lvRzgyv.kCInhb1FlmfGVrVXDqyNFqYoFjRVoE.', 'siswa', '2025-09-01 01:40:23', '2025-09-01 01:40:23'),
(604, 'ROMLAH', '232410077', '$2y$12$0ibkVJ9M2Ad0kYcyd7FVAuprf/ac6xRlbvKBuyHbWGxJrrGW8OfGS', 'siswa', '2025-09-01 01:40:23', '2025-09-01 01:40:23'),
(605, 'SAAD APRIANSYAH', '232410078', '$2y$12$VOz4TmtKSNRdo9zb46CuB.7eeQZty0DitLMIwB/F5ELgljbk8BqHe', 'siswa', '2025-09-01 01:40:23', '2025-09-01 01:40:23'),
(606, 'SANTANA WIDI BAHARI', '232410079', '$2y$12$b/wHOcB3ELdg39wpua9OFeQbUHxsBanyhRmZAREpeJJwFL57irjP2', 'siswa', '2025-09-01 01:40:23', '2025-09-01 01:40:23'),
(607, 'SANTI', '232410080', '$2y$12$JQpQ2HA0TVFkF9Z3AianOeQv60.QyOVohqcSH6SouVU8vjU5WzVpm', 'siswa', '2025-09-01 01:40:24', '2025-09-01 01:40:24'),
(608, 'SITI PATIMAH', '232410081', '$2y$12$IQlSzRoBRDpbksWZtQC8IOh9SRF6btz2p37mcgMvw0xKrt6pA2WuG', 'siswa', '2025-09-01 01:40:24', '2025-09-01 01:40:24'),
(609, 'TAHRI RAHMADANI', '232410082', '$2y$12$Ulo/JvMnd4wZY7stB1CBYeLUzr/xwQZRp5.vh6Ee4GkzC2IPd4/sy', 'siswa', '2025-09-01 01:40:24', '2025-09-01 01:40:24'),
(610, 'TANGGUH AZIZI', '232410083', '$2y$12$9qJBHgdzVw5CE/PBhKgM7u2TNc8VFTdpexvzBR4nvdwRwuwO2T5ym', 'siswa', '2025-09-01 01:40:24', '2025-09-01 01:40:24'),
(611, 'TARVIN', '232410084', '$2y$12$PaFIl8YKqWwHzy.vVl/y1.LdSmToJGI57Tnlmm4zCJ5eeWrzTUOHS', 'siswa', '2025-09-01 01:40:25', '2025-09-01 01:40:25'),
(612, 'AGUSTIAN ABDUR ROFIQ', '232410085', '$2y$12$XqSzEDVvPj.FHUd6JZuIreMFrE89H1DYZ5wTnWppONE4PO4zmS9Rq', 'siswa', '2025-09-01 01:40:25', '2025-09-01 01:40:25'),
(613, 'AHMAD REKSA', '232410086', '$2y$12$6yLjM.p8jXOnJJe9aeg8hO0JWsSq4N.HQ50srVG0byGgMcrABoncG', 'siswa', '2025-09-01 01:40:25', '2025-09-01 01:40:25'),
(614, 'AKBAR RAMADANI', '232410087', '$2y$12$N9Tzxk8b7Okk9YnBx6QBCOFLAP1JZoBR95f6poktHKaXbaRxqudr6', 'siswa', '2025-09-01 01:40:26', '2025-09-01 01:40:26'),
(615, 'ANDREYAN SURYANA SAPUTRA', '232410088', '$2y$12$McrvZUM93xbLfyF3NmFGoODSaKM48wFXEiBThc554WiKeQz4.B3hC', 'siswa', '2025-09-01 01:40:26', '2025-09-01 01:40:26'),
(616, 'ARIF PERMANA SIDIK', '232410089', '$2y$12$QlWT8N1VQMUYBxBymSknIeGYJfmP8Znts1lw8z/sOAUVEaKKBHiyG', 'siswa', '2025-09-01 01:40:26', '2025-09-01 01:40:26'),
(617, 'AYU ARYANAH', '232410090', '$2y$12$XNiB8s7/Li3NzdtIQ58ktu5cSBberOpJeWpY5turrqFJyOVvdVMVO', 'siswa', '2025-09-01 01:40:27', '2025-09-01 01:40:27'),
(618, 'BUSYAERI MAJID', '232410091', '$2y$12$71ikq3RygYGGrZHf5rU.ieQj2ek/.Wf5S.x.WvEZ6HNMbhTf/4sv2', 'siswa', '2025-09-01 01:40:27', '2025-09-01 01:40:27'),
(619, 'CARTIWAN', '232410092', '$2y$12$mMSOnk5mkRNlv3aWLk8wmenSYlJzeBISxSTYRM8CaP4tOkSTD..wa', 'siswa', '2025-09-01 01:40:28', '2025-09-01 01:40:28'),
(620, 'DAHLIA SRI RAHAYU', '232410093', '$2y$12$0oYPJenKVl1ARkNOlZfBRu4saP6XfXienno10PE30nSQ6BVpfcVaW', 'siswa', '2025-09-01 01:40:28', '2025-09-01 01:40:28'),
(621, 'DERLY PRASETYO', '232410094', '$2y$12$GJd1Miv4shs2Jt0e0f8A8OZR4rDu4T7ncs44xVWKtCK3FKeOUtb2y', 'siswa', '2025-09-01 01:40:28', '2025-09-01 01:40:28'),
(622, 'DETIYA KUSMAYADI', '232410095', '$2y$12$vwvwxTzg.CJZ9eH4.A0eBeL/0j.9WLjSS8BidlzKSW9dBxolhzMVa', 'siswa', '2025-09-01 01:40:29', '2025-09-01 01:40:29'),
(623, 'DIMAS ROHMAN SAPUTRA', '232410096', '$2y$12$D5b0t4SZvu5bgG7GZk1nses5Q4qB.RJykp/IkoPAjpMnAQ6jBkjHW', 'siswa', '2025-09-01 01:40:29', '2025-09-01 01:40:29'),
(624, 'FAJAR FADILLAH', '232410097', '$2y$12$tCOBF99.KuZfuMuII60Pe.15RqS.pxaqElMsZCkX4iAvGMz7cYyzG', 'siswa', '2025-09-01 01:40:30', '2025-09-01 01:40:30'),
(625, 'FIKRI AHMAD MUBAROK', '232410098', '$2y$12$P/2VpSrZSiHVZ/qOaSQcze1k4APItW7L6QGAaiJwpe9y8g0yuoBU.', 'siswa', '2025-09-01 01:40:30', '2025-09-01 01:40:30'),
(626, 'GUNAWAN', '232410099', '$2y$12$XRIIvUqW6tLGwlggXx1jr.F1zXzUjA3P9bThOYZ3u1FzMDjqBT50O', 'siswa', '2025-09-01 01:40:30', '2025-09-01 01:40:30'),
(627, 'HADI HOERUDIN', '232410100', '$2y$12$A/h2/KnFolDiaTdJ0jYgU.vamlRe/atr7wTcYSDX.9Gm5bt9pZL7y', 'siswa', '2025-09-01 01:40:31', '2025-09-01 01:40:31'),
(628, 'IBNU QODA', '232410101', '$2y$12$17c6CzkNcerzOagl6Gba8OGVQFvvB5OLCz8iCSIGabWvV53Kz0og.', 'siswa', '2025-09-01 01:40:31', '2025-09-01 01:40:31'),
(629, 'IHYA ULUMUDIN', '232410102', '$2y$12$P8mPjgG311wpQJGGZKDb1.d7bHQoR3pS0W3lMbb.IQmdA0Y0RuohS', 'siswa', '2025-09-01 01:40:31', '2025-09-01 01:40:31'),
(630, 'INTAN DAHLIA', '232410103', '$2y$12$AOChRPRpCgQsLRy9T2PGGO0/zfb6sN4jfy5WOahRBwhzfH8aNLmLa', 'siswa', '2025-09-01 01:40:32', '2025-09-01 01:40:32'),
(631, 'INTAN NURAENI', '232410104', '$2y$12$NDzNWx8aNo4KweOkLkY0aOIMlnmhRpma/i/SoN3nZ50ajQve6K8b6', 'siswa', '2025-09-01 01:40:32', '2025-09-01 01:40:32'),
(632, 'LISNAWATI', '232410105', '$2y$12$ON8AZYs0qKEz4cJfNZuY0OeeQacwDmFtPIGmI/pt7XOfU1IMkqCx6', 'siswa', '2025-09-01 01:40:32', '2025-09-01 01:40:32'),
(633, 'MAMAN ABDUL RAHMAN', '232410106', '$2y$12$cIrh5Khxr4s1xJGMZ8aCM.A4Z2I7pOsd4PoPhOlDo8kilR9ulMeyu', 'siswa', '2025-09-01 01:40:33', '2025-09-01 01:40:33'),
(634, 'MEILANI PUSPITA SARI', '232410107', '$2y$12$bYOMSJCTyw2qPBzCO3iU7.L7HJY1Dkmh3m1642R..PqgC9ibeQGQW', 'siswa', '2025-09-01 01:40:33', '2025-09-01 01:40:33'),
(635, 'MUHAMAD AL NAZIB', '232410108', '$2y$12$Q3pxp/rrFoH8Hv6XTbvyPebYaSffLKtsYUAUMnygBB5zvBssrU.tS', 'siswa', '2025-09-01 01:40:33', '2025-09-01 01:40:33'),
(636, 'NADIA ASMIRANDAH', '232410109', '$2y$12$BckLwz9WUeJGqT/GL9OJtuRMbFeFMThy7JXq6bWc.qWRPGRWw6nAy', 'siswa', '2025-09-01 01:40:34', '2025-09-01 01:40:34'),
(637, 'NATA ADITIYA', '232410110', '$2y$12$Ytr.u6PguLdNHnaGqRq5vOlB3Tv076STZhJJj6dfdeOYuFwLuO7TS', 'siswa', '2025-09-01 01:40:34', '2025-09-01 01:40:34'),
(638, 'NOFITA DEWAN TARI', '232410111', '$2y$12$tGb/VbsNnG4RFXI/5Q1QPuoo0aMCEH6Lv/XsHrQ7FXV4Qj4eySZ3y', 'siswa', '2025-09-01 01:40:34', '2025-09-01 01:40:34'),
(639, 'NOPAL BUKHORI', '232410112', '$2y$12$kUdyvspOlX/f8Tn7k3ft4u4h/hV7uyuTj165SwB7MugNp/LMZbEGG', 'siswa', '2025-09-01 01:40:35', '2025-09-01 01:40:35'),
(640, 'NOVIANTI', '232410113', '$2y$12$NjFOoXNe0yjpu9/sPCyUq.po5YjXQXdLrqapGi7/oTH8EZSzO9jBC', 'siswa', '2025-09-01 01:40:35', '2025-09-01 01:40:35'),
(641, 'RIDWAN FADILAH', '232410114', '$2y$12$e4VOLWO.tUcQuaug4V/x2uK10CcvW2IDV2OGdwFNokSH1JShqkZli', 'siswa', '2025-09-01 01:40:35', '2025-09-01 01:40:35'),
(642, 'SISKA AULIA', '232410115', '$2y$12$JHdTf62aqQs67iIdL/wh1uBnNrIRt7IBN06i7.C4B2kO6ASGr/Tv.', 'siswa', '2025-09-01 01:40:35', '2025-09-01 01:40:35'),
(643, 'SUHENDAR', '232410116', '$2y$12$Q07uEKgjX2B..33sp0l2.u16m1F2CjDtmsc4RKFi7FrOC6o9waowC', 'siswa', '2025-09-01 01:40:36', '2025-09-01 01:40:36'),
(644, 'TOMI', '232410117', '$2y$12$ZKIRvqQAN6dRUphk5c/VUu/CTGvZmK1norhg.TRdMgE1/Kuj2pgP.', 'siswa', '2025-09-01 01:40:36', '2025-09-01 01:40:36');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(645, 'WARTA', '232410118', '$2y$12$uvJaO4/1RtOrUUs/OYH8NeN/vuFDroR6s7lA8dLVcm6M3mSDTSGq.', 'siswa', '2025-09-01 01:40:36', '2025-09-01 01:40:36'),
(646, 'ADAM MARIANSYAH', '232410119', '$2y$12$Sh/PF6sml04lR0FF/LZXF.knWCxS9toUKjp1NuX1jG0oR38KeZqWC', 'siswa', '2025-09-01 01:40:37', '2025-09-01 01:40:37'),
(647, 'AJIJAH LESTARI', '232410120', '$2y$12$VJgezDymmWS7mjtUbxuwkurTldr59IqzhziaFiVD2whyu/BsyF3eK', 'siswa', '2025-09-01 01:40:37', '2025-09-01 01:40:37'),
(648, 'ANDRIAN', '232410121', '$2y$12$PgPF2D3GOfgbxL47bKpAtO72ay4Okt9ID1Q/seWbgLL29wpgRDaCu', 'siswa', '2025-09-01 01:40:37', '2025-09-01 01:40:37'),
(649, 'DENDI PRASETYO', '232410122', '$2y$12$soEdtgM2/xaL/jlrAIxy1Og1O2fFkZF7krGLncquEiYbENpnJcTDa', 'siswa', '2025-09-01 01:40:37', '2025-09-01 01:40:37'),
(650, 'DIANA PUTRI AWALIAYAH', '232410123', '$2y$12$p1lLmFK7/HtyV3v69Q2muO5RbSTI4cg4MDTJpxuO8zoaFpGyVLEZ.', 'siswa', '2025-09-01 01:40:38', '2025-09-01 01:40:38'),
(651, 'DIFA HARIKURNIA', '232410124', '$2y$12$daFnCZONpQKVi.0OhRyi3OBIldSNISSzc4TSChbJjvOx4oTdxObV2', 'siswa', '2025-09-01 01:40:38', '2025-09-01 01:40:38'),
(652, 'ENAH MAEMUNAH', '232410125', '$2y$12$hV0MqBNvVJiC1dtWQ2gSM.Z5N.K4YFFSwgg1wr1AoQg41/RLNW7ce', 'siswa', '2025-09-01 01:40:38', '2025-09-01 01:40:38'),
(653, 'FAIQ AHMAD NAUFAL', '232410126', '$2y$12$dlcxbd8YKmRqPgsjU7sOiuhptiq4nDY.JsU.OiJ6.wJXQCjGIr8Vm', 'siswa', '2025-09-01 01:40:39', '2025-09-01 01:40:39'),
(654, 'FERI SOPANDI', '232410127', '$2y$12$z.wOxk5AivTXGt60LfOor.pQGPLSOmEPduIn.EGKUPusuMzSHOtmq', 'siswa', '2025-09-01 01:40:39', '2025-09-01 01:40:39'),
(655, 'IKBAL MAULANA IBROHIM', '232410128', '$2y$12$//fVXm89iAqwn4IxgpgYseVq/yRdPhpfbfT514U/nQibZPo8OKy.W', 'siswa', '2025-09-01 01:40:39', '2025-09-01 01:40:39'),
(656, 'KASMINAH', '232410129', '$2y$12$ameaWfAvOttGWYB0BFvTfeweiTg0N5.FbKU2LeBra3FR73WUVeXHC', 'siswa', '2025-09-01 01:40:39', '2025-09-01 01:40:39'),
(657, 'KATIMAH', '232410130', '$2y$12$9GSKv9tChdF/wq7CxIE3beF15JGsM/aIbyDAiyYfiaMmx2PR.mMCy', 'siswa', '2025-09-01 01:40:40', '2025-09-01 01:40:40'),
(658, 'LIGAR', '232410131', '$2y$12$Yu5eInOxsVY0FstKF99nsuX0Db5J3gL8Hia1pdW8DFDb5Xl9ultrK', 'siswa', '2025-09-01 01:40:40', '2025-09-01 01:40:40'),
(659, 'MAYA', '232410132', '$2y$12$gpcsmR.TL0cr87lMqzXtDOsjUN5LMSCm8PETe.wA21/QqzL.Soc/K', 'siswa', '2025-09-01 01:40:40', '2025-09-01 01:40:40'),
(660, 'MOH THOLIB RIVKI', '232410133', '$2y$12$cSi/UT9lrKAYj2vsZ2Qy4el9MbNtGNva1ytJNmeMoDvvBzxtpabyW', 'siswa', '2025-09-01 01:40:41', '2025-09-01 01:40:41'),
(661, 'MOHAMAD FEBRY AULIA', '232410134', '$2y$12$3gxqG8IsuihqQZi5u/ArKemHjEyQCUKQCdXXrAs/DJGpl8lqaGyli', 'siswa', '2025-09-01 01:40:41', '2025-09-01 01:40:41'),
(662, 'MOHAMAD RIDWAN', '232410135', '$2y$12$z/7JSg2mJ/4rIZG.KiEz6ekqAyQauAV3EnutKAVEwCGUTYN5K2T5.', 'siswa', '2025-09-01 01:40:41', '2025-09-01 01:40:41'),
(663, 'MUHAMAD HAIDAR RIFAI', '232410136', '$2y$12$bXkt2BKu97Y9YaQx4N3BGuQBe3t4cyDK3ZyfwDih9u1RYEECk0is.', 'siswa', '2025-09-01 01:40:41', '2025-09-01 01:40:41'),
(664, 'MUHAMMAD WAHYUDI', '232410137', '$2y$12$/45JApN25r3t/MXrui6ube/g2T8LnuhKOLD8V2LwcvtK3M4Wnkb6u', 'siswa', '2025-09-01 01:40:42', '2025-09-01 01:40:42'),
(665, 'NADILA LIESHARTANTI', '232410138', '$2y$12$gU35xG9pCKAgtJM7Y/3L3e2ORsRHmp6XXHZNqLA36ZzGuEvrAQX8i', 'siswa', '2025-09-01 01:40:42', '2025-09-01 01:40:42'),
(666, 'NARMAN', '232410139', '$2y$12$VrTEaKIVglw4Qkbqx4T13.x4Y.1n7wJDvY/9gSwvLCnz8DQmIoIQq', 'siswa', '2025-09-01 01:40:42', '2025-09-01 01:40:42'),
(667, 'NOVA YANTO', '232410140', '$2y$12$wWepsYAtPT1Q2ST3iQxbwe8v1vdGyHTbOT.NEhXvZLJdolQQXLvhC', 'siswa', '2025-09-01 01:40:43', '2025-09-01 01:40:43'),
(668, 'OGI WIRAGUNA NAMRAIH', '232410141', '$2y$12$daf8ZjO5s0L3Z7eSJ2ZKl.ImjSpA8bl3UhOI/QjWb4TPS2knmwi1e', 'siswa', '2025-09-01 01:40:43', '2025-09-01 01:40:43'),
(669, 'PEPEN FAISAL AGUSTIAN', '232410142', '$2y$12$OVuu9rY0m5WISFv7dBTB/eQ2jIR0m6OvkFfPA/rKiMWs/feQt77VW', 'siswa', '2025-09-01 01:40:43', '2025-09-01 01:40:43'),
(670, 'RAHIL TRISNA', '232410143', '$2y$12$tSdWRF4UAgzCiMhxQuBJd.7g2Ase.jxeCjKjmbrcml/N0/BKHcwbG', 'siswa', '2025-09-01 01:40:44', '2025-09-01 01:40:44'),
(671, 'RAMDANI', '232410144', '$2y$12$lMnLYx3ANALVYqNDifn7auYkYbz50gMy65v6.Mpo4tA2sB//Wk0wi', 'siswa', '2025-09-01 01:40:44', '2025-09-01 01:40:44'),
(672, 'RANGGA MUHAMAD FARHAN', '232410145', '$2y$12$ohb6259wqie.0rTQ0FY1oep5ZkhfatK.zYJAZlrCsGw0hx0ecjaHi', 'siswa', '2025-09-01 01:40:44', '2025-09-01 01:40:44'),
(673, 'RATU AYU SARI', '232410146', '$2y$12$Cd1TM8R/GrSvseurW8ot7eFCIoq133WOlbYbirvYVQYmSW2QIOIGm', 'siswa', '2025-09-01 01:40:44', '2025-09-01 01:40:44'),
(674, 'RENDI SUJAYA', '232410147', '$2y$12$iydyZ7XfKYyiHvFoF/Hu6OXg6JxddIgaTo1VSBtIGrsYx0hDgYtWK', 'siswa', '2025-09-01 01:40:45', '2025-09-01 01:40:45'),
(675, 'RENO AL FAUZI', '232410148', '$2y$12$oSNs9zJCceB3LnzXNqNwwODaTZwWn2BoY9fAUq1FMBAVSpZ9xOEzO', 'siswa', '2025-09-01 01:40:45', '2025-09-01 01:40:45'),
(676, 'RIDWAN IBNU AL FARIJI', '232410149', '$2y$12$rQis5/qA6PznlRuQZHYkNuTNxlRLWv4KXLZpXG5oumWsIRKxC23x6', 'siswa', '2025-09-01 01:40:45', '2025-09-01 01:40:45'),
(677, 'RIFA AHMAD SOFYAN', '232410150', '$2y$12$efbGIbBq1oj0M7PFS3hiV.0/pLS16kKNfcujsZXvspdfuv0hEH0R2', 'siswa', '2025-09-01 01:40:46', '2025-09-01 01:40:46'),
(678, 'SULTAN PERMANA PUTRA', '232410151', '$2y$12$d8h118uYjRqx9XUqUK8QHul9OeM.UdDlM.v8QJ4idXBdQ5KABp2T6', 'siswa', '2025-09-01 01:40:46', '2025-09-01 01:40:46'),
(679, 'SUPARDI', '232410152', '$2y$12$B4OoraT9mwkCW9lX4k2smO0swuxCjBsKE6Ab/NH7AWa1R8S5XuKw.', 'siswa', '2025-09-01 01:40:46', '2025-09-01 01:40:46'),
(680, 'WIDIA', '232410153', '$2y$12$3X4Hv3GIsjWUarD33gpMlO6a.cx3LRPdNzEHUVSZJDjNUsOsrZNQC', 'siswa', '2025-09-01 01:40:46', '2025-09-01 01:40:46'),
(681, 'ABDUL ROSID', '232410154', '$2y$12$e4auBmdEtz2aqeDznWlhS.lBAeEaEw/aP3stQXX9bA92KOouSIOb.', 'siswa', '2025-09-01 01:40:47', '2025-09-01 01:40:47'),
(682, 'AGUS', '232410155', '$2y$12$scI0ExIwMqwqG0phugVu9epXK1Ys93ozR1U3qzHF1/zIkzbMvjAg.', 'siswa', '2025-09-01 01:40:47', '2025-09-01 01:40:47'),
(683, 'AHMAD BAGIR', '232410156', '$2y$12$TdhJS44tlWc5VagUA34ZLuMIZuHoDoOkuaV1ImOkMV71LsTtJz/DK', 'siswa', '2025-09-01 01:40:47', '2025-09-01 01:40:47'),
(684, 'AKBAR BAIDILLAH SATORIK', '232410157', '$2y$12$KCO50QJ/0obUY7Ek8bLKQOaenewJkx1VI2ZrQq0tpyKs78ohzDqt6', 'siswa', '2025-09-01 01:40:48', '2025-09-01 01:40:48'),
(685, 'AMIRAH YULYANTI', '232410158', '$2y$12$/zmcg3V61L4OKDJIHg8gj.EVy7Ep/Bn57cKKxQjhkHNxjECkik0H.', 'siswa', '2025-09-01 01:40:48', '2025-09-01 01:40:48'),
(686, 'ANGGUN LESTARI', '232410159', '$2y$12$urENskGbvflMTC13ZRgjAuYaeIXjtIX/DMQ6P4MBLxOKtqOYsjSGC', 'siswa', '2025-09-01 01:40:48', '2025-09-01 01:40:48'),
(687, 'DAHVA DERIANSAH', '232410160', '$2y$12$RSP16GU9GKRgQgJwgz8zvuMhOwk5ur9pWV6jORuDOEa9Rhyq4HBv.', 'siswa', '2025-09-01 01:40:48', '2025-09-01 01:40:48'),
(688, 'DANA MAULANA', '232410161', '$2y$12$ImBd2YFawdok.vxf/c/rG.bNocLSk9xAjeXRNR86jmhOfe4lFNfke', 'siswa', '2025-09-01 01:40:49', '2025-09-01 01:40:49'),
(689, 'DEA NOVITA', '232410162', '$2y$12$3XJra3ItwJr9mOZO5v46UeEFcuQTwA6Ne/cjoqUVjftEGWgnRm4a.', 'siswa', '2025-09-01 01:40:49', '2025-09-01 01:40:49'),
(690, 'ELVIRA SELOMITHA ALENA', '232410163', '$2y$12$VEVoU3kyhFaurBcsT91fCugPeb3b97H5tPYveWBQmY2p5mruSWFOi', 'siswa', '2025-09-01 01:40:49', '2025-09-01 01:40:49'),
(691, 'FACHRY HABIBURROHMAN', '232410164', '$2y$12$MkPeJdsEVNVqAZ5d76r3WupuXivAATLLt8lbFTX9UvLwE6YWbfHNW', 'siswa', '2025-09-01 01:40:50', '2025-09-01 01:40:50'),
(692, 'FEBRIAN', '232410165', '$2y$12$peTQQEdVxB3jCjPEllD4nO7piF2Y4c3f8vH6mu54tyye4r5pdHa8K', 'siswa', '2025-09-01 01:40:50', '2025-09-01 01:40:50'),
(693, 'JANE DIKE PUTRI ARIAWAN', '232410166', '$2y$12$ifjLahcjKgrpdVZB7xZrhOGNXyIBtbiIK05GP3M/8bB7Cx8k0yX0S', 'siswa', '2025-09-01 01:40:50', '2025-09-01 01:40:50'),
(694, 'KOMALASARI', '232410167', '$2y$12$17qa1hJUyMJYR0u9..AQVO3paqpab9WFhV.N89ozvzAfih6rKK4SS', 'siswa', '2025-09-01 01:40:50', '2025-09-01 01:40:50'),
(695, 'LUVITA RAHMA SARI', '232410168', '$2y$12$hktMzVbN.BIh8f5jRnU5Z.8.NNhzE8vcmMmQRJ7H9DbFXHzEX9VI.', 'siswa', '2025-09-01 01:40:51', '2025-09-01 01:40:51'),
(696, 'MAHMUD MUNANDAR', '232410169', '$2y$12$EPa4W/LK7zBXBrVJA3MUk.PA6dh/VRnaJF4S7Usi5xbB.XqnZJdgO', 'siswa', '2025-09-01 01:40:51', '2025-09-01 01:40:51'),
(697, 'MARISA LINDA LESTARI', '232410170', '$2y$12$JpkxAbBIA..KgjHpnuuLzez9W2kB/x1s/afFAY5VU/8lu4cpTDmfK', 'siswa', '2025-09-01 01:40:51', '2025-09-01 01:40:51'),
(698, 'MILA SARI', '232410171', '$2y$12$6PEq69pAuLhIylzvQsjdXenGZ/IOlFarf3i7yOO91B5Aqg.xSUpKa', 'siswa', '2025-09-01 01:40:52', '2025-09-01 01:40:52'),
(699, 'MUHAMAD RAIHAN GUMILAR', '232410172', '$2y$12$3IN66XdsWLtDH2aJs6efvu22GAROHeLPOmSQj2W5cvzo0U8Zydwq6', 'siswa', '2025-09-01 01:40:52', '2025-09-01 01:40:52'),
(700, 'MUHAMAD YUGA', '232410173', '$2y$12$HMgKfC8DHuDyTGl4I6oQf.Rrx1dJ.iSPpAXYtPxLGs2NlJXrksEa.', 'siswa', '2025-09-01 01:40:52', '2025-09-01 01:40:52'),
(701, 'RAFI ALHABSY', '232410174', '$2y$12$JngP6Y/D5JpbxAesm4w1cuJGR9CLB4s6ONCP4SMbnq9zWg8/SxuQe', 'siswa', '2025-09-01 01:40:52', '2025-09-01 01:40:52'),
(702, 'RAHMAN', '232410175', '$2y$12$JyXvPUBg4qxk3x3rQrJAG.ivlqj2H45GZAj3OWTKlCqjgEqI7ck.S', 'siswa', '2025-09-01 01:40:53', '2025-09-01 01:40:53'),
(703, 'RAZAN MUHAMMAD IHSAN', '232410176', '$2y$12$EslWrfCXcVCVOFqHhnc/Fu/ptXfi5b/pjzplsiiLmoqmKmTRCvuuy', 'siswa', '2025-09-01 01:40:53', '2025-09-01 01:40:53'),
(704, 'RIAN ADRIANSYAH', '232410177', '$2y$12$jIl1qJYo6lR42iggF.i7Q.4txZFFrMjl5GYIDc0FEr8B5kOP709.C', 'siswa', '2025-09-01 01:40:53', '2025-09-01 01:40:53'),
(705, 'RIAN FIKRIANSAH', '232410178', '$2y$12$Img7/cNWIsHwG6zMprno2uIYcN52oiINfwicarTQRJ0R3sLlXykQ2', 'siswa', '2025-09-01 01:40:54', '2025-09-01 01:40:54'),
(706, 'RIF AN RIZIQ', '232410179', '$2y$12$DssrEutT2nb3q2DVwezjhehS9RBtiMfSx3JLVwaE/TvimwV.0FnBm', 'siswa', '2025-09-01 01:40:54', '2025-09-01 01:40:54'),
(707, 'ROHMAT HIDAYAT', '232410180', '$2y$12$GcryE4sdILbEm13dMi6JM.ZL8wVZGGLn2PkOOpRTpbz7o/EK01tCe', 'siswa', '2025-09-01 01:40:54', '2025-09-01 01:40:54'),
(708, 'RUDITA PRATAMA', '232410181', '$2y$12$vOg50WanNxJwjU.bSmgA2.NAZKx657sVZq5XJdU0XRF/bXLmHRGju', 'siswa', '2025-09-01 01:40:55', '2025-09-01 01:40:55'),
(709, 'SOPAN SOPIAN', '232410182', '$2y$12$9gfWbdq3QxT4lTfJ75pG3OqLnDubittVeUe16t9BEQVQeLsj5jd0S', 'siswa', '2025-09-01 01:40:55', '2025-09-01 01:40:55'),
(710, 'SRI WULANDARI', '232410183', '$2y$12$H0537/qdIpu2bLx1aLcxauJh4YfOSoyNK.z5k.IWIj3MdChi34U/q', 'siswa', '2025-09-01 01:40:55', '2025-09-01 01:40:55'),
(711, 'TONI JAYA SAPUTRA', '232410184', '$2y$12$uRb8NCH5EIsHOK7Pe8CjseriDmsoNX2kK308b6Sb6H78AR1zzQwqC', 'siswa', '2025-09-01 01:40:56', '2025-09-01 01:40:56'),
(712, 'USUP', '232410185', '$2y$12$xqBkWKUXSfBDjxy1TwSQ1eQvPrEwFosSmjG/F8OXtLJOtQUjOg5IW', 'siswa', '2025-09-01 01:40:56', '2025-09-01 01:40:56'),
(713, 'WAHYU REKSA DIFA', '232410186', '$2y$12$HhBTIolpI0FcRHFc0BzSqOMR/hGWLt908eEzlkD6HB5B/hiz.nkHe', 'siswa', '2025-09-01 01:40:56', '2025-09-01 01:40:56'),
(714, 'YAYAN HERMANTO', '232410187', '$2y$12$GeljV.lqKGaSE4q.8k.hQO.SaRUEO4opQmjS9I5SNkZgGjqw73rlK', 'siswa', '2025-09-01 01:40:56', '2025-09-01 01:40:56'),
(715, 'AHMAD FAUZAN', '232410188', '$2y$12$lc0LcXnAHjIBM1FzFeTOb.a4t6nK3GaNug2gKxLgdUAIWt1q14KeW', 'siswa', '2025-09-01 01:40:57', '2025-09-01 01:40:57'),
(716, 'AKBAR NANDA RUKMANA', '232410189', '$2y$12$.4IuydRqSaJfi5xONQ570u5F8Rlo8iA981KkFd1op5GRKw/rbQ1Cy', 'siswa', '2025-09-01 01:40:57', '2025-09-01 01:40:57'),
(717, 'ANGELLYA', '232410190', '$2y$12$yclv38/wZSlc2QWAngcHYeVssRVIqFQB0FGbnrK2kZRBNRqYrTQpW', 'siswa', '2025-09-01 01:40:57', '2025-09-01 01:40:57'),
(718, 'APID', '232410191', '$2y$12$w9QrZVKfEElOy3Z77f1bhOYlmJDWPENe/xBerz5eZDObuf7zlGB3.', 'siswa', '2025-09-01 01:40:58', '2025-09-01 01:40:58'),
(719, 'DIAN MUHLISOTUL ULFIAH', '232410192', '$2y$12$WncSPrED/CSw82myTu7on.Gc8F38k3t/3./uwjmULv46RA6MmpTP2', 'siswa', '2025-09-01 01:40:58', '2025-09-01 01:40:58'),
(720, 'DIAN PERMATASARI', '232410193', '$2y$12$6KGu8A.7KHTBJqSvZ3IMGetl.72ABN.18N.L/FoaRoT/O0kVC7SSK', 'siswa', '2025-09-01 01:40:58', '2025-09-01 01:40:58'),
(721, 'EKA PURWANA', '232410194', '$2y$12$MEm1VxFmBp4jrg1vjTqGt.ph7XuQ0GfeMSzEzmYImQbvzC4TvFSHa', 'siswa', '2025-09-01 01:40:58', '2025-09-01 01:40:58'),
(722, 'FAISHAL FAKHRI', '232410195', '$2y$12$fj.Gpvx2T29HdGPT96dzIOm3MYJb1J859zTinpZPWAWLgeUvNjjZ2', 'siswa', '2025-09-01 01:40:59', '2025-09-01 01:40:59'),
(723, 'HADI RAHMAN', '232410196', '$2y$12$zTdavqRKrsWO6E.GByVMo.G6l42St8wqIT.3unHFLyTzNZzfxzW6G', 'siswa', '2025-09-01 01:40:59', '2025-09-01 01:40:59'),
(724, 'INTAN', '232410197', '$2y$12$Uh4DOk4BF23y58h63.kg1OFGF9EkrGEzXWWYsFAyXLoJXT.iA8W2G', 'siswa', '2025-09-01 01:40:59', '2025-09-01 01:40:59'),
(725, 'IRSAN TICKNO', '232410198', '$2y$12$2uotwoo60NWthSjIieNgueyCwVrOtlbkj0B2cO7yswilqYJFpPCPi', 'siswa', '2025-09-01 01:40:59', '2025-09-01 01:40:59'),
(726, 'JAJANG KOSWARA', '232410199', '$2y$12$8JWv2zqKE3qsHa.NTS8yzuDn0X2rXJdzs.lx7gToQMkWSB74fhcEy', 'siswa', '2025-09-01 01:41:00', '2025-09-01 01:41:00'),
(727, 'JIHAN HOLIYANA', '232410200', '$2y$12$m8EvhlI9VsrfXAulHJckCuPaPSJAKHhaL4nHG8zIkwWxMokJycBju', 'siswa', '2025-09-01 01:41:08', '2025-09-01 01:41:08'),
(728, 'MARYADI', '232410201', '$2y$12$Dyf0ZoewWZ2IjbMxe0rEuu0rt18tTMJLLsnGb8GBYIN1vt.vJky3y', 'siswa', '2025-09-01 01:41:09', '2025-09-01 01:41:09'),
(729, 'MUHAMAD ALIN', '232410202', '$2y$12$1ofyOrLMACrA24FyVrdA6.tPLkmwSWZs/NHLjRMor5DkKCWCK/p3W', 'siswa', '2025-09-01 01:41:09', '2025-09-01 01:41:09'),
(730, 'MUHAMAD RONI ADITIA', '232410203', '$2y$12$Qwk6by4nFP3/Z9WQhukbSe2g8JifDyhnzfZtrpWCNRBm31C7.EDu.', 'siswa', '2025-09-01 01:41:09', '2025-09-01 01:41:09'),
(731, 'MUHAMMAD REIVANDI', '232410204', '$2y$12$B.KKPq8t4.HdQfFHJw2wAOydrO2pKR4.qr/mZNpYqHDAL9irVWddS', 'siswa', '2025-09-01 01:41:09', '2025-09-01 01:41:09'),
(732, 'MUKHAMAD MARUF', '232410205', '$2y$12$pF5G7hvcaUsi9LEeo/JSa.zQs34dp5ZpShGBGP9z4qziYaiwPgjzK', 'siswa', '2025-09-01 01:41:10', '2025-09-01 01:41:10'),
(733, 'NURI AGUSTINA', '232410206', '$2y$12$z.tqfNLkP.KaQdeMGU7X9.mXpC2DpPpZ66ZK/Kqk2KTZMFoPd0y6y', 'siswa', '2025-09-01 01:41:10', '2025-09-01 01:41:10'),
(734, 'RAHMAT HIDAYAT', '232410207', '$2y$12$HLyqpz0BwTLCB8h3iuZi.OcRfixRakzEfv6sQVXRTsa52ddByxACC', 'siswa', '2025-09-01 01:41:10', '2025-09-01 01:41:10'),
(735, 'RAMDANI', '232410208', '$2y$12$Pk5c9uWHBHI4qs/EtABpaejLXKh/6P5mZJxqKZmGVDInc8evL5fcy', 'siswa', '2025-09-01 01:41:11', '2025-09-01 01:41:11'),
(736, 'REYJA', '232410209', '$2y$12$LQ3brBGOTxw5P/FRSr4qWuEqggaLHX04wwwCJZJBXNZsHPITAgFBS', 'siswa', '2025-09-01 01:41:11', '2025-09-01 01:41:11'),
(737, 'RIYAN ARYANTO', '232410210', '$2y$12$YCkyQyHG2ORWM2Touh48Xuh6BXsRU1EnDTtYBr.R9I6v7XBSn4lh6', 'siswa', '2025-09-01 01:41:11', '2025-09-01 01:41:11'),
(738, 'RIZZKI AKBAR ALFATIRI', '232410211', '$2y$12$zvfptK1VSKzf.rbVelh.JuagnzyvM.AYU9fBqHZjh90o89WZclf4.', 'siswa', '2025-09-01 01:41:12', '2025-09-01 01:41:12'),
(739, 'ROPI LORO SOPANJI', '232410212', '$2y$12$JeN0flRd7irUUoNBn64v3O.8zHAfzrQkgZsJpxYN11FSjIruA4Uee', 'siswa', '2025-09-01 01:41:12', '2025-09-01 01:41:12'),
(740, 'SUYUTI AHMAD BUSAERI', '232410213', '$2y$12$af2TGJuQhL2yNbRy/VzIm.F/9Ye1pLfROTTbLp7KRl8GFg7MoWiRK', 'siswa', '2025-09-01 01:41:12', '2025-09-01 01:41:12'),
(741, 'TITI NURJANAH', '232410214', '$2y$12$O79lSsao94oG30JCYhW6wOoTWeNyK0o/UVMAnV430M0f58FadnWuO', 'siswa', '2025-09-01 01:41:12', '2025-09-01 01:41:12'),
(742, 'WIRANATA', '232410215', '$2y$12$pJoBEs/ooPsid8LrZry3UeGOOl.oOYT9ka/SdwGqf3Lg8TuqBAt.K', 'siswa', '2025-09-01 01:41:13', '2025-09-01 01:41:13'),
(743, 'YAZID RAHMAT HIDAYAT', '232410216', '$2y$12$Ib9ShIC0X5cZKj2FlH2W6uEEGoS5NWqtoVXP5W0rTrTs0D0QN4Lje', 'siswa', '2025-09-01 01:41:13', '2025-09-01 01:41:13'),
(744, 'YUDIS TIRA ROMANSAH', '232410217', '$2y$12$iVW31uRHsSGwsV1yZqzydubUvaqSUyUY12g4JbX9YruA6ZWEUYLc6', 'siswa', '2025-09-01 01:41:13', '2025-09-01 01:41:13'),
(745, 'YULI DEWIYANTI', '232410218', '$2y$12$rWOx5rZSnLXsMjRF4FqD2u1y0nGG2HoPFR0i1lKBj5L5q54Wq3FTi', 'siswa', '2025-09-01 01:41:14', '2025-09-01 01:41:14'),
(746, 'YULITA', '232410219', '$2y$12$Looee8L2SUgGmfT8SarLlOfApPL.F1mZ3CleNTs6QAFXEt659OKdq', 'siswa', '2025-09-01 01:41:14', '2025-09-01 01:41:14'),
(747, 'ABDUL RONI', '232410220', '$2y$12$lXUZFFMwfF7GUTeI5W6oMOt6pLC2FGHrSPkcuQp0M2.x50rjtoOn6', 'siswa', '2025-09-01 01:41:14', '2025-09-01 01:41:14'),
(748, 'ABDUL SIDIK', '232410221', '$2y$12$e.ja/.SxWjNA8EFL1q19Q.pAi8NNblXwUh8LSWpgGaocRk1KAk00a', 'siswa', '2025-09-01 01:41:14', '2025-09-01 01:41:14'),
(749, 'AEL GHAZALI', '232410222', '$2y$12$bFl4fXliS8D0l3RMe.vd6O8Zbo854rCOkMabL..owXPg04l6bGgL6', 'siswa', '2025-09-01 01:41:15', '2025-09-01 01:41:15'),
(750, 'AHMAD FAHRI YUNMAR', '232410223', '$2y$12$72l6.yY0tv90a0zJvvqfdu7PP2HFZipcl0Q.1lcZ4kQ.chPN3HNwu', 'siswa', '2025-09-01 01:41:15', '2025-09-01 01:41:15'),
(751, 'AHMAD ZAKKY JAELANI', '232410224', '$2y$12$cNmDwKBIQzurN6GrN5JN5Ol8K36D81JJt/L3tEOMIjLBHqxzib3OO', 'siswa', '2025-09-01 01:41:15', '2025-09-01 01:41:15'),
(752, 'AHMAL', '232410225', '$2y$12$007usyCL2YR9/7T05JDItOEcyhEydoaU4kHxPfZfoU5cWN3uAJBjS', 'siswa', '2025-09-01 01:41:16', '2025-09-01 01:41:16'),
(753, 'AKBAR SUGIHARTONO', '232410226', '$2y$12$8iGDWKZE0No7kPCSP7H.veG5Dy.sJugY.qHewVgOtRYVrVQANl9Cm', 'siswa', '2025-09-01 01:41:16', '2025-09-01 01:41:16'),
(754, 'AMELDA FIKRIA', '232410227', '$2y$12$HIUB38dw74jGYD5kYNC9FOI4Lnn9LFJLHb2aNfXJvZc7xC8DToLRu', 'siswa', '2025-09-01 01:41:16', '2025-09-01 01:41:16'),
(755, 'ARHAM SODIK', '232410228', '$2y$12$LZO5sZofKv0asvJg.UrMx.yyIlMaAGoFJc58afIWB.mW0C00hHC1K', 'siswa', '2025-09-01 01:41:17', '2025-09-01 01:41:17'),
(756, 'ATISAH', '232410229', '$2y$12$.roY/GKYHndJZiH7wOSy2OMWI8AWUcEv8W0A89RSg9Hyrs6cf6tS.', 'siswa', '2025-09-01 01:41:17', '2025-09-01 01:41:17'),
(757, 'CAHYA KOMARA', '232410230', '$2y$12$VNOR5YYxVumNc26Atfc.KOEXc7c5wpjw3n8Lxg0zq0BCDRPkY2NmK', 'siswa', '2025-09-01 01:41:17', '2025-09-01 01:41:17'),
(758, 'DEDEN', '232410231', '$2y$12$aeK4r4RLNxoxzHDhfhUSc.2v5G8lbHcvtIEbjRZBL4PmOD8L2Ps5.', 'siswa', '2025-09-01 01:41:17', '2025-09-01 01:41:17'),
(759, 'FITRIA ANGGRAENI', '232410232', '$2y$12$r4Ul4jK5r7BmDhkfU6ZIk.g/0MawZA8w42TlEQzvtlj9H4aMwFUci', 'siswa', '2025-09-01 01:41:18', '2025-09-01 01:41:18'),
(760, 'FITRIA RAMADANI', '232410233', '$2y$12$dqzysVdoVQ4Wy1g9R4FXnup4Ac8C.UB.umg3vX6IPKlXPiaEkl5Ii', 'siswa', '2025-09-01 01:41:18', '2025-09-01 01:41:18'),
(761, 'GITA MELINDA SARI', '232410234', '$2y$12$0.fgEG8eLWzJqPJmm3O0OOvtn2dWk36rrYTTFH7BxmVUr0LfhVboC', 'siswa', '2025-09-01 01:41:18', '2025-09-01 01:41:18'),
(762, 'IBNU HASAN', '232410235', '$2y$12$ROI9GJ6nn5s5PHPgMBAkeOrjHPVjtmOkbOqXsztSD3qSA/fzBlLly', 'siswa', '2025-09-01 01:41:18', '2025-09-01 01:41:18'),
(763, 'JAJANG SUTEJA', '232410236', '$2y$12$qPbggikY/92I8jJ3Ic6zh.i2lvbL6fjWdEiC4vKxKV032zlJV3DVG', 'siswa', '2025-09-01 01:41:19', '2025-09-01 01:41:19'),
(764, 'KARNOM', '232410237', '$2y$12$cieFeOCmsTE6wiUDJIp..Okxkp6nUsmh3kGC8YnWPLO7daKHiZVQC', 'siswa', '2025-09-01 01:41:19', '2025-09-01 01:41:19'),
(765, 'KARYA MULYANA', '232410238', '$2y$12$ON9Wcc7FjR.0zMLtl9q8kuWdBqAWEOGCktYNv8kO1o/5f0GBccQ7m', 'siswa', '2025-09-01 01:41:19', '2025-09-01 01:41:19'),
(766, 'KHAIRUL IKHWAN ABBASY', '232410239', '$2y$12$fcZDyZZc7lxF0Pk6t.HkDeiLVtkc1W99cwHc4oBZD5CRLAYFfYN6C', 'siswa', '2025-09-01 01:41:20', '2025-09-01 01:41:20'),
(767, 'MAULIDDANI AHMAD NURHANDIKA', '232410240', '$2y$12$trA35EZLDL/sV8avDxoNNulK816/gpDAjshstPh/SKFUHh52tId1q', 'siswa', '2025-09-01 01:41:20', '2025-09-01 01:41:20'),
(768, 'MELI IMELDA', '232410241', '$2y$12$cF4CBPmmf8YuEl1h7XQkOeu9F.g4wnMHWtdImRQv1AN5P08WG4XjC', 'siswa', '2025-09-01 01:41:20', '2025-09-01 01:41:20'),
(769, 'MUHAMAD ROSANDI', '232410242', '$2y$12$1/FDYVSAbAQCTqrz9PKDq.tX3aK2Evqm88qdirhnpa7dDtkbzZ1Si', 'siswa', '2025-09-01 01:41:20', '2025-09-01 01:41:20'),
(770, 'MUHAMMAD RAFA FAUZAN', '232410243', '$2y$12$HPbVvD0cE9og6pmNIxCetOOl8HZkYPEzDyou84EwCTc5Tgv8aqAnu', 'siswa', '2025-09-01 01:41:21', '2025-09-01 01:41:21'),
(771, 'MUHAMMAD RAIHAN', '232410244', '$2y$12$8r/pk//XpEBaoinGcJE71.eHQNit9ig9mmBvd0Cp8QpSkWtMEbl2G', 'siswa', '2025-09-01 01:41:21', '2025-09-01 01:41:21'),
(772, 'NOVIANI', '232410245', '$2y$12$f8gdJsWDwsNzLpbqUE7jzuDVZ.6PJhI3775QF2Oyt6a4nleFvj0Ly', 'siswa', '2025-09-01 01:41:21', '2025-09-01 01:41:21'),
(773, 'PIRMANSAH', '232410246', '$2y$12$8pn2c6eePs1WgiVtpec77.3rzK42/T760aMazDhrRypVMXpBrGszC', 'siswa', '2025-09-01 01:41:22', '2025-09-01 01:41:22'),
(774, 'RADO SAPERO', '232410247', '$2y$12$MtCgxEFesbI1JpTZlqwv8uKCKwxz8hTB3KFighUMRdr1e6jmX8JMK', 'siswa', '2025-09-01 01:41:22', '2025-09-01 01:41:22'),
(775, 'SAEPUL PIRDAUS', '232410248', '$2y$12$WY4dX9J1r5kN7s6WnYg5K.AFGe9uDF6r3M4vGkRydFxzgUvF5mSBu', 'siswa', '2025-09-01 01:41:22', '2025-09-01 01:41:22'),
(776, 'SUHENDAR', '232410249', '$2y$12$/fQ97vVEB2/abt/H3FLk9.5ot.By7CODMngTKYp0ib8UcBvm1CmsK', 'siswa', '2025-09-01 01:41:22', '2025-09-01 01:41:22'),
(777, 'WIDHI BAGASKORO', '232410250', '$2y$12$wJKhwOh/C.RYvJER70LzvuMmMBi7xMh93nTcaJQXyS3aw9ZHMhRIW', 'siswa', '2025-09-01 01:41:23', '2025-09-01 01:41:23'),
(778, 'YULI', '232410251', '$2y$12$9AbEDDTOEe7nUc5Fw/SHi.jRkzEKRKn.1EKmOGULWgRbBfha1.GLS', 'siswa', '2025-09-01 01:41:23', '2025-09-01 01:41:23'),
(779, 'ZEN ANFASA HIDAYAT', '232410252', '$2y$12$FVpQHqQMp75UPy8U4dJHqOavFZWbcYAX7zCECG9eeFqTDUniB5.BK', 'siswa', '2025-09-01 01:41:23', '2025-09-01 01:41:23'),
(780, 'ABDUL ROHMAN', '232410253', '$2y$12$tyDTWCS2bqPTMrjaDbXRhelIuVcDSpYMz2n60F.ZL9ow18RUer3q6', 'siswa', '2025-09-01 01:41:23', '2025-09-01 01:41:23'),
(781, 'ASEP SUJANA', '232410254', '$2y$12$GhrbYaVsXpndCc.7/sA96OoUN3NduWYg1EpjNsXGpaKQ7/zpEBX4y', 'siswa', '2025-09-01 01:41:24', '2025-09-01 01:41:24'),
(782, 'DEDE RAFII', '232410255', '$2y$12$ayDxshtn6UuUiieKzG9IYesKo34cbnXjv3eive8aiaxvLv8wDW5xO', 'siswa', '2025-09-01 01:41:24', '2025-09-01 01:41:24'),
(783, 'DEDI WAHIDIN', '232410256', '$2y$12$D5jfwPaH6zYX4bIwQiTGUOZKwDMvFUdPKhzybDE5xjcb49sfot/..', 'siswa', '2025-09-01 01:41:24', '2025-09-01 01:41:24'),
(784, 'DETI DIAN TINI', '232410257', '$2y$12$Y.Mbht8EGCTNML3oCrhB8OO6Id2932omXbFzzKPvP0JhQg72cNNzq', 'siswa', '2025-09-01 01:41:25', '2025-09-01 01:41:25'),
(785, 'ERNA WIDIAWATI S', '232410258', '$2y$12$t.UMvapxXfqzJm.EctXoceMbmWIzXaMbW8hX/29TekAUhfUxWlQdy', 'siswa', '2025-09-01 01:41:25', '2025-09-01 01:41:25'),
(786, 'ERNI WIDIAWATI S', '232410259', '$2y$12$UBHFerqf5WlnXPuMXLygcuv0JddMftpCXbCj/v6e6xVut5Xob3TPq', 'siswa', '2025-09-01 01:41:25', '2025-09-01 01:41:25'),
(787, 'HUSEN SOBARNA', '232410260', '$2y$12$PuEVAOXBnP3zvMQU0A6jHesW.EIlF0GQbMpNEYd4AVcNd6jES313.', 'siswa', '2025-09-01 01:41:26', '2025-09-01 01:41:26'),
(788, 'IBNI MUHAJIR', '232410261', '$2y$12$A9522dHSxD9o9O7Cp1O10u0XrowYwiRVkFs55CgS4b9bPy1oS6cwy', 'siswa', '2025-09-01 01:41:26', '2025-09-01 01:41:26'),
(789, 'IIP IVANKA', '232410262', '$2y$12$se4j7d7YQYc66yhVrJnLL.wBHNFmdGmesYIGwhNNAy.472LjOo/h2', 'siswa', '2025-09-01 01:41:26', '2025-09-01 01:41:26'),
(790, 'IRFAN HIDAYAT', '232410263', '$2y$12$qYPmOuT99Ubo3CfoqeUQReZgxHAT2.ghDHvPelW2SgCQUHtTy72IS', 'siswa', '2025-09-01 01:41:27', '2025-09-01 01:41:27'),
(791, 'KARDIANTO', '232410264', '$2y$12$lhtG1maF3SLltPVS/J9hw.TC/XSK5lGvn2MgEFiOOjnEhuBP9seJm', 'siswa', '2025-09-01 01:41:27', '2025-09-01 01:41:27'),
(792, 'KISAR', '232410265', '$2y$12$jeud..uIyIL1KXwC80gFj.Ogy7avQxZfJDRD/6R6zvg2i2ijOffTG', 'siswa', '2025-09-01 01:41:27', '2025-09-01 01:41:27'),
(793, 'KORIYAH', '232410266', '$2y$12$ycMbbY2jLGMwhS3IFGeqv.GlUeLBvflY0iX/O2RK217M6qZ0J4fwW', 'siswa', '2025-09-01 01:41:27', '2025-09-01 01:41:27'),
(794, 'LINDA', '232410267', '$2y$12$nF37qiwarf5pSvi5Ejo7ge1Af00FjFfSy78M2tQNpaq5FBa6Nbg8G', 'siswa', '2025-09-01 01:41:28', '2025-09-01 01:41:28'),
(795, 'MAYA ANJELINA FRATAMA', '232410268', '$2y$12$NIZNOZfC2.LVpzklDBY7PeIc0bbsdJ1NXG8zvGyDN4Xouylu6jU9u', 'siswa', '2025-09-01 01:41:28', '2025-09-01 01:41:28'),
(796, 'MUHAMMAD ABDUL FAQIH', '232410269', '$2y$12$98/5Pno6.lKaBvMH6wVyZuZLMRYCwAHl371qMosRh3naVHOqxmRy2', 'siswa', '2025-09-01 01:41:28', '2025-09-01 01:41:28'),
(797, 'MUHAMMAD AHDA AL MUSYAROF', '232410270', '$2y$12$/VgALv9vrS3NwaiGpiRfDOoMGnsepiX2pvVKw3HMDqXocCJDHYBZy', 'siswa', '2025-09-01 01:41:29', '2025-09-01 01:41:29'),
(798, 'MUHAMMAD FADLAN', '232410271', '$2y$12$hkYuPqylHnFYBOtB/VE51uB5.4SdPFcJHn/Xmvk0WMRWjM9NOcquW', 'siswa', '2025-09-01 01:41:29', '2025-09-01 01:41:29'),
(799, 'MUTIARA AZIZAH', '232410272', '$2y$12$IzkWEwLjwPL6MriM754Qz.sqAdjnQsjf3CjtTutT.Pd3wpbZixj72', 'siswa', '2025-09-01 01:41:29', '2025-09-01 01:41:29'),
(800, 'NURAENI', '232410273', '$2y$12$FC.BdvSkFX1.M3T9r5TyV.rgw1Tv4DbXw.s6bkPqSmFYNUANMWBXu', 'siswa', '2025-09-01 01:41:29', '2025-09-01 01:41:29'),
(801, 'RAKA', '232410274', '$2y$12$BpcenIEGtS8fq8thPVKh3..RllfCEsjdd5W/LOUG5TzqsVMBzWTIi', 'siswa', '2025-09-01 01:41:30', '2025-09-01 01:41:30'),
(802, 'RIKI', '232410275', '$2y$12$e3QBoZL6fifY1vM.sCfys.Es.A55BxqsE2yCK5TM5rQY9LIMZ8g5O', 'siswa', '2025-09-01 01:41:30', '2025-09-01 01:41:30'),
(803, 'SAEPUL ANWAR', '232410276', '$2y$12$5uxh4fhB9pZFMruptjjuGe7kVf9OCSGK5g5Sz9G.0B8fX/Z97OlrC', 'siswa', '2025-09-01 01:41:30', '2025-09-01 01:41:30'),
(804, 'WARMAN', '232410277', '$2y$12$vV0kvVtGQYA1ZZXo7rjPceYnItZrejKYjV.aUW0lC.N9IXQs0iO/G', 'siswa', '2025-09-01 01:41:31', '2025-09-01 01:41:31'),
(805, 'YASMIN', '232410278', '$2y$12$plfZSyyWNXdBtJOMWwLahuQTUBtR84zh0.npUh1JrIQNQlnO43w7O', 'siswa', '2025-09-01 01:41:31', '2025-09-01 01:41:31');

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
('csLJHAENLxuRiOtSuhsg41zd3zqi2CtpJjAVL2Wu', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUUZzV3dYY0RtUm42VHlPdVFhcWxXcE91TlVlamNJS25TTmZkTnZmayI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMwOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvaW5zZW50aWYiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1756698261);

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
(1, 2, 2, '252610001', 0.00, 0, '2025-09-01 01:36:53', '2025-09-01 01:36:53'),
(2, 3, 2, '252610002', 0.00, 0, '2025-09-01 01:36:53', '2025-09-01 01:36:53'),
(3, 4, 2, '252610003', 0.00, 0, '2025-09-01 01:36:54', '2025-09-01 01:36:54'),
(4, 5, 2, '252610004', 0.00, 0, '2025-09-01 01:36:54', '2025-09-01 01:36:54'),
(5, 6, 2, '252610005', 0.00, 0, '2025-09-01 01:36:54', '2025-09-01 01:36:54'),
(6, 7, 2, '252610006', 0.00, 0, '2025-09-01 01:36:54', '2025-09-01 01:36:54'),
(7, 8, 2, '252610007', 0.00, 0, '2025-09-01 01:36:55', '2025-09-01 01:36:55'),
(8, 9, 2, '252610008', 0.00, 0, '2025-09-01 01:36:55', '2025-09-01 01:36:55'),
(9, 10, 2, '252610009', 0.00, 0, '2025-09-01 01:36:55', '2025-09-01 01:36:55'),
(10, 11, 2, '252610010', 0.00, 0, '2025-09-01 01:36:55', '2025-09-01 01:36:55'),
(11, 12, 2, '252610011', 0.00, 0, '2025-09-01 01:36:56', '2025-09-01 01:36:56'),
(12, 13, 2, '252610012', 0.00, 0, '2025-09-01 01:36:56', '2025-09-01 01:36:56'),
(13, 14, 2, '252610013', 0.00, 0, '2025-09-01 01:36:56', '2025-09-01 01:36:56'),
(14, 15, 2, '252610014', 0.00, 0, '2025-09-01 01:36:56', '2025-09-01 01:36:56'),
(15, 16, 2, '252610015', 0.00, 0, '2025-09-01 01:36:57', '2025-09-01 01:36:57'),
(16, 17, 2, '252610016', 0.00, 0, '2025-09-01 01:36:57', '2025-09-01 01:36:57'),
(17, 18, 2, '252610017', 0.00, 0, '2025-09-01 01:36:57', '2025-09-01 01:36:57'),
(18, 19, 2, '252610018', 0.00, 0, '2025-09-01 01:36:58', '2025-09-01 01:36:58'),
(19, 20, 2, '252610019', 0.00, 0, '2025-09-01 01:36:58', '2025-09-01 01:36:58'),
(20, 21, 2, '252610020', 0.00, 0, '2025-09-01 01:36:58', '2025-09-01 01:36:58'),
(21, 22, 2, '252610021', 0.00, 0, '2025-09-01 01:36:58', '2025-09-01 01:36:58'),
(22, 23, 2, '252610022', 0.00, 0, '2025-09-01 01:36:59', '2025-09-01 01:36:59'),
(23, 24, 2, '252610023', 0.00, 0, '2025-09-01 01:36:59', '2025-09-01 01:36:59'),
(24, 25, 2, '252610024', 0.00, 0, '2025-09-01 01:36:59', '2025-09-01 01:36:59'),
(25, 26, 2, '252610025', 0.00, 0, '2025-09-01 01:36:59', '2025-09-01 01:36:59'),
(26, 27, 2, '252610026', 0.00, 0, '2025-09-01 01:37:00', '2025-09-01 01:37:00'),
(27, 28, 2, '252610027', 0.00, 0, '2025-09-01 01:37:00', '2025-09-01 01:37:00'),
(28, 29, 3, '252610028', 0.00, 0, '2025-09-01 01:37:00', '2025-09-01 01:37:00'),
(29, 30, 3, '252610029', 0.00, 0, '2025-09-01 01:37:01', '2025-09-01 01:37:01'),
(30, 31, 3, '252610030', 0.00, 0, '2025-09-01 01:37:01', '2025-09-01 01:37:01'),
(31, 32, 3, '252610031', 0.00, 0, '2025-09-01 01:37:01', '2025-09-01 01:37:01'),
(32, 33, 3, '252610032', 0.00, 0, '2025-09-01 01:37:02', '2025-09-01 01:37:02'),
(33, 34, 3, '252610033', 0.00, 0, '2025-09-01 01:37:02', '2025-09-01 01:37:02'),
(34, 35, 3, '252610034', 0.00, 0, '2025-09-01 01:37:02', '2025-09-01 01:37:02'),
(35, 36, 3, '252610035', 0.00, 0, '2025-09-01 01:37:02', '2025-09-01 01:37:02'),
(36, 37, 3, '252610036', 0.00, 0, '2025-09-01 01:37:03', '2025-09-01 01:37:03'),
(37, 38, 3, '252610037', 0.00, 0, '2025-09-01 01:37:03', '2025-09-01 01:37:03'),
(38, 39, 3, '252610038', 0.00, 0, '2025-09-01 01:37:03', '2025-09-01 01:37:03'),
(39, 40, 3, '252610039', 0.00, 0, '2025-09-01 01:37:04', '2025-09-01 01:37:04'),
(40, 41, 3, '252610040', 0.00, 0, '2025-09-01 01:37:04', '2025-09-01 01:37:04'),
(41, 42, 3, '252610041', 0.00, 0, '2025-09-01 01:37:04', '2025-09-01 01:37:04'),
(42, 43, 3, '252610042', 0.00, 0, '2025-09-01 01:37:04', '2025-09-01 01:37:04'),
(43, 44, 3, '252610043', 0.00, 0, '2025-09-01 01:37:05', '2025-09-01 01:37:05'),
(44, 45, 3, '252610044', 0.00, 0, '2025-09-01 01:37:05', '2025-09-01 01:37:05'),
(45, 46, 3, '252610045', 0.00, 0, '2025-09-01 01:37:05', '2025-09-01 01:37:05'),
(46, 47, 3, '252610046', 0.00, 0, '2025-09-01 01:37:05', '2025-09-01 01:37:05'),
(47, 48, 3, '252610047', 0.00, 0, '2025-09-01 01:37:06', '2025-09-01 01:37:06'),
(48, 49, 3, '252610048', 0.00, 0, '2025-09-01 01:37:06', '2025-09-01 01:37:06'),
(49, 50, 3, '252610049', 0.00, 0, '2025-09-01 01:37:06', '2025-09-01 01:37:06'),
(50, 51, 3, '252610050', 0.00, 0, '2025-09-01 01:37:07', '2025-09-01 01:37:07'),
(51, 52, 3, '252610051', 0.00, 0, '2025-09-01 01:37:07', '2025-09-01 01:37:07'),
(52, 53, 3, '252610052', 0.00, 0, '2025-09-01 01:37:07', '2025-09-01 01:37:07'),
(53, 54, 3, '252610053', 0.00, 0, '2025-09-01 01:37:07', '2025-09-01 01:37:07'),
(54, 55, 3, '252610054', 0.00, 0, '2025-09-01 01:37:08', '2025-09-01 01:37:08'),
(55, 56, 3, '252610055', 0.00, 0, '2025-09-01 01:37:08', '2025-09-01 01:37:08'),
(56, 57, 3, '252610056', 0.00, 0, '2025-09-01 01:37:08', '2025-09-01 01:37:08'),
(57, 58, 4, '252610057', 0.00, 0, '2025-09-01 01:37:08', '2025-09-01 01:37:08'),
(58, 59, 4, '252610058', 0.00, 0, '2025-09-01 01:37:09', '2025-09-01 01:37:09'),
(59, 60, 4, '252610059', 0.00, 0, '2025-09-01 01:37:09', '2025-09-01 01:37:09'),
(60, 61, 4, '252610060', 0.00, 0, '2025-09-01 01:37:09', '2025-09-01 01:37:09'),
(61, 62, 4, '252610061', 0.00, 0, '2025-09-01 01:37:10', '2025-09-01 01:37:10'),
(62, 63, 4, '252610062', 0.00, 0, '2025-09-01 01:37:10', '2025-09-01 01:37:10'),
(63, 64, 4, '252610063', 0.00, 0, '2025-09-01 01:37:10', '2025-09-01 01:37:10'),
(64, 65, 4, '252610064', 0.00, 0, '2025-09-01 01:37:10', '2025-09-01 01:37:10'),
(65, 66, 4, '252610065', 0.00, 0, '2025-09-01 01:37:11', '2025-09-01 01:37:11'),
(66, 67, 4, '252610066', 0.00, 0, '2025-09-01 01:37:11', '2025-09-01 01:37:11'),
(67, 68, 4, '252610067', 0.00, 0, '2025-09-01 01:37:11', '2025-09-01 01:37:11'),
(68, 69, 4, '252610068', 0.00, 0, '2025-09-01 01:37:11', '2025-09-01 01:37:11'),
(69, 70, 4, '252610069', 0.00, 0, '2025-09-01 01:37:12', '2025-09-01 01:37:12'),
(70, 71, 4, '252610070', 0.00, 0, '2025-09-01 01:37:12', '2025-09-01 01:37:12'),
(71, 72, 4, '252610071', 0.00, 0, '2025-09-01 01:37:12', '2025-09-01 01:37:12'),
(72, 73, 4, '252610072', 0.00, 0, '2025-09-01 01:37:12', '2025-09-01 01:37:12'),
(73, 74, 4, '252610073', 0.00, 0, '2025-09-01 01:37:13', '2025-09-01 01:37:13'),
(74, 75, 4, '252610074', 0.00, 0, '2025-09-01 01:37:13', '2025-09-01 01:37:13'),
(75, 76, 4, '252610075', 0.00, 0, '2025-09-01 01:37:13', '2025-09-01 01:37:13'),
(76, 77, 4, '252610076', 0.00, 0, '2025-09-01 01:37:13', '2025-09-01 01:37:13'),
(77, 78, 4, '252610077', 0.00, 0, '2025-09-01 01:37:14', '2025-09-01 01:37:14'),
(78, 79, 4, '252610078', 0.00, 0, '2025-09-01 01:37:14', '2025-09-01 01:37:14'),
(79, 80, 4, '252610079', 0.00, 0, '2025-09-01 01:37:14', '2025-09-01 01:37:14'),
(80, 81, 4, '252610080', 0.00, 0, '2025-09-01 01:37:15', '2025-09-01 01:37:15'),
(81, 82, 4, '252610081', 0.00, 0, '2025-09-01 01:37:15', '2025-09-01 01:37:15'),
(82, 83, 4, '252610082', 0.00, 0, '2025-09-01 01:37:15', '2025-09-01 01:37:15'),
(83, 84, 4, '252610083', 0.00, 0, '2025-09-01 01:37:15', '2025-09-01 01:37:15'),
(84, 85, 4, '252610084', 0.00, 0, '2025-09-01 01:37:16', '2025-09-01 01:37:16'),
(85, 86, 4, '252610085', 0.00, 0, '2025-09-01 01:37:16', '2025-09-01 01:37:16'),
(86, 87, 4, '252610086', 0.00, 0, '2025-09-01 01:37:16', '2025-09-01 01:37:16'),
(87, 88, 4, '252610087', 0.00, 0, '2025-09-01 01:37:16', '2025-09-01 01:37:16'),
(88, 89, 4, '252610088', 0.00, 0, '2025-09-01 01:37:17', '2025-09-01 01:37:17'),
(89, 90, 4, '252610089', 0.00, 0, '2025-09-01 01:37:17', '2025-09-01 01:37:17'),
(90, 91, 4, '252610090', 0.00, 0, '2025-09-01 01:37:17', '2025-09-01 01:37:17'),
(91, 92, 5, '252610091', 0.00, 0, '2025-09-01 01:37:17', '2025-09-01 01:37:17'),
(92, 93, 5, '252610092', 0.00, 0, '2025-09-01 01:37:18', '2025-09-01 01:37:18'),
(93, 94, 5, '252610093', 0.00, 0, '2025-09-01 01:37:18', '2025-09-01 01:37:18'),
(94, 95, 5, '252610094', 0.00, 0, '2025-09-01 01:37:18', '2025-09-01 01:37:18'),
(95, 96, 5, '252610095', 0.00, 0, '2025-09-01 01:37:18', '2025-09-01 01:37:18'),
(96, 97, 5, '252610096', 0.00, 0, '2025-09-01 01:37:19', '2025-09-01 01:37:19'),
(97, 98, 5, '252610097', 0.00, 0, '2025-09-01 01:37:19', '2025-09-01 01:37:19'),
(98, 99, 5, '252610098', 0.00, 0, '2025-09-01 01:37:19', '2025-09-01 01:37:19'),
(99, 100, 5, '252610099', 0.00, 0, '2025-09-01 01:37:19', '2025-09-01 01:37:19'),
(100, 101, 5, '252610100', 0.00, 0, '2025-09-01 01:37:20', '2025-09-01 01:37:20'),
(101, 102, 5, '252610101', 0.00, 0, '2025-09-01 01:37:20', '2025-09-01 01:37:20'),
(102, 103, 5, '252610102', 0.00, 0, '2025-09-01 01:37:20', '2025-09-01 01:37:20'),
(103, 104, 5, '252610103', 0.00, 0, '2025-09-01 01:37:21', '2025-09-01 01:37:21'),
(104, 105, 5, '252610104', 0.00, 0, '2025-09-01 01:37:21', '2025-09-01 01:37:21'),
(105, 106, 5, '252610105', 0.00, 0, '2025-09-01 01:37:21', '2025-09-01 01:37:21'),
(106, 107, 5, '252610106', 0.00, 0, '2025-09-01 01:37:21', '2025-09-01 01:37:21'),
(107, 108, 5, '252610107', 0.00, 0, '2025-09-01 01:37:22', '2025-09-01 01:37:22'),
(108, 109, 5, '252610108', 0.00, 0, '2025-09-01 01:37:22', '2025-09-01 01:37:22'),
(109, 110, 5, '252610109', 0.00, 0, '2025-09-01 01:37:22', '2025-09-01 01:37:22'),
(110, 111, 5, '252610110', 0.00, 0, '2025-09-01 01:37:22', '2025-09-01 01:37:22'),
(111, 112, 5, '252610111', 0.00, 0, '2025-09-01 01:37:23', '2025-09-01 01:37:23'),
(112, 113, 5, '252610112', 0.00, 0, '2025-09-01 01:37:23', '2025-09-01 01:37:23'),
(113, 114, 5, '252610113', 0.00, 0, '2025-09-01 01:37:23', '2025-09-01 01:37:23'),
(114, 115, 5, '252610114', 0.00, 0, '2025-09-01 01:37:23', '2025-09-01 01:37:23'),
(115, 116, 5, '252610115', 0.00, 0, '2025-09-01 01:37:24', '2025-09-01 01:37:24'),
(116, 117, 5, '252610116', 0.00, 0, '2025-09-01 01:37:24', '2025-09-01 01:37:24'),
(117, 118, 5, '252610117', 0.00, 0, '2025-09-01 01:37:24', '2025-09-01 01:37:24'),
(118, 119, 5, '252610118', 0.00, 0, '2025-09-01 01:37:25', '2025-09-01 01:37:25'),
(119, 120, 5, '252610119', 0.00, 0, '2025-09-01 01:37:25', '2025-09-01 01:37:25'),
(120, 121, 5, '252610120', 0.00, 0, '2025-09-01 01:37:25', '2025-09-01 01:37:25'),
(121, 122, 5, '252610121', 0.00, 0, '2025-09-01 01:37:25', '2025-09-01 01:37:25'),
(122, 123, 5, '252610122', 0.00, 0, '2025-09-01 01:37:26', '2025-09-01 01:37:26'),
(123, 124, 5, '252610123', 0.00, 0, '2025-09-01 01:37:26', '2025-09-01 01:37:26'),
(124, 125, 5, '252610124', 0.00, 0, '2025-09-01 01:37:26', '2025-09-01 01:37:26'),
(125, 126, 6, '252610125', 0.00, 0, '2025-09-01 01:37:26', '2025-09-01 01:37:26'),
(126, 127, 6, '252610126', 0.00, 0, '2025-09-01 01:37:27', '2025-09-01 01:37:27'),
(127, 128, 6, '252610127', 0.00, 0, '2025-09-01 01:37:27', '2025-09-01 01:37:27'),
(128, 129, 6, '252610128', 0.00, 0, '2025-09-01 01:37:27', '2025-09-01 01:37:27'),
(129, 130, 6, '252610129', 0.00, 0, '2025-09-01 01:37:27', '2025-09-01 01:37:27'),
(130, 131, 6, '252610130', 0.00, 0, '2025-09-01 01:37:28', '2025-09-01 01:37:28'),
(131, 132, 6, '252610131', 0.00, 0, '2025-09-01 01:37:28', '2025-09-01 01:37:28'),
(132, 133, 6, '252610132', 0.00, 0, '2025-09-01 01:37:28', '2025-09-01 01:37:28'),
(133, 134, 6, '252610133', 0.00, 0, '2025-09-01 01:37:29', '2025-09-01 01:37:29'),
(134, 135, 6, '252610134', 0.00, 0, '2025-09-01 01:37:29', '2025-09-01 01:37:29'),
(135, 136, 6, '252610135', 0.00, 0, '2025-09-01 01:37:29', '2025-09-01 01:37:29'),
(136, 137, 6, '252610136', 0.00, 0, '2025-09-01 01:37:29', '2025-09-01 01:37:29'),
(137, 138, 6, '252610137', 0.00, 0, '2025-09-01 01:37:30', '2025-09-01 01:37:30'),
(138, 139, 6, '252610138', 0.00, 0, '2025-09-01 01:37:30', '2025-09-01 01:37:30'),
(139, 140, 6, '252610139', 0.00, 0, '2025-09-01 01:37:30', '2025-09-01 01:37:30'),
(140, 141, 6, '252610140', 0.00, 0, '2025-09-01 01:37:30', '2025-09-01 01:37:30'),
(141, 142, 6, '252610141', 0.00, 0, '2025-09-01 01:37:31', '2025-09-01 01:37:31'),
(142, 143, 6, '252610142', 0.00, 0, '2025-09-01 01:37:31', '2025-09-01 01:37:31'),
(143, 144, 6, '252610143', 0.00, 0, '2025-09-01 01:37:31', '2025-09-01 01:37:31'),
(144, 145, 6, '252610144', 0.00, 0, '2025-09-01 01:37:32', '2025-09-01 01:37:32'),
(145, 146, 6, '252610145', 0.00, 0, '2025-09-01 01:37:32', '2025-09-01 01:37:32'),
(146, 147, 6, '252610146', 0.00, 0, '2025-09-01 01:37:32', '2025-09-01 01:37:32'),
(147, 148, 6, '252610147', 0.00, 0, '2025-09-01 01:37:32', '2025-09-01 01:37:32'),
(148, 149, 6, '252610148', 0.00, 0, '2025-09-01 01:37:33', '2025-09-01 01:37:33'),
(149, 150, 6, '252610149', 0.00, 0, '2025-09-01 01:37:33', '2025-09-01 01:37:33'),
(150, 151, 6, '252610150', 0.00, 0, '2025-09-01 01:37:33', '2025-09-01 01:37:33'),
(151, 152, 6, '252610151', 0.00, 0, '2025-09-01 01:37:34', '2025-09-01 01:37:34'),
(152, 153, 6, '252610152', 0.00, 0, '2025-09-01 01:37:34', '2025-09-01 01:37:34'),
(153, 154, 6, '252610153', 0.00, 0, '2025-09-01 01:37:34', '2025-09-01 01:37:34'),
(154, 155, 6, '252610154', 0.00, 0, '2025-09-01 01:37:34', '2025-09-01 01:37:34'),
(155, 156, 6, '252610155', 0.00, 0, '2025-09-01 01:37:35', '2025-09-01 01:37:35'),
(156, 157, 6, '252610156', 0.00, 0, '2025-09-01 01:37:35', '2025-09-01 01:37:35'),
(157, 158, 6, '252610157', 0.00, 0, '2025-09-01 01:37:35', '2025-09-01 01:37:35'),
(158, 159, 6, '252610158', 0.00, 0, '2025-09-01 01:37:36', '2025-09-01 01:37:36'),
(159, 160, 7, '252610159', 0.00, 0, '2025-09-01 01:37:36', '2025-09-01 01:37:36'),
(160, 161, 7, '252610160', 0.00, 0, '2025-09-01 01:37:36', '2025-09-01 01:37:36'),
(161, 162, 7, '252610161', 0.00, 0, '2025-09-01 01:37:36', '2025-09-01 01:37:36'),
(162, 163, 7, '252610162', 0.00, 0, '2025-09-01 01:37:37', '2025-09-01 01:37:37'),
(163, 164, 7, '252610163', 0.00, 0, '2025-09-01 01:37:37', '2025-09-01 01:37:37'),
(164, 165, 7, '252610164', 0.00, 0, '2025-09-01 01:37:37', '2025-09-01 01:37:37'),
(165, 166, 7, '252610165', 0.00, 0, '2025-09-01 01:37:37', '2025-09-01 01:37:37'),
(166, 167, 7, '252610166', 0.00, 0, '2025-09-01 01:37:38', '2025-09-01 01:37:38'),
(167, 168, 7, '252610167', 0.00, 0, '2025-09-01 01:37:38', '2025-09-01 01:37:38'),
(168, 169, 7, '252610168', 0.00, 0, '2025-09-01 01:37:38', '2025-09-01 01:37:38'),
(169, 170, 7, '252610169', 0.00, 0, '2025-09-01 01:37:38', '2025-09-01 01:37:38'),
(170, 171, 7, '252610170', 0.00, 0, '2025-09-01 01:37:39', '2025-09-01 01:37:39'),
(171, 172, 7, '252610171', 0.00, 0, '2025-09-01 01:37:39', '2025-09-01 01:37:39'),
(172, 173, 7, '252610172', 0.00, 0, '2025-09-01 01:37:39', '2025-09-01 01:37:39'),
(173, 174, 7, '252610173', 0.00, 0, '2025-09-01 01:37:40', '2025-09-01 01:37:40'),
(174, 175, 7, '252610174', 0.00, 0, '2025-09-01 01:37:40', '2025-09-01 01:37:40'),
(175, 176, 7, '252610175', 0.00, 0, '2025-09-01 01:37:40', '2025-09-01 01:37:40'),
(176, 177, 7, '252610176', 0.00, 0, '2025-09-01 01:37:40', '2025-09-01 01:37:40'),
(177, 178, 7, '252610177', 0.00, 0, '2025-09-01 01:37:41', '2025-09-01 01:37:41'),
(178, 179, 7, '252610178', 0.00, 0, '2025-09-01 01:37:41', '2025-09-01 01:37:41'),
(179, 180, 7, '252610179', 0.00, 0, '2025-09-01 01:37:41', '2025-09-01 01:37:41'),
(180, 181, 7, '252610180', 0.00, 0, '2025-09-01 01:37:41', '2025-09-01 01:37:41'),
(181, 182, 7, '252610181', 0.00, 0, '2025-09-01 01:37:42', '2025-09-01 01:37:42'),
(182, 183, 7, '252610182', 0.00, 0, '2025-09-01 01:37:42', '2025-09-01 01:37:42'),
(183, 184, 7, '252610183', 0.00, 0, '2025-09-01 01:37:42', '2025-09-01 01:37:42'),
(184, 185, 7, '252610184', 0.00, 0, '2025-09-01 01:37:42', '2025-09-01 01:37:42'),
(185, 186, 7, '252610185', 0.00, 0, '2025-09-01 01:37:43', '2025-09-01 01:37:43'),
(186, 187, 7, '252610186', 0.00, 0, '2025-09-01 01:37:43', '2025-09-01 01:37:43'),
(187, 188, 7, '252610187', 0.00, 0, '2025-09-01 01:37:43', '2025-09-01 01:37:43'),
(188, 189, 7, '252610188', 0.00, 0, '2025-09-01 01:37:43', '2025-09-01 01:37:43'),
(189, 190, 7, '252610189', 0.00, 0, '2025-09-01 01:37:44', '2025-09-01 01:37:44'),
(190, 191, 7, '252610190', 0.00, 0, '2025-09-01 01:37:44', '2025-09-01 01:37:44'),
(191, 192, 7, '252610191', 0.00, 0, '2025-09-01 01:37:44', '2025-09-01 01:37:44'),
(192, 193, 7, '252610192', 0.00, 0, '2025-09-01 01:37:45', '2025-09-01 01:37:45'),
(193, 194, 8, '252610193', 0.00, 0, '2025-09-01 01:37:45', '2025-09-01 01:37:45'),
(194, 195, 8, '252610194', 0.00, 0, '2025-09-01 01:37:45', '2025-09-01 01:37:45'),
(195, 196, 8, '252610195', 0.00, 0, '2025-09-01 01:37:45', '2025-09-01 01:37:45'),
(196, 197, 8, '252610196', 0.00, 0, '2025-09-01 01:37:46', '2025-09-01 01:37:46'),
(197, 198, 8, '252610197', 0.00, 0, '2025-09-01 01:37:46', '2025-09-01 01:37:46'),
(198, 199, 8, '252610198', 0.00, 0, '2025-09-01 01:37:46', '2025-09-01 01:37:46'),
(199, 200, 8, '252610199', 0.00, 0, '2025-09-01 01:37:46', '2025-09-01 01:37:46'),
(200, 201, 8, '252610200', 0.00, 0, '2025-09-01 01:38:02', '2025-09-01 01:38:02'),
(201, 202, 8, '252610201', 0.00, 0, '2025-09-01 01:38:03', '2025-09-01 01:38:03'),
(202, 203, 8, '252610202', 0.00, 0, '2025-09-01 01:38:03', '2025-09-01 01:38:03'),
(203, 204, 8, '252610203', 0.00, 0, '2025-09-01 01:38:03', '2025-09-01 01:38:03'),
(204, 205, 8, '252610204', 0.00, 0, '2025-09-01 01:38:03', '2025-09-01 01:38:03'),
(205, 206, 8, '252610205', 0.00, 0, '2025-09-01 01:38:04', '2025-09-01 01:38:04'),
(206, 207, 8, '252610206', 0.00, 0, '2025-09-01 01:38:04', '2025-09-01 01:38:04'),
(207, 208, 8, '252610207', 0.00, 0, '2025-09-01 01:38:04', '2025-09-01 01:38:04'),
(208, 209, 8, '252610208', 0.00, 0, '2025-09-01 01:38:04', '2025-09-01 01:38:04'),
(209, 210, 8, '252610209', 0.00, 0, '2025-09-01 01:38:05', '2025-09-01 01:38:05'),
(210, 211, 8, '252610210', 0.00, 0, '2025-09-01 01:38:05', '2025-09-01 01:38:05'),
(211, 212, 8, '252610211', 0.00, 0, '2025-09-01 01:38:05', '2025-09-01 01:38:05'),
(212, 213, 8, '252610212', 0.00, 0, '2025-09-01 01:38:05', '2025-09-01 01:38:05'),
(213, 214, 8, '252610213', 0.00, 0, '2025-09-01 01:38:06', '2025-09-01 01:38:06'),
(214, 215, 8, '252610214', 0.00, 0, '2025-09-01 01:38:06', '2025-09-01 01:38:06'),
(215, 216, 8, '252610215', 0.00, 0, '2025-09-01 01:38:06', '2025-09-01 01:38:06'),
(216, 217, 8, '252610216', 0.00, 0, '2025-09-01 01:38:07', '2025-09-01 01:38:07'),
(217, 218, 8, '252610217', 0.00, 0, '2025-09-01 01:38:07', '2025-09-01 01:38:07'),
(218, 219, 8, '252610218', 0.00, 0, '2025-09-01 01:38:07', '2025-09-01 01:38:07'),
(219, 220, 8, '252610219', 0.00, 0, '2025-09-01 01:38:07', '2025-09-01 01:38:07'),
(220, 221, 8, '252610220', 0.00, 0, '2025-09-01 01:38:08', '2025-09-01 01:38:08'),
(221, 222, 8, '252610221', 0.00, 0, '2025-09-01 01:38:08', '2025-09-01 01:38:08'),
(222, 223, 8, '252610222', 0.00, 0, '2025-09-01 01:38:08', '2025-09-01 01:38:08'),
(223, 224, 8, '252610223', 0.00, 0, '2025-09-01 01:38:08', '2025-09-01 01:38:08'),
(224, 225, 8, '252610224', 0.00, 0, '2025-09-01 01:38:09', '2025-09-01 01:38:09'),
(225, 226, 8, '252610225', 0.00, 0, '2025-09-01 01:38:09', '2025-09-01 01:38:09'),
(226, 227, 8, '252610226', 0.00, 0, '2025-09-01 01:38:09', '2025-09-01 01:38:09'),
(227, 228, 8, '252610227', 0.00, 0, '2025-09-01 01:38:09', '2025-09-01 01:38:09'),
(228, 229, 9, '252610228', 0.00, 0, '2025-09-01 01:38:10', '2025-09-01 01:38:10'),
(229, 230, 9, '252610229', 0.00, 0, '2025-09-01 01:38:10', '2025-09-01 01:38:10'),
(230, 231, 9, '252610230', 0.00, 0, '2025-09-01 01:38:10', '2025-09-01 01:38:10'),
(231, 232, 9, '252610231', 0.00, 0, '2025-09-01 01:38:10', '2025-09-01 01:38:10'),
(232, 233, 9, '252610232', 0.00, 0, '2025-09-01 01:38:11', '2025-09-01 01:38:11'),
(233, 234, 9, '252610233', 0.00, 0, '2025-09-01 01:38:11', '2025-09-01 01:38:11'),
(234, 235, 9, '252610234', 0.00, 0, '2025-09-01 01:38:11', '2025-09-01 01:38:11'),
(235, 236, 9, '252610235', 0.00, 0, '2025-09-01 01:38:12', '2025-09-01 01:38:12'),
(236, 237, 9, '252610236', 0.00, 0, '2025-09-01 01:38:12', '2025-09-01 01:38:12'),
(237, 238, 9, '252610237', 0.00, 0, '2025-09-01 01:38:12', '2025-09-01 01:38:12'),
(238, 239, 9, '252610238', 0.00, 0, '2025-09-01 01:38:12', '2025-09-01 01:38:12'),
(239, 240, 9, '252610239', 0.00, 0, '2025-09-01 01:38:13', '2025-09-01 01:38:13'),
(240, 241, 9, '252610240', 0.00, 0, '2025-09-01 01:38:13', '2025-09-01 01:38:13'),
(241, 242, 9, '252610241', 0.00, 0, '2025-09-01 01:38:13', '2025-09-01 01:38:13'),
(242, 243, 9, '252610242', 0.00, 0, '2025-09-01 01:38:13', '2025-09-01 01:38:13'),
(243, 244, 9, '252610243', 0.00, 0, '2025-09-01 01:38:14', '2025-09-01 01:38:14'),
(244, 245, 9, '252610244', 0.00, 0, '2025-09-01 01:38:14', '2025-09-01 01:38:14'),
(245, 246, 9, '252610245', 0.00, 0, '2025-09-01 01:38:14', '2025-09-01 01:38:14'),
(246, 247, 9, '252610246', 0.00, 0, '2025-09-01 01:38:14', '2025-09-01 01:38:14'),
(247, 248, 9, '252610247', 0.00, 0, '2025-09-01 01:38:15', '2025-09-01 01:38:15'),
(248, 249, 9, '252610248', 0.00, 0, '2025-09-01 01:38:15', '2025-09-01 01:38:15'),
(249, 250, 9, '252610249', 0.00, 0, '2025-09-01 01:38:15', '2025-09-01 01:38:15'),
(250, 251, 9, '252610250', 0.00, 0, '2025-09-01 01:38:16', '2025-09-01 01:38:16'),
(251, 252, 9, '252610251', 0.00, 0, '2025-09-01 01:38:16', '2025-09-01 01:38:16'),
(252, 253, 9, '252610252', 0.00, 0, '2025-09-01 01:38:16', '2025-09-01 01:38:16'),
(253, 254, 9, '252610253', 0.00, 0, '2025-09-01 01:38:16', '2025-09-01 01:38:16'),
(254, 255, 9, '252610254', 0.00, 0, '2025-09-01 01:38:17', '2025-09-01 01:38:17'),
(255, 256, 9, '252610255', 0.00, 0, '2025-09-01 01:38:17', '2025-09-01 01:38:17'),
(256, 257, 9, '252610256', 0.00, 0, '2025-09-01 01:38:17', '2025-09-01 01:38:17'),
(257, 258, 9, '252610257', 0.00, 0, '2025-09-01 01:38:17', '2025-09-01 01:38:17'),
(258, 259, 9, '252610258', 0.00, 0, '2025-09-01 01:38:18', '2025-09-01 01:38:18'),
(259, 260, 9, '252610259', 0.00, 0, '2025-09-01 01:38:18', '2025-09-01 01:38:18'),
(260, 261, 9, '252610260', 0.00, 0, '2025-09-01 01:38:18', '2025-09-01 01:38:18'),
(261, 262, 9, '252610261', 0.00, 0, '2025-09-01 01:38:18', '2025-09-01 01:38:18'),
(262, 263, 9, '252610262', 0.00, 0, '2025-09-01 01:38:19', '2025-09-01 01:38:19'),
(263, 264, 10, '242510001', 0.00, 0, '2025-09-01 01:38:25', '2025-09-01 01:38:25'),
(264, 265, 10, '242510002', 0.00, 0, '2025-09-01 01:38:25', '2025-09-01 01:38:25'),
(265, 266, 10, '242510003', 0.00, 0, '2025-09-01 01:38:25', '2025-09-01 01:38:25'),
(266, 267, 10, '242510004', 0.00, 0, '2025-09-01 01:38:26', '2025-09-01 01:38:26'),
(267, 268, 10, '242510005', 0.00, 0, '2025-09-01 01:38:26', '2025-09-01 01:38:26'),
(268, 269, 10, '242510006', 0.00, 0, '2025-09-01 01:38:26', '2025-09-01 01:38:26'),
(269, 270, 10, '242510007', 0.00, 0, '2025-09-01 01:38:27', '2025-09-01 01:38:27'),
(270, 271, 10, '242510008', 0.00, 0, '2025-09-01 01:38:27', '2025-09-01 01:38:27'),
(271, 272, 10, '242510009', 0.00, 0, '2025-09-01 01:38:27', '2025-09-01 01:38:27'),
(272, 273, 10, '242510010', 0.00, 0, '2025-09-01 01:38:27', '2025-09-01 01:38:27'),
(273, 274, 10, '242510011', 0.00, 0, '2025-09-01 01:38:28', '2025-09-01 01:38:28'),
(274, 275, 10, '242510012', 0.00, 0, '2025-09-01 01:38:28', '2025-09-01 01:38:28'),
(275, 276, 10, '242510013', 0.00, 0, '2025-09-01 01:38:29', '2025-09-01 01:38:29'),
(276, 277, 10, '242510014', 0.00, 0, '2025-09-01 01:38:29', '2025-09-01 01:38:29'),
(277, 278, 10, '242510015', 0.00, 0, '2025-09-01 01:38:29', '2025-09-01 01:38:29'),
(278, 279, 10, '242510016', 0.00, 0, '2025-09-01 01:38:29', '2025-09-01 01:38:29'),
(279, 280, 10, '242510017', 0.00, 0, '2025-09-01 01:38:30', '2025-09-01 01:38:30'),
(280, 281, 10, '242510018', 0.00, 0, '2025-09-01 01:38:30', '2025-09-01 01:38:30'),
(281, 282, 10, '242510019', 0.00, 0, '2025-09-01 01:38:30', '2025-09-01 01:38:30'),
(282, 283, 10, '242510020', 0.00, 0, '2025-09-01 01:38:30', '2025-09-01 01:38:30'),
(283, 284, 10, '242510021', 0.00, 0, '2025-09-01 01:38:31', '2025-09-01 01:38:31'),
(284, 285, 10, '242510022', 0.00, 0, '2025-09-01 01:38:31', '2025-09-01 01:38:31'),
(285, 286, 10, '242510023', 0.00, 0, '2025-09-01 01:38:31', '2025-09-01 01:38:31'),
(286, 287, 10, '242510024', 0.00, 0, '2025-09-01 01:38:32', '2025-09-01 01:38:32'),
(287, 288, 10, '242510025', 0.00, 0, '2025-09-01 01:38:32', '2025-09-01 01:38:32'),
(288, 289, 10, '242510026', 0.00, 0, '2025-09-01 01:38:32', '2025-09-01 01:38:32'),
(289, 290, 10, '242510027', 0.00, 0, '2025-09-01 01:38:32', '2025-09-01 01:38:32'),
(290, 291, 10, '242510028', 0.00, 0, '2025-09-01 01:38:33', '2025-09-01 01:38:33'),
(291, 292, 10, '242510029', 0.00, 0, '2025-09-01 01:38:33', '2025-09-01 01:38:33'),
(292, 293, 10, '242510030', 0.00, 0, '2025-09-01 01:38:33', '2025-09-01 01:38:33'),
(293, 294, 10, '242510031', 0.00, 0, '2025-09-01 01:38:34', '2025-09-01 01:38:34'),
(294, 295, 10, '242510032', 0.00, 0, '2025-09-01 01:38:34', '2025-09-01 01:38:34'),
(295, 296, 10, '242510033', 0.00, 0, '2025-09-01 01:38:34', '2025-09-01 01:38:34'),
(296, 297, 11, '242510034', 0.00, 0, '2025-09-01 01:38:35', '2025-09-01 01:38:35'),
(297, 298, 11, '242510035', 0.00, 0, '2025-09-01 01:38:35', '2025-09-01 01:38:35'),
(298, 299, 11, '242510036', 0.00, 0, '2025-09-01 01:38:35', '2025-09-01 01:38:35'),
(299, 300, 11, '242510037', 0.00, 0, '2025-09-01 01:38:35', '2025-09-01 01:38:35'),
(300, 301, 11, '242510038', 0.00, 0, '2025-09-01 01:38:36', '2025-09-01 01:38:36'),
(301, 302, 11, '242510039', 0.00, 0, '2025-09-01 01:38:36', '2025-09-01 01:38:36'),
(302, 303, 11, '242510040', 0.00, 0, '2025-09-01 01:38:36', '2025-09-01 01:38:36'),
(303, 304, 11, '242510041', 0.00, 0, '2025-09-01 01:38:37', '2025-09-01 01:38:37'),
(304, 305, 11, '242510042', 0.00, 0, '2025-09-01 01:38:37', '2025-09-01 01:38:37'),
(305, 306, 11, '242510043', 0.00, 0, '2025-09-01 01:38:37', '2025-09-01 01:38:37'),
(306, 307, 11, '242510044', 0.00, 0, '2025-09-01 01:38:37', '2025-09-01 01:38:37'),
(307, 308, 11, '242510045', 0.00, 0, '2025-09-01 01:38:38', '2025-09-01 01:38:38'),
(308, 309, 11, '242510046', 0.00, 0, '2025-09-01 01:38:38', '2025-09-01 01:38:38'),
(309, 310, 11, '242510047', 0.00, 0, '2025-09-01 01:38:38', '2025-09-01 01:38:38'),
(310, 311, 11, '242510048', 0.00, 0, '2025-09-01 01:38:39', '2025-09-01 01:38:39'),
(311, 312, 11, '242510049', 0.00, 0, '2025-09-01 01:38:39', '2025-09-01 01:38:39'),
(312, 313, 11, '242510050', 0.00, 0, '2025-09-01 01:38:39', '2025-09-01 01:38:39'),
(313, 314, 11, '242510051', 0.00, 0, '2025-09-01 01:38:39', '2025-09-01 01:38:39'),
(314, 315, 11, '242510052', 0.00, 0, '2025-09-01 01:38:40', '2025-09-01 01:38:40'),
(315, 316, 11, '242510053', 0.00, 0, '2025-09-01 01:38:40', '2025-09-01 01:38:40'),
(316, 317, 11, '242510054', 0.00, 0, '2025-09-01 01:38:40', '2025-09-01 01:38:40'),
(317, 318, 11, '242510055', 0.00, 0, '2025-09-01 01:38:41', '2025-09-01 01:38:41'),
(318, 319, 11, '242510056', 0.00, 0, '2025-09-01 01:38:41', '2025-09-01 01:38:41'),
(319, 320, 11, '242510057', 0.00, 0, '2025-09-01 01:38:41', '2025-09-01 01:38:41'),
(320, 321, 11, '242510058', 0.00, 0, '2025-09-01 01:38:41', '2025-09-01 01:38:41'),
(321, 322, 11, '242510059', 0.00, 0, '2025-09-01 01:38:42', '2025-09-01 01:38:42'),
(322, 323, 11, '242510060', 0.00, 0, '2025-09-01 01:38:42', '2025-09-01 01:38:42'),
(323, 324, 11, '242510061', 0.00, 0, '2025-09-01 01:38:42', '2025-09-01 01:38:42'),
(324, 325, 11, '242510062', 0.00, 0, '2025-09-01 01:38:42', '2025-09-01 01:38:42'),
(325, 326, 11, '242510063', 0.00, 0, '2025-09-01 01:38:43', '2025-09-01 01:38:43'),
(326, 327, 11, '242510064', 0.00, 0, '2025-09-01 01:38:43', '2025-09-01 01:38:43'),
(327, 328, 12, '242510065', 0.00, 0, '2025-09-01 01:38:43', '2025-09-01 01:38:43'),
(328, 329, 12, '242510066', 0.00, 0, '2025-09-01 01:38:44', '2025-09-01 01:38:44'),
(329, 330, 12, '242510067', 0.00, 0, '2025-09-01 01:38:44', '2025-09-01 01:38:44'),
(330, 331, 12, '242510068', 0.00, 0, '2025-09-01 01:38:44', '2025-09-01 01:38:44'),
(331, 332, 12, '242510069', 0.00, 0, '2025-09-01 01:38:44', '2025-09-01 01:38:44'),
(332, 333, 12, '242510070', 0.00, 0, '2025-09-01 01:38:45', '2025-09-01 01:38:45'),
(333, 334, 12, '242510071', 0.00, 0, '2025-09-01 01:38:45', '2025-09-01 01:38:45'),
(334, 335, 12, '242510072', 0.00, 0, '2025-09-01 01:38:45', '2025-09-01 01:38:45'),
(335, 336, 12, '242510073', 0.00, 0, '2025-09-01 01:38:45', '2025-09-01 01:38:45'),
(336, 337, 12, '242510074', 0.00, 0, '2025-09-01 01:38:46', '2025-09-01 01:38:46'),
(337, 338, 12, '242510075', 0.00, 0, '2025-09-01 01:38:46', '2025-09-01 01:38:46'),
(338, 339, 12, '242510076', 0.00, 0, '2025-09-01 01:38:46', '2025-09-01 01:38:46'),
(339, 340, 12, '242510077', 0.00, 0, '2025-09-01 01:38:47', '2025-09-01 01:38:47'),
(340, 341, 12, '242510078', 0.00, 0, '2025-09-01 01:38:47', '2025-09-01 01:38:47'),
(341, 342, 12, '242510079', 0.00, 0, '2025-09-01 01:38:47', '2025-09-01 01:38:47'),
(342, 343, 12, '242510080', 0.00, 0, '2025-09-01 01:38:47', '2025-09-01 01:38:47'),
(343, 344, 12, '242510081', 0.00, 0, '2025-09-01 01:38:48', '2025-09-01 01:38:48'),
(344, 345, 12, '242510082', 0.00, 0, '2025-09-01 01:38:48', '2025-09-01 01:38:48'),
(345, 346, 12, '242510083', 0.00, 0, '2025-09-01 01:38:48', '2025-09-01 01:38:48'),
(346, 347, 12, '242510084', 0.00, 0, '2025-09-01 01:38:48', '2025-09-01 01:38:48'),
(347, 348, 12, '242510085', 0.00, 0, '2025-09-01 01:38:49', '2025-09-01 01:38:49'),
(348, 349, 12, '242510086', 0.00, 0, '2025-09-01 01:38:49', '2025-09-01 01:38:49'),
(349, 350, 12, '242510087', 0.00, 0, '2025-09-01 01:38:49', '2025-09-01 01:38:49'),
(350, 351, 12, '242510088', 0.00, 0, '2025-09-01 01:38:50', '2025-09-01 01:38:50'),
(351, 352, 12, '242510089', 0.00, 0, '2025-09-01 01:38:50', '2025-09-01 01:38:50'),
(352, 353, 12, '242510090', 0.00, 0, '2025-09-01 01:38:50', '2025-09-01 01:38:50'),
(353, 354, 12, '242510091', 0.00, 0, '2025-09-01 01:38:50', '2025-09-01 01:38:50'),
(354, 355, 12, '242510092', 0.00, 0, '2025-09-01 01:38:51', '2025-09-01 01:38:51'),
(355, 356, 12, '242510093', 0.00, 0, '2025-09-01 01:38:51', '2025-09-01 01:38:51'),
(356, 357, 12, '242510094', 0.00, 0, '2025-09-01 01:38:51', '2025-09-01 01:38:51'),
(357, 358, 12, '242510095', 0.00, 0, '2025-09-01 01:38:51', '2025-09-01 01:38:51'),
(358, 359, 12, '242510096', 0.00, 0, '2025-09-01 01:38:52', '2025-09-01 01:38:52'),
(359, 360, 13, '242510097', 0.00, 0, '2025-09-01 01:38:52', '2025-09-01 01:38:52'),
(360, 361, 13, '242510098', 0.00, 0, '2025-09-01 01:38:52', '2025-09-01 01:38:52'),
(361, 362, 13, '242510099', 0.00, 0, '2025-09-01 01:38:53', '2025-09-01 01:38:53'),
(362, 363, 13, '242510100', 0.00, 0, '2025-09-01 01:38:53', '2025-09-01 01:38:53'),
(363, 364, 13, '242510101', 0.00, 0, '2025-09-01 01:38:53', '2025-09-01 01:38:53'),
(364, 365, 13, '242510102', 0.00, 0, '2025-09-01 01:38:53', '2025-09-01 01:38:53'),
(365, 366, 13, '242510103', 0.00, 0, '2025-09-01 01:38:54', '2025-09-01 01:38:54'),
(366, 367, 13, '242510104', 0.00, 0, '2025-09-01 01:38:54', '2025-09-01 01:38:54'),
(367, 368, 13, '242510105', 0.00, 0, '2025-09-01 01:38:54', '2025-09-01 01:38:54'),
(368, 369, 13, '242510106', 0.00, 0, '2025-09-01 01:38:54', '2025-09-01 01:38:54'),
(369, 370, 13, '242510107', 0.00, 0, '2025-09-01 01:38:55', '2025-09-01 01:38:55'),
(370, 371, 13, '242510108', 0.00, 0, '2025-09-01 01:38:55', '2025-09-01 01:38:55'),
(371, 372, 13, '242510109', 0.00, 0, '2025-09-01 01:38:55', '2025-09-01 01:38:55'),
(372, 373, 13, '242510110', 0.00, 0, '2025-09-01 01:38:55', '2025-09-01 01:38:55'),
(373, 374, 13, '242510111', 0.00, 0, '2025-09-01 01:38:56', '2025-09-01 01:38:56'),
(374, 375, 13, '242510112', 0.00, 0, '2025-09-01 01:38:56', '2025-09-01 01:38:56'),
(375, 376, 13, '242510113', 0.00, 0, '2025-09-01 01:38:56', '2025-09-01 01:38:56'),
(376, 377, 13, '242510114', 0.00, 0, '2025-09-01 01:38:57', '2025-09-01 01:38:57'),
(377, 378, 13, '242510115', 0.00, 0, '2025-09-01 01:38:57', '2025-09-01 01:38:57'),
(378, 379, 13, '242510116', 0.00, 0, '2025-09-01 01:38:57', '2025-09-01 01:38:57'),
(379, 380, 13, '242510117', 0.00, 0, '2025-09-01 01:38:57', '2025-09-01 01:38:57'),
(380, 381, 13, '242510118', 0.00, 0, '2025-09-01 01:38:58', '2025-09-01 01:38:58'),
(381, 382, 13, '242510119', 0.00, 0, '2025-09-01 01:38:58', '2025-09-01 01:38:58'),
(382, 383, 13, '242510120', 0.00, 0, '2025-09-01 01:38:58', '2025-09-01 01:38:58'),
(383, 384, 13, '242510121', 0.00, 0, '2025-09-01 01:38:58', '2025-09-01 01:38:58'),
(384, 385, 13, '242510122', 0.00, 0, '2025-09-01 01:38:59', '2025-09-01 01:38:59'),
(385, 386, 13, '242510123', 0.00, 0, '2025-09-01 01:38:59', '2025-09-01 01:38:59'),
(386, 387, 13, '242510124', 0.00, 0, '2025-09-01 01:38:59', '2025-09-01 01:38:59'),
(387, 388, 14, '242510125', 0.00, 0, '2025-09-01 01:38:59', '2025-09-01 01:38:59'),
(388, 389, 14, '242510126', 0.00, 0, '2025-09-01 01:39:00', '2025-09-01 01:39:00'),
(389, 390, 14, '242510127', 0.00, 0, '2025-09-01 01:39:00', '2025-09-01 01:39:00'),
(390, 391, 14, '242510128', 0.00, 0, '2025-09-01 01:39:00', '2025-09-01 01:39:00'),
(391, 392, 14, '242510129', 0.00, 0, '2025-09-01 01:39:01', '2025-09-01 01:39:01'),
(392, 393, 14, '242510130', 0.00, 0, '2025-09-01 01:39:01', '2025-09-01 01:39:01'),
(393, 394, 14, '242510131', 0.00, 0, '2025-09-01 01:39:01', '2025-09-01 01:39:01'),
(394, 395, 14, '242510132', 0.00, 0, '2025-09-01 01:39:01', '2025-09-01 01:39:01'),
(395, 396, 14, '242510133', 0.00, 0, '2025-09-01 01:39:02', '2025-09-01 01:39:02'),
(396, 397, 14, '242510134', 0.00, 0, '2025-09-01 01:39:02', '2025-09-01 01:39:02'),
(397, 398, 14, '242510135', 0.00, 0, '2025-09-01 01:39:02', '2025-09-01 01:39:02'),
(398, 399, 14, '242510136', 0.00, 0, '2025-09-01 01:39:02', '2025-09-01 01:39:02'),
(399, 400, 14, '242510137', 0.00, 0, '2025-09-01 01:39:03', '2025-09-01 01:39:03'),
(400, 401, 14, '242510138', 0.00, 0, '2025-09-01 01:39:03', '2025-09-01 01:39:03'),
(401, 402, 14, '242510139', 0.00, 0, '2025-09-01 01:39:03', '2025-09-01 01:39:03'),
(402, 403, 14, '242510140', 0.00, 0, '2025-09-01 01:39:03', '2025-09-01 01:39:03'),
(403, 404, 14, '242510141', 0.00, 0, '2025-09-01 01:39:04', '2025-09-01 01:39:04'),
(404, 405, 14, '242510142', 0.00, 0, '2025-09-01 01:39:04', '2025-09-01 01:39:04'),
(405, 406, 14, '242510143', 0.00, 0, '2025-09-01 01:39:04', '2025-09-01 01:39:04'),
(406, 407, 14, '242510144', 0.00, 0, '2025-09-01 01:39:05', '2025-09-01 01:39:05'),
(407, 408, 14, '242510145', 0.00, 0, '2025-09-01 01:39:05', '2025-09-01 01:39:05'),
(408, 409, 14, '242510146', 0.00, 0, '2025-09-01 01:39:05', '2025-09-01 01:39:05'),
(409, 410, 14, '242510147', 0.00, 0, '2025-09-01 01:39:05', '2025-09-01 01:39:05'),
(410, 411, 14, '242510148', 0.00, 0, '2025-09-01 01:39:06', '2025-09-01 01:39:06'),
(411, 412, 14, '242510149', 0.00, 0, '2025-09-01 01:39:06', '2025-09-01 01:39:06'),
(412, 413, 14, '242510150', 0.00, 0, '2025-09-01 01:39:06', '2025-09-01 01:39:06'),
(413, 414, 14, '242510151', 0.00, 0, '2025-09-01 01:39:06', '2025-09-01 01:39:06'),
(414, 415, 14, '242510152', 0.00, 0, '2025-09-01 01:39:07', '2025-09-01 01:39:07'),
(415, 416, 15, '242510153', 0.00, 0, '2025-09-01 01:39:07', '2025-09-01 01:39:07'),
(416, 417, 15, '242510154', 0.00, 0, '2025-09-01 01:39:07', '2025-09-01 01:39:07'),
(417, 418, 15, '242510155', 0.00, 0, '2025-09-01 01:39:07', '2025-09-01 01:39:07'),
(418, 419, 15, '242510156', 0.00, 0, '2025-09-01 01:39:08', '2025-09-01 01:39:08'),
(419, 420, 15, '242510157', 0.00, 0, '2025-09-01 01:39:08', '2025-09-01 01:39:08'),
(420, 421, 15, '242510158', 0.00, 0, '2025-09-01 01:39:08', '2025-09-01 01:39:08'),
(421, 422, 15, '242510159', 0.00, 0, '2025-09-01 01:39:08', '2025-09-01 01:39:08'),
(422, 423, 15, '242510160', 0.00, 0, '2025-09-01 01:39:09', '2025-09-01 01:39:09'),
(423, 424, 15, '242510161', 0.00, 0, '2025-09-01 01:39:09', '2025-09-01 01:39:09'),
(424, 425, 15, '242510162', 0.00, 0, '2025-09-01 01:39:09', '2025-09-01 01:39:09'),
(425, 426, 15, '242510163', 0.00, 0, '2025-09-01 01:39:10', '2025-09-01 01:39:10'),
(426, 427, 15, '242510164', 0.00, 0, '2025-09-01 01:39:10', '2025-09-01 01:39:10'),
(427, 428, 15, '242510165', 0.00, 0, '2025-09-01 01:39:10', '2025-09-01 01:39:10'),
(428, 429, 15, '242510166', 0.00, 0, '2025-09-01 01:39:10', '2025-09-01 01:39:10'),
(429, 430, 15, '242510167', 0.00, 0, '2025-09-01 01:39:11', '2025-09-01 01:39:11'),
(430, 431, 15, '242510168', 0.00, 0, '2025-09-01 01:39:11', '2025-09-01 01:39:11'),
(431, 432, 15, '242510169', 0.00, 0, '2025-09-01 01:39:11', '2025-09-01 01:39:11'),
(432, 433, 15, '242510170', 0.00, 0, '2025-09-01 01:39:11', '2025-09-01 01:39:11'),
(433, 434, 15, '242510171', 0.00, 0, '2025-09-01 01:39:12', '2025-09-01 01:39:12'),
(434, 435, 15, '242510172', 0.00, 0, '2025-09-01 01:39:12', '2025-09-01 01:39:12'),
(435, 436, 15, '242510173', 0.00, 0, '2025-09-01 01:39:12', '2025-09-01 01:39:12'),
(436, 437, 15, '242510174', 0.00, 0, '2025-09-01 01:39:12', '2025-09-01 01:39:12'),
(437, 438, 15, '242510175', 0.00, 0, '2025-09-01 01:39:13', '2025-09-01 01:39:13'),
(438, 439, 15, '242510176', 0.00, 0, '2025-09-01 01:39:13', '2025-09-01 01:39:13'),
(439, 440, 15, '242510177', 0.00, 0, '2025-09-01 01:39:13', '2025-09-01 01:39:13'),
(440, 441, 15, '242510178', 0.00, 0, '2025-09-01 01:39:14', '2025-09-01 01:39:14'),
(441, 442, 16, '242510179', 0.00, 0, '2025-09-01 01:39:14', '2025-09-01 01:39:14'),
(442, 443, 16, '242510180', 0.00, 0, '2025-09-01 01:39:14', '2025-09-01 01:39:14'),
(443, 444, 16, '242510181', 0.00, 0, '2025-09-01 01:39:14', '2025-09-01 01:39:14'),
(444, 445, 16, '242510182', 0.00, 0, '2025-09-01 01:39:15', '2025-09-01 01:39:15'),
(445, 446, 16, '242510183', 0.00, 0, '2025-09-01 01:39:15', '2025-09-01 01:39:15'),
(446, 447, 16, '242510184', 0.00, 0, '2025-09-01 01:39:15', '2025-09-01 01:39:15'),
(447, 448, 16, '242510185', 0.00, 0, '2025-09-01 01:39:15', '2025-09-01 01:39:15'),
(448, 449, 16, '242510186', 0.00, 0, '2025-09-01 01:39:16', '2025-09-01 01:39:16'),
(449, 450, 16, '242510187', 0.00, 0, '2025-09-01 01:39:16', '2025-09-01 01:39:16'),
(450, 451, 16, '242510188', 0.00, 0, '2025-09-01 01:39:16', '2025-09-01 01:39:16'),
(451, 452, 16, '242510189', 0.00, 0, '2025-09-01 01:39:17', '2025-09-01 01:39:17'),
(452, 453, 16, '242510190', 0.00, 0, '2025-09-01 01:39:17', '2025-09-01 01:39:17'),
(453, 454, 16, '242510191', 0.00, 0, '2025-09-01 01:39:17', '2025-09-01 01:39:17'),
(454, 455, 16, '242510192', 0.00, 0, '2025-09-01 01:39:17', '2025-09-01 01:39:17'),
(455, 456, 16, '242510193', 0.00, 0, '2025-09-01 01:39:18', '2025-09-01 01:39:18'),
(456, 457, 16, '242510194', 0.00, 0, '2025-09-01 01:39:18', '2025-09-01 01:39:18'),
(457, 458, 16, '242510195', 0.00, 0, '2025-09-01 01:39:18', '2025-09-01 01:39:18'),
(458, 459, 16, '242510196', 0.00, 0, '2025-09-01 01:39:18', '2025-09-01 01:39:18'),
(459, 460, 16, '242510197', 0.00, 0, '2025-09-01 01:39:19', '2025-09-01 01:39:19'),
(460, 461, 16, '242510198', 0.00, 0, '2025-09-01 01:39:19', '2025-09-01 01:39:19'),
(461, 462, 16, '242510199', 0.00, 0, '2025-09-01 01:39:19', '2025-09-01 01:39:19'),
(462, 463, 16, '242510200', 0.00, 0, '2025-09-01 01:39:26', '2025-09-01 01:39:26'),
(463, 464, 16, '242510201', 0.00, 0, '2025-09-01 01:39:26', '2025-09-01 01:39:26'),
(464, 465, 16, '242510202', 0.00, 0, '2025-09-01 01:39:27', '2025-09-01 01:39:27'),
(465, 466, 16, '242510203', 0.00, 0, '2025-09-01 01:39:27', '2025-09-01 01:39:27'),
(466, 467, 16, '242510204', 0.00, 0, '2025-09-01 01:39:27', '2025-09-01 01:39:27'),
(467, 468, 16, '242510205', 0.00, 0, '2025-09-01 01:39:28', '2025-09-01 01:39:28'),
(468, 469, 16, '242510206', 0.00, 0, '2025-09-01 01:39:28', '2025-09-01 01:39:28'),
(469, 470, 16, '242510207', 0.00, 0, '2025-09-01 01:39:28', '2025-09-01 01:39:28'),
(470, 471, 16, '242510208', 0.00, 0, '2025-09-01 01:39:28', '2025-09-01 01:39:28'),
(471, 472, 16, '242510209', 0.00, 0, '2025-09-01 01:39:29', '2025-09-01 01:39:29'),
(472, 473, 16, '242510210', 0.00, 0, '2025-09-01 01:39:29', '2025-09-01 01:39:29'),
(473, 474, 17, '242510211', 0.00, 0, '2025-09-01 01:39:29', '2025-09-01 01:39:29'),
(474, 475, 17, '242510212', 0.00, 0, '2025-09-01 01:39:30', '2025-09-01 01:39:30'),
(475, 476, 17, '242510213', 0.00, 0, '2025-09-01 01:39:30', '2025-09-01 01:39:30'),
(476, 477, 17, '242510214', 0.00, 0, '2025-09-01 01:39:30', '2025-09-01 01:39:30'),
(477, 478, 17, '242510215', 0.00, 0, '2025-09-01 01:39:30', '2025-09-01 01:39:30'),
(478, 479, 17, '242510216', 0.00, 0, '2025-09-01 01:39:31', '2025-09-01 01:39:31'),
(479, 480, 17, '242510217', 0.00, 0, '2025-09-01 01:39:31', '2025-09-01 01:39:31'),
(480, 481, 17, '242510218', 0.00, 0, '2025-09-01 01:39:31', '2025-09-01 01:39:31'),
(481, 482, 17, '242510219', 0.00, 0, '2025-09-01 01:39:32', '2025-09-01 01:39:32'),
(482, 483, 17, '242510220', 0.00, 0, '2025-09-01 01:39:32', '2025-09-01 01:39:32'),
(483, 484, 17, '242510221', 0.00, 0, '2025-09-01 01:39:32', '2025-09-01 01:39:32'),
(484, 485, 17, '242510222', 0.00, 0, '2025-09-01 01:39:32', '2025-09-01 01:39:32'),
(485, 486, 17, '242510223', 0.00, 0, '2025-09-01 01:39:33', '2025-09-01 01:39:33'),
(486, 487, 17, '242510224', 0.00, 0, '2025-09-01 01:39:33', '2025-09-01 01:39:33'),
(487, 488, 17, '242510225', 0.00, 0, '2025-09-01 01:39:33', '2025-09-01 01:39:33'),
(488, 489, 17, '242510226', 0.00, 0, '2025-09-01 01:39:33', '2025-09-01 01:39:33'),
(489, 490, 17, '242510227', 0.00, 0, '2025-09-01 01:39:34', '2025-09-01 01:39:34'),
(490, 491, 17, '242510228', 0.00, 0, '2025-09-01 01:39:34', '2025-09-01 01:39:34'),
(491, 492, 17, '242510229', 0.00, 0, '2025-09-01 01:39:34', '2025-09-01 01:39:34'),
(492, 493, 17, '242510230', 0.00, 0, '2025-09-01 01:39:35', '2025-09-01 01:39:35'),
(493, 494, 17, '242510231', 0.00, 0, '2025-09-01 01:39:35', '2025-09-01 01:39:35'),
(494, 495, 17, '242510232', 0.00, 0, '2025-09-01 01:39:35', '2025-09-01 01:39:35'),
(495, 496, 17, '242510233', 0.00, 0, '2025-09-01 01:39:35', '2025-09-01 01:39:35'),
(496, 497, 17, '242510234', 0.00, 0, '2025-09-01 01:39:36', '2025-09-01 01:39:36'),
(497, 498, 17, '242510235', 0.00, 0, '2025-09-01 01:39:36', '2025-09-01 01:39:36'),
(498, 499, 17, '242510236', 0.00, 0, '2025-09-01 01:39:36', '2025-09-01 01:39:36'),
(499, 500, 18, '242510237', 0.00, 0, '2025-09-01 01:39:36', '2025-09-01 01:39:36'),
(500, 501, 18, '242510238', 0.00, 0, '2025-09-01 01:39:37', '2025-09-01 01:39:37'),
(501, 502, 18, '242510239', 0.00, 0, '2025-09-01 01:39:37', '2025-09-01 01:39:37'),
(502, 503, 18, '242510240', 0.00, 0, '2025-09-01 01:39:37', '2025-09-01 01:39:37'),
(503, 504, 18, '242510241', 0.00, 0, '2025-09-01 01:39:37', '2025-09-01 01:39:37'),
(504, 505, 18, '242510242', 0.00, 0, '2025-09-01 01:39:38', '2025-09-01 01:39:38'),
(505, 506, 18, '242510243', 0.00, 0, '2025-09-01 01:39:38', '2025-09-01 01:39:38'),
(506, 507, 18, '242510244', 0.00, 0, '2025-09-01 01:39:38', '2025-09-01 01:39:38'),
(507, 508, 18, '242510245', 0.00, 0, '2025-09-01 01:39:38', '2025-09-01 01:39:38'),
(508, 509, 18, '242510246', 0.00, 0, '2025-09-01 01:39:39', '2025-09-01 01:39:39'),
(509, 510, 18, '242510247', 0.00, 0, '2025-09-01 01:39:39', '2025-09-01 01:39:39'),
(510, 511, 18, '242510248', 0.00, 0, '2025-09-01 01:39:39', '2025-09-01 01:39:39'),
(511, 512, 18, '242510249', 0.00, 0, '2025-09-01 01:39:40', '2025-09-01 01:39:40'),
(512, 513, 18, '242510250', 0.00, 0, '2025-09-01 01:39:40', '2025-09-01 01:39:40'),
(513, 514, 18, '242510251', 0.00, 0, '2025-09-01 01:39:40', '2025-09-01 01:39:40'),
(514, 515, 18, '242510252', 0.00, 0, '2025-09-01 01:39:40', '2025-09-01 01:39:40'),
(515, 516, 18, '242510253', 0.00, 0, '2025-09-01 01:39:41', '2025-09-01 01:39:41'),
(516, 517, 18, '242510254', 0.00, 0, '2025-09-01 01:39:41', '2025-09-01 01:39:41'),
(517, 518, 18, '242510255', 0.00, 0, '2025-09-01 01:39:41', '2025-09-01 01:39:41'),
(518, 519, 18, '242510256', 0.00, 0, '2025-09-01 01:39:41', '2025-09-01 01:39:41'),
(519, 520, 18, '242510257', 0.00, 0, '2025-09-01 01:39:42', '2025-09-01 01:39:42'),
(520, 521, 18, '242510258', 0.00, 0, '2025-09-01 01:39:42', '2025-09-01 01:39:42'),
(521, 522, 18, '242510259', 0.00, 0, '2025-09-01 01:39:42', '2025-09-01 01:39:42'),
(522, 523, 18, '242510260', 0.00, 0, '2025-09-01 01:39:42', '2025-09-01 01:39:42'),
(523, 524, 18, '242510261', 0.00, 0, '2025-09-01 01:39:43', '2025-09-01 01:39:43'),
(524, 525, 18, '242510262', 0.00, 0, '2025-09-01 01:39:43', '2025-09-01 01:39:43'),
(525, 526, 18, '242510263', 0.00, 0, '2025-09-01 01:39:43', '2025-09-01 01:39:43'),
(526, 527, 18, '242510264', 0.00, 0, '2025-09-01 01:39:44', '2025-09-01 01:39:44'),
(527, 528, 19, '232410001', 0.00, 0, '2025-09-01 01:40:03', '2025-09-01 01:40:03'),
(528, 529, 19, '232410002', 0.00, 0, '2025-09-01 01:40:03', '2025-09-01 01:40:03'),
(529, 530, 19, '232410003', 0.00, 0, '2025-09-01 01:40:03', '2025-09-01 01:40:03'),
(530, 531, 19, '232410004', 0.00, 0, '2025-09-01 01:40:03', '2025-09-01 01:40:03'),
(531, 532, 19, '232410005', 0.00, 0, '2025-09-01 01:40:04', '2025-09-01 01:40:04'),
(532, 533, 19, '232410006', 0.00, 0, '2025-09-01 01:40:04', '2025-09-01 01:40:04'),
(533, 534, 19, '232410007', 0.00, 0, '2025-09-01 01:40:04', '2025-09-01 01:40:04'),
(534, 535, 19, '232410008', 0.00, 0, '2025-09-01 01:40:04', '2025-09-01 01:40:04'),
(535, 536, 19, '232410009', 0.00, 0, '2025-09-01 01:40:05', '2025-09-01 01:40:05'),
(536, 537, 19, '232410010', 0.00, 0, '2025-09-01 01:40:05', '2025-09-01 01:40:05'),
(537, 538, 19, '232410011', 0.00, 0, '2025-09-01 01:40:05', '2025-09-01 01:40:05'),
(538, 539, 19, '232410012', 0.00, 0, '2025-09-01 01:40:05', '2025-09-01 01:40:05'),
(539, 540, 19, '232410013', 0.00, 0, '2025-09-01 01:40:06', '2025-09-01 01:40:06'),
(540, 541, 19, '232410014', 0.00, 0, '2025-09-01 01:40:06', '2025-09-01 01:40:06'),
(541, 542, 19, '232410015', 0.00, 0, '2025-09-01 01:40:06', '2025-09-01 01:40:06'),
(542, 543, 19, '232410016', 0.00, 0, '2025-09-01 01:40:07', '2025-09-01 01:40:07'),
(543, 544, 19, '232410017', 0.00, 0, '2025-09-01 01:40:07', '2025-09-01 01:40:07'),
(544, 545, 19, '232410018', 0.00, 0, '2025-09-01 01:40:07', '2025-09-01 01:40:07'),
(545, 546, 19, '232410019', 0.00, 0, '2025-09-01 01:40:07', '2025-09-01 01:40:07'),
(546, 547, 19, '232410020', 0.00, 0, '2025-09-01 01:40:08', '2025-09-01 01:40:08'),
(547, 548, 19, '232410021', 0.00, 0, '2025-09-01 01:40:08', '2025-09-01 01:40:08'),
(548, 549, 19, '232410022', 0.00, 0, '2025-09-01 01:40:08', '2025-09-01 01:40:08'),
(549, 550, 19, '232410023', 0.00, 0, '2025-09-01 01:40:08', '2025-09-01 01:40:08'),
(550, 551, 19, '232410024', 0.00, 0, '2025-09-01 01:40:09', '2025-09-01 01:40:09'),
(551, 552, 19, '232410025', 0.00, 0, '2025-09-01 01:40:09', '2025-09-01 01:40:09'),
(552, 553, 19, '232410026', 0.00, 0, '2025-09-01 01:40:09', '2025-09-01 01:40:09'),
(553, 554, 20, '232410027', 0.00, 0, '2025-09-01 01:40:09', '2025-09-01 01:40:09'),
(554, 555, 20, '232410028', 0.00, 0, '2025-09-01 01:40:10', '2025-09-01 01:40:10'),
(555, 556, 20, '232410029', 0.00, 0, '2025-09-01 01:40:10', '2025-09-01 01:40:10'),
(556, 557, 20, '232410030', 0.00, 0, '2025-09-01 01:40:10', '2025-09-01 01:40:10'),
(557, 558, 20, '232410031', 0.00, 0, '2025-09-01 01:40:10', '2025-09-01 01:40:10'),
(558, 559, 20, '232410032', 0.00, 0, '2025-09-01 01:40:11', '2025-09-01 01:40:11'),
(559, 560, 20, '232410033', 0.00, 0, '2025-09-01 01:40:11', '2025-09-01 01:40:11'),
(560, 561, 20, '232410034', 0.00, 0, '2025-09-01 01:40:11', '2025-09-01 01:40:11'),
(561, 562, 20, '232410035', 0.00, 0, '2025-09-01 01:40:12', '2025-09-01 01:40:12'),
(562, 563, 20, '232410036', 0.00, 0, '2025-09-01 01:40:12', '2025-09-01 01:40:12'),
(563, 564, 20, '232410037', 0.00, 0, '2025-09-01 01:40:12', '2025-09-01 01:40:12'),
(564, 565, 20, '232410038', 0.00, 0, '2025-09-01 01:40:12', '2025-09-01 01:40:12'),
(565, 566, 20, '232410039', 0.00, 0, '2025-09-01 01:40:13', '2025-09-01 01:40:13'),
(566, 567, 20, '232410040', 0.00, 0, '2025-09-01 01:40:13', '2025-09-01 01:40:13'),
(567, 568, 20, '232410041', 0.00, 0, '2025-09-01 01:40:13', '2025-09-01 01:40:13'),
(568, 569, 20, '232410042', 0.00, 0, '2025-09-01 01:40:13', '2025-09-01 01:40:13'),
(569, 570, 20, '232410043', 0.00, 0, '2025-09-01 01:40:14', '2025-09-01 01:40:14'),
(570, 571, 20, '232410044', 0.00, 0, '2025-09-01 01:40:14', '2025-09-01 01:40:14'),
(571, 572, 20, '232410045', 0.00, 0, '2025-09-01 01:40:14', '2025-09-01 01:40:14'),
(572, 573, 20, '232410046', 0.00, 0, '2025-09-01 01:40:14', '2025-09-01 01:40:14'),
(573, 574, 20, '232410047', 0.00, 0, '2025-09-01 01:40:15', '2025-09-01 01:40:15'),
(574, 575, 20, '232410048', 0.00, 0, '2025-09-01 01:40:15', '2025-09-01 01:40:15'),
(575, 576, 20, '232410049', 0.00, 0, '2025-09-01 01:40:15', '2025-09-01 01:40:15'),
(576, 577, 20, '232410050', 0.00, 0, '2025-09-01 01:40:16', '2025-09-01 01:40:16'),
(577, 578, 20, '232410051', 0.00, 0, '2025-09-01 01:40:16', '2025-09-01 01:40:16'),
(578, 579, 21, '232410052', 0.00, 0, '2025-09-01 01:40:16', '2025-09-01 01:40:16'),
(579, 580, 21, '232410053', 0.00, 0, '2025-09-01 01:40:16', '2025-09-01 01:40:16'),
(580, 581, 21, '232410054', 0.00, 0, '2025-09-01 01:40:17', '2025-09-01 01:40:17'),
(581, 582, 21, '232410055', 0.00, 0, '2025-09-01 01:40:17', '2025-09-01 01:40:17'),
(582, 583, 21, '232410056', 0.00, 0, '2025-09-01 01:40:17', '2025-09-01 01:40:17'),
(583, 584, 21, '232410057', 0.00, 0, '2025-09-01 01:40:17', '2025-09-01 01:40:17'),
(584, 585, 21, '232410058', 0.00, 0, '2025-09-01 01:40:18', '2025-09-01 01:40:18'),
(585, 586, 21, '232410059', 0.00, 0, '2025-09-01 01:40:18', '2025-09-01 01:40:18'),
(586, 587, 21, '232410060', 0.00, 0, '2025-09-01 01:40:18', '2025-09-01 01:40:18'),
(587, 588, 21, '232410061', 0.00, 0, '2025-09-01 01:40:19', '2025-09-01 01:40:19'),
(588, 589, 21, '232410062', 0.00, 0, '2025-09-01 01:40:19', '2025-09-01 01:40:19'),
(589, 590, 21, '232410063', 0.00, 0, '2025-09-01 01:40:19', '2025-09-01 01:40:19'),
(590, 591, 21, '232410064', 0.00, 0, '2025-09-01 01:40:19', '2025-09-01 01:40:19'),
(591, 592, 21, '232410065', 0.00, 0, '2025-09-01 01:40:20', '2025-09-01 01:40:20'),
(592, 593, 21, '232410066', 0.00, 0, '2025-09-01 01:40:20', '2025-09-01 01:40:20'),
(593, 594, 21, '232410067', 0.00, 0, '2025-09-01 01:40:20', '2025-09-01 01:40:20'),
(594, 595, 21, '232410068', 0.00, 0, '2025-09-01 01:40:20', '2025-09-01 01:40:20'),
(595, 596, 21, '232410069', 0.00, 0, '2025-09-01 01:40:21', '2025-09-01 01:40:21'),
(596, 597, 21, '232410070', 0.00, 0, '2025-09-01 01:40:21', '2025-09-01 01:40:21'),
(597, 598, 21, '232410071', 0.00, 0, '2025-09-01 01:40:21', '2025-09-01 01:40:21'),
(598, 599, 21, '232410072', 0.00, 0, '2025-09-01 01:40:21', '2025-09-01 01:40:21'),
(599, 600, 21, '232410073', 0.00, 0, '2025-09-01 01:40:22', '2025-09-01 01:40:22'),
(600, 601, 21, '232410074', 0.00, 0, '2025-09-01 01:40:22', '2025-09-01 01:40:22'),
(601, 602, 21, '232410075', 0.00, 0, '2025-09-01 01:40:22', '2025-09-01 01:40:22'),
(602, 603, 21, '232410076', 0.00, 0, '2025-09-01 01:40:23', '2025-09-01 01:40:23'),
(603, 604, 21, '232410077', 0.00, 0, '2025-09-01 01:40:23', '2025-09-01 01:40:23'),
(604, 605, 21, '232410078', 0.00, 0, '2025-09-01 01:40:23', '2025-09-01 01:40:23'),
(605, 606, 21, '232410079', 0.00, 0, '2025-09-01 01:40:23', '2025-09-01 01:40:23'),
(606, 607, 21, '232410080', 0.00, 0, '2025-09-01 01:40:24', '2025-09-01 01:40:24'),
(607, 608, 21, '232410081', 0.00, 0, '2025-09-01 01:40:24', '2025-09-01 01:40:24'),
(608, 609, 21, '232410082', 0.00, 0, '2025-09-01 01:40:24', '2025-09-01 01:40:24'),
(609, 610, 21, '232410083', 0.00, 0, '2025-09-01 01:40:24', '2025-09-01 01:40:24'),
(610, 611, 21, '232410084', 0.00, 0, '2025-09-01 01:40:25', '2025-09-01 01:40:25'),
(611, 612, 22, '232410085', 0.00, 0, '2025-09-01 01:40:25', '2025-09-01 01:40:25'),
(612, 613, 22, '232410086', 0.00, 0, '2025-09-01 01:40:25', '2025-09-01 01:40:25'),
(613, 614, 22, '232410087', 0.00, 0, '2025-09-01 01:40:26', '2025-09-01 01:40:26'),
(614, 615, 22, '232410088', 0.00, 0, '2025-09-01 01:40:26', '2025-09-01 01:40:26');
INSERT INTO `siswa` (`id`, `id_pengguna`, `id_kelas`, `nis`, `saldo`, `points`, `created_at`, `updated_at`) VALUES
(615, 616, 22, '232410089', 0.00, 0, '2025-09-01 01:40:26', '2025-09-01 01:40:26'),
(616, 617, 22, '232410090', 0.00, 0, '2025-09-01 01:40:27', '2025-09-01 01:40:27'),
(617, 618, 22, '232410091', 0.00, 0, '2025-09-01 01:40:27', '2025-09-01 01:40:27'),
(618, 619, 22, '232410092', 0.00, 0, '2025-09-01 01:40:28', '2025-09-01 01:40:28'),
(619, 620, 22, '232410093', 0.00, 0, '2025-09-01 01:40:28', '2025-09-01 01:40:28'),
(620, 621, 22, '232410094', 0.00, 0, '2025-09-01 01:40:28', '2025-09-01 01:40:28'),
(621, 622, 22, '232410095', 0.00, 0, '2025-09-01 01:40:29', '2025-09-01 01:40:29'),
(622, 623, 22, '232410096', 0.00, 0, '2025-09-01 01:40:29', '2025-09-01 01:40:29'),
(623, 624, 22, '232410097', 0.00, 0, '2025-09-01 01:40:30', '2025-09-01 01:40:30'),
(624, 625, 22, '232410098', 0.00, 0, '2025-09-01 01:40:30', '2025-09-01 01:40:30'),
(625, 626, 22, '232410099', 0.00, 0, '2025-09-01 01:40:30', '2025-09-01 01:40:30'),
(626, 627, 22, '232410100', 0.00, 0, '2025-09-01 01:40:31', '2025-09-01 01:40:31'),
(627, 628, 22, '232410101', 0.00, 0, '2025-09-01 01:40:31', '2025-09-01 01:40:31'),
(628, 629, 22, '232410102', 0.00, 0, '2025-09-01 01:40:31', '2025-09-01 01:40:31'),
(629, 630, 22, '232410103', 0.00, 0, '2025-09-01 01:40:32', '2025-09-01 01:40:32'),
(630, 631, 22, '232410104', 0.00, 0, '2025-09-01 01:40:32', '2025-09-01 01:40:32'),
(631, 632, 22, '232410105', 0.00, 0, '2025-09-01 01:40:32', '2025-09-01 01:40:32'),
(632, 633, 22, '232410106', 0.00, 0, '2025-09-01 01:40:33', '2025-09-01 01:40:33'),
(633, 634, 22, '232410107', 0.00, 0, '2025-09-01 01:40:33', '2025-09-01 01:40:33'),
(634, 635, 22, '232410108', 0.00, 0, '2025-09-01 01:40:33', '2025-09-01 01:40:33'),
(635, 636, 22, '232410109', 0.00, 0, '2025-09-01 01:40:34', '2025-09-01 01:40:34'),
(636, 637, 22, '232410110', 0.00, 0, '2025-09-01 01:40:34', '2025-09-01 01:40:34'),
(637, 638, 22, '232410111', 0.00, 0, '2025-09-01 01:40:34', '2025-09-01 01:40:34'),
(638, 639, 22, '232410112', 0.00, 0, '2025-09-01 01:40:35', '2025-09-01 01:40:35'),
(639, 640, 22, '232410113', 0.00, 0, '2025-09-01 01:40:35', '2025-09-01 01:40:35'),
(640, 641, 22, '232410114', 0.00, 0, '2025-09-01 01:40:35', '2025-09-01 01:40:35'),
(641, 642, 22, '232410115', 0.00, 0, '2025-09-01 01:40:35', '2025-09-01 01:40:35'),
(642, 643, 22, '232410116', 0.00, 0, '2025-09-01 01:40:36', '2025-09-01 01:40:36'),
(643, 644, 22, '232410117', 0.00, 0, '2025-09-01 01:40:36', '2025-09-01 01:40:36'),
(644, 645, 22, '232410118', 0.00, 0, '2025-09-01 01:40:36', '2025-09-01 01:40:36'),
(645, 646, 23, '232410119', 0.00, 0, '2025-09-01 01:40:37', '2025-09-01 01:40:37'),
(646, 647, 23, '232410120', 0.00, 0, '2025-09-01 01:40:37', '2025-09-01 01:40:37'),
(647, 648, 23, '232410121', 0.00, 0, '2025-09-01 01:40:37', '2025-09-01 01:40:37'),
(648, 649, 23, '232410122', 0.00, 0, '2025-09-01 01:40:37', '2025-09-01 01:40:37'),
(649, 650, 23, '232410123', 0.00, 0, '2025-09-01 01:40:38', '2025-09-01 01:40:38'),
(650, 651, 23, '232410124', 0.00, 0, '2025-09-01 01:40:38', '2025-09-01 01:40:38'),
(651, 652, 23, '232410125', 0.00, 0, '2025-09-01 01:40:38', '2025-09-01 01:40:38'),
(652, 653, 23, '232410126', 0.00, 0, '2025-09-01 01:40:39', '2025-09-01 01:40:39'),
(653, 654, 23, '232410127', 0.00, 0, '2025-09-01 01:40:39', '2025-09-01 01:40:39'),
(654, 655, 23, '232410128', 0.00, 0, '2025-09-01 01:40:39', '2025-09-01 01:40:39'),
(655, 656, 23, '232410129', 0.00, 0, '2025-09-01 01:40:39', '2025-09-01 01:40:39'),
(656, 657, 23, '232410130', 0.00, 0, '2025-09-01 01:40:40', '2025-09-01 01:40:40'),
(657, 658, 23, '232410131', 0.00, 0, '2025-09-01 01:40:40', '2025-09-01 01:40:40'),
(658, 659, 23, '232410132', 0.00, 0, '2025-09-01 01:40:40', '2025-09-01 01:40:40'),
(659, 660, 23, '232410133', 0.00, 0, '2025-09-01 01:40:41', '2025-09-01 01:40:41'),
(660, 661, 23, '232410134', 0.00, 0, '2025-09-01 01:40:41', '2025-09-01 01:40:41'),
(661, 662, 23, '232410135', 0.00, 0, '2025-09-01 01:40:41', '2025-09-01 01:40:41'),
(662, 663, 23, '232410136', 0.00, 0, '2025-09-01 01:40:41', '2025-09-01 01:40:41'),
(663, 664, 23, '232410137', 0.00, 0, '2025-09-01 01:40:42', '2025-09-01 01:40:42'),
(664, 665, 23, '232410138', 0.00, 0, '2025-09-01 01:40:42', '2025-09-01 01:40:42'),
(665, 666, 23, '232410139', 0.00, 0, '2025-09-01 01:40:42', '2025-09-01 01:40:42'),
(666, 667, 23, '232410140', 0.00, 0, '2025-09-01 01:40:43', '2025-09-01 01:40:43'),
(667, 668, 23, '232410141', 0.00, 0, '2025-09-01 01:40:43', '2025-09-01 01:40:43'),
(668, 669, 23, '232410142', 0.00, 0, '2025-09-01 01:40:43', '2025-09-01 01:40:43'),
(669, 670, 23, '232410143', 0.00, 0, '2025-09-01 01:40:44', '2025-09-01 01:40:44'),
(670, 671, 23, '232410144', 0.00, 0, '2025-09-01 01:40:44', '2025-09-01 01:40:44'),
(671, 672, 23, '232410145', 0.00, 0, '2025-09-01 01:40:44', '2025-09-01 01:40:44'),
(672, 673, 23, '232410146', 0.00, 0, '2025-09-01 01:40:44', '2025-09-01 01:40:44'),
(673, 674, 23, '232410147', 0.00, 0, '2025-09-01 01:40:45', '2025-09-01 01:40:45'),
(674, 675, 23, '232410148', 0.00, 0, '2025-09-01 01:40:45', '2025-09-01 01:40:45'),
(675, 676, 23, '232410149', 0.00, 0, '2025-09-01 01:40:45', '2025-09-01 01:40:45'),
(676, 677, 23, '232410150', 0.00, 0, '2025-09-01 01:40:46', '2025-09-01 01:40:46'),
(677, 678, 23, '232410151', 0.00, 0, '2025-09-01 01:40:46', '2025-09-01 01:40:46'),
(678, 679, 23, '232410152', 0.00, 0, '2025-09-01 01:40:46', '2025-09-01 01:40:46'),
(679, 680, 23, '232410153', 0.00, 0, '2025-09-01 01:40:46', '2025-09-01 01:40:46'),
(680, 681, 24, '232410154', 0.00, 0, '2025-09-01 01:40:47', '2025-09-01 01:40:47'),
(681, 682, 24, '232410155', 0.00, 0, '2025-09-01 01:40:47', '2025-09-01 01:40:47'),
(682, 683, 24, '232410156', 0.00, 0, '2025-09-01 01:40:47', '2025-09-01 01:40:47'),
(683, 684, 24, '232410157', 0.00, 0, '2025-09-01 01:40:48', '2025-09-01 01:40:48'),
(684, 685, 24, '232410158', 0.00, 0, '2025-09-01 01:40:48', '2025-09-01 01:40:48'),
(685, 686, 24, '232410159', 0.00, 0, '2025-09-01 01:40:48', '2025-09-01 01:40:48'),
(686, 687, 24, '232410160', 0.00, 0, '2025-09-01 01:40:48', '2025-09-01 01:40:48'),
(687, 688, 24, '232410161', 0.00, 0, '2025-09-01 01:40:49', '2025-09-01 01:40:49'),
(688, 689, 24, '232410162', 0.00, 0, '2025-09-01 01:40:49', '2025-09-01 01:40:49'),
(689, 690, 24, '232410163', 0.00, 0, '2025-09-01 01:40:49', '2025-09-01 01:40:49'),
(690, 691, 24, '232410164', 0.00, 0, '2025-09-01 01:40:50', '2025-09-01 01:40:50'),
(691, 692, 24, '232410165', 0.00, 0, '2025-09-01 01:40:50', '2025-09-01 01:40:50'),
(692, 693, 24, '232410166', 0.00, 0, '2025-09-01 01:40:50', '2025-09-01 01:40:50'),
(693, 694, 24, '232410167', 0.00, 0, '2025-09-01 01:40:51', '2025-09-01 01:40:51'),
(694, 695, 24, '232410168', 0.00, 0, '2025-09-01 01:40:51', '2025-09-01 01:40:51'),
(695, 696, 24, '232410169', 0.00, 0, '2025-09-01 01:40:51', '2025-09-01 01:40:51'),
(696, 697, 24, '232410170', 0.00, 0, '2025-09-01 01:40:51', '2025-09-01 01:40:51'),
(697, 698, 24, '232410171', 0.00, 0, '2025-09-01 01:40:52', '2025-09-01 01:40:52'),
(698, 699, 24, '232410172', 0.00, 0, '2025-09-01 01:40:52', '2025-09-01 01:40:52'),
(699, 700, 24, '232410173', 0.00, 0, '2025-09-01 01:40:52', '2025-09-01 01:40:52'),
(700, 701, 24, '232410174', 0.00, 0, '2025-09-01 01:40:53', '2025-09-01 01:40:53'),
(701, 702, 24, '232410175', 0.00, 0, '2025-09-01 01:40:53', '2025-09-01 01:40:53'),
(702, 703, 24, '232410176', 0.00, 0, '2025-09-01 01:40:53', '2025-09-01 01:40:53'),
(703, 704, 24, '232410177', 0.00, 0, '2025-09-01 01:40:53', '2025-09-01 01:40:53'),
(704, 705, 24, '232410178', 0.00, 0, '2025-09-01 01:40:54', '2025-09-01 01:40:54'),
(705, 706, 24, '232410179', 0.00, 0, '2025-09-01 01:40:54', '2025-09-01 01:40:54'),
(706, 707, 24, '232410180', 0.00, 0, '2025-09-01 01:40:54', '2025-09-01 01:40:54'),
(707, 708, 24, '232410181', 0.00, 0, '2025-09-01 01:40:55', '2025-09-01 01:40:55'),
(708, 709, 24, '232410182', 0.00, 0, '2025-09-01 01:40:55', '2025-09-01 01:40:55'),
(709, 710, 24, '232410183', 0.00, 0, '2025-09-01 01:40:55', '2025-09-01 01:40:55'),
(710, 711, 24, '232410184', 0.00, 0, '2025-09-01 01:40:56', '2025-09-01 01:40:56'),
(711, 712, 24, '232410185', 0.00, 0, '2025-09-01 01:40:56', '2025-09-01 01:40:56'),
(712, 713, 24, '232410186', 0.00, 0, '2025-09-01 01:40:56', '2025-09-01 01:40:56'),
(713, 714, 24, '232410187', 0.00, 0, '2025-09-01 01:40:56', '2025-09-01 01:40:56'),
(714, 715, 25, '232410188', 0.00, 0, '2025-09-01 01:40:57', '2025-09-01 01:40:57'),
(715, 716, 25, '232410189', 0.00, 0, '2025-09-01 01:40:57', '2025-09-01 01:40:57'),
(716, 717, 25, '232410190', 0.00, 0, '2025-09-01 01:40:57', '2025-09-01 01:40:57'),
(717, 718, 25, '232410191', 0.00, 0, '2025-09-01 01:40:58', '2025-09-01 01:40:58'),
(718, 719, 25, '232410192', 0.00, 0, '2025-09-01 01:40:58', '2025-09-01 01:40:58'),
(719, 720, 25, '232410193', 0.00, 0, '2025-09-01 01:40:58', '2025-09-01 01:40:58'),
(720, 721, 25, '232410194', 0.00, 0, '2025-09-01 01:40:58', '2025-09-01 01:40:58'),
(721, 722, 25, '232410195', 0.00, 0, '2025-09-01 01:40:59', '2025-09-01 01:40:59'),
(722, 723, 25, '232410196', 0.00, 0, '2025-09-01 01:40:59', '2025-09-01 01:40:59'),
(723, 724, 25, '232410197', 0.00, 0, '2025-09-01 01:40:59', '2025-09-01 01:40:59'),
(724, 725, 25, '232410198', 0.00, 0, '2025-09-01 01:40:59', '2025-09-01 01:40:59'),
(725, 726, 25, '232410199', 0.00, 0, '2025-09-01 01:41:00', '2025-09-01 01:41:00'),
(726, 727, 25, '232410200', 0.00, 0, '2025-09-01 01:41:08', '2025-09-01 01:41:08'),
(727, 728, 25, '232410201', 0.00, 0, '2025-09-01 01:41:09', '2025-09-01 01:41:09'),
(728, 729, 25, '232410202', 0.00, 0, '2025-09-01 01:41:09', '2025-09-01 01:41:09'),
(729, 730, 25, '232410203', 0.00, 0, '2025-09-01 01:41:09', '2025-09-01 01:41:09'),
(730, 731, 25, '232410204', 0.00, 0, '2025-09-01 01:41:09', '2025-09-01 01:41:09'),
(731, 732, 25, '232410205', 0.00, 0, '2025-09-01 01:41:10', '2025-09-01 01:41:10'),
(732, 733, 25, '232410206', 0.00, 0, '2025-09-01 01:41:10', '2025-09-01 01:41:10'),
(733, 734, 25, '232410207', 0.00, 0, '2025-09-01 01:41:10', '2025-09-01 01:41:10'),
(734, 735, 25, '232410208', 0.00, 0, '2025-09-01 01:41:11', '2025-09-01 01:41:11'),
(735, 736, 25, '232410209', 0.00, 0, '2025-09-01 01:41:11', '2025-09-01 01:41:11'),
(736, 737, 25, '232410210', 0.00, 0, '2025-09-01 01:41:11', '2025-09-01 01:41:11'),
(737, 738, 25, '232410211', 0.00, 0, '2025-09-01 01:41:12', '2025-09-01 01:41:12'),
(738, 739, 25, '232410212', 0.00, 0, '2025-09-01 01:41:12', '2025-09-01 01:41:12'),
(739, 740, 25, '232410213', 0.00, 0, '2025-09-01 01:41:12', '2025-09-01 01:41:12'),
(740, 741, 25, '232410214', 0.00, 0, '2025-09-01 01:41:12', '2025-09-01 01:41:12'),
(741, 742, 25, '232410215', 0.00, 0, '2025-09-01 01:41:13', '2025-09-01 01:41:13'),
(742, 743, 25, '232410216', 0.00, 0, '2025-09-01 01:41:13', '2025-09-01 01:41:13'),
(743, 744, 25, '232410217', 0.00, 0, '2025-09-01 01:41:13', '2025-09-01 01:41:13'),
(744, 745, 25, '232410218', 0.00, 0, '2025-09-01 01:41:14', '2025-09-01 01:41:14'),
(745, 746, 25, '232410219', 0.00, 0, '2025-09-01 01:41:14', '2025-09-01 01:41:14'),
(746, 747, 26, '232410220', 0.00, 0, '2025-09-01 01:41:14', '2025-09-01 01:41:14'),
(747, 748, 26, '232410221', 0.00, 0, '2025-09-01 01:41:14', '2025-09-01 01:41:14'),
(748, 749, 26, '232410222', 0.00, 0, '2025-09-01 01:41:15', '2025-09-01 01:41:15'),
(749, 750, 26, '232410223', 0.00, 0, '2025-09-01 01:41:15', '2025-09-01 01:41:15'),
(750, 751, 26, '232410224', 0.00, 0, '2025-09-01 01:41:15', '2025-09-01 01:41:15'),
(751, 752, 26, '232410225', 0.00, 0, '2025-09-01 01:41:16', '2025-09-01 01:41:16'),
(752, 753, 26, '232410226', 0.00, 0, '2025-09-01 01:41:16', '2025-09-01 01:41:16'),
(753, 754, 26, '232410227', 0.00, 0, '2025-09-01 01:41:16', '2025-09-01 01:41:16'),
(754, 755, 26, '232410228', 0.00, 0, '2025-09-01 01:41:17', '2025-09-01 01:41:17'),
(755, 756, 26, '232410229', 0.00, 0, '2025-09-01 01:41:17', '2025-09-01 01:41:17'),
(756, 757, 26, '232410230', 0.00, 0, '2025-09-01 01:41:17', '2025-09-01 01:41:17'),
(757, 758, 26, '232410231', 0.00, 0, '2025-09-01 01:41:17', '2025-09-01 01:41:17'),
(758, 759, 26, '232410232', 0.00, 0, '2025-09-01 01:41:18', '2025-09-01 01:41:18'),
(759, 760, 26, '232410233', 0.00, 0, '2025-09-01 01:41:18', '2025-09-01 01:41:18'),
(760, 761, 26, '232410234', 0.00, 0, '2025-09-01 01:41:18', '2025-09-01 01:41:18'),
(761, 762, 26, '232410235', 0.00, 0, '2025-09-01 01:41:18', '2025-09-01 01:41:18'),
(762, 763, 26, '232410236', 0.00, 0, '2025-09-01 01:41:19', '2025-09-01 01:41:19'),
(763, 764, 26, '232410237', 0.00, 0, '2025-09-01 01:41:19', '2025-09-01 01:41:19'),
(764, 765, 26, '232410238', 0.00, 0, '2025-09-01 01:41:19', '2025-09-01 01:41:19'),
(765, 766, 26, '232410239', 0.00, 0, '2025-09-01 01:41:20', '2025-09-01 01:41:20'),
(766, 767, 26, '232410240', 0.00, 0, '2025-09-01 01:41:20', '2025-09-01 01:41:20'),
(767, 768, 26, '232410241', 0.00, 0, '2025-09-01 01:41:20', '2025-09-01 01:41:20'),
(768, 769, 26, '232410242', 0.00, 0, '2025-09-01 01:41:20', '2025-09-01 01:41:20'),
(769, 770, 26, '232410243', 0.00, 0, '2025-09-01 01:41:21', '2025-09-01 01:41:21'),
(770, 771, 26, '232410244', 0.00, 0, '2025-09-01 01:41:21', '2025-09-01 01:41:21'),
(771, 772, 26, '232410245', 0.00, 0, '2025-09-01 01:41:21', '2025-09-01 01:41:21'),
(772, 773, 26, '232410246', 0.00, 0, '2025-09-01 01:41:22', '2025-09-01 01:41:22'),
(773, 774, 26, '232410247', 0.00, 0, '2025-09-01 01:41:22', '2025-09-01 01:41:22'),
(774, 775, 26, '232410248', 0.00, 0, '2025-09-01 01:41:22', '2025-09-01 01:41:22'),
(775, 776, 26, '232410249', 0.00, 0, '2025-09-01 01:41:22', '2025-09-01 01:41:22'),
(776, 777, 26, '232410250', 0.00, 0, '2025-09-01 01:41:23', '2025-09-01 01:41:23'),
(777, 778, 26, '232410251', 0.00, 0, '2025-09-01 01:41:23', '2025-09-01 01:41:23'),
(778, 779, 26, '232410252', 0.00, 0, '2025-09-01 01:41:23', '2025-09-01 01:41:23'),
(779, 780, 27, '232410253', 0.00, 0, '2025-09-01 01:41:23', '2025-09-01 01:41:23'),
(780, 781, 27, '232410254', 0.00, 0, '2025-09-01 01:41:24', '2025-09-01 01:41:24'),
(781, 782, 27, '232410255', 0.00, 0, '2025-09-01 01:41:24', '2025-09-01 01:41:24'),
(782, 783, 27, '232410256', 0.00, 0, '2025-09-01 01:41:24', '2025-09-01 01:41:24'),
(783, 784, 27, '232410257', 0.00, 0, '2025-09-01 01:41:25', '2025-09-01 01:41:25'),
(784, 785, 27, '232410258', 0.00, 0, '2025-09-01 01:41:25', '2025-09-01 01:41:25'),
(785, 786, 27, '232410259', 0.00, 0, '2025-09-01 01:41:25', '2025-09-01 01:41:25'),
(786, 787, 27, '232410260', 0.00, 0, '2025-09-01 01:41:26', '2025-09-01 01:41:26'),
(787, 788, 27, '232410261', 0.00, 0, '2025-09-01 01:41:26', '2025-09-01 01:41:26'),
(788, 789, 27, '232410262', 0.00, 0, '2025-09-01 01:41:26', '2025-09-01 01:41:26'),
(789, 790, 27, '232410263', 0.00, 0, '2025-09-01 01:41:27', '2025-09-01 01:41:27'),
(790, 791, 27, '232410264', 0.00, 0, '2025-09-01 01:41:27', '2025-09-01 01:41:27'),
(791, 792, 27, '232410265', 0.00, 0, '2025-09-01 01:41:27', '2025-09-01 01:41:27'),
(792, 793, 27, '232410266', 0.00, 0, '2025-09-01 01:41:27', '2025-09-01 01:41:27'),
(793, 794, 27, '232410267', 0.00, 0, '2025-09-01 01:41:28', '2025-09-01 01:41:28'),
(794, 795, 27, '232410268', 0.00, 0, '2025-09-01 01:41:28', '2025-09-01 01:41:28'),
(795, 796, 27, '232410269', 0.00, 0, '2025-09-01 01:41:28', '2025-09-01 01:41:28'),
(796, 797, 27, '232410270', 0.00, 0, '2025-09-01 01:41:29', '2025-09-01 01:41:29'),
(797, 798, 27, '232410271', 0.00, 0, '2025-09-01 01:41:29', '2025-09-01 01:41:29'),
(798, 799, 27, '232410272', 0.00, 0, '2025-09-01 01:41:29', '2025-09-01 01:41:29'),
(799, 800, 27, '232410273', 0.00, 0, '2025-09-01 01:41:29', '2025-09-01 01:41:29'),
(800, 801, 27, '232410274', 0.00, 0, '2025-09-01 01:41:30', '2025-09-01 01:41:30'),
(801, 802, 27, '232410275', 0.00, 0, '2025-09-01 01:41:30', '2025-09-01 01:41:30'),
(802, 803, 27, '232410276', 0.00, 0, '2025-09-01 01:41:30', '2025-09-01 01:41:30'),
(803, 804, 27, '232410277', 0.00, 0, '2025-09-01 01:41:31', '2025-09-01 01:41:31'),
(804, 805, 27, '232410278', 0.00, 0, '2025-09-01 01:41:31', '2025-09-01 01:41:31');

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
-- Indexes for table `insentifs`
--
ALTER TABLE `insentifs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `insentifs_penjualan_id_foreign` (`penjualan_id`),
  ADD KEY `insentifs_kelas_id_foreign` (`kelas_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kelas_id_wali_kelas_unique` (`id_wali_kelas`);

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
-- AUTO_INCREMENT for table `insentifs`
--
ALTER TABLE `insentifs`
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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
-- Constraints for table `insentifs`
--
ALTER TABLE `insentifs`
  ADD CONSTRAINT `insentifs_kelas_id_foreign` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `insentifs_penjualan_id_foreign` FOREIGN KEY (`penjualan_id`) REFERENCES `penjualan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_id_wali_kelas_foreign` FOREIGN KEY (`id_wali_kelas`) REFERENCES `pengguna` (`id`);

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
