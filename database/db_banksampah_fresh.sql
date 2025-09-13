-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2025 at 07:42 AM
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
  `setoran_id` bigint(20) UNSIGNED NOT NULL,
  `kelas_id` bigint(20) UNSIGNED NOT NULL,
  `jumlah_insentif` decimal(10,2) NOT NULL,
  `status_pembayaran` varchar(255) NOT NULL DEFAULT 'belum dibayar',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `pembayaran_insentif_id` bigint(20) UNSIGNED DEFAULT NULL
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
(1, 'Botol Plastik', 'aktif', 'pcs', 35.00, 0, '2025-09-13 05:16:58', '2025-09-13 05:16:58'),
(2, 'Gelas Plastik', 'aktif', 'pcs', 4.00, 0, '2025-09-13 05:16:58', '2025-09-13 05:40:09'),
(3, 'Kardus', 'aktif', 'kg', 1500.00, 0, '2025-09-13 05:16:58', '2025-09-13 05:40:17'),
(4, 'Botol Plastik (Warna)', 'aktif', 'pcs', 16.00, 0, '2025-09-13 05:40:44', '2025-09-13 05:40:44'),
(5, 'Botol Plastik Guru', 'aktif', 'pcs', 40.00, 0, '2025-09-13 05:41:44', '2025-09-13 05:41:50'),
(6, 'Gelas Plastik Guru', 'aktif', 'pcs', 5.00, 0, '2025-09-13 05:41:59', '2025-09-13 05:41:59');

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
(1, 'Guru', '2025-09-13 05:16:58', '2025-09-13 05:16:58', NULL),
(2, 'X MPLB 1', '2025-09-13 05:16:58', '2025-09-13 05:32:49', 852),
(3, 'X MPLB 2', '2025-09-13 05:16:58', '2025-09-13 05:39:08', 866),
(4, 'X TM 1', '2025-09-13 05:16:58', '2025-09-13 05:36:52', 861),
(5, 'X TM 2', '2025-09-13 05:16:58', '2025-09-13 05:33:12', 853),
(6, 'X TM 3', '2025-09-13 05:16:58', '2025-09-13 05:29:46', 847),
(7, 'X TM 4', '2025-09-13 05:16:58', '2025-09-13 05:29:25', 846),
(8, 'X TM 5', '2025-09-13 05:16:58', '2025-09-13 05:36:46', 862),
(9, 'X TM 6', '2025-09-13 05:16:58', '2025-09-13 05:35:51', 860),
(10, 'XI MPLB 1', '2025-09-13 05:16:58', '2025-09-13 05:36:03', 859),
(11, 'XI MPLB 2', '2025-09-13 05:16:58', '2025-09-13 05:38:11', 864),
(12, 'XI TM 1', '2025-09-13 05:16:58', '2025-09-13 05:33:39', 854),
(13, 'XI TM 2', '2025-09-13 05:16:58', '2025-09-13 05:28:46', 845),
(14, 'XI TM 3', '2025-09-13 05:16:58', '2025-09-13 05:37:53', 865),
(15, 'XI TM 4', '2025-09-13 05:16:58', '2025-09-13 05:35:12', 858),
(16, 'XI TM 5', '2025-09-13 05:16:58', '2025-09-13 05:32:18', 851),
(17, 'XI TM 6', '2025-09-13 05:16:58', '2025-09-13 05:33:57', 855),
(18, 'XI TM 7', '2025-09-13 05:16:58', '2025-09-13 05:30:29', 848),
(19, 'XII MPLB 1', '2025-09-13 05:16:58', '2025-09-13 05:31:44', 850),
(20, 'XII MPLB 2', '2025-09-13 05:16:58', '2025-09-13 05:31:18', 849),
(21, 'XII TM 1', '2025-09-13 05:16:58', '2025-09-13 05:37:43', 863),
(22, 'XII TM 2', '2025-09-13 05:16:58', '2025-09-13 05:38:53', 868),
(23, 'XII TM 3', '2025-09-13 05:16:58', '2025-09-13 05:34:50', 857),
(24, 'XII TM 4', '2025-09-13 05:16:58', '2025-09-13 05:28:55', 844),
(25, 'XII TM 5', '2025-09-13 05:16:58', '2025-09-13 05:29:02', 843),
(26, 'XII TM 6', '2025-09-13 05:16:58', '2025-09-13 05:34:17', 856),
(27, 'XII TM 7', '2025-09-13 05:16:58', '2025-09-13 05:38:59', 867);

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
(22, '2025_08_30_164252_create_insentifs_table', 1),
(23, '2025_08_30_171811_modify_role_in_pengguna_table', 1),
(24, '2025_08_30_172022_add_id_wali_kelas_to_kelas_table', 1),
(25, '2025_08_30_172632_add_unique_constraint_to_id_wali_kelas_in_kelas_table', 1),
(26, '2025_09_01_115843_create_pembayaran_insentifs_table', 1),
(27, '2025_09_01_115855_add_status_pembayaran_to_insentifs_table', 1),
(28, '2025_09_02_072425_add_status_to_setoran_table', 1),
(29, '2025_09_02_075146_add_id_wali_kelas_to_pembayaran_insentifs_table', 1),
(30, '2025_09_02_075314_add_jumlah_pembayaran_to_pembayaran_insentifs_table', 1),
(31, '2025_09_02_081823_cleanup_pembayaran_insentifs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_insentifs`
--

CREATE TABLE `pembayaran_insentifs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `tanggal_pembayaran` date NOT NULL,
  `total_dibayar` decimal(15,2) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_wali_kelas` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'Administrator', 'admin', '$2y$12$ycx2NQKL5QAbkCJlbXV6P.Cq7s4E4c01nghqmY68whZ/MV61lMOQm', 'admin', '2025-09-13 05:16:58', '2025-09-13 05:16:58'),
(2, 'JIHAN HOLIYANA', '232410200', '$2y$12$LToDoiwmdFoja7ulbcblB.7DhHYcPur.HdncOsmhzsjYyVdyrIchW', 'siswa', '2025-09-13 05:18:43', '2025-09-13 05:18:43'),
(3, 'MARYADI', '232410201', '$2y$12$5o/F1VMrUR4VVyb915yCoOpvNsNYZOnJDxj5tBh8h5Q0aVpC4fUQq', 'siswa', '2025-09-13 05:18:44', '2025-09-13 05:18:44'),
(4, 'MUHAMAD ALIN', '232410202', '$2y$12$5sOiacLTV/qFrDAApQWsIOxxJAL8xLGcYutFT6yI7id6H7WNONg7q', 'siswa', '2025-09-13 05:18:44', '2025-09-13 05:18:44'),
(5, 'MUHAMAD RONI ADITIA', '232410203', '$2y$12$B4tk8Hw7GQIZDbS8TK914uQ9TMcKk/UI3VVjXIckv8SCUA/ZejO4a', 'siswa', '2025-09-13 05:18:44', '2025-09-13 05:18:44'),
(6, 'MUHAMMAD REIVANDI', '232410204', '$2y$12$1YfIcx79NC6hCwIC2OYj/.6EJjIjS2FPNPqCx1NOWYaNZMbTkcTUK', 'siswa', '2025-09-13 05:18:44', '2025-09-13 05:18:44'),
(7, 'MUKHAMAD MARUF', '232410205', '$2y$12$.BEpXiqeyn.LSQJ0EnGwDOqCBlimve/dsrBwNPuLMwBI1NuTzDHmu', 'siswa', '2025-09-13 05:18:45', '2025-09-13 05:18:45'),
(8, 'NURI AGUSTINA', '232410206', '$2y$12$vp87m3Yt6b1qGLKk2y/hY.KE8e/wT4wsHB53Cd.cXJ7Ta6j7W0xeC', 'siswa', '2025-09-13 05:18:45', '2025-09-13 05:18:45'),
(9, 'RAHMAT HIDAYAT', '232410207', '$2y$12$Dn0SW/Jm.3CAHm2yv1aHQuQUzAMj175dQn4SWOho5IkbEDlmhWcHS', 'siswa', '2025-09-13 05:18:45', '2025-09-13 05:18:45'),
(10, 'RAMDANI', '232410208', '$2y$12$PxvtHXukwLAychtiDB/f2utWDmc.v6dlBK3gtq.riQeFyAtx1ZAki', 'siswa', '2025-09-13 05:18:45', '2025-09-13 05:18:45'),
(11, 'REYJA', '232410209', '$2y$12$lOIr4/BZ9KADXOjWLG.xxeoXSzZYcG1qbtLtz.KNe2G4juC8SzzpS', 'siswa', '2025-09-13 05:18:46', '2025-09-13 05:18:46'),
(12, 'RIYAN ARYANTO', '232410210', '$2y$12$aPhhzToXjAypupK21VebB.lACBhC3z4A/ryQV6Z/wHfi6i2FtyMuO', 'siswa', '2025-09-13 05:18:46', '2025-09-13 05:18:46'),
(13, 'RIZZKI AKBAR ALFATIRI', '232410211', '$2y$12$ZuhvcJyroR7fJsCWhOOEr.9qzTukJs3JRltjWpeIMT0A1blSIC9YS', 'siswa', '2025-09-13 05:18:46', '2025-09-13 05:18:46'),
(14, 'ROPI LORO SOPANJI', '232410212', '$2y$12$vGUO6vTAYow/QZvnD4sCNO3CySQ8Dux6dYY1JQwb407MbZgmyiXVO', 'siswa', '2025-09-13 05:18:47', '2025-09-13 05:18:47'),
(15, 'SUYUTI AHMAD BUSAERI', '232410213', '$2y$12$gAbI1RnyK4Rd/QglALWWLOlum7y4m3qd9dYXTShhb05DYW3nW2kf6', 'siswa', '2025-09-13 05:18:47', '2025-09-13 05:18:47'),
(16, 'TITI NURJANAH', '232410214', '$2y$12$irWGFVDmxZGr8HrjhUsKJODAf9qfDgFMb0JMwWV11efnx1pvsedUy', 'siswa', '2025-09-13 05:18:47', '2025-09-13 05:18:47'),
(17, 'WIRANATA', '232410215', '$2y$12$jtN1OT/WNRNyt7YLwHO26.6FmyP.0wpfLyqdAPj0MhEdKwmAF0l06', 'siswa', '2025-09-13 05:18:47', '2025-09-13 05:18:47'),
(18, 'YAZID RAHMAT HIDAYAT', '232410216', '$2y$12$IrSMD0C.ArKEZCBRc2voV.JzAR/HgSPauNVC8HCrwWYx8f5QYt5xq', 'siswa', '2025-09-13 05:18:48', '2025-09-13 05:18:48'),
(19, 'YUDIS TIRA ROMANSAH', '232410217', '$2y$12$HmnfvZUlQynehmBBrtZeEu37AP3BQOuPD3m7mQJ2euyAxHQEhCcCC', 'siswa', '2025-09-13 05:18:48', '2025-09-13 05:18:48'),
(20, 'YULI DEWIYANTI', '232410218', '$2y$12$Ss5cYGTMsOihXDy2m6jMoue8SievEvhHIpOIwPrUWqZMQTYCMHycu', 'siswa', '2025-09-13 05:18:48', '2025-09-13 05:18:48'),
(21, 'YULITA', '232410219', '$2y$12$hNYXu0.ORhtx0GyPqwUI2e7HVOiRoHaVMuDkVVImiPXBkn6qJbSTm', 'siswa', '2025-09-13 05:18:48', '2025-09-13 05:18:48'),
(22, 'ABDUL RONI', '232410220', '$2y$12$0ooipMfFsw1xRGFFkRiooOW.WGVQRINOeSzBnkE60X4anMDSW/XbG', 'siswa', '2025-09-13 05:18:49', '2025-09-13 05:18:49'),
(23, 'ABDUL SIDIK', '232410221', '$2y$12$wp5TVONDKwfZzxAJmFtyZeaCiQVUhb1dAv8ZLX3JZNzq8A2qUIOCW', 'siswa', '2025-09-13 05:18:49', '2025-09-13 05:18:49'),
(24, 'AEL GHAZALI', '232410222', '$2y$12$7m4btrxqkJgdEC2n.3QIp.Kqu/LNoHb.fm2Xr3n9Qn4fgj/Pg.jE6', 'siswa', '2025-09-13 05:18:49', '2025-09-13 05:18:49'),
(25, 'AHMAD FAHRI YUNMAR', '232410223', '$2y$12$SeOzmCQSDSbyzco.AjBKAuI4Joui9Iq9RxV.l73XXwrD3YylXaZ5y', 'siswa', '2025-09-13 05:18:49', '2025-09-13 05:18:49'),
(26, 'AHMAD ZAKKY JAELANI', '232410224', '$2y$12$o2/4YOvfDgI.qdNNhBX.uu0.bJGfAptuWMsi73ahmu5kIk68m7RvW', 'siswa', '2025-09-13 05:18:50', '2025-09-13 05:18:50'),
(27, 'AHMAL', '232410225', '$2y$12$QwZkeUbHDo3tppN2jgNXA.Z1blu9wCf4c6rq0m8q2ostGA0yeReK6', 'siswa', '2025-09-13 05:18:50', '2025-09-13 05:18:50'),
(28, 'AKBAR SUGIHARTONO', '232410226', '$2y$12$4yZNUCnOnXABBHBOPzJeW.U2k8LgLov1V1edAzSQSys79elae/aa2', 'siswa', '2025-09-13 05:18:50', '2025-09-13 05:18:50'),
(29, 'AMELDA FIKRIA', '232410227', '$2y$12$p85D4NaoybqdldS2d5j5K.WIjTD8Nc5grb7Wh7jw.Vw8rYP3gcxTe', 'siswa', '2025-09-13 05:18:50', '2025-09-13 05:18:50'),
(30, 'ARHAM SODIK', '232410228', '$2y$12$4Pg73NUdILDWnONAunVu9Ob/xjSBWzPmspbKH46t8nvjqnpV9E0Zm', 'siswa', '2025-09-13 05:18:51', '2025-09-13 05:18:51'),
(31, 'ATISAH', '232410229', '$2y$12$wSbMd6lbGKVEZb4MCc2IbOn8yTXffLU8RCso.IIoPFIJ4qOK6xPGG', 'siswa', '2025-09-13 05:18:51', '2025-09-13 05:18:51'),
(32, 'CAHYA KOMARA', '232410230', '$2y$12$fJD9zaVV6vTFwZOBvFhhDe4HG/ZjNSHD27CNgI79y.mfCHgU/YREu', 'siswa', '2025-09-13 05:18:51', '2025-09-13 05:18:51'),
(33, 'DEDEN', '232410231', '$2y$12$KcZksiQrSodmBUFb9FhAzu5ZOJh9uCaiCJdtFqXdbNZaRiljrMepa', 'siswa', '2025-09-13 05:18:52', '2025-09-13 05:18:52'),
(34, 'FITRIA ANGGRAENI', '232410232', '$2y$12$DzvdXdHH8Whn1.Z6Ca0MM.5LEq7A0nNooZDvw0aJsaHW6WG1bwoKa', 'siswa', '2025-09-13 05:18:52', '2025-09-13 05:18:52'),
(35, 'FITRIA RAMADANI', '232410233', '$2y$12$Dls8z9tZAqWOx9oMgphs7.WjEGtMKIc0E0xMW.4.CC6qNVbVGPbuK', 'siswa', '2025-09-13 05:18:52', '2025-09-13 05:18:52'),
(36, 'GITA MELINDA SARI', '232410234', '$2y$12$AXw449Cny3OnZkSHuGcMEui/G9EHZueTlk949j5.d/n0mzxUHHkIe', 'siswa', '2025-09-13 05:18:52', '2025-09-13 05:18:52'),
(37, 'IBNU HASAN', '232410235', '$2y$12$pXFskhnUyqjSApJ.alz8f.N4zMeR/Pq5xsB6DBUwDphv9xR9npd6W', 'siswa', '2025-09-13 05:18:53', '2025-09-13 05:18:53'),
(38, 'JAJANG SUTEJA', '232410236', '$2y$12$GPF.HZzzKRKCjZ7VuFoCiuX3CDpqoZMQe4Nbm2ib6V4z2OZcsXRTO', 'siswa', '2025-09-13 05:18:53', '2025-09-13 05:18:53'),
(39, 'KARNOM', '232410237', '$2y$12$p/AbO2RW.bgkFV8prf.guuGGVYqG3uG1DaeehJ/14Xj67HEac0VMW', 'siswa', '2025-09-13 05:18:53', '2025-09-13 05:18:53'),
(40, 'KARYA MULYANA', '232410238', '$2y$12$bLVoAH5O6th7OhlnsYdKgOzQQYy0P5WAJCf3LoHAhxTHy8HZdzNEO', 'siswa', '2025-09-13 05:18:53', '2025-09-13 05:18:53'),
(41, 'KHAIRUL IKHWAN ABBASY', '232410239', '$2y$12$DRFz84yHXG/EZLbB1Crdf.1kQ6kLN86kGbXO8cm4QqXuXYwJGKdBC', 'siswa', '2025-09-13 05:18:54', '2025-09-13 05:18:54'),
(42, 'MAULIDDANI AHMAD NURHANDIKA', '232410240', '$2y$12$Hrxhrfh7pC5dIsP4YOjWZ.lUTSR54wWq69SzE5ZyfYxuOEGta2Iv2', 'siswa', '2025-09-13 05:18:54', '2025-09-13 05:18:54'),
(43, 'MELI IMELDA', '232410241', '$2y$12$JTgBQqBKIDs5cg7wIYcvzuaPzion7g3X/8lvWeyMlbEC491JI3y/2', 'siswa', '2025-09-13 05:18:54', '2025-09-13 05:18:54'),
(44, 'MUHAMAD ROSANDI', '232410242', '$2y$12$X7x7Ibfa6Ovusu9ANP2gW.4xCzwRuyv3x973.rWii8or9QScqpbc2', 'siswa', '2025-09-13 05:18:54', '2025-09-13 05:18:54'),
(45, 'MUHAMMAD RAFA FAUZAN', '232410243', '$2y$12$g/WOAZiHDaYoJgXHDB4eLuz9nVFfZrwqnHJykPa/IOUqMvApH5pWS', 'siswa', '2025-09-13 05:18:55', '2025-09-13 05:18:55'),
(46, 'MUHAMMAD RAIHAN', '232410244', '$2y$12$B3kj5T4yViGrcmzaUWWP6./VObhB4IUvnY7stODIIuUeZ3IAhA9yy', 'siswa', '2025-09-13 05:18:55', '2025-09-13 05:18:55'),
(47, 'NOVIANI', '232410245', '$2y$12$nmXwGRtRVAdLabCo0iD/.OyUJCDbV9HLP87ckpqCO/eA535uLnwvO', 'siswa', '2025-09-13 05:18:55', '2025-09-13 05:18:55'),
(48, 'PIRMANSAH', '232410246', '$2y$12$X0O79ApK5lISYAj6eXdfw..ElnkhP7ZSnuhYTXZKj6V3tE4Cyi8TO', 'siswa', '2025-09-13 05:18:56', '2025-09-13 05:18:56'),
(49, 'RADO SAPERO', '232410247', '$2y$12$PfeNzeGPN2sDorHlsG/ErOr5pswfLfUpGOAXzHxj.bxTwiwEAjXfG', 'siswa', '2025-09-13 05:18:56', '2025-09-13 05:18:56'),
(50, 'SAEPUL PIRDAUS', '232410248', '$2y$12$l9z9W2eFCLdc1OtN45icJe6pDQvFdFrSoWpc1ZhLFOOWd4jXadEXq', 'siswa', '2025-09-13 05:18:57', '2025-09-13 05:18:57'),
(51, 'SUHENDAR', '232410249', '$2y$12$EzN/rj.MikuoRzmmpE2PHOqxCWHl5nnvEz7nhsMN48JZfH52CItHO', 'siswa', '2025-09-13 05:18:57', '2025-09-13 05:18:57'),
(52, 'WIDHI BAGASKORO', '232410250', '$2y$12$qJCdLg46PHZRy.XrOpfvseVZV3RxYIpYdg0wf.Z3Q9R9ra2EMrM62', 'siswa', '2025-09-13 05:18:57', '2025-09-13 05:18:57'),
(53, 'YULI', '232410251', '$2y$12$SaNrKQvqe7K65TpMyWKkE.YBRUO2gx/Y/ucM6VtZ51VLkORwgJ9H2', 'siswa', '2025-09-13 05:18:57', '2025-09-13 05:18:57'),
(54, 'ZEN ANFASA HIDAYAT', '232410252', '$2y$12$/pGRypnZ5P/RlxPU1HqFvOXqXlY3y948zSvvk3d0RBKLUuL/pY8TO', 'siswa', '2025-09-13 05:18:58', '2025-09-13 05:18:58'),
(55, 'ABDUL ROHMAN', '232410253', '$2y$12$/WBGYeJ3R5lkXhotCwZBme5SZDRwT0BG60iuOhtPR4AWzdUgMKiO.', 'siswa', '2025-09-13 05:18:58', '2025-09-13 05:18:58'),
(56, 'ASEP SUJANA', '232410254', '$2y$12$fIWOBKnNLJr1Vq.1pEUlH.Ub3pI6sbl7txEAblGlp5H7ryH/IEa4i', 'siswa', '2025-09-13 05:18:58', '2025-09-13 05:18:58'),
(57, 'DEDE RAFII', '232410255', '$2y$12$P8rfsgQLleZ30mk8r5vZZ.ZJK4JvaXv7PN1g4rmkMVLNuiNkF70sq', 'siswa', '2025-09-13 05:18:59', '2025-09-13 05:18:59'),
(58, 'DEDI WAHIDIN', '232410256', '$2y$12$o.DDfWbnlBDdjSPAFrF.b.Ge8Bu0O1CaagHQ9yVBbO.EAICOIezdG', 'siswa', '2025-09-13 05:18:59', '2025-09-13 05:18:59'),
(59, 'DETI DIAN TINI', '232410257', '$2y$12$XS7lPW4D5MhXhaF92wXkAupGC8z6WuSNXQnK8PvuDD1suC2y1SeVS', 'siswa', '2025-09-13 05:18:59', '2025-09-13 05:18:59'),
(60, 'ERNA WIDIAWATI S', '232410258', '$2y$12$BjHZaYjXBjhkFcAZDqxkZu5.lCL.Fs03.jz4aS80NfGB/iX.gbuV2', 'siswa', '2025-09-13 05:18:59', '2025-09-13 05:18:59'),
(61, 'ERNI WIDIAWATI S', '232410259', '$2y$12$oS0lKRcJfUrhBhg.W.qL.Omvc8i456xlSqzQ2iLdMkXN48gYZIKva', 'siswa', '2025-09-13 05:19:00', '2025-09-13 05:19:00'),
(62, 'HUSEN SOBARNA', '232410260', '$2y$12$Oq0LSX5ErY/LVLPINwo8aenXNlbVenFXLnKwTHgdmJlWR2UIyLkK2', 'siswa', '2025-09-13 05:19:00', '2025-09-13 05:19:00'),
(63, 'IBNI MUHAJIR', '232410261', '$2y$12$QZvL58jxLy.exuYN7nws/u02y3rWAxwbKNeB4gPzfP/jk1NwWYxO.', 'siswa', '2025-09-13 05:19:00', '2025-09-13 05:19:00'),
(64, 'IIP IVANKA', '232410262', '$2y$12$jdJhUEtz75i8fSsZMoAcDu3FGwTmD084nWQM7bl8j6PLbOYdrj8K2', 'siswa', '2025-09-13 05:19:01', '2025-09-13 05:19:01'),
(65, 'IRFAN HIDAYAT', '232410263', '$2y$12$m9nNUqsmHver6fegBbmjC.ZdoTjg.d22tjgh7X2DvAjJx9etWypHe', 'siswa', '2025-09-13 05:19:01', '2025-09-13 05:19:01'),
(66, 'KARDIANTO', '232410264', '$2y$12$.gXyTu7rpHtQxqg9aYDPk.y0vXKPB4FhGDojYE.RbNt/R7FhrkNla', 'siswa', '2025-09-13 05:19:01', '2025-09-13 05:19:01'),
(67, 'KISAR', '232410265', '$2y$12$wLVx7RfD61Jlt.oz07Si3.4AyG2AILlzT0KGFA6ly0Gpqe1C.fGE6', 'siswa', '2025-09-13 05:19:01', '2025-09-13 05:19:01'),
(68, 'KORIYAH', '232410266', '$2y$12$08KKpM4NaOSFyZCcMQJ6fel0g6TLMHhq3Z9/iUv9AApf4NYSmimhi', 'siswa', '2025-09-13 05:19:02', '2025-09-13 05:19:02'),
(69, 'LINDA', '232410267', '$2y$12$dImRAVa6Mlo06MNQahldd.rS0eERa8Vmfh1JCZHXAeCsxOZQBzRf6', 'siswa', '2025-09-13 05:19:02', '2025-09-13 05:19:02'),
(70, 'MAYA ANJELINA FRATAMA', '232410268', '$2y$12$XaGvSm3xKPUoFp0L1KbGnenf5t2kRMleFuSuteU45LJUVy.z4CV5.', 'siswa', '2025-09-13 05:19:02', '2025-09-13 05:19:02'),
(71, 'MUHAMMAD ABDUL FAQIH', '232410269', '$2y$12$4h1iZgSZWfHIWeN1zg8rPux5l9HCbMm1QeMeBRid.b0GN3g4nnbxm', 'siswa', '2025-09-13 05:19:02', '2025-09-13 05:19:02'),
(72, 'MUHAMMAD AHDA AL MUSYAROF', '232410270', '$2y$12$P4NLaWc3L8bHeHQxF.p/AuA7S/ocNRC77GYXwxBBm7CfzeY2MGYay', 'siswa', '2025-09-13 05:19:03', '2025-09-13 05:19:03'),
(73, 'MUHAMMAD FADLAN', '232410271', '$2y$12$LMSFvVmXmOAUD1zpZvcEV.2XZQ6SVLEnX8l2N.fGtS6MLrfG54v.m', 'siswa', '2025-09-13 05:19:03', '2025-09-13 05:19:03'),
(74, 'MUTIARA AZIZAH', '232410272', '$2y$12$IpwzUMJsQQp3qyAetxq7Bes/aUqXWT4NoH5zXd1.EtauUgg7ep5O.', 'siswa', '2025-09-13 05:19:03', '2025-09-13 05:19:03'),
(75, 'NURAENI', '232410273', '$2y$12$0whtfOmMo6nGCJIASq45p.pVMpRorpWghucBYauQ3Oi4fH.IuPbvK', 'siswa', '2025-09-13 05:19:03', '2025-09-13 05:19:03'),
(76, 'RAKA', '232410274', '$2y$12$08zqXKEfph72ZCsugwuyeeLwvCsw.T5woL5znfcp93ayqWR6ot1aG', 'siswa', '2025-09-13 05:19:04', '2025-09-13 05:19:04'),
(77, 'RIKI', '232410275', '$2y$12$Lnl/EtSsxZMw5KBu7/oBuu3y.9CVV5CEKBgnoYXm72IlbX8R8eCsO', 'siswa', '2025-09-13 05:19:04', '2025-09-13 05:19:04'),
(78, 'SAEPUL ANWAR', '232410276', '$2y$12$m1L5vMr06YezsAG/JeXQg.rNyS1T/LiulvyuhsOFZDWC9JGvPXhnW', 'siswa', '2025-09-13 05:19:04', '2025-09-13 05:19:04'),
(79, 'WARMAN', '232410277', '$2y$12$V09wGZ.29pRflbNb6/7R2.IS3wgIYeQLAbzjBI6zjkvpzQBbIilea', 'siswa', '2025-09-13 05:19:04', '2025-09-13 05:19:04'),
(80, 'YASMIN', '232410278', '$2y$12$mJQ4T7R1ixd/xPYoj0yikOA2.CrWsBpGyNlx01I9rLc7RbAZclQmi', 'siswa', '2025-09-13 05:19:05', '2025-09-13 05:19:05'),
(81, 'AISAH', '232410001', '$2y$12$xMoBLR5JNJ0eke948WJWQempowSptmj79s8J0Hr3xOJhSEVSiRREi', 'siswa', '2025-09-13 05:19:49', '2025-09-13 05:19:49'),
(82, 'AISAH FITRIYAH', '232410002', '$2y$12$VG1BsCDlZuExdU5pZZ1JoOLKAthuKX3ds0winwPD6G0P4SPBpxkcS', 'siswa', '2025-09-13 05:19:49', '2025-09-13 05:19:49'),
(83, 'ALDI REPALDI', '232410003', '$2y$12$UcxJWVNvxs19cZcBJb3we.l04UFvLp2zVZ6z9YxRRICdc22mZvNim', 'siswa', '2025-09-13 05:19:49', '2025-09-13 05:19:49'),
(84, 'ANISA TRI WAHYUNI', '232410004', '$2y$12$itEL8S/qrG0RkDApLbpy4ugpKcOsTrZ8VEwWxbKSGLk5xmEOBAGOC', 'siswa', '2025-09-13 05:19:49', '2025-09-13 05:19:49'),
(85, 'AYU ARISKA', '232410005', '$2y$12$xG1a.JAt5l/2yTQq1zTFX.W0.i4p2Kxwt.luiHjAduCb6SYJwJBm2', 'siswa', '2025-09-13 05:19:50', '2025-09-13 05:19:50'),
(86, 'DEA AULIYA', '232410006', '$2y$12$f0UnAW28ze8W4bKsOE46IONSTJa2jBGG4rf6ZRzDGbm.5E3h4paJ6', 'siswa', '2025-09-13 05:19:50', '2025-09-13 05:19:50'),
(87, 'Dedeh', '232410007', '$2y$12$14P8kkToAZVr7sxlLhkAseISxU3rZB1QoddGm5LGEOdEUoyAnCNKW', 'siswa', '2025-09-13 05:19:50', '2025-09-13 05:19:50'),
(88, 'Entin Julyani', '232410008', '$2y$12$AdzcUbGdMMVWxH9.rl1xSel9XBJEot1dJPLpCqv7v6rgms0IZ.02G', 'siswa', '2025-09-13 05:19:50', '2025-09-13 05:19:50'),
(89, 'HALISA HUMAIRA', '232410009', '$2y$12$7ZMhuCs.gFESD5CMGqpG3.i8ZQoGIWj5X3VrPr6BPFKXcIcumz16C', 'siswa', '2025-09-13 05:19:51', '2025-09-13 05:19:51'),
(90, 'HANIPAH PAUJIAH', '232410010', '$2y$12$fLAQChTuFS4CkM7AA0dXi..dxpQSvDoXSLoysE/LS9dI5RjFR1vSa', 'siswa', '2025-09-13 05:19:51', '2025-09-13 05:19:51'),
(91, 'HASBY MAHEZA', '232410011', '$2y$12$KZVxYxb0Q52GvZhRVptIIO/K2SWK.dW0SI.UseIQc1Vc7lOxALpUW', 'siswa', '2025-09-13 05:19:51', '2025-09-13 05:19:51'),
(92, 'INTAN AOLIA', '232410012', '$2y$12$fH/iL0umg3YQ0kYyjHXwYuyXOC7m4iRn.GDkpYNPv.oQnBQVGzgCK', 'siswa', '2025-09-13 05:19:52', '2025-09-13 05:19:52'),
(93, 'INTAN NURAINI', '232410013', '$2y$12$a3PyQB1oXymBgdBUsP2ufOnIrYeL7g3oVz6fpdXjtyFeFxLPgT0bC', 'siswa', '2025-09-13 05:19:52', '2025-09-13 05:19:52'),
(94, 'IRMA SULISTIA', '232410014', '$2y$12$ACzWsl2bSMmIFPztZWhCB.TBXMQXfMT4oLTb.hWDRjIoIhUWlh5H6', 'siswa', '2025-09-13 05:19:52', '2025-09-13 05:19:52'),
(95, 'JAHRATUSSYITA', '232410015', '$2y$12$dTJLMz75/kwPXoxji9KXV.N3/VP9jkcCXlDSJcEhUTyBIS3UKaagy', 'siswa', '2025-09-13 05:19:53', '2025-09-13 05:19:53'),
(96, 'JIHAN', '232410016', '$2y$12$AAc812n7HP2hpfDcJNjfaey0xOgnCjrv9eUz13sM7WlBijUcXdzF.', 'siswa', '2025-09-13 05:19:53', '2025-09-13 05:19:53'),
(97, 'KURNIA FEBRIANTI', '232410017', '$2y$12$R8w7PgY9B3yGM8pFWjKKgO3SBseQVdyuTv5sjE4/7lUsWYntNDNSm', 'siswa', '2025-09-13 05:19:53', '2025-09-13 05:19:53'),
(98, 'LALA PADILAH', '232410018', '$2y$12$M2PEbO2VvsqljJLrP4bHXOKNnL41fgoI5ebcP2.hSsKJNNij/7nU2', 'siswa', '2025-09-13 05:19:54', '2025-09-13 05:19:54'),
(99, 'NOVITASARI', '232410019', '$2y$12$B.nv3at83wwXF130hdoflOtAiYMFKX9SUKBZUN0KYGYwBmq6iPNNS', 'siswa', '2025-09-13 05:19:54', '2025-09-13 05:19:54'),
(100, 'NURLELAH', '232410020', '$2y$12$5eTBztPWL.nTB2IMtJ93Nu9GecHkKY2rg5Kbv/VT.KD6X4JXcLYNG', 'siswa', '2025-09-13 05:19:54', '2025-09-13 05:19:54'),
(101, 'NURUL FARHAH', '232410021', '$2y$12$6c2RDRzuo8CkYGB4ocgXH.EN95ROzd2uxC7z35qeijYbhDXy3csbG', 'siswa', '2025-09-13 05:19:55', '2025-09-13 05:19:55'),
(102, 'RAHMA AULIA AGUSTIN', '232410022', '$2y$12$U4MJHDhbqnANLIPyfFzWZON3r.Q.GWvnQ15BvwMCxuWn8mBlsINlW', 'siswa', '2025-09-13 05:19:55', '2025-09-13 05:19:55'),
(103, 'RIYAN', '232410023', '$2y$12$Ta35WYEL7miTHmiyC/ev5OX1.4UVrq5gsgFO03aUbix1wQLEFknvC', 'siswa', '2025-09-13 05:19:55', '2025-09-13 05:19:55'),
(104, 'SINDI ARISKA', '232410024', '$2y$12$Y6UI8AxiOWDRwSQ6oPmpe.aD.kE.DAlTpg82bKjO/uqXJPWGqg4bS', 'siswa', '2025-09-13 05:19:55', '2025-09-13 05:19:55'),
(105, 'SITI NURAENI', '232410025', '$2y$12$7O0.HEHOM0D2kajpvTBSCeNOEADYcE0.rE5UoDEe2/WfOYAHw5CZS', 'siswa', '2025-09-13 05:19:56', '2025-09-13 05:19:56'),
(106, 'TRI NOVITA SARI', '232410026', '$2y$12$yLZ1EyTsldKMaMD.KwAKvO5jxa.9dftUiT9UuLTuTmlMs3WLaARKq', 'siswa', '2025-09-13 05:19:56', '2025-09-13 05:19:56'),
(107, 'ALVIANI', '232410027', '$2y$12$kx7qfi2ewYPlAYrk4S5NouxIWOhwv7j93hQbskQ3BJRl6J9dIkLm.', 'siswa', '2025-09-13 05:19:56', '2025-09-13 05:19:56'),
(108, 'DECA LESMANASARI', '232410028', '$2y$12$Wbi3nXhgPBytZDrj2kEimOJdIIVOYemkiUNyaPI6dW8q//LUXYK8W', 'siswa', '2025-09-13 05:19:56', '2025-09-13 05:19:56'),
(109, 'GINA HERAWATI', '232410029', '$2y$12$WJIh7H4j1bXC1U3AQ.E4E.nziyDsspVry32m0XwxwtUpju4t3nEGu', 'siswa', '2025-09-13 05:19:57', '2025-09-13 05:19:57'),
(110, 'INDI LESTARI', '232410030', '$2y$12$T22ooTVf4RcxaLQ2VDVnBeOpRN5vBqm864yVS6GU7pQhd7w8QqmAq', 'siswa', '2025-09-13 05:19:57', '2025-09-13 05:19:57'),
(111, 'JENY SAFIRA', '232410031', '$2y$12$/iPcu5CnpLkvv2h12TnwCuR.7KDeoneMZ.q1O2vY9fhJUqhHG21Jm', 'siswa', '2025-09-13 05:19:57', '2025-09-13 05:19:57'),
(112, 'KHILDA SYAFA`AH', '232410032', '$2y$12$jlKjMYvo1cBFKZjS559e0ec4HGN5t2Q4C5jqXh/yoarMbwOhaRm5a', 'siswa', '2025-09-13 05:19:58', '2025-09-13 05:19:58'),
(113, 'LAELA', '232410033', '$2y$12$N6jmAM4COESabWrNOKh8G.1ASQ7iTrph5jRjmjiiZyns8QliMcoU.', 'siswa', '2025-09-13 05:19:58', '2025-09-13 05:19:58'),
(114, 'NAILA ADZKYA MAULA', '232410034', '$2y$12$kRv2.VFTBoXLPpRl5RtVuOo5fG062gWaR0I0O6XvI43ojKwEWp9gS', 'siswa', '2025-09-13 05:19:58', '2025-09-13 05:19:58'),
(115, 'NAJWA', '232410035', '$2y$12$YmIVz41ccmrCxfd49csjk.yQ6I/EJVPJ1demtV86S/lW6qkZYZWCO', 'siswa', '2025-09-13 05:19:58', '2025-09-13 05:19:58'),
(116, 'NARSIH', '232410036', '$2y$12$IHqBz2m1d6ju5MLGQEe5QOpwuPYGtoQpQF4RaiVZIkR/ub0WK92k.', 'siswa', '2025-09-13 05:19:59', '2025-09-13 05:19:59'),
(117, 'NIKEN RIZKIA NINTIAS', '232410037', '$2y$12$reorBde5mN3gM67288hdXu3NeF98GrXOh2ICPL.ES.F4ttg9x7UfO', 'siswa', '2025-09-13 05:19:59', '2025-09-13 05:19:59'),
(118, 'PUTRI JULIANTI LESTARI', '232410038', '$2y$12$KxSEml/fmTacWc2g3risQ./Fra.VRGKlL0YqbX6CZiTIOkfqkU0Jm', 'siswa', '2025-09-13 05:19:59', '2025-09-13 05:19:59'),
(119, 'RAHMAWATI', '232410039', '$2y$12$swqot3GJYUDqnPqW6d5Wael9tuCaMo2Hm2PiXGiNPnGvs7PZLFFCC', 'siswa', '2025-09-13 05:19:59', '2025-09-13 05:19:59'),
(120, 'RATNA DEWI WULAN SARI', '232410040', '$2y$12$U8kHn6berhvrQsftRSdeiudPgtuVlk2qII6V7lUR/QSyO29Z24bGC', 'siswa', '2025-09-13 05:20:00', '2025-09-13 05:20:00'),
(121, 'REFFA AMELIA', '232410041', '$2y$12$WHzu3WZeIhYnJa2AXLZ/zekOuXTJtzAi5RZ2E3g7e1.OwEobQoGWu', 'siswa', '2025-09-13 05:20:00', '2025-09-13 05:20:00'),
(122, 'SAWI', '232410042', '$2y$12$8CkaSu8BOc3meK01TnxDHOm6oj2hhMvyDn4AZJTH4UIWs89.sj5Em', 'siswa', '2025-09-13 05:20:00', '2025-09-13 05:20:00'),
(123, 'SEPTIANI', '232410043', '$2y$12$j1WcJy.7XVUrCimaxycta.EfjVwNDF7BL2Vt5v5.99vlBhkvUgR3m', 'siswa', '2025-09-13 05:20:01', '2025-09-13 05:20:01'),
(124, 'SITI HILDA MAESAROH', '232410044', '$2y$12$AyR8Am9XfQWiQyyvCTuTIO5VCCQURU1gGXI/bhLf4ccQKIXW.l0yG', 'siswa', '2025-09-13 05:20:01', '2025-09-13 05:20:01'),
(125, 'SITI SOVIYAH', '232410045', '$2y$12$jz3qXWk60fbpxcH4c9v2tuqDYRlIxXASq07toRTOV/Ogb8eG6Fm2.', 'siswa', '2025-09-13 05:20:01', '2025-09-13 05:20:01'),
(126, 'SITRA ADILA', '232410046', '$2y$12$5hB3wx0Hlli7NQu8XLbeMOmfR8Hf2AIr.jGEjKRi.F.TkTlLI7VKq', 'siswa', '2025-09-13 05:20:01', '2025-09-13 05:20:01'),
(127, 'SRI NURHAYATI', '232410047', '$2y$12$TQSS4nbGAOSMWwd.jqpkc.HeRronIzAfj2JHvLqiQ67nagNshLp5q', 'siswa', '2025-09-13 05:20:02', '2025-09-13 05:20:02'),
(128, 'WARI', '232410048', '$2y$12$HQ5e6cEMCLMWXRD9jNB3t.v/XvfyUzE9R97DouwC9MZxc.x5Ydhni', 'siswa', '2025-09-13 05:20:02', '2025-09-13 05:20:02'),
(129, 'WULAN NURUL ARIFAH', '232410049', '$2y$12$k5rpNCgO690TRpfX8JosU.iq94j0PbrqLpX6.xZ5ThDZumD4Rz8zS', 'siswa', '2025-09-13 05:20:02', '2025-09-13 05:20:02'),
(130, 'YUSTIKA DEWI', '232410050', '$2y$12$2w58Qsu6ayGxKVpk3GfCb.T2NUUnHNeqyZErBah4ctBm7EGbI6P/C', 'siswa', '2025-09-13 05:20:02', '2025-09-13 05:20:02'),
(131, 'ZAHRA NURI SURYA', '232410051', '$2y$12$zRcICf9KgI0hAp2cr3zl7uo0zI4cmZLrNIBltbclTVzhmuImltzTS', 'siswa', '2025-09-13 05:20:03', '2025-09-13 05:20:03'),
(132, 'ADAM PRIAMUGA', '232410052', '$2y$12$z42nrShVtt48i0qWF5zbdOipeeELjllkBXxfa0oSTC8c9KkF4Zc0y', 'siswa', '2025-09-13 05:20:03', '2025-09-13 05:20:03'),
(133, 'ADARSONO', '232410053', '$2y$12$HHKIjH9KZEozlowV0GQupeMYQS0EUr6cwYe/IHGpGV.HrTyZDz5A.', 'siswa', '2025-09-13 05:20:03', '2025-09-13 05:20:03'),
(134, 'AFAHRI SATYA ABDUL', '232410054', '$2y$12$feyP8AqBfC1yEge2UrHKoOXORRmeLE9wf4knSGo/lj68.eVYvWrPO', 'siswa', '2025-09-13 05:20:04', '2025-09-13 05:20:04'),
(135, 'AHMAD RIZKI ADITIA', '232410055', '$2y$12$ZPr/Q77V.iey/qPbMn0rFeJs5NfsXwtyAMwX78eWAb/bVdq8Qm6CC', 'siswa', '2025-09-13 05:20:04', '2025-09-13 05:20:04'),
(136, 'AHMAD RIZKY AL MAHMOD', '232410056', '$2y$12$DMVgx2vhP0fvTy3MvRxjNedMcbizrov/fby3Jlgai7hUp/vo7BDlm', 'siswa', '2025-09-13 05:20:04', '2025-09-13 05:20:04'),
(137, 'AJI PANGESTU', '232410057', '$2y$12$9J6kRku3dwENYEOO6ziKkekiOAcYyQKc/5uLaezsJasxz2EJGBVGq', 'siswa', '2025-09-13 05:20:04', '2025-09-13 05:20:04'),
(138, 'AKMAL KUSRORI', '232410058', '$2y$12$b.DZRQmz5ebnMtbxOMDp8eQfgdvW3Qq41GV4v78nyGh8wZHtKVQe6', 'siswa', '2025-09-13 05:20:05', '2025-09-13 05:20:05'),
(139, 'ANGGA ADITIA', '232410059', '$2y$12$wCLmqppQfHg31adrl1u6Wu8Tol3mtZeQ2Ceibxh60.RhK6E2deoA.', 'siswa', '2025-09-13 05:20:05', '2025-09-13 05:20:05'),
(140, 'ANNISA TUL AULIA', '232410060', '$2y$12$0a4OdoX8p9E1u.ElwUlrHuWpC7tmooENA7BAzr9NWvHYO7npF8rtm', 'siswa', '2025-09-13 05:20:05', '2025-09-13 05:20:05'),
(141, 'AYAN SUPRIATNA', '232410061', '$2y$12$Ktwsb9l/mrhv20/2ZUi.9eKpCNcH0Q5Mm9XUKYP2zPiEaQ1YQzei2', 'siswa', '2025-09-13 05:20:05', '2025-09-13 05:20:05'),
(142, 'CACA AULIANA', '232410062', '$2y$12$lLoghn7e9ICq1bIkRW4kc.guGDTto9AyO28uqyO7eu1Wt8C3yc7py', 'siswa', '2025-09-13 05:20:06', '2025-09-13 05:20:06'),
(143, 'DIKI SOMANTRI', '232410063', '$2y$12$qCSl5oIpm82Ge1jewY60NuG9jr4LpatEZ0J28XYSN0wnhWVWL8CuW', 'siswa', '2025-09-13 05:20:06', '2025-09-13 05:20:06'),
(144, 'DIRGA RAGIL PUTRA RUKMANA', '232410064', '$2y$12$7to6ClRoS4Ff1OU7boFD3e/Alis.yYQUbHMqplnwcqUKSe8HUyyVS', 'siswa', '2025-09-13 05:20:06', '2025-09-13 05:20:06'),
(145, 'EVA ALEXA', '232410065', '$2y$12$H6OcQMxQorxwKIUpTrkxle88LFRhU5A1Szka8f7SS9evbaeR6CQHe', 'siswa', '2025-09-13 05:20:06', '2025-09-13 05:20:06'),
(146, 'FAIRUZ FIKHAR FUADI', '232410066', '$2y$12$fdOqx/GJXIYqziYC5MJVjOt1n5.gTyVYI4yMvTSLKxeB1fkSy9cTW', 'siswa', '2025-09-13 05:20:07', '2025-09-13 05:20:07'),
(147, 'FITRIYANI', '232410067', '$2y$12$l3xZtAbkQmq6wi9q1oX3E.PG0InbQ1rxxjFoEgu3jJRvPoA.pq9lq', 'siswa', '2025-09-13 05:20:07', '2025-09-13 05:20:07'),
(148, 'HIDAYAT AHMAD SIDIK', '232410068', '$2y$12$WHfJ91/lP8xaIJNjRAoQOePytrYW4UwOKYlyzxqMRrdd7j8QagD/u', 'siswa', '2025-09-13 05:20:07', '2025-09-13 05:20:07'),
(149, 'IRWAN ISKANDAR', '232410069', '$2y$12$Uko0viprQJug65DQoOOOWu7PCmsGJgw6E0PNchX/QBGF1QyHuGxKy', 'siswa', '2025-09-13 05:20:08', '2025-09-13 05:20:08'),
(150, 'KHOERUL APANDI', '232410070', '$2y$12$7yoVClskm1hr/bqdquAvxuhmEsO5/k4Y8E5tKRBr/GUAQIJUC8D.u', 'siswa', '2025-09-13 05:20:08', '2025-09-13 05:20:08'),
(151, 'KUSNATA', '232410071', '$2y$12$6qRvPcCR2BnSr4WYkfOj6.Ccih.LncijAXE6Ov3srHtYqplxkt7n2', 'siswa', '2025-09-13 05:20:08', '2025-09-13 05:20:08'),
(152, 'MUHAMAD EGA OKTAVIAN', '232410072', '$2y$12$C/n6iHwM67KI2VjrCt6cD.Q6rsWd4Lm4CJK7NPtlKieGr1lbv6.km', 'siswa', '2025-09-13 05:20:08', '2025-09-13 05:20:08'),
(153, 'MUHAMAD YUNUS', '232410073', '$2y$12$hidHHGECKncFh8R7v1DSjeQo3kz5qJIhpONjbznFCwq9plTZdU20K', 'siswa', '2025-09-13 05:20:09', '2025-09-13 05:20:09'),
(154, 'MUHAMMAD RAMDANI', '232410074', '$2y$12$EtcdIUJQViB1tufY9lqqXuzi3FUpC0H/UKr6i0fnh09yHsbhifbUK', 'siswa', '2025-09-13 05:20:09', '2025-09-13 05:20:09'),
(155, 'MUHAMMAD RAYHAN RAMDHAN', '232410075', '$2y$12$XVfp.eNq3c4Dse/m4lIYK.MStqh4egQ7G4mqPRfuoL1vG2mZ89/ly', 'siswa', '2025-09-13 05:20:09', '2025-09-13 05:20:09'),
(156, 'RANIA NURDIAN', '232410076', '$2y$12$J6limH8/cYZVIbPvbHpMMulkq4j3csk01kCfU3610EKCEKfkVmfyS', 'siswa', '2025-09-13 05:20:09', '2025-09-13 05:20:09'),
(157, 'ROMLAH', '232410077', '$2y$12$bfXqybqsJFynxkElgbzRfeT6Rcg/LCQ.VQr75vvYBCUg7ftdZ/i8O', 'siswa', '2025-09-13 05:20:10', '2025-09-13 05:20:10'),
(158, 'SAAD APRIANSYAH', '232410078', '$2y$12$582jn3qyxYmuydyQq2t5GepqesChxHlFtIvG.3IXUwHfahosSx376', 'siswa', '2025-09-13 05:20:10', '2025-09-13 05:20:10'),
(159, 'SANTANA WIDI BAHARI', '232410079', '$2y$12$jKpCTwj9gA.uVdXIG0JMguEReCcLy9/0z0D99k4gXTpT679OwJ/aC', 'siswa', '2025-09-13 05:20:10', '2025-09-13 05:20:10'),
(160, 'SANTI', '232410080', '$2y$12$X1pj0/rqWEuURen8ZQPbCOGjINQkgorHV0azMYXbp7jF4.MJ3U82G', 'siswa', '2025-09-13 05:20:10', '2025-09-13 05:20:10'),
(161, 'SITI PATIMAH', '232410081', '$2y$12$1CuRUCU4trtvAoD2Ar18N.Pice3bJXZ8NgFDmZjQxJZNQghyhr.9m', 'siswa', '2025-09-13 05:20:11', '2025-09-13 05:20:11'),
(162, 'TAHRI RAHMADANI', '232410082', '$2y$12$w1RQ04HEDEna0QV/b2fRtu2bv0TqcfaqIVhptw6TilQhazyy7hWnK', 'siswa', '2025-09-13 05:20:11', '2025-09-13 05:20:11'),
(163, 'TANGGUH AZIZI', '232410083', '$2y$12$EUjzRFAG6zgb7/IXrHStG.2cRHU5sKCvsHZZTrhZwLqMI6/nugzX2', 'siswa', '2025-09-13 05:20:11', '2025-09-13 05:20:11'),
(164, 'TARVIN', '232410084', '$2y$12$xuj2kB./xHMogxG7/bKt4uUb3k29R4f0CwevR0Nd3CdC0Q9kHoazC', 'siswa', '2025-09-13 05:20:12', '2025-09-13 05:20:12'),
(165, 'AGUSTIAN ABDUR ROFIQ', '232410085', '$2y$12$bMMwewVJKapnVdSGbGpkjej5/PknDlMBmqRKCx0Gm7cJ7kI7t8vPe', 'siswa', '2025-09-13 05:20:12', '2025-09-13 05:20:12'),
(166, 'AHMAD REKSA', '232410086', '$2y$12$glxLy6kSdF9qDA6C0Q6GsOrYYyCtcpaIpuAGF4eh1Lh6aYxSGu6J.', 'siswa', '2025-09-13 05:20:12', '2025-09-13 05:20:12'),
(167, 'AKBAR RAMADANI', '232410087', '$2y$12$c.0Y8xKbm1.ya/RuuDx0iuwM5ro8vyZ9sY1bPcMq.JRMtirZla.52', 'siswa', '2025-09-13 05:20:12', '2025-09-13 05:20:12'),
(168, 'ANDREYAN SURYANA SAPUTRA', '232410088', '$2y$12$MC/0evW1D/ruyczunG7fH.ZrEviKrOkVtxGtRfOLueaJrtFwebtZW', 'siswa', '2025-09-13 05:20:13', '2025-09-13 05:20:13'),
(169, 'ARIF PERMANA SIDIK', '232410089', '$2y$12$hLirO.oKI5n1ONvHPHfwT.7CVawZ6GPv0lufXXIIt2uw2kHgIkEyG', 'siswa', '2025-09-13 05:20:13', '2025-09-13 05:20:13'),
(170, 'AYU ARYANAH', '232410090', '$2y$12$wpJqgP4wa3n9mTg34iDCl.4Ys2OEB7iNoER5gFA4UtZze657x7oES', 'siswa', '2025-09-13 05:20:13', '2025-09-13 05:20:13'),
(171, 'BUSYAERI MAJID', '232410091', '$2y$12$/vFgHqyk3SNk9qvGgiSgGeY7A1m7ADue0OagUun9JDx/x2we7oaGO', 'siswa', '2025-09-13 05:20:13', '2025-09-13 05:20:13'),
(172, 'CARTIWAN', '232410092', '$2y$12$mnvpAOzobMbF2NkF8ZsFq.emBYzzz1jO2p27d5EFxT/PO38M0YvfW', 'siswa', '2025-09-13 05:20:14', '2025-09-13 05:20:14'),
(173, 'DAHLIA SRI RAHAYU', '232410093', '$2y$12$uJTcGFtCgAqhW7Od97o2VuA/IBTOAX67EAy6QgjZlBnP3aFhvpTvS', 'siswa', '2025-09-13 05:20:14', '2025-09-13 05:20:14'),
(174, 'DERLY PRASETYO', '232410094', '$2y$12$/snmVAxBxFVoMBejkbbWB.3UQZGEKlJxxEgSu.OczVGo39TjGJ4Q2', 'siswa', '2025-09-13 05:20:14', '2025-09-13 05:20:14'),
(175, 'DETIYA KUSMAYADI', '232410095', '$2y$12$AJJS1D2v72jI0XW96qpfdeVdXmN.448P95zE6swteJKZFjKBmkNTO', 'siswa', '2025-09-13 05:20:14', '2025-09-13 05:20:14'),
(176, 'DIMAS ROHMAN SAPUTRA', '232410096', '$2y$12$fymvPiObPg614MevdB/MYeC4/uKgxjNBPYzzNm3N7KJ50uo.gqjbS', 'siswa', '2025-09-13 05:20:15', '2025-09-13 05:20:15'),
(177, 'FAJAR FADILLAH', '232410097', '$2y$12$OnAA5fszSjLc0L3duYAfFedawg.i8bsc/96pnUP9RdyKXWU4mhD7W', 'siswa', '2025-09-13 05:20:15', '2025-09-13 05:20:15'),
(178, 'FIKRI AHMAD MUBAROK', '232410098', '$2y$12$yy0l.Y9VKfwhr.DPsykkJ.wauDe3QGoq3GiVd1/6hz4YSE.b14Np2', 'siswa', '2025-09-13 05:20:15', '2025-09-13 05:20:15'),
(179, 'GUNAWAN', '232410099', '$2y$12$ItE0ABYGywFIVZxyaUOh8uuiGxksS3A2oZ55xAZK6oiVderbsShxG', 'siswa', '2025-09-13 05:20:16', '2025-09-13 05:20:16'),
(180, 'HADI HOERUDIN', '232410100', '$2y$12$mTRzwo2PK8/8M.i15ajTXOCAO60iNFTzyi85PVOxJxnlzCFP03aiy', 'siswa', '2025-09-13 05:20:16', '2025-09-13 05:20:16'),
(181, 'IBNU QODA', '232410101', '$2y$12$BKi27iEPnBZnnOEDpRnjhuaPQFD.VCxtvVAsNkmjlNkZs73fS6Vdi', 'siswa', '2025-09-13 05:20:16', '2025-09-13 05:20:16'),
(182, 'IHYA ULUMUDIN', '232410102', '$2y$12$nS8XBMJhId2roejbf8KxBuiJoRKsQHvr8S1.YNFb9.5B10Q6lIy3y', 'siswa', '2025-09-13 05:20:16', '2025-09-13 05:20:16'),
(183, 'INTAN DAHLIA', '232410103', '$2y$12$lE9gpFfGmsX5XNSja9/8CO3r2ZfRU4I0xTWoLb0WdTCI4K1RvF4Q.', 'siswa', '2025-09-13 05:20:17', '2025-09-13 05:20:17'),
(184, 'INTAN NURAENI', '232410104', '$2y$12$5jZpiDYYzwBp7ds7Hny5kO4BfwClqUJv6cuAqrl1nGXYQvZldSc9i', 'siswa', '2025-09-13 05:20:17', '2025-09-13 05:20:17'),
(185, 'LISNAWATI', '232410105', '$2y$12$FofkQWE0EmlEqyk27WetVuN3cHSwA2qSZpkFSwlNrARw4pbL1X796', 'siswa', '2025-09-13 05:20:17', '2025-09-13 05:20:17'),
(186, 'MAMAN ABDUL RAHMAN', '232410106', '$2y$12$MKncem3Xf5ez5FRdUJLx6OeZ7jXlMHO0FVRhLAXZapyMV8pIzX2uC', 'siswa', '2025-09-13 05:20:17', '2025-09-13 05:20:17'),
(187, 'MEILANI PUSPITA SARI', '232410107', '$2y$12$RNA6RXT3FLjqGc5zEjWW9O5WnKpc0.Wwq7MDoGom4s8kXo6e47oSW', 'siswa', '2025-09-13 05:20:18', '2025-09-13 05:20:18'),
(188, 'MUHAMAD AL NAZIB', '232410108', '$2y$12$V7Dz1lzcjiYY0zl0HPj7R.9GiB80DIhCCGMF.L/rAD52NAuvyJaji', 'siswa', '2025-09-13 05:20:18', '2025-09-13 05:20:18'),
(189, 'NADIA ASMIRANDAH', '232410109', '$2y$12$5pQA0x7pT6fRdUtJvd0nYeyIqOFKbrPGQ/Jl66gCpI1j.bZvzT4r2', 'siswa', '2025-09-13 05:20:18', '2025-09-13 05:20:18'),
(190, 'NATA ADITIYA', '232410110', '$2y$12$2BUAFAmSSE4bXLOTQ.TMxuVbY4PoE/TmIv2GPjF3U7k65T37HSayG', 'siswa', '2025-09-13 05:20:18', '2025-09-13 05:20:18'),
(191, 'NOFITA DEWAN TARI', '232410111', '$2y$12$mC1Y88txHAD.2DkWheZ0oOKrwdHrkOCyT.JSooERuC/5jGVz3D5i.', 'siswa', '2025-09-13 05:20:19', '2025-09-13 05:20:19'),
(192, 'NOPAL BUKHORI', '232410112', '$2y$12$JPrTpqn5EeKp4W1GtIIoienx/75PCasTMyrj.VSD8Ssc1ZruiqFEC', 'siswa', '2025-09-13 05:20:19', '2025-09-13 05:20:19'),
(193, 'NOVIANTI', '232410113', '$2y$12$eIXcqOT7O6ZjMxAe6L5Ro.WvrKcgIgFdAfCyDTu67vXtOsWf8P/IW', 'siswa', '2025-09-13 05:20:19', '2025-09-13 05:20:19'),
(194, 'RIDWAN FADILAH', '232410114', '$2y$12$ipPuX4orWufUEbX5EFJ6YOGhN38dhmgJtOc83SOUlgqf22vsV.Wj2', 'siswa', '2025-09-13 05:20:20', '2025-09-13 05:20:20'),
(195, 'SISKA AULIA', '232410115', '$2y$12$62VxvWoZLzZxK9JXJqbujeuD3SBc/opOXiFBzjqDJ9GpHEKXEqTGm', 'siswa', '2025-09-13 05:20:20', '2025-09-13 05:20:20'),
(196, 'SUHENDAR', '232410116', '$2y$12$zorJzY84tMuQkfteZPAAwOxVJ0VgrMMjB2kEhy5RFYRYl7gXDWrVy', 'siswa', '2025-09-13 05:20:20', '2025-09-13 05:20:20'),
(197, 'TOMI', '232410117', '$2y$12$zUB..3FaYhmRewovYNiXG.6Cfujz9YyMszgy8I192h04Tx36/G9FC', 'siswa', '2025-09-13 05:20:20', '2025-09-13 05:20:20'),
(198, 'WARTA', '232410118', '$2y$12$1mPys3ATKlpcSh47wcKthOiH/Y61PzZw715CCYEZ.FQChxcbUHljC', 'siswa', '2025-09-13 05:20:21', '2025-09-13 05:20:21'),
(199, 'ADAM MARIANSYAH', '232410119', '$2y$12$oF0HgklVDX0zmDLHOzEM..GjiqUlL6DzZe5KE7NW1TBcQjrBG7NtO', 'siswa', '2025-09-13 05:20:21', '2025-09-13 05:20:21'),
(200, 'AJIJAH LESTARI', '232410120', '$2y$12$Awlgjh7DbbKVIIwu98Bnx.9uu/UlbFZ4yuio2vkgNUt8eCKFegBFa', 'siswa', '2025-09-13 05:20:21', '2025-09-13 05:20:21'),
(201, 'ANDRIAN', '232410121', '$2y$12$lxJGgG0hMcUqU7VJmOvCiuZs1Q4XNaWmDOiwYbeEGX06T1GwlOyUC', 'siswa', '2025-09-13 05:20:21', '2025-09-13 05:20:21'),
(202, 'DENDI PRASETYO', '232410122', '$2y$12$O8AYrdoQ4lLmQWaKll/0zuTOIucx3q0QgGROfNeMtWB3sNmvNkkJi', 'siswa', '2025-09-13 05:20:22', '2025-09-13 05:20:22'),
(203, 'DIANA PUTRI AWALIAYAH', '232410123', '$2y$12$TojrRCBMLAKxbhrGhkonsObHLYVa8LeRfYUgYCNhKNQOuqaOsz.16', 'siswa', '2025-09-13 05:20:22', '2025-09-13 05:20:22'),
(204, 'DIFA HARIKURNIA', '232410124', '$2y$12$KOl6DF0/XZmkw2Vpz/oL2.v71UBs5Bf5WvNPQO4f0WaHr1e6u5Omm', 'siswa', '2025-09-13 05:20:22', '2025-09-13 05:20:22'),
(205, 'ENAH MAEMUNAH', '232410125', '$2y$12$5LPOgPMEE13bdHANwxKwrObdcDMEPdkI4sIWdJAQ5y6SAaohrqecm', 'siswa', '2025-09-13 05:20:23', '2025-09-13 05:20:23'),
(206, 'FAIQ AHMAD NAUFAL', '232410126', '$2y$12$mYqwV9tDpUakKRMRsg0pquLDMBN.I/asESkqxG4SY8N2cD2vb47ki', 'siswa', '2025-09-13 05:20:23', '2025-09-13 05:20:23'),
(207, 'FERI SOPANDI', '232410127', '$2y$12$rZ5x5SBYwIEATU7Dvxod/eH0U08Cdk0HSIenLxo4aacDw6ePTzeei', 'siswa', '2025-09-13 05:20:23', '2025-09-13 05:20:23'),
(208, 'IKBAL MAULANA IBROHIM', '232410128', '$2y$12$CUwCGA8eRXBbMCj.xs3ep.iC2g3DYUpRE5qpGc4WTcU86NjQyTk3O', 'siswa', '2025-09-13 05:20:23', '2025-09-13 05:20:23'),
(209, 'KASMINAH', '232410129', '$2y$12$.C8B3wFJOu6jE87HG2esOOMRiDp.Al2KUHL/uNMTkuc4jPTbwlT0.', 'siswa', '2025-09-13 05:20:24', '2025-09-13 05:20:24'),
(210, 'KATIMAH', '232410130', '$2y$12$r2lZmYhdOtamRseuPUTBPuepIuyXlneg.bbrCftQSIFJNBzg2Ve4m', 'siswa', '2025-09-13 05:20:24', '2025-09-13 05:20:24'),
(211, 'LIGAR', '232410131', '$2y$12$KDK4w3CFQi1B/eny160G9OGMhj2xXU6.NHZZ7GtP8yAtDoh.3z.pm', 'siswa', '2025-09-13 05:20:24', '2025-09-13 05:20:24'),
(212, 'MAYA', '232410132', '$2y$12$F74PX1.XqeUHpYvqCic6DusFvyp2j3ZUS1W6dNn/V4XFukqBUZzUW', 'siswa', '2025-09-13 05:20:24', '2025-09-13 05:20:24'),
(213, 'MOH THOLIB RIVKI', '232410133', '$2y$12$XvIJcOVabji1hfXQU6mVlenrbGs5FDaHB31Q95EmiuSOY.3HqqaMu', 'siswa', '2025-09-13 05:20:25', '2025-09-13 05:20:25'),
(214, 'MOHAMAD FEBRY AULIA', '232410134', '$2y$12$Z2BdxVMuLK/W2nb.fv63s.YIQ5KxG9P05hu/MsprSPEGZqj43.Fje', 'siswa', '2025-09-13 05:20:25', '2025-09-13 05:20:25'),
(215, 'MOHAMAD RIDWAN', '232410135', '$2y$12$8NDbO26A.8wcWND94YtwY./nkomU6HNe060aHEOVHF6wZGqtdl2km', 'siswa', '2025-09-13 05:20:25', '2025-09-13 05:20:25'),
(216, 'MUHAMAD HAIDAR RIFAI', '232410136', '$2y$12$T6BcPO4hYD.6y1Q41NParOyrCzWUOGKFVnpL1I3kS/BEYlm7jnc8C', 'siswa', '2025-09-13 05:20:26', '2025-09-13 05:20:26'),
(217, 'MUHAMMAD WAHYUDI', '232410137', '$2y$12$kILWKF6bCsmQY3Fxt11TS.0BPD9m0Jq77KgNxAemMv3nBeJhBd2Qi', 'siswa', '2025-09-13 05:20:26', '2025-09-13 05:20:26'),
(218, 'NADILA LIESHARTANTI', '232410138', '$2y$12$AQDoSrmAkcB4Fup3mlQVROnKEcDSuUMt1L28PXkdeOx.0mIL.l8bK', 'siswa', '2025-09-13 05:20:26', '2025-09-13 05:20:26'),
(219, 'NARMAN', '232410139', '$2y$12$vVMoyrOLBCZbqLPEs2IQbu1f685jqzKQRTMM.QHv7X1OL8Q.L9Q6y', 'siswa', '2025-09-13 05:20:26', '2025-09-13 05:20:26'),
(220, 'NOVA YANTO', '232410140', '$2y$12$WHYXeNOxQ/r.ek9akCnA8uOBPNu7rq.8piSFAVrape5ZoZR19fkXG', 'siswa', '2025-09-13 05:20:27', '2025-09-13 05:20:27'),
(221, 'OGI WIRAGUNA NAMRAIH', '232410141', '$2y$12$E8DkC.GhPQuPkRy.83k/BeKX3oJj9RPU9teoJCtgiW49fRg/uTL6u', 'siswa', '2025-09-13 05:20:27', '2025-09-13 05:20:27'),
(222, 'PEPEN FAISAL AGUSTIAN', '232410142', '$2y$12$VkyKM0RzaCBVTZQJktuN/ONc36Orm4XpwODqsTXVZwesivC3wZ2zq', 'siswa', '2025-09-13 05:20:27', '2025-09-13 05:20:27'),
(223, 'RAHIL TRISNA', '232410143', '$2y$12$Det8B36rU2DEfX.OZi6Yd.evpqRdGtaiRKzFDldrlGi62JH9QW7TW', 'siswa', '2025-09-13 05:20:28', '2025-09-13 05:20:28'),
(224, 'RAMDANI', '232410144', '$2y$12$8uaXWZCVZqM3vyf60wl9d..CtsUnaAyXxEaBwdeWeKLKBZ.Fvyc32', 'siswa', '2025-09-13 05:20:28', '2025-09-13 05:20:28'),
(225, 'RANGGA MUHAMAD FARHAN', '232410145', '$2y$12$Wc/njudHDjRW3Yk8nUvHaOmXRI14lYI0tsLGbSlD8vs/rJECU.mry', 'siswa', '2025-09-13 05:20:28', '2025-09-13 05:20:28'),
(226, 'RATU AYU SARI', '232410146', '$2y$12$Cze/uXejZGHzNsF3FnykTuXUuAM.2VRQQrXbVBE34Tw.kB34iwO66', 'siswa', '2025-09-13 05:20:28', '2025-09-13 05:20:28'),
(227, 'RENDI SUJAYA', '232410147', '$2y$12$GayIjPt/75KPYCHExDoK7OqvxBTzdKBJfrNFkICnY6whg4DRUByAC', 'siswa', '2025-09-13 05:20:29', '2025-09-13 05:20:29'),
(228, 'RENO AL FAUZI', '232410148', '$2y$12$rFKYVJFWZB5L.he0BVBwIu.0NwC3.fOfaGUY2d.3yGtNxzdJigz7C', 'siswa', '2025-09-13 05:20:29', '2025-09-13 05:20:29'),
(229, 'RIDWAN IBNU AL FARIJI', '232410149', '$2y$12$as.7cK0XHyUQ5vonvsQeb.GeT.YRqYfiZj/bBl.5CHKPhRnCzw4vq', 'siswa', '2025-09-13 05:20:29', '2025-09-13 05:20:29'),
(230, 'RIFA AHMAD SOFYAN', '232410150', '$2y$12$iatHpEJQwiZGwVNwWquMr.X5Xut2Y1wZYzUv07KRlBQFvJjjMJM36', 'siswa', '2025-09-13 05:20:30', '2025-09-13 05:20:30'),
(231, 'SULTAN PERMANA PUTRA', '232410151', '$2y$12$PwDDlOn8miA0oLTguxO96Ok.4rZCKB/CO7.jioytWNTjiXoO3PH3O', 'siswa', '2025-09-13 05:20:30', '2025-09-13 05:20:30'),
(232, 'SUPARDI', '232410152', '$2y$12$LXYob3N9dYUlYH/WQ6141.PTSqSEV9t.EWcEBXKb4Sq3L5hbdSOo.', 'siswa', '2025-09-13 05:20:30', '2025-09-13 05:20:30'),
(233, 'WIDIA', '232410153', '$2y$12$/DRaLkYWBbQwLlRL7dmC2utUAbTiABVf4uiTVkT762dPk1UYrIVL6', 'siswa', '2025-09-13 05:20:30', '2025-09-13 05:20:30'),
(234, 'ABDUL ROSID', '232410154', '$2y$12$2wfBlJwjSSKuNiaCDrp/c.iXrk3J91HPX/NDLya03.XRWxoUFBT9i', 'siswa', '2025-09-13 05:20:31', '2025-09-13 05:20:31'),
(235, 'AGUS', '232410155', '$2y$12$REXYe/e2DhViyn1RQ3WTAOmmCrjMxL85mcFNia9ilLA2AXmgzQwRe', 'siswa', '2025-09-13 05:20:31', '2025-09-13 05:20:31'),
(236, 'AHMAD BAGIR', '232410156', '$2y$12$9LTUWNpbzLWcJy8PVM1INuszb4JIw86wmcBV8lkMqMg75BifflVfm', 'siswa', '2025-09-13 05:20:31', '2025-09-13 05:20:31'),
(237, 'AKBAR BAIDILLAH SATORIK', '232410157', '$2y$12$d7suoO2DSasBwpzi.2e8LuZmL.8iJdFhzwOubveKF2ZZEx395nw1G', 'siswa', '2025-09-13 05:20:31', '2025-09-13 05:20:31'),
(238, 'AMIRAH YULYANTI', '232410158', '$2y$12$sj25d8xsEp74rCqoJ7NfgOSTudIQggltMXR3H/6AnR8URmLF0MpMS', 'siswa', '2025-09-13 05:20:32', '2025-09-13 05:20:32'),
(239, 'ANGGUN LESTARI', '232410159', '$2y$12$ghQhXK6GwOsZz2c30meJoOIMY/1qyGX3fU4tUIW6imGQmgF0OG2/W', 'siswa', '2025-09-13 05:20:32', '2025-09-13 05:20:32'),
(240, 'DAHVA DERIANSAH', '232410160', '$2y$12$rtqMOBI85Cloot3VDOamCeHBARD/ToavLEZHawNtp9diq6SSxaxju', 'siswa', '2025-09-13 05:20:32', '2025-09-13 05:20:32'),
(241, 'DANA MAULANA', '232410161', '$2y$12$ebpfwWBwhp94Ee6R8iRhJugcKrYNs/2MLG9DHA7d8aFaHK6so4OrK', 'siswa', '2025-09-13 05:20:32', '2025-09-13 05:20:32'),
(242, 'DEA NOVITA', '232410162', '$2y$12$M07JVioI2Dt8WIFG24.nDeOFiO23vNKT6Ar7awU5hPEc3TZ1it.O.', 'siswa', '2025-09-13 05:20:33', '2025-09-13 05:20:33'),
(243, 'ELVIRA SELOMITHA ALENA', '232410163', '$2y$12$t5Jf0xUCAxkxPcpiy4yMw.DFeX7WF8Z0QKNhgqtMXs/BbwxDdv9vu', 'siswa', '2025-09-13 05:20:33', '2025-09-13 05:20:33'),
(244, 'FACHRY HABIBURROHMAN', '232410164', '$2y$12$alIPyVZto2n1nTx4EFKndOcZE7Wbw.4.2Qnecvl2axKyrB.NoQQFi', 'siswa', '2025-09-13 05:20:33', '2025-09-13 05:20:33'),
(245, 'FEBRIAN', '232410165', '$2y$12$4JcmQRStYlIkODWPaWVmS.bw24mDvnxIIi9LQtWxur6b8xjsLacpe', 'siswa', '2025-09-13 05:20:34', '2025-09-13 05:20:34'),
(246, 'JANE DIKE PUTRI ARIAWAN', '232410166', '$2y$12$GKnt5LS.jem5ZHIJU2h5VOpOLeXilfLDwHGUHtTHjVj0O6DtIGH4q', 'siswa', '2025-09-13 05:20:34', '2025-09-13 05:20:34'),
(247, 'KOMALASARI', '232410167', '$2y$12$LkBUWdzwP2MWCdoNX245ceqGwzrrjo8Qh7d0Kav2.P406lKIUd54y', 'siswa', '2025-09-13 05:20:34', '2025-09-13 05:20:34'),
(248, 'LUVITA RAHMA SARI', '232410168', '$2y$12$pJ/WjS68RIMZSXSlMagw0eGIj1347WzZphps5fcPByqiPNub0a5m6', 'siswa', '2025-09-13 05:20:34', '2025-09-13 05:20:34'),
(249, 'MAHMUD MUNANDAR', '232410169', '$2y$12$MPdlMF7qMRwtN9YkBW0lh.htMH8PdD6Pnzz/OmygVTLTimvFcempu', 'siswa', '2025-09-13 05:20:35', '2025-09-13 05:20:35'),
(250, 'MARISA LINDA LESTARI', '232410170', '$2y$12$kRyX7GdHVvNuMepNrzh0begzhmmwodZsd0lyoAhWUJgr9PkHxHmay', 'siswa', '2025-09-13 05:20:35', '2025-09-13 05:20:35'),
(251, 'MILA SARI', '232410171', '$2y$12$lHq1iky1xafiJj2Vrm3Nz.g3sCyCRFLci3KYDAfzJhh0pLTPfO.22', 'siswa', '2025-09-13 05:20:35', '2025-09-13 05:20:35'),
(252, 'MUHAMAD RAIHAN GUMILAR', '232410172', '$2y$12$SeBh0XLOeC8nTmfk8OEGfOuEiU5ITGKWg8Dg2yWSNsPXrUOJPYmAC', 'siswa', '2025-09-13 05:20:35', '2025-09-13 05:20:35'),
(253, 'MUHAMAD YUGA', '232410173', '$2y$12$8vAUeH5UHnCVFkaKp3zBKeyke.wTrzxkVLC3n0r9E4NYFTMR5HwDO', 'siswa', '2025-09-13 05:20:36', '2025-09-13 05:20:36'),
(254, 'RAFI ALHABSY', '232410174', '$2y$12$70F0G6w/fBVUUWz9WjNLk.f3Qgum3CmHhL/Y7I6dRCBu8Ooclp4E2', 'siswa', '2025-09-13 05:20:36', '2025-09-13 05:20:36'),
(255, 'RAHMAN', '232410175', '$2y$12$nES2cy9tkPlfkpykhOE3U.0hxEVgtRU1wEiyBIPJDQNMLVD2WOuHa', 'siswa', '2025-09-13 05:20:36', '2025-09-13 05:20:36'),
(256, 'RAZAN MUHAMMAD IHSAN', '232410176', '$2y$12$iWcC5Kc9jsGZcgMY1.4rseYVvLU1B7Qy8eTMPAocutIrHzBiOjwGm', 'siswa', '2025-09-13 05:20:37', '2025-09-13 05:20:37'),
(257, 'RIAN ADRIANSYAH', '232410177', '$2y$12$aaG6/ReFTqyRo55CkQ7see9Ntasw59rsT5.qQOmp5VEOiUbPnq3jG', 'siswa', '2025-09-13 05:20:37', '2025-09-13 05:20:37'),
(258, 'RIAN FIKRIANSAH', '232410178', '$2y$12$AoUWy8dlxgA.f52bpxtL7OP8LIM7bMuLdZaUfdz2DvR/GN9bilo5u', 'siswa', '2025-09-13 05:20:37', '2025-09-13 05:20:37'),
(259, 'RIF AN RIZIQ', '232410179', '$2y$12$r.RqR1y1PQAkLH5/CbEcbejV.zWGFYxYnHNYUYWpKLbG5mBbglgr.', 'siswa', '2025-09-13 05:20:37', '2025-09-13 05:20:37'),
(260, 'ROHMAT HIDAYAT', '232410180', '$2y$12$uc2NKtWR8GR1B7wXzqTC7eqWD11.nI5i0ufLebbMnDZBw7zmvgjjG', 'siswa', '2025-09-13 05:20:38', '2025-09-13 05:20:38'),
(261, 'RUDITA PRATAMA', '232410181', '$2y$12$OENne/cBiiE31BJgiqsO1uf7svNAF2acPGu.PwI2eT3Pj/KzaMTFm', 'siswa', '2025-09-13 05:20:38', '2025-09-13 05:20:38'),
(262, 'SOPAN SOPIAN', '232410182', '$2y$12$3Phma9tmIkDpXjFzKmWFXewjoY/3wvkD2APvI0anas4whPB2wUAq2', 'siswa', '2025-09-13 05:20:38', '2025-09-13 05:20:38'),
(263, 'SRI WULANDARI', '232410183', '$2y$12$swAstB2EoSjxrgpjlqFg8ua4IUINYjFkcp19Ckrv19BYLTWXZsIIa', 'siswa', '2025-09-13 05:20:38', '2025-09-13 05:20:38'),
(264, 'TONI JAYA SAPUTRA', '232410184', '$2y$12$0POJDHwtCRlTPoftaZ2TnewacI3FNlooBSl5JUoovvl/mK5k605C6', 'siswa', '2025-09-13 05:20:39', '2025-09-13 05:20:39'),
(265, 'USUP', '232410185', '$2y$12$B/jiJMjCq6T1N7A8ydS43.7JpQAAhjGcHh4Mybrk4.urlm0IgO..C', 'siswa', '2025-09-13 05:20:39', '2025-09-13 05:20:39'),
(266, 'WAHYU REKSA DIFA', '232410186', '$2y$12$nq0bSZKpsJ8sX7SFI/rQyeXCgshwD0PRUtK0qa4mYagM1DUEdq7Bq', 'siswa', '2025-09-13 05:20:39', '2025-09-13 05:20:39'),
(267, 'YAYAN HERMANTO', '232410187', '$2y$12$B7SrCziJI7bt.k7qzdqbiuCVJszJONInG7uzKsQyGYCqkO1scA3Cy', 'siswa', '2025-09-13 05:20:39', '2025-09-13 05:20:39'),
(268, 'AHMAD FAUZAN', '232410188', '$2y$12$7Y0qiBu63rojE/MBWj9CmOhMTy/TJvirsbzca3FfvCK2Uiehw.LHK', 'siswa', '2025-09-13 05:20:40', '2025-09-13 05:20:40'),
(269, 'AKBAR NANDA RUKMANA', '232410189', '$2y$12$uEmlGoyiz0.JoSlhENCH.Oio7fNuwdjkMf841pivCbZwq3c9oc9Um', 'siswa', '2025-09-13 05:20:40', '2025-09-13 05:20:40'),
(270, 'ANGELLYA', '232410190', '$2y$12$Nn9Gf0ScalJj.NsqTi.CeuvXAVeQ7NeWNJiTnke5rJ4mdoylZ3yTi', 'siswa', '2025-09-13 05:20:40', '2025-09-13 05:20:40'),
(271, 'APID', '232410191', '$2y$12$SSao5bbqaJYUY.xDneG4VuRgDX01wt4SRQUccLJ6UHsJrih7xDNGS', 'siswa', '2025-09-13 05:20:40', '2025-09-13 05:20:40'),
(272, 'DIAN MUHLISOTUL ULFIAH', '232410192', '$2y$12$vJNwB5g/yxk8WXpjvsD5leA/QDslHMPlg7ASIphghC2GxLHUPv2Ze', 'siswa', '2025-09-13 05:20:41', '2025-09-13 05:20:41'),
(273, 'DIAN PERMATASARI', '232410193', '$2y$12$.G./hl78wuhLfjyI47MLY.bJldJwlR0HKwD3vLVaiOBy4mE9opR0K', 'siswa', '2025-09-13 05:20:41', '2025-09-13 05:20:41'),
(274, 'EKA PURWANA', '232410194', '$2y$12$w01FcKwy8amQXExXwl0zleZ/S4Ecnxfj1B74YHitIETWqXq1AYN56', 'siswa', '2025-09-13 05:20:41', '2025-09-13 05:20:41'),
(275, 'FAISHAL FAKHRI', '232410195', '$2y$12$RupcvkYpYYG6C1isgBsxcOIZdHR6IX9YX66UlpcpICjG0w3C3wT4a', 'siswa', '2025-09-13 05:20:42', '2025-09-13 05:20:42'),
(276, 'HADI RAHMAN', '232410196', '$2y$12$gRJTi6AmVdQQ31kfSlier.ZS1p4IZGAYx6IVEVHWVgJvmXN6FW0Na', 'siswa', '2025-09-13 05:20:42', '2025-09-13 05:20:42'),
(277, 'INTAN', '232410197', '$2y$12$onSuuCDC08pe/wF9auElQOpE9YUSP1D246WOBy3DK/bbaM7AMXPMC', 'siswa', '2025-09-13 05:20:42', '2025-09-13 05:20:42'),
(278, 'IRSAN TICKNO', '232410198', '$2y$12$MPgJwnCj3Tz2PDI/A9VURu/Cnq7vYvU8w.fexGcr6QBbei.pUhdHi', 'siswa', '2025-09-13 05:20:42', '2025-09-13 05:20:42'),
(279, 'JAJANG KOSWARA', '232410199', '$2y$12$0OGY3lHuk1X.hUyEgOlNyOxPR6G.i6vSISzaEnBNuSbfqdQ5qigQq', 'siswa', '2025-09-13 05:20:43', '2025-09-13 05:20:43'),
(280, 'NAJRIL ILHAM', '242510200', '$2y$12$0toRj9.9AIebZzqP4.wwi.2WYFeaHCOmwmyQa8sj2gzzWzZNjE15u', 'siswa', '2025-09-13 05:20:51', '2025-09-13 05:20:51'),
(281, 'NANANG KOSIM', '242510201', '$2y$12$HqcW1HDPUSqaIzpOP0bN/eIQlqnNYDDhR7AhIx2oYlcf2mEWIUUoW', 'siswa', '2025-09-13 05:20:52', '2025-09-13 05:20:52'),
(282, 'RIPA HAMDANI', '242510202', '$2y$12$p7YVevOEnypgIDanFQo8NuzZ/EPCkMpZ1s8YFuNewb1yIFBWw3f1m', 'siswa', '2025-09-13 05:20:52', '2025-09-13 05:20:52'),
(283, 'RIZKI AHMAD HAMBALI', '242510203', '$2y$12$upqnZJHZ.TUROef51mAmCuwESxqADxoXtVSImt/I/ZjUuEuEmGT.i', 'siswa', '2025-09-13 05:20:52', '2025-09-13 05:20:52'),
(284, 'SAEPUDIN', '242510204', '$2y$12$/pMzhlQ7srwzMARu9NyHuu50VQqpT5R/URvSEkCxlm05CPBhjsSNi', 'siswa', '2025-09-13 05:20:53', '2025-09-13 05:20:53'),
(285, 'SAKTI GENTA AIRLANGGA', '242510205', '$2y$12$A3vD6YcsFxWLhHsH0eYvc.Xlsl8y9S1AlcTFNUkT9E3wyiyIN68Nu', 'siswa', '2025-09-13 05:20:53', '2025-09-13 05:20:53'),
(286, 'SASKIA MURNI ATI JUANDI', '242510206', '$2y$12$7KAUhrGcCTD.rUt3xY8DHelfV3ZYZaGSquO4m0YQzRmzf.pZOtYFO', 'siswa', '2025-09-13 05:20:53', '2025-09-13 05:20:53'),
(287, 'SITI HALIMAH SADIYAH', '242510207', '$2y$12$GvP7kJOsSxWMa.ggV6QyTOArpeBfH33whdiNjgq8ZORhhJZX/cota', 'siswa', '2025-09-13 05:20:53', '2025-09-13 05:20:53'),
(288, 'SODIK RIFAI', '242510208', '$2y$12$OIk1DbI46G2luAIP1iT06.qmFM87TG3STePMedMOcIyoEJw//nY7K', 'siswa', '2025-09-13 05:20:54', '2025-09-13 05:20:54'),
(289, 'WIDIA RAHMA SARI', '242510209', '$2y$12$eCT1TwqsyKJyKoHDBJ62ZeZA0xLfNPBTUo.WeXFvoWd4rGvm63dbi', 'siswa', '2025-09-13 05:20:54', '2025-09-13 05:20:54'),
(290, 'WILDATUL RAHMATUL UMMAH', '242510210', '$2y$12$6on5MTm6DkpN8Q5SX0rzh.VgkkLi3NDwhBQDGq8zAPCPsAyNU9EHW', 'siswa', '2025-09-13 05:20:54', '2025-09-13 05:20:54'),
(291, 'AGNA FATHURROHMAN', '242510211', '$2y$12$2wjnDOtVXctPXQklTy5DheYtiaq/FhWMMkWrUf5A2HZKs6r1qKUjq', 'siswa', '2025-09-13 05:20:55', '2025-09-13 05:20:55'),
(292, 'ALI AHMAD DINEZAD', '242510212', '$2y$12$jvUcx/iw9H.fPrb09.k36.2pta4.uiSroA1xJUVyIKu3iMBlJUYXe', 'siswa', '2025-09-13 05:20:55', '2025-09-13 05:20:55'),
(293, 'ALNAZRIL ANASSYAH', '242510213', '$2y$12$tIx/rlT8pO5COEs9URr9iucFFEQLg4ij7tXs7VYrjRj75GBxeBNre', 'siswa', '2025-09-13 05:20:55', '2025-09-13 05:20:55'),
(294, 'ANGGA', '242510214', '$2y$12$T5xwM/Xd/hwFLk0VUgFtW.Ni8dVlFUyeQmgMmF1JIhb720kxuc/uG', 'siswa', '2025-09-13 05:20:55', '2025-09-13 05:20:55'),
(295, 'DERI SAEPUDIN', '242510215', '$2y$12$3CR1GCmLLpAHrdghw.aO8eF4HFxMLM5xKIsP.Tmu2.cNwryE/yXk2', 'siswa', '2025-09-13 05:20:56', '2025-09-13 05:20:56'),
(296, 'DIKI PURNAMA', '242510216', '$2y$12$hLH5fETwFQCkA94XEwEhKOqxGC2Z8dF4.BaBR2KcyS9/PApftZYT.', 'siswa', '2025-09-13 05:20:56', '2025-09-13 05:20:56'),
(297, 'FAUZI RIDWAN', '242510217', '$2y$12$Fp4epYmuRokNUiBHCEfdI.L2B8FjMH0lzAP1dq.tiMkIcv65EbGDG', 'siswa', '2025-09-13 05:20:56', '2025-09-13 05:20:56'),
(298, 'GILANG ANGGA KUSUMAH', '242510218', '$2y$12$8TbssunPDaVEzhcmkZswYOcD8q5sErpdbjEw.PaO7P2GGW0svTeWa', 'siswa', '2025-09-13 05:20:57', '2025-09-13 05:20:57'),
(299, 'IMARRUL UMMARA', '242510219', '$2y$12$VoR0.66Bweb2C8b/uFvpreUQnqFaIhxaYjxtZ9WvVrIH6vhiK1Hvy', 'siswa', '2025-09-13 05:20:57', '2025-09-13 05:20:57'),
(300, 'KARTOBI', '242510220', '$2y$12$6G.Xkh.PtHhFuG8VIjH3V.rmRcprS4oee92JWBj5ox.UasCitpTAm', 'siswa', '2025-09-13 05:20:57', '2025-09-13 05:20:57'),
(301, 'MALIK IBRAHIM', '242510221', '$2y$12$rPnkSTcX8hjH2yz59nIpk.C5oCs1X5HgxW9K5DXrH0n9wTvKvH8zq', 'siswa', '2025-09-13 05:20:58', '2025-09-13 05:20:58'),
(302, 'MARSELA', '242510222', '$2y$12$M7waTgySiw3xkuz3LpgNXuHa9d7OKft69qNP6OrPoG/OPBdM9BtBm', 'siswa', '2025-09-13 05:20:58', '2025-09-13 05:20:58'),
(303, 'MUHAMAD FARIS DZULFIKAR', '242510223', '$2y$12$EXxWLSRu/OvHniWPEGIFlu42.EPhUVLYQ9Tp62qbLV36wtimEVONu', 'siswa', '2025-09-13 05:20:58', '2025-09-13 05:20:58'),
(304, 'MUHAMAD REHAN BAROKAH', '242510224', '$2y$12$FbesFzNdcgEZKhTRkBpLSO4AGk8APU1NLKgy.Q483evBJWoI/ytz.', 'siswa', '2025-09-13 05:20:58', '2025-09-13 05:20:58'),
(305, 'MUHAMMAD RAIHAN FEBRIAN', '242510225', '$2y$12$KMsX7BPmm/IhT6AynuQ4Ae8pQi2Irgtwdv6qvV1hLe3.yY8XenM6K', 'siswa', '2025-09-13 05:20:59', '2025-09-13 05:20:59'),
(306, 'RADIT RAMDANI', '242510226', '$2y$12$svxdjFbcnbzo8OnXis3g6OeQjCAaMD7TLAwrf82xOenmZvW0ZVPAS', 'siswa', '2025-09-13 05:20:59', '2025-09-13 05:20:59'),
(307, 'RAMDANI', '242510227', '$2y$12$zVnSZduxO9TATNRygcLbfeMbVLja44MQLxLzlaYAGM2GY7K3TZOfu', 'siswa', '2025-09-13 05:20:59', '2025-09-13 05:20:59'),
(308, 'REHAN MAULANA RIZKY', '242510228', '$2y$12$cQswlbXY8W1C7J6ZXJemiej3Fjzz66op6ZKmIMOWK1z5LiFDmbtny', 'siswa', '2025-09-13 05:21:00', '2025-09-13 05:21:00'),
(309, 'RENO APRIAN', '242510229', '$2y$12$9SnHqQeNE0Dj5.yiMupwcOi3vizYKjAVoQ9N8V1ShYGJt5OwqsUT2', 'siswa', '2025-09-13 05:21:00', '2025-09-13 05:21:00'),
(310, 'REYSSA PRIYUNITHA IVANA', '242510230', '$2y$12$SaKppZkWulyU8KYMWAu71.RAvQqsI/HYag/.CyI3UWB7T.JHx.xhe', 'siswa', '2025-09-13 05:21:00', '2025-09-13 05:21:00'),
(311, 'RIZKI', '242510231', '$2y$12$pP/RBJLQg4ZLN4.My17RxO9uqG8AlwPFc.0NDQAv5rAg1Uwxass/G', 'siswa', '2025-09-13 05:21:01', '2025-09-13 05:21:01'),
(312, 'SRI ANGGRAENI PEBRIANTI', '242510232', '$2y$12$X7HgAMEXaFFZWmv4bxLokeFQdWfXQ/RbbG9ksCv3fvP6k53GtXGru', 'siswa', '2025-09-13 05:21:01', '2025-09-13 05:21:01'),
(313, 'TASYA', '242510233', '$2y$12$z2I74Cnr8iQ4An1G247R.eT.AMb255E8FqBKBUheKX93JBIHvoLK2', 'siswa', '2025-09-13 05:21:01', '2025-09-13 05:21:01'),
(314, 'TAUFIQ HIDAYATULAH', '242510234', '$2y$12$R/sZhlt/ayoERrTYJiLGS.YTI2ZwoUCtvI3A98vXG8gYsMkNK2mBu', 'siswa', '2025-09-13 05:21:02', '2025-09-13 05:21:02'),
(315, 'TRISTANTO', '242510235', '$2y$12$LKyjqn506Re7DeGlch0JNutsdCkgpYJTLvfOPBWSFUMvKp8kFbPka', 'siswa', '2025-09-13 05:21:03', '2025-09-13 05:21:03'),
(316, 'WHILDAN SYAHRIZAL WAHYUDI', '242510236', '$2y$12$D2X0Recm6r8EnJRb5FfBl.4IR1hIIfXEousiNtfzY.n0js3yeV4fW', 'siswa', '2025-09-13 05:21:04', '2025-09-13 05:21:04'),
(317, 'ABDUL AZIS', '242510237', '$2y$12$f63OZ/hZRcLHU5edVyUYme17kUC7YlHxHzW8yg/aFt/n7sTWo6ka2', 'siswa', '2025-09-13 05:21:05', '2025-09-13 05:21:05'),
(318, 'ABDUL RAHMAN WAHYUDIN', '242510238', '$2y$12$R/mqV19QpFUbA4g.lgYYQ.2YbO8K7NpmSK4QWASnty4PPLc0N8R4W', 'siswa', '2025-09-13 05:21:05', '2025-09-13 05:21:05'),
(319, 'AHMAD FANANI', '242510239', '$2y$12$SCZEWTQYMN5OQzjnG3O7heh6ZGDFCBaEoBb/30NRcbgzVy8yEh3gO', 'siswa', '2025-09-13 05:21:06', '2025-09-13 05:21:06'),
(320, 'ALFA NURHIKMAH', '242510240', '$2y$12$FpqG5tkGz5EBrcApyjA0YOKKkFyF7ljjXuU/iGGnA4goK87Q0UeWa', 'siswa', '2025-09-13 05:21:06', '2025-09-13 05:21:06'),
(321, 'ANDRA PURNAMA', '242510241', '$2y$12$iiWLG29btru6U1QDyIQDHubcmgnZcmkrLfwCPjpUe52TgLWEscX8K', 'siswa', '2025-09-13 05:21:07', '2025-09-13 05:21:07'),
(322, 'ARINO ARDAN ARUBETH', '242510242', '$2y$12$Lls6vX7YgaAdBNaDoFRtUe1Wp6CnYg18e7wqRb6nGpEiLW8iAsVoK', 'siswa', '2025-09-13 05:21:07', '2025-09-13 05:21:07'),
(323, 'CARSIYAH', '242510243', '$2y$12$xsRvUEk4K4781yvbs2AxXerPqg.QcoUTGWoow6I59hO88SkoYWvgG', 'siswa', '2025-09-13 05:21:09', '2025-09-13 05:21:09'),
(324, 'CHICI NURSELA', '242510244', '$2y$12$fNjBmjI2F8UVUbF7vU3y9OYP4Y1NCHUWxF5eHFN3TUVhketZknDCC', 'siswa', '2025-09-13 05:21:09', '2025-09-13 05:21:09');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(325, 'DALAL IRWANSYAH', '242510245', '$2y$12$Ma5bRFdsTdRHZUz90TgZSu.AyMQInvsYzYnlngY.ofFhYbL7kjswG', 'siswa', '2025-09-13 05:21:10', '2025-09-13 05:21:10'),
(326, 'DODO WIJAYA', '242510246', '$2y$12$QoCbEoHyl/7gdm9Bo/YPZ.5c3ygWTjj3bSh82Gej5UgLXaMP3Qasa', 'siswa', '2025-09-13 05:21:10', '2025-09-13 05:21:10'),
(327, 'ELI HAYATI', '242510247', '$2y$12$zWeNMAHtf1RmbMzFOQE8auieaTqMPPmqjSH36aq/JHYK1l4Ninw0a', 'siswa', '2025-09-13 05:21:10', '2025-09-13 05:21:10'),
(328, 'INDRA', '242510248', '$2y$12$40SwNhOQ0U6sQxOdclll8uocnDJIV1unfbqaT4exQ.XzbI90yG6yO', 'siswa', '2025-09-13 05:21:11', '2025-09-13 05:21:11'),
(329, 'LAILA SAFITRI', '242510249', '$2y$12$FKu9cc4Fus2W952GhfF0m.qg/kknFhqpn5BUNTl8FbW9qV1Tgs/ju', 'siswa', '2025-09-13 05:21:11', '2025-09-13 05:21:11'),
(330, 'MAESAROH', '242510250', '$2y$12$DXGUnAt5t5gfHL/6DUoxTuPcYEwzpQop9ghFkvN8liR5xt1j0M1yy', 'siswa', '2025-09-13 05:21:11', '2025-09-13 05:21:11'),
(331, 'MUHAMAD RASYA RAMADHAN', '242510251', '$2y$12$M9DrWDqZFPSL3mhLYoK9Au4tr8MmZ5N9AkxicmegVWL4aoL.8ol8K', 'siswa', '2025-09-13 05:21:12', '2025-09-13 05:21:12'),
(332, 'MUHAMAD WAKAB', '242510252', '$2y$12$rkw4aJxK48sJY/6J2fFSeOTv6X7H9UahiKYh.QdjONWnBv9LHMlp6', 'siswa', '2025-09-13 05:21:12', '2025-09-13 05:21:12'),
(333, 'MUHAMAD WAKUB', '242510253', '$2y$12$80//yXVskUbscCPpl33/r.DfU1d9yrWiJjRk7hd.8GFeMz.A0VDdS', 'siswa', '2025-09-13 05:21:12', '2025-09-13 05:21:12'),
(334, 'MUHAMMAD RIDO RIDWANULAH', '242510254', '$2y$12$pl8A6Z73MHNaZDu3VfddDO8saBKTDEqNopaz3a9iaplc0oO8q5DlG', 'siswa', '2025-09-13 05:21:13', '2025-09-13 05:21:13'),
(335, 'NAJRIL ILHAM', '242510255', '$2y$12$Do5iGNlfuKcmVrDbBpLSj.q0GVPUbpMNgU5qcvheVlyFLWZixDS.S', 'siswa', '2025-09-13 05:21:13', '2025-09-13 05:21:13'),
(336, 'NIA RAMADHANI', '242510256', '$2y$12$6w1VXI7tfq8GXmedKj9Vf.jY8YVCEPzX1Raz8UpOCjNdjnjV8PBI.', 'siswa', '2025-09-13 05:21:13', '2025-09-13 05:21:13'),
(337, 'RANGGA ARDIAN', '242510257', '$2y$12$nnCkCHJ8LEHSWr/YnPb3JOuZ7.gwIh1kIVImRBK9av6N5mbcb4qBu', 'siswa', '2025-09-13 05:21:13', '2025-09-13 05:21:13'),
(338, 'RIZKI MAULANA', '242510258', '$2y$12$GNuKapQqeiF3oUeZ.LW.M.x9.X1ma/Mu4ON4NonYjLBKjwZCFbE/u', 'siswa', '2025-09-13 05:21:14', '2025-09-13 05:21:14'),
(339, 'SOPIAN GUNAWAN', '242510259', '$2y$12$csep1LAs2l2yO05H7qdTIuU8UCZ.N3v1CAhvHu1DDjFpZrMZbAhcu', 'siswa', '2025-09-13 05:21:14', '2025-09-13 05:21:14'),
(340, 'SUPRIYATNA RAMADAN PRASTIYO', '242510260', '$2y$12$ZrCDqmZ0gyhktDSsys05luFjSCGplKGn3FpepvnDE5niozp/twJyW', 'siswa', '2025-09-13 05:21:14', '2025-09-13 05:21:14'),
(341, 'VICRY APRIANSYAH', '242510261', '$2y$12$MjTSd.hBMmd/R1g13fSPu.MfcuIOZa159YdQMlEgYf3HH.Ayrbs76', 'siswa', '2025-09-13 05:21:14', '2025-09-13 05:21:14'),
(342, 'WANA MAULANA', '242510262', '$2y$12$r4R/qUfLtRmxvJgRUzMMJuKXDvhpMmmlF4qBNZ3mU9sVzc61In6ky', 'siswa', '2025-09-13 05:21:15', '2025-09-13 05:21:15'),
(343, 'WIRA ATMAJA', '242510263', '$2y$12$iunYEPEcEvb7ln.3o6xNeeR3AaZ6KGvO5jW5nbU3aE7i/46OxO.vK', 'siswa', '2025-09-13 05:21:15', '2025-09-13 05:21:15'),
(344, 'YUDA PRATAMA', '242510264', '$2y$12$.KVkA6lD.3No4uczD.vymOaNcWv2YIUB5vep755Fk4O2XOocR8yEe', 'siswa', '2025-09-13 05:21:15', '2025-09-13 05:21:15'),
(345, 'AMELIA', '242510001', '$2y$12$VBao0YcvsuFO7iBbBEJ5xOp.kiRb//1FIbLAomMqA5S526N/LOPYq', 'siswa', '2025-09-13 05:21:27', '2025-09-13 05:21:27'),
(346, 'ANISA RHAMADANI', '242510002', '$2y$12$f83WA7U/M45iIuTzTjeMFONfyap1qnzqj1.bu8xLxEziTKmkVr3re', 'siswa', '2025-09-13 05:21:27', '2025-09-13 05:21:27'),
(347, 'AYU NINGRAT', '242510003', '$2y$12$pLiguXLp5dghK2VoSAuQ1OWpaO4Hk.yn5ePZByrpAEYucs4ZQA/qO', 'siswa', '2025-09-13 05:21:28', '2025-09-13 05:21:28'),
(348, 'CINDI LESTARI', '242510004', '$2y$12$AVHija33.0T5Tm90pgSV2ukvjGmTIAUtANiG48VjZP/T9uUtYAUd2', 'siswa', '2025-09-13 05:21:28', '2025-09-13 05:21:28'),
(349, 'CITRA SHABILA IRAWAN', '242510005', '$2y$12$7FQ.OumcOCH0aAaO2.23cujqPshOPMBodSf/B0/QWi.yfiWfVaV/O', 'siswa', '2025-09-13 05:21:28', '2025-09-13 05:21:28'),
(350, 'DENITA SARI', '242510006', '$2y$12$/7JdPoPrMHGhk6.RO8ql1eP.g6TYAoOAPdtXlLHzH4iRb4fDgoo/i', 'siswa', '2025-09-13 05:21:29', '2025-09-13 05:21:29'),
(351, 'EVI NURAENDI', '242510007', '$2y$12$H.vK0E/658Dpxc7put7KE.xzcOit4khvsRHAXjwgliTVqV9DB5LJ2', 'siswa', '2025-09-13 05:21:29', '2025-09-13 05:21:29'),
(352, 'INTAN LESTARI', '242510008', '$2y$12$A3wTxdqjpJBEdO1YcM0HE.x/UEyIcJRoppKNEkH90fuCekG0j4X/2', 'siswa', '2025-09-13 05:21:29', '2025-09-13 05:21:29'),
(353, 'INTAN RASJI RAMADHANY', '242510009', '$2y$12$yQ3wjRmqv.0q7UnSf1WIU.j6bRlOm2Fcr6PU2JKFIY8huJ4tP2PPG', 'siswa', '2025-09-13 05:21:29', '2025-09-13 05:21:29'),
(354, 'KARLINA', '242510010', '$2y$12$Tn7oX95xBtP.xJ0Z/LxzEeRYfIhwvzOTLBc486oXUU7rfAtHJZ6z6', 'siswa', '2025-09-13 05:21:30', '2025-09-13 05:21:30'),
(355, 'KURNIA', '242510011', '$2y$12$YGYn4hfOnprhJg/a39s/XOtTS58KVVBPpI760xI4Sp7LsqXMMyaxe', 'siswa', '2025-09-13 05:21:30', '2025-09-13 05:21:30'),
(356, 'MAHENDRA', '242510012', '$2y$12$vcMZy.QKzSXG8IdTl7Fvj.hxkmN15rkkTrq4xyruzEMrGyR0sg23W', 'siswa', '2025-09-13 05:21:30', '2025-09-13 05:21:30'),
(357, 'MARPUAH', '242510013', '$2y$12$.aFiX6VNuvLAxRLlQrP.Hu6EMkCohSdpmp.Fk/erb2eTAs.b3N/0G', 'siswa', '2025-09-13 05:21:31', '2025-09-13 05:21:31'),
(358, 'MAULANA ANSORI SURYANA', '242510014', '$2y$12$/kVTbqNSJT.QAp2r6AQkHe/xpUKQLuYm3PiBvqJq1qwX049kGYCx2', 'siswa', '2025-09-13 05:21:31', '2025-09-13 05:21:31'),
(359, 'MAYLANI', '242510015', '$2y$12$fspjy1ekc2H77PiezRtUKeXxMvydndKRO4JAzSQcOTVB78qKUB9eS', 'siswa', '2025-09-13 05:21:31', '2025-09-13 05:21:31'),
(360, 'MUHAMAD ADHI SATRIO', '242510016', '$2y$12$j2TUNbTBlMesGBlqbzYQPOo0PTCuNNSuxvwPN.jtWEieyrMAL3NRC', 'siswa', '2025-09-13 05:21:31', '2025-09-13 05:21:31'),
(361, 'NUR SILVA OCTAVIA', '242510017', '$2y$12$Y3BjuFt3mPN1PbmGayFXhu80Zf6IcqvoevmmncklNzlw/EL1oL7F.', 'siswa', '2025-09-13 05:21:32', '2025-09-13 05:21:32'),
(362, 'NURMALA PUSPITASARI', '242510018', '$2y$12$dbbEpg19pLmSmXEFznqi1O/arCQXei59SyBdCuxQKQnoF2sGZIrrK', 'siswa', '2025-09-13 05:21:32', '2025-09-13 05:21:32'),
(363, 'QORIATUL FITRIYAH', '242510019', '$2y$12$zSF5mNe5JUBJSrvHFGy0fOwKkIAyBTt3Zz2Dcd/fEyhxjUtzi6I/C', 'siswa', '2025-09-13 05:21:32', '2025-09-13 05:21:32'),
(364, 'RAHMA PUSPITASARI', '242510020', '$2y$12$b8CjZ/znwF1reJgOFPp0dO7vdj5n6w/RMxKYmr8JI8sdH6mTFG2Rq', 'siswa', '2025-09-13 05:21:32', '2025-09-13 05:21:32'),
(365, 'RISKA APRILIA', '242510021', '$2y$12$YxmmGie9uLhgioPesrew9.kuFfVn2R2Cyw9zjZ9spm3dPvLDtdMGS', 'siswa', '2025-09-13 05:21:33', '2025-09-13 05:21:33'),
(366, 'RISMAYANTI', '242510022', '$2y$12$8kPoezSEGCXqUUb6Gc6ozejZ29yBQ4oqLbfkHb9mtqfAPEsM9cdRa', 'siswa', '2025-09-13 05:21:33', '2025-09-13 05:21:33'),
(367, 'SARAH INDRIYANTI', '242510023', '$2y$12$6.acJgjoW9ICKeyZ5Lp0Ce1SMJ/RULs1C1vUy6j5qAL0F4r.giB/W', 'siswa', '2025-09-13 05:21:33', '2025-09-13 05:21:33'),
(368, 'SITI JAHROTULSYITTA', '242510024', '$2y$12$iqzI8ZXHUvUE5ufgBul9muV6ugT0nUiSyAgRFmGT2gAOQ9c4dUcMC', 'siswa', '2025-09-13 05:21:34', '2025-09-13 05:21:34'),
(369, 'SITI NURHASANAH', '242510025', '$2y$12$pYTIQJfKbrksUPqHmkIX8ulJd7PsLiiNZVsIxScrzkwdhLGGmYpJK', 'siswa', '2025-09-13 05:21:34', '2025-09-13 05:21:34'),
(370, 'SITI NURPADILAH', '242510026', '$2y$12$FMMgOG5vSiO6MJY89UGkiuPWe1OXh0XGCSzRS/znUP5u/9w8KbsiK', 'siswa', '2025-09-13 05:21:34', '2025-09-13 05:21:34'),
(371, 'SITI SALAMAH', '242510027', '$2y$12$K2StmiZh7VQ5vOpWb4fWM..UWaHfsLnDj13AOcZ8raKdXQ585HVe6', 'siswa', '2025-09-13 05:21:34', '2025-09-13 05:21:34'),
(372, 'SITI ZENAB', '242510028', '$2y$12$V18JQlfIs2RLcGWdcRsWGeRIe6H7yz9BmmJI0Cfj2b9Os2bqJYRZG', 'siswa', '2025-09-13 05:21:35', '2025-09-13 05:21:35'),
(373, 'SYAVIRA DWI NOVIANTI', '242510029', '$2y$12$8i37vk5RteZ/VNeD/JbETut8A39cK8Gkx3uiKEiI28eQ9GpvCtrvS', 'siswa', '2025-09-13 05:21:35', '2025-09-13 05:21:35'),
(374, 'SYIFAUDZIHNI', '242510030', '$2y$12$RxHurqwAgFuGaw2JfXPL/.yQtw9iPNaxqFpsZclfqiFhd4cNKpp5C', 'siswa', '2025-09-13 05:21:35', '2025-09-13 05:21:35'),
(375, 'TASYA ANANDA', '242510031', '$2y$12$Qox91jKJQEw4nqyPZe65xuXDDWj5Q7KdaCf6oStc6g7SKq.c8wbwi', 'siswa', '2025-09-13 05:21:35', '2025-09-13 05:21:35'),
(376, 'TIKA DEWI', '242510032', '$2y$12$6ITu2eCA1ZtVhgFoJ7Cjhu64lOTiQ5//6eVCnjftxGteN5ewKhREi', 'siswa', '2025-09-13 05:21:36', '2025-09-13 05:21:36'),
(377, 'WILDA CAHYANI', '242510033', '$2y$12$1y7dXnSFSBOvDLu.LMjxteT8QZ0rV55Ddo/tGrAww2gQE9uXYobW6', 'siswa', '2025-09-13 05:21:36', '2025-09-13 05:21:36'),
(378, 'AISAH WALINAYAH', '242510034', '$2y$12$1uFX9zTSV9S63SO4yauA3ORSlH70MdlKa8pFDSPBcgSKhAbRhfYJu', 'siswa', '2025-09-13 05:21:36', '2025-09-13 05:21:36'),
(379, 'ANGGUN DARA CANTIKA', '242510035', '$2y$12$6E7qWfuglbdEm.5zUTBMzez1sIJPzfPAYWU21DOiWkJU17E0TX572', 'siswa', '2025-09-13 05:21:36', '2025-09-13 05:21:36'),
(380, 'APRILIANI', '242510036', '$2y$12$P/QLUPquJzqAsx9m2RdsCOX5Wdu8WePJdgD07TX9Ict8SJypfiR8u', 'siswa', '2025-09-13 05:21:37', '2025-09-13 05:21:37'),
(381, 'ARUM', '242510037', '$2y$12$N7nI30QwxuqFjTx9qK2jSuwRW1CPbM49Mlj2jlUYhVLbtfxG4FQ3K', 'siswa', '2025-09-13 05:21:37', '2025-09-13 05:21:37'),
(382, 'CITRA NURY RAHMAN', '242510038', '$2y$12$JuflRnueIceeSl34w0wxWuQc8KrFbH8XkxPlHGIn1LYTEhfJU5EYa', 'siswa', '2025-09-13 05:21:37', '2025-09-13 05:21:37'),
(383, 'DEDEH FAUZIYAH', '242510039', '$2y$12$MmKzB8His4Vsf2AEIoKkcOkHtc5.QiONy4i8PN5JWrTWz7LkOTc8q', 'siswa', '2025-09-13 05:21:37', '2025-09-13 05:21:37'),
(384, 'DEVI YULIANI KUSMANTO', '242510040', '$2y$12$p.KRSgYrfhSauqE9AJXlBef6pcPvnBRskvdOUAk1ctCU.hQtkVNKC', 'siswa', '2025-09-13 05:21:38', '2025-09-13 05:21:38'),
(385, 'DINDA LESTARI', '242510041', '$2y$12$WgI3DY5Rj4dMc.KMvYVFYOzHorMf67dshy7KRj2hAygVUpOlKrOjK', 'siswa', '2025-09-13 05:21:38', '2025-09-13 05:21:38'),
(386, 'ERNAWATI', '242510042', '$2y$12$UE4vxs108UYNTboEvVIxTejjz2aPjE1YhjkPeJFNtt80JH.aav2bK', 'siswa', '2025-09-13 05:21:38', '2025-09-13 05:21:38'),
(387, 'INAYAH', '242510043', '$2y$12$pgPWW9s5KtQeY0mrGoqzVelg7Qr8vy2PvTE6BwNsiFulX1655FnTy', 'siswa', '2025-09-13 05:21:39', '2025-09-13 05:21:39'),
(388, 'LAILA', '242510044', '$2y$12$RmzjEYjDRf4KJK2rDiphUOI3fFURGgc7GgSCMf6FVgoINXUj.0VzC', 'siswa', '2025-09-13 05:21:39', '2025-09-13 05:21:39'),
(389, 'LUTIKA SUNDAWA', '242510045', '$2y$12$bM5ATXykHNtZT3hVZfrv2.iqN7.AqapDxBn275OVDNPdNmyPvehWu', 'siswa', '2025-09-13 05:21:39', '2025-09-13 05:21:39'),
(390, 'MAULIDDIVA NAWWAROH', '242510046', '$2y$12$DrF9cMdpJHtz7mRfTQhgG.UJHQyknUne0w8Do7uurmpViqj48GYPq', 'siswa', '2025-09-13 05:21:39', '2025-09-13 05:21:39'),
(391, 'MAYA MAESAROH', '242510047', '$2y$12$3h6XuRLwvrIznyAZ4mR80OlitGXcVFOpr5LcN/n54KZ5k5QQwTFEO', 'siswa', '2025-09-13 05:21:40', '2025-09-13 05:21:40'),
(392, 'MELYANI', '242510048', '$2y$12$5UMcAfUuuoqXrVdCG3ksCOf1Idy5IuBEeURx4Hgr0OuVOvdHXVDWK', 'siswa', '2025-09-13 05:21:40', '2025-09-13 05:21:40'),
(393, 'MIA BIATUL QOYA', '242510049', '$2y$12$r5tGQdv//jeSz7bjDE5BxuE.ewGy15CoF.EwsHI8zikBRr.d..T8G', 'siswa', '2025-09-13 05:21:40', '2025-09-13 05:21:40'),
(394, 'MUHAMMAD RAFFA RODIYANA', '242510050', '$2y$12$XHuwR/I4DIDfcYypBYiUguMF5/iOuzPU/HcMHqKqzmJURL7R1O8Ja', 'siswa', '2025-09-13 05:21:40', '2025-09-13 05:21:40'),
(395, 'NAJWA FITRIA AZZAHRA', '242510051', '$2y$12$ZjXQOuo5L/5qF3bDpRJ52ul.qVLnJjDRpxWDihgjwza0OHIgOrI/6', 'siswa', '2025-09-13 05:21:41', '2025-09-13 05:21:41'),
(396, 'NINING NURFALAH', '242510052', '$2y$12$R6Q8uYnKSYtuNO4IwgSXxu8xtHZSlR3UMNkqjq1LiKUGtzK5MrUAe', 'siswa', '2025-09-13 05:21:41', '2025-09-13 05:21:41'),
(397, 'NORMAN HIDAYATULLAH', '242510053', '$2y$12$H38wAPzmqK2cHqAcH3Quw.TJAcMN.K7cl/WSe26aOLlFCt3ricpYa', 'siswa', '2025-09-13 05:21:41', '2025-09-13 05:21:41'),
(398, 'NOVI SEPTIANA RAHMADANI', '242510054', '$2y$12$QJlohY5RPl0Pv9TT/ka.pe2nhcK7kIXEiGaLkHEO7z054bk8FBisu', 'siswa', '2025-09-13 05:21:42', '2025-09-13 05:21:42'),
(399, 'NURMALA', '242510055', '$2y$12$QR.1Bx15kwa8gs/TamXu0OUq8rvPnVS5qfsPySHH9OhQQgdYHiMjG', 'siswa', '2025-09-13 05:21:42', '2025-09-13 05:21:42'),
(400, 'PUTRI SALSABELA', '242510056', '$2y$12$.yTKewsK1wLjPNbIOtg.P.OxE3.Fx8fHkYSeW34/BhFMapUf7zw9y', 'siswa', '2025-09-13 05:21:42', '2025-09-13 05:21:42'),
(401, 'RANI', '242510057', '$2y$12$vKQ86Wb5N/5PO7iIzG562ugOeZqrl90ghA.uadIlPCxii1q/HpzTi', 'siswa', '2025-09-13 05:21:42', '2025-09-13 05:21:42'),
(402, 'RIRIN EKAWATI', '242510058', '$2y$12$XRc7HrVNkK6UW542xZe5sOIOGpNVxBjpd2wS9PeU1ZIogGerLD27q', 'siswa', '2025-09-13 05:21:43', '2025-09-13 05:21:43'),
(403, 'SARASWATI', '242510059', '$2y$12$.T9t1x3eQ7MJ1ENc4g/8.uVwaPHNmZ5CeHGKaO2bnJXbJjwLdhafm', 'siswa', '2025-09-13 05:21:43', '2025-09-13 05:21:43'),
(404, 'SITI NURJAMILAH', '242510060', '$2y$12$OfnDIb33rYgmt3pMrMThJewrG7hCP5vAL0FFJGnlvoAshIIhVVpOm', 'siswa', '2025-09-13 05:21:43', '2025-09-13 05:21:43'),
(405, 'WIWIN NURMAULIDA', '242510061', '$2y$12$hBlM.tffgQs7jppD9no0rucYIw/bIkmm32Gd03BcTjlXPTwpE4VWC', 'siswa', '2025-09-13 05:21:43', '2025-09-13 05:21:43'),
(406, 'WULAN SARI', '242510062', '$2y$12$18fQ/Asjp37iQrvLDJ5R8e3aUS4elVhfmbZRlRZOndkuvBQYpKCee', 'siswa', '2025-09-13 05:21:44', '2025-09-13 05:21:44'),
(407, 'ZAHRA AYUMI', '242510063', '$2y$12$vCRKWGVWC/pa9Q4VB9nJSO4YCV1RV9wHMbf77q.Kf5hJTJRjOWCwm', 'siswa', '2025-09-13 05:21:44', '2025-09-13 05:21:44'),
(408, 'ZAHWA AENURROHMAH', '242510064', '$2y$12$UtKABRr9MXOoPIsv63rRuuF/bf7U9eA7z/Lr2DsDPhhelWsm0582u', 'siswa', '2025-09-13 05:21:44', '2025-09-13 05:21:44'),
(409, 'ABDUL SODIK', '242510065', '$2y$12$X0UhAGue7LjxJ5CN7Hkg.uy4LYoDJTyFXSEyLpZBSwUDO0ZuDcEDq', 'siswa', '2025-09-13 05:21:44', '2025-09-13 05:21:44'),
(410, 'AGNAN HAMBALI', '242510066', '$2y$12$FfkkKhXaBV6k8ZINNGq1besJE8bN7rtxA/Yedw7PMR7NsLH4rPIjq', 'siswa', '2025-09-13 05:21:45', '2025-09-13 05:21:45'),
(411, 'AGUS MULYANA', '242510067', '$2y$12$SK6MtwYiJWdLfiwg5A4oMu852SxiLEiwyR0ISYO.7YY1ThkCGyQWO', 'siswa', '2025-09-13 05:21:45', '2025-09-13 05:21:45'),
(412, 'AKBAR DHANI', '242510068', '$2y$12$Itml1rFsr1pJif4Jbx3Mp.5t1xxGjePrCCN5olcvHIlTsKe/9.tM.', 'siswa', '2025-09-13 05:21:45', '2025-09-13 05:21:45'),
(413, 'ALDI FAUZAN', '242510069', '$2y$12$gUKeSf5K02xH64Y6xjhbNukoPy.vRhg0nsBCr.Z1JbNXCqReIAslO', 'siswa', '2025-09-13 05:21:46', '2025-09-13 05:21:46'),
(414, 'ALDIEN AKBAR', '242510070', '$2y$12$ut5c8Yhzmv3qx0mEdsuLW.Zhz.JSVTsR.zWUgQzLf47Hxklir0yMe', 'siswa', '2025-09-13 05:21:46', '2025-09-13 05:21:46'),
(415, 'ALPI SAEPUL AKBAR', '242510071', '$2y$12$egYwcSXuOMFQ33H1j06Rye5z9keHTlly8uaGr6pHiq59VVHrFSxuC', 'siswa', '2025-09-13 05:21:46', '2025-09-13 05:21:46'),
(416, 'ANDIKA SYAPUTRA', '242510072', '$2y$12$oOmexEZPG0.9q8ZAPxJ86.RgoRoWv7RifTNKrJXf/goADfRJrElqe', 'siswa', '2025-09-13 05:21:46', '2025-09-13 05:21:46'),
(417, 'AYOM PRAYOGA', '242510073', '$2y$12$71nBmvJjrU8kSibWqOwtQubrxfS9Y70ckn3H7fqzRMI6qlpd5rIAe', 'siswa', '2025-09-13 05:21:47', '2025-09-13 05:21:47'),
(418, 'CAHYONO MAULANA', '242510074', '$2y$12$d/Ye7iR1r/OYLE/P2qvxN.aJXbTSoSem2fobYOV6JRzcFKuOskKou', 'siswa', '2025-09-13 05:21:47', '2025-09-13 05:21:47'),
(419, 'DIMAS PRADIPTA FUDHOLI', '242510075', '$2y$12$6nYpiUWJi2cCgb4nUNE2vOxxyby7r8lHe8PHdf9mCDrhEVterJBHS', 'siswa', '2025-09-13 05:21:47', '2025-09-13 05:21:47'),
(420, 'EKA RAMDANI JUNAEDI', '242510076', '$2y$12$ENMOIPvNYEDBBSKNTpaqpOJBJYiOKr2/mrEW.hsvqHiDGZwjvymq.', 'siswa', '2025-09-13 05:21:47', '2025-09-13 05:21:47'),
(421, 'EVA NURAENDI', '242510077', '$2y$12$Byp4Bkz2cGOS2VnUp2R9PuHpI4L4cRAB1bFd.E/GuLgdAV.XG1Vqm', 'siswa', '2025-09-13 05:21:48', '2025-09-13 05:21:48'),
(422, 'GENTA TENGGARA BADAY', '242510078', '$2y$12$/hMWuSL5GeP9hJnHxQvd9.G6PeLeLrVxuQyDwBeRTuNwJmBBZ.ahG', 'siswa', '2025-09-13 05:21:48', '2025-09-13 05:21:48'),
(423, 'INTAN NURJANAH', '242510079', '$2y$12$/Ky6.KGdQmpOPH8QSPFADezFx7ELlqQAZX9NR6Xk0ic.rQe/Y9nEq', 'siswa', '2025-09-13 05:21:48', '2025-09-13 05:21:48'),
(424, 'IRPAN HERMAWAN', '242510080', '$2y$12$9Ps70q5MSXVX19wiTp9BRuKw2aw1PgbvctjnDAz5W4z7oU.VKV6pi', 'siswa', '2025-09-13 05:21:49', '2025-09-13 05:21:49'),
(425, 'MUHAMAD YAHYA', '242510081', '$2y$12$ufjeUl6weWfRXzAFhHHTceUcOBYdbrAUaTkmaQZwC6ccINLGKANXm', 'siswa', '2025-09-13 05:21:49', '2025-09-13 05:21:49'),
(426, 'NABILA JULIANY', '242510082', '$2y$12$vigIldBiEAmzUu4YYT6ETO.EUbW28ZW969unLL9aZYYvYGyBuENPm', 'siswa', '2025-09-13 05:21:49', '2025-09-13 05:21:49'),
(427, 'RAFI MAULANA LILAH', '242510083', '$2y$12$NO7c9475m/VFX4eM92zxQ.RqdBq8G1vOCt7.FBVubGMFekZv1qQe6', 'siswa', '2025-09-13 05:21:49', '2025-09-13 05:21:49'),
(428, 'RAMA ALDIANSYAH', '242510084', '$2y$12$9RSUW8vfQzik82t3HbrQbOj9xvg3a6CPyW3BCPC2RgcsCdz4Nx3/2', 'siswa', '2025-09-13 05:21:50', '2025-09-13 05:21:50'),
(429, 'RAMA HERDIANSYAH', '242510085', '$2y$12$vxbogthKyN/nsKVzxwn/4OJ4CFH8IQ7N3tqc0YC0.q1DUz2rqHZEO', 'siswa', '2025-09-13 05:21:50', '2025-09-13 05:21:50'),
(430, 'REDI', '242510086', '$2y$12$UgTP5qGxD7LfmCQd9rvDNuTxUEe78RvGw7c74j.88M7RmfWLiGw5G', 'siswa', '2025-09-13 05:21:50', '2025-09-13 05:21:50'),
(431, 'REGIA NANDA FEBRIATAMA', '242510087', '$2y$12$eYzLxtDSaOzgl/MTNJwEPuTyq.DBNgRp7gIs3WlgeHiKVb2mWur6K', 'siswa', '2025-09-13 05:21:51', '2025-09-13 05:21:51'),
(432, 'RIFKI MULYANA', '242510088', '$2y$12$TNlTMqVzgYdOAE3sPBlJpe5VvVihTwJWt0t/2SGgFGRxoQXBHi3Ju', 'siswa', '2025-09-13 05:21:51', '2025-09-13 05:21:51'),
(433, 'RIZKY ADITIYA', '242510089', '$2y$12$LzXErKzHoacTRD.ifX5oNew.7.Dykq5u22/ZgrvBXEnIVN1oj0Yp.', 'siswa', '2025-09-13 05:21:51', '2025-09-13 05:21:51'),
(434, 'RIZKY AZIZ MAULANA', '242510090', '$2y$12$ixofPEo5VohIEqwQ2LaSW.ixl8ZqnPf9ZptMN7S2QaT8FojU4vCqq', 'siswa', '2025-09-13 05:21:51', '2025-09-13 05:21:51'),
(435, 'SITI MARIYAM', '242510091', '$2y$12$kcDpvpDz.u6X.pQ3V.nrwee8nV5hT4p9uNeVXpWIDF1Dp78e19pKS', 'siswa', '2025-09-13 05:21:52', '2025-09-13 05:21:52'),
(436, 'SYAHRILLA PERMATA NUSANTARA', '242510092', '$2y$12$mnh3pllMXddOPxecskP9ceOLaiphFjAlck38pk0fCzfRoj.E78Xt6', 'siswa', '2025-09-13 05:21:52', '2025-09-13 05:21:52'),
(437, 'WIBY KURNIAWAN', '242510093', '$2y$12$hgd.WCGRCB7vSMvAYkxln.a45LWMzWtQdDQxTvOVvwz8tznKg/8w6', 'siswa', '2025-09-13 05:21:52', '2025-09-13 05:21:52'),
(438, 'WIDIYA ANISA PUTRI', '242510094', '$2y$12$p8WjmM682k6qb9NTJT6XJOc0xlQSfSbuT/CEw1Rr7ZVsd.7kb3TRe', 'siswa', '2025-09-13 05:21:52', '2025-09-13 05:21:52'),
(439, 'WINDY DANUARTA', '242510095', '$2y$12$6C4nuZH7x.BbDSJqbHJ0SOSRZb32oqxCHwqEzu2ekjZqCkZhCRQg.', 'siswa', '2025-09-13 05:21:53', '2025-09-13 05:21:53'),
(440, 'YUDI MULYANA', '242510096', '$2y$12$7UFQUlDewJI/NkbNiw1kq.Uj/pUAQcJ.QV6Jf2HABGwv4u0Lvu4kq', 'siswa', '2025-09-13 05:21:53', '2025-09-13 05:21:53'),
(441, 'ADITTIYA SAPUTRA', '242510097', '$2y$12$5KNh2wtXYEKKWP4zoz3bA.UEy49ofsrJdvzYHpNUPFL6Qr/vFAre6', 'siswa', '2025-09-13 05:21:53', '2025-09-13 05:21:53'),
(442, 'AFDAL ZIQRI RAMADAN', '242510098', '$2y$12$wG0XyQCtPh3kSHtMao9w9OtqY8GBY8cvylLIY6s7bUpO7oqaPBvcy', 'siswa', '2025-09-13 05:21:53', '2025-09-13 05:21:53'),
(443, 'ANDIKA EKA SAPUTRA', '242510099', '$2y$12$dCbA8mqxXZ/30a7h9QTrGeyeorS8sZ1ppTgBBpl5xcZw27DcSyaEi', 'siswa', '2025-09-13 05:21:54', '2025-09-13 05:21:54'),
(444, 'ANGGUN RIANA PUTRI', '242510100', '$2y$12$iDNo0Kz7/A86oAaNSdsMV..I5s4AlrPTZl5k5qHqKCcjRVseKnQjW', 'siswa', '2025-09-13 05:21:54', '2025-09-13 05:21:54'),
(445, 'APRIZAL SUGANDA', '242510101', '$2y$12$8j.B/12H4.OCS5FQXNy4cewvUQCzLjrDQYl0vxCt7o1aUJSZ02sbm', 'siswa', '2025-09-13 05:21:54', '2025-09-13 05:21:54'),
(446, 'ARDIANSYAH', '242510102', '$2y$12$wmmF96QzUpt4tB94YLyFFuluRDuUvtxmiTsBiIrdwNvNrTy1TGM6C', 'siswa', '2025-09-13 05:21:55', '2025-09-13 05:21:55'),
(447, 'ARIF JUNAEDI ABDILAH', '242510103', '$2y$12$4tbhaEU1wmFCwzTSte93HOZuRn/.89FKyO6b873/Kj6s3rdRtM96y', 'siswa', '2025-09-13 05:21:55', '2025-09-13 05:21:55'),
(448, 'ASIAH NURAZIZAH', '242510104', '$2y$12$LXOi8/qw1SMbTzgu6psFhe/ayS1Y1XUuuEQ.KT1OYKyajswJHBtHW', 'siswa', '2025-09-13 05:21:55', '2025-09-13 05:21:55'),
(449, 'DIMAS', '242510105', '$2y$12$0kUY4k4BqomtEv4g.kHwh.wrWhS0tjEvhRkcQwVPBshhm7pb/4Upa', 'siswa', '2025-09-13 05:21:55', '2025-09-13 05:21:55'),
(450, 'DIO PRATAMA', '242510106', '$2y$12$gbNVQQ/krps/vzVjUp.k/u0h6lVu0B4JHKHgzcniKFn6AyQ3yFnUO', 'siswa', '2025-09-13 05:21:56', '2025-09-13 05:21:56'),
(451, 'FACHRI MUHAMAD SOFYAN', '242510107', '$2y$12$WoO3InUciZUAzja1RGWSkOperqxazFDnj5j3hm/.JVxEoY0GE7hLi', 'siswa', '2025-09-13 05:21:56', '2025-09-13 05:21:56'),
(452, 'FAHRI HAMDANI', '242510108', '$2y$12$.IJkQ9BagtlJYDUZGm1SheubpehmDQBFhiOe9Oc/2RuVSKfyFS97G', 'siswa', '2025-09-13 05:21:56', '2025-09-13 05:21:56'),
(453, 'FERRY SEM JULIANTO', '242510109', '$2y$12$75og1lfXGq9V29oxhDTGGOAQoGTkE2V/R6GXx.nvIaMGcVV88IJKe', 'siswa', '2025-09-13 05:21:56', '2025-09-13 05:21:56'),
(454, 'GUNAWAN GUNTUR', '242510110', '$2y$12$lP5yLEF0NQWjfKnBVqP1LeJ46baU3IWVudV59A6yOyuQAQaDZCb3m', 'siswa', '2025-09-13 05:21:57', '2025-09-13 05:21:57'),
(455, 'IRMAWATI', '242510111', '$2y$12$/36zY4qSeDK9B35kWsyYo.TK3DRFi6/ioRcw42eas4i6Yo.y9ay5C', 'siswa', '2025-09-13 05:21:57', '2025-09-13 05:21:57'),
(456, 'ISMAIL NURJAYA', '242510112', '$2y$12$YaOzUkn11S0dAxSqX0wvtuoaS0sijXU82FIJ6p53a/pbMWfldFrze', 'siswa', '2025-09-13 05:21:57', '2025-09-13 05:21:57'),
(457, 'LUTPIAH', '242510113', '$2y$12$a0bD3qRv4478eOhfWyRJs.KZWtqt0N5MEKLBc35Bq9o8NO4N8hbN6', 'siswa', '2025-09-13 05:21:58', '2025-09-13 05:21:58'),
(458, 'MUHAMAD FAIS', '242510114', '$2y$12$8RPz2o1KvRaQgZzT2FcUtuCraO0odFVM3MSa2tp98GPMnty5axnqa', 'siswa', '2025-09-13 05:21:58', '2025-09-13 05:21:58'),
(459, 'MUHAMAD MUMIN', '242510115', '$2y$12$KmFAnjyoxf63tbze6x3GPOmiJ.oiUozk.ooT7TUy5xFxFqxdcLcva', 'siswa', '2025-09-13 05:21:58', '2025-09-13 05:21:58'),
(460, 'MUHAMAD NUSHA BADARI', '242510116', '$2y$12$EXjeHvsRKinCasT9JCad4OmEHsj7Zr/Q2boEApWEprdqYLOUa8Jt2', 'siswa', '2025-09-13 05:21:58', '2025-09-13 05:21:58'),
(461, 'MUHAMMAD PALESTIN', '242510117', '$2y$12$NxsQ4XbeTWqkGe6l4PYjyOFn8Pvbehx5D0Sv.Y206pZjqy1GV4nG.', 'siswa', '2025-09-13 05:21:59', '2025-09-13 05:21:59'),
(462, 'MUHAMMAD RAFFI ALFARIS', '242510118', '$2y$12$1CNBtpE2fJgH2dK1ZL/Gke/EAFKG1EvANHwBtdzB1q3a641KF.luW', 'siswa', '2025-09-13 05:21:59', '2025-09-13 05:21:59'),
(463, 'MUHIDIN', '242510119', '$2y$12$aL0kU/tbpykVuFpPG3OX5OwCUzYZIniev5NkNErClj81aUp11ErYe', 'siswa', '2025-09-13 05:21:59', '2025-09-13 05:21:59'),
(464, 'NURHAYATI', '242510120', '$2y$12$qjiOoYIsc62iYIEII.yg8uv2ILsAVeqOWNP8QHCrSpvOOY4qpULNy', 'siswa', '2025-09-13 05:21:59', '2025-09-13 05:21:59'),
(465, 'NURSIAH', '242510121', '$2y$12$d9Q6RgjEioMxfdxY3b/pQue1o6vh78o2cYVREcECnMse8YwHKNjGC', 'siswa', '2025-09-13 05:22:00', '2025-09-13 05:22:00'),
(466, 'ROHMANA', '242510122', '$2y$12$gy7HtvdhrJKQNt1B9fZAWueBv7aGpteZR0ZRu/6dgxHeeIyf0UgaS', 'siswa', '2025-09-13 05:22:00', '2025-09-13 05:22:00'),
(467, 'SYARIP NASRULLOH', '242510123', '$2y$12$aO6mUbHweNw7MRx1P7rFIewxEpYCyrCraDUUR5e692AayPhVdnWV6', 'siswa', '2025-09-13 05:22:00', '2025-09-13 05:22:00'),
(468, 'TAMAMI', '242510124', '$2y$12$Tz4W4emeOvDkPChCNnQ/VuJ2g5LLiY.wMyqHxjRiIytH.q.FUvxDu', 'siswa', '2025-09-13 05:22:01', '2025-09-13 05:22:01'),
(469, 'ABDUL GANI', '242510125', '$2y$12$3AoICfD6zdkcPrB4h1ak8ua6juqU87.9AR5v9l1IwO7H/6CK2HLxO', 'siswa', '2025-09-13 05:22:01', '2025-09-13 05:22:01'),
(470, 'AHMAD DANU', '242510126', '$2y$12$.IovRyNyjGE.nJ99R0YDrOckXPK0uIjyxOfgAzzg0EFr1PfviRYVe', 'siswa', '2025-09-13 05:22:01', '2025-09-13 05:22:01'),
(471, 'ALMASUL ANAM', '242510127', '$2y$12$Z5JPOJA9ZuGadm5in87.j.kgQ1YK6jTJj0WdH1C6gl15YM1V18ivS', 'siswa', '2025-09-13 05:22:01', '2025-09-13 05:22:01'),
(472, 'APRIANSYAH KARIM', '242510128', '$2y$12$.o30BlxbUABAO68nHt3v8O3pWZRx9FTFiSAfYxw0Pg3qMhS6j.fD2', 'siswa', '2025-09-13 05:22:02', '2025-09-13 05:22:02'),
(473, 'APRIYANSYAH', '242510129', '$2y$12$ZDkhPSw6INeULXV9dTynde4KrxtpQ64p3fZAIlueKsCJHCGYiS2yi', 'siswa', '2025-09-13 05:22:02', '2025-09-13 05:22:02'),
(474, 'ARYO SAPUTRA', '242510130', '$2y$12$dOe0mFxB70NP5fPOBo6xouVah3F1U.136QcbLoQEZz8FEI8NqJjYC', 'siswa', '2025-09-13 05:22:02', '2025-09-13 05:22:02'),
(475, 'BELA CANTIKA', '242510131', '$2y$12$U./R5n8XLbGjubO9iNgmkeFCDoFed7Tt9Eh66TUqGo6quFIw1b8y6', 'siswa', '2025-09-13 05:22:02', '2025-09-13 05:22:02'),
(476, 'CASTIMAN', '242510132', '$2y$12$Jn23NEWD7zWOAS1gKh4JUe6XUO9RCdJFIdHbLc0oXfHjvryZ0s8yu', 'siswa', '2025-09-13 05:22:03', '2025-09-13 05:22:03'),
(477, 'DAVI BAHTIAR', '242510133', '$2y$12$dNI2Nc8FHiw/0UlAc6L.jOI6VwaSlKQvDAqfgAcowCaEylZy8oGIO', 'siswa', '2025-09-13 05:22:03', '2025-09-13 05:22:03'),
(478, 'DELIMA', '242510134', '$2y$12$n1tRTE5tuP6TY0vGk9dZg.IdZ.65Nl.0nX/cr621eb9nIDT4Itt/6', 'siswa', '2025-09-13 05:22:03', '2025-09-13 05:22:03'),
(479, 'EKO ADI SUCIPTO', '242510135', '$2y$12$NQQ14vHTw7LsZFrT9wviOOw2N3I1KUlG6LT2DdvbZ/ndfjNbGI0aW', 'siswa', '2025-09-13 05:22:04', '2025-09-13 05:22:04'),
(480, 'IBRAHIM SIDIK JAELANI', '242510136', '$2y$12$6YwMGQRjs8PjvlaALdwiBOhr/ekbb1VjfkChs8/QLIj2FoyaL42tG', 'siswa', '2025-09-13 05:22:04', '2025-09-13 05:22:04'),
(481, 'ICANA', '242510137', '$2y$12$o0uBJgwkNOBYP79oSEaBbeF4UsiZOr0LQLo/V7jJUFwVKM0hOkFxO', 'siswa', '2025-09-13 05:22:04', '2025-09-13 05:22:04'),
(482, 'IRPAN', '242510138', '$2y$12$7riwrPOyInRhrDoI.46GvuDm8x7h0vqoPmo6VNcPWmGE59.phDetS', 'siswa', '2025-09-13 05:22:04', '2025-09-13 05:22:04'),
(483, 'KHAILA SABINA', '242510139', '$2y$12$Qvg9JjbH6mubQnZ/4rMQMOdiAYfVdkMB1o5qUwlhbsQeGuwpx3lOK', 'siswa', '2025-09-13 05:22:05', '2025-09-13 05:22:05'),
(484, 'MUHANAD ABDULHADI', '242510140', '$2y$12$aAXstvchWGnyaHPcZuf8UuXfqE50x0YYB.4gQIZM5ynXKldHg03G2', 'siswa', '2025-09-13 05:22:05', '2025-09-13 05:22:05'),
(485, 'NURLELA APRIYANTI', '242510141', '$2y$12$5yisM2URVQQtSkenygZifO67KOTOR/xJ5Z2vH3phzot6xZJYQo57.', 'siswa', '2025-09-13 05:22:05', '2025-09-13 05:22:05'),
(486, 'PARIDHAH', '242510142', '$2y$12$ghD9MB20R5q86kvfoIp2p.f.NpGC82OZePhJi/qvkXraDpH4pnyPq', 'siswa', '2025-09-13 05:22:05', '2025-09-13 05:22:05'),
(487, 'PASA NUR PADILAH', '242510143', '$2y$12$dns0n3N/78wpX0E9v5iSfunLfEj9aQhaI6Mk5F.Iqx5GF.FGROzPK', 'siswa', '2025-09-13 05:22:06', '2025-09-13 05:22:06'),
(488, 'RAISYA ADITIA', '242510144', '$2y$12$uyAniIM.ngfPXC7H6.YQKem9.CyIMYeNfAj8tQS5Fz3ft0INs.Nza', 'siswa', '2025-09-13 05:22:06', '2025-09-13 05:22:06'),
(489, 'RANATA', '242510145', '$2y$12$7hzKfCo0sxlPrf3opOopo.bl8mwDsz5xiaHHxnpkzzzeQAwS5fsJi', 'siswa', '2025-09-13 05:22:06', '2025-09-13 05:22:06'),
(490, 'RAPI RIPANSYAH', '242510146', '$2y$12$NPZhz8TY4WKfRCJQNwTQ4.pq3RxtffFTXhvZROJFCxPlYtuSiBOWm', 'siswa', '2025-09-13 05:22:07', '2025-09-13 05:22:07'),
(491, 'RIPAT', '242510147', '$2y$12$KGhl9NOMNIkJnnrhWMSDRe7u7Z2kfcI5UifLw01HaSKgibvKdMSj2', 'siswa', '2025-09-13 05:22:07', '2025-09-13 05:22:07'),
(492, 'RIZIQ ABDUL WAHID', '242510148', '$2y$12$V/S1ffUrEbbXVmVDGFH1w.Df03owA09o32VVxP2EzOTDCp.c/.R8S', 'siswa', '2025-09-13 05:22:07', '2025-09-13 05:22:07'),
(493, 'SUCIKOH MAHARANI', '242510149', '$2y$12$ySH5hlWVDUWeEBbAwAwBD.1GFnbKEOnDNthZt/a6MgadYHPv9tXeS', 'siswa', '2025-09-13 05:22:07', '2025-09-13 05:22:07'),
(494, 'SUKARDI', '242510150', '$2y$12$aqzTaMnnKLh1QyumCe4lVOyEDVAUOZCRcFK13HvQUJWt7Fhrz4inu', 'siswa', '2025-09-13 05:22:08', '2025-09-13 05:22:08'),
(495, 'TIANI', '242510151', '$2y$12$Tl.cX60gL./UtaAm713CAeF2CakZxmoJGhFtywiZsAE1/Kcc.LPui', 'siswa', '2025-09-13 05:22:08', '2025-09-13 05:22:08'),
(496, 'WAHAB TAJUDIN', '242510152', '$2y$12$Ba.BfwtTT2JWxgfvmRh9teRRFL9.Y2YAEKnAwpy31gz7rTtB7GatK', 'siswa', '2025-09-13 05:22:08', '2025-09-13 05:22:08'),
(497, 'AHMAD RIFKI RIFAI', '242510153', '$2y$12$WNmY5/xNSjoTbSm2yAU/Ru14FtUw2qXb/vcXQ4phlsO6CTzb8WZ3a', 'siswa', '2025-09-13 05:22:08', '2025-09-13 05:22:08'),
(498, 'ALDO PRASETYO ADAM', '242510154', '$2y$12$5VmXwqoHvWmi97rBlUhpxOOvq1saoj4MOHIiH0t7tCF4kbckjlYWW', 'siswa', '2025-09-13 05:22:09', '2025-09-13 05:22:09'),
(499, 'ARIS MUKTIA', '242510155', '$2y$12$7XwbPK6JeQGBCkm9tbImkuWRcy3v8USyBgXlatv9xTQbScSQDUouK', 'siswa', '2025-09-13 05:22:09', '2025-09-13 05:22:09'),
(500, 'ARMAN RAMADHAN', '242510156', '$2y$12$WLtbAoNSu2GyLkeUwYh2Aev6g250mRl2j8.GXmWFcX.hnNdeb/.f6', 'siswa', '2025-09-13 05:22:09', '2025-09-13 05:22:09'),
(501, 'DARMAWAN', '242510157', '$2y$12$5D5XGTJILanya957HX2RS.R7CrvnNK6VqPZzPqJiMT54jdKs3bYei', 'siswa', '2025-09-13 05:22:10', '2025-09-13 05:22:10'),
(502, 'DENI HARUN', '242510158', '$2y$12$31K/m1TZS46u2impS3WpgeLlJM1j./yQA1arxRUqRRf9zdziXG7vG', 'siswa', '2025-09-13 05:22:10', '2025-09-13 05:22:10'),
(503, 'DIMAS', '242510159', '$2y$12$P1fSUMKz7xfKq2mtvOO3reEtP8N99LP.3jWWSDSwe0U54Tz2VhRDm', 'siswa', '2025-09-13 05:22:10', '2025-09-13 05:22:10'),
(504, 'FAISAL ABDUL AZIS', '242510160', '$2y$12$V3QNULJL0Q0bjVT2E9gwk.O5BUAxhrAT.2HNuDvnNkSzrSqUYre5C', 'siswa', '2025-09-13 05:22:10', '2025-09-13 05:22:10'),
(505, 'GALIH WARDANA', '242510161', '$2y$12$X5YxvAWeLIqj/Q7WdvfCJ.0M5Jpuuj0omS.eviSvSDIsEDTOr9FmW', 'siswa', '2025-09-13 05:22:11', '2025-09-13 05:22:11'),
(506, 'GILANG PERMANA', '242510162', '$2y$12$maQaX0pI7ozpkkbIts5xW.c6.7eIO9ohsO3BB81TcUgPjm/Hptvh6', 'siswa', '2025-09-13 05:22:11', '2025-09-13 05:22:11'),
(507, 'HOTIMAH', '242510163', '$2y$12$hxHgOiR5tDKRh/Z7MiisH.I90OemDY7Fdvx.0WRv8ghEDyOg0Wg7m', 'siswa', '2025-09-13 05:22:11', '2025-09-13 05:22:11'),
(508, 'ILYAS SUPANDI', '242510164', '$2y$12$9ya2u5oAPdCN6ZLFuZ2MDu9cohcbcp1uh/E1ffgACSLxvuU671jWG', 'siswa', '2025-09-13 05:22:12', '2025-09-13 05:22:12'),
(509, 'IRKI', '242510165', '$2y$12$50Ve6IlJYMstUE76HbfGbeN..DcccRSs5lZ9dyXdx4VMXCluZs7nG', 'siswa', '2025-09-13 05:22:12', '2025-09-13 05:22:12'),
(510, 'IRWAN', '242510166', '$2y$12$d//6giI3ci/mGFPfA5Haf.PCs5Z8LgGfIb524mNp2f1aK6sQ6ntQm', 'siswa', '2025-09-13 05:22:12', '2025-09-13 05:22:12'),
(511, 'KARDIANSYAH', '242510167', '$2y$12$zQ/aUYKJ8TFdcrqKeABX7OmOyvkeyyM13XGmNfJ4GCqRBsekl8oui', 'siswa', '2025-09-13 05:22:12', '2025-09-13 05:22:12'),
(512, 'MEYFHA AKILAH', '242510168', '$2y$12$uXacGyGA.tgzB/bNOqdVlOrnCXUNQI/Ncrt5FMz4d5jvVzXTAYvE2', 'siswa', '2025-09-13 05:22:13', '2025-09-13 05:22:13'),
(513, 'MOHAMAD AKBAR', '242510169', '$2y$12$thmJGnLIYnd67.ewZoHxy.LfFuZjrR2VDWjF8Slhdtfi1jykYA1by', 'siswa', '2025-09-13 05:22:13', '2025-09-13 05:22:13'),
(514, 'MUTIARA', '242510170', '$2y$12$phQW1BJnh7Xh44WlDDEcYuVwC9NprUxrKbGQXjV9UdQY9wLtEPM/G', 'siswa', '2025-09-13 05:22:13', '2025-09-13 05:22:13'),
(515, 'NANANG ALDIANSYAH', '242510171', '$2y$12$T0HAisA1Dop8PVvjLbXyXeM29IqWdeF3B9XLUrFcarwwe92kZy1gm', 'siswa', '2025-09-13 05:22:14', '2025-09-13 05:22:14'),
(516, 'PAHRUDIN', '242510172', '$2y$12$tnZR0jMzddZFNhCuDILn/ecLwGjOEnk0X6m3zL3InlL8yck4sZhRG', 'siswa', '2025-09-13 05:22:14', '2025-09-13 05:22:14'),
(517, 'SAPRUDIN', '242510173', '$2y$12$oyKPKd/12CGlH4TyQVLdVOlHhIeHDhmvZaWzmJ1/BkpbGsxgKRv2.', 'siswa', '2025-09-13 05:22:14', '2025-09-13 05:22:14'),
(518, 'SIFAH FAUZIAH', '242510174', '$2y$12$I4Pyzr2W/KbpxENRtyvW2.1YK52/S9h86GCJ.Gm4AO3f1E7B1ZG/u', 'siswa', '2025-09-13 05:22:14', '2025-09-13 05:22:14'),
(519, 'TANIA LAURA', '242510175', '$2y$12$KuzLbdWuFTnAVVAKxW5IouRePGry/pHWL5EqJ5QZi6hjDw57DOx5S', 'siswa', '2025-09-13 05:22:15', '2025-09-13 05:22:15'),
(520, 'TEGAR ANANDA PRATAMA', '242510176', '$2y$12$LqplkWPvYP3oqCCfAkmhc.u72y2x/7hyC1.WiEIOeSE2P6DsMfyRe', 'siswa', '2025-09-13 05:22:15', '2025-09-13 05:22:15'),
(521, 'WIRANATA', '242510177', '$2y$12$xPUIMyYu3lctThAy2Npd.exKXYNTpUSFvDNdvuuZpV.97RtcKmLKO', 'siswa', '2025-09-13 05:22:15', '2025-09-13 05:22:15'),
(522, 'YUSUP HABIBI', '242510178', '$2y$12$tfBFQCw/usLuOrmAVQHOMOtlpzFa4ZbM4BMPDRbuCAQDkq/0IvdqO', 'siswa', '2025-09-13 05:22:15', '2025-09-13 05:22:15'),
(523, 'AHMAD NURACA', '242510179', '$2y$12$GP3gXFRLpm1hkkegbcuscOdv1bcPw7FISNjyQ7jNeZQCHbDKJshAi', 'siswa', '2025-09-13 05:22:16', '2025-09-13 05:22:16'),
(524, 'ALVIAN NURFADILAH AGUSTIN', '242510180', '$2y$12$zXZAHbhAe6ReLxFnVho81.BpS5aBc41hlX2FLWWsKW43uCuJykMaK', 'siswa', '2025-09-13 05:22:16', '2025-09-13 05:22:16'),
(525, 'CARTIKA AYU', '242510181', '$2y$12$0zp3McAWB0EK7asB6/kAYuoU1950AiTxVFiGXqsmEpk17K/.j2SpW', 'siswa', '2025-09-13 05:22:16', '2025-09-13 05:22:16'),
(526, 'DIMAS', '242510182', '$2y$12$kMxWJ6k35YmZvJ1F7UO6/u26vL5SOPSCoM9Ji7XnM1HAh.BxsCade', 'siswa', '2025-09-13 05:22:16', '2025-09-13 05:22:16'),
(527, 'DIRLY KUSUMAH', '242510183', '$2y$12$Qn.8wvFclnx7nn2R4to2EO60fWF23UCD4W9YAaBajYLBG3RR05aSi', 'siswa', '2025-09-13 05:22:17', '2025-09-13 05:22:17'),
(528, 'FAISAL SETYO NUGROHO', '242510184', '$2y$12$dsH8udIlYAFeTdWN/Ti8Y.Ptbe1hxalFrItMWvPRPjQl2tAnWgYEG', 'siswa', '2025-09-13 05:22:17', '2025-09-13 05:22:17'),
(529, 'FARID RIZKY RAMDANI', '242510185', '$2y$12$2bRx50ilR2XExK/zCMbK7OeRvriyzBXq4fdjz9Ng4LauLs7LbGBIC', 'siswa', '2025-09-13 05:22:17', '2025-09-13 05:22:17'),
(530, 'IIN DWI DIKA', '242510186', '$2y$12$vk1Ml2aYG9vMM9Zb0iV60eidhrXFNWfEj5nbGHV4ccuBjDVyMFIrS', 'siswa', '2025-09-13 05:22:18', '2025-09-13 05:22:18'),
(531, 'ILYAS EFENDI', '242510187', '$2y$12$MheYbCIwg.PHNdhQHnTCvO3kOKThfWwSDpz5L5w2fMZ6Dm1GZlYLu', 'siswa', '2025-09-13 05:22:18', '2025-09-13 05:22:18'),
(532, 'IRWAN', '242510188', '$2y$12$nHh2B.qok8Ds1ITaX.ajQ./Z7miKwMaxRZuvdAfq01Fb5r0HgSmxu', 'siswa', '2025-09-13 05:22:18', '2025-09-13 05:22:18'),
(533, 'JAMAL MAULANA', '242510189', '$2y$12$Hh1g9jbS.NF/UAJgxt1CbuBYQxzNlEe.mJr8IiY1TUnAg71PC.EIO', 'siswa', '2025-09-13 05:22:18', '2025-09-13 05:22:18'),
(534, 'LUTHFI YANSYAH', '242510190', '$2y$12$ra0m/UhJVmv9SNJSiLZ8aOW0ckUbAbGwn4k34zJMxMwYHatut8cH.', 'siswa', '2025-09-13 05:22:19', '2025-09-13 05:22:19'),
(535, 'MUHAMAD ANDRE ALPHIANSYAH', '242510191', '$2y$12$3tD1ZLYxQ6DS/W6fFpda7OHj1yhZUX3UpKH.7ElBWYxIMnFDcphy6', 'siswa', '2025-09-13 05:22:19', '2025-09-13 05:22:19'),
(536, 'MUHAMAD BOBY FRAYUDA', '242510192', '$2y$12$VbnjP2iMj3r6CxN8FrAo2ef0n9Miq5SBhWMNB1CefsmEtB7w/99dG', 'siswa', '2025-09-13 05:22:19', '2025-09-13 05:22:19'),
(537, 'MUHAMAD FAISAL', '242510193', '$2y$12$v39A1e.Grz5Cj.UwBFgtFuOYHWKtzIpj5Os2FiV1/P2RvDPEj59Oy', 'siswa', '2025-09-13 05:22:19', '2025-09-13 05:22:19'),
(538, 'MUHAMAD RAIHAN', '242510194', '$2y$12$XVF6CnJAXBgxP3AOL1QoVe6QhaeEowu69C8OVeXqVILUhHmAnE/wW', 'siswa', '2025-09-13 05:22:20', '2025-09-13 05:22:20'),
(539, 'MUHAMAD RIKI ALFATUR RIZKI', '242510195', '$2y$12$eoXzC6FjUcGfAO8FmSy14.VZ8uAlcF31SVCg8NNOn8OY1zQimABPy', 'siswa', '2025-09-13 05:22:20', '2025-09-13 05:22:20'),
(540, 'MUHAMAD SAUD', '242510196', '$2y$12$XgaA3buxMN.fl9hc6yJBiOTmnx3wlw4ETtEZYiG8kLZajOVcwHxl6', 'siswa', '2025-09-13 05:22:20', '2025-09-13 05:22:20'),
(541, 'MUHAMAD TIRTA RUKMANA', '242510197', '$2y$12$Myoda3HX314AWjFkY6lcuOnQiOja/pTuCPFpDDGxY5wasP.v3TjfK', 'siswa', '2025-09-13 05:22:21', '2025-09-13 05:22:21'),
(542, 'MUHAMMAD FARHAN MIFTAHUL ROJAK', '242510198', '$2y$12$52xap.o9JyM2t9.blSci0esF7KP3cEH95d6k2sU6ivGzcwfkhOp9y', 'siswa', '2025-09-13 05:22:21', '2025-09-13 05:22:21'),
(543, 'MUHAMMAD HASAN BASRI', '242510199', '$2y$12$EpUck8vAmCdkR.eU6gHM3e7cT2EJLfUurxG/37CHTb9UWgm/Vz/8e', 'siswa', '2025-09-13 05:22:21', '2025-09-13 05:22:21'),
(544, 'DEFNE MAULLANA EL SYARIF', '252610200', '$2y$12$5zJyINlKPQcW115EHIeafu1tNmMYPq7WesVLCdm26qUxM0jB1JUFC', 'siswa', '2025-09-13 05:22:30', '2025-09-13 05:22:30'),
(545, 'DEVI DESVITASARI', '252610201', '$2y$12$4dYPFk2TQJ7dHjD9XVkOKujCh9QiwE8Trr0A/mYM7iGyvLFNK2b9i', 'siswa', '2025-09-13 05:22:30', '2025-09-13 05:22:30'),
(546, 'DIKA NANDA', '252610202', '$2y$12$IpvEYk8TL4XCMHs1PT6AuucjQLg3unJkfHw2zeFqldCUvuoz4tGFm', 'siswa', '2025-09-13 05:22:31', '2025-09-13 05:22:31'),
(547, 'EKA FEBRIANA', '252610203', '$2y$12$WAcJOd1PGoWuppv2IZYr/uInu8EJj791i.TlJao2GopjVh5rXSq0.', 'siswa', '2025-09-13 05:22:31', '2025-09-13 05:22:31'),
(548, 'GALANG FIRMANSYAH', '252610204', '$2y$12$jkCPBqgW3gZLMvM4FvqvdunFHViPGIR5qEoU7HbdGDEKHW/CGH1Bu', 'siswa', '2025-09-13 05:22:31', '2025-09-13 05:22:31'),
(549, 'HALIMATU ZAHRA', '252610205', '$2y$12$yHuuyPj2McurlCc5U3XCVuWjY0lXHp6ZanZ.rYG2eBXcg.HYPkUlC', 'siswa', '2025-09-13 05:22:31', '2025-09-13 05:22:31'),
(550, 'HASBI ASHIDIQI', '252610206', '$2y$12$tynDBcbpp7pZtCyTlx1i/O3yDTJz.DgrUUqY58kmU0EoMqt95kMay', 'siswa', '2025-09-13 05:22:32', '2025-09-13 05:22:32'),
(551, 'HERDIYAN NUGRAHA', '252610207', '$2y$12$4Eo4APcSBtLtflrrQYrya.msS6Pe5yKRQWmSsg2Aup.m0fQdSQFBy', 'siswa', '2025-09-13 05:22:32', '2025-09-13 05:22:32'),
(552, 'JEJE', '252610208', '$2y$12$f6PICDSjIP8ntzdSyTssuOQ6lQ2KdpowuFeAaefxwD/eVn0HI1MCq', 'siswa', '2025-09-13 05:22:32', '2025-09-13 05:22:32'),
(553, 'MARINA F SIMATUPANG', '252610209', '$2y$12$mHnWhMLlotJjZWxkOrc.T.tQZ.PdTv1AvRmwNrEKaNubvIZicCDES', 'siswa', '2025-09-13 05:22:32', '2025-09-13 05:22:32'),
(554, 'MUHAMAD IHSAN MUBAROK', '252610210', '$2y$12$8lPUDBzy/cazfY9j1opK0u5xlJJlQYv.ZPgJhlsnVgGxe5Ini8MIW', 'siswa', '2025-09-13 05:22:33', '2025-09-13 05:22:33'),
(555, 'MUHAMAD IQBAL ALFAQIH', '252610211', '$2y$12$X3KS.mV3qkNAQVfyVXYEeeXbQ7Yjn.b/wrgBp1cQtfc3Isqi9yd5y', 'siswa', '2025-09-13 05:22:33', '2025-09-13 05:22:33'),
(556, 'MUHAMAD KAMAL', '252610212', '$2y$12$6h4/LoSpUq8N29NkuYSKJ.XFsBAAFvXp8L8O7Y3tF/4nB0Jj9jf0e', 'siswa', '2025-09-13 05:22:33', '2025-09-13 05:22:33'),
(557, 'MUHAMAD REHAN', '252610213', '$2y$12$yi2HGcIHyFEniHFh4IGUEOODC0b8asRNAFM5sPvQiAlqg0xRjTPta', 'siswa', '2025-09-13 05:22:33', '2025-09-13 05:22:33'),
(558, 'MUHAMMAD WAROSATUL AMBIYA', '252610214', '$2y$12$0TduWycVtmCF.Rmt.G7cu.JT5s6DRcQPz530CrqiPNv2o2BiQcwmi', 'siswa', '2025-09-13 05:22:34', '2025-09-13 05:22:34'),
(559, 'NURFRIAN SYAHRONY', '252610215', '$2y$12$4iHZzsMU.F2Z9fUD3chW6uTOHctpxZzDZnLiDrFLC1Ruc0BrD9A5m', 'siswa', '2025-09-13 05:22:34', '2025-09-13 05:22:34'),
(560, 'RAELAN MUTABAROQ', '252610216', '$2y$12$AZDAWmtyzaauRmjmZdGapeYFlrYZUSZp7SBicjqrcspslW1VgqHcS', 'siswa', '2025-09-13 05:22:34', '2025-09-13 05:22:34'),
(561, 'RAMLI', '252610217', '$2y$12$a7w7vIpu1YH4JpUB0eZm4.iIOUmxbru74lIySiYMUmsrOH4wb6pPy', 'siswa', '2025-09-13 05:22:35', '2025-09-13 05:22:35'),
(562, 'RIFQIANSAH', '252610218', '$2y$12$yCK0DhS1/5m8gJ4G/cZnP.R4UL58f4MlwujQuNDy/m/FJOfcGfOlq', 'siswa', '2025-09-13 05:22:35', '2025-09-13 05:22:35'),
(563, 'RINTO', '252610219', '$2y$12$x.XX1aajmJlUlrabNr5wju96XuI9eb6LOTUYKTswCU4WYzeFuYUqG', 'siswa', '2025-09-13 05:22:35', '2025-09-13 05:22:35'),
(564, 'RISMA', '252610220', '$2y$12$1BQ6xVchpwoGAPlHM8WgXOjMVsEgRMUufv.zk2ipLrY9BMDHGTg3i', 'siswa', '2025-09-13 05:22:35', '2025-09-13 05:22:35'),
(565, 'SIVA YULYANTI', '252610221', '$2y$12$ghcDGcSCNVa0zxf14.slzuRLVfhFZwXNQmhbtueWtz4051U0Uh8gS', 'siswa', '2025-09-13 05:22:36', '2025-09-13 05:22:36'),
(566, 'SUHERMAN', '252610222', '$2y$12$jE3w8mjUa821KcpsL3cAQ.cvFWo.Wy/QH2G3RRGum3Xl5B08hfh.m', 'siswa', '2025-09-13 05:22:36', '2025-09-13 05:22:36'),
(567, 'SUNANTA', '252610223', '$2y$12$2Z5KARpmCa0JO2.SamDD4.qBo2GZtur.xOqHBEAD1vL0cI6dxrH4e', 'siswa', '2025-09-13 05:22:36', '2025-09-13 05:22:36'),
(568, 'SURYANI WIDYA PUTRI', '252610224', '$2y$12$YhQsq9jcpVk4SvUKxmto5uvsXhPtac1Jq762zNGrR2HqCefv6vv6y', 'siswa', '2025-09-13 05:22:36', '2025-09-13 05:22:36'),
(569, 'ULFIA ANGGIA PUTRI', '252610225', '$2y$12$GMP2fWCUFBwUJKj4minN.OXOU7ZA1IMAgHW7Kt0GvNEHh0DNzUkby', 'siswa', '2025-09-13 05:22:37', '2025-09-13 05:22:37'),
(570, 'WARDI', '252610226', '$2y$12$CQy34BweP7qp2Zik3MdNhOdX7Yty3W/dXI0MO/HCo6zS2NV06.puu', 'siswa', '2025-09-13 05:22:37', '2025-09-13 05:22:37'),
(571, 'WARDIMAN', '252610227', '$2y$12$OOI2lffnioDFhrDoKB7xquCn5s7xNkFqp7wZwCcfQKj5eNt8SbLu2', 'siswa', '2025-09-13 05:22:37', '2025-09-13 05:22:37'),
(572, 'ZAHRAN MAHESWARI', '252610228', '$2y$12$rgCosDiDFPr0VC6ZhJlugeM7KFhx0xB.ZAebDcJE.WcFRHR.ScJNq', 'siswa', '2025-09-13 05:22:37', '2025-09-13 05:22:37'),
(573, 'AHMAD RANDIKA', '252610229', '$2y$12$JiMUhitN/Gab4c2RqYKw0.MsRRtTQn4nNlEwLkvhFdCMM/R8wccqm', 'siswa', '2025-09-13 05:22:38', '2025-09-13 05:22:38'),
(574, 'AHMAD SAEPUDIN', '252610230', '$2y$12$zoB4VogodCAMd2dwjmhTD.mGUD2ujyuSAy7ttBcJ3Q8VcPBHgn.S6', 'siswa', '2025-09-13 05:22:38', '2025-09-13 05:22:38'),
(575, 'AHMAD SOFWAN ISMAIL', '252610231', '$2y$12$liNAOxPJth8U1pCG3d6GsemFsBjpgfxUW1qMkNxaC25dxV.BobeIm', 'siswa', '2025-09-13 05:22:38', '2025-09-13 05:22:38'),
(576, 'ANDHIKA RAMADHAN', '252610232', '$2y$12$NzFmn6NZ75opHT2eyqlwROb5r5OG74PsZUYRB/ckx7StMBx4QPDnG', 'siswa', '2025-09-13 05:22:39', '2025-09-13 05:22:39'),
(577, 'ANDIH SAEPUL BAHRI', '252610233', '$2y$12$6EFH3YqjEtwtZzuzFqRWsOPxKp99Sa4JEDblvaipTyo6rUP4BsE.m', 'siswa', '2025-09-13 05:22:39', '2025-09-13 05:22:39'),
(578, 'ANDIKA PRATAMA', '252610234', '$2y$12$RWzx/wsM371jgix4XVLMvOdWefm6FgkBeKQJmeHsGG1bigq8ET1Om', 'siswa', '2025-09-13 05:22:39', '2025-09-13 05:22:39'),
(579, 'ARIYA DARMAWANSYAH', '252610235', '$2y$12$YzgYmWNgtmc95is016Aq3exjQ4I6j3F9tFXMEP1tRtZNiz/Sce9LS', 'siswa', '2025-09-13 05:22:39', '2025-09-13 05:22:39'),
(580, 'ARSYA NUR HARLY HASAN', '252610236', '$2y$12$.EgExn7UKkXDnspYEzXpMu.S93GJal9LsIAg5Tvy/qrQO/LEEIdQK', 'siswa', '2025-09-13 05:22:40', '2025-09-13 05:22:40'),
(581, 'BENI KURNIA', '252610237', '$2y$12$Hk8EOtxstc24ljYFeySl2eKDEsXNSF/.27IjongnLDc0xJUXEWW4q', 'siswa', '2025-09-13 05:22:40', '2025-09-13 05:22:40'),
(582, 'CANDRA AKBAR', '252610238', '$2y$12$eOQbfuubrf7a1oiNr/i7N.82gJ6ICS/gM4xnLZsha.u8q28FmzTWK', 'siswa', '2025-09-13 05:22:40', '2025-09-13 05:22:40'),
(583, 'CINTIA', '252610239', '$2y$12$OQCU5Bt6NsXko5PfMdZ5GeUeM1bwyj6KPcilXDdox6NFNBhVR85h2', 'siswa', '2025-09-13 05:22:40', '2025-09-13 05:22:40'),
(584, 'DEWI CUT NADIN', '252610240', '$2y$12$2VTcBSwerwMJ4aWtAORfpeG6XTRjr3wzIvJaB3xmJ87TUF7PUL60G', 'siswa', '2025-09-13 05:22:41', '2025-09-13 05:22:41'),
(585, 'DIKA BAEHAKI', '252610241', '$2y$12$0rdZqBCSKMFAJxdlF1NBouNkZbqgvKsKeufJ28jtJnkfab3ynufHi', 'siswa', '2025-09-13 05:22:41', '2025-09-13 05:22:41'),
(586, 'DIMAS SETO', '252610242', '$2y$12$BWhEfwRZNUI1YSWi8m0PkeKow3THpSUVYuJeZU/F4x6HJxmOvj1D2', 'siswa', '2025-09-13 05:22:41', '2025-09-13 05:22:41'),
(587, 'FAIQ SUGILAR', '252610243', '$2y$12$LbjBxMwHqI6w6cyUgPHcguX6HYupS0DCdGX8F4nrDJpzNspr6JDVm', 'siswa', '2025-09-13 05:22:41', '2025-09-13 05:22:41'),
(588, 'FAJRUL MA ANI', '252610244', '$2y$12$C1ohChfHrtAYd1vFgZDNbex3CjEGxTnbVXthlLY1PI.oxxqjQFxNe', 'siswa', '2025-09-13 05:22:42', '2025-09-13 05:22:42'),
(589, 'FUJA SAEPULLOH', '252610245', '$2y$12$m1bsidJYsmbYf5RcxvUnnu7.dRX7D9wIKlQOTE4yEStf14cDauna2', 'siswa', '2025-09-13 05:22:42', '2025-09-13 05:22:42'),
(590, 'HENDI SETIAWAN', '252610246', '$2y$12$buUPx9ELmDN96WxYW7Meaer5GObRBjPXKRTT1O5qAB8iuAhju1SGi', 'siswa', '2025-09-13 05:22:42', '2025-09-13 05:22:42'),
(591, 'KARNATA JAYADI NINGRAT', '252610247', '$2y$12$440E8fxkiRSS9y.eBZBOQ.FQ3b.ImhTwfKEeZW0ubilofOObSRPlm', 'siswa', '2025-09-13 05:22:43', '2025-09-13 05:22:43'),
(592, 'MUHAMAD KHAIRUL INIESTA', '252610248', '$2y$12$EqqxI6tOV06Y4Qq3wC0cb.7bYTe.4YGdIO8kEDfjXolmwWX8ZRx8y', 'siswa', '2025-09-13 05:22:43', '2025-09-13 05:22:43'),
(593, 'MUHAMMAD DANIAL ALPIKRI', '252610249', '$2y$12$aTPwBjv000zUN/jECz1RIe4AFAU8Z/o6VnCIfRxhr5pDmb4isT8nW', 'siswa', '2025-09-13 05:22:43', '2025-09-13 05:22:43'),
(594, 'NENENG HABIBAH', '252610250', '$2y$12$4q3D20m.umAY47MIM1Abh.p8dQi1G1jc7STRI4v6xtVVtGwux6b/u', 'siswa', '2025-09-13 05:22:43', '2025-09-13 05:22:43'),
(595, 'NOVAL JUNIAN SALEH', '252610251', '$2y$12$PISfh/GuvVFFD8b/KIAFDegbcbKfV5kQEwR5JoeCLCJZbPdqoDhFO', 'siswa', '2025-09-13 05:22:44', '2025-09-13 05:22:44'),
(596, 'NUAF DHANU WINATA', '252610252', '$2y$12$7F5jl33fTB1Z2LlvqBAdyuUuzVNYJRHdoKuqNqi3gJvCEuGmaNyuq', 'siswa', '2025-09-13 05:22:44', '2025-09-13 05:22:44'),
(597, 'RAIHAN ABDUL YAFIDZ', '252610253', '$2y$12$GYzoXFeIDtcrHP.uTzwAB.a..0tKjQNt/jBex3IMktFWRRW3OPZCq', 'siswa', '2025-09-13 05:22:44', '2025-09-13 05:22:44'),
(598, 'REIHAN FIRMANSYAH', '252610254', '$2y$12$mQmW4VaEC0sYg3kFVwz8e.GsDL5A7ztSvBDG7Sj8QWD5T122g5p5a', 'siswa', '2025-09-13 05:22:44', '2025-09-13 05:22:44'),
(599, 'RIO RAMA', '252610255', '$2y$12$vzX25jfjV/wrnBruRCjh.Oca3IQyWWL8oRKfo89t5aha6dmh7JLja', 'siswa', '2025-09-13 05:22:45', '2025-09-13 05:22:45'),
(600, 'RITA FITRIA', '252610256', '$2y$12$rSxKMSkICksv7HHASbI2KuMDFo47ybqZ5TAAeQmitcNOy52NnLNXi', 'siswa', '2025-09-13 05:22:45', '2025-09-13 05:22:45'),
(601, 'ROFIKOH ALIYATUL SUNIAH', '252610257', '$2y$12$nu.Ih/1pHFmS4P9WMEgJ0uyG7k.iXFtTfI4BsdwtkbC6ZKy.d4RXq', 'siswa', '2025-09-13 05:22:45', '2025-09-13 05:22:45'),
(602, 'ROSAM CAKRA WINATA', '252610258', '$2y$12$G4SJ4M3hbDrMbV1Ol/CyQemIeS6kbDPMfLfCDq1iDSz.SIBVPzudK', 'siswa', '2025-09-13 05:22:46', '2025-09-13 05:22:46'),
(603, 'SAEFUL GOFAR', '252610259', '$2y$12$BNTFMjH1EfLfBUKkbtbCMumc2Vpz8kZEcbUmJlRoXHZ6p4Pqq25f.', 'siswa', '2025-09-13 05:22:46', '2025-09-13 05:22:46'),
(604, 'SAEPUL MAULANA', '252610260', '$2y$12$r4YilkLcS6Bjiu22zgNkGOIbQBesB72pB6bnbVUxgjbXIccq2dfMu', 'siswa', '2025-09-13 05:22:46', '2025-09-13 05:22:46'),
(605, 'SETIYAJI AHMAD FAUZI', '252610261', '$2y$12$yr8Uyf0D/1W8ossRp7rGFeMBrskPymcsDAvIixAZ2v6NfaaF8AWYe', 'siswa', '2025-09-13 05:22:46', '2025-09-13 05:22:46'),
(606, 'WINDY OCTOVIYA', '252610262', '$2y$12$ueb5EWqfmQAlAOgTALiHn.DaynmA.hFwaFgN9gSTwogeTZ0rj5FKS', 'siswa', '2025-09-13 05:22:47', '2025-09-13 05:22:47'),
(607, 'YUDI ADITIA', '252610263', '$2y$12$4D7u1B6WA5frtSgjOhKH0.0hiskKqdnyoSkjlLl8yCk.iSAYZZkgW', 'siswa', '2025-09-13 05:22:47', '2025-09-13 05:22:47'),
(608, 'ADILAH', '252610001', '$2y$12$jzS4RIwwSGrF5dNuijfCJuDlfT5cROL3OeQ3kuU1FkH0bCaJmYOrq', 'siswa', '2025-09-13 05:22:57', '2025-09-13 05:22:57'),
(609, 'ADINDA OKTAVIANA', '252610002', '$2y$12$btCuSAkz4vUdUq58zXpYVez4OYPTxtCoZSTTJyVKTHS9fkLCkE.b2', 'siswa', '2025-09-13 05:22:57', '2025-09-13 05:22:57'),
(610, 'ATIK CANTIKA', '252610003', '$2y$12$7cUVXOr0LKIhkJUR4kxaW.rXquiaBHdsGji0uHVgtH6OIp7zPXSmy', 'siswa', '2025-09-13 05:22:57', '2025-09-13 05:22:57'),
(611, 'AYU FADILLAH', '252610004', '$2y$12$6JyYPriSU9uIujLnKVtKJunou.u.EzvAR6qmQ23TubQBEzosANTOK', 'siswa', '2025-09-13 05:22:58', '2025-09-13 05:22:58'),
(612, 'BINTANG SAMUDRA SATYABUDIE', '252610005', '$2y$12$Ll7r4sjQxJWbcumSgW48P.FqkuDXJGR5h6OornVEDClSFcy9IwGVG', 'siswa', '2025-09-13 05:22:58', '2025-09-13 05:22:58'),
(613, 'DESFA NAILATUL NAFISA', '252610006', '$2y$12$FbJhHheZ1bBXqwf7FH/dUuxYapN7Qo2uJVZcS/m1zKjqI26coSGTe', 'siswa', '2025-09-13 05:22:58', '2025-09-13 05:22:58'),
(614, 'DONI RAMADHANI', '252610007', '$2y$12$btX4mHYIldGhkM4rzUklkuQNVbOFPqMK4cb4O5/VXgemy8oCVHMCG', 'siswa', '2025-09-13 05:22:59', '2025-09-13 05:22:59'),
(615, 'FITRIA ZAHRATUNNAJA', '252610008', '$2y$12$NWS/ipXC3ptypz7TsFjPs.XnGtlY4dk30YUmm8SDWU5DhpKk6M8Ue', 'siswa', '2025-09-13 05:22:59', '2025-09-13 05:22:59'),
(616, 'INDAH AFIFA', '252610009', '$2y$12$L47dfEVQB9V2GfTIYSuZguF.4sMPD2n5ZGTU749fgxhOcoRNDfI36', 'siswa', '2025-09-13 05:22:59', '2025-09-13 05:22:59'),
(617, 'INDAH LISNAWATI', '252610010', '$2y$12$7zFr.e9wRuzs1WjGHw3H4.MfPpqLiS9sooVSAuHlZF2nprMomghKy', 'siswa', '2025-09-13 05:22:59', '2025-09-13 05:22:59'),
(618, 'INDRI PUSPITASARI', '252610011', '$2y$12$vSI0fbt/wVOdZE1W0aRCs.XNlGS/ur5VKJAxHa3sgUQ/kbJfKnyD.', 'siswa', '2025-09-13 05:23:00', '2025-09-13 05:23:00'),
(619, 'IQBAL MAULANA', '252610012', '$2y$12$NEAjN2TsncWFTfaheof.Kex9nhfqjWLr9CXykM9u/AUxbzglqBqyG', 'siswa', '2025-09-13 05:23:00', '2025-09-13 05:23:00'),
(620, 'JIHAN KHOLILAH', '252610013', '$2y$12$FVbMAf2L4UQK81AXfdCBCes3Dh.YQtABHjy2YCNxo/5TMq2wAIsZu', 'siswa', '2025-09-13 05:23:00', '2025-09-13 05:23:00'),
(621, 'KARLINA', '252610014', '$2y$12$KqaZPVtw1Qn9QHqBvVCgNuUDkfPewASki3AbaLgKMpfwKVnE7osTK', 'siswa', '2025-09-13 05:23:00', '2025-09-13 05:23:00'),
(622, 'KHOLIFAH RIZKA NURSAADAH', '252610015', '$2y$12$5YLX/kt6HOyzFmNvA/76veZk8mjuI0ZH0Z21l1wHpoMYIb4/OpNM2', 'siswa', '2025-09-13 05:23:01', '2025-09-13 05:23:01'),
(623, 'KOMARIAH', '252610016', '$2y$12$QPog62phw5iAstt9jP9Mduw7NYWwCHh0XKgf/HYuM0EMo2hPZgasG', 'siswa', '2025-09-13 05:23:01', '2025-09-13 05:23:01'),
(624, 'NURUL HABIBAH', '252610017', '$2y$12$TK783vOsV.5oH1LpGvvhG.7g3pJTkDxTd14R/lKz8r6k2T/FMmANe', 'siswa', '2025-09-13 05:23:01', '2025-09-13 05:23:01'),
(625, 'RISMA NURMALA', '252610018', '$2y$12$Q36aqQ.PwfZX3q1EwHJOVOVBp3qBDbMqM4pF4iWwrpolYYJWse2Te', 'siswa', '2025-09-13 05:23:02', '2025-09-13 05:23:02'),
(626, 'SALWA ANUROH', '252610019', '$2y$12$oJFR8v/TLKHHsxArkm4CHu3ziWlYIXx0hjX90HL2zWMfoIOK5XHuW', 'siswa', '2025-09-13 05:23:02', '2025-09-13 05:23:02'),
(627, 'SHIPA', '252610020', '$2y$12$fwwO3UiFDEPh8xzXZ2zSmOrEF0OAVyVP3dtnS6bOB/zM7i4dcVnmS', 'siswa', '2025-09-13 05:23:02', '2025-09-13 05:23:02'),
(628, 'SHOFIA AISYAH MUSAFAAH', '252610021', '$2y$12$fpCr9C59lepDlrd3RQqCJO.vcK520LlDOmPnUclSoskauHnOuVGoq', 'siswa', '2025-09-13 05:23:02', '2025-09-13 05:23:02'),
(629, 'SITI ALISA', '252610022', '$2y$12$zXuLP.nYdycF3.mhoHwH5umIRUodk7eukUWnOCF4lqmRbKtpKC0oK', 'siswa', '2025-09-13 05:23:03', '2025-09-13 05:23:03'),
(630, 'SITI AMINAH', '252610023', '$2y$12$UmGcN0jzoAFQaEK2.LmUrO.WUy0hUWiriW67ogqFu8BugdPmKCJ5q', 'siswa', '2025-09-13 05:23:03', '2025-09-13 05:23:03'),
(631, 'SITI FATIMAH', '252610024', '$2y$12$ldvdRPvoJN/5mgp5k9ETI.0MuF22yttAkRCDzuP/ODQ99I9lnbqta', 'siswa', '2025-09-13 05:23:03', '2025-09-13 05:23:03'),
(632, 'WARNIH MELINDA', '252610025', '$2y$12$kjfKKTcEIk.tJIlXAdVwPeFkJEBUn8CPQ33wiJBKLmuIuEnoUY9Ly', 'siswa', '2025-09-13 05:23:03', '2025-09-13 05:23:03'),
(633, 'WINA', '252610026', '$2y$12$rw4trpzL.yaTqLH1u8WzKOFaVIJDn.Rg9sGuJC/nA91.4Osvgb1ty', 'siswa', '2025-09-13 05:23:04', '2025-09-13 05:23:04'),
(634, 'ZASKIA PUTRI', '252610027', '$2y$12$d9fKmXTd8I0.FoiNSrkaNOFxJPIfTQrCK2yAia3m4Ziwnd3buUvYu', 'siswa', '2025-09-13 05:23:04', '2025-09-13 05:23:04'),
(635, 'ALLEEISYA DAVINA KAMANDHANIKA', '252610028', '$2y$12$z1VgdoeVL85t1hmGxXjSLOtDHSXyoSVyq7po8klQMqBEqlBCtIenK', 'siswa', '2025-09-13 05:23:04', '2025-09-13 05:23:04'),
(636, 'ALYA HANDAYANI', '252610029', '$2y$12$HOczcrMgblmbLZ0/upIGw.PJs/HHZlp/vt2oGibJFkeetZ1829LXO', 'siswa', '2025-09-13 05:23:05', '2025-09-13 05:23:05'),
(637, 'ANI SUHAENI', '252610030', '$2y$12$43qjcbsf0cezrshxZHU/bOD2xTjnco8m1U02dPbZV03Cisqb.cR1G', 'siswa', '2025-09-13 05:23:05', '2025-09-13 05:23:05'),
(638, 'ANITA', '252610031', '$2y$12$FzdMqmTMg.kPANYVhDVVzO0Pfbg6hExu/sxcT9zwKuDOjA9.vXAeC', 'siswa', '2025-09-13 05:23:05', '2025-09-13 05:23:05'),
(639, 'APRILLIA ANATASYA', '252610032', '$2y$12$kEgXN3yHvQWu18PAEK/QHOo2O7CZbGkGuLKdu9y0lpc.GyMYTnMRu', 'siswa', '2025-09-13 05:23:05', '2025-09-13 05:23:05'),
(640, 'AULIA ISHAQUE', '252610033', '$2y$12$IUJWTPneE8J1GS5.D8jNc.XeWNtK9FuW57JvKjwEbm7xx2fEIO1ye', 'siswa', '2025-09-13 05:23:06', '2025-09-13 05:23:06'),
(641, 'AVRIL AVPRIDA HARIYANA', '252610034', '$2y$12$V8YLsZ6utQ7KNDneWktKGuhtzWNTzdHugbnM06uBXChdmnDY8Sdba', 'siswa', '2025-09-13 05:23:06', '2025-09-13 05:23:06'),
(642, 'CITRA LESTARI ROHIMAH', '252610035', '$2y$12$Bzfsx9bgmlQkGuGDk5I1r.IDK8PABmo2ceOlcpACaBO3/nj6Sw.2e', 'siswa', '2025-09-13 05:23:06', '2025-09-13 05:23:06'),
(643, 'DINA', '252610036', '$2y$12$dU333Zk0nnDTM11C8b.Ri.Hbcic0GKmuxs9hxS9yrdrON/llHZ62W', 'siswa', '2025-09-13 05:23:06', '2025-09-13 05:23:06'),
(644, 'ENENG JUMARIYAH', '252610037', '$2y$12$H8lgaX2/FrEebbbG5k/W0evuU9GN9SavPOFqBocjteCDvtDXSLsEe', 'siswa', '2025-09-13 05:23:07', '2025-09-13 05:23:07'),
(645, 'ENGKOM KOMARIAH', '252610038', '$2y$12$XkGGntNS6bzgtAIWO4ACwuiVBkTyvDrRToUZq9TUoEEjSHnmkIz7u', 'siswa', '2025-09-13 05:23:07', '2025-09-13 05:23:07'),
(646, 'HENA ALI', '252610039', '$2y$12$j6.RUdR4IHY5p8VWMveuIeE0W33nExeRHps/uBnJYneCiYOVepUvO', 'siswa', '2025-09-13 05:23:07', '2025-09-13 05:23:07');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(647, 'JIHAN ANNASTASYA', '252610040', '$2y$12$bC592ZoeqNgCZv4G2oUVUeg4k8pvanu8KVwwRVydZcQz07O3DKi9q', 'siswa', '2025-09-13 05:23:07', '2025-09-13 05:23:07'),
(648, 'KURNIA HANAPIAH ISWANDI', '252610041', '$2y$12$pDW1ppkArGOikumI/4NL3ehpeEWpfOKSik8LTfJWFqao5QKbxfzQ2', 'siswa', '2025-09-13 05:23:08', '2025-09-13 05:23:08'),
(649, 'LATIFAH', '252610042', '$2y$12$uaIsJHBfJHij/tXxf3Wye..j3HtCSRqRDoqonGQ4EgUjES69pYFze', 'siswa', '2025-09-13 05:23:08', '2025-09-13 05:23:08'),
(650, 'NASYA MAHARANI', '252610043', '$2y$12$s9fUPTR3DGZY4izXaMtv5uoPb8qHNZ7b0UqWv5p.qhyDjWerIrQp2', 'siswa', '2025-09-13 05:23:08', '2025-09-13 05:23:08'),
(651, 'NUR ALBIAH SALWA', '252610044', '$2y$12$lHzVvc4b6qPVG3Tt7liKVOj45oteaUvecBF704n71g1bRfJYA3oB2', 'siswa', '2025-09-13 05:23:09', '2025-09-13 05:23:09'),
(652, 'NUR SIFA ANGGAENI', '252610045', '$2y$12$Hm5m6/IMvEviCY2FmXknAeTim71fMKZzccG6seIe761gVRHFImk7a', 'siswa', '2025-09-13 05:23:09', '2025-09-13 05:23:09'),
(653, 'PUTRI SASKIA', '252610046', '$2y$12$c8OHsrxUaMtVu0hQAoGMae/zGQeRG6dLAcQQoXjCE/kCudSLAVGXS', 'siswa', '2025-09-13 05:23:09', '2025-09-13 05:23:09'),
(654, 'RAHMA YANTI', '252610047', '$2y$12$hs239m/ahruZnC3pHmBLQ.YL5zaXPyyOuACg0uN5MpYx5MYSUkTgu', 'siswa', '2025-09-13 05:23:09', '2025-09-13 05:23:09'),
(655, 'RANI AMELIA', '252610048', '$2y$12$KgrxXw4FvIpZgvfDv300TOfLg4yp0Qka5iED20gqsPixBapDBBsnO', 'siswa', '2025-09-13 05:23:10', '2025-09-13 05:23:10'),
(656, 'SAHAR SYAFITRI', '252610049', '$2y$12$wo2IbP31exa2VhMlsGfcP.uepjUoyRHOye4kUt6NFFpJcCuagPv3W', 'siswa', '2025-09-13 05:23:10', '2025-09-13 05:23:10'),
(657, 'SALSA BILA AZZAHRA', '252610050', '$2y$12$OJqazVxvaNs73gbuyO959.7Nm64M74GkdiIVzUYSoU5zqL8mwYH/K', 'siswa', '2025-09-13 05:23:10', '2025-09-13 05:23:10'),
(658, 'SHIFA ADELIA MAWAR', '252610051', '$2y$12$P/UNZ9.a6njLKBMMLOVSh.78hFtyWoRy2wMCZxrMrA5pyIGw3OAiK', 'siswa', '2025-09-13 05:23:10', '2025-09-13 05:23:10'),
(659, 'SINTA SUTIA', '252610052', '$2y$12$htrLw/P4egtXvGs05ds/Ye35kedZ7ydQfVA9WAJQOKo43r0GiPT1G', 'siswa', '2025-09-13 05:23:11', '2025-09-13 05:23:11'),
(660, 'SITI NURZAHRA', '252610053', '$2y$12$qs0zrn8GTZ/chK4/WU/b3ucnz8IRmVf.K8wx3QMcPxiicu9sh/zBe', 'siswa', '2025-09-13 05:23:11', '2025-09-13 05:23:11'),
(661, 'SITI ROMLAH', '252610054', '$2y$12$pOwBQPuzJ/Sr1pV1AHkBKuuTy3DrtLl2r1XMZ74394b1x0CTGDMfy', 'siswa', '2025-09-13 05:23:11', '2025-09-13 05:23:11'),
(662, 'TANIA OKTAVIANI', '252610055', '$2y$12$8vQAHYaMw/mDaqXFwTRVk.lBAC6niV64/W9efOJy95foojnOABZK2', 'siswa', '2025-09-13 05:23:12', '2025-09-13 05:23:12'),
(663, 'WINDI ALTIYAH', '252610056', '$2y$12$ooBTCtBdw5iSTZHxPHkdkeKhuDgdPh4dj6T/QvClPeqSwutn.XM6i', 'siswa', '2025-09-13 05:23:12', '2025-09-13 05:23:12'),
(664, 'ABU HAMAD MASKURI', '252610057', '$2y$12$a0kdgB/dVi6eTOKr82wiNeud7L8KssAQRgCWLF.s1GhiGW4xQj3Ya', 'siswa', '2025-09-13 05:23:12', '2025-09-13 05:23:12'),
(665, 'ADE IRWANSYAH', '252610058', '$2y$12$KTakJTRWxON72F5hyeAzNOSWsG8zFzShVphUhSU8/TAtWoaV0oKUO', 'siswa', '2025-09-13 05:23:12', '2025-09-13 05:23:12'),
(666, 'ALDO SUTISNA', '252610059', '$2y$12$liYufwTip9Qnh3FfaofsgeOG7VlNzjeQNTT5krFo4XmQhvOeUsrDW', 'siswa', '2025-09-13 05:23:13', '2025-09-13 05:23:13'),
(667, 'ANDIKA PAJAR MAHDI', '252610060', '$2y$12$aLOygezdv8H8gpWWGmTmU.K5L/Zf1Qrle6/y8Q2s3tjqCKj/AaAXC', 'siswa', '2025-09-13 05:23:13', '2025-09-13 05:23:13'),
(668, 'ANDINI ANGGRAENI', '252610061', '$2y$12$12yXnXpHPU4GtTEH50o7pOyxEk7diiJogm6IbrdTs.nQTcAIEukYS', 'siswa', '2025-09-13 05:23:13', '2025-09-13 05:23:13'),
(669, 'BAGAS ARDIWINATA', '252610062', '$2y$12$iFdzWxbUpXMUD7tQqqjcxeUxoeuHwJvAj9f3KNFvv4N4zaU3pG4oK', 'siswa', '2025-09-13 05:23:13', '2025-09-13 05:23:13'),
(670, 'CHIKA SIPA ANGGITA', '252610063', '$2y$12$FG5f4p7LDtofPQt7so7RDO8jU4Q1SvG4w6ii.mvPbCo/b00EUoMje', 'siswa', '2025-09-13 05:23:14', '2025-09-13 05:23:14'),
(671, 'DANI SETIAWAN', '252610064', '$2y$12$infDidaJSV2SeiDTs0vFkeaEw645K8xZUSxvrM9Y7EWpIGwCY5k7S', 'siswa', '2025-09-13 05:23:14', '2025-09-13 05:23:14'),
(672, 'DANI SUTISNA', '252610065', '$2y$12$p89Ha/4S8FMqBDcSO.b3OODgBqX7lAmJtIEyADGnW4cXxirYIdkCO', 'siswa', '2025-09-13 05:23:14', '2025-09-13 05:23:14'),
(673, 'DANIA OKTAVIA', '252610066', '$2y$12$qLJ79DqRloAi/fJNnVfUvuNq0wn3WWIw1I.xkWIdMvQQjrBKz8J5.', 'siswa', '2025-09-13 05:23:15', '2025-09-13 05:23:15'),
(674, 'DIMAS AHMAD RAMADAN', '252610067', '$2y$12$9oKo01khU7wEiB33Bv3WOe5/jLTDCjlgO4c4TiOC5zhkAAcUgsewO', 'siswa', '2025-09-13 05:23:15', '2025-09-13 05:23:15'),
(675, 'DIRLY ANGGADITA', '252610068', '$2y$12$.xcNHc.q7j2x87r0zV3c0u0lO4iBqbwJ9CROp/MZjxS8244Uwe5BC', 'siswa', '2025-09-13 05:23:15', '2025-09-13 05:23:15'),
(676, 'EDI SETIA GUNAWAN', '252610069', '$2y$12$phW20Z5g8UAb.aCU5WEwje2Z0ALQpSQFIIJCcoFIJKlsBaEAU6rDK', 'siswa', '2025-09-13 05:23:15', '2025-09-13 05:23:15'),
(677, 'EKA BAMBANG SAPUTRA', '252610070', '$2y$12$cgiIqwnBE9tZqWioFMbtSucQvzKriEOH5t2pb2/3epEyiSWQ1WHWi', 'siswa', '2025-09-13 05:23:16', '2025-09-13 05:23:16'),
(678, 'ENDRIK PURNAMA', '252610071', '$2y$12$nCu6r58PCy9ZWJor0HV2sOAMppmKO4UUEFzxew2EXXb0cCs6pcy4C', 'siswa', '2025-09-13 05:23:16', '2025-09-13 05:23:16'),
(679, 'HERMANSYAH', '252610072', '$2y$12$gwGP.6mMk0WIFAHSSCMMo.vnkfQBjI.xQuR8HyMC.QKjiq43MUcjy', 'siswa', '2025-09-13 05:23:16', '2025-09-13 05:23:16'),
(680, 'HIDAYATULLAH', '252610073', '$2y$12$1cw5EmViOmbXivlxm0W1oOf6bzHITAPyl9uI8o6.G9wYldLQZGdXq', 'siswa', '2025-09-13 05:23:16', '2025-09-13 05:23:16'),
(681, 'JAEN', '252610074', '$2y$12$/gUsawKyH8Q9Ek1cyHCqCeq0EOhprQp07dDsT2Chaj33oC.8B/J1.', 'siswa', '2025-09-13 05:23:17', '2025-09-13 05:23:17'),
(682, 'JULIYANTO', '252610075', '$2y$12$WACCFUwxAzWM9viN8VS2ce2LoWkevdeNHck8mYdMuVOCNCpUcGH6e', 'siswa', '2025-09-13 05:23:17', '2025-09-13 05:23:17'),
(683, 'MIFTAHUL ARIFIN', '252610076', '$2y$12$54l4zcBjYncj2mOCxitFHuLdYGr3WoEfHvt/QjqdzHmEnYJ06E7z2', 'siswa', '2025-09-13 05:23:17', '2025-09-13 05:23:17'),
(684, 'MIT F FELIX GUSNA', '252610077', '$2y$12$sqqD4j57TXyJtkiWhs2fh.TfWRhLZtAVELW.PoGCT9bYoOerM3FDS', 'siswa', '2025-09-13 05:23:18', '2025-09-13 05:23:18'),
(685, 'MUHAMAD MUHIBIN', '252610078', '$2y$12$UCFP5ep8K0u1s9sJp..qt.IjwcUI8/PdpuVcF60tRoW3xV/KR2rvK', 'siswa', '2025-09-13 05:23:18', '2025-09-13 05:23:18'),
(686, 'MUHAMAD RADITIYA', '252610079', '$2y$12$M.UdlGkGnxnBBYYZoOvxZucCTfQ7LqQU7YoC4EUgtQ5F7qKbRJ8kS', 'siswa', '2025-09-13 05:23:18', '2025-09-13 05:23:18'),
(687, 'MUHAMAD RIZKI BAEHAKI', '252610080', '$2y$12$oYEoT3rcA8scafW.2PqtIe5ZyrXlsnpoacdYBSI7dG.WRfLHopxwu', 'siswa', '2025-09-13 05:23:18', '2025-09-13 05:23:18'),
(688, 'MUHAMAD RIZKY HABIBI', '252610081', '$2y$12$Z9OoMsJkDBoVyJN2zcczH.SU3zXGAkcdHDU.cFUDnYeiWcv54vWie', 'siswa', '2025-09-13 05:23:19', '2025-09-13 05:23:19'),
(689, 'MUHAMMAD AL ISRA FIRMANSYAH', '252610082', '$2y$12$C1qbXwDYTxAzS8FZlv.GU.mwNq2QnlpPutTPJ2idQYAr32IG6X.gG', 'siswa', '2025-09-13 05:23:19', '2025-09-13 05:23:19'),
(690, 'MUHAMMAD FARHAN ADI PUTRA', '252610083', '$2y$12$qR8OZD4oFWGoszSQi02leOLiu7ylWQbojDaoZi/t1.1/XW8N2UktG', 'siswa', '2025-09-13 05:23:19', '2025-09-13 05:23:19'),
(691, 'RIFALDI JULIANSYAH', '252610084', '$2y$12$4Po5W6RQ7.HtHrRy3HMTbOlFcfdN32eaMv85Hdu22AaOwHSNJBeKy', 'siswa', '2025-09-13 05:23:19', '2025-09-13 05:23:19'),
(692, 'RINDI', '252610085', '$2y$12$jzv4i3SDDBUQbBLdayAVJ.zUHlwACHgQeoL6ox2xZarVtKQp4J3zi', 'siswa', '2025-09-13 05:23:20', '2025-09-13 05:23:20'),
(693, 'RISFI HIDAYAT', '252610086', '$2y$12$I3QCT3uEGx0w0uUsdEczM.oJ8s1ma0mG8jRasiAD3LDbP2qNThRHq', 'siswa', '2025-09-13 05:23:20', '2025-09-13 05:23:20'),
(694, 'TAOPIK HIDAYAH', '252610087', '$2y$12$IWtgKxaaO4kvNZlvOFFoJeelCjFTRqegbXb2ccMjDDXDz0gCmWRSC', 'siswa', '2025-09-13 05:23:20', '2025-09-13 05:23:20'),
(695, 'WISNU HASLAN FARID', '252610088', '$2y$12$BK0XRMwxD/Zb2yzfa3gfau23dhgG0tPHnjuzJCnAgLuIDvmP1N4CS', 'siswa', '2025-09-13 05:23:21', '2025-09-13 05:23:21'),
(696, 'YOMI ABDUL MANAH', '252610089', '$2y$12$afPl.VTEdkBvKJIwSg21CO5.zLKpt9o6Py3ZsT0mNzHq3AeD0hz22', 'siswa', '2025-09-13 05:23:21', '2025-09-13 05:23:21'),
(697, 'ZAKI IBNU KHAIRI', '252610090', '$2y$12$tVfePOafNeVp113yQ7VPveD1jWy2/xpER9SBgOt.zJ7b9WZiUeTaC', 'siswa', '2025-09-13 05:23:21', '2025-09-13 05:23:21'),
(698, 'ABDUL LATIF', '252610091', '$2y$12$NZqUHYlTuVXNoTcO1.RNKeXl5xko60DlYsYkDqM7eVhlkt8aNzqpO', 'siswa', '2025-09-13 05:23:21', '2025-09-13 05:23:21'),
(699, 'ADE IRFAN', '252610092', '$2y$12$GTFBnik7nyH1V0EePqFMVePKRuEQphuyLy/grroR6/qkio6hs5DNa', 'siswa', '2025-09-13 05:23:22', '2025-09-13 05:23:22'),
(700, 'ADE KRISYANTO', '252610093', '$2y$12$w0DhUIPZMDDsxvu7yFzq8uTHcdjawgTXecbigxr6ktyz6lFDpRV6y', 'siswa', '2025-09-13 05:23:22', '2025-09-13 05:23:22'),
(701, 'ADITIA SIMATUPANG', '252610094', '$2y$12$Th8FIYFhjoVv4NCU5DbOB.WyUZVvR.JCFmoRsCKMdo164lVqw3YDi', 'siswa', '2025-09-13 05:23:22', '2025-09-13 05:23:22'),
(702, 'AHMAD FAUZAN', '252610095', '$2y$12$.DO7haHDlnJYyegsMNwJe.m94umppaXgFUpYO6yjEGXmtVEBbG89O', 'siswa', '2025-09-13 05:23:22', '2025-09-13 05:23:22'),
(703, 'AHMAD FAUZI', '252610096', '$2y$12$SfmnMeq/DxabwpRm7no72uSo4EQ5r7BMvzGAwNhzi.Ph0T7ZQocHi', 'siswa', '2025-09-13 05:23:23', '2025-09-13 05:23:23'),
(704, 'AKBAR JUNIARDI', '252610097', '$2y$12$E1zMV1U9vxfE0b6DQBWS4eN/Fk7ME9GCbKVqctC4vJWuopeGgdxwS', 'siswa', '2025-09-13 05:23:23', '2025-09-13 05:23:23'),
(705, 'ALDI', '252610098', '$2y$12$tiZSQDKJ6db5fw3Azlk3SOwKmUXhtBXNcW8l1yBiuOBACMLlJprBS', 'siswa', '2025-09-13 05:23:23', '2025-09-13 05:23:23'),
(706, 'BUNGA IRMA REFALIA', '252610099', '$2y$12$Ut.eo15k.drSqByuPQ7G0eeb84CmEzTyQpzLPcmOv/e3Y1p8VhEly', 'siswa', '2025-09-13 05:23:24', '2025-09-13 05:23:24'),
(707, 'DENIS', '252610100', '$2y$12$jvRtX2wA20Nppio4UrocEONACx7caBJeDz/cseG8vSp3G8KQUjfgK', 'siswa', '2025-09-13 05:23:24', '2025-09-13 05:23:24'),
(708, 'DIDI FIRJATULLOH FADIB', '252610101', '$2y$12$zYccZc.OPVMRJkQ74X0x1OMWGCZDa35zOJMZZtK0m3Aix1ufI6oim', 'siswa', '2025-09-13 05:23:24', '2025-09-13 05:23:24'),
(709, 'DIMAS HAFIDDUDIN', '252610102', '$2y$12$MpHTcYBSvgUjpyOT31YM.uXbW3tE8n688TOIBTg5a4KnWrbsuPnWO', 'siswa', '2025-09-13 05:23:24', '2025-09-13 05:23:24'),
(710, 'DINI AMELIA PUTRI', '252610103', '$2y$12$E2v.IkPcSh0E867WO.qq1uI/ZK9dySA9TTQzwW.CvtGJCAX3QwjYS', 'siswa', '2025-09-13 05:23:25', '2025-09-13 05:23:25'),
(711, 'ENJELIKA APRIDA', '252610104', '$2y$12$i9XSpPJjyK6wj9AqUzSbMO6SZTU/6hCArjnY95m7uOnnQCtGbRizy', 'siswa', '2025-09-13 05:23:25', '2025-09-13 05:23:25'),
(712, 'FAISAL AKBAR', '252610105', '$2y$12$1mrIJRqAo2DQ4jSWuXpqnev4cQQmN6XwsSSk3UJDAUxyD9Rh1qeI2', 'siswa', '2025-09-13 05:23:25', '2025-09-13 05:23:25'),
(713, 'GIAN JANU PANDU SAPUTRA', '252610106', '$2y$12$jonDpie0ZIKSGzjI8VX.iuBFUF5s0e/sr1yLNmiPDwsDbtVaE6Nv6', 'siswa', '2025-09-13 05:23:26', '2025-09-13 05:23:26'),
(714, 'HAFID JULIANA', '252610107', '$2y$12$FURe2w6OU7avd8Dxd2wZFuq.T4ZUuZUE.jiSKnpuT00jMsmLTzQz2', 'siswa', '2025-09-13 05:23:26', '2025-09-13 05:23:26'),
(715, 'IQBAL ALBIANSYAH', '252610108', '$2y$12$HvP8y0uMn5zY2LXGYuyTI.Mu9ssgw0/JHJtalbz73fge9mnZG1R9a', 'siswa', '2025-09-13 05:23:26', '2025-09-13 05:23:26'),
(716, 'IRWAN SAPUTRA', '252610109', '$2y$12$A3M7uobt3ONz7aCgXD0jQeRhwUD3AqLynKJMgiQT/xWPApON3hxlm', 'siswa', '2025-09-13 05:23:26', '2025-09-13 05:23:26'),
(717, 'MUHAMAD FAZRI', '252610110', '$2y$12$uWyPrQFPQ2rcwl6sCWRhUeqzVKTZ4cXvd2SeRPfEHXPHI6CHXuPAm', 'siswa', '2025-09-13 05:23:27', '2025-09-13 05:23:27'),
(718, 'MUHAMAD HUSAIN HAFIZHULLAH', '252610111', '$2y$12$rr3bA9VUY/52imEJKVxfAORfQ6RKXR5WMpNINsXO8DCEJ8ja.x8QO', 'siswa', '2025-09-13 05:23:27', '2025-09-13 05:23:27'),
(719, 'MUHAMAD SOLEH ALFIKRI', '252610112', '$2y$12$shrjwNbdUsce0UqXw9ug2uwF5kyVHpzlgjL.l9rCcE3fPsL/WABN.', 'siswa', '2025-09-13 05:23:27', '2025-09-13 05:23:27'),
(720, 'MUHAMMAD REFAN REPIS', '252610113', '$2y$12$r8jBwkd0l/nUbf4N69ilAefWPYnRe52KTAuCi3ZQDKmeoQ/uV1a.C', 'siswa', '2025-09-13 05:23:27', '2025-09-13 05:23:27'),
(721, 'NIZAR NASIHUDIN', '252610114', '$2y$12$F6jo0KPFkYgJb5oD6agqZ.OKOCFupM1dR7luY1q4kzXphE6hF7JhG', 'siswa', '2025-09-13 05:23:28', '2025-09-13 05:23:28'),
(722, 'RAHMAT MURTI UMAY PUTRA', '252610115', '$2y$12$hkTawCyDfGUdBB7YsN/x/OWRN0247A/8rlPzbmySjo0.H/6Oux6E6', 'siswa', '2025-09-13 05:23:28', '2025-09-13 05:23:28'),
(723, '	RAJA SITA ATMAJA', '252610116', '$2y$12$CW9RIx/ZxDC76rMj1L4Jn.lX5zbaEA0sO/OfOdkTmY/wx3KG6KlIK', 'siswa', '2025-09-13 05:23:28', '2025-09-13 05:23:28'),
(724, 'REYHAN ABIDIN', '252610117', '$2y$12$GWZt0wxSFxpHWbW8171XBeWBqF1OUMNxF7wZdGJfFQNKFlvX9Axf2', 'siswa', '2025-09-13 05:23:29', '2025-09-13 05:23:29'),
(725, 'REZA ARDIANSAH', '252610118', '$2y$12$blgqTnuMUOwCEKOU8LLn7uFsf0Xhl6ScTieg9jYxdpy3thbP1wZo6', 'siswa', '2025-09-13 05:23:29', '2025-09-13 05:23:29'),
(726, 'RHEDY AFRILIANS NUGRAHA', '252610119', '$2y$12$hGwo85Wl/KgvTmGzdywRReu2NLMaVBcxPRZmaPhhOkqy1woZ5s9Tm', 'siswa', '2025-09-13 05:23:29', '2025-09-13 05:23:29'),
(727, 'ROSALINDA', '252610120', '$2y$12$BAlBInYJBUCc0A/4E4iOT.yxVuo2ngXJ2XvFzWa5ggT4Gs3iJpbbG', 'siswa', '2025-09-13 05:23:29', '2025-09-13 05:23:29'),
(728, 'SITI MARYAM', '252610121', '$2y$12$5quI8Jz1mLRZAer0mKG8Ve7tI5mujpiGv.aI5qozjgjU1De20NZwq', 'siswa', '2025-09-13 05:23:30', '2025-09-13 05:23:30'),
(729, 'SITI PAIDAH', '252610122', '$2y$12$0ge7GjPopfgMjRFTwGUwu.gen4PmuZH/PZSOnJ4H2gE7tw.QaqLbG', 'siswa', '2025-09-13 05:23:30', '2025-09-13 05:23:30'),
(730, 'SRI LESTARI', '252610123', '$2y$12$OvCPZ98c6MtN.Is5cx39x.vP.rCCRGA3VM0gpkMGDl/kDT5UGXAse', 'siswa', '2025-09-13 05:23:30', '2025-09-13 05:23:30'),
(731, 'TRYO ABDULGONI', '252610124', '$2y$12$yJgb11kiA.DY2eqVFzfvmuUvCrS7oiEyHx/r4pBod0B22b4RyKjYS', 'siswa', '2025-09-13 05:23:30', '2025-09-13 05:23:30'),
(732, 'TUBAGUS NAWAWI', '252610125', '$2y$12$Wf3BEQLCrKR9.ndbkJRoXe4f4UNmFmDyIR5ZTn9oRbLVqhB04nBvC', 'siswa', '2025-09-13 05:23:31', '2025-09-13 05:23:31'),
(733, 'AHLIS ARFA NAOZA', '252610126', '$2y$12$akInP3QAMxnbG4X57HRlseXfCEkDN12ANleB5js6z4fOLlnksgH9S', 'siswa', '2025-09-13 05:23:31', '2025-09-13 05:23:31'),
(734, 'AHMAD FAUZI', '252610127', '$2y$12$1nY6P7Q/.pUeCydbB7FJcOugpGlLz5FV1tEYkq5YJK6iETdMZ7fMa', 'siswa', '2025-09-13 05:23:31', '2025-09-13 05:23:31'),
(735, 'AHMAD RIDWAN', '252610128', '$2y$12$jYdWImLQhOlJU9KekIZKQetstlX0WEITeWM2NoyHEJzjsrkN1RJBK', 'siswa', '2025-09-13 05:23:32', '2025-09-13 05:23:32'),
(736, 'AHMAD RIFAI', '252610129', '$2y$12$cHorLrVYHANG.Fs0PJwxQeAaut3ndQkCb2D23T.6isLtGshHwLcDi', 'siswa', '2025-09-13 05:23:32', '2025-09-13 05:23:32'),
(737, 'AKBAR MAULIANSYACH', '252610130', '$2y$12$Gj4g.QUJYK1BhFoqTu0qXusX2130cps5cUJRg8rGG.xrNh0W5dVkm', 'siswa', '2025-09-13 05:23:32', '2025-09-13 05:23:32'),
(738, 'ANDINI', '252610131', '$2y$12$4DAWXcd8UhTZydCd.FV9rufOXbGZkNpynw75Tng4lclKt4Y51Pami', 'siswa', '2025-09-13 05:23:32', '2025-09-13 05:23:32'),
(739, 'AYU ADIRA', '252610132', '$2y$12$MrKS5ZjeHw4QGkmOm0okTOx4ooKOO85TnGx0NJRW3qA2udgmXwvLu', 'siswa', '2025-09-13 05:23:33', '2025-09-13 05:23:33'),
(740, 'CANDRA MAULANA', '252610133', '$2y$12$xbFmaE467fjFMyo7rYBmPu4yPzczKfl88YoMAsXwy21CVBs/8Zvf.', 'siswa', '2025-09-13 05:23:33', '2025-09-13 05:23:33'),
(741, 'CIKAL ERLANGGA', '252610134', '$2y$12$mNltTc90Zpg5663cV3qdBe9R9xZ7GEDdoWOoj9SVjARW4bYDkH5lK', 'siswa', '2025-09-13 05:23:33', '2025-09-13 05:23:33'),
(742, 'DENI RIZKY PRATAMA', '252610135', '$2y$12$7gocQH6y5xACh1WDlJIELeYnFulkrSsqyeNT4Cw9/3grVmZ67o9ee', 'siswa', '2025-09-13 05:23:33', '2025-09-13 05:23:33'),
(743, 'FAHRI ALIF FADILLAH', '252610136', '$2y$12$S3fgPPmLLSVKxjl4W2ecxOjkG.PqYvOD80B3jYPXVcPno4KTttPe6', 'siswa', '2025-09-13 05:23:34', '2025-09-13 05:23:34'),
(744, 'GALANG RAMDANI', '252610137', '$2y$12$IffGyPTzv0MMFPhrAVkfC.zlfZYmyFvgE8gHfV/okf6kPa7rOQdsu', 'siswa', '2025-09-13 05:23:34', '2025-09-13 05:23:34'),
(745, 'HADID SWARA GUMILANG', '252610138', '$2y$12$wSriAz9O/HjsVyWe5YTrSuiyTskeNvWMa68iQ5XpcGIN0eXPsFFr2', 'siswa', '2025-09-13 05:23:34', '2025-09-13 05:23:34'),
(746, 'KARTIKA SARI', '252610139', '$2y$12$igpMtVSbVZUkYl9IuZx1zuYsH/HqNVU3sgOASmFfze7/AA5SakZPW', 'siswa', '2025-09-13 05:23:35', '2025-09-13 05:23:35'),
(747, 'MARSHALL MILANIZT STILL Z', '252610140', '$2y$12$KoktXIVBqj2iWbM5c5jJKOgJHM2cqk5eAi9iAkp5fbWdo5xUDbxGC', 'siswa', '2025-09-13 05:23:35', '2025-09-13 05:23:35'),
(748, 'MEISYA EUIS SADIAH', '252610141', '$2y$12$k7/5zYxA3EK2gpHC2.ypg.jRl34rMF4PLnwqyDh6mk3idU2Y6xYVa', 'siswa', '2025-09-13 05:23:35', '2025-09-13 05:23:35'),
(749, 'MOHAMMAD ZEYAD', '252610142', '$2y$12$kAC28mMGd2SxI5KtAKiSJ.n4fu2CvufbG2sg5k7UEMhczPVh/is8W', 'siswa', '2025-09-13 05:23:35', '2025-09-13 05:23:35'),
(750, 'MUHAMAD FARHAN', '252610143', '$2y$12$ov48XqC0Rq0Jx9uHmm5raeT1CYUHcQQMvS8O/6hdxD3gJ8ZJTDHjq', 'siswa', '2025-09-13 05:23:36', '2025-09-13 05:23:36'),
(751, 'MUHAMAD IRFAN MAULANA', '252610144', '$2y$12$hLFITRYv/ZS0lt8wL6Y/OO.LHrhjtrXl6LrRZwAlT.XucaFi1O7wS', 'siswa', '2025-09-13 05:23:36', '2025-09-13 05:23:36'),
(752, 'MUHAMAD JIHAD ILMA ATTAMIMI', '252610145', '$2y$12$foWeR5obPw5OPAAMADMmM.mn0dcIU/4.ert5bDUV0YyLDNMgWqXtW', 'siswa', '2025-09-13 05:23:36', '2025-09-13 05:23:36'),
(753, 'MUHAMAD RIZKI', '252610146', '$2y$12$S/sXQvre8gNLo/vBJD5X7eeVKI2mSSQka7HhrioWAUYcDIA7qMK52', 'siswa', '2025-09-13 05:23:36', '2025-09-13 05:23:36'),
(754, 'MUHAMMAD ZAELANI', '252610147', '$2y$12$W4y6SbtlbrNd1ZZ1yd3eJOxtKNBJCmFmzZ6BR.mkA88LUdrnFQu9C', 'siswa', '2025-09-13 05:23:37', '2025-09-13 05:23:37'),
(755, 'NURJATI', '252610148', '$2y$12$.WIZEq4edz8NT3.CIIAIAebiSHgqMFLD.8kEkvf4oCDkd.GRcUJQi', 'siswa', '2025-09-13 05:23:37', '2025-09-13 05:23:37'),
(756, 'RAMADAN', '252610149', '$2y$12$VnfAFfkmghFEJIYV5Tf46uGxxRHP4Gp4XG0rVzkz3DOx2m0nkxMvq', 'siswa', '2025-09-13 05:23:37', '2025-09-13 05:23:37'),
(757, 'RIFQI QHAIRUL HASAN', '252610150', '$2y$12$.gdKuTO/tfQdvpTY9Br3X.xAFow7WmavpyjflWwSHGV2mFsp8RDTe', 'siswa', '2025-09-13 05:23:38', '2025-09-13 05:23:38'),
(758, 'RIZKI NUR AL FAHRI', '252610151', '$2y$12$M4C3c60/Dh1aK.CA1.8mL.Trqeby87JMr18t.llu9NPtoEnvLs6Se', 'siswa', '2025-09-13 05:23:38', '2025-09-13 05:23:38'),
(759, 'SALSA NABILA', '252610152', '$2y$12$zJ7JGH6hbPsdArK38/5RWeMlv9/vQqUi.kWOPYkvszPWB9cbUppX.', 'siswa', '2025-09-13 05:23:38', '2025-09-13 05:23:38'),
(760, 'SITI HASANAH', '252610153', '$2y$12$pA/TcH0lUefvzFuGZ1YBpePvrLYdUlGNFas9P54dbGQD.H8Pw0bq6', 'siswa', '2025-09-13 05:23:38', '2025-09-13 05:23:38'),
(761, 'SUHENDRA', '252610154', '$2y$12$SmPtZ2DOghMwEUh1aWAxT.FqoqrKU3.rMZLe7tE2ISF3V5EwCfQjm', 'siswa', '2025-09-13 05:23:39', '2025-09-13 05:23:39'),
(762, 'SUTISNA PRATAMA', '252610155', '$2y$12$k98hjExqBsjPCMrsMAhYh.NVx67vRaGIyr1.1jupST1M27u0NE3IC', 'siswa', '2025-09-13 05:23:39', '2025-09-13 05:23:39'),
(763, 'TEDI MAULANA', '252610156', '$2y$12$KmSxSNXC/TTFwSh8jn3OOu08Nxo6hfs2PZ6DVvwn3FBtAJp4nUY8e', 'siswa', '2025-09-13 05:23:39', '2025-09-13 05:23:39'),
(764, 'WAHYU SUPRIATNA', '252610157', '$2y$12$7gs7iTDvfVJghzrFhz63xOsOZYVej.qu1Yfq2BxFzJSVfzYayl.du', 'siswa', '2025-09-13 05:23:39', '2025-09-13 05:23:39'),
(765, 'WALID FAJAR RAMADHAN', '252610158', '$2y$12$0ffh0zplMUFic73xp4IXl.o5W.446budQlQFwddR4ayXi8p5fw7Gq', 'siswa', '2025-09-13 05:23:40', '2025-09-13 05:23:40'),
(766, 'YUSUP', '252610159', '$2y$12$IQ.q60ZuwcJP0/o4BniZgOqKYpUUS82f0U0RoSltrCDQnvP.G7xyO', 'siswa', '2025-09-13 05:23:40', '2025-09-13 05:23:40'),
(767, 'ABDUL FIKRI', '252610160', '$2y$12$eWO6kSfO/vDZ68/STYl78OgE6.2c2u3quW/oZgP6rs/PNC6L6pD3.', 'siswa', '2025-09-13 05:23:40', '2025-09-13 05:23:40'),
(768, 'ADIL ALZULFA', '252610161', '$2y$12$gt86WlH3SXn5mE1Mnd.w1.Ykm/cdoc5a1auDOMjWyoPJhuTcA0rzO', 'siswa', '2025-09-13 05:23:41', '2025-09-13 05:23:41'),
(769, 'AGAM MADANI', '252610162', '$2y$12$Suh0kK2V5ecjbeU7GZjvwOkhUWlr2JV/mMlkeZWCUHahVi9ln52tG', 'siswa', '2025-09-13 05:23:41', '2025-09-13 05:23:41'),
(770, 'AGUS SAPUTRA', '252610163', '$2y$12$PIi5SmasL0ieBmyVasY2cOi/s/uCpKxZXBtq4D/FrfUh4uENMRfFW', 'siswa', '2025-09-13 05:23:41', '2025-09-13 05:23:41'),
(771, 'AHMAD AZMI KHOERUNNIZAR', '252610164', '$2y$12$J5wVL0y4Eo5k4JohAxenau31fMivWlIuOeM5w6kzUXQMzN3WQn7Aq', 'siswa', '2025-09-13 05:23:41', '2025-09-13 05:23:41'),
(772, 'AHMAD RIZKY KURNIAWAN', '252610165', '$2y$12$cG3takfG4yrsgQPqitZu8.Um46W.xh0Ulhc5K7/Q5BMLLr7Lyllq2', 'siswa', '2025-09-13 05:23:42', '2025-09-13 05:23:42'),
(773, 'AHMAD SYAFIQ', '252610166', '$2y$12$v7PClU..8morj51MEDffUup1E3PP814GeDqs9.ZE12Pc3Zo2d1VqO', 'siswa', '2025-09-13 05:23:42', '2025-09-13 05:23:42'),
(774, 'ANGGA MAULANA', '252610167', '$2y$12$x/iP1P37xKCGPol2bG7nYONQcTmD4wn8ewBqLRApr1w8ICQMcqoFu', 'siswa', '2025-09-13 05:23:42', '2025-09-13 05:23:42'),
(775, 'DENI KUSMANA', '252610168', '$2y$12$UX7al5SDKxmaiZtbibch3OEko5bYwotp0pUEgOXRpDYnszlVpMWpG', 'siswa', '2025-09-13 05:23:42', '2025-09-13 05:23:42'),
(776, 'DIANA RAHAYU', '252610169', '$2y$12$E8JmjeCzNnaok7pHFNpLnuAp4r/a2/01x2CiQqcRK7auXAQTfYENy', 'siswa', '2025-09-13 05:23:43', '2025-09-13 05:23:43'),
(777, 'EPITASARI', '252610170', '$2y$12$LoFz.7lGsSodIwcf7OKxfecrYKO27kPgQEeRxCYDAQQULlDFdnFAS', 'siswa', '2025-09-13 05:23:43', '2025-09-13 05:23:43'),
(778, 'FARHANNABIL', '252610171', '$2y$12$iJq7G1dQngE557w.TYAFye902CJvwWoy8CGXWDtHE2b4jV1tOvO6m', 'siswa', '2025-09-13 05:23:43', '2025-09-13 05:23:43'),
(779, 'HABIL NUR ALDIN', '252610172', '$2y$12$Kht459OIHw95aVV7pONBVuZ4Xha6tcH/xmKKEp1eoyBjAjGYoawb.', 'siswa', '2025-09-13 05:23:44', '2025-09-13 05:23:44'),
(780, 'KARDA PUTRA ADIANSYAH', '252610173', '$2y$12$mY7N5MVhXIqa9z/qRKbi2Oq/LEfleV/wuwOri71U2eaabXfc3bNAa', 'siswa', '2025-09-13 05:23:44', '2025-09-13 05:23:44'),
(781, 'MARYONO', '252610174', '$2y$12$BpBD.ZauxP4KFINet8qUfuZoK/tsMNSrI8MH1lAsgkrHy08tDc0AW', 'siswa', '2025-09-13 05:23:44', '2025-09-13 05:23:44'),
(782, 'MASITOH NURUL SYIFA', '252610175', '$2y$12$DRtZMRTgjNEQfeY1pCUzSuqqP.9tIj7O5TvVai5KxDt1T38S0RhxK', 'siswa', '2025-09-13 05:23:44', '2025-09-13 05:23:44'),
(783, 'MOHAMAD FAJAR ALFAZRY', '252610176', '$2y$12$32cv1G0rcp4xqkIYcFgyyudedsSyHwvg6EDn9L57zvN6o94o0G2oO', 'siswa', '2025-09-13 05:23:45', '2025-09-13 05:23:45'),
(784, 'MUHAMAD KHOLBY SAHIH', '252610177', '$2y$12$Yre6o2yAUGtVwOyvbb/icOvytVpy8tva7yNFflkq8VdAKfkTRrw3e', 'siswa', '2025-09-13 05:23:45', '2025-09-13 05:23:45'),
(785, 'MUHAMAD RIDWAN SAPII', '252610178', '$2y$12$g5/j0pvdvCcWwoulp.kRcO2GigCpRDAyBjFT6n1rrqCUdN4O1gHFy', 'siswa', '2025-09-13 05:23:45', '2025-09-13 05:23:45'),
(786, 'MUHAMMAD ALDIANSYAH', '252610179', '$2y$12$Ba/VeETISNcW/XF7QwkX8eU3CE68CZH8vAJtZyuSHGOBtFmDDitC2', 'siswa', '2025-09-13 05:23:45', '2025-09-13 05:23:45'),
(787, 'MUHAMMAD RIDWAN AL KHADAFI', '252610180', '$2y$12$fVGyoyiE708B8nY77ChBIOwD3WEJvQEhSkT/PwbxTeDOK1ufPpWeO', 'siswa', '2025-09-13 05:23:46', '2025-09-13 05:23:46'),
(788, 'NOVAL MALIKI', '252610181', '$2y$12$HZzZB7kuZXxoJ5VfNhpc6elDocO0p.Ve7nf7ljGdUUcyDVG9h1sle', 'siswa', '2025-09-13 05:23:46', '2025-09-13 05:23:46'),
(789, 'NURWULAN', '252610182', '$2y$12$PtF2Bjn1f7rcLlUTqcS2zed434NE/svD8KlqgSs7q0BPjcDDkNZNC', 'siswa', '2025-09-13 05:23:46', '2025-09-13 05:23:46'),
(790, 'OBAY SOBARNA', '252610183', '$2y$12$EKl0DXM1y6VU6oaULmBA7eZjqRWHxKuQ42i31xObT8u5NTE0tUdUe', 'siswa', '2025-09-13 05:23:46', '2025-09-13 05:23:46'),
(791, 'PATONAH', '252610184', '$2y$12$qAmsRDNw8/8IyG7oL7fUludtHkd7r2.MelQLZA4v11lqboX07VGM6', 'siswa', '2025-09-13 05:23:47', '2025-09-13 05:23:47'),
(792, 'RAGIL GOJALI', '252610185', '$2y$12$POoqsRkXDP2JlxKKJYxPyOKl7tHFiGe/LkDqonmyl.DLBo7y0xAY6', 'siswa', '2025-09-13 05:23:47', '2025-09-13 05:23:47'),
(793, 'RAJIF JULIAWAN', '252610186', '$2y$12$fD/R/Ajo3F2gqynzOcXO0e8/hdrPF0tQwZiBoI2c2X8vq2CQOOeSq', 'siswa', '2025-09-13 05:23:47', '2025-09-13 05:23:47'),
(794, 'RIO SUSANTO', '252610187', '$2y$12$oame3kYqLZr3fJKwy1S8juaarnoHKJcmzbJvy37Dr5XD1QgxsfuIO', 'siswa', '2025-09-13 05:23:48', '2025-09-13 05:23:48'),
(795, 'RIZKY RAMDANI', '252610188', '$2y$12$M5hdryF2X5Q6aHj/yJYgxuddr9xt7YsivliHWGrqIgRY3eTB2XVDO', 'siswa', '2025-09-13 05:23:48', '2025-09-13 05:23:48'),
(796, 'RUSLAN', '252610189', '$2y$12$KwcimLiS50rzRWiktAHY0uUYOKKWANtWNwQ3FvCpFKhL4WfskjO6m', 'siswa', '2025-09-13 05:23:48', '2025-09-13 05:23:48'),
(797, 'RYAN HIDAYAT', '252610190', '$2y$12$.Grj8ED21UtqaMWHlAgBdO03P7AZu7c5B5TAbllAN4bvvB7Z3kD16', 'siswa', '2025-09-13 05:23:48', '2025-09-13 05:23:48'),
(798, 'TAUPIK UROHMAN', '252610191', '$2y$12$Yr/6GXbB8ENX8FvjnGBqmuOWcLwz0WAhL2jL801BDyC9.S7R.iyO6', 'siswa', '2025-09-13 05:23:49', '2025-09-13 05:23:49'),
(799, 'WILLIYANA ADISTIA', '252610192', '$2y$12$xL0v2jf.NcGCERV2lRS4nOMQZIqzFJY0gNMXWPpODmYCswt.6BdV.', 'siswa', '2025-09-13 05:23:49', '2025-09-13 05:23:49'),
(800, 'YUSUF RAMADAN', '252610193', '$2y$12$rG6k4.A8HVrn1vJ8FgmnSeSwEi5zg0sPT3Hq/9fx3lhkioElIc2xy', 'siswa', '2025-09-13 05:23:49', '2025-09-13 05:23:49'),
(801, 'AHMAD GUNAWAN', '252610194', '$2y$12$1xzfwPgwyajGFGGk2.1KoO8vYz/D47jS12sDSMnYvOAw.KNMzhkNC', 'siswa', '2025-09-13 05:23:49', '2025-09-13 05:23:49'),
(802, 'AKBAR ALVIAN', '252610195', '$2y$12$LPbFgBxEbE.AUhfnJl08AeF2qd1P2wGdFBNB/uDW5nXvai8VFytVC', 'siswa', '2025-09-13 05:23:50', '2025-09-13 05:23:50'),
(803, 'AL AZIS MUBAROK', '252610196', '$2y$12$jX2QOJVgSI2YccPXN9iHLu2sfdssCFAtN7yb2OqUGCuQ1pp2ykBSe', 'siswa', '2025-09-13 05:23:50', '2025-09-13 05:23:50'),
(804, 'ALIF QIZWINI', '252610197', '$2y$12$P2njm8vvVPYnZvBo0RTsgOOeVnQbz60hqo7vW7rneRhtLfMYIKqS.', 'siswa', '2025-09-13 05:23:50', '2025-09-13 05:23:50'),
(805, 'CARSADI', '252610198', '$2y$12$.HMCQylGMt4MekLacz/9Y.5C7F.rT3Jjy/sLZH0s5hk2EQ3EEBpXK', 'siswa', '2025-09-13 05:23:50', '2025-09-13 05:23:50'),
(806, 'CHIKA RAHMAWATI', '252610199', '$2y$12$Sl5rXFPMnLwc6J/eX3uUn.pMe/ht8oWqjWa/dsbIVVmTeetVwB2p.', 'siswa', '2025-09-13 05:23:51', '2025-09-13 05:23:51'),
(807, 'ABDUL AZIS, A.Md', 'azis', '$2y$12$aeWoH.oPzP3.JTzWnGhG6O1i7pPiO3tQLiCCYJwcDlt1Ugx4c0rLm', 'siswa', '2025-09-13 05:24:00', '2025-09-13 05:24:00'),
(808, 'AGUNG ISLAHUDIN, S.Pd', 'agung', '$2y$12$H0cNnyKvXPcJTNbLhi7FsuWWMNMUy0M.XeyISYliliVJOYsX9Te.e', 'siswa', '2025-09-13 05:24:01', '2025-09-13 05:24:01'),
(809, 'AHMAD MUHIBBAN, S.Ag', 'iben', '$2y$12$NXVGJ20QF..UIvSaWkBTQumFOhAGnyWGJag5g6jfPUiaXLlBA3V8e', 'siswa', '2025-09-13 05:24:01', '2025-09-13 05:24:01'),
(810, 'ASIM AZHARI, A.Md', 'asim', '$2y$12$jAcnCdeE8QmWUTx/fnGe4.s.dgQdRPB.UxDykOxB5hQ7ZncLXons6', 'siswa', '2025-09-13 05:24:01', '2025-09-13 05:24:01'),
(811, 'AYU WULANDARI, S.Tr. Kes', 'ayu', '$2y$12$6tCHEPjRUAHYrYPiitrI0OAvNO/Gftl3uXU5vX/FKkD2d/uY.y9H6', 'siswa', '2025-09-13 05:24:01', '2025-09-13 05:24:01'),
(812, 'BINTANG KUSUMA WARDHANA, S.Si., M.Or', 'bintang', '$2y$12$OTNjFqSkQAJmjJlizeETuOmCa8onWjxzYufa5DNUIXMOvS6HNF7d.', 'siswa', '2025-09-13 05:24:02', '2025-09-13 05:24:02'),
(813, 'BUDI AZANI, S.Pd', 'budi', '$2y$12$a8Q6wJ.ysZ.K9jhKNtgrAOPs.aTO3/LnhqTCDCe9Hoh5Gx1Nu1Hj.', 'siswa', '2025-09-13 05:24:02', '2025-09-13 05:24:02'),
(814, 'DEWI DAMAYANTI, S.Pd', 'dewi', '$2y$12$R53FNYtN4FHDA..SfBz7kOihc.HdqNdAXAjmI5MMu2fuWPw/G35/a', 'siswa', '2025-09-13 05:24:02', '2025-09-13 05:24:02'),
(815, 'DINI DIMYATI, S.Pd', 'dini', '$2y$12$XQos60d4EGerdPkRVFyta.YEaJFaiucVjvi3qNULgGRUrSd/9n3Ii', 'siswa', '2025-09-13 05:24:02', '2025-09-13 05:24:02'),
(816, 'DIYAH RATNASARI INDAH, S.Pd', 'diyah', '$2y$12$7FHDB/ip1krGmE1ADwdT/OVvV4StawlL6v/wyntVoZGBA3zZ3g20K', 'siswa', '2025-09-13 05:24:03', '2025-09-13 05:24:03'),
(817, 'Drs. DANA SUTISNA', 'dana', '$2y$12$ti.oW9UeAezcWwTLwDE5Qe7jnXkuTUMj3rPbXgwK9TZPaFTSAj9ta', 'siswa', '2025-09-13 05:24:03', '2025-09-13 05:24:03'),
(818, 'EKA SUPRIADI, S.Kom', 'eka', '$2y$12$AiKptb8P9EyMF.8Jz/aYdeKD3188SqPK5cfaZVS6UE66Ns8gpnHgW', 'siswa', '2025-09-13 05:24:03', '2025-09-13 05:24:03'),
(819, 'EUIS NANI, S.E', 'euis', '$2y$12$IE8oTzEijz04oE5OY5g19ObzF.Ue.yVzeCgPUuGcQxwY2gV.6E5cG', 'siswa', '2025-09-13 05:24:04', '2025-09-13 05:24:04'),
(820, 'FADIA ULFA ANGELINA, A.Md', 'fadia', '$2y$12$Nfg0YQNUbSW8.8AEto0hK.J1cfrXBmZT74V/qljVox089iFxicRp2', 'siswa', '2025-09-13 05:24:04', '2025-09-13 05:24:04'),
(821, 'ICIH KURNIANENGSIH, S.Pd', 'icih', '$2y$12$3Um4QU6nhshgJLB5wKJY.eNdF0YLT5y2vjqMOwy6ADwWmb/0PIDHG', 'siswa', '2025-09-13 05:24:04', '2025-09-13 05:24:04'),
(822, 'IIM FAUZIAH, S.Ag', 'iim', '$2y$12$V2xyq7wjXYsvb3ah1f/De.Kon0zzfjlKCQ7kyHKsAKvo.M0tAROVK', 'siswa', '2025-09-13 05:24:04', '2025-09-13 05:24:04'),
(823, 'JONI ABDUL KHALID', 'joni', '$2y$12$ZhXa8PWaQ4YBenNfTRVz2OZl22VpinS39MU4CPq9fEJKJOULSrknm', 'siswa', '2025-09-13 05:24:05', '2025-09-13 05:24:05'),
(824, 'KARYATI, S.Pd', 'karyati', '$2y$12$A4rETAK4XXscDEXH3oToSux4/wCX9wukoMW/qF2nhQudTdSmu910S', 'siswa', '2025-09-13 05:24:05', '2025-09-13 05:24:05'),
(825, 'MOERDIONO. S.H, Gr', 'moerdiono', '$2y$12$6w7I1vyD6HCVt5fSAF6/Rea1R0JEIJc3JtrJ6Ss.oUpfCBqJEBP76', 'siswa', '2025-09-13 05:24:05', '2025-09-13 05:24:05'),
(826, 'MOHAMMAD ALWI, S.Pd', 'alwi', '$2y$12$vnI.gz/Pg5p88cCLlkWZR.xW65ZPlAj2TBRQZ/xSUAB/N3fx3feeW', 'siswa', '2025-09-13 05:24:05', '2025-09-13 05:24:05'),
(827, 'MUMUN MUNAWAROH, S.Kom', 'mumun', '$2y$12$ZAt.u25hgZQ7D3IjVBF3O.WtYmsWqJF/JG5z7HgsVcl54Y9ko4f66', 'siswa', '2025-09-13 05:24:06', '2025-09-13 05:24:06'),
(828, 'NAUPAL IRSYAD, S.Pd', 'naupal', '$2y$12$Onam9sTXNlgm8KDoV7Z7su/Ip2w3Hgx6RVujtxt.Rv4sg4B3jEAM2', 'siswa', '2025-09-13 05:24:06', '2025-09-13 05:24:06'),
(829, 'RENALDI FERDIANSAH, S.Pd', 'renaldi', '$2y$12$wdSnd7vq2hBI095lw/LhIOu4E33bX7LrX66egdq4ZamtmIudYcldK', 'siswa', '2025-09-13 05:24:06', '2025-09-13 05:24:06'),
(830, 'RIFKI NUR HIDAYAT, S.T', 'rifki', '$2y$12$uaf1NoF/AtNp2DanCY.O.OKov6B8lB.eJK3ZAlwNXRb/iZFGWYwim', 'siswa', '2025-09-13 05:24:06', '2025-09-13 05:24:06'),
(831, 'RITA KHOERUNNISA, S.S', 'rita', '$2y$12$g9Ui82PbeBgjbrLXMIPd4.0QNflBzBMNQ3Dl.cYBC3XaRxqeIVSKW', 'siswa', '2025-09-13 05:24:07', '2025-09-13 05:24:07'),
(832, 'RUSDIANTO, S.T', 'rusdianto', '$2y$12$DW0oKZoheKH0Njibf5Xsl.tQE3FUkoKKadGIUWyXKc6Zi9teSNYkW', 'siswa', '2025-09-13 05:24:07', '2025-09-13 05:24:07'),
(833, 'SAEPUDIN LUBIS, S.Pd, MM', 'lubis', '$2y$12$VaD2S8N9y/jAVLN8sjE6pO6j.iIeB9YzRcYMtv2NlIs1qt2kkBO5a', 'siswa', '2025-09-13 05:24:07', '2025-09-13 05:24:07'),
(834, 'SITI INA ROSTIANA, S.Pd', 'siti', '$2y$12$yZc5yHTVv1MJkf./ghWOC.bxmj9tRt2S9NINmqdm6oJiY/vKFsVR2', 'siswa', '2025-09-13 05:24:08', '2025-09-13 05:24:08'),
(835, 'SOPIAN HADI, A.Md', 'sopian', '$2y$12$Ru0nmPmboZfyzI0tm1qGJ.B6O0gfjLw3YH3zPT4e1V4mvEiBlOg2S', 'siswa', '2025-09-13 05:24:08', '2025-09-13 05:24:08'),
(836, 'SUKATMO, S.Pd', 'sukatmo', '$2y$12$vIPQCAssl/uZQ8MxeYqyAuoX4RNxe.Kc66jVKE6FyE2xhOCN8Ep/O', 'siswa', '2025-09-13 05:24:08', '2025-09-13 05:24:08'),
(837, 'TIO IRVAN MULYADI, S.Pd', 'tio', '$2y$12$9EqX3Gw3sdz9ugVlUp4XJ.dkQY5IfG.uDiywT.DXkfbTkWsz7wzXG', 'siswa', '2025-09-13 05:24:08', '2025-09-13 05:24:08'),
(838, 'TRI AYUNI BILA KARTIKA, S.Pd', 'tri', '$2y$12$EQYEOTlHLvEx08nE7amMaO0w8gRS76Xb7T5hffnC/R7omVqryuNUW', 'siswa', '2025-09-13 05:24:09', '2025-09-13 05:24:09'),
(839, 'TRI ZULFAN PURNAMA PUTRA, S.Pd', 'zulfan', '$2y$12$EfJFKVtC3Hrasjh8zvLs0.yy.DHObHu3/ttPn/c6Fyz4NSwJerCvi', 'siswa', '2025-09-13 05:24:09', '2025-09-13 05:24:09'),
(840, 'VIONA FARA NABILA, S.Pd', 'viona', '$2y$12$Iw5VkWrXKMamo.9bqYzMt.ICbzFEbIgooWqLlmFsWrycCX2qBZQc2', 'siswa', '2025-09-13 05:24:09', '2025-09-13 05:24:09'),
(841, 'WAHYU RUSDIANSYAH, S.Kom', 'wahyu', '$2y$12$WzoO/65PPJsLFVuiQeSVgOa7DiZYaKz1idupRH2I2dncWpihWeotS', 'siswa', '2025-09-13 05:24:09', '2025-09-13 05:24:09'),
(842, 'YATI NURHAYATI, S.Pd', 'yati', '$2y$12$WbM7bF8bx/x1ldDYKdPAnO06HUxMWJjGEwJ5rFKtB8jKctXlm0MYi', 'siswa', '2025-09-13 05:24:10', '2025-09-13 05:24:10'),
(843, 'ABDUL AZIS, A.Md', 'aazis', '$2y$12$k0qaoCt/mfEKKMbh2aZLHexCbDXOdqXV5WtKe8BA5cxtPLiULYk9m', 'wali', '2025-09-13 05:27:57', '2025-09-13 05:27:57'),
(844, 'AGUNG ISLAHUDIN, S.Pd', 'aagung', '$2y$12$QMU.bRa.7qYT.pIw7GQCHOAPZ2AELgvI920FBUzi/MDKYch6zb/LO', 'wali', '2025-09-13 05:28:12', '2025-09-13 05:28:12'),
(845, 'AHMAD MUHIBBAN, S.Ag', 'aiben', '$2y$12$BAEZCWQHb0GPA9Ht7W3gKebqGXJmovCLo3YxHxjiZsC6KvuAwHUFu', 'wali', '2025-09-13 05:28:29', '2025-09-13 05:28:29'),
(846, 'AYU WULANDARI, S.Tr. Kes', 'aayu', '$2y$12$6DgDAHgIVwwKtroNv3Pz9eXjhCIioSoFy3vMS2TnHGkjvUyEwX2sO', 'wali', '2025-09-13 05:29:17', '2025-09-13 05:29:17'),
(847, 'BUDI AZANI, S.Pd', 'abudi', '$2y$12$Ftd2JUN4KMoN8A6inaZahONAs.Ms7V.8pevtbej0ld.LtELWjdxga', 'wali', '2025-09-13 05:29:39', '2025-09-13 05:29:39'),
(848, 'DEWI DAMAYANTI, S.Pd', 'adewi', '$2y$12$UJvPfA/oIJGDOI7PVVgnK.oxtGSEIkrxxAyg2hBYJdIb76XjuwSXm', 'wali', '2025-09-13 05:30:02', '2025-09-13 05:30:23'),
(849, 'DINI DIMYATI, S.Pd', 'adini', '$2y$12$XIwKQB/sSttvk5mMdmaU1.rkFray9JM0.Rnqs3x.5lI5uFDuctA4q', 'wali', '2025-09-13 05:30:43', '2025-09-13 05:30:43'),
(850, 'EUIS NANI, S.E', 'aeuis', '$2y$12$in8hG3IPl7wI3BBt11TzWuV.yH6dYhoDNC.QDSYUJXEnvo46pBWC6', 'wali', '2025-09-13 05:31:32', '2025-09-13 05:31:32'),
(851, 'FADIA ULFA ANGELINA, A.Md', 'afadia', '$2y$12$CTFKC5.zIwi6qnBC3a2MbOv3Pq8KIYF7ARhKySl9mX6YIfYVoGp.q', 'wali', '2025-09-13 05:31:59', '2025-09-13 05:31:59'),
(852, 'IIM FAUZIAH, S.Ag', 'aiim', '$2y$12$2kx/JpmBqtazAzk5tFrEXO5e5FsJtdVD.DGFll0AsKHY2b2rR.zOy', 'wali', '2025-09-13 05:32:35', '2025-09-13 05:32:35'),
(853, 'MOERDIONO. S.H, Gr', 'amoer', '$2y$12$h8cWxJzE6wZnt8uSSMjKX.KuPZU5gHDQAUPwH2lDD/4KT1B4JsY/S', 'wali', '2025-09-13 05:33:05', '2025-09-13 05:33:05'),
(854, 'MOHAMMAD ALWI, S.Pd', 'aalwi', '$2y$12$4fFoJJf3r.1u7KNPOIyGLOVsUZL84.GJsb7GyNSOlU7xj/PNmGum.', 'wali', '2025-09-13 05:33:26', '2025-09-13 05:33:26'),
(855, 'MUMUN MUNAWAROH, S.Kom', 'amumun', '$2y$12$sVd8zdCmkYfC60Lr7dvKZOvKzXK6Ea9XP9.Iyeb5drKJPdSjP5tEu', 'wali', '2025-09-13 05:33:52', '2025-09-13 05:33:52'),
(856, 'NAUPAL IRSYAD, S.Pd', 'anaupal', '$2y$12$neZrdIBuvW18mOgYv7eBRO2wVQBjqSnOPjmE6g6BuckSKC9KS8Y1m', 'wali', '2025-09-13 05:34:11', '2025-09-13 05:34:11'),
(857, 'RENALDI FERDIANSAH, S.Pd', 'arenaldi', '$2y$12$yeURimXPWyCvJk.tJ02kYOyNwBvHEsUDWV9aICLyeDKQa.YcCv3g2', 'wali', '2025-09-13 05:34:30', '2025-09-13 05:34:30'),
(858, 'RIFKI NUR HIDAYAT, S.T', 'arifki', '$2y$12$aD.uDqdxZ4djWZaPHh1n1eOaGtrYQ34JtqFqwyNzRzdiMwYlMXDni', 'wali', '2025-09-13 05:34:44', '2025-09-13 05:34:44'),
(859, 'RITA KHOERUNNISA, S.S', 'arita', '$2y$12$N3gxhP/tQ/wiqubpL.R1s.LUKLaIrvrao7l4RwAW76cpFzALIDms2', 'wali', '2025-09-13 05:35:27', '2025-09-13 05:35:27'),
(860, 'RUSDIANTO, S.T', 'arusdi', '$2y$12$jLtY9SNydSupQ3yU4MksI.NZsP8KxQrTjlRw1nPVJHWmAm5gAvxeW', 'wali', '2025-09-13 05:35:41', '2025-09-13 05:35:41'),
(861, 'SITI INA ROSTIANA, S.Pd', 'asiti', '$2y$12$vu1d07YrOf6YbGnFv4aZuOynC8Urq6d25epjIMGiur2Z8wQEBflqK', 'wali', '2025-09-13 05:36:16', '2025-09-13 05:36:16'),
(862, 'Nida', 'anida', '$2y$12$VUhXmTJzwmS8bbe4GFtX7OKv6RJy8OmE6ke0.pMJvfedz3QtoGgXm', 'wali', '2025-09-13 05:36:34', '2025-09-13 05:36:34'),
(863, 'SUKATMO, S.Pd', 'asukatmo', '$2y$12$y.k1SIS8vO8FoUl10UT96evz9yr/N89/Uxy1Fg6fB2K9yUETBkDPq', 'wali', '2025-09-13 05:37:06', '2025-09-13 05:37:06'),
(864, 'TRI AYUNI BILA KARTIKA, S.Pd', 'atri', '$2y$12$5PlJcmCZqHNWndZPhaZrduV1yycE7HS5imP/923R4UyeO8XJSWrue', 'wali', '2025-09-13 05:37:20', '2025-09-13 05:37:20'),
(865, 'TRI ZULFAN PURNAMA PUTRA, S.Pd', 'aatri', '$2y$12$3iGQHNIaVT2L9fZXLwtaIumCUeTvcUWjt5cNip1jxmIm58R5eVGDa', 'wali', '2025-09-13 05:37:36', '2025-09-13 05:37:36'),
(866, 'VIONA FARA NABILA, S.Pd', 'aviona', '$2y$12$fmqUwENT8h4H9X2OBT7jrOLAtdXsebrU7imQwDVQ2KOmYgZRyDoSO', 'wali', '2025-09-13 05:38:24', '2025-09-13 05:38:24'),
(867, 'WAHYU RUSDIANSYAH, S.Kom', 'awahyu', '$2y$12$gvQLBCF0ue7YrQ9c/PHUp.ch38H8a5vHQGL1TcFdmntPUvoDNIWNu', 'wali', '2025-09-13 05:38:36', '2025-09-13 05:38:36'),
(868, 'YATI NURHAYATI, S.Pd', 'ayati', '$2y$12$/yJFo.V1/YqvZFmUGW/PzOxrF7A6EIIo/hijLrnpxdsc91X2qLIji', 'wali', '2025-09-13 05:38:48', '2025-09-13 05:38:48');

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
('hPKqoZ1wOEcLFvJ6nvknTf821t5GQHGOYOtmu9FA', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiSXFjOHlvUjc4MlFQQWZEUkt6enhpM2YwRm9Rd1ZER1lhVjhVWTZqZiI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMwOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvc2V0dGluZ3MiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1757742148);

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
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'normal'
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

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'site_title', 'Bank_Sampah', '2025-09-13 05:42:27', '2025-09-13 05:42:27'),
(2, 'persentase_pengelola', '0', '2025-09-13 05:42:27', '2025-09-13 05:42:27'),
(3, 'persentase_wali_kelas', '10', '2025-09-13 05:42:27', '2025-09-13 05:42:27'),
(4, 'persentase_sekolah', '3', '2025-09-13 05:42:27', '2025-09-13 05:42:27');

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
(1, 2, 25, '232410200', 0.00, 0, '2025-09-13 05:18:43', '2025-09-13 05:18:43'),
(2, 3, 25, '232410201', 0.00, 0, '2025-09-13 05:18:44', '2025-09-13 05:18:44'),
(3, 4, 25, '232410202', 0.00, 0, '2025-09-13 05:18:44', '2025-09-13 05:18:44'),
(4, 5, 25, '232410203', 0.00, 0, '2025-09-13 05:18:44', '2025-09-13 05:18:44'),
(5, 6, 25, '232410204', 0.00, 0, '2025-09-13 05:18:44', '2025-09-13 05:18:44'),
(6, 7, 25, '232410205', 0.00, 0, '2025-09-13 05:18:45', '2025-09-13 05:18:45'),
(7, 8, 25, '232410206', 0.00, 0, '2025-09-13 05:18:45', '2025-09-13 05:18:45'),
(8, 9, 25, '232410207', 0.00, 0, '2025-09-13 05:18:45', '2025-09-13 05:18:45'),
(9, 10, 25, '232410208', 0.00, 0, '2025-09-13 05:18:45', '2025-09-13 05:18:45'),
(10, 11, 25, '232410209', 0.00, 0, '2025-09-13 05:18:46', '2025-09-13 05:18:46'),
(11, 12, 25, '232410210', 0.00, 0, '2025-09-13 05:18:46', '2025-09-13 05:18:46'),
(12, 13, 25, '232410211', 0.00, 0, '2025-09-13 05:18:46', '2025-09-13 05:18:46'),
(13, 14, 25, '232410212', 0.00, 0, '2025-09-13 05:18:47', '2025-09-13 05:18:47'),
(14, 15, 25, '232410213', 0.00, 0, '2025-09-13 05:18:47', '2025-09-13 05:18:47'),
(15, 16, 25, '232410214', 0.00, 0, '2025-09-13 05:18:47', '2025-09-13 05:18:47'),
(16, 17, 25, '232410215', 0.00, 0, '2025-09-13 05:18:47', '2025-09-13 05:18:47'),
(17, 18, 25, '232410216', 0.00, 0, '2025-09-13 05:18:48', '2025-09-13 05:18:48'),
(18, 19, 25, '232410217', 0.00, 0, '2025-09-13 05:18:48', '2025-09-13 05:18:48'),
(19, 20, 25, '232410218', 0.00, 0, '2025-09-13 05:18:48', '2025-09-13 05:18:48'),
(20, 21, 25, '232410219', 0.00, 0, '2025-09-13 05:18:48', '2025-09-13 05:18:48'),
(21, 22, 26, '232410220', 0.00, 0, '2025-09-13 05:18:49', '2025-09-13 05:18:49'),
(22, 23, 26, '232410221', 0.00, 0, '2025-09-13 05:18:49', '2025-09-13 05:18:49'),
(23, 24, 26, '232410222', 0.00, 0, '2025-09-13 05:18:49', '2025-09-13 05:18:49'),
(24, 25, 26, '232410223', 0.00, 0, '2025-09-13 05:18:49', '2025-09-13 05:18:49'),
(25, 26, 26, '232410224', 0.00, 0, '2025-09-13 05:18:50', '2025-09-13 05:18:50'),
(26, 27, 26, '232410225', 0.00, 0, '2025-09-13 05:18:50', '2025-09-13 05:18:50'),
(27, 28, 26, '232410226', 0.00, 0, '2025-09-13 05:18:50', '2025-09-13 05:18:50'),
(28, 29, 26, '232410227', 0.00, 0, '2025-09-13 05:18:50', '2025-09-13 05:18:50'),
(29, 30, 26, '232410228', 0.00, 0, '2025-09-13 05:18:51', '2025-09-13 05:18:51'),
(30, 31, 26, '232410229', 0.00, 0, '2025-09-13 05:18:51', '2025-09-13 05:18:51'),
(31, 32, 26, '232410230', 0.00, 0, '2025-09-13 05:18:51', '2025-09-13 05:18:51'),
(32, 33, 26, '232410231', 0.00, 0, '2025-09-13 05:18:52', '2025-09-13 05:18:52'),
(33, 34, 26, '232410232', 0.00, 0, '2025-09-13 05:18:52', '2025-09-13 05:18:52'),
(34, 35, 26, '232410233', 0.00, 0, '2025-09-13 05:18:52', '2025-09-13 05:18:52'),
(35, 36, 26, '232410234', 0.00, 0, '2025-09-13 05:18:52', '2025-09-13 05:18:52'),
(36, 37, 26, '232410235', 0.00, 0, '2025-09-13 05:18:53', '2025-09-13 05:18:53'),
(37, 38, 26, '232410236', 0.00, 0, '2025-09-13 05:18:53', '2025-09-13 05:18:53'),
(38, 39, 26, '232410237', 0.00, 0, '2025-09-13 05:18:53', '2025-09-13 05:18:53'),
(39, 40, 26, '232410238', 0.00, 0, '2025-09-13 05:18:53', '2025-09-13 05:18:53'),
(40, 41, 26, '232410239', 0.00, 0, '2025-09-13 05:18:54', '2025-09-13 05:18:54'),
(41, 42, 26, '232410240', 0.00, 0, '2025-09-13 05:18:54', '2025-09-13 05:18:54'),
(42, 43, 26, '232410241', 0.00, 0, '2025-09-13 05:18:54', '2025-09-13 05:18:54'),
(43, 44, 26, '232410242', 0.00, 0, '2025-09-13 05:18:54', '2025-09-13 05:18:54'),
(44, 45, 26, '232410243', 0.00, 0, '2025-09-13 05:18:55', '2025-09-13 05:18:55'),
(45, 46, 26, '232410244', 0.00, 0, '2025-09-13 05:18:55', '2025-09-13 05:18:55'),
(46, 47, 26, '232410245', 0.00, 0, '2025-09-13 05:18:55', '2025-09-13 05:18:55'),
(47, 48, 26, '232410246', 0.00, 0, '2025-09-13 05:18:56', '2025-09-13 05:18:56'),
(48, 49, 26, '232410247', 0.00, 0, '2025-09-13 05:18:56', '2025-09-13 05:18:56'),
(49, 50, 26, '232410248', 0.00, 0, '2025-09-13 05:18:57', '2025-09-13 05:18:57'),
(50, 51, 26, '232410249', 0.00, 0, '2025-09-13 05:18:57', '2025-09-13 05:18:57'),
(51, 52, 26, '232410250', 0.00, 0, '2025-09-13 05:18:57', '2025-09-13 05:18:57'),
(52, 53, 26, '232410251', 0.00, 0, '2025-09-13 05:18:57', '2025-09-13 05:18:57'),
(53, 54, 26, '232410252', 0.00, 0, '2025-09-13 05:18:58', '2025-09-13 05:18:58'),
(54, 55, 27, '232410253', 0.00, 0, '2025-09-13 05:18:58', '2025-09-13 05:18:58'),
(55, 56, 27, '232410254', 0.00, 0, '2025-09-13 05:18:58', '2025-09-13 05:18:58'),
(56, 57, 27, '232410255', 0.00, 0, '2025-09-13 05:18:59', '2025-09-13 05:18:59'),
(57, 58, 27, '232410256', 0.00, 0, '2025-09-13 05:18:59', '2025-09-13 05:18:59'),
(58, 59, 27, '232410257', 0.00, 0, '2025-09-13 05:18:59', '2025-09-13 05:18:59'),
(59, 60, 27, '232410258', 0.00, 0, '2025-09-13 05:18:59', '2025-09-13 05:18:59'),
(60, 61, 27, '232410259', 0.00, 0, '2025-09-13 05:19:00', '2025-09-13 05:19:00'),
(61, 62, 27, '232410260', 0.00, 0, '2025-09-13 05:19:00', '2025-09-13 05:19:00'),
(62, 63, 27, '232410261', 0.00, 0, '2025-09-13 05:19:00', '2025-09-13 05:19:00'),
(63, 64, 27, '232410262', 0.00, 0, '2025-09-13 05:19:01', '2025-09-13 05:19:01'),
(64, 65, 27, '232410263', 0.00, 0, '2025-09-13 05:19:01', '2025-09-13 05:19:01'),
(65, 66, 27, '232410264', 0.00, 0, '2025-09-13 05:19:01', '2025-09-13 05:19:01'),
(66, 67, 27, '232410265', 0.00, 0, '2025-09-13 05:19:01', '2025-09-13 05:19:01'),
(67, 68, 27, '232410266', 0.00, 0, '2025-09-13 05:19:02', '2025-09-13 05:19:02'),
(68, 69, 27, '232410267', 0.00, 0, '2025-09-13 05:19:02', '2025-09-13 05:19:02'),
(69, 70, 27, '232410268', 0.00, 0, '2025-09-13 05:19:02', '2025-09-13 05:19:02'),
(70, 71, 27, '232410269', 0.00, 0, '2025-09-13 05:19:02', '2025-09-13 05:19:02'),
(71, 72, 27, '232410270', 0.00, 0, '2025-09-13 05:19:03', '2025-09-13 05:19:03'),
(72, 73, 27, '232410271', 0.00, 0, '2025-09-13 05:19:03', '2025-09-13 05:19:03'),
(73, 74, 27, '232410272', 0.00, 0, '2025-09-13 05:19:03', '2025-09-13 05:19:03'),
(74, 75, 27, '232410273', 0.00, 0, '2025-09-13 05:19:03', '2025-09-13 05:19:03'),
(75, 76, 27, '232410274', 0.00, 0, '2025-09-13 05:19:04', '2025-09-13 05:19:04'),
(76, 77, 27, '232410275', 0.00, 0, '2025-09-13 05:19:04', '2025-09-13 05:19:04'),
(77, 78, 27, '232410276', 0.00, 0, '2025-09-13 05:19:04', '2025-09-13 05:19:04'),
(78, 79, 27, '232410277', 0.00, 0, '2025-09-13 05:19:04', '2025-09-13 05:19:04'),
(79, 80, 27, '232410278', 0.00, 0, '2025-09-13 05:19:05', '2025-09-13 05:19:05'),
(80, 81, 19, '232410001', 0.00, 0, '2025-09-13 05:19:49', '2025-09-13 05:19:49'),
(81, 82, 19, '232410002', 0.00, 0, '2025-09-13 05:19:49', '2025-09-13 05:19:49'),
(82, 83, 19, '232410003', 0.00, 0, '2025-09-13 05:19:49', '2025-09-13 05:19:49'),
(83, 84, 19, '232410004', 0.00, 0, '2025-09-13 05:19:49', '2025-09-13 05:19:49'),
(84, 85, 19, '232410005', 0.00, 0, '2025-09-13 05:19:50', '2025-09-13 05:19:50'),
(85, 86, 19, '232410006', 0.00, 0, '2025-09-13 05:19:50', '2025-09-13 05:19:50'),
(86, 87, 19, '232410007', 0.00, 0, '2025-09-13 05:19:50', '2025-09-13 05:19:50'),
(87, 88, 19, '232410008', 0.00, 0, '2025-09-13 05:19:50', '2025-09-13 05:19:50'),
(88, 89, 19, '232410009', 0.00, 0, '2025-09-13 05:19:51', '2025-09-13 05:19:51'),
(89, 90, 19, '232410010', 0.00, 0, '2025-09-13 05:19:51', '2025-09-13 05:19:51'),
(90, 91, 19, '232410011', 0.00, 0, '2025-09-13 05:19:51', '2025-09-13 05:19:51'),
(91, 92, 19, '232410012', 0.00, 0, '2025-09-13 05:19:52', '2025-09-13 05:19:52'),
(92, 93, 19, '232410013', 0.00, 0, '2025-09-13 05:19:52', '2025-09-13 05:19:52'),
(93, 94, 19, '232410014', 0.00, 0, '2025-09-13 05:19:52', '2025-09-13 05:19:52'),
(94, 95, 19, '232410015', 0.00, 0, '2025-09-13 05:19:53', '2025-09-13 05:19:53'),
(95, 96, 19, '232410016', 0.00, 0, '2025-09-13 05:19:53', '2025-09-13 05:19:53'),
(96, 97, 19, '232410017', 0.00, 0, '2025-09-13 05:19:53', '2025-09-13 05:19:53'),
(97, 98, 19, '232410018', 0.00, 0, '2025-09-13 05:19:54', '2025-09-13 05:19:54'),
(98, 99, 19, '232410019', 0.00, 0, '2025-09-13 05:19:54', '2025-09-13 05:19:54'),
(99, 100, 19, '232410020', 0.00, 0, '2025-09-13 05:19:54', '2025-09-13 05:19:54'),
(100, 101, 19, '232410021', 0.00, 0, '2025-09-13 05:19:55', '2025-09-13 05:19:55'),
(101, 102, 19, '232410022', 0.00, 0, '2025-09-13 05:19:55', '2025-09-13 05:19:55'),
(102, 103, 19, '232410023', 0.00, 0, '2025-09-13 05:19:55', '2025-09-13 05:19:55'),
(103, 104, 19, '232410024', 0.00, 0, '2025-09-13 05:19:55', '2025-09-13 05:19:55'),
(104, 105, 19, '232410025', 0.00, 0, '2025-09-13 05:19:56', '2025-09-13 05:19:56'),
(105, 106, 19, '232410026', 0.00, 0, '2025-09-13 05:19:56', '2025-09-13 05:19:56'),
(106, 107, 20, '232410027', 0.00, 0, '2025-09-13 05:19:56', '2025-09-13 05:19:56'),
(107, 108, 20, '232410028', 0.00, 0, '2025-09-13 05:19:56', '2025-09-13 05:19:56'),
(108, 109, 20, '232410029', 0.00, 0, '2025-09-13 05:19:57', '2025-09-13 05:19:57'),
(109, 110, 20, '232410030', 0.00, 0, '2025-09-13 05:19:57', '2025-09-13 05:19:57'),
(110, 111, 20, '232410031', 0.00, 0, '2025-09-13 05:19:57', '2025-09-13 05:19:57'),
(111, 112, 20, '232410032', 0.00, 0, '2025-09-13 05:19:58', '2025-09-13 05:19:58'),
(112, 113, 20, '232410033', 0.00, 0, '2025-09-13 05:19:58', '2025-09-13 05:19:58'),
(113, 114, 20, '232410034', 0.00, 0, '2025-09-13 05:19:58', '2025-09-13 05:19:58'),
(114, 115, 20, '232410035', 0.00, 0, '2025-09-13 05:19:58', '2025-09-13 05:19:58'),
(115, 116, 20, '232410036', 0.00, 0, '2025-09-13 05:19:59', '2025-09-13 05:19:59'),
(116, 117, 20, '232410037', 0.00, 0, '2025-09-13 05:19:59', '2025-09-13 05:19:59'),
(117, 118, 20, '232410038', 0.00, 0, '2025-09-13 05:19:59', '2025-09-13 05:19:59'),
(118, 119, 20, '232410039', 0.00, 0, '2025-09-13 05:19:59', '2025-09-13 05:19:59'),
(119, 120, 20, '232410040', 0.00, 0, '2025-09-13 05:20:00', '2025-09-13 05:20:00'),
(120, 121, 20, '232410041', 0.00, 0, '2025-09-13 05:20:00', '2025-09-13 05:20:00'),
(121, 122, 20, '232410042', 0.00, 0, '2025-09-13 05:20:00', '2025-09-13 05:20:00'),
(122, 123, 20, '232410043', 0.00, 0, '2025-09-13 05:20:01', '2025-09-13 05:20:01'),
(123, 124, 20, '232410044', 0.00, 0, '2025-09-13 05:20:01', '2025-09-13 05:20:01'),
(124, 125, 20, '232410045', 0.00, 0, '2025-09-13 05:20:01', '2025-09-13 05:20:01'),
(125, 126, 20, '232410046', 0.00, 0, '2025-09-13 05:20:01', '2025-09-13 05:20:01'),
(126, 127, 20, '232410047', 0.00, 0, '2025-09-13 05:20:02', '2025-09-13 05:20:02'),
(127, 128, 20, '232410048', 0.00, 0, '2025-09-13 05:20:02', '2025-09-13 05:20:02'),
(128, 129, 20, '232410049', 0.00, 0, '2025-09-13 05:20:02', '2025-09-13 05:20:02'),
(129, 130, 20, '232410050', 0.00, 0, '2025-09-13 05:20:02', '2025-09-13 05:20:02'),
(130, 131, 20, '232410051', 0.00, 0, '2025-09-13 05:20:03', '2025-09-13 05:20:03'),
(131, 132, 21, '232410052', 0.00, 0, '2025-09-13 05:20:03', '2025-09-13 05:20:03'),
(132, 133, 21, '232410053', 0.00, 0, '2025-09-13 05:20:03', '2025-09-13 05:20:03'),
(133, 134, 21, '232410054', 0.00, 0, '2025-09-13 05:20:04', '2025-09-13 05:20:04'),
(134, 135, 21, '232410055', 0.00, 0, '2025-09-13 05:20:04', '2025-09-13 05:20:04'),
(135, 136, 21, '232410056', 0.00, 0, '2025-09-13 05:20:04', '2025-09-13 05:20:04'),
(136, 137, 21, '232410057', 0.00, 0, '2025-09-13 05:20:04', '2025-09-13 05:20:04'),
(137, 138, 21, '232410058', 0.00, 0, '2025-09-13 05:20:05', '2025-09-13 05:20:05'),
(138, 139, 21, '232410059', 0.00, 0, '2025-09-13 05:20:05', '2025-09-13 05:20:05'),
(139, 140, 21, '232410060', 0.00, 0, '2025-09-13 05:20:05', '2025-09-13 05:20:05'),
(140, 141, 21, '232410061', 0.00, 0, '2025-09-13 05:20:05', '2025-09-13 05:20:05'),
(141, 142, 21, '232410062', 0.00, 0, '2025-09-13 05:20:06', '2025-09-13 05:20:06'),
(142, 143, 21, '232410063', 0.00, 0, '2025-09-13 05:20:06', '2025-09-13 05:20:06'),
(143, 144, 21, '232410064', 0.00, 0, '2025-09-13 05:20:06', '2025-09-13 05:20:06'),
(144, 145, 21, '232410065', 0.00, 0, '2025-09-13 05:20:06', '2025-09-13 05:20:06'),
(145, 146, 21, '232410066', 0.00, 0, '2025-09-13 05:20:07', '2025-09-13 05:20:07'),
(146, 147, 21, '232410067', 0.00, 0, '2025-09-13 05:20:07', '2025-09-13 05:20:07'),
(147, 148, 21, '232410068', 0.00, 0, '2025-09-13 05:20:07', '2025-09-13 05:20:07'),
(148, 149, 21, '232410069', 0.00, 0, '2025-09-13 05:20:08', '2025-09-13 05:20:08'),
(149, 150, 21, '232410070', 0.00, 0, '2025-09-13 05:20:08', '2025-09-13 05:20:08'),
(150, 151, 21, '232410071', 0.00, 0, '2025-09-13 05:20:08', '2025-09-13 05:20:08'),
(151, 152, 21, '232410072', 0.00, 0, '2025-09-13 05:20:08', '2025-09-13 05:20:08'),
(152, 153, 21, '232410073', 0.00, 0, '2025-09-13 05:20:09', '2025-09-13 05:20:09'),
(153, 154, 21, '232410074', 0.00, 0, '2025-09-13 05:20:09', '2025-09-13 05:20:09'),
(154, 155, 21, '232410075', 0.00, 0, '2025-09-13 05:20:09', '2025-09-13 05:20:09'),
(155, 156, 21, '232410076', 0.00, 0, '2025-09-13 05:20:09', '2025-09-13 05:20:09'),
(156, 157, 21, '232410077', 0.00, 0, '2025-09-13 05:20:10', '2025-09-13 05:20:10'),
(157, 158, 21, '232410078', 0.00, 0, '2025-09-13 05:20:10', '2025-09-13 05:20:10'),
(158, 159, 21, '232410079', 0.00, 0, '2025-09-13 05:20:10', '2025-09-13 05:20:10'),
(159, 160, 21, '232410080', 0.00, 0, '2025-09-13 05:20:10', '2025-09-13 05:20:10'),
(160, 161, 21, '232410081', 0.00, 0, '2025-09-13 05:20:11', '2025-09-13 05:20:11'),
(161, 162, 21, '232410082', 0.00, 0, '2025-09-13 05:20:11', '2025-09-13 05:20:11'),
(162, 163, 21, '232410083', 0.00, 0, '2025-09-13 05:20:11', '2025-09-13 05:20:11'),
(163, 164, 21, '232410084', 0.00, 0, '2025-09-13 05:20:12', '2025-09-13 05:20:12'),
(164, 165, 22, '232410085', 0.00, 0, '2025-09-13 05:20:12', '2025-09-13 05:20:12'),
(165, 166, 22, '232410086', 0.00, 0, '2025-09-13 05:20:12', '2025-09-13 05:20:12'),
(166, 167, 22, '232410087', 0.00, 0, '2025-09-13 05:20:12', '2025-09-13 05:20:12'),
(167, 168, 22, '232410088', 0.00, 0, '2025-09-13 05:20:13', '2025-09-13 05:20:13'),
(168, 169, 22, '232410089', 0.00, 0, '2025-09-13 05:20:13', '2025-09-13 05:20:13'),
(169, 170, 22, '232410090', 0.00, 0, '2025-09-13 05:20:13', '2025-09-13 05:20:13'),
(170, 171, 22, '232410091', 0.00, 0, '2025-09-13 05:20:13', '2025-09-13 05:20:13'),
(171, 172, 22, '232410092', 0.00, 0, '2025-09-13 05:20:14', '2025-09-13 05:20:14'),
(172, 173, 22, '232410093', 0.00, 0, '2025-09-13 05:20:14', '2025-09-13 05:20:14'),
(173, 174, 22, '232410094', 0.00, 0, '2025-09-13 05:20:14', '2025-09-13 05:20:14'),
(174, 175, 22, '232410095', 0.00, 0, '2025-09-13 05:20:14', '2025-09-13 05:20:14'),
(175, 176, 22, '232410096', 0.00, 0, '2025-09-13 05:20:15', '2025-09-13 05:20:15'),
(176, 177, 22, '232410097', 0.00, 0, '2025-09-13 05:20:15', '2025-09-13 05:20:15'),
(177, 178, 22, '232410098', 0.00, 0, '2025-09-13 05:20:15', '2025-09-13 05:20:15'),
(178, 179, 22, '232410099', 0.00, 0, '2025-09-13 05:20:16', '2025-09-13 05:20:16'),
(179, 180, 22, '232410100', 0.00, 0, '2025-09-13 05:20:16', '2025-09-13 05:20:16'),
(180, 181, 22, '232410101', 0.00, 0, '2025-09-13 05:20:16', '2025-09-13 05:20:16'),
(181, 182, 22, '232410102', 0.00, 0, '2025-09-13 05:20:16', '2025-09-13 05:20:16'),
(182, 183, 22, '232410103', 0.00, 0, '2025-09-13 05:20:17', '2025-09-13 05:20:17'),
(183, 184, 22, '232410104', 0.00, 0, '2025-09-13 05:20:17', '2025-09-13 05:20:17'),
(184, 185, 22, '232410105', 0.00, 0, '2025-09-13 05:20:17', '2025-09-13 05:20:17'),
(185, 186, 22, '232410106', 0.00, 0, '2025-09-13 05:20:17', '2025-09-13 05:20:17'),
(186, 187, 22, '232410107', 0.00, 0, '2025-09-13 05:20:18', '2025-09-13 05:20:18'),
(187, 188, 22, '232410108', 0.00, 0, '2025-09-13 05:20:18', '2025-09-13 05:20:18'),
(188, 189, 22, '232410109', 0.00, 0, '2025-09-13 05:20:18', '2025-09-13 05:20:18'),
(189, 190, 22, '232410110', 0.00, 0, '2025-09-13 05:20:18', '2025-09-13 05:20:18'),
(190, 191, 22, '232410111', 0.00, 0, '2025-09-13 05:20:19', '2025-09-13 05:20:19'),
(191, 192, 22, '232410112', 0.00, 0, '2025-09-13 05:20:19', '2025-09-13 05:20:19'),
(192, 193, 22, '232410113', 0.00, 0, '2025-09-13 05:20:19', '2025-09-13 05:20:19'),
(193, 194, 22, '232410114', 0.00, 0, '2025-09-13 05:20:20', '2025-09-13 05:20:20'),
(194, 195, 22, '232410115', 0.00, 0, '2025-09-13 05:20:20', '2025-09-13 05:20:20'),
(195, 196, 22, '232410116', 0.00, 0, '2025-09-13 05:20:20', '2025-09-13 05:20:20'),
(196, 197, 22, '232410117', 0.00, 0, '2025-09-13 05:20:20', '2025-09-13 05:20:20'),
(197, 198, 22, '232410118', 0.00, 0, '2025-09-13 05:20:21', '2025-09-13 05:20:21'),
(198, 199, 23, '232410119', 0.00, 0, '2025-09-13 05:20:21', '2025-09-13 05:20:21'),
(199, 200, 23, '232410120', 0.00, 0, '2025-09-13 05:20:21', '2025-09-13 05:20:21'),
(200, 201, 23, '232410121', 0.00, 0, '2025-09-13 05:20:21', '2025-09-13 05:20:21'),
(201, 202, 23, '232410122', 0.00, 0, '2025-09-13 05:20:22', '2025-09-13 05:20:22'),
(202, 203, 23, '232410123', 0.00, 0, '2025-09-13 05:20:22', '2025-09-13 05:20:22'),
(203, 204, 23, '232410124', 0.00, 0, '2025-09-13 05:20:22', '2025-09-13 05:20:22'),
(204, 205, 23, '232410125', 0.00, 0, '2025-09-13 05:20:23', '2025-09-13 05:20:23'),
(205, 206, 23, '232410126', 0.00, 0, '2025-09-13 05:20:23', '2025-09-13 05:20:23'),
(206, 207, 23, '232410127', 0.00, 0, '2025-09-13 05:20:23', '2025-09-13 05:20:23'),
(207, 208, 23, '232410128', 0.00, 0, '2025-09-13 05:20:23', '2025-09-13 05:20:23'),
(208, 209, 23, '232410129', 0.00, 0, '2025-09-13 05:20:24', '2025-09-13 05:20:24'),
(209, 210, 23, '232410130', 0.00, 0, '2025-09-13 05:20:24', '2025-09-13 05:20:24'),
(210, 211, 23, '232410131', 0.00, 0, '2025-09-13 05:20:24', '2025-09-13 05:20:24'),
(211, 212, 23, '232410132', 0.00, 0, '2025-09-13 05:20:24', '2025-09-13 05:20:24'),
(212, 213, 23, '232410133', 0.00, 0, '2025-09-13 05:20:25', '2025-09-13 05:20:25'),
(213, 214, 23, '232410134', 0.00, 0, '2025-09-13 05:20:25', '2025-09-13 05:20:25'),
(214, 215, 23, '232410135', 0.00, 0, '2025-09-13 05:20:25', '2025-09-13 05:20:25'),
(215, 216, 23, '232410136', 0.00, 0, '2025-09-13 05:20:26', '2025-09-13 05:20:26'),
(216, 217, 23, '232410137', 0.00, 0, '2025-09-13 05:20:26', '2025-09-13 05:20:26'),
(217, 218, 23, '232410138', 0.00, 0, '2025-09-13 05:20:26', '2025-09-13 05:20:26'),
(218, 219, 23, '232410139', 0.00, 0, '2025-09-13 05:20:26', '2025-09-13 05:20:26'),
(219, 220, 23, '232410140', 0.00, 0, '2025-09-13 05:20:27', '2025-09-13 05:20:27'),
(220, 221, 23, '232410141', 0.00, 0, '2025-09-13 05:20:27', '2025-09-13 05:20:27'),
(221, 222, 23, '232410142', 0.00, 0, '2025-09-13 05:20:27', '2025-09-13 05:20:27'),
(222, 223, 23, '232410143', 0.00, 0, '2025-09-13 05:20:28', '2025-09-13 05:20:28'),
(223, 224, 23, '232410144', 0.00, 0, '2025-09-13 05:20:28', '2025-09-13 05:20:28'),
(224, 225, 23, '232410145', 0.00, 0, '2025-09-13 05:20:28', '2025-09-13 05:20:28'),
(225, 226, 23, '232410146', 0.00, 0, '2025-09-13 05:20:28', '2025-09-13 05:20:28'),
(226, 227, 23, '232410147', 0.00, 0, '2025-09-13 05:20:29', '2025-09-13 05:20:29'),
(227, 228, 23, '232410148', 0.00, 0, '2025-09-13 05:20:29', '2025-09-13 05:20:29'),
(228, 229, 23, '232410149', 0.00, 0, '2025-09-13 05:20:29', '2025-09-13 05:20:29'),
(229, 230, 23, '232410150', 0.00, 0, '2025-09-13 05:20:30', '2025-09-13 05:20:30'),
(230, 231, 23, '232410151', 0.00, 0, '2025-09-13 05:20:30', '2025-09-13 05:20:30'),
(231, 232, 23, '232410152', 0.00, 0, '2025-09-13 05:20:30', '2025-09-13 05:20:30'),
(232, 233, 23, '232410153', 0.00, 0, '2025-09-13 05:20:30', '2025-09-13 05:20:30'),
(233, 234, 24, '232410154', 0.00, 0, '2025-09-13 05:20:31', '2025-09-13 05:20:31'),
(234, 235, 24, '232410155', 0.00, 0, '2025-09-13 05:20:31', '2025-09-13 05:20:31'),
(235, 236, 24, '232410156', 0.00, 0, '2025-09-13 05:20:31', '2025-09-13 05:20:31'),
(236, 237, 24, '232410157', 0.00, 0, '2025-09-13 05:20:31', '2025-09-13 05:20:31'),
(237, 238, 24, '232410158', 0.00, 0, '2025-09-13 05:20:32', '2025-09-13 05:20:32'),
(238, 239, 24, '232410159', 0.00, 0, '2025-09-13 05:20:32', '2025-09-13 05:20:32'),
(239, 240, 24, '232410160', 0.00, 0, '2025-09-13 05:20:32', '2025-09-13 05:20:32'),
(240, 241, 24, '232410161', 0.00, 0, '2025-09-13 05:20:32', '2025-09-13 05:20:32'),
(241, 242, 24, '232410162', 0.00, 0, '2025-09-13 05:20:33', '2025-09-13 05:20:33'),
(242, 243, 24, '232410163', 0.00, 0, '2025-09-13 05:20:33', '2025-09-13 05:20:33'),
(243, 244, 24, '232410164', 0.00, 0, '2025-09-13 05:20:33', '2025-09-13 05:20:33'),
(244, 245, 24, '232410165', 0.00, 0, '2025-09-13 05:20:34', '2025-09-13 05:20:34'),
(245, 246, 24, '232410166', 0.00, 0, '2025-09-13 05:20:34', '2025-09-13 05:20:34'),
(246, 247, 24, '232410167', 0.00, 0, '2025-09-13 05:20:34', '2025-09-13 05:20:34'),
(247, 248, 24, '232410168', 0.00, 0, '2025-09-13 05:20:34', '2025-09-13 05:20:34'),
(248, 249, 24, '232410169', 0.00, 0, '2025-09-13 05:20:35', '2025-09-13 05:20:35'),
(249, 250, 24, '232410170', 0.00, 0, '2025-09-13 05:20:35', '2025-09-13 05:20:35'),
(250, 251, 24, '232410171', 0.00, 0, '2025-09-13 05:20:35', '2025-09-13 05:20:35'),
(251, 252, 24, '232410172', 0.00, 0, '2025-09-13 05:20:35', '2025-09-13 05:20:35'),
(252, 253, 24, '232410173', 0.00, 0, '2025-09-13 05:20:36', '2025-09-13 05:20:36'),
(253, 254, 24, '232410174', 0.00, 0, '2025-09-13 05:20:36', '2025-09-13 05:20:36'),
(254, 255, 24, '232410175', 0.00, 0, '2025-09-13 05:20:36', '2025-09-13 05:20:36'),
(255, 256, 24, '232410176', 0.00, 0, '2025-09-13 05:20:37', '2025-09-13 05:20:37'),
(256, 257, 24, '232410177', 0.00, 0, '2025-09-13 05:20:37', '2025-09-13 05:20:37'),
(257, 258, 24, '232410178', 0.00, 0, '2025-09-13 05:20:37', '2025-09-13 05:20:37'),
(258, 259, 24, '232410179', 0.00, 0, '2025-09-13 05:20:37', '2025-09-13 05:20:37'),
(259, 260, 24, '232410180', 0.00, 0, '2025-09-13 05:20:38', '2025-09-13 05:20:38'),
(260, 261, 24, '232410181', 0.00, 0, '2025-09-13 05:20:38', '2025-09-13 05:20:38'),
(261, 262, 24, '232410182', 0.00, 0, '2025-09-13 05:20:38', '2025-09-13 05:20:38'),
(262, 263, 24, '232410183', 0.00, 0, '2025-09-13 05:20:38', '2025-09-13 05:20:38'),
(263, 264, 24, '232410184', 0.00, 0, '2025-09-13 05:20:39', '2025-09-13 05:20:39'),
(264, 265, 24, '232410185', 0.00, 0, '2025-09-13 05:20:39', '2025-09-13 05:20:39'),
(265, 266, 24, '232410186', 0.00, 0, '2025-09-13 05:20:39', '2025-09-13 05:20:39'),
(266, 267, 24, '232410187', 0.00, 0, '2025-09-13 05:20:39', '2025-09-13 05:20:39'),
(267, 268, 25, '232410188', 0.00, 0, '2025-09-13 05:20:40', '2025-09-13 05:20:40'),
(268, 269, 25, '232410189', 0.00, 0, '2025-09-13 05:20:40', '2025-09-13 05:20:40'),
(269, 270, 25, '232410190', 0.00, 0, '2025-09-13 05:20:40', '2025-09-13 05:20:40'),
(270, 271, 25, '232410191', 0.00, 0, '2025-09-13 05:20:40', '2025-09-13 05:20:40'),
(271, 272, 25, '232410192', 0.00, 0, '2025-09-13 05:20:41', '2025-09-13 05:20:41'),
(272, 273, 25, '232410193', 0.00, 0, '2025-09-13 05:20:41', '2025-09-13 05:20:41'),
(273, 274, 25, '232410194', 0.00, 0, '2025-09-13 05:20:41', '2025-09-13 05:20:41'),
(274, 275, 25, '232410195', 0.00, 0, '2025-09-13 05:20:42', '2025-09-13 05:20:42'),
(275, 276, 25, '232410196', 0.00, 0, '2025-09-13 05:20:42', '2025-09-13 05:20:42'),
(276, 277, 25, '232410197', 0.00, 0, '2025-09-13 05:20:42', '2025-09-13 05:20:42'),
(277, 278, 25, '232410198', 0.00, 0, '2025-09-13 05:20:42', '2025-09-13 05:20:42'),
(278, 279, 25, '232410199', 0.00, 0, '2025-09-13 05:20:43', '2025-09-13 05:20:43'),
(279, 280, 16, '242510200', 0.00, 0, '2025-09-13 05:20:51', '2025-09-13 05:20:51'),
(280, 281, 16, '242510201', 0.00, 0, '2025-09-13 05:20:52', '2025-09-13 05:20:52'),
(281, 282, 16, '242510202', 0.00, 0, '2025-09-13 05:20:52', '2025-09-13 05:20:52'),
(282, 283, 16, '242510203', 0.00, 0, '2025-09-13 05:20:52', '2025-09-13 05:20:52'),
(283, 284, 16, '242510204', 0.00, 0, '2025-09-13 05:20:53', '2025-09-13 05:20:53'),
(284, 285, 16, '242510205', 0.00, 0, '2025-09-13 05:20:53', '2025-09-13 05:20:53'),
(285, 286, 16, '242510206', 0.00, 0, '2025-09-13 05:20:53', '2025-09-13 05:20:53'),
(286, 287, 16, '242510207', 0.00, 0, '2025-09-13 05:20:53', '2025-09-13 05:20:53'),
(287, 288, 16, '242510208', 0.00, 0, '2025-09-13 05:20:54', '2025-09-13 05:20:54'),
(288, 289, 16, '242510209', 0.00, 0, '2025-09-13 05:20:54', '2025-09-13 05:20:54'),
(289, 290, 16, '242510210', 0.00, 0, '2025-09-13 05:20:54', '2025-09-13 05:20:54'),
(290, 291, 17, '242510211', 0.00, 0, '2025-09-13 05:20:55', '2025-09-13 05:20:55'),
(291, 292, 17, '242510212', 0.00, 0, '2025-09-13 05:20:55', '2025-09-13 05:20:55'),
(292, 293, 17, '242510213', 0.00, 0, '2025-09-13 05:20:55', '2025-09-13 05:20:55'),
(293, 294, 17, '242510214', 0.00, 0, '2025-09-13 05:20:55', '2025-09-13 05:20:55'),
(294, 295, 17, '242510215', 0.00, 0, '2025-09-13 05:20:56', '2025-09-13 05:20:56'),
(295, 296, 17, '242510216', 0.00, 0, '2025-09-13 05:20:56', '2025-09-13 05:20:56'),
(296, 297, 17, '242510217', 0.00, 0, '2025-09-13 05:20:56', '2025-09-13 05:20:56'),
(297, 298, 17, '242510218', 0.00, 0, '2025-09-13 05:20:57', '2025-09-13 05:20:57'),
(298, 299, 17, '242510219', 0.00, 0, '2025-09-13 05:20:57', '2025-09-13 05:20:57'),
(299, 300, 17, '242510220', 0.00, 0, '2025-09-13 05:20:57', '2025-09-13 05:20:57'),
(300, 301, 17, '242510221', 0.00, 0, '2025-09-13 05:20:58', '2025-09-13 05:20:58'),
(301, 302, 17, '242510222', 0.00, 0, '2025-09-13 05:20:58', '2025-09-13 05:20:58'),
(302, 303, 17, '242510223', 0.00, 0, '2025-09-13 05:20:58', '2025-09-13 05:20:58'),
(303, 304, 17, '242510224', 0.00, 0, '2025-09-13 05:20:58', '2025-09-13 05:20:58'),
(304, 305, 17, '242510225', 0.00, 0, '2025-09-13 05:20:59', '2025-09-13 05:20:59'),
(305, 306, 17, '242510226', 0.00, 0, '2025-09-13 05:20:59', '2025-09-13 05:20:59'),
(306, 307, 17, '242510227', 0.00, 0, '2025-09-13 05:20:59', '2025-09-13 05:20:59'),
(307, 308, 17, '242510228', 0.00, 0, '2025-09-13 05:21:00', '2025-09-13 05:21:00'),
(308, 309, 17, '242510229', 0.00, 0, '2025-09-13 05:21:00', '2025-09-13 05:21:00'),
(309, 310, 17, '242510230', 0.00, 0, '2025-09-13 05:21:00', '2025-09-13 05:21:00'),
(310, 311, 17, '242510231', 0.00, 0, '2025-09-13 05:21:01', '2025-09-13 05:21:01'),
(311, 312, 17, '242510232', 0.00, 0, '2025-09-13 05:21:01', '2025-09-13 05:21:01'),
(312, 313, 17, '242510233', 0.00, 0, '2025-09-13 05:21:02', '2025-09-13 05:21:02'),
(313, 314, 17, '242510234', 0.00, 0, '2025-09-13 05:21:02', '2025-09-13 05:21:02'),
(314, 315, 17, '242510235', 0.00, 0, '2025-09-13 05:21:03', '2025-09-13 05:21:03'),
(315, 316, 17, '242510236', 0.00, 0, '2025-09-13 05:21:04', '2025-09-13 05:21:04'),
(316, 317, 18, '242510237', 0.00, 0, '2025-09-13 05:21:05', '2025-09-13 05:21:05'),
(317, 318, 18, '242510238', 0.00, 0, '2025-09-13 05:21:05', '2025-09-13 05:21:05'),
(318, 319, 18, '242510239', 0.00, 0, '2025-09-13 05:21:06', '2025-09-13 05:21:06'),
(319, 320, 18, '242510240', 0.00, 0, '2025-09-13 05:21:06', '2025-09-13 05:21:06'),
(320, 321, 18, '242510241', 0.00, 0, '2025-09-13 05:21:07', '2025-09-13 05:21:07'),
(321, 322, 18, '242510242', 0.00, 0, '2025-09-13 05:21:08', '2025-09-13 05:21:08'),
(322, 323, 18, '242510243', 0.00, 0, '2025-09-13 05:21:09', '2025-09-13 05:21:09'),
(323, 324, 18, '242510244', 0.00, 0, '2025-09-13 05:21:09', '2025-09-13 05:21:09'),
(324, 325, 18, '242510245', 0.00, 0, '2025-09-13 05:21:10', '2025-09-13 05:21:10'),
(325, 326, 18, '242510246', 0.00, 0, '2025-09-13 05:21:10', '2025-09-13 05:21:10'),
(326, 327, 18, '242510247', 0.00, 0, '2025-09-13 05:21:10', '2025-09-13 05:21:10'),
(327, 328, 18, '242510248', 0.00, 0, '2025-09-13 05:21:11', '2025-09-13 05:21:11'),
(328, 329, 18, '242510249', 0.00, 0, '2025-09-13 05:21:11', '2025-09-13 05:21:11'),
(329, 330, 18, '242510250', 0.00, 0, '2025-09-13 05:21:11', '2025-09-13 05:21:11'),
(330, 331, 18, '242510251', 0.00, 0, '2025-09-13 05:21:12', '2025-09-13 05:21:12'),
(331, 332, 18, '242510252', 0.00, 0, '2025-09-13 05:21:12', '2025-09-13 05:21:12'),
(332, 333, 18, '242510253', 0.00, 0, '2025-09-13 05:21:12', '2025-09-13 05:21:12'),
(333, 334, 18, '242510254', 0.00, 0, '2025-09-13 05:21:13', '2025-09-13 05:21:13'),
(334, 335, 18, '242510255', 0.00, 0, '2025-09-13 05:21:13', '2025-09-13 05:21:13'),
(335, 336, 18, '242510256', 0.00, 0, '2025-09-13 05:21:13', '2025-09-13 05:21:13'),
(336, 337, 18, '242510257', 0.00, 0, '2025-09-13 05:21:13', '2025-09-13 05:21:13'),
(337, 338, 18, '242510258', 0.00, 0, '2025-09-13 05:21:14', '2025-09-13 05:21:14'),
(338, 339, 18, '242510259', 0.00, 0, '2025-09-13 05:21:14', '2025-09-13 05:21:14'),
(339, 340, 18, '242510260', 0.00, 0, '2025-09-13 05:21:14', '2025-09-13 05:21:14'),
(340, 341, 18, '242510261', 0.00, 0, '2025-09-13 05:21:14', '2025-09-13 05:21:14'),
(341, 342, 18, '242510262', 0.00, 0, '2025-09-13 05:21:15', '2025-09-13 05:21:15'),
(342, 343, 18, '242510263', 0.00, 0, '2025-09-13 05:21:15', '2025-09-13 05:21:15'),
(343, 344, 18, '242510264', 0.00, 0, '2025-09-13 05:21:15', '2025-09-13 05:21:15'),
(344, 345, 10, '242510001', 0.00, 0, '2025-09-13 05:21:27', '2025-09-13 05:21:27'),
(345, 346, 10, '242510002', 0.00, 0, '2025-09-13 05:21:27', '2025-09-13 05:21:27'),
(346, 347, 10, '242510003', 0.00, 0, '2025-09-13 05:21:28', '2025-09-13 05:21:28'),
(347, 348, 10, '242510004', 0.00, 0, '2025-09-13 05:21:28', '2025-09-13 05:21:28'),
(348, 349, 10, '242510005', 0.00, 0, '2025-09-13 05:21:28', '2025-09-13 05:21:28'),
(349, 350, 10, '242510006', 0.00, 0, '2025-09-13 05:21:29', '2025-09-13 05:21:29'),
(350, 351, 10, '242510007', 0.00, 0, '2025-09-13 05:21:29', '2025-09-13 05:21:29'),
(351, 352, 10, '242510008', 0.00, 0, '2025-09-13 05:21:29', '2025-09-13 05:21:29'),
(352, 353, 10, '242510009', 0.00, 0, '2025-09-13 05:21:29', '2025-09-13 05:21:29'),
(353, 354, 10, '242510010', 0.00, 0, '2025-09-13 05:21:30', '2025-09-13 05:21:30'),
(354, 355, 10, '242510011', 0.00, 0, '2025-09-13 05:21:30', '2025-09-13 05:21:30'),
(355, 356, 10, '242510012', 0.00, 0, '2025-09-13 05:21:30', '2025-09-13 05:21:30'),
(356, 357, 10, '242510013', 0.00, 0, '2025-09-13 05:21:31', '2025-09-13 05:21:31'),
(357, 358, 10, '242510014', 0.00, 0, '2025-09-13 05:21:31', '2025-09-13 05:21:31'),
(358, 359, 10, '242510015', 0.00, 0, '2025-09-13 05:21:31', '2025-09-13 05:21:31'),
(359, 360, 10, '242510016', 0.00, 0, '2025-09-13 05:21:31', '2025-09-13 05:21:31'),
(360, 361, 10, '242510017', 0.00, 0, '2025-09-13 05:21:32', '2025-09-13 05:21:32'),
(361, 362, 10, '242510018', 0.00, 0, '2025-09-13 05:21:32', '2025-09-13 05:21:32'),
(362, 363, 10, '242510019', 0.00, 0, '2025-09-13 05:21:32', '2025-09-13 05:21:32'),
(363, 364, 10, '242510020', 0.00, 0, '2025-09-13 05:21:32', '2025-09-13 05:21:32'),
(364, 365, 10, '242510021', 0.00, 0, '2025-09-13 05:21:33', '2025-09-13 05:21:33'),
(365, 366, 10, '242510022', 0.00, 0, '2025-09-13 05:21:33', '2025-09-13 05:21:33'),
(366, 367, 10, '242510023', 0.00, 0, '2025-09-13 05:21:33', '2025-09-13 05:21:33'),
(367, 368, 10, '242510024', 0.00, 0, '2025-09-13 05:21:34', '2025-09-13 05:21:34'),
(368, 369, 10, '242510025', 0.00, 0, '2025-09-13 05:21:34', '2025-09-13 05:21:34'),
(369, 370, 10, '242510026', 0.00, 0, '2025-09-13 05:21:34', '2025-09-13 05:21:34'),
(370, 371, 10, '242510027', 0.00, 0, '2025-09-13 05:21:34', '2025-09-13 05:21:34'),
(371, 372, 10, '242510028', 0.00, 0, '2025-09-13 05:21:35', '2025-09-13 05:21:35'),
(372, 373, 10, '242510029', 0.00, 0, '2025-09-13 05:21:35', '2025-09-13 05:21:35'),
(373, 374, 10, '242510030', 0.00, 0, '2025-09-13 05:21:35', '2025-09-13 05:21:35'),
(374, 375, 10, '242510031', 0.00, 0, '2025-09-13 05:21:35', '2025-09-13 05:21:35'),
(375, 376, 10, '242510032', 0.00, 0, '2025-09-13 05:21:36', '2025-09-13 05:21:36'),
(376, 377, 10, '242510033', 0.00, 0, '2025-09-13 05:21:36', '2025-09-13 05:21:36'),
(377, 378, 11, '242510034', 0.00, 0, '2025-09-13 05:21:36', '2025-09-13 05:21:36'),
(378, 379, 11, '242510035', 0.00, 0, '2025-09-13 05:21:36', '2025-09-13 05:21:36'),
(379, 380, 11, '242510036', 0.00, 0, '2025-09-13 05:21:37', '2025-09-13 05:21:37'),
(380, 381, 11, '242510037', 0.00, 0, '2025-09-13 05:21:37', '2025-09-13 05:21:37'),
(381, 382, 11, '242510038', 0.00, 0, '2025-09-13 05:21:37', '2025-09-13 05:21:37'),
(382, 383, 11, '242510039', 0.00, 0, '2025-09-13 05:21:38', '2025-09-13 05:21:38'),
(383, 384, 11, '242510040', 0.00, 0, '2025-09-13 05:21:38', '2025-09-13 05:21:38'),
(384, 385, 11, '242510041', 0.00, 0, '2025-09-13 05:21:38', '2025-09-13 05:21:38'),
(385, 386, 11, '242510042', 0.00, 0, '2025-09-13 05:21:38', '2025-09-13 05:21:38'),
(386, 387, 11, '242510043', 0.00, 0, '2025-09-13 05:21:39', '2025-09-13 05:21:39'),
(387, 388, 11, '242510044', 0.00, 0, '2025-09-13 05:21:39', '2025-09-13 05:21:39'),
(388, 389, 11, '242510045', 0.00, 0, '2025-09-13 05:21:39', '2025-09-13 05:21:39'),
(389, 390, 11, '242510046', 0.00, 0, '2025-09-13 05:21:39', '2025-09-13 05:21:39'),
(390, 391, 11, '242510047', 0.00, 0, '2025-09-13 05:21:40', '2025-09-13 05:21:40'),
(391, 392, 11, '242510048', 0.00, 0, '2025-09-13 05:21:40', '2025-09-13 05:21:40'),
(392, 393, 11, '242510049', 0.00, 0, '2025-09-13 05:21:40', '2025-09-13 05:21:40'),
(393, 394, 11, '242510050', 0.00, 0, '2025-09-13 05:21:40', '2025-09-13 05:21:40'),
(394, 395, 11, '242510051', 0.00, 0, '2025-09-13 05:21:41', '2025-09-13 05:21:41'),
(395, 396, 11, '242510052', 0.00, 0, '2025-09-13 05:21:41', '2025-09-13 05:21:41'),
(396, 397, 11, '242510053', 0.00, 0, '2025-09-13 05:21:41', '2025-09-13 05:21:41'),
(397, 398, 11, '242510054', 0.00, 0, '2025-09-13 05:21:42', '2025-09-13 05:21:42'),
(398, 399, 11, '242510055', 0.00, 0, '2025-09-13 05:21:42', '2025-09-13 05:21:42'),
(399, 400, 11, '242510056', 0.00, 0, '2025-09-13 05:21:42', '2025-09-13 05:21:42'),
(400, 401, 11, '242510057', 0.00, 0, '2025-09-13 05:21:42', '2025-09-13 05:21:42'),
(401, 402, 11, '242510058', 0.00, 0, '2025-09-13 05:21:43', '2025-09-13 05:21:43'),
(402, 403, 11, '242510059', 0.00, 0, '2025-09-13 05:21:43', '2025-09-13 05:21:43'),
(403, 404, 11, '242510060', 0.00, 0, '2025-09-13 05:21:43', '2025-09-13 05:21:43'),
(404, 405, 11, '242510061', 0.00, 0, '2025-09-13 05:21:43', '2025-09-13 05:21:43'),
(405, 406, 11, '242510062', 0.00, 0, '2025-09-13 05:21:44', '2025-09-13 05:21:44'),
(406, 407, 11, '242510063', 0.00, 0, '2025-09-13 05:21:44', '2025-09-13 05:21:44'),
(407, 408, 11, '242510064', 0.00, 0, '2025-09-13 05:21:44', '2025-09-13 05:21:44'),
(408, 409, 12, '242510065', 0.00, 0, '2025-09-13 05:21:44', '2025-09-13 05:21:44'),
(409, 410, 12, '242510066', 0.00, 0, '2025-09-13 05:21:45', '2025-09-13 05:21:45'),
(410, 411, 12, '242510067', 0.00, 0, '2025-09-13 05:21:45', '2025-09-13 05:21:45'),
(411, 412, 12, '242510068', 0.00, 0, '2025-09-13 05:21:45', '2025-09-13 05:21:45'),
(412, 413, 12, '242510069', 0.00, 0, '2025-09-13 05:21:46', '2025-09-13 05:21:46'),
(413, 414, 12, '242510070', 0.00, 0, '2025-09-13 05:21:46', '2025-09-13 05:21:46'),
(414, 415, 12, '242510071', 0.00, 0, '2025-09-13 05:21:46', '2025-09-13 05:21:46'),
(415, 416, 12, '242510072', 0.00, 0, '2025-09-13 05:21:46', '2025-09-13 05:21:46'),
(416, 417, 12, '242510073', 0.00, 0, '2025-09-13 05:21:47', '2025-09-13 05:21:47'),
(417, 418, 12, '242510074', 0.00, 0, '2025-09-13 05:21:47', '2025-09-13 05:21:47'),
(418, 419, 12, '242510075', 0.00, 0, '2025-09-13 05:21:47', '2025-09-13 05:21:47'),
(419, 420, 12, '242510076', 0.00, 0, '2025-09-13 05:21:47', '2025-09-13 05:21:47'),
(420, 421, 12, '242510077', 0.00, 0, '2025-09-13 05:21:48', '2025-09-13 05:21:48'),
(421, 422, 12, '242510078', 0.00, 0, '2025-09-13 05:21:48', '2025-09-13 05:21:48'),
(422, 423, 12, '242510079', 0.00, 0, '2025-09-13 05:21:48', '2025-09-13 05:21:48'),
(423, 424, 12, '242510080', 0.00, 0, '2025-09-13 05:21:49', '2025-09-13 05:21:49'),
(424, 425, 12, '242510081', 0.00, 0, '2025-09-13 05:21:49', '2025-09-13 05:21:49'),
(425, 426, 12, '242510082', 0.00, 0, '2025-09-13 05:21:49', '2025-09-13 05:21:49'),
(426, 427, 12, '242510083', 0.00, 0, '2025-09-13 05:21:49', '2025-09-13 05:21:49'),
(427, 428, 12, '242510084', 0.00, 0, '2025-09-13 05:21:50', '2025-09-13 05:21:50'),
(428, 429, 12, '242510085', 0.00, 0, '2025-09-13 05:21:50', '2025-09-13 05:21:50'),
(429, 430, 12, '242510086', 0.00, 0, '2025-09-13 05:21:50', '2025-09-13 05:21:50'),
(430, 431, 12, '242510087', 0.00, 0, '2025-09-13 05:21:51', '2025-09-13 05:21:51'),
(431, 432, 12, '242510088', 0.00, 0, '2025-09-13 05:21:51', '2025-09-13 05:21:51'),
(432, 433, 12, '242510089', 0.00, 0, '2025-09-13 05:21:51', '2025-09-13 05:21:51'),
(433, 434, 12, '242510090', 0.00, 0, '2025-09-13 05:21:51', '2025-09-13 05:21:51'),
(434, 435, 12, '242510091', 0.00, 0, '2025-09-13 05:21:52', '2025-09-13 05:21:52'),
(435, 436, 12, '242510092', 0.00, 0, '2025-09-13 05:21:52', '2025-09-13 05:21:52'),
(436, 437, 12, '242510093', 0.00, 0, '2025-09-13 05:21:52', '2025-09-13 05:21:52'),
(437, 438, 12, '242510094', 0.00, 0, '2025-09-13 05:21:52', '2025-09-13 05:21:52'),
(438, 439, 12, '242510095', 0.00, 0, '2025-09-13 05:21:53', '2025-09-13 05:21:53'),
(439, 440, 12, '242510096', 0.00, 0, '2025-09-13 05:21:53', '2025-09-13 05:21:53'),
(440, 441, 13, '242510097', 0.00, 0, '2025-09-13 05:21:53', '2025-09-13 05:21:53'),
(441, 442, 13, '242510098', 0.00, 0, '2025-09-13 05:21:53', '2025-09-13 05:21:53'),
(442, 443, 13, '242510099', 0.00, 0, '2025-09-13 05:21:54', '2025-09-13 05:21:54'),
(443, 444, 13, '242510100', 0.00, 0, '2025-09-13 05:21:54', '2025-09-13 05:21:54'),
(444, 445, 13, '242510101', 0.00, 0, '2025-09-13 05:21:54', '2025-09-13 05:21:54'),
(445, 446, 13, '242510102', 0.00, 0, '2025-09-13 05:21:55', '2025-09-13 05:21:55'),
(446, 447, 13, '242510103', 0.00, 0, '2025-09-13 05:21:55', '2025-09-13 05:21:55'),
(447, 448, 13, '242510104', 0.00, 0, '2025-09-13 05:21:55', '2025-09-13 05:21:55'),
(448, 449, 13, '242510105', 0.00, 0, '2025-09-13 05:21:55', '2025-09-13 05:21:55'),
(449, 450, 13, '242510106', 0.00, 0, '2025-09-13 05:21:56', '2025-09-13 05:21:56'),
(450, 451, 13, '242510107', 0.00, 0, '2025-09-13 05:21:56', '2025-09-13 05:21:56'),
(451, 452, 13, '242510108', 0.00, 0, '2025-09-13 05:21:56', '2025-09-13 05:21:56'),
(452, 453, 13, '242510109', 0.00, 0, '2025-09-13 05:21:56', '2025-09-13 05:21:56'),
(453, 454, 13, '242510110', 0.00, 0, '2025-09-13 05:21:57', '2025-09-13 05:21:57'),
(454, 455, 13, '242510111', 0.00, 0, '2025-09-13 05:21:57', '2025-09-13 05:21:57'),
(455, 456, 13, '242510112', 0.00, 0, '2025-09-13 05:21:57', '2025-09-13 05:21:57'),
(456, 457, 13, '242510113', 0.00, 0, '2025-09-13 05:21:58', '2025-09-13 05:21:58'),
(457, 458, 13, '242510114', 0.00, 0, '2025-09-13 05:21:58', '2025-09-13 05:21:58'),
(458, 459, 13, '242510115', 0.00, 0, '2025-09-13 05:21:58', '2025-09-13 05:21:58'),
(459, 460, 13, '242510116', 0.00, 0, '2025-09-13 05:21:58', '2025-09-13 05:21:58'),
(460, 461, 13, '242510117', 0.00, 0, '2025-09-13 05:21:59', '2025-09-13 05:21:59'),
(461, 462, 13, '242510118', 0.00, 0, '2025-09-13 05:21:59', '2025-09-13 05:21:59'),
(462, 463, 13, '242510119', 0.00, 0, '2025-09-13 05:21:59', '2025-09-13 05:21:59'),
(463, 464, 13, '242510120', 0.00, 0, '2025-09-13 05:21:59', '2025-09-13 05:21:59'),
(464, 465, 13, '242510121', 0.00, 0, '2025-09-13 05:22:00', '2025-09-13 05:22:00'),
(465, 466, 13, '242510122', 0.00, 0, '2025-09-13 05:22:00', '2025-09-13 05:22:00'),
(466, 467, 13, '242510123', 0.00, 0, '2025-09-13 05:22:00', '2025-09-13 05:22:00'),
(467, 468, 13, '242510124', 0.00, 0, '2025-09-13 05:22:01', '2025-09-13 05:22:01'),
(468, 469, 14, '242510125', 0.00, 0, '2025-09-13 05:22:01', '2025-09-13 05:22:01'),
(469, 470, 14, '242510126', 0.00, 0, '2025-09-13 05:22:01', '2025-09-13 05:22:01'),
(470, 471, 14, '242510127', 0.00, 0, '2025-09-13 05:22:01', '2025-09-13 05:22:01'),
(471, 472, 14, '242510128', 0.00, 0, '2025-09-13 05:22:02', '2025-09-13 05:22:02'),
(472, 473, 14, '242510129', 0.00, 0, '2025-09-13 05:22:02', '2025-09-13 05:22:02'),
(473, 474, 14, '242510130', 0.00, 0, '2025-09-13 05:22:02', '2025-09-13 05:22:02'),
(474, 475, 14, '242510131', 0.00, 0, '2025-09-13 05:22:02', '2025-09-13 05:22:02'),
(475, 476, 14, '242510132', 0.00, 0, '2025-09-13 05:22:03', '2025-09-13 05:22:03'),
(476, 477, 14, '242510133', 0.00, 0, '2025-09-13 05:22:03', '2025-09-13 05:22:03'),
(477, 478, 14, '242510134', 0.00, 0, '2025-09-13 05:22:03', '2025-09-13 05:22:03'),
(478, 479, 14, '242510135', 0.00, 0, '2025-09-13 05:22:04', '2025-09-13 05:22:04'),
(479, 480, 14, '242510136', 0.00, 0, '2025-09-13 05:22:04', '2025-09-13 05:22:04'),
(480, 481, 14, '242510137', 0.00, 0, '2025-09-13 05:22:04', '2025-09-13 05:22:04'),
(481, 482, 14, '242510138', 0.00, 0, '2025-09-13 05:22:04', '2025-09-13 05:22:04'),
(482, 483, 14, '242510139', 0.00, 0, '2025-09-13 05:22:05', '2025-09-13 05:22:05'),
(483, 484, 14, '242510140', 0.00, 0, '2025-09-13 05:22:05', '2025-09-13 05:22:05'),
(484, 485, 14, '242510141', 0.00, 0, '2025-09-13 05:22:05', '2025-09-13 05:22:05'),
(485, 486, 14, '242510142', 0.00, 0, '2025-09-13 05:22:05', '2025-09-13 05:22:05'),
(486, 487, 14, '242510143', 0.00, 0, '2025-09-13 05:22:06', '2025-09-13 05:22:06'),
(487, 488, 14, '242510144', 0.00, 0, '2025-09-13 05:22:06', '2025-09-13 05:22:06'),
(488, 489, 14, '242510145', 0.00, 0, '2025-09-13 05:22:06', '2025-09-13 05:22:06'),
(489, 490, 14, '242510146', 0.00, 0, '2025-09-13 05:22:07', '2025-09-13 05:22:07'),
(490, 491, 14, '242510147', 0.00, 0, '2025-09-13 05:22:07', '2025-09-13 05:22:07'),
(491, 492, 14, '242510148', 0.00, 0, '2025-09-13 05:22:07', '2025-09-13 05:22:07'),
(492, 493, 14, '242510149', 0.00, 0, '2025-09-13 05:22:07', '2025-09-13 05:22:07'),
(493, 494, 14, '242510150', 0.00, 0, '2025-09-13 05:22:08', '2025-09-13 05:22:08'),
(494, 495, 14, '242510151', 0.00, 0, '2025-09-13 05:22:08', '2025-09-13 05:22:08'),
(495, 496, 14, '242510152', 0.00, 0, '2025-09-13 05:22:08', '2025-09-13 05:22:08'),
(496, 497, 15, '242510153', 0.00, 0, '2025-09-13 05:22:08', '2025-09-13 05:22:08'),
(497, 498, 15, '242510154', 0.00, 0, '2025-09-13 05:22:09', '2025-09-13 05:22:09'),
(498, 499, 15, '242510155', 0.00, 0, '2025-09-13 05:22:09', '2025-09-13 05:22:09'),
(499, 500, 15, '242510156', 0.00, 0, '2025-09-13 05:22:09', '2025-09-13 05:22:09'),
(500, 501, 15, '242510157', 0.00, 0, '2025-09-13 05:22:10', '2025-09-13 05:22:10'),
(501, 502, 15, '242510158', 0.00, 0, '2025-09-13 05:22:10', '2025-09-13 05:22:10'),
(502, 503, 15, '242510159', 0.00, 0, '2025-09-13 05:22:10', '2025-09-13 05:22:10'),
(503, 504, 15, '242510160', 0.00, 0, '2025-09-13 05:22:10', '2025-09-13 05:22:10'),
(504, 505, 15, '242510161', 0.00, 0, '2025-09-13 05:22:11', '2025-09-13 05:22:11'),
(505, 506, 15, '242510162', 0.00, 0, '2025-09-13 05:22:11', '2025-09-13 05:22:11'),
(506, 507, 15, '242510163', 0.00, 0, '2025-09-13 05:22:11', '2025-09-13 05:22:11'),
(507, 508, 15, '242510164', 0.00, 0, '2025-09-13 05:22:12', '2025-09-13 05:22:12'),
(508, 509, 15, '242510165', 0.00, 0, '2025-09-13 05:22:12', '2025-09-13 05:22:12'),
(509, 510, 15, '242510166', 0.00, 0, '2025-09-13 05:22:12', '2025-09-13 05:22:12'),
(510, 511, 15, '242510167', 0.00, 0, '2025-09-13 05:22:12', '2025-09-13 05:22:12'),
(511, 512, 15, '242510168', 0.00, 0, '2025-09-13 05:22:13', '2025-09-13 05:22:13'),
(512, 513, 15, '242510169', 0.00, 0, '2025-09-13 05:22:13', '2025-09-13 05:22:13'),
(513, 514, 15, '242510170', 0.00, 0, '2025-09-13 05:22:13', '2025-09-13 05:22:13'),
(514, 515, 15, '242510171', 0.00, 0, '2025-09-13 05:22:14', '2025-09-13 05:22:14'),
(515, 516, 15, '242510172', 0.00, 0, '2025-09-13 05:22:14', '2025-09-13 05:22:14'),
(516, 517, 15, '242510173', 0.00, 0, '2025-09-13 05:22:14', '2025-09-13 05:22:14'),
(517, 518, 15, '242510174', 0.00, 0, '2025-09-13 05:22:14', '2025-09-13 05:22:14'),
(518, 519, 15, '242510175', 0.00, 0, '2025-09-13 05:22:15', '2025-09-13 05:22:15'),
(519, 520, 15, '242510176', 0.00, 0, '2025-09-13 05:22:15', '2025-09-13 05:22:15'),
(520, 521, 15, '242510177', 0.00, 0, '2025-09-13 05:22:15', '2025-09-13 05:22:15'),
(521, 522, 15, '242510178', 0.00, 0, '2025-09-13 05:22:15', '2025-09-13 05:22:15'),
(522, 523, 16, '242510179', 0.00, 0, '2025-09-13 05:22:16', '2025-09-13 05:22:16'),
(523, 524, 16, '242510180', 0.00, 0, '2025-09-13 05:22:16', '2025-09-13 05:22:16'),
(524, 525, 16, '242510181', 0.00, 0, '2025-09-13 05:22:16', '2025-09-13 05:22:16'),
(525, 526, 16, '242510182', 0.00, 0, '2025-09-13 05:22:16', '2025-09-13 05:22:16'),
(526, 527, 16, '242510183', 0.00, 0, '2025-09-13 05:22:17', '2025-09-13 05:22:17'),
(527, 528, 16, '242510184', 0.00, 0, '2025-09-13 05:22:17', '2025-09-13 05:22:17'),
(528, 529, 16, '242510185', 0.00, 0, '2025-09-13 05:22:17', '2025-09-13 05:22:17'),
(529, 530, 16, '242510186', 0.00, 0, '2025-09-13 05:22:18', '2025-09-13 05:22:18'),
(530, 531, 16, '242510187', 0.00, 0, '2025-09-13 05:22:18', '2025-09-13 05:22:18'),
(531, 532, 16, '242510188', 0.00, 0, '2025-09-13 05:22:18', '2025-09-13 05:22:18'),
(532, 533, 16, '242510189', 0.00, 0, '2025-09-13 05:22:18', '2025-09-13 05:22:18'),
(533, 534, 16, '242510190', 0.00, 0, '2025-09-13 05:22:19', '2025-09-13 05:22:19'),
(534, 535, 16, '242510191', 0.00, 0, '2025-09-13 05:22:19', '2025-09-13 05:22:19'),
(535, 536, 16, '242510192', 0.00, 0, '2025-09-13 05:22:19', '2025-09-13 05:22:19'),
(536, 537, 16, '242510193', 0.00, 0, '2025-09-13 05:22:19', '2025-09-13 05:22:19'),
(537, 538, 16, '242510194', 0.00, 0, '2025-09-13 05:22:20', '2025-09-13 05:22:20'),
(538, 539, 16, '242510195', 0.00, 0, '2025-09-13 05:22:20', '2025-09-13 05:22:20'),
(539, 540, 16, '242510196', 0.00, 0, '2025-09-13 05:22:20', '2025-09-13 05:22:20'),
(540, 541, 16, '242510197', 0.00, 0, '2025-09-13 05:22:21', '2025-09-13 05:22:21'),
(541, 542, 16, '242510198', 0.00, 0, '2025-09-13 05:22:21', '2025-09-13 05:22:21'),
(542, 543, 16, '242510199', 0.00, 0, '2025-09-13 05:22:21', '2025-09-13 05:22:21'),
(543, 544, 8, '252610200', 0.00, 0, '2025-09-13 05:22:30', '2025-09-13 05:22:30'),
(544, 545, 8, '252610201', 0.00, 0, '2025-09-13 05:22:30', '2025-09-13 05:22:30'),
(545, 546, 8, '252610202', 0.00, 0, '2025-09-13 05:22:31', '2025-09-13 05:22:31'),
(546, 547, 8, '252610203', 0.00, 0, '2025-09-13 05:22:31', '2025-09-13 05:22:31'),
(547, 548, 8, '252610204', 0.00, 0, '2025-09-13 05:22:31', '2025-09-13 05:22:31'),
(548, 549, 8, '252610205', 0.00, 0, '2025-09-13 05:22:31', '2025-09-13 05:22:31'),
(549, 550, 8, '252610206', 0.00, 0, '2025-09-13 05:22:32', '2025-09-13 05:22:32'),
(550, 551, 8, '252610207', 0.00, 0, '2025-09-13 05:22:32', '2025-09-13 05:22:32'),
(551, 552, 8, '252610208', 0.00, 0, '2025-09-13 05:22:32', '2025-09-13 05:22:32'),
(552, 553, 8, '252610209', 0.00, 0, '2025-09-13 05:22:32', '2025-09-13 05:22:32'),
(553, 554, 8, '252610210', 0.00, 0, '2025-09-13 05:22:33', '2025-09-13 05:22:33'),
(554, 555, 8, '252610211', 0.00, 0, '2025-09-13 05:22:33', '2025-09-13 05:22:33'),
(555, 556, 8, '252610212', 0.00, 0, '2025-09-13 05:22:33', '2025-09-13 05:22:33'),
(556, 557, 8, '252610213', 0.00, 0, '2025-09-13 05:22:33', '2025-09-13 05:22:33'),
(557, 558, 8, '252610214', 0.00, 0, '2025-09-13 05:22:34', '2025-09-13 05:22:34'),
(558, 559, 8, '252610215', 0.00, 0, '2025-09-13 05:22:34', '2025-09-13 05:22:34'),
(559, 560, 8, '252610216', 0.00, 0, '2025-09-13 05:22:34', '2025-09-13 05:22:34'),
(560, 561, 8, '252610217', 0.00, 0, '2025-09-13 05:22:35', '2025-09-13 05:22:35'),
(561, 562, 8, '252610218', 0.00, 0, '2025-09-13 05:22:35', '2025-09-13 05:22:35'),
(562, 563, 8, '252610219', 0.00, 0, '2025-09-13 05:22:35', '2025-09-13 05:22:35'),
(563, 564, 8, '252610220', 0.00, 0, '2025-09-13 05:22:35', '2025-09-13 05:22:35'),
(564, 565, 8, '252610221', 0.00, 0, '2025-09-13 05:22:36', '2025-09-13 05:22:36'),
(565, 566, 8, '252610222', 0.00, 0, '2025-09-13 05:22:36', '2025-09-13 05:22:36'),
(566, 567, 8, '252610223', 0.00, 0, '2025-09-13 05:22:36', '2025-09-13 05:22:36'),
(567, 568, 8, '252610224', 0.00, 0, '2025-09-13 05:22:36', '2025-09-13 05:22:36'),
(568, 569, 8, '252610225', 0.00, 0, '2025-09-13 05:22:37', '2025-09-13 05:22:37'),
(569, 570, 8, '252610226', 0.00, 0, '2025-09-13 05:22:37', '2025-09-13 05:22:37'),
(570, 571, 8, '252610227', 0.00, 0, '2025-09-13 05:22:37', '2025-09-13 05:22:37'),
(571, 572, 8, '252610228', 0.00, 0, '2025-09-13 05:22:37', '2025-09-13 05:22:37'),
(572, 573, 9, '252610229', 0.00, 0, '2025-09-13 05:22:38', '2025-09-13 05:22:38'),
(573, 574, 9, '252610230', 0.00, 0, '2025-09-13 05:22:38', '2025-09-13 05:22:38'),
(574, 575, 9, '252610231', 0.00, 0, '2025-09-13 05:22:38', '2025-09-13 05:22:38'),
(575, 576, 9, '252610232', 0.00, 0, '2025-09-13 05:22:39', '2025-09-13 05:22:39'),
(576, 577, 9, '252610233', 0.00, 0, '2025-09-13 05:22:39', '2025-09-13 05:22:39'),
(577, 578, 9, '252610234', 0.00, 0, '2025-09-13 05:22:39', '2025-09-13 05:22:39'),
(578, 579, 9, '252610235', 0.00, 0, '2025-09-13 05:22:39', '2025-09-13 05:22:39'),
(579, 580, 9, '252610236', 0.00, 0, '2025-09-13 05:22:40', '2025-09-13 05:22:40'),
(580, 581, 9, '252610237', 0.00, 0, '2025-09-13 05:22:40', '2025-09-13 05:22:40'),
(581, 582, 9, '252610238', 0.00, 0, '2025-09-13 05:22:40', '2025-09-13 05:22:40'),
(582, 583, 9, '252610239', 0.00, 0, '2025-09-13 05:22:40', '2025-09-13 05:22:40'),
(583, 584, 9, '252610240', 0.00, 0, '2025-09-13 05:22:41', '2025-09-13 05:22:41'),
(584, 585, 9, '252610241', 0.00, 0, '2025-09-13 05:22:41', '2025-09-13 05:22:41'),
(585, 586, 9, '252610242', 0.00, 0, '2025-09-13 05:22:41', '2025-09-13 05:22:41'),
(586, 587, 9, '252610243', 0.00, 0, '2025-09-13 05:22:41', '2025-09-13 05:22:41'),
(587, 588, 9, '252610244', 0.00, 0, '2025-09-13 05:22:42', '2025-09-13 05:22:42'),
(588, 589, 9, '252610245', 0.00, 0, '2025-09-13 05:22:42', '2025-09-13 05:22:42'),
(589, 590, 9, '252610246', 0.00, 0, '2025-09-13 05:22:42', '2025-09-13 05:22:42'),
(590, 591, 9, '252610247', 0.00, 0, '2025-09-13 05:22:43', '2025-09-13 05:22:43'),
(591, 592, 9, '252610248', 0.00, 0, '2025-09-13 05:22:43', '2025-09-13 05:22:43'),
(592, 593, 9, '252610249', 0.00, 0, '2025-09-13 05:22:43', '2025-09-13 05:22:43'),
(593, 594, 9, '252610250', 0.00, 0, '2025-09-13 05:22:43', '2025-09-13 05:22:43'),
(594, 595, 9, '252610251', 0.00, 0, '2025-09-13 05:22:44', '2025-09-13 05:22:44'),
(595, 596, 9, '252610252', 0.00, 0, '2025-09-13 05:22:44', '2025-09-13 05:22:44'),
(596, 597, 9, '252610253', 0.00, 0, '2025-09-13 05:22:44', '2025-09-13 05:22:44'),
(597, 598, 9, '252610254', 0.00, 0, '2025-09-13 05:22:44', '2025-09-13 05:22:44'),
(598, 599, 9, '252610255', 0.00, 0, '2025-09-13 05:22:45', '2025-09-13 05:22:45'),
(599, 600, 9, '252610256', 0.00, 0, '2025-09-13 05:22:45', '2025-09-13 05:22:45'),
(600, 601, 9, '252610257', 0.00, 0, '2025-09-13 05:22:45', '2025-09-13 05:22:45'),
(601, 602, 9, '252610258', 0.00, 0, '2025-09-13 05:22:46', '2025-09-13 05:22:46'),
(602, 603, 9, '252610259', 0.00, 0, '2025-09-13 05:22:46', '2025-09-13 05:22:46'),
(603, 604, 9, '252610260', 0.00, 0, '2025-09-13 05:22:46', '2025-09-13 05:22:46'),
(604, 605, 9, '252610261', 0.00, 0, '2025-09-13 05:22:46', '2025-09-13 05:22:46'),
(605, 606, 9, '252610262', 0.00, 0, '2025-09-13 05:22:47', '2025-09-13 05:22:47'),
(606, 607, 9, '252610263', 0.00, 0, '2025-09-13 05:22:47', '2025-09-13 05:22:47'),
(607, 608, 2, '252610001', 0.00, 0, '2025-09-13 05:22:57', '2025-09-13 05:22:57'),
(608, 609, 2, '252610002', 0.00, 0, '2025-09-13 05:22:57', '2025-09-13 05:22:57'),
(609, 610, 2, '252610003', 0.00, 0, '2025-09-13 05:22:57', '2025-09-13 05:22:57'),
(610, 611, 2, '252610004', 0.00, 0, '2025-09-13 05:22:58', '2025-09-13 05:22:58'),
(611, 612, 2, '252610005', 0.00, 0, '2025-09-13 05:22:58', '2025-09-13 05:22:58');
INSERT INTO `siswa` (`id`, `id_pengguna`, `id_kelas`, `nis`, `saldo`, `points`, `created_at`, `updated_at`) VALUES
(612, 613, 2, '252610006', 0.00, 0, '2025-09-13 05:22:58', '2025-09-13 05:22:58'),
(613, 614, 2, '252610007', 0.00, 0, '2025-09-13 05:22:59', '2025-09-13 05:22:59'),
(614, 615, 2, '252610008', 0.00, 0, '2025-09-13 05:22:59', '2025-09-13 05:22:59'),
(615, 616, 2, '252610009', 0.00, 0, '2025-09-13 05:22:59', '2025-09-13 05:22:59'),
(616, 617, 2, '252610010', 0.00, 0, '2025-09-13 05:22:59', '2025-09-13 05:22:59'),
(617, 618, 2, '252610011', 0.00, 0, '2025-09-13 05:23:00', '2025-09-13 05:23:00'),
(618, 619, 2, '252610012', 0.00, 0, '2025-09-13 05:23:00', '2025-09-13 05:23:00'),
(619, 620, 2, '252610013', 0.00, 0, '2025-09-13 05:23:00', '2025-09-13 05:23:00'),
(620, 621, 2, '252610014', 0.00, 0, '2025-09-13 05:23:00', '2025-09-13 05:23:00'),
(621, 622, 2, '252610015', 0.00, 0, '2025-09-13 05:23:01', '2025-09-13 05:23:01'),
(622, 623, 2, '252610016', 0.00, 0, '2025-09-13 05:23:01', '2025-09-13 05:23:01'),
(623, 624, 2, '252610017', 0.00, 0, '2025-09-13 05:23:01', '2025-09-13 05:23:01'),
(624, 625, 2, '252610018', 0.00, 0, '2025-09-13 05:23:02', '2025-09-13 05:23:02'),
(625, 626, 2, '252610019', 0.00, 0, '2025-09-13 05:23:02', '2025-09-13 05:23:02'),
(626, 627, 2, '252610020', 0.00, 0, '2025-09-13 05:23:02', '2025-09-13 05:23:02'),
(627, 628, 2, '252610021', 0.00, 0, '2025-09-13 05:23:02', '2025-09-13 05:23:02'),
(628, 629, 2, '252610022', 0.00, 0, '2025-09-13 05:23:03', '2025-09-13 05:23:03'),
(629, 630, 2, '252610023', 0.00, 0, '2025-09-13 05:23:03', '2025-09-13 05:23:03'),
(630, 631, 2, '252610024', 0.00, 0, '2025-09-13 05:23:03', '2025-09-13 05:23:03'),
(631, 632, 2, '252610025', 0.00, 0, '2025-09-13 05:23:03', '2025-09-13 05:23:03'),
(632, 633, 2, '252610026', 0.00, 0, '2025-09-13 05:23:04', '2025-09-13 05:23:04'),
(633, 634, 2, '252610027', 0.00, 0, '2025-09-13 05:23:04', '2025-09-13 05:23:04'),
(634, 635, 3, '252610028', 0.00, 0, '2025-09-13 05:23:04', '2025-09-13 05:23:04'),
(635, 636, 3, '252610029', 0.00, 0, '2025-09-13 05:23:05', '2025-09-13 05:23:05'),
(636, 637, 3, '252610030', 0.00, 0, '2025-09-13 05:23:05', '2025-09-13 05:23:05'),
(637, 638, 3, '252610031', 0.00, 0, '2025-09-13 05:23:05', '2025-09-13 05:23:05'),
(638, 639, 3, '252610032', 0.00, 0, '2025-09-13 05:23:05', '2025-09-13 05:23:05'),
(639, 640, 3, '252610033', 0.00, 0, '2025-09-13 05:23:06', '2025-09-13 05:23:06'),
(640, 641, 3, '252610034', 0.00, 0, '2025-09-13 05:23:06', '2025-09-13 05:23:06'),
(641, 642, 3, '252610035', 0.00, 0, '2025-09-13 05:23:06', '2025-09-13 05:23:06'),
(642, 643, 3, '252610036', 0.00, 0, '2025-09-13 05:23:06', '2025-09-13 05:23:06'),
(643, 644, 3, '252610037', 0.00, 0, '2025-09-13 05:23:07', '2025-09-13 05:23:07'),
(644, 645, 3, '252610038', 0.00, 0, '2025-09-13 05:23:07', '2025-09-13 05:23:07'),
(645, 646, 3, '252610039', 0.00, 0, '2025-09-13 05:23:07', '2025-09-13 05:23:07'),
(646, 647, 3, '252610040', 0.00, 0, '2025-09-13 05:23:07', '2025-09-13 05:23:07'),
(647, 648, 3, '252610041', 0.00, 0, '2025-09-13 05:23:08', '2025-09-13 05:23:08'),
(648, 649, 3, '252610042', 0.00, 0, '2025-09-13 05:23:08', '2025-09-13 05:23:08'),
(649, 650, 3, '252610043', 0.00, 0, '2025-09-13 05:23:08', '2025-09-13 05:23:08'),
(650, 651, 3, '252610044', 0.00, 0, '2025-09-13 05:23:09', '2025-09-13 05:23:09'),
(651, 652, 3, '252610045', 0.00, 0, '2025-09-13 05:23:09', '2025-09-13 05:23:09'),
(652, 653, 3, '252610046', 0.00, 0, '2025-09-13 05:23:09', '2025-09-13 05:23:09'),
(653, 654, 3, '252610047', 0.00, 0, '2025-09-13 05:23:09', '2025-09-13 05:23:09'),
(654, 655, 3, '252610048', 0.00, 0, '2025-09-13 05:23:10', '2025-09-13 05:23:10'),
(655, 656, 3, '252610049', 0.00, 0, '2025-09-13 05:23:10', '2025-09-13 05:23:10'),
(656, 657, 3, '252610050', 0.00, 0, '2025-09-13 05:23:10', '2025-09-13 05:23:10'),
(657, 658, 3, '252610051', 0.00, 0, '2025-09-13 05:23:10', '2025-09-13 05:23:10'),
(658, 659, 3, '252610052', 0.00, 0, '2025-09-13 05:23:11', '2025-09-13 05:23:11'),
(659, 660, 3, '252610053', 0.00, 0, '2025-09-13 05:23:11', '2025-09-13 05:23:11'),
(660, 661, 3, '252610054', 0.00, 0, '2025-09-13 05:23:11', '2025-09-13 05:23:11'),
(661, 662, 3, '252610055', 0.00, 0, '2025-09-13 05:23:12', '2025-09-13 05:23:12'),
(662, 663, 3, '252610056', 0.00, 0, '2025-09-13 05:23:12', '2025-09-13 05:23:12'),
(663, 664, 4, '252610057', 0.00, 0, '2025-09-13 05:23:12', '2025-09-13 05:23:12'),
(664, 665, 4, '252610058', 0.00, 0, '2025-09-13 05:23:12', '2025-09-13 05:23:12'),
(665, 666, 4, '252610059', 0.00, 0, '2025-09-13 05:23:13', '2025-09-13 05:23:13'),
(666, 667, 4, '252610060', 0.00, 0, '2025-09-13 05:23:13', '2025-09-13 05:23:13'),
(667, 668, 4, '252610061', 0.00, 0, '2025-09-13 05:23:13', '2025-09-13 05:23:13'),
(668, 669, 4, '252610062', 0.00, 0, '2025-09-13 05:23:13', '2025-09-13 05:23:13'),
(669, 670, 4, '252610063', 0.00, 0, '2025-09-13 05:23:14', '2025-09-13 05:23:14'),
(670, 671, 4, '252610064', 0.00, 0, '2025-09-13 05:23:14', '2025-09-13 05:23:14'),
(671, 672, 4, '252610065', 0.00, 0, '2025-09-13 05:23:14', '2025-09-13 05:23:14'),
(672, 673, 4, '252610066', 0.00, 0, '2025-09-13 05:23:15', '2025-09-13 05:23:15'),
(673, 674, 4, '252610067', 0.00, 0, '2025-09-13 05:23:15', '2025-09-13 05:23:15'),
(674, 675, 4, '252610068', 0.00, 0, '2025-09-13 05:23:15', '2025-09-13 05:23:15'),
(675, 676, 4, '252610069', 0.00, 0, '2025-09-13 05:23:15', '2025-09-13 05:23:15'),
(676, 677, 4, '252610070', 0.00, 0, '2025-09-13 05:23:16', '2025-09-13 05:23:16'),
(677, 678, 4, '252610071', 0.00, 0, '2025-09-13 05:23:16', '2025-09-13 05:23:16'),
(678, 679, 4, '252610072', 0.00, 0, '2025-09-13 05:23:16', '2025-09-13 05:23:16'),
(679, 680, 4, '252610073', 0.00, 0, '2025-09-13 05:23:16', '2025-09-13 05:23:16'),
(680, 681, 4, '252610074', 0.00, 0, '2025-09-13 05:23:17', '2025-09-13 05:23:17'),
(681, 682, 4, '252610075', 0.00, 0, '2025-09-13 05:23:17', '2025-09-13 05:23:17'),
(682, 683, 4, '252610076', 0.00, 0, '2025-09-13 05:23:17', '2025-09-13 05:23:17'),
(683, 684, 4, '252610077', 0.00, 0, '2025-09-13 05:23:18', '2025-09-13 05:23:18'),
(684, 685, 4, '252610078', 0.00, 0, '2025-09-13 05:23:18', '2025-09-13 05:23:18'),
(685, 686, 4, '252610079', 0.00, 0, '2025-09-13 05:23:18', '2025-09-13 05:23:18'),
(686, 687, 4, '252610080', 0.00, 0, '2025-09-13 05:23:18', '2025-09-13 05:23:18'),
(687, 688, 4, '252610081', 0.00, 0, '2025-09-13 05:23:19', '2025-09-13 05:23:19'),
(688, 689, 4, '252610082', 0.00, 0, '2025-09-13 05:23:19', '2025-09-13 05:23:19'),
(689, 690, 4, '252610083', 0.00, 0, '2025-09-13 05:23:19', '2025-09-13 05:23:19'),
(690, 691, 4, '252610084', 0.00, 0, '2025-09-13 05:23:19', '2025-09-13 05:23:19'),
(691, 692, 4, '252610085', 0.00, 0, '2025-09-13 05:23:20', '2025-09-13 05:23:20'),
(692, 693, 4, '252610086', 0.00, 0, '2025-09-13 05:23:20', '2025-09-13 05:23:20'),
(693, 694, 4, '252610087', 0.00, 0, '2025-09-13 05:23:20', '2025-09-13 05:23:20'),
(694, 695, 4, '252610088', 0.00, 0, '2025-09-13 05:23:21', '2025-09-13 05:23:21'),
(695, 696, 4, '252610089', 0.00, 0, '2025-09-13 05:23:21', '2025-09-13 05:23:21'),
(696, 697, 4, '252610090', 0.00, 0, '2025-09-13 05:23:21', '2025-09-13 05:23:21'),
(697, 698, 5, '252610091', 0.00, 0, '2025-09-13 05:23:21', '2025-09-13 05:23:21'),
(698, 699, 5, '252610092', 0.00, 0, '2025-09-13 05:23:22', '2025-09-13 05:23:22'),
(699, 700, 5, '252610093', 0.00, 0, '2025-09-13 05:23:22', '2025-09-13 05:23:22'),
(700, 701, 5, '252610094', 0.00, 0, '2025-09-13 05:23:22', '2025-09-13 05:23:22'),
(701, 702, 5, '252610095', 0.00, 0, '2025-09-13 05:23:22', '2025-09-13 05:23:22'),
(702, 703, 5, '252610096', 0.00, 0, '2025-09-13 05:23:23', '2025-09-13 05:23:23'),
(703, 704, 5, '252610097', 0.00, 0, '2025-09-13 05:23:23', '2025-09-13 05:23:23'),
(704, 705, 5, '252610098', 0.00, 0, '2025-09-13 05:23:23', '2025-09-13 05:23:23'),
(705, 706, 5, '252610099', 0.00, 0, '2025-09-13 05:23:24', '2025-09-13 05:23:24'),
(706, 707, 5, '252610100', 0.00, 0, '2025-09-13 05:23:24', '2025-09-13 05:23:24'),
(707, 708, 5, '252610101', 0.00, 0, '2025-09-13 05:23:24', '2025-09-13 05:23:24'),
(708, 709, 5, '252610102', 0.00, 0, '2025-09-13 05:23:24', '2025-09-13 05:23:24'),
(709, 710, 5, '252610103', 0.00, 0, '2025-09-13 05:23:25', '2025-09-13 05:23:25'),
(710, 711, 5, '252610104', 0.00, 0, '2025-09-13 05:23:25', '2025-09-13 05:23:25'),
(711, 712, 5, '252610105', 0.00, 0, '2025-09-13 05:23:25', '2025-09-13 05:23:25'),
(712, 713, 5, '252610106', 0.00, 0, '2025-09-13 05:23:26', '2025-09-13 05:23:26'),
(713, 714, 5, '252610107', 0.00, 0, '2025-09-13 05:23:26', '2025-09-13 05:23:26'),
(714, 715, 5, '252610108', 0.00, 0, '2025-09-13 05:23:26', '2025-09-13 05:23:26'),
(715, 716, 5, '252610109', 0.00, 0, '2025-09-13 05:23:26', '2025-09-13 05:23:26'),
(716, 717, 5, '252610110', 0.00, 0, '2025-09-13 05:23:27', '2025-09-13 05:23:27'),
(717, 718, 5, '252610111', 0.00, 0, '2025-09-13 05:23:27', '2025-09-13 05:23:27'),
(718, 719, 5, '252610112', 0.00, 0, '2025-09-13 05:23:27', '2025-09-13 05:23:27'),
(719, 720, 5, '252610113', 0.00, 0, '2025-09-13 05:23:27', '2025-09-13 05:23:27'),
(720, 721, 5, '252610114', 0.00, 0, '2025-09-13 05:23:28', '2025-09-13 05:23:28'),
(721, 722, 5, '252610115', 0.00, 0, '2025-09-13 05:23:28', '2025-09-13 05:23:28'),
(722, 723, 5, '252610116', 0.00, 0, '2025-09-13 05:23:28', '2025-09-13 05:23:28'),
(723, 724, 5, '252610117', 0.00, 0, '2025-09-13 05:23:29', '2025-09-13 05:23:29'),
(724, 725, 5, '252610118', 0.00, 0, '2025-09-13 05:23:29', '2025-09-13 05:23:29'),
(725, 726, 5, '252610119', 0.00, 0, '2025-09-13 05:23:29', '2025-09-13 05:23:29'),
(726, 727, 5, '252610120', 0.00, 0, '2025-09-13 05:23:29', '2025-09-13 05:23:29'),
(727, 728, 5, '252610121', 0.00, 0, '2025-09-13 05:23:30', '2025-09-13 05:23:30'),
(728, 729, 5, '252610122', 0.00, 0, '2025-09-13 05:23:30', '2025-09-13 05:23:30'),
(729, 730, 5, '252610123', 0.00, 0, '2025-09-13 05:23:30', '2025-09-13 05:23:30'),
(730, 731, 5, '252610124', 0.00, 0, '2025-09-13 05:23:30', '2025-09-13 05:23:30'),
(731, 732, 5, '252610125', 0.00, 0, '2025-09-13 05:23:31', '2025-09-13 05:23:31'),
(732, 733, 6, '252610126', 0.00, 0, '2025-09-13 05:23:31', '2025-09-13 05:23:31'),
(733, 734, 6, '252610127', 0.00, 0, '2025-09-13 05:23:31', '2025-09-13 05:23:31'),
(734, 735, 6, '252610128', 0.00, 0, '2025-09-13 05:23:32', '2025-09-13 05:23:32'),
(735, 736, 6, '252610129', 0.00, 0, '2025-09-13 05:23:32', '2025-09-13 05:23:32'),
(736, 737, 6, '252610130', 0.00, 0, '2025-09-13 05:23:32', '2025-09-13 05:23:32'),
(737, 738, 6, '252610131', 0.00, 0, '2025-09-13 05:23:32', '2025-09-13 05:23:32'),
(738, 739, 6, '252610132', 0.00, 0, '2025-09-13 05:23:33', '2025-09-13 05:23:33'),
(739, 740, 6, '252610133', 0.00, 0, '2025-09-13 05:23:33', '2025-09-13 05:23:33'),
(740, 741, 6, '252610134', 0.00, 0, '2025-09-13 05:23:33', '2025-09-13 05:23:33'),
(741, 742, 6, '252610135', 0.00, 0, '2025-09-13 05:23:33', '2025-09-13 05:23:33'),
(742, 743, 6, '252610136', 0.00, 0, '2025-09-13 05:23:34', '2025-09-13 05:23:34'),
(743, 744, 6, '252610137', 0.00, 0, '2025-09-13 05:23:34', '2025-09-13 05:23:34'),
(744, 745, 6, '252610138', 0.00, 0, '2025-09-13 05:23:34', '2025-09-13 05:23:34'),
(745, 746, 6, '252610139', 0.00, 0, '2025-09-13 05:23:35', '2025-09-13 05:23:35'),
(746, 747, 6, '252610140', 0.00, 0, '2025-09-13 05:23:35', '2025-09-13 05:23:35'),
(747, 748, 6, '252610141', 0.00, 0, '2025-09-13 05:23:35', '2025-09-13 05:23:35'),
(748, 749, 6, '252610142', 0.00, 0, '2025-09-13 05:23:35', '2025-09-13 05:23:35'),
(749, 750, 6, '252610143', 0.00, 0, '2025-09-13 05:23:36', '2025-09-13 05:23:36'),
(750, 751, 6, '252610144', 0.00, 0, '2025-09-13 05:23:36', '2025-09-13 05:23:36'),
(751, 752, 6, '252610145', 0.00, 0, '2025-09-13 05:23:36', '2025-09-13 05:23:36'),
(752, 753, 6, '252610146', 0.00, 0, '2025-09-13 05:23:36', '2025-09-13 05:23:36'),
(753, 754, 6, '252610147', 0.00, 0, '2025-09-13 05:23:37', '2025-09-13 05:23:37'),
(754, 755, 6, '252610148', 0.00, 0, '2025-09-13 05:23:37', '2025-09-13 05:23:37'),
(755, 756, 6, '252610149', 0.00, 0, '2025-09-13 05:23:37', '2025-09-13 05:23:37'),
(756, 757, 6, '252610150', 0.00, 0, '2025-09-13 05:23:38', '2025-09-13 05:23:38'),
(757, 758, 6, '252610151', 0.00, 0, '2025-09-13 05:23:38', '2025-09-13 05:23:38'),
(758, 759, 6, '252610152', 0.00, 0, '2025-09-13 05:23:38', '2025-09-13 05:23:38'),
(759, 760, 6, '252610153', 0.00, 0, '2025-09-13 05:23:38', '2025-09-13 05:23:38'),
(760, 761, 6, '252610154', 0.00, 0, '2025-09-13 05:23:39', '2025-09-13 05:23:39'),
(761, 762, 6, '252610155', 0.00, 0, '2025-09-13 05:23:39', '2025-09-13 05:23:39'),
(762, 763, 6, '252610156', 0.00, 0, '2025-09-13 05:23:39', '2025-09-13 05:23:39'),
(763, 764, 6, '252610157', 0.00, 0, '2025-09-13 05:23:39', '2025-09-13 05:23:39'),
(764, 765, 6, '252610158', 0.00, 0, '2025-09-13 05:23:40', '2025-09-13 05:23:40'),
(765, 766, 6, '252610159', 0.00, 0, '2025-09-13 05:23:40', '2025-09-13 05:23:40'),
(766, 767, 7, '252610160', 0.00, 0, '2025-09-13 05:23:40', '2025-09-13 05:23:40'),
(767, 768, 7, '252610161', 0.00, 0, '2025-09-13 05:23:41', '2025-09-13 05:23:41'),
(768, 769, 7, '252610162', 0.00, 0, '2025-09-13 05:23:41', '2025-09-13 05:23:41'),
(769, 770, 7, '252610163', 0.00, 0, '2025-09-13 05:23:41', '2025-09-13 05:23:41'),
(770, 771, 7, '252610164', 0.00, 0, '2025-09-13 05:23:41', '2025-09-13 05:23:41'),
(771, 772, 7, '252610165', 0.00, 0, '2025-09-13 05:23:42', '2025-09-13 05:23:42'),
(772, 773, 7, '252610166', 0.00, 0, '2025-09-13 05:23:42', '2025-09-13 05:23:42'),
(773, 774, 7, '252610167', 0.00, 0, '2025-09-13 05:23:42', '2025-09-13 05:23:42'),
(774, 775, 7, '252610168', 0.00, 0, '2025-09-13 05:23:42', '2025-09-13 05:23:42'),
(775, 776, 7, '252610169', 0.00, 0, '2025-09-13 05:23:43', '2025-09-13 05:23:43'),
(776, 777, 7, '252610170', 0.00, 0, '2025-09-13 05:23:43', '2025-09-13 05:23:43'),
(777, 778, 7, '252610171', 0.00, 0, '2025-09-13 05:23:43', '2025-09-13 05:23:43'),
(778, 779, 7, '252610172', 0.00, 0, '2025-09-13 05:23:44', '2025-09-13 05:23:44'),
(779, 780, 7, '252610173', 0.00, 0, '2025-09-13 05:23:44', '2025-09-13 05:23:44'),
(780, 781, 7, '252610174', 0.00, 0, '2025-09-13 05:23:44', '2025-09-13 05:23:44'),
(781, 782, 7, '252610175', 0.00, 0, '2025-09-13 05:23:44', '2025-09-13 05:23:44'),
(782, 783, 7, '252610176', 0.00, 0, '2025-09-13 05:23:45', '2025-09-13 05:23:45'),
(783, 784, 7, '252610177', 0.00, 0, '2025-09-13 05:23:45', '2025-09-13 05:23:45'),
(784, 785, 7, '252610178', 0.00, 0, '2025-09-13 05:23:45', '2025-09-13 05:23:45'),
(785, 786, 7, '252610179', 0.00, 0, '2025-09-13 05:23:45', '2025-09-13 05:23:45'),
(786, 787, 7, '252610180', 0.00, 0, '2025-09-13 05:23:46', '2025-09-13 05:23:46'),
(787, 788, 7, '252610181', 0.00, 0, '2025-09-13 05:23:46', '2025-09-13 05:23:46'),
(788, 789, 7, '252610182', 0.00, 0, '2025-09-13 05:23:46', '2025-09-13 05:23:46'),
(789, 790, 7, '252610183', 0.00, 0, '2025-09-13 05:23:46', '2025-09-13 05:23:46'),
(790, 791, 7, '252610184', 0.00, 0, '2025-09-13 05:23:47', '2025-09-13 05:23:47'),
(791, 792, 7, '252610185', 0.00, 0, '2025-09-13 05:23:47', '2025-09-13 05:23:47'),
(792, 793, 7, '252610186', 0.00, 0, '2025-09-13 05:23:47', '2025-09-13 05:23:47'),
(793, 794, 7, '252610187', 0.00, 0, '2025-09-13 05:23:48', '2025-09-13 05:23:48'),
(794, 795, 7, '252610188', 0.00, 0, '2025-09-13 05:23:48', '2025-09-13 05:23:48'),
(795, 796, 7, '252610189', 0.00, 0, '2025-09-13 05:23:48', '2025-09-13 05:23:48'),
(796, 797, 7, '252610190', 0.00, 0, '2025-09-13 05:23:48', '2025-09-13 05:23:48'),
(797, 798, 7, '252610191', 0.00, 0, '2025-09-13 05:23:49', '2025-09-13 05:23:49'),
(798, 799, 7, '252610192', 0.00, 0, '2025-09-13 05:23:49', '2025-09-13 05:23:49'),
(799, 800, 7, '252610193', 0.00, 0, '2025-09-13 05:23:49', '2025-09-13 05:23:49'),
(800, 801, 8, '252610194', 0.00, 0, '2025-09-13 05:23:49', '2025-09-13 05:23:49'),
(801, 802, 8, '252610195', 0.00, 0, '2025-09-13 05:23:50', '2025-09-13 05:23:50'),
(802, 803, 8, '252610196', 0.00, 0, '2025-09-13 05:23:50', '2025-09-13 05:23:50'),
(803, 804, 8, '252610197', 0.00, 0, '2025-09-13 05:23:50', '2025-09-13 05:23:50'),
(804, 805, 8, '252610198', 0.00, 0, '2025-09-13 05:23:50', '2025-09-13 05:23:50'),
(805, 806, 8, '252610199', 0.00, 0, '2025-09-13 05:23:51', '2025-09-13 05:23:51'),
(806, 807, 1, '1', 0.00, 0, '2025-09-13 05:24:00', '2025-09-13 05:24:00'),
(807, 808, 1, '2', 0.00, 0, '2025-09-13 05:24:01', '2025-09-13 05:24:01'),
(808, 809, 1, '3', 0.00, 0, '2025-09-13 05:24:01', '2025-09-13 05:24:01'),
(809, 810, 1, '4', 0.00, 0, '2025-09-13 05:24:01', '2025-09-13 05:24:01'),
(810, 811, 1, '5', 0.00, 0, '2025-09-13 05:24:01', '2025-09-13 05:24:01'),
(811, 812, 1, '6', 0.00, 0, '2025-09-13 05:24:02', '2025-09-13 05:24:02'),
(812, 813, 1, '7', 0.00, 0, '2025-09-13 05:24:02', '2025-09-13 05:24:02'),
(813, 814, 1, '8', 0.00, 0, '2025-09-13 05:24:02', '2025-09-13 05:24:02'),
(814, 815, 1, '9', 0.00, 0, '2025-09-13 05:24:03', '2025-09-13 05:24:03'),
(815, 816, 1, '10', 0.00, 0, '2025-09-13 05:24:03', '2025-09-13 05:24:03'),
(816, 817, 1, '11', 0.00, 0, '2025-09-13 05:24:03', '2025-09-13 05:24:03'),
(817, 818, 1, '12', 0.00, 0, '2025-09-13 05:24:03', '2025-09-13 05:24:03'),
(818, 819, 1, '13', 0.00, 0, '2025-09-13 05:24:04', '2025-09-13 05:24:04'),
(819, 820, 1, '14', 0.00, 0, '2025-09-13 05:24:04', '2025-09-13 05:24:04'),
(820, 821, 1, '15', 0.00, 0, '2025-09-13 05:24:04', '2025-09-13 05:24:04'),
(821, 822, 1, '16', 0.00, 0, '2025-09-13 05:24:04', '2025-09-13 05:24:04'),
(822, 823, 1, '17', 0.00, 0, '2025-09-13 05:24:05', '2025-09-13 05:24:05'),
(823, 824, 1, '18', 0.00, 0, '2025-09-13 05:24:05', '2025-09-13 05:24:05'),
(824, 825, 1, '19', 0.00, 0, '2025-09-13 05:24:05', '2025-09-13 05:24:05'),
(825, 826, 1, '20', 0.00, 0, '2025-09-13 05:24:05', '2025-09-13 05:24:05'),
(826, 827, 1, '21', 0.00, 0, '2025-09-13 05:24:06', '2025-09-13 05:24:06'),
(827, 828, 1, '22', 0.00, 0, '2025-09-13 05:24:06', '2025-09-13 05:24:06'),
(828, 829, 1, '23', 0.00, 0, '2025-09-13 05:24:06', '2025-09-13 05:24:06'),
(829, 830, 1, '24', 0.00, 0, '2025-09-13 05:24:06', '2025-09-13 05:24:06'),
(830, 831, 1, '25', 0.00, 0, '2025-09-13 05:24:07', '2025-09-13 05:24:07'),
(831, 832, 1, '26', 0.00, 0, '2025-09-13 05:24:07', '2025-09-13 05:24:07'),
(832, 833, 1, '27', 0.00, 0, '2025-09-13 05:24:07', '2025-09-13 05:24:07'),
(833, 834, 1, '28', 0.00, 0, '2025-09-13 05:24:08', '2025-09-13 05:24:08'),
(834, 835, 1, '29', 0.00, 0, '2025-09-13 05:24:08', '2025-09-13 05:24:08'),
(835, 836, 1, '30', 0.00, 0, '2025-09-13 05:24:08', '2025-09-13 05:24:08'),
(836, 837, 1, '31', 0.00, 0, '2025-09-13 05:24:08', '2025-09-13 05:24:08'),
(837, 838, 1, '32', 0.00, 0, '2025-09-13 05:24:09', '2025-09-13 05:24:09'),
(838, 839, 1, '33', 0.00, 0, '2025-09-13 05:24:09', '2025-09-13 05:24:09'),
(839, 840, 1, '34', 0.00, 0, '2025-09-13 05:24:09', '2025-09-13 05:24:09'),
(840, 841, 1, '35', 0.00, 0, '2025-09-13 05:24:09', '2025-09-13 05:24:09'),
(841, 842, 1, '36', 0.00, 0, '2025-09-13 05:24:10', '2025-09-13 05:24:10');

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
  ADD KEY `insentifs_setoran_id_foreign` (`setoran_id`),
  ADD KEY `insentifs_kelas_id_foreign` (`kelas_id`),
  ADD KEY `insentifs_pembayaran_insentif_id_foreign` (`pembayaran_insentif_id`);

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
-- Indexes for table `pembayaran_insentifs`
--
ALTER TABLE `pembayaran_insentifs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pembayaran_insentifs_id_admin_foreign` (`id_admin`),
  ADD KEY `pembayaran_insentifs_id_wali_kelas_foreign` (`id_wali_kelas`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kategori_transaksi`
--
ALTER TABLE `kategori_transaksi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `pembayaran_insentifs`
--
ALTER TABLE `pembayaran_insentifs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `penarikan`
--
ALTER TABLE `penarikan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=869;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=842;

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
  ADD CONSTRAINT `insentifs_pembayaran_insentif_id_foreign` FOREIGN KEY (`pembayaran_insentif_id`) REFERENCES `pembayaran_insentifs` (`id`),
  ADD CONSTRAINT `insentifs_setoran_id_foreign` FOREIGN KEY (`setoran_id`) REFERENCES `setoran` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_id_wali_kelas_foreign` FOREIGN KEY (`id_wali_kelas`) REFERENCES `pengguna` (`id`);

--
-- Constraints for table `pembayaran_insentifs`
--
ALTER TABLE `pembayaran_insentifs`
  ADD CONSTRAINT `pembayaran_insentifs_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`),
  ADD CONSTRAINT `pembayaran_insentifs_id_wali_kelas_foreign` FOREIGN KEY (`id_wali_kelas`) REFERENCES `pengguna` (`id`);

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
