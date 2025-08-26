-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 26, 2025 at 06:41 AM
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
  `updated_at` timestamp NULL DEFAULT NULL
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
  `jumlah` decimal(8,2) NOT NULL,
  `subtotal_harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`id`, `id_penjualan`, `id_jenis_sampah`, `jumlah`, `subtotal_harga`, `created_at`, `updated_at`) VALUES
(2, 2, 5, 10.00, 1000.00, '2025-08-25 02:46:13', '2025-08-25 02:46:13');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_sampah`
--

CREATE TABLE `jenis_sampah` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_sampah` varchar(50) NOT NULL,
  `satuan` varchar(255) NOT NULL DEFAULT 'pcs',
  `harga_per_satuan` decimal(10,2) NOT NULL,
  `stok` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jenis_sampah`
--

INSERT INTO `jenis_sampah` (`id`, `nama_sampah`, `satuan`, `harga_per_satuan`, `stok`, `created_at`, `updated_at`) VALUES
(2, 'Gelas Plastik', 'pcs', 20.00, 0.00, NULL, '2025-08-24 18:45:25'),
(4, 'Kardus', 'kg', 2000.00, 0.00, '2025-08-24 23:51:40', '2025-08-25 02:44:28'),
(5, 'Botol Plastik', 'pcs', 35.00, 0.00, '2025-08-25 00:28:39', '2025-08-25 02:46:13');

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
(1, 'XII MPLB 1', '2025-08-24 18:42:40', '2025-08-24 18:47:31'),
(2, 'XII MPLB 2', '2025-08-24 18:42:40', '2025-08-24 18:47:37'),
(3, 'XII TM 1', '2025-08-24 18:42:40', '2025-08-24 18:47:43'),
(4, 'XII TM 2', '2025-08-24 18:47:47', '2025-08-24 18:47:47'),
(5, 'XII TM 3', '2025-08-24 18:47:51', '2025-08-24 18:47:51'),
(6, 'XII TM 4', '2025-08-24 18:47:54', '2025-08-24 18:47:54'),
(7, 'XII TM 5', '2025-08-24 18:47:57', '2025-08-24 18:47:57'),
(8, 'XII TM 6', '2025-08-24 18:48:00', '2025-08-24 18:48:00'),
(9, 'XII TM 7', '2025-08-24 18:48:05', '2025-08-24 18:48:05'),
(10, 'XI MPLB 1', '2025-08-24 18:48:08', '2025-08-24 18:48:08'),
(11, 'XI MPLB 2', '2025-08-24 18:48:13', '2025-08-24 18:48:13'),
(12, 'XI TM 1', '2025-08-24 18:48:16', '2025-08-24 18:48:16'),
(13, 'XI TM 2', '2025-08-24 18:48:18', '2025-08-24 18:48:18'),
(14, 'XI TM 3', '2025-08-24 18:48:21', '2025-08-24 18:48:27'),
(15, 'XI TM 4', '2025-08-24 18:48:32', '2025-08-24 18:48:32'),
(16, 'XI TM 5', '2025-08-24 18:48:36', '2025-08-24 18:48:36'),
(17, 'XI TM 6', '2025-08-24 18:48:56', '2025-08-24 18:48:56'),
(18, 'XI TM 7', '2025-08-24 18:49:00', '2025-08-24 18:49:00'),
(19, 'X MPLB 1', '2025-08-24 18:49:06', '2025-08-24 18:49:06'),
(20, 'X MPLB 2', '2025-08-24 18:49:10', '2025-08-24 18:49:10'),
(21, 'X TM 1', '2025-08-24 18:49:13', '2025-08-24 18:49:13'),
(22, 'X TM 2', '2025-08-24 18:49:16', '2025-08-24 18:49:16'),
(23, 'X TM 3', '2025-08-24 18:49:20', '2025-08-24 18:49:20'),
(24, 'X TM 4', '2025-08-24 18:49:23', '2025-08-24 18:49:23'),
(25, 'X TM 5', '2025-08-24 18:49:28', '2025-08-24 18:49:28'),
(26, 'X TM 6', '2025-08-24 18:49:32', '2025-08-24 18:49:32');

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
(9, '2025_08_23_114250_add_timestamps_to_kelas_table', 1),
(10, '2025_08_23_125708_create_cache_table', 1),
(11, '2025_08_24_180920_add_stok_to_jenis_sampah_table', 1),
(12, '2025_08_24_181005_create_penjualan_tables', 1),
(13, '2025_08_24_193128_modify_penarikan_table_for_class_withdrawal', 1),
(14, '2025_08_24_201303_add_kg_to_detail_penjualan_table', 1),
(15, '2025_08_25_040516_create_jobs_table', 2),
(16, '2025_08_25_050048_create_settings_table', 3),
(18, '2025_08_25_051923_make_unit_system_flexible', 4),
(19, '2025_08_25_065512_drop_kg_column_from_detail_penjualan_table', 5),
(20, '2025_08_25_083932_create_kas_kecil_table', 5),
(21, '2025_08_25_232512_create_buku_kas_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `penarikan`
--

CREATE TABLE `penarikan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_siswa` bigint(20) UNSIGNED DEFAULT NULL,
  `jumlah_penarikan` decimal(10,2) NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `id_kelas` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `penarikan`
--

INSERT INTO `penarikan` (`id`, `id_siswa`, `jumlah_penarikan`, `id_admin`, `created_at`, `updated_at`, `id_kelas`) VALUES
(1, 431, 50.00, 1, '2025-08-25 02:05:07', '2025-08-25 02:05:07', NULL);

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
(1, 'Administrator', 'admin', '$2y$12$4QADQdrcXafbIV30I/PuU.MLfXPJQpQlu3spI5fLizIMUxleN1tve', 'admin', '2025-08-24 18:42:40', '2025-08-25 02:31:48'),
(432, 'ADILAH', '252610001', '$2y$12$YCKzwIzag8veJfz5IhebP.abiQlztXs9pAkgbj/SV.S9iGL5u/uQi', 'siswa', '2025-08-24 21:11:06', '2025-08-24 21:11:06'),
(433, 'ADINDA OKTAVIANA', '252610002', '$2y$12$WEtkbxO7FyuNADWEWzkhFev2aVFAP436Hbtc.izhbYAfMMhrte2au', 'siswa', '2025-08-24 21:11:06', '2025-08-24 21:11:06'),
(434, 'ATIK CANTIKA', '252610003', '$2y$12$YQ1qQS9PTCgXqB7qy0ToQ.HZ90or8nkVR.QWgIiou6LJpcOCS4Mla', 'siswa', '2025-08-24 21:11:06', '2025-08-24 21:11:06'),
(435, 'AYU FADILLAH', '252610004', '$2y$12$rthPhgBAb7/2MGDnKeO30e1ekCFCcP268OEr9aqoO7KMWx/IPp8HG', 'siswa', '2025-08-24 21:11:06', '2025-08-24 21:11:06'),
(436, 'BINTANG SAMUDRA SATYABUDIE', '252610005', '$2y$12$xolyjBKCyZvgYc4b4hIFXuO.b59eB4k3aIvfBpgk7yqqWOsV3zdGy', 'siswa', '2025-08-24 21:11:07', '2025-08-24 21:11:07'),
(437, 'DESFA NAILATUL NAFISA', '252610006', '$2y$12$eLrirLutE1HvesDBoFNpauZWtwBvju/4AhPm8/WgLvATISdNnfJz2', 'siswa', '2025-08-24 21:11:07', '2025-08-24 21:11:07'),
(438, 'DONI RAMADHANI', '252610007', '$2y$12$Ym7qJt8wGtcl4pMHd16QA.BY3XRPih.hG1qH9gQYq1PjG/OG7r9IO', 'siswa', '2025-08-24 21:11:07', '2025-08-24 21:11:07'),
(439, 'FITRIA ZAHRATUNNAJA', '252610008', '$2y$12$a8mvdQMvcbmG7pXJ47cOu.tenEA.jNz23YZ.zhs6nHj8dTF/jv57S', 'siswa', '2025-08-24 21:11:07', '2025-08-24 21:11:07'),
(440, 'INDAH AFIFA', '252610009', '$2y$12$sX/3bb8af5NleEj6j1sZM./S/judxGOBZbsRr6ZVifpXYwf95sTla', 'siswa', '2025-08-24 21:11:08', '2025-08-24 21:11:08'),
(441, 'INDAH LISNAWATI', '252610010', '$2y$12$/CxibNN3A/OF28BoDftTiezsWLL94SbloeZ3u0qqCyXobDWvRNyu6', 'siswa', '2025-08-24 21:11:08', '2025-08-24 21:11:08'),
(442, 'INDRI PUSPITASARI', '252610011', '$2y$12$jgEWCvFHj7.HdZFXGCWzV.OzMzUl6sE/Zn8I5sl1Gt4.N6xziFD0m', 'siswa', '2025-08-24 21:11:08', '2025-08-24 21:11:08'),
(443, 'IQBAL MAULANA', '252610012', '$2y$12$SMvVAwIXd0FEz0MHUC.1tu6kw0P.FGyu2j1sZ3E6QS5Upl3pl.qOW', 'siswa', '2025-08-24 21:11:08', '2025-08-24 21:11:08'),
(444, 'JIHAN KHOLILAH', '252610013', '$2y$12$5yClbNK3JdfB3XubFKvzOOW/uFMmnc4cQBpUBBKPDRI9AB2L3Eszm', 'siswa', '2025-08-24 21:11:09', '2025-08-24 21:11:09'),
(445, 'KARLINA', '252610014', '$2y$12$fgbFcxfwueuK9ryvlWqfiux3ujX3gRkmuJ73PG.pbxFFlixMhuFKq', 'siswa', '2025-08-24 21:11:09', '2025-08-24 21:11:09'),
(446, 'KHOLIFAH RIZKA NURSAADAH', '252610015', '$2y$12$OEIIbsru2.u9Uf.FO2GxsOO0K/YltDiLiU8OWkxnmOwgCrXXnELAu', 'siswa', '2025-08-24 21:11:09', '2025-08-24 21:11:09'),
(447, 'KOMARIAH', '252610016', '$2y$12$zuIJS5HZ4y7YH3OEGm17NONjHwf2RXyZljNWrjyY4u3CYYaLoBwve', 'siswa', '2025-08-24 21:11:10', '2025-08-24 21:11:10'),
(448, 'NURUL HABIBAH', '252610017', '$2y$12$kgZlVyuhjCbpzQA4.2zCueunR0HRui1e9QUPEUD1NRqLjQatXTC8y', 'siswa', '2025-08-24 21:11:10', '2025-08-24 21:11:10'),
(449, 'RISMA NURMALA', '252610018', '$2y$12$HsbzpflKGkFInBrYUu5YRe.UJvQjKdnVcYHdotEDrfS0GCAOswl4.', 'siswa', '2025-08-24 21:11:10', '2025-08-24 21:11:10'),
(450, 'SALWA ANUROH', '252610019', '$2y$12$QXJI8xiJtKBhAQNI.Be0NOP83Wz/CuXf7gLjCh3alNa0mQs0uehce', 'siswa', '2025-08-24 21:11:10', '2025-08-24 21:11:10'),
(451, 'SHIPA', '252610020', '$2y$12$MKF4.jFOrbZfvrjnsqfDuuwUBGHY0xEcbPQNMF2ZAKA2j55FaD5ZO', 'siswa', '2025-08-24 21:11:11', '2025-08-24 21:11:11'),
(452, 'SHOFIA AISYAH MUSAFAAH', '252610021', '$2y$12$tAlpqesaiZR.9CcspLFSYu4IssBIGOTafskdZe31Hozgr9LZ53pCq', 'siswa', '2025-08-24 21:11:11', '2025-08-24 21:11:11'),
(453, 'SITI ALISA', '252610022', '$2y$12$RPMgNUBmXfSHpglVanrv1eA7BtPT2v2z9Wy.coc7rEhGCE5TZx6pi', 'siswa', '2025-08-24 21:11:11', '2025-08-24 21:11:11'),
(454, 'SITI AMINAH', '252610023', '$2y$12$fMbrMZZ95.QkhoZEk6OyjO.51m5RFFc.tBRYB2r3JG5VET1moR9NW', 'siswa', '2025-08-24 21:11:11', '2025-08-24 21:11:11'),
(455, 'SITI FATIMAH', '252610024', '$2y$12$6fZSOk9Huv7/QDQY4.lrk.YG0E5JHAfcRX5N8TgEqGYzcOoENPkRi', 'siswa', '2025-08-24 21:11:12', '2025-08-24 21:11:12'),
(456, 'WARNIH MELINDA', '252610025', '$2y$12$xi0XhO/9/ET2lfUjSqCzQuDPpagkMzJ1IDCUOTkzyqdX8JG/hHpUC', 'siswa', '2025-08-24 21:11:12', '2025-08-24 21:11:12'),
(457, 'WINA', '252610026', '$2y$12$sdoJ2kdzIn0RtXwoos0PoeNL7upzCKaIDaif3T3QMo4HbVHzVCPRS', 'siswa', '2025-08-24 21:11:12', '2025-08-24 21:11:12'),
(458, 'ZASKIA PUTRI', '252610027', '$2y$12$Xkpi275HwFkUs9RgNJj5Bu0JAn6oBXHj5w44q7zRC5xxuKeyvWh/q', 'siswa', '2025-08-24 21:11:13', '2025-08-24 21:11:13'),
(459, 'ALLEEISYA DAVINA KAMANDHANIKA', '252610028', '$2y$12$S/7WyZeOnOMgqL36w618xeQ2Dn3ne7GxsaENWuT7.sJxkoOLJ6LLy', 'siswa', '2025-08-24 21:11:13', '2025-08-24 21:11:13'),
(460, 'ALYA HANDAYANI', '252610029', '$2y$12$y/O4nMejlQHwZKKv6q9CPumoCccJ/2FuppF7vMUi2g/ljUhD/yKIm', 'siswa', '2025-08-24 21:11:13', '2025-08-24 21:11:13'),
(461, 'ANI SUHAENI', '252610030', '$2y$12$pe.oRG.xqA428q3yAtJmR.kG8LPq2fXngGrod/c79vjawcJAzoonS', 'siswa', '2025-08-24 21:11:13', '2025-08-24 21:11:13'),
(462, 'ANITA', '252610031', '$2y$12$Irab6P1GyZNIU7gGwrGBJuzc74LN04.6smPAVw72esfrzInMawinS', 'siswa', '2025-08-24 21:11:14', '2025-08-24 21:11:14'),
(463, 'APRILLIA ANATASYA', '252610032', '$2y$12$erEoq8Dgox4CjOYWPZP9Re4npU/FsjZdQ3wX4a6rk/5kuy6zG0iKi', 'siswa', '2025-08-24 21:11:14', '2025-08-24 21:11:14'),
(464, 'AULIA ISHAQUE', '252610033', '$2y$12$xdOJNKXzWTkfYdvBw4aFcOiBXvHZcHNwDXPWSGB9EzV2Rdsc8w3ga', 'siswa', '2025-08-24 21:11:14', '2025-08-24 21:11:14'),
(465, 'AVRIL AVPRIDA HARIYANA', '252610034', '$2y$12$IbblK5OuySax56/kEBPmWeTQC7QDLmNoEiVpJ61UAd3/g1KELy.3W', 'siswa', '2025-08-24 21:11:14', '2025-08-24 21:11:14'),
(466, 'CITRA LESTARI ROHIMAH', '252610035', '$2y$12$i.E290KwPuVyO4PwDRkc2Os0v7FddQ8A8TKVJ31.36z7rrkKnxgf2', 'siswa', '2025-08-24 21:11:15', '2025-08-24 21:11:15'),
(467, 'DINA', '252610036', '$2y$12$kdqLOcAx.UyeRo8C.6UUu.F5VAdBkWS17ExGoV7XFlI95wgZsGsBu', 'siswa', '2025-08-24 21:11:15', '2025-08-24 21:11:15'),
(468, 'ENENG JUMARIYAH', '252610037', '$2y$12$L71L2sPHSOx7bdBTCOArje9FmyzYs41imiFHECOXtje5LyudE8Stq', 'siswa', '2025-08-24 21:11:15', '2025-08-24 21:11:15'),
(469, 'ENGKOM KOMARIAH', '252610038', '$2y$12$DJOX4Q7SRy4S2WJhmvGbt.4I7gK5l7NS30.zqaLpGB/Vp9v5l7UgC', 'siswa', '2025-08-24 21:11:16', '2025-08-24 21:11:16'),
(470, 'HENA ALI', '252610039', '$2y$12$ddUqtYyek5vAf3N0Sb27tuv326RAemLqlPq1MFyDVpBdESTnHFVbK', 'siswa', '2025-08-24 21:11:16', '2025-08-24 21:11:16'),
(471, 'JIHAN ANNASTASYA', '252610040', '$2y$12$K1FvUGmf9WiJKZW6w5C30uTMwWyPNVeRMHKBS3s9rRKg.znIHzeIK', 'siswa', '2025-08-24 21:11:16', '2025-08-24 21:11:16'),
(472, 'KURNIA HANAPIAH ISWANDI', '252610041', '$2y$12$iifNNcKmeyI0b4pKLSh9tu3cR4tQmdT8mtLpBAXbRP4tuTARsYPhm', 'siswa', '2025-08-24 21:11:16', '2025-08-24 21:11:16'),
(473, 'LATIFAH', '252610042', '$2y$12$SzEf9XpAAxDfajcYxmnu9OpQNku0Uz4MkIQ6pqP/YL21me/PZ8ZGm', 'siswa', '2025-08-24 21:11:17', '2025-08-24 21:11:17'),
(474, 'NASYA MAHARANI', '252610043', '$2y$12$iVEswnRwvHb.Iz.fmYlFpO1kTqpMs6eVzcyXXD4yV/MY3BcW5a/7i', 'siswa', '2025-08-24 21:11:17', '2025-08-24 21:11:17'),
(475, 'NUR ALBIAH SALWA', '252610044', '$2y$12$mKE4keAA/gGm0w7ZlR0OVOyKEOj1kiHRzYw0/wcuz/ORWr43ZaJGm', 'siswa', '2025-08-24 21:11:17', '2025-08-24 21:11:17'),
(476, 'NUR SIFA ANGGAENI', '252610045', '$2y$12$LvAulwU9w6GaDjgkCZWHnuhL8z6cwz0w47OxzmEpEtsBOnCHqBDNq', 'siswa', '2025-08-24 21:11:17', '2025-08-24 21:11:17'),
(477, 'PUTRI SASKIA', '252610046', '$2y$12$p18zgQfSNw4X03mBK.D9o.AYkFltfyczBzgJHpSCN7ebVFboLaZrG', 'siswa', '2025-08-24 21:11:18', '2025-08-24 21:11:18'),
(478, 'RAHMA YANTI', '252610047', '$2y$12$qq.rMAlyoV.1QzDAxPJNjO62e28J.PRpNQXqBhoaTyJymIr/8/ivy', 'siswa', '2025-08-24 21:11:18', '2025-08-24 21:11:18'),
(479, 'RANI AMELIA', '252610048', '$2y$12$0dw/gsPMrD2XMe1q4mJWGO.HOAcfvU3tK3RilnRf9hrgdm3TOdb4y', 'siswa', '2025-08-24 21:11:18', '2025-08-24 21:11:18'),
(480, 'SAHAR SYAFITRI', '252610049', '$2y$12$mVwrCbRGrxL9tFkNXGu20.iIx6chmnC8/tXU1i6hmOsmFYpuk2Y3O', 'siswa', '2025-08-24 21:11:19', '2025-08-24 21:11:19'),
(481, 'SALSA BILA AZZAHRA', '252610050', '$2y$12$VftZAFARk2htb/xrTdEJBeOeAfR4VEKWRqWaAi3NFnQJWy4H.IyZ6', 'siswa', '2025-08-24 21:11:19', '2025-08-24 21:11:19'),
(482, 'SHIFA ADELIA MAWAR', '252610051', '$2y$12$ivVfw3l5/3eA.dogUl0KHOvYo02ViudDtIYbxQEkmxIH6Zx9Pghh.', 'siswa', '2025-08-24 21:11:19', '2025-08-24 21:11:19'),
(483, 'SINTA SUTIA', '252610052', '$2y$12$Qzfu0gE0gdliN9nSyeydmektb3TztCfXMR3qhxdIR1mCG50K9zIS.', 'siswa', '2025-08-24 21:11:19', '2025-08-24 21:11:19'),
(484, 'SITI NURZAHRA', '252610053', '$2y$12$wFLARRZc4UpDGyhDYn0rKuPTk8VCfZsVXxZkeaFX6wSmq8MlFYq32', 'siswa', '2025-08-24 21:11:20', '2025-08-24 21:11:20'),
(485, 'SITI ROMLAH', '252610054', '$2y$12$Ik/uFaKuvv.MKwVoQjzflOMtTmdb9g3Lj5eauIxhOLA8mTYEZR2Jm', 'siswa', '2025-08-24 21:11:20', '2025-08-24 21:11:20'),
(486, 'TANIA OKTAVIANI', '252610055', '$2y$12$cKQ1gZrory4iQD9dhDQmm.yQYmUWDhG6ryzpu9uWeNkas6xt/XIcW', 'siswa', '2025-08-24 21:11:20', '2025-08-24 21:11:20'),
(487, 'WINDI ALTIYAH', '252610056', '$2y$12$YPAhHJ8w9Wp0.fgjTIQTreCDsnC1Lakd/0T91upyrmug2oBYDo/d.', 'siswa', '2025-08-24 21:11:20', '2025-08-24 21:11:20'),
(488, 'ABU HAMAD MASKURI', '252610057', '$2y$12$s6Jq9wIorBG6sQctUeVxZ.t3DGa4M/TVJ6LvTqFqL4yPB8EC9IKHi', 'siswa', '2025-08-24 21:11:21', '2025-08-24 21:11:21'),
(489, 'ADE IRWANSYAH', '252610058', '$2y$12$LL/GoSxXf5Qw4ux8a4nX9uflcuhqgZutW8K9vg0yQkrotnc1SlwSS', 'siswa', '2025-08-24 21:11:21', '2025-08-24 21:11:21'),
(490, 'ALDO SUTISNA', '252610059', '$2y$12$rFhUPGOcDd4Zb0ypUCqsVuVo1A46ZvpN87bOgaElDDjsQfruLLAAi', 'siswa', '2025-08-24 21:11:21', '2025-08-24 21:11:21'),
(491, 'ANDIKA PAJAR MAHDI', '252610060', '$2y$12$6fhO90FTagixXL6ZUDRBaenpB7OZyZ9w3NKYLu53P71F86G/W4req', 'siswa', '2025-08-24 21:11:21', '2025-08-24 21:11:21'),
(492, 'ANDINI ANGGRAENI', '252610061', '$2y$12$HKB12aF1SL/PEAStzYobh.AqkO/t.EN1MLVujlN23l3I7jeSmCUxe', 'siswa', '2025-08-24 21:11:22', '2025-08-24 21:11:22'),
(493, 'BAGAS ARDIWINATA', '252610062', '$2y$12$Zc7j6rYXRemnO9NcDE1/kewrAblj64HVIClG8DcMVR.YG9DtpqHTq', 'siswa', '2025-08-24 21:11:22', '2025-08-24 21:11:22'),
(494, 'CHIKA SIPA ANGGITA', '252610063', '$2y$12$ul9NaWLBjosYDfLp02d0neKbhchOIrnkrHeSUaAZj4CRYH29O9OGy', 'siswa', '2025-08-24 21:11:22', '2025-08-24 21:11:22'),
(495, 'DANI SETIAWAN', '252610064', '$2y$12$NcekT3xfm7bN9sFdCoY4ReUNTzPnWb58QszJPlUlqiENHG27g7NaW', 'siswa', '2025-08-24 21:11:22', '2025-08-24 21:11:22'),
(496, 'DANI SUTISNA', '252610065', '$2y$12$6MhDqoDS3iOzs8lXjfyYS./UuToS7d5J3EWKbsAe9.56V4Uh9AQ22', 'siswa', '2025-08-24 21:11:23', '2025-08-24 21:11:23'),
(497, 'DANIA OKTAVIA', '252610066', '$2y$12$a9efQHzOlswnjIlgpbjRI.K2OCMGAjCctXUdtd5a8KvkjLKE8bkz6', 'siswa', '2025-08-24 21:11:23', '2025-08-24 21:11:23'),
(498, 'DIMAS AHMAD RAMADAN', '252610067', '$2y$12$oGA6xxrmFg.RFuRN6j0HB.9DDfy9QNHu6ZavXpiOHWkAv/.OaB1w6', 'siswa', '2025-08-24 21:11:23', '2025-08-24 21:11:23'),
(499, 'DIRLY ANGGADITA', '252610068', '$2y$12$z.mFydX9dN/AStu5NatSB.Q.HbXJ8NaELEfB.E09ZG5A/qYF5AvO6', 'siswa', '2025-08-24 21:11:24', '2025-08-24 21:11:24'),
(500, 'EDI SETIA GUNAWAN', '252610069', '$2y$12$YH93q.N6TQlAqR6KlOMGFet/L9EaLvtwOy2n7IOBTN6qQTOR7sAwq', 'siswa', '2025-08-24 21:11:24', '2025-08-24 21:11:24'),
(501, 'EKA BAMBANG SAPUTRA', '252610070', '$2y$12$bj6OtODjtr8pCBwJBTeLxuARUA8WNa0V0okJgFcRM8VWQb53ofbEe', 'siswa', '2025-08-24 21:11:24', '2025-08-24 21:11:24'),
(502, 'ENDRIK PURNAMA', '252610071', '$2y$12$JAn622j4g42ydPUCzdxw3Ok.Up7MFcJuGM58auwog364cFipLmPrG', 'siswa', '2025-08-24 21:11:24', '2025-08-24 21:11:24'),
(503, 'HERMANSYAH', '252610072', '$2y$12$0.gf59XzEYjfO5fhN.Zvkuw5HX0Mk9R0LEuPUVEMjeuIPO2PU4KNi', 'siswa', '2025-08-24 21:11:25', '2025-08-24 21:11:25'),
(504, 'HIDAYATULLAH', '252610073', '$2y$12$RBtJhrltVLBw8uJe62EUh.no.b8Q8jNpbAUOjJYLsEr5YY4MTcIBq', 'siswa', '2025-08-24 21:11:25', '2025-08-24 21:11:25'),
(505, 'JAEN', '252610074', '$2y$12$1EYMChNOO3krG1LcGfadre974CqwSj702KBQSFW03tjC4x0QkcxnK', 'siswa', '2025-08-24 21:11:25', '2025-08-24 21:11:25'),
(506, 'JULIYANTO', '252610075', '$2y$12$9rcXyTlU/cElbXZtUGgpZOvUf/m8udcgHSdrqqnaJxnW4ZUV4I0Vy', 'siswa', '2025-08-24 21:11:25', '2025-08-24 21:11:25'),
(507, 'MIFTAHUL ARIFIN', '252610076', '$2y$12$/LDsXkcCHH/1ZUogopv/HeaI6svqQoOzqfARDzTsKAht.bYMCdH..', 'siswa', '2025-08-24 21:11:26', '2025-08-24 21:11:26'),
(508, 'MIT F FELIX GUSNA', '252610077', '$2y$12$z28ZGuq3X8S1IMyOMAm5r.g5O9v94OebGnMEE5lE/HBzmrOoMnaZe', 'siswa', '2025-08-24 21:11:26', '2025-08-24 21:11:26'),
(509, 'MUHAMAD MUHIBIN', '252610078', '$2y$12$SlA7vTxSda7zztlF6xNWne2c7NVaoVOZ.81cv3RnSjfN5o3gjSUyG', 'siswa', '2025-08-24 21:11:26', '2025-08-24 21:11:26'),
(510, 'MUHAMAD RADITIYA', '252610079', '$2y$12$8fWmsqMrFcmqvPg3y.7G6ud013auLRZc7uFPjxDWVPXQtotUBjU/O', 'siswa', '2025-08-24 21:11:26', '2025-08-24 21:11:26'),
(511, 'MUHAMAD RIZKI BAEHAKI', '252610080', '$2y$12$fxDILx5Q//DAPA81ZkN8UOoNVDTQ7DweeXj5hnzBmQ85qgt2jaNaa', 'siswa', '2025-08-24 21:11:27', '2025-08-24 21:11:27'),
(512, 'MUHAMAD RIZKY HABIBI', '252610081', '$2y$12$UXRLmRlKsBZnWjzNkLXJN.1wC98qUVxIicKyDsw.RcsSZboSCLcoG', 'siswa', '2025-08-24 21:11:27', '2025-08-24 21:11:27'),
(513, 'MUHAMMAD AL ISRA FIRMANSYAH', '252610082', '$2y$12$GynudsRSITwSyswUDl5Df.YKmDJEPfvPW9IFTgVUJDGxo2XYn/Lwe', 'siswa', '2025-08-24 21:11:27', '2025-08-24 21:11:27'),
(514, 'MUHAMMAD FARHAN ADI PUTRA', '252610083', '$2y$12$KPc9H//kYWwsHsoleke21eJ2ZBcgyayDDZsMuVZm8YXSzIkgzOyzu', 'siswa', '2025-08-24 21:11:27', '2025-08-24 21:11:27'),
(515, 'RIFALDI JULIANSYAH', '252610084', '$2y$12$9YxXWmKMjRMWVYKa3vxQwuO7.1hZ6M9T8QUf313DDO.qpw86UCY5W', 'siswa', '2025-08-24 21:11:28', '2025-08-24 21:11:28'),
(516, 'RINDI', '252610085', '$2y$12$IAlvLUI4T94rAjrozRuDUe5VOU.4723UBmU.vPTI2cfxeRIeWyNVy', 'siswa', '2025-08-24 21:11:28', '2025-08-24 21:11:28'),
(517, 'RISFI HIDAYAT', '252610086', '$2y$12$KF0aH4fPF4llMOBnWIHtOeEcON2Wt2m2JgMVL6MX0HA0K0.OQ6ncO', 'siswa', '2025-08-24 21:11:28', '2025-08-24 21:11:28'),
(518, 'TAOPIK HIDAYAH', '252610087', '$2y$12$gOlih7wONbh6fF.LcTyhQ.XLfRl5lP.XgqnX5HucOvWdm6ZdN2uFe', 'siswa', '2025-08-24 21:11:28', '2025-08-24 21:11:28'),
(519, 'WISNU HASLAN FARID', '252610088', '$2y$12$MK3Y2NYcy0JE6SPIJ.dA9u.LO0jTH2PODubAsEWh9SIRanonefj6u', 'siswa', '2025-08-24 21:11:29', '2025-08-24 21:11:29'),
(520, 'YOMI ABDUL MANAH', '252610089', '$2y$12$uovyEKoEIIygTNIl/1wfueWl15iz.xup1O8B294t5DayDoqCWKfYW', 'siswa', '2025-08-24 21:11:29', '2025-08-24 21:11:29'),
(521, 'ZAKI IBNU KHAIRI', '252610090', '$2y$12$vONlXGMuUErJT6vyQ5IqaORop/QM/OffFlH0M9v8g1FYGMxZ6zOLG', 'siswa', '2025-08-24 21:11:29', '2025-08-24 21:11:29'),
(522, 'ABDUL LATIF', '252610091', '$2y$12$/N.FzEiH2Vxak7EbsjuTZe1aVHIL4LPM38kUvDHHfqGdB2./55vBC', 'siswa', '2025-08-24 21:11:30', '2025-08-24 21:11:30'),
(523, 'ADE IRFAN', '252610092', '$2y$12$108YiP3HvbEZcuLq5i95H.aQ20Ud0H2qLW7.DZrCa5UIr0B9NPF/K', 'siswa', '2025-08-24 21:11:30', '2025-08-24 21:11:30'),
(524, 'ADE KRISYANTO', '252610093', '$2y$12$3fYChP8w.Lz1DvCRtFZWw.CVRrkO1OfaF0FhFBjJq50DF/rr5BX6e', 'siswa', '2025-08-24 21:11:30', '2025-08-24 21:11:30'),
(525, 'ADITIA SIMATUPANG', '252610094', '$2y$12$XcJat0KM5mJj9mQuuNYvUufBB/4mfbSHY/JOyTPog2KjNDqMDwGpa', 'siswa', '2025-08-24 21:11:30', '2025-08-24 21:11:30'),
(526, 'AHMAD FAUZAN', '252610095', '$2y$12$S2aC7e1JXZZiJ/NN85WMyOuTfdQBQCFnH3pXiEuQK0LFp7TMUMwNG', 'siswa', '2025-08-24 21:11:31', '2025-08-24 21:11:31'),
(527, 'AHMAD FAUZI', '252610096', '$2y$12$l7Qf.B8rRmzUor2WVbUq..GP1vGf24OwTeveX7kSWvfwILnErsEU2', 'siswa', '2025-08-24 21:11:31', '2025-08-24 21:11:31'),
(528, 'AKBAR JUNIARDI', '252610097', '$2y$12$bdl5osb9SkBotLkyaVA7oeEUwlMc.oALFDFIMOnoKMX8pLUcsM8SS', 'siswa', '2025-08-24 21:11:31', '2025-08-24 21:11:31'),
(529, 'ALDI', '252610098', '$2y$12$49iaMQsMN5H7QiywJHvGUuj/B.Jl17/Yn.9bYL./d69HhXeZmrIL6', 'siswa', '2025-08-24 21:11:31', '2025-08-24 21:11:31'),
(530, 'BUNGA IRMA REFALIA', '252610099', '$2y$12$n5g/sQEvKAw66n81naDJ2uVj7RGvzbHvCL9435NUmDTmMmrMkM2o.', 'siswa', '2025-08-24 21:11:32', '2025-08-24 21:11:32'),
(531, 'DENIS', '252610100', '$2y$12$kAsuK2BIca32bK/Fbkl1L..47O0rJROhp2xJSuFHCUhY7E80huWRm', 'siswa', '2025-08-24 21:11:32', '2025-08-24 21:11:32'),
(532, 'DIDI FIRJATULLOH FADIB', '252610101', '$2y$12$jXyzxvFrjuH22mUXCLQxkOj8nLssdlvo.4biadesIPTKK7BDpXTY6', 'siswa', '2025-08-24 21:11:33', '2025-08-24 21:11:33'),
(533, 'DIMAS HAFIDDUDIN', '252610102', '$2y$12$yLz/ni4jDigJ4/dAb6eNEOxoT4bC8Xvp2o0SeXKQVvnLSrXbUTLXG', 'siswa', '2025-08-24 21:11:33', '2025-08-24 21:11:33'),
(534, 'DINI AMELIA PUTRI', '252610103', '$2y$12$EVJNeGLC1A/0Yr2qiaJnU.YM4Muo78KM8whVbmWfSmfU..ylBwQgi', 'siswa', '2025-08-24 21:11:33', '2025-08-24 21:11:33'),
(535, 'ENJELIKA APRIDA', '252610104', '$2y$12$Fsq8Zn.KZN45pfFhLPQ9R.96J3acPaidVA..Jc3O3Qxke86uyVouq', 'siswa', '2025-08-24 21:11:33', '2025-08-24 21:11:33'),
(536, 'FAISAL AKBAR', '252610105', '$2y$12$aJPGUKSJgFjnzw5dnkw4AewqllUe.X/0IT9pB57bU9bmmZuU5v8ly', 'siswa', '2025-08-24 21:11:34', '2025-08-24 21:11:34'),
(537, 'GIAN JANU PANDU SAPUTRA', '252610106', '$2y$12$/cO.zW8nDVLugzUAQTVw...z0QN4xhmdICtnVZ7aw0L284DmzrtEy', 'siswa', '2025-08-24 21:11:34', '2025-08-24 21:11:34'),
(538, 'HAFID JULIANA', '252610107', '$2y$12$ZqIv8w0n6zTgvAdAWHI9jeayNQ4gNr0c8JsCqamNjo2EPgr0Fopvm', 'siswa', '2025-08-24 21:11:34', '2025-08-24 21:11:34'),
(539, 'IQBAL ALBIANSYAH', '252610108', '$2y$12$zCMwxZFRGW2rjLpxiCbOLOzze1a4n3ovbyjWwjHN7WRcbsifPN8Qe', 'siswa', '2025-08-24 21:11:34', '2025-08-24 21:11:34'),
(540, 'IRWAN SAPUTRA', '252610109', '$2y$12$bCHJG8gINmIioTE7mZjvcO3MAIJQG3SQq7n9pdiDdn4bzCVR7Ewvi', 'siswa', '2025-08-24 21:11:35', '2025-08-24 21:11:35'),
(541, 'MUHAMAD FAZRI', '252610110', '$2y$12$7fDHTinwyENaXW9Bt1yxtujZTi.biUDwHjmTSSzNfjfbEpONwYBsu', 'siswa', '2025-08-24 21:11:35', '2025-08-24 21:11:35'),
(542, 'MUHAMAD HUSAIN HAFIZHULLAH', '252610111', '$2y$12$g5WTLVkLI5a97tLtPf/vlOL2dv05rLgI9.SkiqFYaeM30sBmDz3Cu', 'siswa', '2025-08-24 21:11:35', '2025-08-24 21:11:35'),
(543, 'MUHAMAD SOLEH ALFIKRI', '252610112', '$2y$12$atF2MSDNUx1THlv6MPTLueFvRkJNYqBbuo/4yA/KuXvxIzsCzTBRi', 'siswa', '2025-08-24 21:11:35', '2025-08-24 21:11:35'),
(544, 'MUHAMMAD REFAN REPIS', '252610113', '$2y$12$TXw2soPIwWtXJtxv2FXNlOb5sLbZPg7Ll668BKBfF/9zG9KTqbs5S', 'siswa', '2025-08-24 21:11:36', '2025-08-24 21:11:36'),
(545, 'NIZAR NASIHUDIN', '252610114', '$2y$12$lONT3HHYU1w.sNXIUBsAbex8BXhKMj5oh1DhqmtBJgcQk8AMwsrT.', 'siswa', '2025-08-24 21:11:36', '2025-08-24 21:11:36'),
(546, 'RAHMAT MURTI UMAY PUTRA', '252610115', '$2y$12$HI8yP7JcOKRHey1H4f8Fl.RcXfW3Lpsv8kVxQAgDStTlYMW3X98oq', 'siswa', '2025-08-24 21:11:36', '2025-08-24 21:11:36'),
(547, 'REYHAN ABIDIN', '252610116', '$2y$12$U80qRkgzP.J20a7JZzSmjOzkYjg.3rSkFgSKLQ5WvEQaioTqxBW.G', 'siswa', '2025-08-24 21:11:36', '2025-08-24 21:11:36'),
(548, 'REZA ARDIANSAH', '252610117', '$2y$12$AJEOz2MUeqhXFhQCJfmf4O0sCeDuCBpEylwz2oQ147EIVfK5OedSm', 'siswa', '2025-08-24 21:11:37', '2025-08-24 21:11:37'),
(549, 'RHEDY AFRILIANS NUGRAHA', '252610118', '$2y$12$UtU/dDT1qz9z/B1fs4Rjw.Hd76sbwRr7fVOOx4VSuPOjX0XygI2Oe', 'siswa', '2025-08-24 21:11:37', '2025-08-24 21:11:37'),
(550, 'ROSALINDA', '252610119', '$2y$12$n1ouJ51xCJBo..NQXnA6/elbldlDq1zRpO9h7bjFWJInBTjvrf2Aa', 'siswa', '2025-08-24 21:11:37', '2025-08-24 21:11:37'),
(551, 'SITI MARYAM', '252610120', '$2y$12$9yViBDb4zF6D/XCqHF3s0ebq62KcCyUgY/zyDtcrahcBBPARQ3Spe', 'siswa', '2025-08-24 21:11:38', '2025-08-24 21:11:38'),
(552, 'SITI PAIDAH', '252610121', '$2y$12$exL3H7PPPd.oZlHGAimM8O2JOQJc2DxQltWdRm2Ukji4NX2Kw/SrG', 'siswa', '2025-08-24 21:11:38', '2025-08-24 21:11:38'),
(553, 'SRI LESTARI', '252610122', '$2y$12$oCevpCS/Hdtlxh14/GSZm.BNoUybLisqNsjGeLCh37olSog6PFnhy', 'siswa', '2025-08-24 21:11:38', '2025-08-24 21:11:38'),
(554, 'TRYO ABDULGONI', '252610123', '$2y$12$LJ3xmGPpnntqIf1G5WRbDeNzTTVOA6Ehd0xQ6IpAvwCUK1tE2o75K', 'siswa', '2025-08-24 21:11:38', '2025-08-24 21:11:38'),
(555, 'TUBAGUS NAWAWI', '252610124', '$2y$12$4Nl4D2MN7.9Ef1Am92.elOq4OP8D3ZrsGla52h0S0cWboFPHE6ACm', 'siswa', '2025-08-24 21:11:39', '2025-08-24 21:11:39'),
(556, 'AHLIS ARFA NAOZA', '252610125', '$2y$12$zKsvxYMpjjwTuEbuwZNiRulbJFvcjQj/xRfO8BhSNKjz8WjyaHfQ2', 'siswa', '2025-08-24 21:11:39', '2025-08-24 21:11:39'),
(557, 'AHMAD FAUZI', '252610126', '$2y$12$6.tpRVM3a9VPpT5LgUxiv.EsPYNuq1mSErPxbsAOTbjkHosdB62dW', 'siswa', '2025-08-24 21:11:39', '2025-08-24 21:11:39'),
(558, 'AHMAD RIDWAN', '252610127', '$2y$12$zj4YXhdwl2TD49GJlQvJSOz8wqqCxWJM9GRVYTndFyiWlmzD7a4MG', 'siswa', '2025-08-24 21:11:40', '2025-08-24 21:11:40'),
(559, 'AHMAD RIFAI', '252610128', '$2y$12$IzEUk2lJIfVSkr52cRyep.7buqxZb6AoYa5ewAzn7G8JYktNyCC2q', 'siswa', '2025-08-24 21:11:40', '2025-08-24 21:11:40'),
(560, 'AKBAR MAULIANSYACH', '252610129', '$2y$12$GjmoKFdD5PzB4rPYFgBWXup8IHfkLNCH2W5/bUnZPnYy/doFsqWpG', 'siswa', '2025-08-24 21:11:40', '2025-08-24 21:11:40'),
(561, 'ANDINI', '252610130', '$2y$12$ByG17dxsKv3vymlmszMiu.W4qriUxVadMjsfYxSr4ItUAQCSO2Q8e', 'siswa', '2025-08-24 21:11:40', '2025-08-24 21:11:40'),
(562, 'AYU ADIRA', '252610131', '$2y$12$cyerSrpZqawMxEM65DaOfO5oFnJ8PK6jSNj8QzrG2EUH.WEKiWtoG', 'siswa', '2025-08-24 21:11:41', '2025-08-24 21:11:41'),
(563, 'CANDRA MAULANA', '252610132', '$2y$12$rXKJJgg0pDG5GQ4EGEahrOTox1P49lOhevOqQSnwcua2pXb6axS1S', 'siswa', '2025-08-24 21:11:41', '2025-08-24 21:11:41'),
(564, 'CIKAL ERLANGGA', '252610133', '$2y$12$cxpEervY0VY3PoYos607uegqQd.F7x3L0B.4BHMzpIysgTD6XFrUS', 'siswa', '2025-08-24 21:11:41', '2025-08-24 21:11:41'),
(565, 'DENI RIZKY PRATAMA', '252610134', '$2y$12$GFgFtywi3SiVCmyAdxCZDeaDEuvdDw.9RaS4DH75z4GeMgpkdKD02', 'siswa', '2025-08-24 21:11:42', '2025-08-24 21:11:42'),
(566, 'FAHRI ALIF FADILLAH', '252610135', '$2y$12$JQbS2VIceJ/j2NDvduBWhuS4dzAmjEjgfPyQ3G6LpgcOkm6cLk9ri', 'siswa', '2025-08-24 21:11:42', '2025-08-24 21:11:42'),
(567, 'GALANG RAMDANI', '252610136', '$2y$12$4ovXqyVAaERVE5.o8fqqzOXcFbK1EcUgZ1YgOcnHotTKLG8j01/2m', 'siswa', '2025-08-24 21:11:42', '2025-08-24 21:11:42'),
(568, 'HADID SWARA GUMILANG', '252610137', '$2y$12$X.R1LX1urfUQz79mSr1fHuROSkB3iL8qzOUCi5HFjxNGEGSqY7PNS', 'siswa', '2025-08-24 21:11:42', '2025-08-24 21:11:42'),
(569, 'KARTIKA SARI', '252610138', '$2y$12$rIar5g15cIdAuHRs5BCCqOVwMhIEwt9gp7zmWRxTrqA6Ey0qbZ8.e', 'siswa', '2025-08-24 21:11:43', '2025-08-24 21:11:43'),
(570, 'MARSHALL MILANIZT STILL Z', '252610139', '$2y$12$9m7h3ij7d5ydTvV6BhcOD.e6LWaMosJB9TFypIcRWRWCy5HsdjpKW', 'siswa', '2025-08-24 21:11:43', '2025-08-24 21:11:43'),
(571, 'MEISYA EUIS SADIAH', '252610140', '$2y$12$tH2ZYXl78dCWSzGURM2zFu9CMLjt7teot0ab34VV3BgPLH/hObXbe', 'siswa', '2025-08-24 21:11:43', '2025-08-24 21:11:43'),
(572, 'MOHAMMAD ZEYAD', '252610141', '$2y$12$TsQ2fL6Ckh/7hz/TRBHtn.IGlbCwJvqF8dwL9n106AEKJPxxTdB7a', 'siswa', '2025-08-24 21:11:43', '2025-08-24 21:11:43'),
(573, 'MUHAMAD FARHAN', '252610142', '$2y$12$dwLE3qfUyuRU.O1OtKxZo.hJF45vDlSJ2RkqWbpbfJchkwtd5z9FS', 'siswa', '2025-08-24 21:11:44', '2025-08-24 21:11:44'),
(574, 'MUHAMAD IRFAN MAULANA', '252610143', '$2y$12$kurTXBIbP8dgf5zlfQqci.5WSYMWxlNzYnYa1Hi78LZX.aWDedx72', 'siswa', '2025-08-24 21:11:44', '2025-08-24 21:11:44'),
(575, 'MUHAMAD JIHAD ILMA ATTAMIMI', '252610144', '$2y$12$YBpZnSho0xCKfsjjlRPiHeTH37p9C9vDBelXmefKipXTZbFBI9x2m', 'siswa', '2025-08-24 21:11:44', '2025-08-24 21:11:44'),
(576, 'MUHAMAD RIZKI', '252610145', '$2y$12$vw2lDu.V9OChHgCgSdnBOOw7iAvdRx38Cx/NeEQCZ/yUsDQdwWWoC', 'siswa', '2025-08-24 21:11:45', '2025-08-24 21:11:45'),
(577, 'MUHAMMAD ZAELANI', '252610146', '$2y$12$fXBdhNW9FhCD2sGwnEye/.Da5sj7aAq72KGXMKHlbtBz7zw0bhFqK', 'siswa', '2025-08-24 21:11:45', '2025-08-24 21:11:45'),
(578, 'NURJATI', '252610147', '$2y$12$Fp3GRbNGP36a1K2xrU3IbuYUbwWpY3OJ0V3WKpsAGgz4d3vNYUYEu', 'siswa', '2025-08-24 21:11:45', '2025-08-24 21:11:45'),
(579, 'RAMADAN', '252610148', '$2y$12$Z6YLDNtvrnuaAQVb5AfYP.ijB2QIR7ujMFeF3FKL/9crE7oj1evDe', 'siswa', '2025-08-24 21:11:45', '2025-08-24 21:11:45'),
(580, 'RIFQI QHAIRUL HASAN', '252610149', '$2y$12$Y9HmOijGfLocrvt/HIftMuKBvHUap665LkrmgF6woaU2VpBnqzaBK', 'siswa', '2025-08-24 21:11:46', '2025-08-24 21:11:46'),
(581, 'RIZKI NUR AL FAHRI', '252610150', '$2y$12$7AK9MKwROi7BKSMoGbHDouBGk9HW4KYXkOK79yDWuqhvRrrSivUuW', 'siswa', '2025-08-24 21:11:46', '2025-08-24 21:11:46'),
(582, 'SALSA NABILA', '252610151', '$2y$12$fxyLfpu4WaMI/BoFHWYncexICXPdI2mQjyAVAKIp2fhgKDzqZ6oVW', 'siswa', '2025-08-24 21:11:46', '2025-08-24 21:11:46'),
(583, 'SITI HASANAH', '252610152', '$2y$12$.Wo83doMwzPTEYJUGjvubuhuHGAfeARuDe/PQhBTlz2.In9GHZImi', 'siswa', '2025-08-24 21:11:46', '2025-08-24 21:11:46'),
(584, 'SUHENDRA', '252610153', '$2y$12$xp4LopnW51cn7YCffUcqnuTm8hRGcMpEHb5JqwAiPXHBYcH4dPiNq', 'siswa', '2025-08-24 21:11:47', '2025-08-24 21:11:47'),
(585, 'SUTISNA PRATAMA', '252610154', '$2y$12$nTncQNKoOcWUQL5zwQ311.9EytgbDWAyF.QYsdoP5NGr7ag00UU8q', 'siswa', '2025-08-24 21:11:47', '2025-08-24 21:11:47'),
(586, 'TEDI MAULANA', '252610155', '$2y$12$CFO0WPYGHM5Us45c8I4cruCtOQPQxm94tI0OIyk1ArgycA8v4BqtO', 'siswa', '2025-08-24 21:11:47', '2025-08-24 21:11:47'),
(587, 'WAHYU SUPRIATNA', '252610156', '$2y$12$60P.hmvbUA7.AAmm30dprOk0ngGy1IOHoaEW0Pt7Q4XGvS2YeF7AS', 'siswa', '2025-08-24 21:11:48', '2025-08-24 21:11:48'),
(588, 'WALID FAJAR RAMADHAN', '252610157', '$2y$12$ubQFYo56VGiFi9CUma3ewObeQCZH4oXuWUV.PswChUAPtwTuBpn/C', 'siswa', '2025-08-24 21:11:48', '2025-08-24 21:11:48'),
(589, 'YUSUP', '252610158', '$2y$12$zsIIslqUG3LTLJdMQnnlO.zE9l.ytVIxoPphmstdr5j3ILswg75RG', 'siswa', '2025-08-24 21:11:48', '2025-08-24 21:11:48'),
(590, 'ABDUL FIKRI', '252610159', '$2y$12$cdieojbQY81Mc.vSniBMAuSDj7IhPtBNRToI4tVhXTibUGSoiXE/6', 'siswa', '2025-08-24 21:11:48', '2025-08-24 21:11:48'),
(591, 'ADIL ALZULFA', '252610160', '$2y$12$zgGG9oVM1TKVnCUj3pMSA.RSYHoimdn7mJ6EW4Z6lqYiKlUZXw7NS', 'siswa', '2025-08-24 21:11:49', '2025-08-24 21:11:49'),
(592, 'AGAM MADANI', '252610161', '$2y$12$p6EWF3/rEmeFxpdutNsDE.qPf91Oaws2ZQjYT/TW//PZIDgBl3hcS', 'siswa', '2025-08-24 21:11:49', '2025-08-24 21:11:49'),
(593, 'AGUS SAPUTRA', '252610162', '$2y$12$ep7tpK5FVdE1E4ksQddk8e25pWvCJMcZa8eO4aPytymdm/ymeXK0.', 'siswa', '2025-08-24 21:11:49', '2025-08-24 21:11:49'),
(594, 'AHMAD AZMI KHOERUNNIZAR', '252610163', '$2y$12$szTvPCHAwG3mXVkO0/keROfNqzpfRjoP1.1aQKM3WA4/NnJdQA37u', 'siswa', '2025-08-24 21:11:49', '2025-08-24 21:11:49'),
(595, 'AHMAD RIZKY KURNIAWAN', '252610164', '$2y$12$Hk7r1ucymmH1dkZM2HJaQuxPMAwCgq5XQDBHKs0NwVG0rRDXcMbXO', 'siswa', '2025-08-24 21:11:50', '2025-08-24 21:11:50'),
(596, 'AHMAD SYAFIQ', '252610165', '$2y$12$1KFH509X1gTzRElNeAvpvOzJuFrQVuksng6801FpnVpel.lXW40Na', 'siswa', '2025-08-24 21:11:50', '2025-08-24 21:11:50'),
(597, 'ANGGA MAULANA', '252610166', '$2y$12$yBWsHcDQqy/pUYlY/4b49utSynPXiSFabPWR.o/eD0ALWb0Ob3lbO', 'siswa', '2025-08-24 21:11:50', '2025-08-24 21:11:50'),
(598, 'DENI KUSMANA', '252610167', '$2y$12$WzZB5QNqfKUbqVI3vuFROO0KjeWvAYXvwjKMpFxcb3VZ6DHhFTGRy', 'siswa', '2025-08-24 21:11:51', '2025-08-24 21:11:51'),
(599, 'DIANA RAHAYU', '252610168', '$2y$12$5d6X2K.5RxQuY0Vv6ijVfOWrj57d97JMZzkx3WF2zSCzMjEoMHVP2', 'siswa', '2025-08-24 21:11:51', '2025-08-24 21:11:51'),
(600, 'EPITASARI', '252610169', '$2y$12$l8wecXIZEDr8TyKz.fbcXOVu1KKSxyNit6661taJPIxuznSiCS9w6', 'siswa', '2025-08-24 21:11:51', '2025-08-24 21:11:51'),
(601, 'FARHANNABIL', '252610170', '$2y$12$wxjxG5tJD35sQ8xTc7.hRePeiUB8LSwm1j0.6QBkQVDYTCK5nE7G2', 'siswa', '2025-08-24 21:11:51', '2025-08-24 21:11:51'),
(602, 'HABIL NUR ALDIN', '252610171', '$2y$12$.VBtf71kVOxUbWltRd4/OeX2F4obbiwPUGUvnpkZP4QqHRMmxzZpq', 'siswa', '2025-08-24 21:11:52', '2025-08-24 21:11:52'),
(603, 'KARDA PUTRA ADIANSYAH', '252610172', '$2y$12$veLvr9f1pMeUh8mCjMnvrOXHyfzRKyQGkjT00//wvOMWUsWMJg2dO', 'siswa', '2025-08-24 21:11:52', '2025-08-24 21:11:52'),
(604, 'MARYONO', '252610173', '$2y$12$xXUb8Ff0Lfxfb.ak9Kr29uk3t4QPSbYowktwwArJ8kNzFPzSigQSu', 'siswa', '2025-08-24 21:11:52', '2025-08-24 21:11:52'),
(605, 'MASITOH NURUL SYIFA', '252610174', '$2y$12$4zeGwtpBbzXY49hlXC2ZneiufQG2Xywuji06hybGLnKMhDSZQwxwO', 'siswa', '2025-08-24 21:11:53', '2025-08-24 21:11:53'),
(606, 'MOHAMAD FAJAR ALFAZRY', '252610175', '$2y$12$fAaMFBPXZr9XHZbc06tKvOyEQ/kUGIrvI/DXev8RumjpJonN8302G', 'siswa', '2025-08-24 21:11:53', '2025-08-24 21:11:53'),
(607, 'MUHAMAD KHOLBY SAHIH', '252610176', '$2y$12$ggR1rV2JbTrHklzzDtVWWu2pERxuLZEj88r/MiZFo9ECTyYYQmhV2', 'siswa', '2025-08-24 21:11:53', '2025-08-24 21:11:53'),
(608, 'MUHAMAD RIDWAN SAPII', '252610177', '$2y$12$NP17Hf8AHMxClBDofaWfGORkHP8YCBFkNG9.FQ59Gc0W5JLpKCjYm', 'siswa', '2025-08-24 21:11:53', '2025-08-24 21:11:53'),
(609, 'MUHAMMAD ALDIANSYAH', '252610178', '$2y$12$rkrriQ1SeiRWw6MeYJNq2O25dpVDASOqwJEg/IjiSYKf2JEq1BoJq', 'siswa', '2025-08-24 21:11:54', '2025-08-24 21:11:54'),
(610, 'MUHAMMAD RIDWAN AL KHADAFI', '252610179', '$2y$12$MCT.x95mvX3SqE63orEgLenTVdosYx8yB5UcRY..cezAxRCq.MKCW', 'siswa', '2025-08-24 21:11:54', '2025-08-24 21:11:54'),
(611, 'NOVAL MALIKI', '252610180', '$2y$12$vuqho6m2ObRwelaMOco28ezVPGhTJfCjZS4nqKRGKxAdWgYMAqqmO', 'siswa', '2025-08-24 21:11:54', '2025-08-24 21:11:54'),
(612, 'NURWULAN', '252610181', '$2y$12$PvVeBj1tVZJatU7hVL0ouuBNXgzbVNo4dvJcq6mN/Q5.58q7lPhXO', 'siswa', '2025-08-24 21:11:54', '2025-08-24 21:11:54'),
(613, 'OBAY SOBARNA', '252610182', '$2y$12$lI2wq..d7OuxKDf4.WdCOeWWWuJfNzPf/Diwbee9QjPSgyS/Q7mai', 'siswa', '2025-08-24 21:11:55', '2025-08-24 21:11:55'),
(614, 'PATONAH', '252610183', '$2y$12$1kQ9Y.M7M1K.kZ5IdJSIruvRTjOjPFm1kJv7RVfR1aUtIFkB/XoLy', 'siswa', '2025-08-24 21:11:55', '2025-08-24 21:11:55'),
(615, 'RAGIL GOJALI', '252610184', '$2y$12$ACzGjJeo8bYtxjBSe/9MU.h7gEWPv..obDc4rI2owgCaosnBNoUqa', 'siswa', '2025-08-24 21:11:55', '2025-08-24 21:11:55'),
(616, 'RAJIF JULIAWAN', '252610185', '$2y$12$8mfjOXc1pMe3/qtSkYs4CeL7nrVysxYpZ/tcHjXC2iXs2SW.8uk2e', 'siswa', '2025-08-24 21:11:56', '2025-08-24 21:11:56'),
(617, 'RIO SUSANTO', '252610186', '$2y$12$Ae4leWALzZpLq/2nXoU1euzQtfkeLy9Qyv2PTYNt4L9TgT6yIAdq2', 'siswa', '2025-08-24 21:11:56', '2025-08-24 21:11:56'),
(618, 'RIZKY RAMDANI', '252610187', '$2y$12$oj.jt986gquRDGYjmGJsyu7gnoWgDEGleXoQmo5ALwhe80HAFdb1y', 'siswa', '2025-08-24 21:11:56', '2025-08-24 21:11:56'),
(619, 'RUSLAN', '252610188', '$2y$12$weYZU0.qaOSpu3VoAKWG3OtFjwF5cjHsKftOma5f20BcsR/OlWS.y', 'siswa', '2025-08-24 21:11:56', '2025-08-24 21:11:56'),
(620, 'RYAN HIDAYAT', '252610189', '$2y$12$ekfkg1/0r5uEGVG/1Q9sJeA1cLCQVaj8wkpaEGeqP5IEDvPzjClRC', 'siswa', '2025-08-24 21:11:57', '2025-08-24 21:11:57'),
(621, 'TAUPIK UROHMAN', '252610190', '$2y$12$3BGsopnhNsloehoeKS8EQukwPfruOPoB3gfMNK0s8CsQ1kHsM.fua', 'siswa', '2025-08-24 21:11:57', '2025-08-24 21:11:57'),
(622, 'WILLIYANA ADISTIA', '252610191', '$2y$12$C7y7YQIQRCd7ftyePJ1A1O.KxnbN.WtQvSQhSABS4PZ0Bf6iyogwm', 'siswa', '2025-08-24 21:11:57', '2025-08-24 21:11:57'),
(623, 'YUSUF RAMADAN', '252610192', '$2y$12$oEYGVFYfnJtf4uIZJvqaL.KQ9VlBF7tUgJAbWzvkXjqQhkzGD6m2K', 'siswa', '2025-08-24 21:11:57', '2025-08-24 21:11:57'),
(624, 'AHMAD GUNAWAN', '252610193', '$2y$12$mvRVtx7vgSQpL2kA4Nw0.ewuNAgDPyKl7wbzvrJhXzY9pN81IN3f2', 'siswa', '2025-08-24 21:11:58', '2025-08-24 21:11:58'),
(625, 'AKBAR ALVIAN', '252610194', '$2y$12$eNHAi/iMN1UcGhLusyLrduav5CQWEjD1ovKNRmzLHFSvTi/K4rvhm', 'siswa', '2025-08-24 21:11:58', '2025-08-24 21:11:58'),
(626, 'AL AZIS MUBAROK', '252610195', '$2y$12$K10.9S7aiLDqFhWpuZkut.14cHj/BVH86cJaG1h2ZcOqgTqwuVmjq', 'siswa', '2025-08-24 21:11:58', '2025-08-24 21:11:58'),
(627, 'ALIF QIZWINI', '252610196', '$2y$12$U3t5DsxTLhITsKHtD7jWqONlNkmWvkOeQBJxgsFxSk.8B/Hagp5Ja', 'siswa', '2025-08-24 21:11:59', '2025-08-24 21:11:59'),
(628, 'CARSADI', '252610197', '$2y$12$ZRaOKKnHkkVzDoFj/w9oxOw0o3amPHvXZ5lBGqSPzo0.odW0.Sq2y', 'siswa', '2025-08-24 21:11:59', '2025-08-24 21:11:59'),
(629, 'CHIKA RAHMAWATI', '252610198', '$2y$12$V8akAeM8VYKa5v/bZ.5cpOBv8T19NPQPSQiwRyTnB/Nu2bNg8C7xS', 'siswa', '2025-08-24 21:11:59', '2025-08-24 21:11:59'),
(630, 'DEFNE MAULLANA EL SYARIF', '252610199', '$2y$12$EyQJXkvzGxLisuAJo2vzmu/YvS6hkS6iZ2tI2H2SxvPkmD0x8BvBG', 'siswa', '2025-08-24 21:11:59', '2025-08-24 21:11:59'),
(631, 'DEVI DESVITASARI', '252610200', '$2y$12$UzsvFfyWBv79Ax866N5Qj.QFVDh5JhGoDXDRDs5tsvr.JDSIA2LNq', 'siswa', '2025-08-24 21:12:00', '2025-08-24 21:12:00'),
(632, 'DIKA NANDA', '252610201', '$2y$12$NfgSeUHQ2YT7tcHnpShKrOpcMVt2.x..d6Hguw3TpM8Kr5ynRI.s.', 'siswa', '2025-08-24 21:12:00', '2025-08-24 21:12:00'),
(633, 'EKA FEBRIANA', '252610202', '$2y$12$2HYbadQxXNyA1cInslr/wuxZyDG8rPj/zcUjFwen616Vr56UnMGc2', 'siswa', '2025-08-24 21:12:00', '2025-08-24 21:12:00'),
(634, 'GALANG FIRMANSYAH', '252610203', '$2y$12$tU6bjDRdEafoR/Ed9j.wNuGLmrHVeyT47FOEKTSA9tyIplQ.KKH9y', 'siswa', '2025-08-24 21:12:01', '2025-08-24 21:12:01'),
(635, 'HALIMATU ZAHRA', '252610204', '$2y$12$U6krlDneNnUVequfg2Tta.19YnXXpHgZJhlaiabMlWUdKMHuG/Srq', 'siswa', '2025-08-24 21:12:01', '2025-08-24 21:12:01'),
(636, 'HASBI ASHIDIQI', '252610205', '$2y$12$1W4zCI6jpH2ar4wEd8I35u6z/e4eZ2QoHx8b8hK13.jIX33UL68xu', 'siswa', '2025-08-24 21:12:01', '2025-08-24 21:12:01'),
(637, 'HERDIYAN NUGRAHA', '252610206', '$2y$12$Yyx7iddB3X20VxZG7UqXWOFR2q6ahmqFUFHwLDDwZ0JCMNDlkw7i6', 'siswa', '2025-08-24 21:12:01', '2025-08-24 21:12:01'),
(638, 'JEJE', '252610207', '$2y$12$Tbm6Tnl76JLJFkCFEDA3JucQ1yk9qNCWht4PV1jY8IevV24YO91QW', 'siswa', '2025-08-24 21:12:02', '2025-08-24 21:12:02'),
(639, 'MARINA F SIMATUPANG', '252610208', '$2y$12$68RP0fOK47QbBf68xUiAsedx5mzOhI5dUPYejzuclW2Ia.5I8Fw.6', 'siswa', '2025-08-24 21:12:02', '2025-08-24 21:12:02'),
(640, 'MUHAMAD IHSAN MUBAROK', '252610209', '$2y$12$m2QAr5LgbPCNZ7FQoZO2JOL3kcXeiPYBSLLf3f.Fgm31pyANDE1LK', 'siswa', '2025-08-24 21:12:02', '2025-08-24 21:12:02'),
(641, 'MUHAMAD IQBAL ALFAQIH', '252610210', '$2y$12$Inzx8mLhS84lEc1A.R00KuD8XbTpK3blSWewpLDGP/xAEeb/z7MHG', 'siswa', '2025-08-24 21:12:03', '2025-08-24 21:12:03'),
(642, 'MUHAMAD KAMAL', '252610211', '$2y$12$JTuQtbE3gxbNrlvqJJdpmums.vGZfActguMLmSeN7fZN6XNDF12um', 'siswa', '2025-08-24 21:12:03', '2025-08-24 21:12:03'),
(643, 'MUHAMAD REHAN', '252610212', '$2y$12$JeGZn3TKdVXcsYd97D5dUOAt8gKuLT9amDmpWD/MLl5Fl3M7RvO3y', 'siswa', '2025-08-24 21:12:03', '2025-08-24 21:12:03'),
(644, 'MUHAMMAD WAROSATUL AMBIYA', '252610213', '$2y$12$.no3Ff2EgxZDlJqwf4yd7.zN6sBUIbYqKUMOai/Eth158ADMJbIEe', 'siswa', '2025-08-24 21:12:03', '2025-08-24 21:12:03'),
(645, 'NURFRIAN SYAHRONY', '252610214', '$2y$12$ZDMTXaGyhtukRwJwt5s2ousjwcEn4OL2//1qsV1PXB7JFajvdKC.C', 'siswa', '2025-08-24 21:12:04', '2025-08-24 21:12:04'),
(646, 'RAELAN MUTABAROQ', '252610215', '$2y$12$47p4FLSj3sYtLg6M5lx6guQDpKr2PTZwCvj3TH9kd0e0.wtZdLk7y', 'siswa', '2025-08-24 21:12:04', '2025-08-24 21:12:04'),
(647, 'RAMLI', '252610216', '$2y$12$/.H6bN1muleCo/k7GtL60eDUheMs0EYQ2Fbozx614WDdrmSc8LBb6', 'siswa', '2025-08-24 21:12:04', '2025-08-24 21:12:04'),
(648, 'RIFQIANSAH', '252610217', '$2y$12$u51jpnHpNNAsL.u.LkB3g.rBS1skuV/H4wdmgskNqnGZTfzDKHoaq', 'siswa', '2025-08-24 21:12:04', '2025-08-24 21:12:04'),
(649, 'RINTO', '252610218', '$2y$12$vE.ItVAQPME5Lmd.mce92eHfOyIpAVAg1wrl4Tr6bn0CLz31HchBS', 'siswa', '2025-08-24 21:12:05', '2025-08-24 21:12:05'),
(650, 'RISMA', '252610219', '$2y$12$s82eu4nUVZnHQuXIyVgUWuKmxraeMQjlcsXODtFtwWjE9bilAexWu', 'siswa', '2025-08-24 21:12:05', '2025-08-24 21:12:05'),
(651, 'SIVA YULYANTI', '252610220', '$2y$12$lsOHeYhjhqAfKlMxEAP8Hu5zAMfWQGuCbbh8I8vPG0IiCdUds737u', 'siswa', '2025-08-24 21:12:05', '2025-08-24 21:12:05'),
(652, 'SUHERMAN', '252610221', '$2y$12$MM2mG2wdJL2E30lxZTGQQ.y/YMT5W0YmfEWCjb3JnA8mxzCVYZC8i', 'siswa', '2025-08-24 21:12:06', '2025-08-24 21:12:06'),
(653, 'SUNANTA', '252610222', '$2y$12$7EXwk6C8piqiMlYsRHnjsOyj3rxwB2NuAokAu4ejT.RP9lt.Iq64u', 'siswa', '2025-08-24 21:12:06', '2025-08-24 21:12:06'),
(654, 'SURYANI WIDYA PUTRI', '252610223', '$2y$12$iiBHmxkI4q/UoTPJlgsupOHyjQybGfVKRyygs8Kd0nm/dEqnwzTt6', 'siswa', '2025-08-24 21:12:06', '2025-08-24 21:12:06'),
(655, 'ULFIA ANGGIA PUTRI', '252610224', '$2y$12$Isfm3kl6iyCtS43aI4KXw.hOfl3RStZywjOTPMWRm/2KzkLz2yYXm', 'siswa', '2025-08-24 21:12:06', '2025-08-24 21:12:06'),
(656, 'WARDI', '252610225', '$2y$12$BrOqdVc/PggYnklVwblBg.fTzGbRIgg1Qp/13QPrnh6NDStdH0cGm', 'siswa', '2025-08-24 21:12:07', '2025-08-24 21:12:07'),
(657, 'WARDIMAN', '252610226', '$2y$12$efT8BgFjWurtcEJ0GlMbp.rxtcX0vPXCL3LiblQYAipEy4EMzGqmm', 'siswa', '2025-08-24 21:12:07', '2025-08-24 21:12:07'),
(658, 'ZAHRAN MAHESWARI', '252610227', '$2y$12$BFL5sKJZNQ4RUwFrkWDy1eLtDcYxI9deHo/KICOa3UA6POL5UECDW', 'siswa', '2025-08-24 21:12:07', '2025-08-24 21:12:07'),
(659, 'AHMAD RANDIKA', '252610228', '$2y$12$ct5Nq7kKLEj.F2v7VbRGzuOl80F0RLm5CSCmLbntWoZAy2iX.8Oau', 'siswa', '2025-08-24 21:12:08', '2025-08-24 21:12:08'),
(660, 'AHMAD SAEPUDIN', '252610229', '$2y$12$dQzqBViGH7rpN0sfRFXmNuJzNvQyad2DSXuBlHfFa5ZGT/Zm3zRDS', 'siswa', '2025-08-24 21:12:08', '2025-08-24 21:12:08'),
(661, 'AHMAD SOFWAN ISMAIL', '252610230', '$2y$12$3rhkrHFjImEjzEzs4dDbAuzbjBuoyTsBExeXWS8mD8KnU7/lhCm.S', 'siswa', '2025-08-24 21:12:08', '2025-08-24 21:12:08'),
(662, 'ANDHIKA RAMADHAN', '252610231', '$2y$12$M8.hVvqYi8BfL1Px/BTz.u/1UxJzG7kldMc6BNLOOUgYcQbWrCmyy', 'siswa', '2025-08-24 21:12:08', '2025-08-24 21:12:08'),
(663, 'ANDIH SAEPUL BAHRI', '252610232', '$2y$12$9Xr6ptWH5/dQADWJOafDY.umA7E5nu.FOFgUu1pyhxEpOmuShYX2C', 'siswa', '2025-08-24 21:12:09', '2025-08-24 21:12:09'),
(664, 'ANDIKA PRATAMA', '252610233', '$2y$12$aLV648vhrME/eVQfRjecgOrrCfiLLcy8yLO/NaYWF09l7f3yLJxk.', 'siswa', '2025-08-24 21:12:09', '2025-08-24 21:12:09'),
(665, 'ARIYA DARMAWANSYAH', '252610234', '$2y$12$iVHewzDo15fIt2b46ieabOxsyJozXd/e5cYyBjpKCBLPlUiIkws7e', 'siswa', '2025-08-24 21:12:09', '2025-08-24 21:12:09'),
(666, 'ARSYA NUR HARLY HASAN', '252610235', '$2y$12$DaW/B/RkTesVT9kMqa6wz.PXJNWrd9yVjb.J4Ue.4/nsjYVDYMECa', 'siswa', '2025-08-24 21:12:10', '2025-08-24 21:12:10'),
(667, 'BENI KURNIA', '252610236', '$2y$12$0q3YxCpZs4MVwDKOub4VJ.rwT5GTcT9SJEH6DCYMdIFI8QMcZ9UFK', 'siswa', '2025-08-24 21:12:10', '2025-08-24 21:12:10'),
(668, 'CANDRA AKBAR', '252610237', '$2y$12$EHhEsfAA37UXIG24fuW8aO6SzlgiYzcBjj8xr7UMIYynXrhX2r0.2', 'siswa', '2025-08-24 21:12:10', '2025-08-24 21:12:10'),
(669, 'CINTIA', '252610238', '$2y$12$RCrGMRVMKkS1Dwi28yKNZunC8MzEpEzRYR9UzHj5wSmh4Qx8hc86W', 'siswa', '2025-08-24 21:12:10', '2025-08-24 21:12:10'),
(670, 'DEWI CUT NADIN', '252610239', '$2y$12$iCNiwcFtWOs7ILiAwpqhv.c9UcGsF.UmybH1QZHfs77Oezh1F0D7y', 'siswa', '2025-08-24 21:12:11', '2025-08-24 21:12:11'),
(671, 'DIKA BAEHAKI', '252610240', '$2y$12$YkxY3l9yLEYvIladRuNSneKPMkcYtVcSqjnqmXUHMzEHmP9IeFmK.', 'siswa', '2025-08-24 21:12:11', '2025-08-24 21:12:11'),
(672, 'DIMAS SETO', '252610241', '$2y$12$6UIMbxKmYVtvc3xBh8e/eeJq4VU927m2xx3kZNjPQrn2vyrqGejmS', 'siswa', '2025-08-24 21:12:11', '2025-08-24 21:12:11'),
(673, 'FAIQ SUGILAR', '252610242', '$2y$12$MlttGc7y2UoAmRJsXuDvUuHl3TxW9OZZ8Ifz719.vg.Ere9lRCmRq', 'siswa', '2025-08-24 21:12:11', '2025-08-24 21:12:11'),
(674, 'FAJRUL MA ANI', '252610243', '$2y$12$gQwoVfCmTzDu0TU1LKVlsen516HXfvTI7/1uBGdOaR1kG2lr//p.y', 'siswa', '2025-08-24 21:12:12', '2025-08-24 21:12:12'),
(675, 'FUJA SAEPULLOH', '252610244', '$2y$12$7C5gyTwQgPEVILQsPXtt/uhT.4dvP9ZPPaT/luHU715HyDHV/X6yG', 'siswa', '2025-08-24 21:12:12', '2025-08-24 21:12:12'),
(676, 'HENDI SETIAWAN', '252610245', '$2y$12$nVB.loByKzQRzJLsAJqDZOa.ON72U8eLTJhi4Imd1sqbV2dhJwpV2', 'siswa', '2025-08-24 21:12:12', '2025-08-24 21:12:12'),
(677, 'KARNATA JAYADI NINGRAT', '252610246', '$2y$12$ins6jTmfSpStyNTaj6GCVuEg0YgApg4uqAFCARYhwzTnPj0Zyjv3e', 'siswa', '2025-08-24 21:12:13', '2025-08-24 21:12:13'),
(678, 'MUHAMAD KHAIRUL INIESTA', '252610247', '$2y$12$ZKa7nIwnqFfb18IA8ICbhu.TCXoVrM78iHlXe4NpdiSd3M7KrcvJu', 'siswa', '2025-08-24 21:12:13', '2025-08-24 21:12:13'),
(679, 'MUHAMMAD DANIAL ALPIKRI', '252610248', '$2y$12$hzEUw6j5oK/LsaTT7cPDG.oNeX1/GtRUtym8/8vh8GqY9KHn3lYpa', 'siswa', '2025-08-24 21:12:13', '2025-08-24 21:12:13'),
(680, 'NENENG HABIBAH', '252610249', '$2y$12$gsAMqHQRc7h7i2kySkcfOe40kgFUdAyA6.KkWz6RhDq.DfD9dd2wS', 'siswa', '2025-08-24 21:12:13', '2025-08-24 21:12:13'),
(681, 'NOVAL JUNIAN SALEH', '252610250', '$2y$12$MdDmXUdUh.oN.FdlUbQy7.QcSIU0XQCEdtHbRLFUkQSZp5YkqKAcu', 'siswa', '2025-08-24 21:12:14', '2025-08-24 21:12:14'),
(682, 'NUAF DHANU WINATA', '252610251', '$2y$12$oKmc2nfbn.ZHystBFy9MpeaOzzCAE77kRGgi.I.sVOefmHWc5p4dC', 'siswa', '2025-08-24 21:12:14', '2025-08-24 21:12:14'),
(683, 'RAIHAN ABDUL YAFIDZ', '252610252', '$2y$12$XkgIIy4s7UX4f7Nw8aVE3O52r05w9Wg54YLsFG5Jh555IwekXKXTC', 'siswa', '2025-08-24 21:12:14', '2025-08-24 21:12:14'),
(684, 'REIHAN FIRMANSYAH', '252610253', '$2y$12$3DmSmRKpsec0ODDvty5ur.8GsIPqPF9CQVEGV0l6lsH1GrJxpztMC', 'siswa', '2025-08-24 21:12:15', '2025-08-24 21:12:15'),
(685, 'RIO RAMA', '252610254', '$2y$12$P.1gkEwXqbl3y3G26AsslOVpGHvxVqD8rVqK/iOcP3WqAVN0UqbX6', 'siswa', '2025-08-24 21:12:15', '2025-08-24 21:12:15'),
(686, 'RITA FITRIA', '252610255', '$2y$12$hsVBwyMDsFWV5QKRSO8/MO/UWpUlNtZ0s0IL61emL4ItMdWhrbBjW', 'siswa', '2025-08-24 21:12:15', '2025-08-24 21:12:15'),
(687, 'ROFIKOH ALIYATUL SUNIAH', '252610256', '$2y$12$4i3cyufJ0WTvHecOBIs.TOVm5Oou.CjjuGq9DKFLmifoH7mQR6ML2', 'siswa', '2025-08-24 21:12:15', '2025-08-24 21:12:15'),
(688, 'ROSAM CAKRA WINATA', '252610257', '$2y$12$tSgQ9XNLZgb3z9wYizyVAum424axwPLfwe.jtXbhfXTL.WwLOqNlq', 'siswa', '2025-08-24 21:12:16', '2025-08-24 21:12:16'),
(689, 'SAEFUL GOFAR', '252610258', '$2y$12$UZheR68CY3rO8C6A3UuGk.56CuqDIcDODn0qAQEB1L0mX0RhZaTDW', 'siswa', '2025-08-24 21:12:16', '2025-08-24 21:12:16'),
(690, 'SAEPUL MAULANA', '252610259', '$2y$12$s2OvUydlCziPLG/3dwcEsue2vs6H0i7NOkGYuWsUF2vJFK7anX8O6', 'siswa', '2025-08-24 21:12:16', '2025-08-24 21:12:16'),
(691, 'SETIYAJI AHMAD FAUZI', '252610260', '$2y$12$MeQisnQ7Efl64moQJB3hjuyQAFRs3TzM9inXdh0lRUaYbAkkBbQTG', 'siswa', '2025-08-24 21:12:16', '2025-08-24 21:12:16'),
(692, 'WINDY OCTOVIYA', '252610261', '$2y$12$4KJ4EBJB5Ki5jRweK0CzgehCCqMJnHyTbXNmjr6jxX.VliaYWD.TS', 'siswa', '2025-08-24 21:12:17', '2025-08-24 21:12:17'),
(693, 'YUDI ADITIA', '252610262', '$2y$12$8oNF5WyFezD5/IOGKK8mcu9jeZQb8SfJ5tVvCbEK.ewc4qKAC5VI6', 'siswa', '2025-08-24 21:12:17', '2025-08-24 21:12:17'),
(694, 'AMELIA', '242510001', '$2y$12$qShHqNHSv6uacgXs9l1GF.jbUbbhJNwGHMest8Q9hfrzoM32PezM6', 'siswa', '2025-08-24 21:23:29', '2025-08-24 21:23:29'),
(695, 'ANISA RHAMADANI', '242510002', '$2y$12$3zjDX97lkG.oVFu4xmuqju38y3QWHqJsXkqYWwtxAwZ9yhC87LRJ2', 'siswa', '2025-08-24 21:23:30', '2025-08-24 21:23:30'),
(696, 'AYU NINGRAT', '242510003', '$2y$12$jzfwCYstVDIwmZOOAr9WQOVojZPtWE3t8yeXEEsVzQY0vhqcsEdP2', 'siswa', '2025-08-24 21:23:30', '2025-08-24 21:23:30'),
(697, 'CINDI LESTARI', '242510004', '$2y$12$AlV/9.sCdFFdm93gWcHqaOogKiNqBvSNh9SiVtE63nzJlcQ/WqyLu', 'siswa', '2025-08-24 21:23:30', '2025-08-24 21:23:30'),
(698, 'CITRA SHABILA IRAWAN', '242510005', '$2y$12$NCd83pq5cyHT2wxRi80bV.604OG6U.pmShpQF1JKtjYUsusk2uXlC', 'siswa', '2025-08-24 21:23:30', '2025-08-24 21:23:30'),
(699, 'DENITA SARI', '242510006', '$2y$12$ihF4GeZxs7WfWJc0XdTYFe5SEMXqg97EZUYTqpCXKgSPHRIg.1Ufi', 'siswa', '2025-08-24 21:23:31', '2025-08-24 21:23:31'),
(700, 'EVI NURAENDI', '242510007', '$2y$12$8A5AguVjF4arZpUQhQPKsOYS6okFaBm2TlYKfK9dVEGbtNqZAt7mG', 'siswa', '2025-08-24 21:23:31', '2025-08-24 21:23:31'),
(701, 'INTAN LESTARI', '242510008', '$2y$12$Aoj3/2kgKkTYH88cClHng.C5/jdg9durSvfhkmLDbcppe8UG16Dh2', 'siswa', '2025-08-24 21:23:31', '2025-08-24 21:23:31'),
(702, 'INTAN RASJI RAMADHANY', '242510009', '$2y$12$c6UCmv3PEe5Qx7ssT1zVveUstcLiNuNBPoNhHXzxDYDiuT4nDlYoW', 'siswa', '2025-08-24 21:23:31', '2025-08-24 21:23:31'),
(703, 'KARLINA', '242510010', '$2y$12$rCK9T/N9S7Qqqvw/bUy6k.iKE8kK3e9gXsK51dCuVj/AlIF3cTEUy', 'siswa', '2025-08-24 21:23:32', '2025-08-24 21:23:32'),
(704, 'KURNIA', '242510011', '$2y$12$MQE2.JoPyaB3K.HO9Qcv5O87lGdDpc2EKhCWKB.qOFtlvl24F1W7m', 'siswa', '2025-08-24 21:23:32', '2025-08-24 21:23:32'),
(705, 'MAHENDRA', '242510012', '$2y$12$xe5YRDOrB7sNvuyumvWDSeKHWLMO1cZ2a9TjE5nFUPhp4xtdR8Xw.', 'siswa', '2025-08-24 21:23:32', '2025-08-24 21:23:32'),
(706, 'MARPUAH', '242510013', '$2y$12$wAfSnKnl4rDVbcNZT43rEO.dDUiva54qJmNvEwzpJYABQ8S6zaXTO', 'siswa', '2025-08-24 21:23:32', '2025-08-24 21:23:32'),
(707, 'MAULANA ANSORI SURYANA', '242510014', '$2y$12$bqVdK8/lccUgKYVeueJgEuFLNuMuiVQ.1732hbCnXQntJUvzY/w76', 'siswa', '2025-08-24 21:23:33', '2025-08-24 21:23:33'),
(708, 'MAYLANI', '242510015', '$2y$12$ydiG3if2Oc1n6ZU/hQGleOCz.tASc0zxkeAefgGZYbzfx/U/061/2', 'siswa', '2025-08-24 21:23:33', '2025-08-24 21:23:33'),
(709, 'MUHAMAD ADHI SATRIO', '242510016', '$2y$12$X/8RE6NT0mldWsBZU5M3lO471l1.rN3mRhKUXupy0j./5jloUrJpO', 'siswa', '2025-08-24 21:23:33', '2025-08-24 21:23:33'),
(710, 'NUR SILVA OCTAVIA', '242510017', '$2y$12$sw9B582VQFm7AgQzri6mu.u4nNc0CY8ocfUmxLWHQlpoVRrOFKkFi', 'siswa', '2025-08-24 21:23:33', '2025-08-24 21:23:33'),
(711, 'NURMALA PUSPITASARI', '242510018', '$2y$12$2lk1tjp7VFi7ztYqoUeqe.hFwZWgZPucQ9/.D2ApneYLQHtyUe05K', 'siswa', '2025-08-24 21:23:34', '2025-08-24 21:23:34'),
(712, 'QORIATUL FITRIYAH', '242510019', '$2y$12$/SUA4pI0fOTczWTBa1j7JOjkb3lH./7.KKXXZ6/Rk8Wt/wHqqQEHG', 'siswa', '2025-08-24 21:23:34', '2025-08-24 21:23:34'),
(713, 'RAHMA PUSPITASARI', '242510020', '$2y$12$8Dc2Md8sphHx2liNPjjyi.oCcy1JmBv6n2426tF3.4LKZq/Wo9CJu', 'siswa', '2025-08-24 21:23:34', '2025-08-24 21:23:34'),
(714, 'RISKA APRILIA', '242510021', '$2y$12$5vbZ4e0NcKHVOjkXnpYgY.q4IDGaXMIzi36OVfceG2Su11wjabA4m', 'siswa', '2025-08-24 21:23:35', '2025-08-24 21:23:35'),
(715, 'RISMAYANTI', '242510022', '$2y$12$B14Tm155iGzCI2HvMeoh9ORIzbVkoVY19VaCM3o4C8IwA0famtAAC', 'siswa', '2025-08-24 21:23:35', '2025-08-24 21:23:35'),
(716, 'SARAH INDRIYANTI', '242510023', '$2y$12$qGvPR7aEepY5/ULM83SSweR0W89QHvWxGEDLO8PO7K9b4ofGF3hwa', 'siswa', '2025-08-24 21:23:35', '2025-08-24 21:23:35'),
(717, 'SITI JAHROTULSYITTA', '242510024', '$2y$12$JSNTn9n7zkKpfA6fXi6x/erqNzYgzkjAb5HEXEQ.6CBxMtxl47OCu', 'siswa', '2025-08-24 21:23:35', '2025-08-24 21:23:35'),
(718, 'SITI NURHASANAH', '242510025', '$2y$12$NXubgHv9PItgmrk1JACdauW1vUkydKcpNQaQjgK30jqXE7SpH7E9u', 'siswa', '2025-08-24 21:23:36', '2025-08-24 21:23:36'),
(719, 'SITI NURPADILAH', '242510026', '$2y$12$CSyCPjOoXNcfZWLh3fchyOS8Mg1GM9rvOtuDQfJl5UkZtIvD2qtCW', 'siswa', '2025-08-24 21:23:36', '2025-08-24 21:23:36'),
(720, 'SITI SALAMAH', '242510027', '$2y$12$f3oVPnzyn.iPNzy9LcxrFeFGiOaczqTVBd.ZdKKs.INz.WdAZbopa', 'siswa', '2025-08-24 21:23:36', '2025-08-24 21:23:36'),
(721, 'SITI ZENAB', '242510028', '$2y$12$0cTX.OaeUk8YOG2AJXnlJeOdWG8oiGsRvm16ZxhsOJylYGxYNK98K', 'siswa', '2025-08-24 21:23:36', '2025-08-24 21:23:36'),
(722, 'SYAVIRA DWI NOVIANTI', '242510029', '$2y$12$alTx1hR3pwuQQPIX6SI6vurW.NvOdz7aEbwejkhOAQB569xcZNKFO', 'siswa', '2025-08-24 21:23:37', '2025-08-24 21:23:37'),
(723, 'SYIFAUDZIHNI', '242510030', '$2y$12$bOdXLf9JCH.d6ROv737vQOP533t.9IcYduakxWY6JGvE1Fp2.VYPa', 'siswa', '2025-08-24 21:23:37', '2025-08-24 21:23:37'),
(724, 'TASYA ANANDA', '242510031', '$2y$12$N5Rukt1B02khiSwLMKkjx.DbCc83nigrUQhb76imBCXPlUEYVTV3m', 'siswa', '2025-08-24 21:23:37', '2025-08-24 21:23:37'),
(725, 'TIKA DEWI', '242510032', '$2y$12$JB9JAmRho9mRvx26znVNuuKaloyyzQGJAfU2lnvbYewOYiTXr3f1S', 'siswa', '2025-08-24 21:23:37', '2025-08-24 21:23:37'),
(726, 'WILDA CAHYANI', '242510033', '$2y$12$6llK5HNyEVvJo7rcFItW4u2E7LVMHBE5x47CXRN2p5UjPGu2ddsya', 'siswa', '2025-08-24 21:23:38', '2025-08-24 21:23:38'),
(727, 'AISAH WALINAYAH', '242510034', '$2y$12$nEI8q.1FA95Ues9L9/fJTukJErrzAx6tCw4BaaAEjwiFsMm1oz3A6', 'siswa', '2025-08-24 21:23:38', '2025-08-24 21:23:38'),
(728, 'ANGGUN DARA CANTIKA', '242510035', '$2y$12$KYnXNl.99NDoIANdBliBauXPbvLDlpGBAZaTekMy6QSgi4yNtzqWe', 'siswa', '2025-08-24 21:23:38', '2025-08-24 21:23:38'),
(729, 'APRILIANI', '242510036', '$2y$12$Cq3ZBlWErQJdyNpuFBFKmehuMnV3b/zQYnARAlKXW/AKTvIVwEHO2', 'siswa', '2025-08-24 21:23:38', '2025-08-24 21:23:38'),
(730, 'ARUM', '242510037', '$2y$12$60SJtUYA/YN3vW4.rAe3AO0dK4rRstASqGJlgNTOMrQF3cA60BRP.', 'siswa', '2025-08-24 21:23:39', '2025-08-24 21:23:39'),
(731, 'CITRA NURY RAHMAN', '242510038', '$2y$12$doTZca0WYV3xNcw2AzG.k.pQZeORARuBl7WhGAw1Wvn2bd8jNbpuu', 'siswa', '2025-08-24 21:23:39', '2025-08-24 21:23:39'),
(732, 'DEDEH FAUZIYAH', '242510039', '$2y$12$CCXoHd3pGfx.8e2AheqhsO20ZvIVpn5Pr5cGASoV2ZrwOTMx65mw6', 'siswa', '2025-08-24 21:23:39', '2025-08-24 21:23:39'),
(733, 'DEVI YULIANI KUSMANTO', '242510040', '$2y$12$22BR9N9AMF5CSuawFDe2Ju6F3IuJOV1d9WEnl6ksdbCEiId95waP2', 'siswa', '2025-08-24 21:23:39', '2025-08-24 21:23:39'),
(734, 'DINDA LESTARI', '242510041', '$2y$12$0Gx7sHkxCJa1.TxCGAFf1OkdPjI.rkNpB3Uye2q9Jnc.cCwMwJWT.', 'siswa', '2025-08-24 21:23:40', '2025-08-24 21:23:40'),
(735, 'ERNAWATI', '242510042', '$2y$12$o6Akr9bX5tJ7XRzbhahrQe7wXkkcuWgeywuKGSNcOGd9BN6rPRrO6', 'siswa', '2025-08-24 21:23:40', '2025-08-24 21:23:40'),
(736, 'INAYAH', '242510043', '$2y$12$TDOoe530nmjWZFApVSPb3uIuZc0p.aT1earm3Rupcy/0Mu5btT2Za', 'siswa', '2025-08-24 21:23:40', '2025-08-24 21:23:40'),
(737, 'LAILA', '242510044', '$2y$12$E3hWPz9mql/mfKuaYPwrc.Ly.KklTnSvp1TTXpybTf7jRn21YG0oy', 'siswa', '2025-08-24 21:23:40', '2025-08-24 21:23:40'),
(738, 'LUTIKA SUNDAWA', '242510045', '$2y$12$KmrxyxSQHXPNyKAcK4xkY.Bu9YD1qeD1w.yb.j8INlu/NxF5VXk2u', 'siswa', '2025-08-24 21:23:41', '2025-08-24 21:23:41'),
(739, 'MAULIDDIVA NAWWAROH', '242510046', '$2y$12$BvG1kaCd.b1L7sZ.DnCNv.R8Mzz3vRCkwoaDLAXWVQjjCNq7rlAk.', 'siswa', '2025-08-24 21:23:41', '2025-08-24 21:23:41'),
(740, 'MAYA MAESAROH', '242510047', '$2y$12$MtsJEpuSdftarLUUJZ9wGeVM.6BPQVJtyQd7J2Q.JbAB8CayGbSYC', 'siswa', '2025-08-24 21:23:41', '2025-08-24 21:23:41'),
(741, 'MELYANI', '242510048', '$2y$12$k5ZaIrH4ApuUkI4QxwqFuu3PcvUpp3QxZCC0DBaRA7HTbJpXxtMoy', 'siswa', '2025-08-24 21:23:41', '2025-08-24 21:23:41'),
(742, 'MIA BIATUL QOYA', '242510049', '$2y$12$ShdOfOJPNjjtYOdFj7TCJecLR91MaLal1Ho65k6fEBx1nHjldDR7G', 'siswa', '2025-08-24 21:23:42', '2025-08-24 21:23:42'),
(743, 'MUHAMMAD RAFFA RODIYANA', '242510050', '$2y$12$QCrWNCYBMwpJ.1gMDfzG9e5ay7hMU6BRsZalu6OO/.K3kb5NKmW9G', 'siswa', '2025-08-24 21:23:42', '2025-08-24 21:23:42'),
(744, 'NAJWA FITRIA AZZAHRA', '242510051', '$2y$12$/6X2dKxHoKTbZGNaZLd1TO2J3.mfw8wh1smJEO.i6c06LKYlSv/7i', 'siswa', '2025-08-24 21:23:42', '2025-08-24 21:23:42'),
(745, 'NINING NURFALAH', '242510052', '$2y$12$QyxoSIgtEwZFBh6TG5GVaOrQ15e/WQd7pPA0dHVaPmYCno2JjdYsG', 'siswa', '2025-08-24 21:23:42', '2025-08-24 21:23:42'),
(746, 'NORMAN HIDAYATULLAH', '242510053', '$2y$12$.KYhSqvZsMI8dpnzsHe7te5W48skPnsRYc5rQMdQK/kd8l1LCmf.u', 'siswa', '2025-08-24 21:23:43', '2025-08-24 21:23:43'),
(747, 'NOVI SEPTIANA RAHMADANI', '242510054', '$2y$12$AufUJ004axi4OsJ8lUmHIu4tdYnweTqVWsccuiZEjeBJfstybKE76', 'siswa', '2025-08-24 21:23:43', '2025-08-24 21:23:43'),
(748, 'NURMALA', '242510055', '$2y$12$9DY3oI4y6z/.tppyv54qYOnW1PR5hD3KKubimE.fXD/X0QmquvmYm', 'siswa', '2025-08-24 21:23:43', '2025-08-24 21:23:43'),
(749, 'PUTRI SALSABELA', '242510056', '$2y$12$MOYan/FiK6KYfo16lGcymOS0Lvd5t0UpSZfq1WmEz5aaxZ9ws6TDe', 'siswa', '2025-08-24 21:23:44', '2025-08-24 21:23:44'),
(750, 'RANI', '242510057', '$2y$12$TRbIeD9gma5GWiMxgx5n4er4DSbidLqRrLMRdDkmd1zngoTENFdHC', 'siswa', '2025-08-24 21:23:44', '2025-08-24 21:23:44'),
(751, 'RIRIN EKAWATI', '242510058', '$2y$12$.VDLRyRYugOFSqAQD6alOeX5w9GuZmX.xCmqcRsFuSskNVEYG36em', 'siswa', '2025-08-24 21:23:44', '2025-08-24 21:23:44');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(752, 'SARASWATI', '242510059', '$2y$12$gfkUlBglyZXwvVkXAUtv5uO/4OFG1eNH5l65PnaTf2sCIu.W5Lg1e', 'siswa', '2025-08-24 21:23:44', '2025-08-24 21:23:44'),
(753, 'SITI NURJAMILAH', '242510060', '$2y$12$yDvZhqnmVKcT5GNt70kMHeHttj/h02X699JaAYzCVzHMk5y7Z8kwq', 'siswa', '2025-08-24 21:23:45', '2025-08-24 21:23:45'),
(754, 'WIWIN NURMAULIDA', '242510061', '$2y$12$AJyeEmXtTi11lvaUFKsDaOQjRNTKAWZO6ToYzCZeqsX/FTvJlifza', 'siswa', '2025-08-24 21:23:45', '2025-08-24 21:23:45'),
(755, 'WULAN SARI', '242510062', '$2y$12$4UcSmkJP3x.5laxk9OC2KeW77tN3crNqGXSRXEtL7T3oaMgilP3.m', 'siswa', '2025-08-24 21:23:45', '2025-08-24 21:23:45'),
(756, 'ZAHRA AYUMI', '242510063', '$2y$12$NgnMBnlrGsXLtOnj98Ab3e2CLDT.8VpvG6qshqEUDCs7Kb2jrejr.', 'siswa', '2025-08-24 21:23:45', '2025-08-24 21:23:45'),
(757, 'ZAHWA AENURROHMAH', '242510064', '$2y$12$5Tq3u3rCjwEi1bkx9DQDKer0gkTB9U5YReojOMif6Rg4KLOFO6Atm', 'siswa', '2025-08-24 21:23:46', '2025-08-24 21:23:46'),
(758, 'ABDUL SODIK', '242510065', '$2y$12$sHPaK5YRVt1DGqlBPw7sxu3SN30ByDXtc.3EGp1ZbnGHo5DM6jxE.', 'siswa', '2025-08-24 21:23:46', '2025-08-24 21:23:46'),
(759, 'AGNAN HAMBALI', '242510066', '$2y$12$5uXSkRWx2ecXzoampxTEe.nXfsNKCuEQbv5gBNK2mh1t0E418HlFi', 'siswa', '2025-08-24 21:23:46', '2025-08-24 21:23:46'),
(760, 'AGUS MULYANA', '242510067', '$2y$12$bw/0TfCA4ybkc8lYB0wqMOECB1lwJ2sTNILNVCV0yyvArMtt8X6P2', 'siswa', '2025-08-24 21:23:46', '2025-08-24 21:23:46'),
(761, 'AKBAR DHANI', '242510068', '$2y$12$SgR/BYNXIzSWZCV2U8RkPOx.USwk6jejrTbioXg8KOVPqsZx9q.8y', 'siswa', '2025-08-24 21:23:47', '2025-08-24 21:23:47'),
(762, 'ALDI FAUZAN', '242510069', '$2y$12$vSCs4HS49pmvCl5N4VR7aOE6gqWvyhpq70wT4PMDVpAJmiglgxLjy', 'siswa', '2025-08-24 21:23:47', '2025-08-24 21:23:47'),
(763, 'ALDIEN AKBAR', '242510070', '$2y$12$cIAIx1soEIofUrzv1hCQg.srD/ruLbUrqCe0tfSs8lSIygQ6pVN46', 'siswa', '2025-08-24 21:23:47', '2025-08-24 21:23:47'),
(764, 'ALPI SAEPUL AKBAR', '242510071', '$2y$12$p3X2PUkIgguUf.4qo0JDreWEMOtf.4o.gQuqdthkmkWIi69pflYCS', 'siswa', '2025-08-24 21:23:47', '2025-08-24 21:23:47'),
(765, 'ANDIKA SYAPUTRA', '242510072', '$2y$12$1WoKoFioUTf58G8gmhB1YeXGdwkadRONvFA7kFUL27FypJjOJbYWm', 'siswa', '2025-08-24 21:23:48', '2025-08-24 21:23:48'),
(766, 'AYOM PRAYOGA', '242510073', '$2y$12$OopRsg5ojFNUUDhHT8dwGuSvUo8sdUAsqw6ZNAvXabVxvdDb3t2YK', 'siswa', '2025-08-24 21:23:48', '2025-08-24 21:23:48'),
(767, 'CAHYONO MAULANA', '242510074', '$2y$12$khJb5mWG7c9FZDGkCAn3BunODUuTcIqh5nohbkUDGBXKIq37Wd0Xq', 'siswa', '2025-08-24 21:23:48', '2025-08-24 21:23:48'),
(768, 'DIMAS PRADIPTA FUDHOLI', '242510075', '$2y$12$.p.fMMiqqk7J0hAhcagFxuBYoqmUeyCDj5z2NUuc/XL6l2fSec/Pq', 'siswa', '2025-08-24 21:23:48', '2025-08-24 21:23:48'),
(769, 'EKA RAMDANI JUNAEDI', '242510076', '$2y$12$8yyXankA7ORHaGATZIriQO0qm35K5atJbakrn6Ebi5vhbWZel7uC2', 'siswa', '2025-08-24 21:23:49', '2025-08-24 21:23:49'),
(770, 'EVA NURAENDI', '242510077', '$2y$12$6cGQvcr5p8kab67I0ooopetZg4Z1jK4SeR9w79Dnrv45NNJlN66Ra', 'siswa', '2025-08-24 21:23:49', '2025-08-24 21:23:49'),
(771, 'GENTA TENGGARA BADAY', '242510078', '$2y$12$GJIYJ.Moycx7nD.AGAzHE..l1PtLgMYD8R/fBI1blAbXRtfNUnXZ.', 'siswa', '2025-08-24 21:23:49', '2025-08-24 21:23:49'),
(772, 'INTAN NURJANAH', '242510079', '$2y$12$ZCZ7utmf5A1JZsFUggds1.oWwq0THtk62ca4PxK0hIZXLv4NeiILq', 'siswa', '2025-08-24 21:23:49', '2025-08-24 21:23:49'),
(773, 'IRPAN HERMAWAN', '242510080', '$2y$12$mFWUNB1SXx2jFREBaA9QDOd.D.gb3BiSsQH1MKUtPRelzmighpL2y', 'siswa', '2025-08-24 21:23:50', '2025-08-24 21:23:50'),
(774, 'MUHAMAD YAHYA', '242510081', '$2y$12$BbIdROWQ.oBYKIpovo/Ct.MygBd/0Ah8hVwOz2HSW9bcbnBax68cy', 'siswa', '2025-08-24 21:23:50', '2025-08-24 21:23:50'),
(775, 'NABILA JULIANY', '242510082', '$2y$12$uKuD808OESXPULJjq.XbQeHRfSDM7HlNVjWpIWFidRHUoU/EKawpu', 'siswa', '2025-08-24 21:23:50', '2025-08-24 21:23:50'),
(776, 'RAFI MAULANA LILAH', '242510083', '$2y$12$Iqg3YMflhk5O6BELFhmqgOSYCbYJstrHegSOxKmbH8gnmKmPtpD46', 'siswa', '2025-08-24 21:23:50', '2025-08-24 21:23:50'),
(777, 'RAMA ALDIANSYAH', '242510084', '$2y$12$KihbZPVhPL1xTo6ep..MvO4Dr1vsUtIR.wMzxsjFI8W5IjcJMcvR2', 'siswa', '2025-08-24 21:23:51', '2025-08-24 21:23:51'),
(778, 'RAMA HERDIANSYAH', '242510085', '$2y$12$FGs3yNLTE7OjUM6MR.70geiPCzA1e9ns5O.42DojJvfyvmauoIbsu', 'siswa', '2025-08-24 21:23:51', '2025-08-24 21:23:51'),
(779, 'REDI', '242510086', '$2y$12$Rz/bGOa9l9kkjmhNYxqD4ukcwG6MNVojDWLZBngQ9..FXM5sUBrJS', 'siswa', '2025-08-24 21:23:51', '2025-08-24 21:23:51'),
(780, 'REGIA NANDA FEBRIATAMA', '242510087', '$2y$12$n6hA0DWzd.UHYVK7sX0IpuysDpKx9EchdVH2VhUJWovcTt.WeTbNW', 'siswa', '2025-08-24 21:23:51', '2025-08-24 21:23:51'),
(781, 'RIFKI MULYANA', '242510088', '$2y$12$4KiI30ZLAtN7rX0/Kvx/u.R2bBTW6.LL4GDL0xNNiHpZQLvym6ZMK', 'siswa', '2025-08-24 21:23:52', '2025-08-24 21:23:52'),
(782, 'RIZKY ADITIYA', '242510089', '$2y$12$FtbZuGf2OiZTU0q1AafKoO/LflXMzFImSfbCxN/PmeXwOON3mjWx6', 'siswa', '2025-08-24 21:23:52', '2025-08-24 21:23:52'),
(783, 'RIZKY AZIZ MAULANA', '242510090', '$2y$12$dxPiU9u6L3C3cska8pLOZeHEhM5d9GKWpc9tPOKb6PnQrX9xbQ3NW', 'siswa', '2025-08-24 21:23:52', '2025-08-24 21:23:52'),
(784, 'SITI MARIYAM', '242510091', '$2y$12$Q5O9J2rNzdteuvvC1vHtOed3cAkjrrn4zk8AJh92yhuKB1YHFIHM2', 'siswa', '2025-08-24 21:23:53', '2025-08-24 21:23:53'),
(785, 'SYAHRILLA PERMATA NUSANTARA', '242510092', '$2y$12$F.6giEf2b0pGvGwv.c1bRengIO4mZITz8fEU/YOa6AOkhDcHmxxbS', 'siswa', '2025-08-24 21:23:53', '2025-08-24 21:23:53'),
(786, 'WIBY KURNIAWAN', '242510093', '$2y$12$zxtK/jlOIw2UcSIJShmF2uOCNYdU1A/7i0ce.k0/FDj6ylpAwqItK', 'siswa', '2025-08-24 21:23:53', '2025-08-24 21:23:53'),
(787, 'WIDIYA ANISA PUTRI', '242510094', '$2y$12$Bczg/gYAugBd8u.RCAaFVu0ZFbf33V5dSwOcmCr1XdiGu15/CGOmS', 'siswa', '2025-08-24 21:23:53', '2025-08-24 21:23:53'),
(788, 'WINDY DANUARTA', '242510095', '$2y$12$iQMmbBwm3lrawpjSTxvX2.aaaXmYYBPpnrbfilCNOF7nqBtI22G6W', 'siswa', '2025-08-24 21:23:54', '2025-08-24 21:23:54'),
(789, 'YUDI MULYANA', '242510096', '$2y$12$ykHWLfo.S.W6XUywYcfYGeVI40yV8AA.bBK/1mcR7PcVs5vTh2eDS', 'siswa', '2025-08-24 21:23:54', '2025-08-24 21:23:54'),
(790, 'ADITTIYA SAPUTRA', '242510097', '$2y$12$iXISN3MA7HmsgTkwpumdzuIpjvHxPpMb51Ix/oDHYvPEZie7gq8.C', 'siswa', '2025-08-24 21:23:54', '2025-08-24 21:23:54'),
(791, 'AFDAL ZIQRI RAMADAN', '242510098', '$2y$12$Z1FjHWSQbUsie0YpQPFaWedomBrIJ2kbnNJnXuKvwnN./GH1v4K3K', 'siswa', '2025-08-24 21:23:54', '2025-08-24 21:23:54'),
(792, 'ANDIKA EKA SAPUTRA', '242510099', '$2y$12$HxA8w183ctRGxXLl9Qe.FOOADzTgPoOfvPwkNw6V8xcP3a4Ybv7D2', 'siswa', '2025-08-24 21:23:55', '2025-08-24 21:23:55'),
(793, 'ANGGUN RIANA PUTRI', '242510100', '$2y$12$apiVcwcARkHMoZUnCr0louJ9PO2qhsPeTOxrpFxN/20ZmUuB7mZNK', 'siswa', '2025-08-24 21:23:55', '2025-08-24 21:23:55'),
(794, 'APRIZAL SUGANDA', '242510101', '$2y$12$rhjudCyVV.aXE7DnEBUVVOYLisnOQd5KVfpJ8KpKly1flhv6JVMDa', 'siswa', '2025-08-24 21:23:55', '2025-08-24 21:23:55'),
(795, 'ARDIANSYAH', '242510102', '$2y$12$S.m9nW3XXBsu/kvj7eMzTuhR9sJiLGKO6RF2hsgpEr4VsXG9b9rke', 'siswa', '2025-08-24 21:23:55', '2025-08-24 21:23:55'),
(796, 'ARIF JUNAEDI ABDILAH', '242510103', '$2y$12$8fY7thqUpTg1BtXglmppieDbXPDnp6UxORorO1c/aokPpM0oHrcrC', 'siswa', '2025-08-24 21:23:56', '2025-08-24 21:23:56'),
(797, 'ASIAH NURAZIZAH', '242510104', '$2y$12$C4Ush017CCIjRwO55RS0feA9FJMEqqCD4WTXDWHyH.7QvNthdDyDi', 'siswa', '2025-08-24 21:23:56', '2025-08-24 21:23:56'),
(798, 'DIMAS', '242510105', '$2y$12$1KhitpxTG5CMw7fPLXTm3OV/02pQ6TADLV1Iqoe7cRDnKbgbPKa7e', 'siswa', '2025-08-24 21:23:56', '2025-08-24 21:23:56'),
(799, 'DIO PRATAMA', '242510106', '$2y$12$PLG74wJSv7OP57ewzjNG8e1PwXLWFgg1OADZRAgaF5qv3K1SbZXVe', 'siswa', '2025-08-24 21:23:56', '2025-08-24 21:23:56'),
(800, 'FACHRI MUHAMAD SOFYAN', '242510107', '$2y$12$nHZyiSVFLiL50mADOrWnyu42oOeaR5srAU6YY4A8UvE7lariVAoiK', 'siswa', '2025-08-24 21:23:57', '2025-08-24 21:23:57'),
(801, 'FAHRI HAMDANI', '242510108', '$2y$12$8hKQMZRg4GhV9uDeuLr6aeIJA/R0soHDU2vB1C7PGNhiTmp5jOrG.', 'siswa', '2025-08-24 21:23:57', '2025-08-24 21:23:57'),
(802, 'FERRY SEM JULIANTO', '242510109', '$2y$12$jq4uwOiUvnb6vyPnmT79x.UuH2SLqgBz2dJtRZa0rsuZXhfrfCX1O', 'siswa', '2025-08-24 21:23:57', '2025-08-24 21:23:57'),
(803, 'GUNAWAN GUNTUR', '242510110', '$2y$12$hjlVPDuvYSgcVWuJqMXyxuQ0gtI8PEJ4fcBq590Xntkp0lQj6W/p2', 'siswa', '2025-08-24 21:23:57', '2025-08-24 21:23:57'),
(804, 'IRMAWATI', '242510111', '$2y$12$sdIvu7YPFrWyopzqOjXii.UB8iUIQTkwIbdZmilMn.rgfhkYPEs8O', 'siswa', '2025-08-24 21:23:58', '2025-08-24 21:23:58'),
(805, 'ISMAIL NURJAYA', '242510112', '$2y$12$.pFRrG3dFUHShWoA58vzWezGxAojhidKAnHBPQ7/KAtVT1U5Cp9Me', 'siswa', '2025-08-24 21:23:58', '2025-08-24 21:23:58'),
(806, 'LUTPIAH', '242510113', '$2y$12$I2TK48q.pxq3tu1T0D1byey6E4X8JIXvlv1qqJuyIbJIx4.VUddrG', 'siswa', '2025-08-24 21:23:58', '2025-08-24 21:23:58'),
(807, 'MUHAMAD FAIS', '242510114', '$2y$12$cLsCCa8b8AbJzUnylA1Hx.9xK0RPYmmVLqAmenulnMhKDRTbkc5.m', 'siswa', '2025-08-24 21:23:58', '2025-08-24 21:23:58'),
(808, 'MUHAMAD MUMIN', '242510115', '$2y$12$C4SRaDxANCvBJUAgmEEAqezyyUa0Mldp/0WU0A5rcflYJyiIzGTkC', 'siswa', '2025-08-24 21:23:59', '2025-08-24 21:23:59'),
(809, 'MUHAMAD NUSHA BADARI', '242510116', '$2y$12$f6iguToC2rmErKZjHmAOHudKnGTCf6XBkoBQgcfoMU2r9602yj7Je', 'siswa', '2025-08-24 21:23:59', '2025-08-24 21:23:59'),
(810, 'MUHAMMAD PALESTIN', '242510117', '$2y$12$/iI5uDyLpmjRqBpI/Upjm.BTnSzKjC0i8gzheMtTv5CUfzF2qkRvO', 'siswa', '2025-08-24 21:23:59', '2025-08-24 21:23:59'),
(811, 'MUHAMMAD RAFFI ALFARIS', '242510118', '$2y$12$E9W9IZFLzR9wmYFXydrlGuPbP7SuuW4Pti28JPidGy9FatQAKOtRK', 'siswa', '2025-08-24 21:24:00', '2025-08-24 21:24:00'),
(812, 'MUHIDIN', '242510119', '$2y$12$hQwxX2FYDJz9bGCvxjij.eley5cBn7ibZ0897X3fSkQqxQpe1O0cK', 'siswa', '2025-08-24 21:24:00', '2025-08-24 21:24:00'),
(813, 'NURHAYATI', '242510120', '$2y$12$FQuPA5dIYKmMYKTUfgzY1.l6ky3Ddazlo4MJtreA7nDGQNG7uBcaK', 'siswa', '2025-08-24 21:24:00', '2025-08-24 21:24:00'),
(814, 'NURSIAH', '242510121', '$2y$12$uTtzZypjo.BTKL3I5QqcHOV9H80Zr1AAWxCsdJljkS/0iOR5eL5fG', 'siswa', '2025-08-24 21:24:00', '2025-08-24 21:24:00'),
(815, 'ROHMANA', '242510122', '$2y$12$60692lPfaGNs5UE7FpAiHeUH3Lt9GDg83Lyxcjm8vNrPqHAy3SzcS', 'siswa', '2025-08-24 21:24:01', '2025-08-24 21:24:01'),
(816, 'SYARIP NASRULLOH', '242510123', '$2y$12$JvLbKkIMooaRRYnOC2jIr.cLNP1REc5LP6APQ0Ef1aksgj..gQBY2', 'siswa', '2025-08-24 21:24:01', '2025-08-24 21:24:01'),
(817, 'TAMAMI', '242510124', '$2y$12$wTD5cYWplGJBGWi.CGDo1e5u1wP5k9p9z9a8GbLVC4NlyrsRAMdZ.', 'siswa', '2025-08-24 21:24:01', '2025-08-24 21:24:01'),
(818, 'ABDUL GANI', '242510125', '$2y$12$2C39ttOoI2wTHsrqwhAnxuXWyFArrOIqAd7S60uBs4edcv3NC4VZW', 'siswa', '2025-08-24 21:24:01', '2025-08-24 21:24:01'),
(819, 'AHMAD DANU', '242510126', '$2y$12$4ORoVIZHHr5JXnJ/BceOb./Efn9J0mwATHGpfO2.VHLA7Kjop3cOG', 'siswa', '2025-08-24 21:24:02', '2025-08-24 21:24:02'),
(820, 'ALMASUL ANAM', '242510127', '$2y$12$2vef7p5vd5zSksl8XbwljeZkDLufa2P2v7VPLKJOlTihiY3gkhWp2', 'siswa', '2025-08-24 21:24:02', '2025-08-24 21:24:02'),
(821, 'APRIANSYAH KARIM', '242510128', '$2y$12$zdJBXZjn5WJabIHn62Z3zeWVhv01Ib0zxBlRb8WUf5Br459daFG.q', 'siswa', '2025-08-24 21:24:02', '2025-08-24 21:24:02'),
(822, 'APRIYANSYAH', '242510129', '$2y$12$1OLETkZnC0DInMmvSsDxROHWr/lC3TyFgyNTIa80FTYavqxn9yFeq', 'siswa', '2025-08-24 21:24:02', '2025-08-24 21:24:02'),
(823, 'ARYO SAPUTRA', '242510130', '$2y$12$YyL7.7KYZOP.kPgXRFWVJuXvYbzRdLE3CjBLPG1UfkCKqtk9uBfke', 'siswa', '2025-08-24 21:24:03', '2025-08-24 21:24:03'),
(824, 'BELA CANTIKA', '242510131', '$2y$12$e7WSy9j8RTuk1ePAPrudguyhShS7qbqRYJwss5oOTyVD87LTw3pq2', 'siswa', '2025-08-24 21:24:03', '2025-08-24 21:24:03'),
(825, 'CASTIMAN', '242510132', '$2y$12$OKM5HLmJ7RD2q3igHeWHoe7qeKFwWQWfVxAW896ojPOm1xlLd9we2', 'siswa', '2025-08-24 21:24:03', '2025-08-24 21:24:03'),
(826, 'DAVI BAHTIAR', '242510133', '$2y$12$VignYCOHeGyDXI.apmTW8upHbd/4xFZ1kZXfDwpoZd00JRwdLYn0e', 'siswa', '2025-08-24 21:24:03', '2025-08-24 21:24:03'),
(827, 'DELIMA', '242510134', '$2y$12$bLFqrMpG0PuUKNM.ISxZ0OCdQ9hnpHETbamiA8BAhPNp.osrE.coi', 'siswa', '2025-08-24 21:24:04', '2025-08-24 21:24:04'),
(828, 'EKO ADI SUCIPTO', '242510135', '$2y$12$VIZVHS3BtYC7ilKEVhSdhOKFPLQRPI./qIGjVZMEJSSOmfviFMMkO', 'siswa', '2025-08-24 21:24:04', '2025-08-24 21:24:04'),
(829, 'IBRAHIM SIDIK JAELANI', '242510136', '$2y$12$iDyomefX5afjObUK44X1G.lNDK7dnnjg70tyvTPiaiBWb/RhMk3b.', 'siswa', '2025-08-24 21:24:04', '2025-08-24 21:24:04'),
(830, 'ICANA', '242510137', '$2y$12$OLuIWLdgdW90xfYip.mY/.f9WugmvXoPbPGgkCGv7.G/tDV5pJbja', 'siswa', '2025-08-24 21:24:04', '2025-08-24 21:24:04'),
(831, 'IRPAN', '242510138', '$2y$12$2YDtNO47Sg/VCqWTzD/Vg.sVUbsrDqO.8lrwoU3uyK8baYRyXWA2S', 'siswa', '2025-08-24 21:24:05', '2025-08-24 21:24:05'),
(832, 'KHAILA SABINA', '242510139', '$2y$12$YF/ewqEdwwRfU/QowkOawOnrulT.8Ud.tBYJpDodpI8U0.D8hWS0G', 'siswa', '2025-08-24 21:24:05', '2025-08-24 21:24:05'),
(833, 'MUHANAD ABDULHADI', '242510140', '$2y$12$YSmMYhs8E/cP5ogAE/ULh.MRwJJi7M3JY6cp/6c.86pnS9Hi.1Kli', 'siswa', '2025-08-24 21:24:05', '2025-08-24 21:24:05'),
(834, 'NURLELA APRIYANTI', '242510141', '$2y$12$YM1JKqK2q1QRE756cAUv/eU0TEkvkITJ.zDamoahMGDTuX4OVhb8y', 'siswa', '2025-08-24 21:24:05', '2025-08-24 21:24:05'),
(835, 'PARIDHAH', '242510142', '$2y$12$/3z4oy7mNGQvj5w5b0Zgw.vvbeavgLECG/yAun.GTTMaKIH/FtS4i', 'siswa', '2025-08-24 21:24:06', '2025-08-24 21:24:06'),
(836, 'PASA NUR PADILAH', '242510143', '$2y$12$pkQVNkbJ0iyOlw1SAYGHiecT/xSAr3USFM9LraQj1nLk/HYijQDPm', 'siswa', '2025-08-24 21:24:06', '2025-08-24 21:24:06'),
(837, 'RAISYA ADITIA', '242510144', '$2y$12$t.Hv/h3XlBd.ABS8.OQtBO9UJjXlG4wVaQY7izbWPLeeBSFRmx69e', 'siswa', '2025-08-24 21:24:06', '2025-08-24 21:24:06'),
(838, 'RANATA', '242510145', '$2y$12$beeNEdYQsP7SKCSXi3X0h.OPFbt8aX.iviRJiPM1jJVUD6LA5hKh6', 'siswa', '2025-08-24 21:24:07', '2025-08-24 21:24:07'),
(839, 'RAPI RIPANSYAH', '242510146', '$2y$12$zCMtPZJldYmeO9gSjl9w..kgdrfp.y8UZcQzTBL88QBlaJ3TxIE3q', 'siswa', '2025-08-24 21:24:07', '2025-08-24 21:24:07'),
(840, 'RIPAT', '242510147', '$2y$12$HHx/Y8GEAl5gDEYZ5beVb.Qz8Ku8Q4TvKOM6V.LVLw044XgdmbRcO', 'siswa', '2025-08-24 21:24:07', '2025-08-24 21:24:07'),
(841, 'RIZIQ ABDUL WAHID', '242510148', '$2y$12$0eoZLEfrXe3Z/WnsCp4tvOA8MmvzK5RiqMUsg9Dt1qwVKJpsHWYmm', 'siswa', '2025-08-24 21:24:07', '2025-08-24 21:24:07'),
(842, 'SUCIKOH MAHARANI', '242510149', '$2y$12$U23iJbLWPwZBdUAmrwidiO5IAnypJ2aIaDsPpJTYbmQktDNZkxB8y', 'siswa', '2025-08-24 21:24:08', '2025-08-24 21:24:08'),
(843, 'SUKARDI', '242510150', '$2y$12$SACzErKQvFxkwQgLXxeaqOQ8XLGam1xSUhE.JEMrrG3T84sx8oxT6', 'siswa', '2025-08-24 21:24:08', '2025-08-24 21:24:08'),
(844, 'TIANI', '242510151', '$2y$12$t1T2ZGBt2xucv98jihGgsu9fVFs6sjW3bnf1Mvx5EOoKrj62JTdX.', 'siswa', '2025-08-24 21:24:08', '2025-08-24 21:24:08'),
(845, 'WAHAB TAJUDIN', '242510152', '$2y$12$gCtydr4C3Rh8d3Lieoomc.vKbwsX.531BwBbPNwp63b6mnXyWUOru', 'siswa', '2025-08-24 21:24:08', '2025-08-24 21:24:08'),
(846, 'AHMAD RIFKI RIFAI', '242510153', '$2y$12$RGHQCUDgHFDmpDD7MJP3meKFV4.dhtRkKQrJBDwshnIjbGlmC4huW', 'siswa', '2025-08-24 21:24:09', '2025-08-24 21:24:09'),
(847, 'ALDO PRASETYO ADAM', '242510154', '$2y$12$ZACsvUoUwxFl22qlF42cx.RhrbvTCXl7GRTr0KhbfW7AuW4vW1.Y.', 'siswa', '2025-08-24 21:24:09', '2025-08-24 21:24:09'),
(848, 'ARIS MUKTIA', '242510155', '$2y$12$q1kEcroykAlbSdeIAX.W9eh6lva5BBmb2WlodPXB61J8/otZLOLKW', 'siswa', '2025-08-24 21:24:09', '2025-08-24 21:24:09'),
(849, 'ARMAN RAMADHAN', '242510156', '$2y$12$5RJ/r0pcZMtslVe8AM2ocuyklojanf..DHGLxoX1MUxlNYnStKc3e', 'siswa', '2025-08-24 21:24:09', '2025-08-24 21:24:09'),
(850, 'DARMAWAN', '242510157', '$2y$12$rftkWPIKx26.47ESKxFr1.1rELbusnq9YlcboFZQdi3a/pNxAF6te', 'siswa', '2025-08-24 21:24:10', '2025-08-24 21:24:10'),
(851, 'DENI HARUN', '242510158', '$2y$12$sqr.pq/frXpGlD6xuJivLO5wiRUNGN4TLvsIpJzk9C5j2W0pIsfi.', 'siswa', '2025-08-24 21:24:10', '2025-08-24 21:24:10'),
(852, 'DIMAS', '242510159', '$2y$12$WqkdYFPbgJZXvO262JnTN.ShtrVurDt/GmyPsN8ALwGera2GNPJs2', 'siswa', '2025-08-24 21:24:10', '2025-08-24 21:24:10'),
(853, 'FAISAL ABDUL AZIS', '242510160', '$2y$12$oR/nFdF5H5e1eMVwasOptOqzUFXAE1TNBahn0SmNcZhNCcVopoyJG', 'siswa', '2025-08-24 21:24:10', '2025-08-24 21:24:10'),
(854, 'GALIH WARDANA', '242510161', '$2y$12$bzUK7eFfvPaM7yd3jDcWtOy7eG76/banGOIVtot1wuNCHau8oGcL6', 'siswa', '2025-08-24 21:24:11', '2025-08-24 21:24:11'),
(855, 'GILANG PERMANA', '242510162', '$2y$12$IZD45MWZ0nbKu9Nj3R.moOT.W58qVQv4DzS1yacjAUYSBg6rMSqm.', 'siswa', '2025-08-24 21:24:11', '2025-08-24 21:24:11'),
(856, 'HOTIMAH', '242510163', '$2y$12$ZQVlT8maHfEj04eKExwOV.Re4OGI564HocYiHaO3cu0Egw5T8Me4m', 'siswa', '2025-08-24 21:24:11', '2025-08-24 21:24:11'),
(857, 'ILYAS SUPANDI', '242510164', '$2y$12$IiLQw3r9un3YxrLaP3t5b.YMB7gRe.6A4SrjqZyrQzt9e8mliPoy2', 'siswa', '2025-08-24 21:24:12', '2025-08-24 21:24:12'),
(858, 'IRKI', '242510165', '$2y$12$KfatXueZ6/JXVrAOaDyR.usVGVLboM/r.5/qPoLC244H6DFJugRs6', 'siswa', '2025-08-24 21:24:12', '2025-08-24 21:24:12'),
(859, 'IRWAN', '242510166', '$2y$12$cC6QIu9TukIcrPhGBuMIrepYgkgUMKMG34wdFnjjdbvT.YhMcCQ0u', 'siswa', '2025-08-24 21:24:12', '2025-08-24 21:24:12'),
(860, 'KARDIANSYAH', '242510167', '$2y$12$bICC2GGtfz4bUQ9C.aH17uiLQUk7UyPnIGzp4Z.x/Gz/xexiNCRYO', 'siswa', '2025-08-24 21:24:12', '2025-08-24 21:24:12'),
(861, 'MEYFHA AKILAH', '242510168', '$2y$12$1Coc.0GBCbzeQnWcWfJ.suUT0tVKkaN3Do84i72pLPxbKjuqtNWxK', 'siswa', '2025-08-24 21:24:13', '2025-08-24 21:24:13'),
(862, 'MOHAMAD AKBAR', '242510169', '$2y$12$sq8OHrAvQf9y4JzfwWdHx.VL/OclH9nkL3D82MjeocX0Zq/q5QThC', 'siswa', '2025-08-24 21:24:13', '2025-08-24 21:24:13'),
(863, 'MUTIARA', '242510170', '$2y$12$L4ZK8Nrpvm.iSK41DW50v.tJq.ojTtDndeg50HsYAM8LjSv6Ubk8q', 'siswa', '2025-08-24 21:24:13', '2025-08-24 21:24:13'),
(864, 'NANANG ALDIANSYAH', '242510171', '$2y$12$DO4RXTSen9h0e2ArzT10/.O9bP7OywOVXmjbMlbQAUUgMoSb/8OA.', 'siswa', '2025-08-24 21:24:13', '2025-08-24 21:24:13'),
(865, 'PAHRUDIN', '242510172', '$2y$12$hPRfYXQJ6G5ViwM1QJ36YuzwjBDPRxgOCADTPe8KAPvzo5ez7H.G2', 'siswa', '2025-08-24 21:24:14', '2025-08-24 21:24:14'),
(866, 'SAPRUDIN', '242510173', '$2y$12$xgeHD0PRDnSSyR.P.L5qReg9f8/NC7JiS7z2aSyK/9lypA8r7u08C', 'siswa', '2025-08-24 21:24:14', '2025-08-24 21:24:14'),
(867, 'SIFAH FAUZIAH', '242510174', '$2y$12$gJC/TEDjR3utHyQ/R4sL2e6V2PKjnCt1/2eEvptWfH1.EMv9WX95q', 'siswa', '2025-08-24 21:24:14', '2025-08-24 21:24:14'),
(868, 'TANIA LAURA', '242510175', '$2y$12$p312EKAmmkrNLznig3SMzOzKmvrcf/MzxJKZ0Rslj6LylPPfNLNca', 'siswa', '2025-08-24 21:24:15', '2025-08-24 21:24:15'),
(869, 'TEGAR ANANDA PRATAMA', '242510176', '$2y$12$jIZcpo2d4KgCqOzcFUAXo.nYgDHBbL4b1GwVVi2yq5ZxMR4jttZYa', 'siswa', '2025-08-24 21:24:15', '2025-08-24 21:24:15'),
(870, 'WIRANATA', '242510177', '$2y$12$hyMpeLDYKc8HndGtU/G6M.DI4EiK.evgnqfjyVcpQkrsbDl4X.O.a', 'siswa', '2025-08-24 21:24:15', '2025-08-24 21:24:15'),
(871, 'YUSUP HABIBI', '242510178', '$2y$12$iRCx/OfNyo6g/EDwKxxROuJSQIt2zQZ9cHlV1Hnlg1XQKHsUl8cd6', 'siswa', '2025-08-24 21:24:15', '2025-08-24 21:24:15'),
(872, 'AHMAD NURACA', '242510179', '$2y$12$VGyps/1OBsEPbhzDmwfFL./USAkFZOuTtWCNHA1Pt0IQkepK9VyZG', 'siswa', '2025-08-24 21:24:16', '2025-08-24 21:24:16'),
(873, 'ALVIAN NURFADILAH AGUSTIN', '242510180', '$2y$12$qgPuG87InfeWaXshnTgtzOt5oKj1POjYRN3KTRoV7vhzlMA2G1sc2', 'siswa', '2025-08-24 21:24:16', '2025-08-24 21:24:16'),
(874, 'CARTIKA AYU', '242510181', '$2y$12$GsNOvS51tbw0.0Ra0oZspe5gwmwi5WrC3k1s6weN5Z8eOZpqfh5z2', 'siswa', '2025-08-24 21:24:16', '2025-08-24 21:24:16'),
(875, 'DIMAS', '242510182', '$2y$12$o9IBGJy367BSgXTH903KNe0wz7uYQrSrvMEQXrVXkaI0WmGeHBD6i', 'siswa', '2025-08-24 21:24:16', '2025-08-24 21:24:16'),
(876, 'DIRLY KUSUMAH', '242510183', '$2y$12$6g5n6sD93gFmE.82JW2fkO4dsMY8wM3yBjwoaAzQnNbWrtNHErNMa', 'siswa', '2025-08-24 21:24:17', '2025-08-24 21:24:17'),
(877, 'FAISAL SETYO NUGROHO', '242510184', '$2y$12$AcE4fSV7AlDYYlR7q2RYkOMo3zJOsdOrv24EC5Ztzrgi6hpU6Fyo.', 'siswa', '2025-08-24 21:24:17', '2025-08-24 21:24:17'),
(878, 'FARID RIZKY RAMDANI', '242510185', '$2y$12$kAwiHTfG0u9G3dcHYjpgmOg/us4r99PYPfiMjQuHiPllV1wncWwma', 'siswa', '2025-08-24 21:24:17', '2025-08-24 21:24:17'),
(879, 'IIN DWI DIKA', '242510186', '$2y$12$mdO.exxYAPYl5NztJi494eCLnw/Aqrn44JmV7FCjCwSIShmPCiSSK', 'siswa', '2025-08-24 21:24:17', '2025-08-24 21:24:17'),
(880, 'ILYAS EFENDI', '242510187', '$2y$12$8VvJMpyIsWlsH3AmFrp2CuAUD.Qy8ldUSRbtVl/VP8jBvyJAaCuga', 'siswa', '2025-08-24 21:24:18', '2025-08-24 21:24:18'),
(881, 'IRWAN', '242510188', '$2y$12$EXDHvogMy0Ci.Hjjasc69uynj1fOSwxJRpdlp65K2qdxK02s20gP.', 'siswa', '2025-08-24 21:24:18', '2025-08-24 21:24:18'),
(882, 'JAMAL MAULANA', '242510189', '$2y$12$K0YQxoh/CXR47cub56FpEur.8O8zZog4wMpu56439s0D429utDF.a', 'siswa', '2025-08-24 21:24:18', '2025-08-24 21:24:18'),
(883, 'LUTHFI YANSYAH', '242510190', '$2y$12$KRNbyJv3SeNqDhEzZHndQOKB6dooM3BWDkiKXi2t2hDeZLRrf2F0u', 'siswa', '2025-08-24 21:24:19', '2025-08-24 21:24:19'),
(884, 'MUHAMAD ANDRE ALPHIANSYAH', '242510191', '$2y$12$b235XskUOeuSC2zJw56BzOF61Zc8a7NrY2iThy.3MBc82vdc0YkpG', 'siswa', '2025-08-24 21:24:19', '2025-08-24 21:24:19'),
(885, 'MUHAMAD BOBY FRAYUDA', '242510192', '$2y$12$Q93NaBqkOjC8PfxCRe1pkOytRX2zCav2XmdCcsrGIP5jzLccr81AW', 'siswa', '2025-08-24 21:24:19', '2025-08-24 21:24:19'),
(886, 'MUHAMAD FAISAL', '242510193', '$2y$12$bkTNKfA84OQMBW7lmMISr.eFqAaJ8UUKQGLK9.JxC9Qww8wPwRvoG', 'siswa', '2025-08-24 21:24:19', '2025-08-24 21:24:19'),
(887, 'MUHAMAD RAIHAN', '242510194', '$2y$12$/W.RmXixOtjN9V2w/oWniuD3mp9RmuMpnymlO60ui19zAbz4a22K6', 'siswa', '2025-08-24 21:24:20', '2025-08-24 21:24:20'),
(888, 'MUHAMAD RIKI ALFATUR RIZKI', '242510195', '$2y$12$pPs3w3uFEg7qJREe/y.t8u6owYTHbSV41Hi3UReWe.UCfDW2zRwza', 'siswa', '2025-08-24 21:24:20', '2025-08-24 21:24:20'),
(889, 'MUHAMAD SAUD', '242510196', '$2y$12$kduamxuzW3Zg8n5sCOTwOu4kOBk5Dp7wyURNorz/TIXvXwPU1bPl2', 'siswa', '2025-08-24 21:24:20', '2025-08-24 21:24:20'),
(890, 'MUHAMAD TIRTA RUKMANA', '242510197', '$2y$12$5hJaFJYWFkDh4B3hpNGAtO0S4CH5lNiOqWEHmtTv/lpwjk85BaKIe', 'siswa', '2025-08-24 21:24:20', '2025-08-24 21:24:20'),
(891, 'MUHAMMAD FARHAN MIFTAHUL ROJAK', '242510198', '$2y$12$3GgJRaZvMx.b/Vyx9Q128uzy10BQ9RWyLQQknnEp9idHt8ptjlYyG', 'siswa', '2025-08-24 21:24:21', '2025-08-24 21:24:21'),
(892, 'MUHAMMAD HASAN BASRI', '242510199', '$2y$12$7dsXJOqxOvPrQCPmCyqcBebz80IeTdZuultU1ILVxIVAyNFtmt5se', 'siswa', '2025-08-24 21:24:21', '2025-08-24 21:24:21'),
(893, 'NAJRIL ILHAM', '242510200', '$2y$12$.NeOsbXrfpecyh6hmUE4JOHmLHo1RyF3PZyRZo6oTDZS4q2aFUJIa', 'siswa', '2025-08-24 21:24:21', '2025-08-24 21:24:21'),
(894, 'NANANG KOSIM', '242510201', '$2y$12$U0F.naBSi4Mbr.pXu4jkieLhmSSGKuBtMvLVnW.a6/rW1RdHa1DZ6', 'siswa', '2025-08-24 21:24:22', '2025-08-24 21:24:22'),
(895, 'RIPA HAMDANI', '242510202', '$2y$12$ohXQhqVLYWTmVgYZvz/6MeKLZNIZyGzbcamwQ3T4vL4tZkGDyb2NC', 'siswa', '2025-08-24 21:24:22', '2025-08-24 21:24:22'),
(896, 'RIZKI AHMAD HAMBALI', '242510203', '$2y$12$vtk/MrjRi43M3PMX/vKcfuf6phkeb.DP5BM3r28VQIK8SlLaBHIMu', 'siswa', '2025-08-24 21:24:22', '2025-08-24 21:24:22'),
(897, 'SAEPUDIN', '242510204', '$2y$12$s/MqJAC47SwG4ze0MtgD6urRB4c5B2UyRe1kEX57/Pzi27lo3Tywy', 'siswa', '2025-08-24 21:24:22', '2025-08-24 21:24:22'),
(898, 'SAKTI GENTA AIRLANGGA', '242510205', '$2y$12$XJ5RJCUgo645jCUF8ef9YOkU.5cZ.Vgdv3SgKksOMiRRqLhZhL2SC', 'siswa', '2025-08-24 21:24:23', '2025-08-24 21:24:23'),
(899, 'SASKIA MURNI ATI JUANDI', '242510206', '$2y$12$H/3SXtMjDmQArcj1fbsr/.FfZXAxVCWiwCQdRJV6XFptFjAYRO98i', 'siswa', '2025-08-24 21:24:23', '2025-08-24 21:24:23'),
(900, 'SITI HALIMAH SADIYAH', '242510207', '$2y$12$egZd.QAYpbQEAbXf2KeOMuW6hPr/rQGM9/nWBc5Ff480kkRleIpn6', 'siswa', '2025-08-24 21:24:23', '2025-08-24 21:24:23'),
(901, 'SODIK RIFAI', '242510208', '$2y$12$qUxmxlElv8936ndxMbZyVuAjxVlaeIkkVL9920SP8NR.AHoRAC5wO', 'siswa', '2025-08-24 21:24:23', '2025-08-24 21:24:23'),
(902, 'WIDIA RAHMA SARI', '242510209', '$2y$12$TeexWGBSUtQPjpkn5XDYLO6EalHdgv4SlPhta6yq6Yrb0Ga.9ZZUi', 'siswa', '2025-08-24 21:24:24', '2025-08-24 21:24:24'),
(903, 'WILDATUL RAHMATUL UMMAH', '242510210', '$2y$12$PnxtR6jWDZJDPk0ppxK5L./5I68cj1YOIlN2cLjn7LYbRNHrZaS46', 'siswa', '2025-08-24 21:24:24', '2025-08-24 21:24:24'),
(904, 'AGNA FATHURROHMAN', '242510211', '$2y$12$1Ve/DTkOotLBEg/lSykvpOZMtZ/mQDzXIpt8HsEdbjVzv3L1a3nZq', 'siswa', '2025-08-24 21:24:24', '2025-08-24 21:24:24'),
(905, 'ALI AHMAD DINEZAD', '242510212', '$2y$12$BVauf5HeaiWqaPweNhxEEec6R6lF1D84OPvhDI.GQ0wD/wPS1MdQC', 'siswa', '2025-08-24 21:24:24', '2025-08-24 21:24:24'),
(906, 'ALNAZRIL ANASSYAH', '242510213', '$2y$12$bFiRP0BY6JbPaReHTYX/PeGAnYB7z.CHDeLWYmNqXmjizkatZfHVy', 'siswa', '2025-08-24 21:24:25', '2025-08-24 21:24:25'),
(907, 'ANGGA', '242510214', '$2y$12$Fum.K.FzWLi5mtDLUlIEtei/vJ.U451Gyvo.TCOIxSzFxVp8mWVDe', 'siswa', '2025-08-24 21:24:25', '2025-08-24 21:24:25'),
(908, 'DERI SAEPUDIN', '242510215', '$2y$12$fteLDugSypK/0qTtCaUvs.phHEDU1AH0EWwOezNvT2fPOJ0P.F9LO', 'siswa', '2025-08-24 21:24:25', '2025-08-24 21:24:25'),
(909, 'DIKI PURNAMA', '242510216', '$2y$12$qB14BpBFaCPiCidSMnvkneOMGW0vRKJkgIijmBl9.hreD9WwjEDLK', 'siswa', '2025-08-24 21:24:26', '2025-08-24 21:24:26'),
(910, 'FAUZI RIDWAN', '242510217', '$2y$12$.zQCVuZA4ISOt3ZzDRg4Ze0xJA.P3010S4fPRrH5t81k5ED28qKGm', 'siswa', '2025-08-24 21:24:26', '2025-08-24 21:24:26'),
(911, 'GILANG ANGGA KUSUMAH', '242510218', '$2y$12$Ro.d6BFn.xqBOllrriACheujQb/qSIsgxqJhAdRotuPyXXQEdNT0G', 'siswa', '2025-08-24 21:24:26', '2025-08-24 21:24:26'),
(912, 'IMARRUL UMMARA', '242510219', '$2y$12$FOHmvpqWg4MidjEkKnILUufkP3SadNSkQDwvmb2SHIsgJHlW2lbT.', 'siswa', '2025-08-24 21:24:26', '2025-08-24 21:24:26'),
(913, 'KARTOBI', '242510220', '$2y$12$dMGmce5yIoIbUkt4ffTkwe3y1.WTQxaFy7AS6LVOQ7nQwgIptnDuu', 'siswa', '2025-08-24 21:24:27', '2025-08-24 21:24:27'),
(914, 'MALIK IBRAHIM', '242510221', '$2y$12$mappQeQ0tghIXhX5rl/iyuWncgAlboerdCXsrfkN8PjZNVCNJJ/1.', 'siswa', '2025-08-24 21:24:27', '2025-08-24 21:24:27'),
(915, 'MARSELA', '242510222', '$2y$12$2PSytnFtVAOZW.Gf6CPHfefQl5Sp.hu0sc4jOHPU4JyaElGA.2mS6', 'siswa', '2025-08-24 21:24:27', '2025-08-24 21:24:27'),
(916, 'MUHAMAD FARIS DZULFIKAR', '242510223', '$2y$12$A9hKfv0x5OQjArnWhnDYT.t6akBe0NUo1V89fnewoD2ghUn4Hs.B.', 'siswa', '2025-08-24 21:24:27', '2025-08-24 21:24:27'),
(917, 'MUHAMAD REHAN BAROKAH', '242510224', '$2y$12$Plt9kjsCgKsL7Tbml/Vn6uNE4ZXQfJ91.gQ8g2wHb4BACKqWzZ2Gq', 'siswa', '2025-08-24 21:24:28', '2025-08-24 21:24:28'),
(918, 'MUHAMMAD RAIHAN FEBRIAN', '242510225', '$2y$12$Yn3qZAtPrnipCX1.rZUIs.4D3Gs9R7/kooChuM7MCiFduBBuJr9zu', 'siswa', '2025-08-24 21:24:28', '2025-08-24 21:24:28'),
(919, 'RADIT RAMDANI', '242510226', '$2y$12$ppOQaXoy25aS/5N7mPZn4ekuu3yJ8qRypB639y9lui7zB.w4ephM.', 'siswa', '2025-08-24 21:24:28', '2025-08-24 21:24:28'),
(920, 'RAMDANI', '242510227', '$2y$12$o1C4K7eWkR33HsC3CHCNVuvV1LWUBZ27Um1HxA919qBPDDDFOTMzK', 'siswa', '2025-08-24 21:24:28', '2025-08-24 21:24:28'),
(921, 'REHAN MAULANA RIZKY', '242510228', '$2y$12$Xvuiggw.5lxWmMBgYlDu6.dB1qF5OKAva8UjQUWW2/vIvIy9flhNO', 'siswa', '2025-08-24 21:24:29', '2025-08-24 21:24:29'),
(922, 'RENO APRIAN', '242510229', '$2y$12$i9tLPaC4UH8ws1yEoiae8uH6aRy4Z5wMW..Bzph8OCcm1tgTK5HE.', 'siswa', '2025-08-24 21:24:29', '2025-08-24 21:24:29'),
(923, 'REYSSA PRIYUNITHA IVANA', '242510230', '$2y$12$NNZVGvlRfw0.numLNVc5F.rSdazq1FXzbePlreJeg8dTPkMurq6iS', 'siswa', '2025-08-24 21:24:29', '2025-08-24 21:24:29'),
(924, 'RIZKI', '242510231', '$2y$12$N/oUS6aCyaCsHI7ZTFh1Ue9oS7VAlsxD12LejHfnSdNsSaokV.yCq', 'siswa', '2025-08-24 21:24:30', '2025-08-24 21:24:30'),
(925, 'SRI ANGGRAENI PEBRIANTI', '242510232', '$2y$12$wZHHFXL5ZAdo1Uy82tSbBOm8U6Nx49QTOR1SYbAIvn95p6xwbGxLC', 'siswa', '2025-08-24 21:24:30', '2025-08-24 21:24:30'),
(926, 'TASYA', '242510233', '$2y$12$sDxQjX6yavBQlkzRBm39leoDdeSX/3xp4LzzDBHhIsipPbQfVYvbG', 'siswa', '2025-08-24 21:24:30', '2025-08-24 21:24:30'),
(927, 'TAUFIQ HIDAYATULAH', '242510234', '$2y$12$wgBii23C6UOAwcOuRsD.8.sScAuBEEECj.8Qv2BcQXnr9uRQlgU3S', 'siswa', '2025-08-24 21:24:30', '2025-08-24 21:24:30'),
(928, 'TRISTANTO', '242510235', '$2y$12$GgzypmmkWN87rUdR3BXcLuxoz5Qsx7iOjuV0vnoKh3FmDLbAxK1C.', 'siswa', '2025-08-24 21:24:31', '2025-08-24 21:24:31'),
(929, 'WHILDAN SYAHRIZAL WAHYUDI', '242510236', '$2y$12$VxqNPXQsX4cO1o28VXxAu.HYBfSUvQZ.GPx715uoJ4hqcvIklS6Eq', 'siswa', '2025-08-24 21:24:31', '2025-08-24 21:24:31'),
(930, 'ABDUL AZIS', '242510237', '$2y$12$MilJ8CDeMh7lnx5RHa7Arehc38BNPTAKmefe3SM7cr3RH/L0CG/7O', 'siswa', '2025-08-24 21:24:31', '2025-08-24 21:24:31'),
(931, 'ABDUL RAHMAN WAHYUDIN', '242510238', '$2y$12$lOMA/6Mb1mRSWQa2ttVIXuZDiMJKwZNXPUo8.YXyQZcNn3XufnVEW', 'siswa', '2025-08-24 21:24:31', '2025-08-24 21:24:31'),
(932, 'AHMAD FANANI', '242510239', '$2y$12$7xSTAYvIvEYGk05CGRLfz.0VyYHa4bCbzEfdHTFB8lY73StqphGi2', 'siswa', '2025-08-24 21:24:32', '2025-08-24 21:24:32'),
(933, 'ALFA NURHIKMAH', '242510240', '$2y$12$tnnpB3lqNHB7LxJiwapxF.TjrPAYxJqqQSVkcqG86..MLrYkd4BIq', 'siswa', '2025-08-24 21:24:32', '2025-08-24 21:24:32'),
(934, 'ANDRA PURNAMA', '242510241', '$2y$12$VErL0fGtaFOXpzMkaPeohOmVEYY5UIIeVlTVyLWMYINOJud4574Ty', 'siswa', '2025-08-24 21:24:32', '2025-08-24 21:24:32'),
(935, 'ARINO ARDAN ARUBETH', '242510242', '$2y$12$a/lcEUhrpFzQgbjLnxqABO12uoqP3sut1nZFMh98xRx6yLFz1WlMi', 'siswa', '2025-08-24 21:24:32', '2025-08-24 21:24:32'),
(936, 'CARSIYAH', '242510243', '$2y$12$Vwtf6y9jTrJQY5Hr0184Q.mzW7gCgxLjZ2nZTE.2zv3USzEY6EsK2', 'siswa', '2025-08-24 21:24:33', '2025-08-24 21:24:33'),
(937, 'CHICI NURSELA', '242510244', '$2y$12$3WWjwsKXm457sOCb78psHuY136gjuu2bxYk33Gu/Yo6lSiIjZgWm2', 'siswa', '2025-08-24 21:24:33', '2025-08-24 21:24:33'),
(938, 'DALAL IRWANSYAH', '242510245', '$2y$12$s2zxDASR5v8rxSoPiND8MOXUzLkx5fcZ44v0wmgM3apUTg65x.WiS', 'siswa', '2025-08-24 21:24:33', '2025-08-24 21:24:33'),
(939, 'DODO WIJAYA', '242510246', '$2y$12$LVgy6ejGTG5stwSVVKnCEuQJCa/EYRvLnrA5jWZqLCrkK5LCpWE2G', 'siswa', '2025-08-24 21:24:34', '2025-08-24 21:24:34'),
(940, 'ELI HAYATI', '242510247', '$2y$12$v/mKTYiTNpL68v65UP3lHOPYi932JlKeIJe58tDqENfI5zzxsF.Na', 'siswa', '2025-08-24 21:24:34', '2025-08-24 21:24:34'),
(941, 'INDRA', '242510248', '$2y$12$5To8pE61ohYpdt4WwJNQ5eKPB.8GGxrCorhFm18oCpnQBlUIbsOEe', 'siswa', '2025-08-24 21:24:34', '2025-08-24 21:24:34'),
(942, 'LAILA SAFITRI', '242510249', '$2y$12$W4AnR3lApgEq.qPvHhBl2eyU42z3jmRdfNdXD8k48BM2CKcJkUid2', 'siswa', '2025-08-24 21:24:34', '2025-08-24 21:24:34'),
(943, 'MAESAROH', '242510250', '$2y$12$JHRm.GQ1EmjayaZoRCzsbu8A0EdWdme83KJWkob6miueLtVcJ9dV2', 'siswa', '2025-08-24 21:24:35', '2025-08-24 21:24:35'),
(944, 'MUHAMAD RASYA RAMADHAN', '242510251', '$2y$12$OfyAzvfBUkVzQaWKEs6VAOIE4hBWDBoJKIL8uNqPQP6o7AZw2fHFC', 'siswa', '2025-08-24 21:24:35', '2025-08-24 21:24:35'),
(945, 'MUHAMAD WAKAB', '242510252', '$2y$12$097Oy3sSHCB9lNohUiO5BOs9fp2myQMRWBHT2vZPamWwYn2yjQwsy', 'siswa', '2025-08-24 21:24:35', '2025-08-24 21:24:35'),
(946, 'MUHAMAD WAKUB', '242510253', '$2y$12$DbiKvfYSvjgBAWQdMdvZWeCzmygzXviZKoufyx/kxOF8JS5sO6UBS', 'siswa', '2025-08-24 21:24:35', '2025-08-24 21:24:35'),
(947, 'MUHAMMAD RIDO RIDWANULAH', '242510254', '$2y$12$RWIlRGyjDlnYbOMpzNmUN.REVZPTWreUvQn59D8uczxVUHp/PkJ7W', 'siswa', '2025-08-24 21:24:36', '2025-08-24 21:24:36'),
(948, 'NAJRIL ILHAM', '242510255', '$2y$12$c13S.wiefh2kR6RM76Af..Xj.VdBXUHWrCBsazOGBfnsOEbr5LT6O', 'siswa', '2025-08-24 21:24:36', '2025-08-24 21:24:36'),
(949, 'NIA RAMADHANI', '242510256', '$2y$12$abs76NIPqowgGmmNu/hL/.7d/fn9ADzqG1SAmARVwnNPcZMGLCh9q', 'siswa', '2025-08-24 21:24:36', '2025-08-24 21:24:36'),
(950, 'RANGGA ARDIAN', '242510257', '$2y$12$Bwme2ESchgfP66SBJjW7rO9LlBTaFRMDlnm/gL64SHi/eWHQXAFRK', 'siswa', '2025-08-24 21:24:36', '2025-08-24 21:24:36'),
(951, 'RIZKI MAULANA', '242510258', '$2y$12$UgMWk3PFKOC/O/glFjG19uZaCYWLDfRLSKeOwiW1lCe/rwZcG75ey', 'siswa', '2025-08-24 21:24:37', '2025-08-24 21:24:37'),
(952, 'SOPIAN GUNAWAN', '242510259', '$2y$12$z5OyDONWYwa6ox.wv7PqX.Fn5D0uvYVilPcXF4S30TOxhwSVpcXei', 'siswa', '2025-08-24 21:24:37', '2025-08-24 21:24:37'),
(953, 'SUPRIYATNA RAMADAN PRASTIYO', '242510260', '$2y$12$w1Bt8wQ6OzxpzxigGmQXL.YBFPqqfxEOZKvXtrGqdwvg1UhjhCarO', 'siswa', '2025-08-24 21:24:37', '2025-08-24 21:24:37'),
(954, 'VICRY APRIANSYAH', '242510261', '$2y$12$nqK0EYV2ANpFIqoih2Zye.eZeJJ9/5wcyF5bi5WGqKdmyRjt93QBu', 'siswa', '2025-08-24 21:24:37', '2025-08-24 21:24:37'),
(955, 'WANA MAULANA', '242510262', '$2y$12$R5KclHTOE1vhGenyxtzDJOimB3SqKrBy08vBZE8j.21qTOv6seiqO', 'siswa', '2025-08-24 21:24:38', '2025-08-24 21:24:38'),
(956, 'WIRA ATMAJA', '242510263', '$2y$12$9CuYnGf.ZqMyrA7vKzfrm.nSBJZXa8gg.7YdEgOzPcJvHpLvAYIz6', 'siswa', '2025-08-24 21:24:38', '2025-08-24 21:24:38'),
(957, 'YUDA PRATAMA', '242510264', '$2y$12$JknSehB3cWuPypfvU2YBuOurUmxQSHbRE7dw.4bEIP2cp1MbPVYIW', 'siswa', '2025-08-24 21:24:38', '2025-08-24 21:24:38'),
(958, 'AISAH', '232410001', '$2y$12$SeHRms5nu5F0O1KMjW9vF.N8IPmv63zPSohrY2/oEwT7vccsA0y8.', 'siswa', '2025-08-24 21:47:44', '2025-08-24 21:47:44'),
(959, 'AISAH FITRIYAH', '232410002', '$2y$12$sQhzTyIZirdjQbqlJBBb5evsGrI0HAxpDYUCmfhNpc8TYMg4ZguP6', 'siswa', '2025-08-24 21:47:45', '2025-08-24 21:47:45'),
(960, 'ALDI REPALDI', '232410003', '$2y$12$c6tTAvJ1B.7GKAVEkW/Fa.ElRNivp9U5dyRF/njyDycsyzLZeZ83m', 'siswa', '2025-08-24 21:47:45', '2025-08-24 21:47:45'),
(961, 'ANISA TRI WAHYUNI', '232410004', '$2y$12$066sq6/DLgjDvf9kJvQHx.FcZ8gCF/rCeTSwDHXmN6aSYUUw0tXsG', 'siswa', '2025-08-24 21:47:45', '2025-08-24 21:47:45'),
(962, 'AYU ARISKA', '232410005', '$2y$12$aGWeBubOlphkpla3u46zMuD5p34NdBeofRXlgD3N00wElPSm2KcSe', 'siswa', '2025-08-24 21:47:45', '2025-08-24 21:47:45'),
(963, 'DEA AULIYA', '232410006', '$2y$12$/UUE3od8RYUjaHB.TE3RLOMk5k2OZ6TwzZ6AAETCxcqr2Y2UtfSDO', 'siswa', '2025-08-24 21:47:46', '2025-08-24 21:47:46'),
(964, 'Dedeh', '232410007', '$2y$12$zsLxf/CxXoF1g1J/YjSi8uKabjMqfDtU06LzzfDd2PBNvUsLvXzEy', 'siswa', '2025-08-24 21:47:46', '2025-08-24 21:47:46'),
(965, 'Entin Julyani', '232410008', '$2y$12$4v2DE3qRxJOcQFNoCnqlUuObQFZ2SoGrwO/k4ACuXo7FywBdopaV6', 'siswa', '2025-08-24 21:47:46', '2025-08-24 21:47:46'),
(966, 'HALISA HUMAIRA', '232410009', '$2y$12$F6ze9uHPPSbEgEqc02s6I.Cr86AYOXCspyEeesuhs020hHcAS.2wW', 'siswa', '2025-08-24 21:47:46', '2025-08-24 21:47:46'),
(967, 'HANIPAH PAUJIAH', '232410010', '$2y$12$k1bsQFfaUd//SeYIPAwWuOSu6lQV2d6HC4nHnLgsEtWXKdhiMsZV2', 'siswa', '2025-08-24 21:47:47', '2025-08-24 21:47:47'),
(968, 'HASBY MAHEZA', '232410011', '$2y$12$C/Q/QjxD02wA8xioUc0Upukn0guSwGrs80JRk05GRVeEw7giNZXWa', 'siswa', '2025-08-24 21:47:47', '2025-08-24 21:47:47'),
(969, 'INTAN AOLIA', '232410012', '$2y$12$AK.RRdLPuBGXf8k8Y4aUlOsHGQGLFvBo4yoCkjKdCW3oWhoWvN8G2', 'siswa', '2025-08-24 21:47:47', '2025-08-24 21:47:47'),
(970, 'INTAN NURAINI', '232410013', '$2y$12$CgCpKShoZa8gnYT8H1ZzIO4ts8qAAORcRpemiZPyoyTO0hnZ.sB/a', 'siswa', '2025-08-24 21:47:47', '2025-08-24 21:47:47'),
(971, 'IRMA SULISTIA', '232410014', '$2y$12$n0kiOYgQ2tebXmxkyJdite8WjMxAntL4pvMALgadChPD6FIZmBCkG', 'siswa', '2025-08-24 21:47:48', '2025-08-24 21:47:48'),
(972, 'JAHRATUSSYITA', '232410015', '$2y$12$LwPfkXkqEm5YB.mmsH5oS.DsDG.QXtMuVK8ZsnP2KH5BINrK5yuYy', 'siswa', '2025-08-24 21:47:48', '2025-08-24 21:47:48'),
(973, 'JIHAN', '232410016', '$2y$12$gx5LN4f5k6L/jGl2P80Xvul4jWcV4a7Qc3e5AoEy1dlDVnNtKsVoG', 'siswa', '2025-08-24 21:47:48', '2025-08-24 21:47:48'),
(974, 'KURNIA FEBRIANTI', '232410017', '$2y$12$.enoFy96/Y7zfroDAsaB2.tVDi4hfuze8IvceuY3f5CImCIRt527S', 'siswa', '2025-08-24 21:47:48', '2025-08-24 21:47:48'),
(975, 'LALA PADILAH', '232410018', '$2y$12$m.7Y8E9MJNtmif7JLJd/zeKadUaUBeI7Y4rWRROWiqaqT4I1rGZz.', 'siswa', '2025-08-24 21:47:49', '2025-08-24 21:47:49'),
(976, 'NOVITASARI', '232410019', '$2y$12$Tr73oU5sZ6i3UkN2iCxf0ufahLwZXgeQhvkYT6fsjEo5Gv9iow/aa', 'siswa', '2025-08-24 21:47:49', '2025-08-24 21:47:49'),
(977, 'NURLELAH', '232410020', '$2y$12$LZj4tm8fsGAFISmPM.NY6.u.EjSkVAhRbrqAif9NxaAMYS7gkjwzK', 'siswa', '2025-08-24 21:47:49', '2025-08-24 21:47:49'),
(978, 'NURUL FARHAH', '232410021', '$2y$12$mSaMH4omvdG9K9OurW7eveUf0sxdwNAQ57S1yuRabf77FBVnnZ8IW', 'siswa', '2025-08-24 21:47:50', '2025-08-24 21:47:50'),
(979, 'RAHMA AULIA AGUSTIN', '232410022', '$2y$12$W2vzZQ7nCRZ.VOr0YwNFv.Godn8krcUaF5Hi99cV5pquzGbxo1V5e', 'siswa', '2025-08-24 21:47:50', '2025-08-24 21:47:50'),
(980, 'RIYAN', '232410023', '$2y$12$z./MswKNNiPUqW8AtJsu9u49kEGSBrcTlFHjAam2MlVrYDYbnAM26', 'siswa', '2025-08-24 21:47:50', '2025-08-24 21:47:50'),
(981, 'SINDI ARISKA', '232410024', '$2y$12$ZmqpLAP8N3c5.4.TekGuQ.7KfCZpZ3U7mB1sjpMO2Fy15.49RldVu', 'siswa', '2025-08-24 21:47:50', '2025-08-24 21:47:50'),
(982, 'SITI NURAENI', '232410025', '$2y$12$ODhvRL0gO4De6OoW1t.aeeOugdJ9nJQwhReD3mD5k4LsA1RVk4cF.', 'siswa', '2025-08-24 21:47:51', '2025-08-24 21:47:51'),
(983, 'TRI NOVITA SARI', '232410026', '$2y$12$7OV28xO8do/RaM4k4Ye27eUyuZLUNKf0fCIgDJM2n8Jtd/5c51MIW', 'siswa', '2025-08-24 21:47:51', '2025-08-24 21:47:51'),
(984, 'ALVIANI', '232410027', '$2y$12$DOWy2eBRlC9buiSf.YDTNO5PTK/T1FE/vr3w2SsGckL22qD.Avw6e', 'siswa', '2025-08-24 21:47:51', '2025-08-24 21:47:51'),
(985, 'DECA LESMANASARI', '232410028', '$2y$12$sZJvOg8rLcPJAfKv4avrfe5HdAyS3XXUZjF2jxgeJli.h1CtkOQsK', 'siswa', '2025-08-24 21:47:51', '2025-08-24 21:47:51'),
(986, 'GINA HERAWATI', '232410029', '$2y$12$O9iRqudZbXkWLya/iFGCw.6eEH2MNVEPnhROWsL1ZreYZgyX/xlVW', 'siswa', '2025-08-24 21:47:52', '2025-08-24 21:47:52'),
(987, 'INDI LESTARI', '232410030', '$2y$12$mVmePdaF9KNS5lJcGrTguurF5CHH1bVJfGIhq9g1BB1sN6WgXZsra', 'siswa', '2025-08-24 21:47:52', '2025-08-24 21:47:52'),
(988, 'JENY SAFIRA', '232410031', '$2y$12$f46LFU/.99d9mbhnAX7eg.nemn9wC40.bfqjRUqq8.a8OYkdBpt2K', 'siswa', '2025-08-24 21:47:52', '2025-08-24 21:47:52'),
(989, 'KHILDA SYAFA`AH', '232410032', '$2y$12$d08/QKyRj4ppb8ASl6UIF.3fvd0mvWm.YNoTGG4b87Aw36kLXwo9S', 'siswa', '2025-08-24 21:47:52', '2025-08-24 21:47:52'),
(990, 'LAELA', '232410033', '$2y$12$sTVlEPRfMG9dG.c17SDCWOPEppF8o4.CZfMHjbbUc6ToUV.D3nREK', 'siswa', '2025-08-24 21:47:53', '2025-08-24 21:47:53'),
(991, 'NAILA ADZKYA MAULA', '232410034', '$2y$12$DhUmPZVSb5KMMJ5zerw6XOhXM8bdhTGiykU.vKzVCl0S3KqdCvgDG', 'siswa', '2025-08-24 21:47:53', '2025-08-24 21:47:53'),
(992, 'NAJWA', '232410035', '$2y$12$OOJMPpqsbgcIYp6QpneA4ON6YYgf7JZs3S5EWPEwkd2htrDsZVjNG', 'siswa', '2025-08-24 21:47:53', '2025-08-24 21:47:53'),
(993, 'NARSIH', '232410036', '$2y$12$6FGtU34V6ITgN1aV1RR4l.WNk6hu3SJI1rXzNLCjLvZkXS876NEj6', 'siswa', '2025-08-24 21:47:53', '2025-08-24 21:47:53'),
(994, 'NIKEN RIZKIA NINTIAS', '232410037', '$2y$12$AvsPC7NEiUK6gdBZOdgdZ.dTPFaetT0BS4vwvtfEJZ3ynXaQWeHQq', 'siswa', '2025-08-24 21:47:54', '2025-08-24 21:47:54'),
(995, 'PUTRI JULIANTI LESTARI', '232410038', '$2y$12$6fadoaI7OBz7rJf4dMnBRuVomT8HRJ.ipdcIjkUjhVGPdU1sr7GIG', 'siswa', '2025-08-24 21:47:54', '2025-08-24 21:47:54'),
(996, 'RAHMAWATI', '232410039', '$2y$12$3QBC.LoazVyG6z73tyOTROVwIddWyVEGf1ELkTOa7aiyua1ZswSv2', 'siswa', '2025-08-24 21:47:54', '2025-08-24 21:47:54'),
(997, 'RATNA DEWI WULAN SARI', '232410040', '$2y$12$y2tcG6noJtq9.KLs6SwNnuN/.IDSdckssgdJDzE3cgkeKe2ffaV8e', 'siswa', '2025-08-24 21:47:55', '2025-08-24 21:47:55'),
(998, 'REFFA AMELIA', '232410041', '$2y$12$ZaF..P7U/VUBqBxf/U8dKuVa0QPaDhv7teV18ejm8zoaDbIY.uMpG', 'siswa', '2025-08-24 21:47:55', '2025-08-24 21:47:55'),
(999, 'SAWI', '232410042', '$2y$12$4jbKXTVtHgwI62aiEoHlyOQOG98mZNj1jKAf1HLQqysMOBp0.2yhe', 'siswa', '2025-08-24 21:47:55', '2025-08-24 21:47:55'),
(1000, 'SEPTIANI', '232410043', '$2y$12$aRbvuzsuGG7bqkisrczz6eZzTkyzqdwvW5nQbV5gTUvrYY3y1n.ze', 'siswa', '2025-08-24 21:47:56', '2025-08-24 21:47:56'),
(1001, 'SITI HILDA MAESAROH', '232410044', '$2y$12$Wa2DzILFynSmBdvxscpto.r/UB0Jupjzg9RkNpMnTPWlaXHfyQhpC', 'siswa', '2025-08-24 21:47:56', '2025-08-24 21:47:56'),
(1002, 'SITI SOVIYAH', '232410045', '$2y$12$.G0YT9xBIPC2irtkStzjZOWHctxUtUpqhl2i.A46XaKiXUNEEzWfy', 'siswa', '2025-08-24 21:47:56', '2025-08-24 21:47:56'),
(1003, 'SITRA ADILA', '232410046', '$2y$12$0BATh4cWC94bctfVxNTdw.fcm1Lw0rsKmnRl4nE7oYNKe6d3OSLZW', 'siswa', '2025-08-24 21:47:56', '2025-08-24 21:47:56'),
(1004, 'SRI NURHAYATI', '232410047', '$2y$12$4DGoYoBv0teduz7EwV1fw.cadqXCaxC3f3/HrlZjajDiht88OeTOK', 'siswa', '2025-08-24 21:47:57', '2025-08-24 21:47:57'),
(1005, 'WARI', '232410048', '$2y$12$ZfatcoZn0tP7FEUM0/pWA.xfszwFTp8C.BJfzYUQ9FkoRDomat1RG', 'siswa', '2025-08-24 21:47:57', '2025-08-24 21:47:57'),
(1006, 'WULAN NURUL ARIFAH', '232410049', '$2y$12$59TI3jZh/ZOl8T50mX25U.JuUylDmNhVAjnslFlUr2oVr6K1Mx3Ka', 'siswa', '2025-08-24 21:47:57', '2025-08-24 21:47:57'),
(1007, 'YUSTIKA DEWI', '232410050', '$2y$12$QIKXdNwBkkRmcICfXD0K5eQDFAQZZ8sAS2MWxzeqs1yBlv3bh3GSG', 'siswa', '2025-08-24 21:47:57', '2025-08-24 21:47:57'),
(1008, 'ZAHRA NURI SURYA', '232410051', '$2y$12$biu0NR3DBaUtK3L0b5.E6.kB94w/Rprz0a70YoOCC8qsi4qD2wPVC', 'siswa', '2025-08-24 21:47:58', '2025-08-24 21:47:58'),
(1009, 'ADAM PRIAMUGA', '232410052', '$2y$12$Oj/9469z9vk6Lser6SMrcunMeiN9gRQGC3zxV9D74eFVTTonGObDq', 'siswa', '2025-08-24 21:47:58', '2025-08-24 21:47:58'),
(1010, 'ADARSONO', '232410053', '$2y$12$wkDduwWTw2UNe6cdgdmZLuWJz1qzjX2pq7rWMSW4JuTqjeuf9JOSi', 'siswa', '2025-08-24 21:47:58', '2025-08-24 21:47:58'),
(1011, 'AFAHRI SATYA ABDUL', '232410054', '$2y$12$bt2GGjw61UHysiYDIkci6O50HNyOrKDHel7Kl2rgfs15uWuC4CemK', 'siswa', '2025-08-24 21:47:58', '2025-08-24 21:47:58'),
(1012, 'AHMAD RIZKI ADITIA', '232410055', '$2y$12$GxpuuxG/dtwxAQ6tm8rCQORL2fmYoeiL5BkxlLs30id2uwhBBKNS.', 'siswa', '2025-08-24 21:47:59', '2025-08-24 21:47:59'),
(1013, 'AHMAD RIZKY AL MAHMOD', '232410056', '$2y$12$n5H8wvi0TXMWWNO6dmDA3OxyLcL9wEqNFAccNRgPrEizxbvHDSQce', 'siswa', '2025-08-24 21:47:59', '2025-08-24 21:47:59'),
(1014, 'AJI PANGESTU', '232410057', '$2y$12$ce1TFqrVBEaq5zLJxMYP7OPCQojWFi2tecUeOpbiS7uLXD0jyKCjW', 'siswa', '2025-08-24 21:47:59', '2025-08-24 21:47:59'),
(1015, 'AKMAL KUSRORI', '232410058', '$2y$12$O1sWuwz4FXuHqVqtVrrJ7Oq.r7FsqGvtvmNfrlSl.VZl3nWrZ2HDG', 'siswa', '2025-08-24 21:48:00', '2025-08-24 21:48:00'),
(1016, 'ANGGA ADITIA', '232410059', '$2y$12$7.4eQsjKQ5JFegPrw8qq0ulXtXK9QpOz6Do.4prbeoHpkQPLIDRRS', 'siswa', '2025-08-24 21:48:00', '2025-08-24 21:48:00'),
(1017, 'ANNISA TUL AULIA', '232410060', '$2y$12$Rdom7OsLWnVlFaeSB2UTvuEYW0GVB.E2GjG4z03Zt901guyph1a5e', 'siswa', '2025-08-24 21:48:00', '2025-08-24 21:48:00'),
(1018, 'AYAN SUPRIATNA', '232410061', '$2y$12$fJuY6vHXLpKHzdoPi6iVN.aOqf5AtLCGqjLc1b0dLi6x6h.kqCE9.', 'siswa', '2025-08-24 21:48:00', '2025-08-24 21:48:00'),
(1019, 'CACA AULIANA', '232410062', '$2y$12$beWBpRNXFe9Bc0HeYnWQqOehxVoHWCPElsWN6e8.aihUrn.WRpbL2', 'siswa', '2025-08-24 21:48:01', '2025-08-24 21:48:01'),
(1020, 'DIKI SOMANTRI', '232410063', '$2y$12$OXC0rUB6to7h78CfHZ8WwOqMDJqK2hYdPTG3fChzxZNMU6KlB4FY2', 'siswa', '2025-08-24 21:48:01', '2025-08-24 21:48:01'),
(1021, 'DIRGA RAGIL PUTRA RUKMANA', '232410064', '$2y$12$eZ0HRBJPaZEEamIvkTPDZu9aEdayG.T5RIumv9Ylpe7LgW9gu.Mha', 'siswa', '2025-08-24 21:48:01', '2025-08-24 21:48:01'),
(1022, 'EVA ALEXA', '232410065', '$2y$12$VJFGzwUndEWwkix0xIi1L.W.FMgFjCF6VBej2KTNPSQqe0U0q4yUa', 'siswa', '2025-08-24 21:48:01', '2025-08-24 21:48:01'),
(1023, 'FAIRUZ FIKHAR FUADI', '232410066', '$2y$12$hxo2kodXDIfv1k98.W5fFewBfHVakZ0Y2uoQDysIRHkRtveo.Skqy', 'siswa', '2025-08-24 21:48:02', '2025-08-24 21:48:02'),
(1024, 'FITRIYANI', '232410067', '$2y$12$glzp0W.c4UiLzWKlgn/DSuK43GgdPsULxJmuGHLMR/odEhEPB2eGy', 'siswa', '2025-08-24 21:48:02', '2025-08-24 21:48:02'),
(1025, 'HIDAYAT AHMAD SIDIK', '232410068', '$2y$12$x0eZCyo/u8uXGuXbAxYPB.5pEjz3VtK/fqPunTxNO3PGXk3L2t.Va', 'siswa', '2025-08-24 21:48:02', '2025-08-24 21:48:02'),
(1026, 'IRWAN ISKANDAR', '232410069', '$2y$12$A3b7ALygdFm5Gu.peBCP/.tIBlB6n6HfvtCU.832qI2GD7cBblt8G', 'siswa', '2025-08-24 21:48:02', '2025-08-24 21:48:02'),
(1027, 'KHOERUL APANDI', '232410070', '$2y$12$F3VkcjvWi7zpm0OcLdU/PugB4l0.x/Y.7vAO5bpKu3iOUV5uvV5vC', 'siswa', '2025-08-24 21:48:03', '2025-08-24 21:48:03'),
(1028, 'KUSNATA', '232410071', '$2y$12$KvAaiUeBiTuO6qtfKTpNLO7xGFmp62fVD1cYpGLWTEIrM5yZ4AveC', 'siswa', '2025-08-24 21:48:03', '2025-08-24 21:48:03'),
(1029, 'MUHAMAD EGA OKTAVIAN', '232410072', '$2y$12$HMLZGUetzahkj8A634LGLuMUoNc/jeIc.qKtUjO9E7o2AEQi2YjTS', 'siswa', '2025-08-24 21:48:03', '2025-08-24 21:48:03'),
(1030, 'MUHAMAD YUNUS', '232410073', '$2y$12$pxc3c19bSuzgIswPsivKI.H8hqknPDOUBvDl8fDJeCEwbPQm5FUlu', 'siswa', '2025-08-24 21:48:03', '2025-08-24 21:48:03'),
(1031, 'MUHAMMAD RAMDANI', '232410074', '$2y$12$35T0bOD92D4Mq/pEvm53jOVPtneu5keG4.N9YNv3sT60jc5dyURbG', 'siswa', '2025-08-24 21:48:04', '2025-08-24 21:48:04'),
(1032, 'MUHAMMAD RAYHAN RAMDHAN', '232410075', '$2y$12$cEczZLix09q4tQSIsi2y1uFNz0pxypnOBScV.klCLg1bLcJhfhv0e', 'siswa', '2025-08-24 21:48:04', '2025-08-24 21:48:04'),
(1033, 'RANIA NURDIAN', '232410076', '$2y$12$eNSr5Q/Od4lmqW5/FPvCTOeq4/5xvZmjKrWepCLlfxr/OQFF5KQaq', 'siswa', '2025-08-24 21:48:04', '2025-08-24 21:48:04'),
(1034, 'ROMLAH', '232410077', '$2y$12$.eWhzQSY03JhNNBXbud3Ie1B3A4D2701wCEQwwvxY/Nrbq.6T.H16', 'siswa', '2025-08-24 21:48:04', '2025-08-24 21:48:04'),
(1035, 'SAAD APRIANSYAH', '232410078', '$2y$12$R1avPAXHfudN3rrn0AWvJ.Mbv2Lst29qZX7aKh8pgmQARn5l6pRRO', 'siswa', '2025-08-24 21:48:05', '2025-08-24 21:48:05'),
(1036, 'SANTANA WIDI BAHARI', '232410079', '$2y$12$8zPl7lthj2qJKM5vWjD8h.6KiASytux0rzz7ElgbNx/17CEu6q9om', 'siswa', '2025-08-24 21:48:05', '2025-08-24 21:48:05'),
(1037, 'SANTI', '232410080', '$2y$12$93z5EC4ve.r8b0Z41HCgQOyOALHALw2y.3tEEHXGf3NZygAW2MFy6', 'siswa', '2025-08-24 21:48:05', '2025-08-24 21:48:05'),
(1038, 'SITI PATIMAH', '232410081', '$2y$12$pJNY2XgsiQgclQlOl1sXt.yDN0AjYZlidjEKbnV5wdvOwIWte0KBS', 'siswa', '2025-08-24 21:48:05', '2025-08-24 21:48:05'),
(1039, 'TAHRI RAHMADANI', '232410082', '$2y$12$Bv9.THzzODFPyW2T//fs9OU9oR3xEREteivdO.MdKDHCeGL1holFG', 'siswa', '2025-08-24 21:48:06', '2025-08-24 21:48:06'),
(1040, 'TANGGUH AZIZI', '232410083', '$2y$12$hKoNrhrry56HQzwBCK/XquMOFLg4MmMnVWKfoAe1C4q8hLz.b.v0q', 'siswa', '2025-08-24 21:48:06', '2025-08-24 21:48:06'),
(1041, 'TARVIN', '232410084', '$2y$12$Cuh7qsoQgNgmf1p9/avdju/X4KQ.BvxE0OIqkjm9SuENesfcBQskG', 'siswa', '2025-08-24 21:48:06', '2025-08-24 21:48:06'),
(1042, 'AGUSTIAN ABDUR ROFIQ', '232410085', '$2y$12$4ZUEWf.W9.bRiAz1MKqcOuvqPsuvRM0CncoBYdJm8MzP5O4spJiHO', 'siswa', '2025-08-24 21:48:07', '2025-08-24 21:48:07'),
(1043, 'AHMAD REKSA', '232410086', '$2y$12$OVEsWn99zYUcJ7Au5EQ8V.oUZKP3lXtCnJJgQCjYmQDNiuRyjz9xS', 'siswa', '2025-08-24 21:48:07', '2025-08-24 21:48:07'),
(1044, 'AKBAR RAMADANI', '232410087', '$2y$12$VMcyQNOHbAGLivENzxSIqOBBHOtndkthCZ.qNzdF9e3jUk03HF61C', 'siswa', '2025-08-24 21:48:07', '2025-08-24 21:48:07'),
(1045, 'ANDREYAN SURYANA SAPUTRA', '232410088', '$2y$12$FNCl7qtEwl.EvL1Din9p1.Xdqh83a8kF9RPCAYbLF80Uy.r7MiJCq', 'siswa', '2025-08-24 21:48:07', '2025-08-24 21:48:07'),
(1046, 'ARIF PERMANA SIDIK', '232410089', '$2y$12$69/b4dAUPOJSYJ/zpBwKNuTXuFKOTPymF2K1JhDuooLd4dM2sN4WG', 'siswa', '2025-08-24 21:48:08', '2025-08-24 21:48:08'),
(1047, 'AYU ARYANAH', '232410090', '$2y$12$PwRIfky1vzZF31s8OqX4femEHs49yMrxZG27CdiPEklxYatev.l5a', 'siswa', '2025-08-24 21:48:08', '2025-08-24 21:48:08'),
(1048, 'BUSYAERI MAJID', '232410091', '$2y$12$Yp7kh6s0fFSljwiepZF1ruULoYwwaj.lnPsh04Z37BKkIUJlaSYXS', 'siswa', '2025-08-24 21:48:08', '2025-08-24 21:48:08'),
(1049, 'CARTIWAN', '232410092', '$2y$12$kz5lwnZ3m3vdr3e8WiTeSuwQucjM.aywqY0wEsIDYpjFDXrQR29kG', 'siswa', '2025-08-24 21:48:08', '2025-08-24 21:48:08'),
(1050, 'DAHLIA SRI RAHAYU', '232410093', '$2y$12$5Y1RWHYHpuHha5f0hZlqGu9i1WZLmYtMZs1M/1wk0PQnVu8NtZFt.', 'siswa', '2025-08-24 21:48:09', '2025-08-24 21:48:09'),
(1051, 'DERLY PRASETYO', '232410094', '$2y$12$DsFVGJYWKmDH2HZTq1Q2wessVI9NMs7FGvWpBDzYwEUlJW/AX5ac2', 'siswa', '2025-08-24 21:48:09', '2025-08-24 21:48:09'),
(1052, 'DETIYA KUSMAYADI', '232410095', '$2y$12$8Mas3bkvymQDJGcQmJP3NegsdOt86vSVNcGva75f0Xu1uTa.8ZlQW', 'siswa', '2025-08-24 21:48:09', '2025-08-24 21:48:09'),
(1053, 'DIMAS ROHMAN SAPUTRA', '232410096', '$2y$12$HVBXEynL12RBAF763XrtEuVlXygrEtt47ylCetQXvbf37hLqlKc2y', 'siswa', '2025-08-24 21:48:09', '2025-08-24 21:48:09'),
(1054, 'FAJAR FADILLAH', '232410097', '$2y$12$tcHzEQWiruZOwv4X2zCqOe8vwohe5nKov1y2JlOCC9tQAzgGbsMyO', 'siswa', '2025-08-24 21:48:10', '2025-08-24 21:48:10'),
(1055, 'FIKRI AHMAD MUBAROK', '232410098', '$2y$12$wlZNfz4a5DudJsUQrEFO3OFvpBaCkLYcMV2nibqkNRdLB0vXGhZbm', 'siswa', '2025-08-24 21:48:10', '2025-08-24 21:48:10'),
(1056, 'GUNAWAN', '232410099', '$2y$12$BRVe95DWckLVUoIlhrRtiOT931wdxkyQyXPcGFpNQ4xGiuRhzaY0m', 'siswa', '2025-08-24 21:48:10', '2025-08-24 21:48:10'),
(1057, 'HADI HOERUDIN', '232410100', '$2y$12$mcRg8LkOzNS7oBw1.G3fa.7Z7Pjg253o1HJKATcGIujN92wsdKSEG', 'siswa', '2025-08-24 21:48:10', '2025-08-24 21:48:10'),
(1058, 'IBNU QODA', '232410101', '$2y$12$GtSXq4fjgXSjAe3LlUeI3ubYSl2H5xGpISeD7p0.7mposSQe5BX7u', 'siswa', '2025-08-24 21:48:11', '2025-08-24 21:48:11'),
(1059, 'IHYA ULUMUDIN', '232410102', '$2y$12$Be6.lzjALbYZW6tN0bO6K.YJQWbYBef.vs.nC1E34qVHDJiDnBbV6', 'siswa', '2025-08-24 21:48:11', '2025-08-24 21:48:11'),
(1060, 'INTAN DAHLIA', '232410103', '$2y$12$qhSdL0luLQbp8.Yfjfjbb.arDpcEr0D7O.iBoKUUwJ9HvZEUUr7.G', 'siswa', '2025-08-24 21:48:11', '2025-08-24 21:48:11'),
(1061, 'INTAN NURAENI', '232410104', '$2y$12$qjFC/4Ciwhydp7kErKaCcOm2IitNI21MWVjnMwvF8KTG9vDJrRV42', 'siswa', '2025-08-24 21:48:11', '2025-08-24 21:48:11'),
(1062, 'LISNAWATI', '232410105', '$2y$12$jIClZYLf0qJjFvoFklRBW.pWSXkG7K2GgcbtC/FSGqVtH9De5YV5e', 'siswa', '2025-08-24 21:48:12', '2025-08-24 21:48:12'),
(1063, 'MAMAN ABDUL RAHMAN', '232410106', '$2y$12$zbNSC/9KWVMnmrPZNyhGnO9.blIOc5e.NnvJuaUCViL9PtuNGyxPK', 'siswa', '2025-08-24 21:48:12', '2025-08-24 21:48:12'),
(1064, 'MEILANI PUSPITA SARI', '232410107', '$2y$12$.EdYK5eVbIT127.Rf14Y7uhEaRVbHZkwSOO2.AdVKmcDHSlWGh8Jy', 'siswa', '2025-08-24 21:48:12', '2025-08-24 21:48:12'),
(1065, 'MUHAMAD AL NAZIB', '232410108', '$2y$12$kLuMFF4GaDpDj/Zn97HZfeftOoP06GBBdd4Y2L6PGpHluK38JBGla', 'siswa', '2025-08-24 21:48:13', '2025-08-24 21:48:13'),
(1066, 'NADIA ASMIRANDAH', '232410109', '$2y$12$.mQIkW67FGUH/XN8IPNCRexyly4Usddwq1f2zGQOgr8sd2OEXPUja', 'siswa', '2025-08-24 21:48:13', '2025-08-24 21:48:13'),
(1067, 'NATA ADITIYA', '232410110', '$2y$12$7sOP7ki/DOPk0TOvztx0VepP5SyE4PEIvXV.K93RQW1N2e6A7SfSi', 'siswa', '2025-08-24 21:48:13', '2025-08-24 21:48:13'),
(1068, 'NOFITA DEWAN TARI', '232410111', '$2y$12$2XxCqX4sJIU/E2KT.C1N4OHvvqmpr8aPJIGnW6SQ6BgQfUdBX8x.q', 'siswa', '2025-08-24 21:48:13', '2025-08-24 21:48:13'),
(1069, 'NOPAL BUKHORI', '232410112', '$2y$12$OPxQP1q9.11Qm9ZzcPvQp.GXizVvFYRj76GF.IwzaRM6AuSlTeHty', 'siswa', '2025-08-24 21:48:14', '2025-08-24 21:48:14'),
(1070, 'NOVIANTI', '232410113', '$2y$12$utlAlbwWHhRwz04k2d3QsOij43j9pSzPId6Gm3ivozQk3lHvSEfPq', 'siswa', '2025-08-24 21:48:14', '2025-08-24 21:48:14'),
(1071, 'RIDWAN FADILAH', '232410114', '$2y$12$AwQtH9LSmn7QxC0NffjqFepLMsXi/jgl1V5kZLupo0N6gYLNbuV06', 'siswa', '2025-08-24 21:48:14', '2025-08-24 21:48:14'),
(1072, 'SISKA AULIA', '232410115', '$2y$12$DLPgTkjSLb6qAsjaNEJ2iOnqSz4Ow2H8Kal02vXCXCAT3E0fS73v.', 'siswa', '2025-08-24 21:48:14', '2025-08-24 21:48:14'),
(1073, 'SUHENDAR', '232410116', '$2y$12$SsD7rneT4cC9A4.PkTAGhOU.o/JTVI0EQ.B28uAfcBccHTM.uJS5C', 'siswa', '2025-08-24 21:48:15', '2025-08-24 21:48:15');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1074, 'TOMI', '232410117', '$2y$12$dTxhcDJHqtgNLxMm10TrEeEGsG4P4z6WZrlboMYfbahTYAZShtNye', 'siswa', '2025-08-24 21:48:15', '2025-08-24 21:48:15'),
(1075, 'WARTA', '232410118', '$2y$12$nd.ERpFi1lEzwH3s6kRMw.A0jDL4XsNOdZp5WpC6lJeFvQSaLLCzW', 'siswa', '2025-08-24 21:48:15', '2025-08-24 21:48:15'),
(1076, 'ADAM MARIANSYAH', '232410119', '$2y$12$lam6OGGaZCDdk0sSei9BI.QtxRRpe3JTnVzdX2SAw06tyz7VoJkre', 'siswa', '2025-08-24 21:48:15', '2025-08-24 21:48:15'),
(1077, 'AJIJAH LESTARI', '232410120', '$2y$12$hGrmdf/sXDJAf6x/wdv.qO.tzMX0ybteLyTNU6Z5bT1ldUQCchzRy', 'siswa', '2025-08-24 21:48:16', '2025-08-24 21:48:16'),
(1078, 'ANDRIAN', '232410121', '$2y$12$tTo9VOQHyfrDPhTEGVpsuOI.lmUsj9YWTeWmdOeJ6aLfUY.w0dQqK', 'siswa', '2025-08-24 21:48:16', '2025-08-24 21:48:16'),
(1079, 'DENDI PRASETYO', '232410122', '$2y$12$AXxAoS6.U9WzCsuR3DvBF.Xso6pRG2/.kBo49APKWbFB30HxHsiZW', 'siswa', '2025-08-24 21:48:16', '2025-08-24 21:48:16'),
(1080, 'DIANA PUTRI AWALIAYAH', '232410123', '$2y$12$/ZD6HpZ3pnxzh9I8DhNOOe1MoK6nXwPFP4M2H7PDcG1uv0xYzji1i', 'siswa', '2025-08-24 21:48:16', '2025-08-24 21:48:16'),
(1081, 'DIFA HARIKURNIA', '232410124', '$2y$12$zZkdced3lIZTpVET2eOgyuqS7cys3Mp.lDJxFMA.TnJRi4IR72hBi', 'siswa', '2025-08-24 21:48:17', '2025-08-24 21:48:17'),
(1082, 'ENAH MAEMUNAH', '232410125', '$2y$12$FTbL6AMAe/7w6Ro2oXOS5.BiYHp3e/hcOOtx0fO0ZyyqRqPx8iUzG', 'siswa', '2025-08-24 21:48:17', '2025-08-24 21:48:17'),
(1083, 'FAIQ AHMAD NAUFAL', '232410126', '$2y$12$iUSBFUcalAg3JmMs2sKpqOKB19JMVVSgkt8gdmLWBhNJg53XACzL.', 'siswa', '2025-08-24 21:48:17', '2025-08-24 21:48:17'),
(1084, 'FERI SOPANDI', '232410127', '$2y$12$7AhIN29O5AHJu/5ti5ClNeqDirbXJxM4.qagGEj4A1W90hOEmbwWG', 'siswa', '2025-08-24 21:48:17', '2025-08-24 21:48:17'),
(1085, 'IKBAL MAULANA IBROHIM', '232410128', '$2y$12$tpRnSoiMxRIiCLljKy2vY.uJ1zb3TqBjHxSqLDLcSqT7YDZOUkJaq', 'siswa', '2025-08-24 21:48:18', '2025-08-24 21:48:18'),
(1086, 'KASMINAH', '232410129', '$2y$12$T3gvj02iImIrQjOXAVgZ5.czbA2cRvaeFJVE5MIesIqFmRq4UUMqe', 'siswa', '2025-08-24 21:48:18', '2025-08-24 21:48:18'),
(1087, 'KATIMAH', '232410130', '$2y$12$r9BcMPlKrmOcqXrzq0rmWeKje.yaQeeSQGHDXKwcCOEUyu.R1qJAO', 'siswa', '2025-08-24 21:48:18', '2025-08-24 21:48:18'),
(1088, 'LIGAR', '232410131', '$2y$12$pVF17O/O985wywMHifZ2OukUCRR4vn5dHgkJW0k2Chby4RMNUhDCG', 'siswa', '2025-08-24 21:48:18', '2025-08-24 21:48:18'),
(1089, 'MAYA', '232410132', '$2y$12$w9RiSzs4T7e7pJ3P0SUfX.apiRq0GRJgE/Vv4Dw3HzQiUEhrT2Ktm', 'siswa', '2025-08-24 21:48:19', '2025-08-24 21:48:19'),
(1090, 'MOH THOLIB RIVKI', '232410133', '$2y$12$H56tiC53LWBNc2CwPpCcgu/Csw.auDmV.9zxodax5pX36f.1MCF0q', 'siswa', '2025-08-24 21:48:19', '2025-08-24 21:48:19'),
(1091, 'MOHAMAD FEBRY AULIA', '232410134', '$2y$12$1wEXZJByEelnZuSFjbWUb./XJjN9iatwvzP3D5ki/7yVbYs9fzmsy', 'siswa', '2025-08-24 21:48:19', '2025-08-24 21:48:19'),
(1092, 'MOHAMAD RIDWAN', '232410135', '$2y$12$bXLmkmjteXNMb8gzWEzNIuuVxvhTSMuRrcq69T6EKDE221Tnzjlx.', 'siswa', '2025-08-24 21:48:20', '2025-08-24 21:48:20'),
(1093, 'MUHAMAD HAIDAR RIFAI', '232410136', '$2y$12$bmNJ8/PSaaReuJBmttcayO9F4JFfPFYKfCHxPr8K3PQQiNZNzNGka', 'siswa', '2025-08-24 21:48:20', '2025-08-24 21:48:20'),
(1094, 'MUHAMMAD WAHYUDI', '232410137', '$2y$12$QPAJTijmO4ko29hXLl1ZPumjjHWFCpGuPeRxEoOnlxwSV/xf068Vu', 'siswa', '2025-08-24 21:48:20', '2025-08-24 21:48:20'),
(1095, 'NADILA LIESHARTANTI', '232410138', '$2y$12$c89L1dTOVYeHs52tZUbobOymuskRELkE5iHBZ2v/JXMLp54BFjfzW', 'siswa', '2025-08-24 21:48:20', '2025-08-24 21:48:20'),
(1096, 'NARMAN', '232410139', '$2y$12$BbphhDs0Gi3q40IB8H5K7.IBT74KIL1PZriglnMdEbGt68OPEh26i', 'siswa', '2025-08-24 21:48:21', '2025-08-24 21:48:21'),
(1097, 'NOVA YANTO', '232410140', '$2y$12$WzHQJoeamIBiRrlUyCqMUecd.OeJqLc..yAlQ6LhXwWrkaY9HeDtq', 'siswa', '2025-08-24 21:48:21', '2025-08-24 21:48:21'),
(1098, 'OGI WIRAGUNA NAMRAIH', '232410141', '$2y$12$T6OeA8JEoyQy9wcG6y0n8.CmHdTxm8o6zbwhtNAMDzycF0mGS.VtS', 'siswa', '2025-08-24 21:48:21', '2025-08-24 21:48:21'),
(1099, 'PEPEN FAISAL AGUSTIAN', '232410142', '$2y$12$gvXdjpZvc6fe4KjI45qffeTYhdROOI4mg4fPMkDsBu8RKl0PsAY.G', 'siswa', '2025-08-24 21:48:21', '2025-08-24 21:48:21'),
(1100, 'RAHIL TRISNA', '232410143', '$2y$12$4ZcfS/a8BTIQoIIvIFrBrO4CNW83.iG0z.8D7zchFPy7eqLy1HM7y', 'siswa', '2025-08-24 21:48:22', '2025-08-24 21:48:22'),
(1101, 'RAMDANI', '232410144', '$2y$12$6Yrv63ES7vd47k0ucJmqZeugOFlBChJxcJnLFL4MytvBLnw3LvNDy', 'siswa', '2025-08-24 21:48:22', '2025-08-24 21:48:22'),
(1102, 'RANGGA MUHAMAD FARHAN', '232410145', '$2y$12$C9OqfE9jKafvGh9VwqiTdOe.lq5/0NBRSdjOY.5rFVeidBXzzOfzq', 'siswa', '2025-08-24 21:48:22', '2025-08-24 21:48:22'),
(1103, 'RATU AYU SARI', '232410146', '$2y$12$5BPT3rJ4yiYi4osvF4MHHudWJo4n.KBPkJiW2KnhwzEcIsBQ.DpIa', 'siswa', '2025-08-24 21:48:22', '2025-08-24 21:48:22'),
(1104, 'RENDI SUJAYA', '232410147', '$2y$12$juN4uIwMPQTemQRuhsyj/.jkcCZZxTXQJ51U2wMIIpL2HVSrpJufe', 'siswa', '2025-08-24 21:48:23', '2025-08-24 21:48:23'),
(1105, 'RENO AL FAUZI', '232410148', '$2y$12$bbovYxtPv8tpAlRO6.P0KuYuDMBa5rGMablRIvDELKgFwtpXahJhC', 'siswa', '2025-08-24 21:48:23', '2025-08-24 21:48:23'),
(1106, 'RIDWAN IBNU AL FARIJI', '232410149', '$2y$12$s3qiadHpA/blFIjkeNdINezmNi4wEKZCWFmbKeROv8yniW4df.m5u', 'siswa', '2025-08-24 21:48:23', '2025-08-24 21:48:23'),
(1107, 'RIFA AHMAD SOFYAN', '232410150', '$2y$12$APhV8u7qALWPdnXi81EtaurHvKnx/DVA7/0F3eWxJ8BqVU/8N90LG', 'siswa', '2025-08-24 21:48:23', '2025-08-24 21:48:23'),
(1108, 'SULTAN PERMANA PUTRA', '232410151', '$2y$12$sN6uKo2Nhfkh6LZk3zVdaOKUnE9dRyGbJ8qsGZfPH28mnQtaDwnNO', 'siswa', '2025-08-24 21:48:24', '2025-08-24 21:48:24'),
(1109, 'SUPARDI', '232410152', '$2y$12$ruFTtdN01fB843WCnbfYHuuV8MHiOPJQbgQ7vLzXsqM/974V7ZJXO', 'siswa', '2025-08-24 21:48:24', '2025-08-24 21:48:24'),
(1110, 'WIDIA', '232410153', '$2y$12$uDBXK0PidtdCwP.FTjbLfeKFOCcBh9NiKimnx98uHhG.XaPQojEi2', 'siswa', '2025-08-24 21:48:24', '2025-08-24 21:48:24'),
(1111, 'ABDUL ROSID', '232410154', '$2y$12$NSC2XO8vNmT7PffPixDk2OZCb8mEv4JywF24FyajiHOxU321JHnq6', 'siswa', '2025-08-24 21:48:24', '2025-08-24 21:48:24'),
(1112, 'AGUS', '232410155', '$2y$12$2bolP9n/Q6cBbCw9zY7.7u9ufBRXvoONeKQP4svMocl.e8SgDIxEu', 'siswa', '2025-08-24 21:48:25', '2025-08-24 21:48:25'),
(1113, 'AHMAD BAGIR', '232410156', '$2y$12$AwEbFjvQY7ZvjhVza7WxF.IMgi1fBLI4xLReL8aNChIvxkWYAg1Pm', 'siswa', '2025-08-24 21:48:25', '2025-08-24 21:48:25'),
(1114, 'AKBAR BAIDILLAH SATORIK', '232410157', '$2y$12$oxJJdh8G4Vf6mguA.ApJ0uF3PHxrE5Z/jpbKG4XuC6H8nT5uEk8wG', 'siswa', '2025-08-24 21:48:25', '2025-08-24 21:48:25'),
(1115, 'AMIRAH YULYANTI', '232410158', '$2y$12$f/lOZj.gWhpHD727KTYHpeLFaI7TF/RyOvSafjTquSGLUd35k.xEW', 'siswa', '2025-08-24 21:48:25', '2025-08-24 21:48:25'),
(1116, 'ANGGUN LESTARI', '232410159', '$2y$12$ovMWUFUOB52zrSCp8q9w8emHLv3ryS05MKcOM8To4Hc1PiSjRjgtG', 'siswa', '2025-08-24 21:48:26', '2025-08-24 21:48:26'),
(1117, 'DAHVA DERIANSAH', '232410160', '$2y$12$rB7dtrmvXd3BZx6OyxaVUub.PLDu0jym1DAwXfT2S4iMJ.NWrDFpa', 'siswa', '2025-08-24 21:48:26', '2025-08-24 21:48:26'),
(1118, 'DANA MAULANA', '232410161', '$2y$12$Q2fSwbgc2OVbdecws0ECXec5KolO2a/jo8HkXGILjuvOrrI2uYfFG', 'siswa', '2025-08-24 21:48:26', '2025-08-24 21:48:26'),
(1119, 'DEA NOVITA', '232410162', '$2y$12$5jOTvCbHWmdIPxZwGzr8JeRjDILMJRZ9zQ0CdQqiYJcV8Zq/1myPi', 'siswa', '2025-08-24 21:48:26', '2025-08-24 21:48:26'),
(1120, 'ELVIRA SELOMITHA ALENA', '232410163', '$2y$12$U.GhsocE8tp9WdlpoGpm0eWA9KKQIlFzVxC61L5yeCHc9s3bhVW7W', 'siswa', '2025-08-24 21:48:27', '2025-08-24 21:48:27'),
(1121, 'FACHRY HABIBURROHMAN', '232410164', '$2y$12$kuDWGTnECNPLGDzPPvBbrOKMGIO7rGZHBIWef.F.0WcKr/Qq3aFw.', 'siswa', '2025-08-24 21:48:27', '2025-08-24 21:48:27'),
(1122, 'FEBRIAN', '232410165', '$2y$12$pqW45hQ5j/Xj7hdPzRej2.kAoXXA3DCEd6wEt2PSsVKE.vVS5FQ4e', 'siswa', '2025-08-24 21:48:27', '2025-08-24 21:48:27'),
(1123, 'JANE DIKE PUTRI ARIAWAN', '232410166', '$2y$12$Mwe9u0RYXSUZxphuS4SILOhtj4BSFPJh6UADLPfAV99L68SA/3vF.', 'siswa', '2025-08-24 21:48:28', '2025-08-24 21:48:28'),
(1124, 'KOMALASARI', '232410167', '$2y$12$8b0k97wWzohwtygo6d/seuVt8Qdc.hhdH/p/RHwszu9PqdFbLZTT6', 'siswa', '2025-08-24 21:48:28', '2025-08-24 21:48:28'),
(1125, 'LUVITA RAHMA SARI', '232410168', '$2y$12$kWGzeU0FsdmARp1Ve3TCEOwlVim5ygaaidbZf5pn.GPLXeQIWxuNy', 'siswa', '2025-08-24 21:48:28', '2025-08-24 21:48:28'),
(1126, 'MAHMUD MUNANDAR', '232410169', '$2y$12$kqJkUWAokN/dcefcI2jiRu3KeI4ViARCyiuvggHg0EMA8lL8eCAo6', 'siswa', '2025-08-24 21:48:28', '2025-08-24 21:48:28'),
(1127, 'MARISA LINDA LESTARI', '232410170', '$2y$12$NZcIUwrTQC67CiOEXd96VObsBMA3AV2KRWvnMZ1.3.qPcc52WQFky', 'siswa', '2025-08-24 21:48:29', '2025-08-24 21:48:29'),
(1128, 'MILA SARI', '232410171', '$2y$12$j1cE7WSFv5D75IfkJ5mf8upIL0sIkEJEDTY0HyXGcyyC9sBIUt5Ae', 'siswa', '2025-08-24 21:48:29', '2025-08-24 21:48:29'),
(1129, 'MUHAMAD RAIHAN GUMILAR', '232410172', '$2y$12$CG0oRE4.dypMYKfukuK17OOcJjqF0ny/hFr7hlNR1tJFrKSLgX0D6', 'siswa', '2025-08-24 21:48:29', '2025-08-24 21:48:29'),
(1130, 'MUHAMAD YUGA', '232410173', '$2y$12$jPXM3cQYPFm7paEPeV0z9uLIwE4Pw09tbFb0QoJm0MB8BWZ8WrJ3e', 'siswa', '2025-08-24 21:48:29', '2025-08-24 21:48:29'),
(1131, 'RAFI ALHABSY', '232410174', '$2y$12$62mbgMT/haibX6CjrBhG9.diSgdlqIs7migE7GIEB1huqDLsZQJ1m', 'siswa', '2025-08-24 21:48:30', '2025-08-24 21:48:30'),
(1132, 'RAHMAN', '232410175', '$2y$12$iCuUTBSAXkZfaWMk1ECJo.UlI5Ms44UvCfs.7gEtO0pUtjVOKI6pa', 'siswa', '2025-08-24 21:48:30', '2025-08-24 21:48:30'),
(1133, 'RAZAN MUHAMMAD IHSAN', '232410176', '$2y$12$iW1fSZAtYC37317.SKDzU.wn14lbAYd3G9508qHggJJJMjgyj0.2.', 'siswa', '2025-08-24 21:48:30', '2025-08-24 21:48:30'),
(1134, 'RIAN ADRIANSYAH', '232410177', '$2y$12$VyDTclbqM/s61ho6cuVMRO3EoxYaJh0kNRsu1nherE95/ZLoT40FG', 'siswa', '2025-08-24 21:48:30', '2025-08-24 21:48:30'),
(1135, 'RIAN FIKRIANSAH', '232410178', '$2y$12$Av.eXPChgOTceg9.4VB49e9Ygp0qQl1IUKgGVmq7AA5fk9qy0qqxq', 'siswa', '2025-08-24 21:48:31', '2025-08-24 21:48:31'),
(1136, 'RIF AN RIZIQ', '232410179', '$2y$12$0vHtIvn6iXZJV.vlUysc7eOJV3V3kdjhdaEQX2tK/gToffDyjJBia', 'siswa', '2025-08-24 21:48:31', '2025-08-24 21:48:31'),
(1137, 'ROHMAT HIDAYAT', '232410180', '$2y$12$NZUQ2etcTNJ5BFxmxQ0HPOXJ2EdlTQRTbwW3tvTHD1nFqTY8UcHmy', 'siswa', '2025-08-24 21:48:31', '2025-08-24 21:48:31'),
(1138, 'RUDITA PRATAMA', '232410181', '$2y$12$JWAoDjbDtU1VOEZ0TlDxxu8SFOd22MlHN5qiNnDrLBujGlcs8Swu.', 'siswa', '2025-08-24 21:48:31', '2025-08-24 21:48:31'),
(1139, 'SOPAN SOPIAN', '232410182', '$2y$12$exC7rXOcPWAT00naEXLryuBLjYddXsOKu3qPZYn8afUurmKi7UJY.', 'siswa', '2025-08-24 21:48:32', '2025-08-24 21:48:32'),
(1140, 'SRI WULANDARI', '232410183', '$2y$12$eVPzLTLF7INqihiYPU9JjO.TCfxGxOmyNTFNN9dJGB2HR.wxA9rL.', 'siswa', '2025-08-24 21:48:32', '2025-08-24 21:48:32'),
(1141, 'TONI JAYA SAPUTRA', '232410184', '$2y$12$IWEPv5H6A7zh49n3Wi/XxecC0n1xBQl/Cfk.PtHUVPUv0bRIo6MRu', 'siswa', '2025-08-24 21:48:32', '2025-08-24 21:48:32'),
(1142, 'USUP', '232410185', '$2y$12$Xq0iYiwQxa9Kvao2fVy2cuz3SC03nhEwVVrFzBjx46WFZ28iS9gX.', 'siswa', '2025-08-24 21:48:32', '2025-08-24 21:48:32'),
(1143, 'WAHYU REKSA DIFA', '232410186', '$2y$12$l5UigOM0fKCa6bkjAzPg1Oqftag3qgTe3oVd0xTgo2P5B/n5kxGve', 'siswa', '2025-08-24 21:48:33', '2025-08-24 21:48:33'),
(1144, 'YAYAN HERMANTO', '232410187', '$2y$12$sZRXKmSieY9AGxpCeiPlquZHmDEpeY2xP.7u1DZTQd75CUisszula', 'siswa', '2025-08-24 21:48:33', '2025-08-24 21:48:33'),
(1145, 'AHMAD FAUZAN', '232410188', '$2y$12$NW/n9Jzq7ncYTuLMdU5yMuQmyQYrCTtDv8gpswL2SGGDrhi8hke7K', 'siswa', '2025-08-24 21:48:33', '2025-08-24 21:48:33'),
(1146, 'AKBAR NANDA RUKMANA', '232410189', '$2y$12$EDj6BqsSGlovxSD0Ltxcgu.nVeoVRoxcclodJYxwiQToVbPYshbr.', 'siswa', '2025-08-24 21:48:34', '2025-08-24 21:48:34'),
(1147, 'ANGELLYA', '232410190', '$2y$12$Xvsh/N2bgCcPDJqDJZ4duuicASYl6iH8vwZTOo2QJCVC1SzRHiAoa', 'siswa', '2025-08-24 21:48:34', '2025-08-24 21:48:34'),
(1148, 'APID', '232410191', '$2y$12$kmSaMyUd4yL5yMEakxAmCegCFshrUaD0BHuBuczKak20qTtElK8vC', 'siswa', '2025-08-24 21:48:34', '2025-08-24 21:48:34'),
(1149, 'DIAN MUHLISOTUL ULFIAH', '232410192', '$2y$12$0fBftD1AXqP9wwe1HwcZIuqm8Xqy50Sy.Fqldkay8rHp68eSTOY7u', 'siswa', '2025-08-24 21:48:34', '2025-08-24 21:48:34'),
(1150, 'DIAN PERMATASARI', '232410193', '$2y$12$HNijcgDdKLiJzH6TfPxQk..9mifpLp/V9QgrFgl35V5BUmxt0a97u', 'siswa', '2025-08-24 21:48:35', '2025-08-24 21:48:35'),
(1151, 'EKA PURWANA', '232410194', '$2y$12$W0ngC4asaWy1sQAWVVZ.BedZYdSBf3s7ssxWTonlVaSJWtjHamVZq', 'siswa', '2025-08-24 21:48:35', '2025-08-24 21:48:35'),
(1152, 'FAISHAL FAKHRI', '232410195', '$2y$12$gttP.4t0rJ6v50tdjt7bbeUVWGJMRcX.xFnV8WRMVP26DrM0GXJSO', 'siswa', '2025-08-24 21:48:35', '2025-08-24 21:48:35'),
(1153, 'HADI RAHMAN', '232410196', '$2y$12$NEwC.bAHSWyIBPB38E9FFOyq1IpLvwOCcDVFItM..Omk/J1MKMwLy', 'siswa', '2025-08-24 21:48:36', '2025-08-24 21:48:36'),
(1154, 'INTAN', '232410197', '$2y$12$eJm98fv/wcfnK8YfKAJ2auLQb5ku8oIobtUyleFQsGqXn5jd0PKjG', 'siswa', '2025-08-24 21:48:36', '2025-08-24 21:48:36'),
(1155, 'IRSAN TICKNO', '232410198', '$2y$12$riy5S3shBcgx09Io8P5r2OlPUwKpWqI8Y9oyqIm3MTUA9wHxUz4OK', 'siswa', '2025-08-24 21:48:36', '2025-08-24 21:48:36'),
(1156, 'JAJANG KOSWARA', '232410199', '$2y$12$vlIOjnr7LsygtGaeyJ4lQuGTZKAXvzvH7fOqGnQg60TiOh8T4vVtu', 'siswa', '2025-08-24 21:48:36', '2025-08-24 21:48:36'),
(1157, 'JIHAN HOLIYANA', '232410200', '$2y$12$F.K5VRlwuWElFMUUH/8Sd.mFyTHp3WQsT5y05RLVE25oBu/Idgvem', 'siswa', '2025-08-24 21:48:37', '2025-08-24 21:48:37'),
(1158, 'MARYADI', '232410201', '$2y$12$MHOm1K.0J1RD0pOvJ5MVrONamuLqAT06qBmmndyklc7DGcThGLBrq', 'siswa', '2025-08-24 21:48:37', '2025-08-24 21:48:37'),
(1159, 'MUHAMAD ALIN', '232410202', '$2y$12$6BgkJYKr2N6DSYgOhKKgTehQ30DbXnAtu0Ru1F5v/IbwXl.BQ96.G', 'siswa', '2025-08-24 21:48:37', '2025-08-24 21:48:37'),
(1160, 'MUHAMAD RONI ADITIA', '232410203', '$2y$12$y7GsyXXP3LMrmsemeb1Et.6MTGUp./6mTyC1Ha7aUxMsXv4N1S3g6', 'siswa', '2025-08-24 21:48:37', '2025-08-24 21:48:37'),
(1161, 'MUHAMMAD REIVANDI', '232410204', '$2y$12$nw3XozSDCZSDirebacmEf.PxWl2F8ag9KfqBJydJFSiDW.SI7wHQa', 'siswa', '2025-08-24 21:48:38', '2025-08-24 21:48:38'),
(1162, 'MUKHAMAD MARUF', '232410205', '$2y$12$NQkXzOnoryniabK5NazGoe27BzftRka29/ZT29p1Y9IOgNJBDc.qK', 'siswa', '2025-08-24 21:48:38', '2025-08-24 21:48:38'),
(1163, 'NURI AGUSTINA', '232410206', '$2y$12$QPLoacycEpD0go5Y.lpn/O7U2MzePLoQRMILmIoLKbI5TbceQkVBa', 'siswa', '2025-08-24 21:48:38', '2025-08-24 21:48:38'),
(1164, 'RAHMAT HIDAYAT', '232410207', '$2y$12$ifQVcGDY3I1xmeWn.pbZQeHme5y.0v87oBgxvrt4xHiOWam0Wy2tC', 'siswa', '2025-08-24 21:48:38', '2025-08-24 21:48:38'),
(1165, 'RAMDANI', '232410208', '$2y$12$SXe/AK6ShuTxFlfPNhPG7OSCYkl9Zz3sQnkUW/4WWseo6I7NeYjsC', 'siswa', '2025-08-24 21:48:39', '2025-08-24 21:48:39'),
(1166, 'REYJA', '232410209', '$2y$12$/JLW2u8x./.EHIf.fw64PeqxE0Q8royQaK8lvweQardJSAis3sMd.', 'siswa', '2025-08-24 21:48:39', '2025-08-24 21:48:39'),
(1167, 'RIYAN ARYANTO', '232410210', '$2y$12$sfu5qxAEhHL6H1xpq0aAde5GUMcQDc3mmKYAXmsXwrtcgXL/0lV0u', 'siswa', '2025-08-24 21:48:39', '2025-08-24 21:48:39'),
(1168, 'RIZZKI AKBAR ALFATIRI', '232410211', '$2y$12$IB2jYl52308OIDbJEGMTouiL4RgsBCNTWfN8FBLXjOpH4cX09dRQa', 'siswa', '2025-08-24 21:48:40', '2025-08-24 21:48:40'),
(1169, 'ROPI LORO SOPANJI', '232410212', '$2y$12$Z2NKTKKp7f4j2WPub5b7FeYjlmTBuSTLeF9kfafwdpFaPF0.Z0DOS', 'siswa', '2025-08-24 21:48:40', '2025-08-24 21:48:40'),
(1170, 'SUYUTI AHMAD BUSAERI', '232410213', '$2y$12$TSUtuHLXg945Os8goX09QOeBPipnETvAAJrlDCUxxXi8t89vdKAM2', 'siswa', '2025-08-24 21:48:40', '2025-08-24 21:48:40'),
(1171, 'TITI NURJANAH', '232410214', '$2y$12$jokU3StOFuY3bNSnJgWpl.OGJpmY42O8g72R7CGWEML/b8DY5rCYe', 'siswa', '2025-08-24 21:48:40', '2025-08-24 21:48:40'),
(1172, 'WIRANATA', '232410215', '$2y$12$hq7uCcnORDS.7ocCfDtoDuTbnolKTv3pf9nn8vkWx3Ovn4gHi6m3C', 'siswa', '2025-08-24 21:48:41', '2025-08-24 21:48:41'),
(1173, 'YAZID RAHMAT HIDAYAT', '232410216', '$2y$12$oyaDpN4dT/FUMMB7wHshau9rgQ8HQNIA494LaiVGxKH37HDJNIkR2', 'siswa', '2025-08-24 21:48:41', '2025-08-24 21:48:41'),
(1174, 'YUDIS TIRA ROMANSAH', '232410217', '$2y$12$vvWom46a7e/akRQBmNcJb.5CYVPhE6gK6sXXeLCGfjsbamZlHNeR6', 'siswa', '2025-08-24 21:48:41', '2025-08-24 21:48:41'),
(1175, 'YULI DEWIYANTI', '232410218', '$2y$12$9xB/axaV8YevjbsCsdG55OcqOKcB.yeQB03jx7.U8exKJF.bcjzRG', 'siswa', '2025-08-24 21:48:41', '2025-08-24 21:48:41'),
(1176, 'YULITA', '232410219', '$2y$12$l9VodByUuy0Il41ha/Dyu.CMuvF.E5xea2ShF21sBoSn5nE171Vm6', 'siswa', '2025-08-24 21:48:42', '2025-08-24 21:48:42'),
(1177, 'ABDUL RONI', '232410220', '$2y$12$VEVmaZdhhDJ2IjiyuLW49O0qsC7xsug4Rj4kp2wXJQZ6zhClJWYtq', 'siswa', '2025-08-24 21:48:42', '2025-08-24 21:48:42'),
(1178, 'ABDUL SIDIK', '232410221', '$2y$12$on15zXr7a.K8CvEEdunuPuSkz7.mpjs7HqVlYEw.Zv9vp34vGXPm2', 'siswa', '2025-08-24 21:48:42', '2025-08-24 21:48:42'),
(1179, 'AEL GHAZALI', '232410222', '$2y$12$K0So1uusymnW.NAFN8iDXuRLBhigwewGZh2.yYVmBpK85XhgxpTN.', 'siswa', '2025-08-24 21:48:42', '2025-08-24 21:48:42'),
(1180, 'AHMAD FAHRI YUNMAR', '232410223', '$2y$12$2Ze6wQ7E354ZkqL6xHJvZ.KaMrAa42dNKFGJ6kNxA9dpJpRNtj.v6', 'siswa', '2025-08-24 21:48:43', '2025-08-24 21:48:43'),
(1181, 'AHMAD ZAKKY JAELANI', '232410224', '$2y$12$OQA6BWacL/aPPGVMoGrlO.w6VHFsfAYohc19vSYcXDNKz.1R5QLXK', 'siswa', '2025-08-24 21:48:43', '2025-08-24 21:48:43'),
(1182, 'AHMAL', '232410225', '$2y$12$bMGQfD7F62951gDqeKEqX.v1jsU/LrC0iR1jecLsmFDbAWSgM9CAq', 'siswa', '2025-08-24 21:48:43', '2025-08-24 21:48:43'),
(1183, 'AKBAR SUGIHARTONO', '232410226', '$2y$12$OlF7hjfk9C060bWrta13Keq3dtDi1NeHH3ycc3jiP8AZN5XSeDIVm', 'siswa', '2025-08-24 21:48:43', '2025-08-24 21:48:43'),
(1184, 'AMELDA FIKRIA', '232410227', '$2y$12$ejAD9Hw8vqK3gs6TTge2gOiSniwhaxDA0qvG32dUB61XsyaG3SkF2', 'siswa', '2025-08-24 21:48:44', '2025-08-24 21:48:44'),
(1185, 'ARHAM SODIK', '232410228', '$2y$12$bOwXx9abFD8m7FiDSCTW5.EMU9/L9EBGGsZod.FQgD.8J2z.2Fwpy', 'siswa', '2025-08-24 21:48:44', '2025-08-24 21:48:44'),
(1186, 'ATISAH', '232410229', '$2y$12$suQMO7QdHQ6vZkMV0d2FLeeS5L4cTNMlzcJT7Vkg7IsHRurB6sjky', 'siswa', '2025-08-24 21:48:44', '2025-08-24 21:48:44'),
(1187, 'CAHYA KOMARA', '232410230', '$2y$12$m9NxYDM2abKnrb0DMbjFw.jfbVqgjoxNoPln7mHnxQOuPV4BBJigm', 'siswa', '2025-08-24 21:48:44', '2025-08-24 21:48:44'),
(1188, 'DEDEN', '232410231', '$2y$12$qFGXksfZf8raLyCS7LdBterceSxph97uwlPT/5kuFgTZ8oN60Tz1G', 'siswa', '2025-08-24 21:48:45', '2025-08-24 21:48:45'),
(1189, 'FITRIA ANGGRAENI', '232410232', '$2y$12$uYClJWNduVjvOeo2eIETFOSgM/3.daez4WwHGcClqK.PLNtnuwuku', 'siswa', '2025-08-24 21:48:45', '2025-08-24 21:48:45'),
(1190, 'FITRIA RAMADANI', '232410233', '$2y$12$JlaqBLnKVqPNiOkYgpRAXu4Tf6Qic6QBOGYr3yE9DOj/MkpyGLbOW', 'siswa', '2025-08-24 21:48:45', '2025-08-24 21:48:45'),
(1191, 'GITA MELINDA SARI', '232410234', '$2y$12$mpdkMPxWdCZrW98YAf/efeT7QjA87VJzyhdrbfyUh3iYia8ldXJmS', 'siswa', '2025-08-24 21:48:45', '2025-08-24 21:48:45'),
(1192, 'IBNU HASAN', '232410235', '$2y$12$xhjL69YFRzXa1D5A.kX.nuaNUn39mTHKY963uQpiy62L4sDDBvBFC', 'siswa', '2025-08-24 21:48:46', '2025-08-24 21:48:46'),
(1193, 'JAJANG SUTEJA', '232410236', '$2y$12$rtTOjxviGI1WMLwBUJvjTOIMinIqZERjcdI0m4r2yF15XcbSAqcVW', 'siswa', '2025-08-24 21:48:46', '2025-08-24 21:48:46'),
(1194, 'KARNOM', '232410237', '$2y$12$wiKwSRt7JbkWjjr8QCOI6eG6VeDg9FPj/Mhg702sM.KusUVZhbYYC', 'siswa', '2025-08-24 21:48:46', '2025-08-24 21:48:46'),
(1195, 'KARYA MULYANA', '232410238', '$2y$12$GxbC04IPwYruWlsVBvyfm.npxdgZenCSxZqxNBrI92SmHRiiQOE6C', 'siswa', '2025-08-24 21:48:46', '2025-08-24 21:48:46'),
(1196, 'KHAIRUL IKHWAN ABBASY', '232410239', '$2y$12$st6/hvkYxYqXncXdK/Euw.ULPG/2YeeaYNRrMk2Yl250FbO6Xu/4i', 'siswa', '2025-08-24 21:48:47', '2025-08-24 21:48:47'),
(1197, 'MAULIDDANI AHMAD NURHANDIKA', '232410240', '$2y$12$bjeuIBF48AAnTIRg2EtY1.xrQ8DrcUn1644QR7l.MtyFMJ1dhXwRC', 'siswa', '2025-08-24 21:48:47', '2025-08-24 21:48:47'),
(1198, 'MELI IMELDA', '232410241', '$2y$12$JH4it6nJfSX6zNfLVbr9j.6W8Cb9XHSzHcOUmsCv0jWZA3ODjrLIa', 'siswa', '2025-08-24 21:48:47', '2025-08-24 21:48:47'),
(1199, 'MUHAMAD ROSANDI', '232410242', '$2y$12$2mhwMub0VotsMOunBmRCKudT5r.c8J1AJs4weM4JBFGqO6fzAsODO', 'siswa', '2025-08-24 21:48:47', '2025-08-24 21:48:47'),
(1200, 'MUHAMMAD RAFA FAUZAN', '232410243', '$2y$12$cs4y82z2CBFLROSRm3e.SuxJd5rBxrBqlKvXkXweBfE2fOTKkdkqS', 'siswa', '2025-08-24 21:48:48', '2025-08-24 21:48:48'),
(1201, 'MUHAMMAD RAIHAN', '232410244', '$2y$12$BihsImPe8EPh5TqYkR0RMu7CxcESor2vG1SfsHcNs7noSgypVVMDq', 'siswa', '2025-08-24 21:48:48', '2025-08-24 21:48:48'),
(1202, 'NOVIANI', '232410245', '$2y$12$vMucxNZZO/ZqY4/jfLOmVem6rOcLTTCRRTgnVPczBwxnKxKKb8A8C', 'siswa', '2025-08-24 21:48:48', '2025-08-24 21:48:48'),
(1203, 'PIRMANSAH', '232410246', '$2y$12$orCgbVdJlTF4vmaaso.ChOVxC21TJ7A0XUl6aAOS7zkIiwitCLu/O', 'siswa', '2025-08-24 21:48:49', '2025-08-24 21:48:49'),
(1204, 'RADO SAPERO', '232410247', '$2y$12$KFTiq37Nf4tkUqkny1wH7OIc.qwjjVBN8tIIOfPre8ifptzjc9HgW', 'siswa', '2025-08-24 21:48:49', '2025-08-24 21:48:49'),
(1205, 'SAEPUL PIRDAUS', '232410248', '$2y$12$6zu09iNkCYuKttRO0tEx8OAjnLJdjCrv3qPmV327toiYQPQPD4Jgm', 'siswa', '2025-08-24 21:48:49', '2025-08-24 21:48:49'),
(1206, 'SUHENDAR', '232410249', '$2y$12$XUvPZzyS7w5CW..q2ypSzOCpdZv180baYqa.iNZaf/eewdQffVI7S', 'siswa', '2025-08-24 21:48:49', '2025-08-24 21:48:49'),
(1207, 'WIDHI BAGASKORO', '232410250', '$2y$12$jDxNShArG27SkpRJFSO.ZeGnY6jzTRsZclhGxyFfC/aJvJXB5El6i', 'siswa', '2025-08-24 21:48:50', '2025-08-24 21:48:50'),
(1208, 'YULI', '232410251', '$2y$12$NcPiZdhqR9Rul6X4dBaLNufv/NBQyCDQXwu8jjbjlDS1wyX60TCJa', 'siswa', '2025-08-24 21:48:50', '2025-08-24 21:48:50'),
(1209, 'ZEN ANFASA HIDAYAT', '232410252', '$2y$12$ZXBsgM8wfEEu0j65e4hZsuuFGk2filzWneERW5GdrUs1KB2iPqKsK', 'siswa', '2025-08-24 21:48:50', '2025-08-24 21:48:50'),
(1210, 'ABDUL ROHMAN', '232410253', '$2y$12$EQA36eig160hebJM/W35n.ZkBvaOPqx19lIpbNSwZEYEa/iEkEecK', 'siswa', '2025-08-24 21:48:50', '2025-08-24 21:48:50'),
(1211, 'ASEP SUJANA', '232410254', '$2y$12$kBaEhKRsu0Ndrk1wvKsEteX.zYRdMvQ3zwF6glPw03vPtP/Ce8m3C', 'siswa', '2025-08-24 21:48:51', '2025-08-24 21:48:51'),
(1212, 'DEDE RAFII', '232410255', '$2y$12$ZdLxHfUjlJF93qXDfBz2hunyn4zFEgGAeusBAdN40ZFLYJ0yjMxNa', 'siswa', '2025-08-24 21:48:51', '2025-08-24 21:48:51'),
(1213, 'DEDI WAHIDIN', '232410256', '$2y$12$mT0g6DdgcO8OiJPSHb/UvOi2ASfPFEzlG6dfFpllNHP04gyDQNoJu', 'siswa', '2025-08-24 21:48:51', '2025-08-24 21:48:51'),
(1214, 'DETI DIAN TINI', '232410257', '$2y$12$4q3aiPga2kZ.0/Xzr.jYyONI3SqdpZrREdWolKV50uK3UsS127kuS', 'siswa', '2025-08-24 21:48:51', '2025-08-24 21:48:51'),
(1215, 'ERNA WIDIAWATI S', '232410258', '$2y$12$Tv98okzVMl/DXxbXrT6hYuwK42v6aPaqKMHXtIExMbvnl6OzIZQwu', 'siswa', '2025-08-24 21:48:52', '2025-08-24 21:48:52'),
(1216, 'ERNI WIDIAWATI S', '232410259', '$2y$12$X/WSK1RWeUkZ9Qv/oWWoGuhoyI2jzXUWlso7Gd9eaautiDNU/KHzu', 'siswa', '2025-08-24 21:48:52', '2025-08-24 21:48:52'),
(1217, 'HUSEN SOBARNA', '232410260', '$2y$12$TttF71V1tIWEMi5tFis/WOQqA0wt5N2ccgcGAPhiD33FsCUUb5Qnq', 'siswa', '2025-08-24 21:48:52', '2025-08-24 21:48:52'),
(1218, 'IBNI MUHAJIR', '232410261', '$2y$12$f8BlL6fnJnZx.mRsGl0o9.JUKAKjkaj30A9jcUPGsnJIPqLV1HLGu', 'siswa', '2025-08-24 21:48:52', '2025-08-24 21:48:52'),
(1219, 'IIP IVANKA', '232410262', '$2y$12$lpqo0w/EwipaDfU.SsxQ3OOMfXU8yPeaytqwyOWI0SybYXISIHUBC', 'siswa', '2025-08-24 21:48:53', '2025-08-24 21:48:53'),
(1220, 'IRFAN HIDAYAT', '232410263', '$2y$12$tI.5vlXG4s2xE6j2FLpgm.4yX/OtteSuSB67XohyRpSgxVC5cSuWW', 'siswa', '2025-08-24 21:48:53', '2025-08-24 21:48:53'),
(1221, 'KARDIANTO', '232410264', '$2y$12$KeB/XmsZhdTCJNaClx7nJeF3ISrETeoe0qz2RHJB.XNUoSvhlu8Zy', 'siswa', '2025-08-24 21:48:53', '2025-08-24 21:48:53'),
(1222, 'KISAR', '232410265', '$2y$12$JrafOPD0Bz2CnfOvIEIj5Okm1B6ty6MMYE/bM09yBGQs6UqDVuWBa', 'siswa', '2025-08-24 21:48:53', '2025-08-24 21:48:53'),
(1223, 'KORIYAH', '232410266', '$2y$12$.SGsw4VWG5mjR2zo7/bPl.VdL8C53Gm/raSnECsqZoLWl7ZtNn0vS', 'siswa', '2025-08-24 21:48:54', '2025-08-24 21:48:54'),
(1224, 'LINDA', '232410267', '$2y$12$9tb4f7xwKsOqJNUm5vcqQOThEVAabCEU.6pJy.sQ7FOmYICOjfoSi', 'siswa', '2025-08-24 21:48:54', '2025-08-24 21:48:54'),
(1225, 'MAYA ANJELINA FRATAMA', '232410268', '$2y$12$.q394Yqc7arazvai0msx1OpSGmsZQbenEn/kRtRsJyk0gAZuGRA46', 'siswa', '2025-08-24 21:48:54', '2025-08-24 21:48:54'),
(1226, 'MUHAMMAD ABDUL FAQIH', '232410269', '$2y$12$1ysoYLroeablU6mEFpeP4ejlOvT9jj9fWwFJZFCawEP.5CMS/umue', 'siswa', '2025-08-24 21:48:54', '2025-08-24 21:48:54'),
(1227, 'MUHAMMAD AHDA AL MUSYAROF', '232410270', '$2y$12$NoGMeYjnMpPfOhL9Wcxur.OYSSNyOu9IkHn0xxp.P/lNmuy9knqqO', 'siswa', '2025-08-24 21:48:55', '2025-08-24 21:48:55'),
(1228, 'MUHAMMAD FADLAN', '232410271', '$2y$12$0fg/mb7JO8hZt7rXDJBuUuwqvMAZvhkt8JscyxNqjOVkFecocGsuC', 'siswa', '2025-08-24 21:48:55', '2025-08-24 21:48:55'),
(1229, 'MUTIARA AZIZAH', '232410272', '$2y$12$uxtPxCiApctDl2DaYIdC0us86g9/ZSSReBSmQQ2g/9CGQVpnt07C2', 'siswa', '2025-08-24 21:48:55', '2025-08-24 21:48:55'),
(1230, 'NURAENI', '232410273', '$2y$12$kV9.rEZtJsshA0x4dKxfnubKu73dGm715hnzIgYoKj.588Wooqe.C', 'siswa', '2025-08-24 21:48:55', '2025-08-24 21:48:55'),
(1231, 'RAKA', '232410274', '$2y$12$OA54OulwfHjqUBuWrfwale2unzkAgIRsUhzAiQKxmB1XrqN8F3u5a', 'siswa', '2025-08-24 21:48:56', '2025-08-24 21:48:56'),
(1232, 'RIKI', '232410275', '$2y$12$lkQNtfX5DcYQk7wv2Fbp..NDc0Y4u3RoOJNGIXXWn4VkVgtpHaxuu', 'siswa', '2025-08-24 21:48:56', '2025-08-24 21:48:56'),
(1233, 'SAEPUL ANWAR', '232410276', '$2y$12$iz52Rru9HG86e5acJrBCXuY8mpJtvyJnZqeEJvX.SvyGJdYPrUZMe', 'siswa', '2025-08-24 21:48:56', '2025-08-24 21:48:56'),
(1234, 'WARMAN', '232410277', '$2y$12$SSovizHKH5GvNko1h/Q9ruExnp3ymFTM2dRK0EpOkJ4neCzd7MLPm', 'siswa', '2025-08-24 21:48:56', '2025-08-24 21:48:56'),
(1235, 'YASMIN', '232410278', '$2y$12$.bZSw7r/VP2lR7m6OYYzBecmre9OKceyy5SnKrcg/or1M7qnK1YaG', 'siswa', '2025-08-24 21:48:57', '2025-08-24 21:48:57');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `nama_pengepul` varchar(255) NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`id`, `id_admin`, `nama_pengepul`, `total_harga`, `created_at`, `updated_at`) VALUES
(2, 1, 'test', 1000.00, '2025-08-25 02:46:13', '2025-08-25 02:46:13');

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
('M4zLS8eisnuSO3Isc6i5HcFw3r66xpRknylWYjJF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieEVVNlRGU25ITXZnRGhDT0IybVlYek5ldDRobDJVU0V0WWdDM1VuaSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fX0=', 1756116187),
('X5mkKV1cxLl2rJsWmXDrt6Hgn7PPZ86JVTJqQVZE', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieDJEOXY4MGVOcGdwMzM4aDdqa1JDY0JWb1ZPN2lOSmY0OHo5UElIUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1756183232);

-- --------------------------------------------------------

--
-- Table structure for table `setoran`
--

CREATE TABLE `setoran` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_siswa` bigint(20) UNSIGNED NOT NULL,
  `id_jenis_sampah` bigint(20) UNSIGNED NOT NULL,
  `jumlah` decimal(8,2) NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `setoran`
--

INSERT INTO `setoran` (`id`, `id_siswa`, `id_jenis_sampah`, `jumlah`, `total_harga`, `id_admin`, `created_at`, `updated_at`) VALUES
(1, 431, 5, 10.00, 350.00, 1, '2025-08-25 02:04:42', '2025-08-25 02:04:42'),
(2, 957, 4, 1.00, 2000.00, 1, '2025-08-25 02:19:20', '2025-08-25 02:19:20');

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
(1, 'site_title', 'Bank Sampah TKM', '2025-08-24 22:07:40', '2025-08-24 22:07:40');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id`, `id_pengguna`, `id_kelas`, `nis`, `saldo`, `created_at`, `updated_at`) VALUES
(431, 432, 19, '252610001', 300.00, '2025-08-24 21:11:06', '2025-08-25 02:05:07'),
(432, 433, 19, '252610002', 0.00, '2025-08-24 21:11:06', '2025-08-24 21:11:06'),
(433, 434, 19, '252610003', 0.00, '2025-08-24 21:11:06', '2025-08-24 21:11:06'),
(434, 435, 19, '252610004', 0.00, '2025-08-24 21:11:06', '2025-08-24 21:11:06'),
(435, 436, 19, '252610005', 0.00, '2025-08-24 21:11:07', '2025-08-24 21:11:07'),
(436, 437, 19, '252610006', 0.00, '2025-08-24 21:11:07', '2025-08-24 21:11:07'),
(437, 438, 19, '252610007', 0.00, '2025-08-24 21:11:07', '2025-08-24 21:11:07'),
(438, 439, 19, '252610008', 0.00, '2025-08-24 21:11:07', '2025-08-24 21:11:07'),
(439, 440, 19, '252610009', 0.00, '2025-08-24 21:11:08', '2025-08-24 21:11:08'),
(440, 441, 19, '252610010', 0.00, '2025-08-24 21:11:08', '2025-08-24 21:11:08'),
(441, 442, 19, '252610011', 0.00, '2025-08-24 21:11:08', '2025-08-24 21:11:08'),
(442, 443, 19, '252610012', 0.00, '2025-08-24 21:11:08', '2025-08-24 21:11:08'),
(443, 444, 19, '252610013', 0.00, '2025-08-24 21:11:09', '2025-08-24 21:11:09'),
(444, 445, 19, '252610014', 0.00, '2025-08-24 21:11:09', '2025-08-24 21:11:09'),
(445, 446, 19, '252610015', 0.00, '2025-08-24 21:11:09', '2025-08-24 21:11:09'),
(446, 447, 19, '252610016', 0.00, '2025-08-24 21:11:10', '2025-08-24 21:11:10'),
(447, 448, 19, '252610017', 0.00, '2025-08-24 21:11:10', '2025-08-24 21:11:10'),
(448, 449, 19, '252610018', 0.00, '2025-08-24 21:11:10', '2025-08-24 21:11:10'),
(449, 450, 19, '252610019', 0.00, '2025-08-24 21:11:10', '2025-08-24 21:11:10'),
(450, 451, 19, '252610020', 0.00, '2025-08-24 21:11:11', '2025-08-24 21:11:11'),
(451, 452, 19, '252610021', 0.00, '2025-08-24 21:11:11', '2025-08-24 21:11:11'),
(452, 453, 19, '252610022', 0.00, '2025-08-24 21:11:11', '2025-08-24 21:11:11'),
(453, 454, 19, '252610023', 0.00, '2025-08-24 21:11:11', '2025-08-24 21:11:11'),
(454, 455, 19, '252610024', 0.00, '2025-08-24 21:11:12', '2025-08-24 21:11:12'),
(455, 456, 19, '252610025', 0.00, '2025-08-24 21:11:12', '2025-08-24 21:11:12'),
(456, 457, 19, '252610026', 0.00, '2025-08-24 21:11:12', '2025-08-24 21:11:12'),
(457, 458, 19, '252610027', 0.00, '2025-08-24 21:11:13', '2025-08-24 21:11:13'),
(458, 459, 20, '252610028', 0.00, '2025-08-24 21:11:13', '2025-08-24 21:11:13'),
(459, 460, 20, '252610029', 0.00, '2025-08-24 21:11:13', '2025-08-24 21:11:13'),
(460, 461, 20, '252610030', 0.00, '2025-08-24 21:11:13', '2025-08-24 21:11:13'),
(461, 462, 20, '252610031', 0.00, '2025-08-24 21:11:14', '2025-08-24 21:11:14'),
(462, 463, 20, '252610032', 0.00, '2025-08-24 21:11:14', '2025-08-24 21:11:14'),
(463, 464, 20, '252610033', 0.00, '2025-08-24 21:11:14', '2025-08-24 21:11:14'),
(464, 465, 20, '252610034', 0.00, '2025-08-24 21:11:14', '2025-08-24 21:11:14'),
(465, 466, 20, '252610035', 0.00, '2025-08-24 21:11:15', '2025-08-24 21:11:15'),
(466, 467, 20, '252610036', 0.00, '2025-08-24 21:11:15', '2025-08-24 21:11:15'),
(467, 468, 20, '252610037', 0.00, '2025-08-24 21:11:15', '2025-08-24 21:11:15'),
(468, 469, 20, '252610038', 0.00, '2025-08-24 21:11:16', '2025-08-24 21:11:16'),
(469, 470, 20, '252610039', 0.00, '2025-08-24 21:11:16', '2025-08-24 21:11:16'),
(470, 471, 20, '252610040', 0.00, '2025-08-24 21:11:16', '2025-08-24 21:11:16'),
(471, 472, 20, '252610041', 0.00, '2025-08-24 21:11:16', '2025-08-24 21:11:16'),
(472, 473, 20, '252610042', 0.00, '2025-08-24 21:11:17', '2025-08-24 21:11:17'),
(473, 474, 20, '252610043', 0.00, '2025-08-24 21:11:17', '2025-08-24 21:11:17'),
(474, 475, 20, '252610044', 0.00, '2025-08-24 21:11:17', '2025-08-24 21:11:17'),
(475, 476, 20, '252610045', 0.00, '2025-08-24 21:11:17', '2025-08-24 21:11:17'),
(476, 477, 20, '252610046', 0.00, '2025-08-24 21:11:18', '2025-08-24 21:11:18'),
(477, 478, 20, '252610047', 0.00, '2025-08-24 21:11:18', '2025-08-24 21:11:18'),
(478, 479, 20, '252610048', 0.00, '2025-08-24 21:11:18', '2025-08-24 21:11:18'),
(479, 480, 20, '252610049', 0.00, '2025-08-24 21:11:19', '2025-08-24 21:11:19'),
(480, 481, 20, '252610050', 0.00, '2025-08-24 21:11:19', '2025-08-24 21:11:19'),
(481, 482, 20, '252610051', 0.00, '2025-08-24 21:11:19', '2025-08-24 21:11:19'),
(482, 483, 20, '252610052', 0.00, '2025-08-24 21:11:19', '2025-08-24 21:11:19'),
(483, 484, 20, '252610053', 0.00, '2025-08-24 21:11:20', '2025-08-24 21:11:20'),
(484, 485, 20, '252610054', 0.00, '2025-08-24 21:11:20', '2025-08-24 21:11:20'),
(485, 486, 20, '252610055', 0.00, '2025-08-24 21:11:20', '2025-08-24 21:11:20'),
(486, 487, 20, '252610056', 0.00, '2025-08-24 21:11:20', '2025-08-24 21:11:20'),
(487, 488, 21, '252610057', 0.00, '2025-08-24 21:11:21', '2025-08-24 21:11:21'),
(488, 489, 21, '252610058', 0.00, '2025-08-24 21:11:21', '2025-08-24 21:11:21'),
(489, 490, 21, '252610059', 0.00, '2025-08-24 21:11:21', '2025-08-24 21:11:21'),
(490, 491, 21, '252610060', 0.00, '2025-08-24 21:11:21', '2025-08-24 21:11:21'),
(491, 492, 21, '252610061', 0.00, '2025-08-24 21:11:22', '2025-08-24 21:11:22'),
(492, 493, 21, '252610062', 0.00, '2025-08-24 21:11:22', '2025-08-24 21:11:22'),
(493, 494, 21, '252610063', 0.00, '2025-08-24 21:11:22', '2025-08-24 21:11:22'),
(494, 495, 21, '252610064', 0.00, '2025-08-24 21:11:22', '2025-08-24 21:11:22'),
(495, 496, 21, '252610065', 0.00, '2025-08-24 21:11:23', '2025-08-24 21:11:23'),
(496, 497, 21, '252610066', 0.00, '2025-08-24 21:11:23', '2025-08-24 21:11:23'),
(497, 498, 21, '252610067', 0.00, '2025-08-24 21:11:23', '2025-08-24 21:11:23'),
(498, 499, 21, '252610068', 0.00, '2025-08-24 21:11:24', '2025-08-24 21:11:24'),
(499, 500, 21, '252610069', 0.00, '2025-08-24 21:11:24', '2025-08-24 21:11:24'),
(500, 501, 21, '252610070', 0.00, '2025-08-24 21:11:24', '2025-08-24 21:11:24'),
(501, 502, 21, '252610071', 0.00, '2025-08-24 21:11:24', '2025-08-24 21:11:24'),
(502, 503, 21, '252610072', 0.00, '2025-08-24 21:11:25', '2025-08-24 21:11:25'),
(503, 504, 21, '252610073', 0.00, '2025-08-24 21:11:25', '2025-08-24 21:11:25'),
(504, 505, 21, '252610074', 0.00, '2025-08-24 21:11:25', '2025-08-24 21:11:25'),
(505, 506, 21, '252610075', 0.00, '2025-08-24 21:11:25', '2025-08-24 21:11:25'),
(506, 507, 21, '252610076', 0.00, '2025-08-24 21:11:26', '2025-08-24 21:11:26'),
(507, 508, 21, '252610077', 0.00, '2025-08-24 21:11:26', '2025-08-24 21:11:26'),
(508, 509, 21, '252610078', 0.00, '2025-08-24 21:11:26', '2025-08-24 21:11:26'),
(509, 510, 21, '252610079', 0.00, '2025-08-24 21:11:26', '2025-08-24 21:11:26'),
(510, 511, 21, '252610080', 0.00, '2025-08-24 21:11:27', '2025-08-24 21:11:27'),
(511, 512, 21, '252610081', 0.00, '2025-08-24 21:11:27', '2025-08-24 21:11:27'),
(512, 513, 21, '252610082', 0.00, '2025-08-24 21:11:27', '2025-08-24 21:11:27'),
(513, 514, 21, '252610083', 0.00, '2025-08-24 21:11:27', '2025-08-24 21:11:27'),
(514, 515, 21, '252610084', 0.00, '2025-08-24 21:11:28', '2025-08-24 21:11:28'),
(515, 516, 21, '252610085', 0.00, '2025-08-24 21:11:28', '2025-08-24 21:11:28'),
(516, 517, 21, '252610086', 0.00, '2025-08-24 21:11:28', '2025-08-24 21:11:28'),
(517, 518, 21, '252610087', 0.00, '2025-08-24 21:11:28', '2025-08-24 21:11:28'),
(518, 519, 21, '252610088', 0.00, '2025-08-24 21:11:29', '2025-08-24 21:11:29'),
(519, 520, 21, '252610089', 0.00, '2025-08-24 21:11:29', '2025-08-24 21:11:29'),
(520, 521, 21, '252610090', 0.00, '2025-08-24 21:11:29', '2025-08-24 21:11:29'),
(521, 522, 22, '252610091', 0.00, '2025-08-24 21:11:30', '2025-08-24 21:11:30'),
(522, 523, 22, '252610092', 0.00, '2025-08-24 21:11:30', '2025-08-24 21:11:30'),
(523, 524, 22, '252610093', 0.00, '2025-08-24 21:11:30', '2025-08-24 21:11:30'),
(524, 525, 22, '252610094', 0.00, '2025-08-24 21:11:30', '2025-08-24 21:11:30'),
(525, 526, 22, '252610095', 0.00, '2025-08-24 21:11:31', '2025-08-24 21:11:31'),
(526, 527, 22, '252610096', 0.00, '2025-08-24 21:11:31', '2025-08-24 21:11:31'),
(527, 528, 22, '252610097', 0.00, '2025-08-24 21:11:31', '2025-08-24 21:11:31'),
(528, 529, 22, '252610098', 0.00, '2025-08-24 21:11:31', '2025-08-24 21:11:31'),
(529, 530, 22, '252610099', 0.00, '2025-08-24 21:11:32', '2025-08-24 21:11:32'),
(530, 531, 22, '252610100', 0.00, '2025-08-24 21:11:32', '2025-08-24 21:11:32'),
(531, 532, 22, '252610101', 0.00, '2025-08-24 21:11:33', '2025-08-24 21:11:33'),
(532, 533, 22, '252610102', 0.00, '2025-08-24 21:11:33', '2025-08-24 21:11:33'),
(533, 534, 22, '252610103', 0.00, '2025-08-24 21:11:33', '2025-08-24 21:11:33'),
(534, 535, 22, '252610104', 0.00, '2025-08-24 21:11:33', '2025-08-24 21:11:33'),
(535, 536, 22, '252610105', 0.00, '2025-08-24 21:11:34', '2025-08-24 21:11:34'),
(536, 537, 22, '252610106', 0.00, '2025-08-24 21:11:34', '2025-08-24 21:11:34'),
(537, 538, 22, '252610107', 0.00, '2025-08-24 21:11:34', '2025-08-24 21:11:34'),
(538, 539, 22, '252610108', 0.00, '2025-08-24 21:11:34', '2025-08-24 21:11:34'),
(539, 540, 22, '252610109', 0.00, '2025-08-24 21:11:35', '2025-08-24 21:11:35'),
(540, 541, 22, '252610110', 0.00, '2025-08-24 21:11:35', '2025-08-24 21:11:35'),
(541, 542, 22, '252610111', 0.00, '2025-08-24 21:11:35', '2025-08-24 21:11:35'),
(542, 543, 22, '252610112', 0.00, '2025-08-24 21:11:35', '2025-08-24 21:11:35'),
(543, 544, 22, '252610113', 0.00, '2025-08-24 21:11:36', '2025-08-24 21:11:36'),
(544, 545, 22, '252610114', 0.00, '2025-08-24 21:11:36', '2025-08-24 21:11:36'),
(545, 546, 22, '252610115', 0.00, '2025-08-24 21:11:36', '2025-08-24 21:11:36'),
(546, 547, 22, '252610116', 0.00, '2025-08-24 21:11:36', '2025-08-24 21:11:36'),
(547, 548, 22, '252610117', 0.00, '2025-08-24 21:11:37', '2025-08-24 21:11:37'),
(548, 549, 22, '252610118', 0.00, '2025-08-24 21:11:37', '2025-08-24 21:11:37'),
(549, 550, 22, '252610119', 0.00, '2025-08-24 21:11:37', '2025-08-24 21:11:37'),
(550, 551, 22, '252610120', 0.00, '2025-08-24 21:11:38', '2025-08-24 21:11:38'),
(551, 552, 22, '252610121', 0.00, '2025-08-24 21:11:38', '2025-08-24 21:11:38'),
(552, 553, 22, '252610122', 0.00, '2025-08-24 21:11:38', '2025-08-24 21:11:38'),
(553, 554, 22, '252610123', 0.00, '2025-08-24 21:11:38', '2025-08-24 21:11:38'),
(554, 555, 22, '252610124', 0.00, '2025-08-24 21:11:39', '2025-08-24 21:11:39'),
(555, 556, 23, '252610125', 0.00, '2025-08-24 21:11:39', '2025-08-24 21:11:39'),
(556, 557, 23, '252610126', 0.00, '2025-08-24 21:11:39', '2025-08-24 21:11:39'),
(557, 558, 23, '252610127', 0.00, '2025-08-24 21:11:40', '2025-08-24 21:11:40'),
(558, 559, 23, '252610128', 0.00, '2025-08-24 21:11:40', '2025-08-24 21:11:40'),
(559, 560, 23, '252610129', 0.00, '2025-08-24 21:11:40', '2025-08-24 21:11:40'),
(560, 561, 23, '252610130', 0.00, '2025-08-24 21:11:40', '2025-08-24 21:11:40'),
(561, 562, 23, '252610131', 0.00, '2025-08-24 21:11:41', '2025-08-24 21:11:41'),
(562, 563, 23, '252610132', 0.00, '2025-08-24 21:11:41', '2025-08-24 21:11:41'),
(563, 564, 23, '252610133', 0.00, '2025-08-24 21:11:41', '2025-08-24 21:11:41'),
(564, 565, 23, '252610134', 0.00, '2025-08-24 21:11:42', '2025-08-24 21:11:42'),
(565, 566, 23, '252610135', 0.00, '2025-08-24 21:11:42', '2025-08-24 21:11:42'),
(566, 567, 23, '252610136', 0.00, '2025-08-24 21:11:42', '2025-08-24 21:11:42'),
(567, 568, 23, '252610137', 0.00, '2025-08-24 21:11:42', '2025-08-24 21:11:42'),
(568, 569, 23, '252610138', 0.00, '2025-08-24 21:11:43', '2025-08-24 21:11:43'),
(569, 570, 23, '252610139', 0.00, '2025-08-24 21:11:43', '2025-08-24 21:11:43'),
(570, 571, 23, '252610140', 0.00, '2025-08-24 21:11:43', '2025-08-24 21:11:43'),
(571, 572, 23, '252610141', 0.00, '2025-08-24 21:11:43', '2025-08-24 21:11:43'),
(572, 573, 23, '252610142', 0.00, '2025-08-24 21:11:44', '2025-08-24 21:11:44'),
(573, 574, 23, '252610143', 0.00, '2025-08-24 21:11:44', '2025-08-24 21:11:44'),
(574, 575, 23, '252610144', 0.00, '2025-08-24 21:11:44', '2025-08-24 21:11:44'),
(575, 576, 23, '252610145', 0.00, '2025-08-24 21:11:45', '2025-08-24 21:11:45'),
(576, 577, 23, '252610146', 0.00, '2025-08-24 21:11:45', '2025-08-24 21:11:45'),
(577, 578, 23, '252610147', 0.00, '2025-08-24 21:11:45', '2025-08-24 21:11:45'),
(578, 579, 23, '252610148', 0.00, '2025-08-24 21:11:45', '2025-08-24 21:11:45'),
(579, 580, 23, '252610149', 0.00, '2025-08-24 21:11:46', '2025-08-24 21:11:46'),
(580, 581, 23, '252610150', 0.00, '2025-08-24 21:11:46', '2025-08-24 21:11:46'),
(581, 582, 23, '252610151', 0.00, '2025-08-24 21:11:46', '2025-08-24 21:11:46'),
(582, 583, 23, '252610152', 0.00, '2025-08-24 21:11:46', '2025-08-24 21:11:46'),
(583, 584, 23, '252610153', 0.00, '2025-08-24 21:11:47', '2025-08-24 21:11:47'),
(584, 585, 23, '252610154', 0.00, '2025-08-24 21:11:47', '2025-08-24 21:11:47'),
(585, 586, 23, '252610155', 0.00, '2025-08-24 21:11:47', '2025-08-24 21:11:47'),
(586, 587, 23, '252610156', 0.00, '2025-08-24 21:11:48', '2025-08-24 21:11:48'),
(587, 588, 23, '252610157', 0.00, '2025-08-24 21:11:48', '2025-08-24 21:11:48'),
(588, 589, 23, '252610158', 0.00, '2025-08-24 21:11:48', '2025-08-24 21:11:48'),
(589, 590, 24, '252610159', 0.00, '2025-08-24 21:11:48', '2025-08-24 21:11:48'),
(590, 591, 24, '252610160', 0.00, '2025-08-24 21:11:49', '2025-08-24 21:11:49'),
(591, 592, 24, '252610161', 0.00, '2025-08-24 21:11:49', '2025-08-24 21:11:49'),
(592, 593, 24, '252610162', 0.00, '2025-08-24 21:11:49', '2025-08-24 21:11:49'),
(593, 594, 24, '252610163', 0.00, '2025-08-24 21:11:49', '2025-08-24 21:11:49'),
(594, 595, 24, '252610164', 0.00, '2025-08-24 21:11:50', '2025-08-24 21:11:50'),
(595, 596, 24, '252610165', 0.00, '2025-08-24 21:11:50', '2025-08-24 21:11:50'),
(596, 597, 24, '252610166', 0.00, '2025-08-24 21:11:50', '2025-08-24 21:11:50'),
(597, 598, 24, '252610167', 0.00, '2025-08-24 21:11:51', '2025-08-24 21:11:51'),
(598, 599, 24, '252610168', 0.00, '2025-08-24 21:11:51', '2025-08-24 21:11:51'),
(599, 600, 24, '252610169', 0.00, '2025-08-24 21:11:51', '2025-08-24 21:11:51'),
(600, 601, 24, '252610170', 0.00, '2025-08-24 21:11:51', '2025-08-24 21:11:51'),
(601, 602, 24, '252610171', 0.00, '2025-08-24 21:11:52', '2025-08-24 21:11:52'),
(602, 603, 24, '252610172', 0.00, '2025-08-24 21:11:52', '2025-08-24 21:11:52'),
(603, 604, 24, '252610173', 0.00, '2025-08-24 21:11:52', '2025-08-24 21:11:52'),
(604, 605, 24, '252610174', 0.00, '2025-08-24 21:11:53', '2025-08-24 21:11:53'),
(605, 606, 24, '252610175', 0.00, '2025-08-24 21:11:53', '2025-08-24 21:11:53'),
(606, 607, 24, '252610176', 0.00, '2025-08-24 21:11:53', '2025-08-24 21:11:53'),
(607, 608, 24, '252610177', 0.00, '2025-08-24 21:11:53', '2025-08-24 21:11:53'),
(608, 609, 24, '252610178', 0.00, '2025-08-24 21:11:54', '2025-08-24 21:11:54'),
(609, 610, 24, '252610179', 0.00, '2025-08-24 21:11:54', '2025-08-24 21:11:54'),
(610, 611, 24, '252610180', 0.00, '2025-08-24 21:11:54', '2025-08-24 21:11:54'),
(611, 612, 24, '252610181', 0.00, '2025-08-24 21:11:54', '2025-08-24 21:11:54'),
(612, 613, 24, '252610182', 0.00, '2025-08-24 21:11:55', '2025-08-24 21:11:55'),
(613, 614, 24, '252610183', 0.00, '2025-08-24 21:11:55', '2025-08-24 21:11:55'),
(614, 615, 24, '252610184', 0.00, '2025-08-24 21:11:55', '2025-08-24 21:11:55'),
(615, 616, 24, '252610185', 0.00, '2025-08-24 21:11:56', '2025-08-24 21:11:56'),
(616, 617, 24, '252610186', 0.00, '2025-08-24 21:11:56', '2025-08-24 21:11:56'),
(617, 618, 24, '252610187', 0.00, '2025-08-24 21:11:56', '2025-08-24 21:11:56'),
(618, 619, 24, '252610188', 0.00, '2025-08-24 21:11:56', '2025-08-24 21:11:56'),
(619, 620, 24, '252610189', 0.00, '2025-08-24 21:11:57', '2025-08-24 21:11:57'),
(620, 621, 24, '252610190', 0.00, '2025-08-24 21:11:57', '2025-08-24 21:11:57'),
(621, 622, 24, '252610191', 0.00, '2025-08-24 21:11:57', '2025-08-24 21:11:57'),
(622, 623, 24, '252610192', 0.00, '2025-08-24 21:11:57', '2025-08-24 21:11:57'),
(623, 624, 25, '252610193', 0.00, '2025-08-24 21:11:58', '2025-08-24 21:11:58'),
(624, 625, 25, '252610194', 0.00, '2025-08-24 21:11:58', '2025-08-24 21:11:58'),
(625, 626, 25, '252610195', 0.00, '2025-08-24 21:11:58', '2025-08-24 21:11:58'),
(626, 627, 25, '252610196', 0.00, '2025-08-24 21:11:59', '2025-08-24 21:11:59'),
(627, 628, 25, '252610197', 0.00, '2025-08-24 21:11:59', '2025-08-24 21:11:59'),
(628, 629, 25, '252610198', 0.00, '2025-08-24 21:11:59', '2025-08-24 21:11:59'),
(629, 630, 25, '252610199', 0.00, '2025-08-24 21:11:59', '2025-08-24 21:11:59'),
(630, 631, 25, '252610200', 0.00, '2025-08-24 21:12:00', '2025-08-24 21:12:00'),
(631, 632, 25, '252610201', 0.00, '2025-08-24 21:12:00', '2025-08-24 21:12:00'),
(632, 633, 25, '252610202', 0.00, '2025-08-24 21:12:00', '2025-08-24 21:12:00'),
(633, 634, 25, '252610203', 0.00, '2025-08-24 21:12:01', '2025-08-24 21:12:01'),
(634, 635, 25, '252610204', 0.00, '2025-08-24 21:12:01', '2025-08-24 21:12:01'),
(635, 636, 25, '252610205', 0.00, '2025-08-24 21:12:01', '2025-08-24 21:12:01'),
(636, 637, 25, '252610206', 0.00, '2025-08-24 21:12:01', '2025-08-24 21:12:01'),
(637, 638, 25, '252610207', 0.00, '2025-08-24 21:12:02', '2025-08-24 21:12:02'),
(638, 639, 25, '252610208', 0.00, '2025-08-24 21:12:02', '2025-08-24 21:12:02'),
(639, 640, 25, '252610209', 0.00, '2025-08-24 21:12:02', '2025-08-24 21:12:02'),
(640, 641, 25, '252610210', 0.00, '2025-08-24 21:12:03', '2025-08-24 21:12:03'),
(641, 642, 25, '252610211', 0.00, '2025-08-24 21:12:03', '2025-08-24 21:12:03'),
(642, 643, 25, '252610212', 0.00, '2025-08-24 21:12:03', '2025-08-24 21:12:03'),
(643, 644, 25, '252610213', 0.00, '2025-08-24 21:12:03', '2025-08-24 21:12:03'),
(644, 645, 25, '252610214', 0.00, '2025-08-24 21:12:04', '2025-08-24 21:12:04'),
(645, 646, 25, '252610215', 0.00, '2025-08-24 21:12:04', '2025-08-24 21:12:04'),
(646, 647, 25, '252610216', 0.00, '2025-08-24 21:12:04', '2025-08-24 21:12:04'),
(647, 648, 25, '252610217', 0.00, '2025-08-24 21:12:04', '2025-08-24 21:12:04'),
(648, 649, 25, '252610218', 0.00, '2025-08-24 21:12:05', '2025-08-24 21:12:05'),
(649, 650, 25, '252610219', 0.00, '2025-08-24 21:12:05', '2025-08-24 21:12:05'),
(650, 651, 25, '252610220', 0.00, '2025-08-24 21:12:05', '2025-08-24 21:12:05'),
(651, 652, 25, '252610221', 0.00, '2025-08-24 21:12:06', '2025-08-24 21:12:06'),
(652, 653, 25, '252610222', 0.00, '2025-08-24 21:12:06', '2025-08-24 21:12:06'),
(653, 654, 25, '252610223', 0.00, '2025-08-24 21:12:06', '2025-08-24 21:12:06'),
(654, 655, 25, '252610224', 0.00, '2025-08-24 21:12:06', '2025-08-24 21:12:06'),
(655, 656, 25, '252610225', 0.00, '2025-08-24 21:12:07', '2025-08-24 21:12:07'),
(656, 657, 25, '252610226', 0.00, '2025-08-24 21:12:07', '2025-08-24 21:12:07'),
(657, 658, 25, '252610227', 0.00, '2025-08-24 21:12:07', '2025-08-24 21:12:07'),
(658, 659, 26, '252610228', 0.00, '2025-08-24 21:12:08', '2025-08-24 21:12:08'),
(659, 660, 26, '252610229', 0.00, '2025-08-24 21:12:08', '2025-08-24 21:12:08'),
(660, 661, 26, '252610230', 0.00, '2025-08-24 21:12:08', '2025-08-24 21:12:08'),
(661, 662, 26, '252610231', 0.00, '2025-08-24 21:12:08', '2025-08-24 21:12:08'),
(662, 663, 26, '252610232', 0.00, '2025-08-24 21:12:09', '2025-08-24 21:12:09'),
(663, 664, 26, '252610233', 0.00, '2025-08-24 21:12:09', '2025-08-24 21:12:09'),
(664, 665, 26, '252610234', 0.00, '2025-08-24 21:12:09', '2025-08-24 21:12:09'),
(665, 666, 26, '252610235', 0.00, '2025-08-24 21:12:10', '2025-08-24 21:12:10'),
(666, 667, 26, '252610236', 0.00, '2025-08-24 21:12:10', '2025-08-24 21:12:10'),
(667, 668, 26, '252610237', 0.00, '2025-08-24 21:12:10', '2025-08-24 21:12:10'),
(668, 669, 26, '252610238', 0.00, '2025-08-24 21:12:10', '2025-08-24 21:12:10'),
(669, 670, 26, '252610239', 0.00, '2025-08-24 21:12:11', '2025-08-24 21:12:11'),
(670, 671, 26, '252610240', 0.00, '2025-08-24 21:12:11', '2025-08-24 21:12:11'),
(671, 672, 26, '252610241', 0.00, '2025-08-24 21:12:11', '2025-08-24 21:12:11'),
(672, 673, 26, '252610242', 0.00, '2025-08-24 21:12:11', '2025-08-24 21:12:11'),
(673, 674, 26, '252610243', 0.00, '2025-08-24 21:12:12', '2025-08-24 21:12:12'),
(674, 675, 26, '252610244', 0.00, '2025-08-24 21:12:12', '2025-08-24 21:12:12'),
(675, 676, 26, '252610245', 0.00, '2025-08-24 21:12:12', '2025-08-24 21:12:12'),
(676, 677, 26, '252610246', 0.00, '2025-08-24 21:12:13', '2025-08-24 21:12:13'),
(677, 678, 26, '252610247', 0.00, '2025-08-24 21:12:13', '2025-08-24 21:12:13'),
(678, 679, 26, '252610248', 0.00, '2025-08-24 21:12:13', '2025-08-24 21:12:13'),
(679, 680, 26, '252610249', 0.00, '2025-08-24 21:12:13', '2025-08-24 21:12:13'),
(680, 681, 26, '252610250', 0.00, '2025-08-24 21:12:14', '2025-08-24 21:12:14'),
(681, 682, 26, '252610251', 0.00, '2025-08-24 21:12:14', '2025-08-24 21:12:14'),
(682, 683, 26, '252610252', 0.00, '2025-08-24 21:12:14', '2025-08-24 21:12:14'),
(683, 684, 26, '252610253', 0.00, '2025-08-24 21:12:15', '2025-08-24 21:12:15'),
(684, 685, 26, '252610254', 0.00, '2025-08-24 21:12:15', '2025-08-24 21:12:15'),
(685, 686, 26, '252610255', 0.00, '2025-08-24 21:12:15', '2025-08-24 21:12:15'),
(686, 687, 26, '252610256', 0.00, '2025-08-24 21:12:15', '2025-08-24 21:12:15'),
(687, 688, 26, '252610257', 0.00, '2025-08-24 21:12:16', '2025-08-24 21:12:16'),
(688, 689, 26, '252610258', 0.00, '2025-08-24 21:12:16', '2025-08-24 21:12:16'),
(689, 690, 26, '252610259', 0.00, '2025-08-24 21:12:16', '2025-08-24 21:12:16'),
(690, 691, 26, '252610260', 0.00, '2025-08-24 21:12:16', '2025-08-24 21:12:16'),
(691, 692, 26, '252610261', 0.00, '2025-08-24 21:12:17', '2025-08-24 21:12:17'),
(692, 693, 26, '252610262', 0.00, '2025-08-24 21:12:17', '2025-08-24 21:12:17'),
(693, 694, 10, '242510001', 0.00, '2025-08-24 21:23:29', '2025-08-24 21:23:29'),
(694, 695, 10, '242510002', 0.00, '2025-08-24 21:23:30', '2025-08-24 21:23:30'),
(695, 696, 10, '242510003', 0.00, '2025-08-24 21:23:30', '2025-08-24 21:23:30'),
(696, 697, 10, '242510004', 0.00, '2025-08-24 21:23:30', '2025-08-24 21:23:30'),
(697, 698, 10, '242510005', 0.00, '2025-08-24 21:23:30', '2025-08-24 21:23:30'),
(698, 699, 10, '242510006', 0.00, '2025-08-24 21:23:31', '2025-08-24 21:23:31'),
(699, 700, 10, '242510007', 0.00, '2025-08-24 21:23:31', '2025-08-24 21:23:31'),
(700, 701, 10, '242510008', 0.00, '2025-08-24 21:23:31', '2025-08-24 21:23:31'),
(701, 702, 10, '242510009', 0.00, '2025-08-24 21:23:31', '2025-08-24 21:23:31'),
(702, 703, 10, '242510010', 0.00, '2025-08-24 21:23:32', '2025-08-24 21:23:32'),
(703, 704, 10, '242510011', 0.00, '2025-08-24 21:23:32', '2025-08-24 21:23:32'),
(704, 705, 10, '242510012', 0.00, '2025-08-24 21:23:32', '2025-08-24 21:23:32'),
(705, 706, 10, '242510013', 0.00, '2025-08-24 21:23:32', '2025-08-24 21:23:32'),
(706, 707, 10, '242510014', 0.00, '2025-08-24 21:23:33', '2025-08-24 21:23:33'),
(707, 708, 10, '242510015', 0.00, '2025-08-24 21:23:33', '2025-08-24 21:23:33'),
(708, 709, 10, '242510016', 0.00, '2025-08-24 21:23:33', '2025-08-24 21:23:33'),
(709, 710, 10, '242510017', 0.00, '2025-08-24 21:23:33', '2025-08-24 21:23:33'),
(710, 711, 10, '242510018', 0.00, '2025-08-24 21:23:34', '2025-08-24 21:23:34'),
(711, 712, 10, '242510019', 0.00, '2025-08-24 21:23:34', '2025-08-24 21:23:34'),
(712, 713, 10, '242510020', 0.00, '2025-08-24 21:23:34', '2025-08-24 21:23:34'),
(713, 714, 10, '242510021', 0.00, '2025-08-24 21:23:35', '2025-08-24 21:23:35'),
(714, 715, 10, '242510022', 0.00, '2025-08-24 21:23:35', '2025-08-24 21:23:35'),
(715, 716, 10, '242510023', 0.00, '2025-08-24 21:23:35', '2025-08-24 21:23:35'),
(716, 717, 10, '242510024', 0.00, '2025-08-24 21:23:35', '2025-08-24 21:23:35'),
(717, 718, 10, '242510025', 0.00, '2025-08-24 21:23:36', '2025-08-24 21:23:36'),
(718, 719, 10, '242510026', 0.00, '2025-08-24 21:23:36', '2025-08-24 21:23:36'),
(719, 720, 10, '242510027', 0.00, '2025-08-24 21:23:36', '2025-08-24 21:23:36'),
(720, 721, 10, '242510028', 0.00, '2025-08-24 21:23:36', '2025-08-24 21:23:36'),
(721, 722, 10, '242510029', 0.00, '2025-08-24 21:23:37', '2025-08-24 21:23:37'),
(722, 723, 10, '242510030', 0.00, '2025-08-24 21:23:37', '2025-08-24 21:23:37'),
(723, 724, 10, '242510031', 0.00, '2025-08-24 21:23:37', '2025-08-24 21:23:37'),
(724, 725, 10, '242510032', 0.00, '2025-08-24 21:23:37', '2025-08-24 21:23:37'),
(725, 726, 10, '242510033', 0.00, '2025-08-24 21:23:38', '2025-08-24 21:23:38'),
(726, 727, 11, '242510034', 0.00, '2025-08-24 21:23:38', '2025-08-24 21:23:38'),
(727, 728, 11, '242510035', 0.00, '2025-08-24 21:23:38', '2025-08-24 21:23:38'),
(728, 729, 11, '242510036', 0.00, '2025-08-24 21:23:38', '2025-08-24 21:23:38'),
(729, 730, 11, '242510037', 0.00, '2025-08-24 21:23:39', '2025-08-24 21:23:39'),
(730, 731, 11, '242510038', 0.00, '2025-08-24 21:23:39', '2025-08-24 21:23:39'),
(731, 732, 11, '242510039', 0.00, '2025-08-24 21:23:39', '2025-08-24 21:23:39'),
(732, 733, 11, '242510040', 0.00, '2025-08-24 21:23:39', '2025-08-24 21:23:39'),
(733, 734, 11, '242510041', 0.00, '2025-08-24 21:23:40', '2025-08-24 21:23:40'),
(734, 735, 11, '242510042', 0.00, '2025-08-24 21:23:40', '2025-08-24 21:23:40'),
(735, 736, 11, '242510043', 0.00, '2025-08-24 21:23:40', '2025-08-24 21:23:40'),
(736, 737, 11, '242510044', 0.00, '2025-08-24 21:23:40', '2025-08-24 21:23:40'),
(737, 738, 11, '242510045', 0.00, '2025-08-24 21:23:41', '2025-08-24 21:23:41'),
(738, 739, 11, '242510046', 0.00, '2025-08-24 21:23:41', '2025-08-24 21:23:41'),
(739, 740, 11, '242510047', 0.00, '2025-08-24 21:23:41', '2025-08-24 21:23:41'),
(740, 741, 11, '242510048', 0.00, '2025-08-24 21:23:41', '2025-08-24 21:23:41'),
(741, 742, 11, '242510049', 0.00, '2025-08-24 21:23:42', '2025-08-24 21:23:42'),
(742, 743, 11, '242510050', 0.00, '2025-08-24 21:23:42', '2025-08-24 21:23:42'),
(743, 744, 11, '242510051', 0.00, '2025-08-24 21:23:42', '2025-08-24 21:23:42'),
(744, 745, 11, '242510052', 0.00, '2025-08-24 21:23:42', '2025-08-24 21:23:42'),
(745, 746, 11, '242510053', 0.00, '2025-08-24 21:23:43', '2025-08-24 21:23:43'),
(746, 747, 11, '242510054', 0.00, '2025-08-24 21:23:43', '2025-08-24 21:23:43'),
(747, 748, 11, '242510055', 0.00, '2025-08-24 21:23:43', '2025-08-24 21:23:43'),
(748, 749, 11, '242510056', 0.00, '2025-08-24 21:23:44', '2025-08-24 21:23:44'),
(749, 750, 11, '242510057', 0.00, '2025-08-24 21:23:44', '2025-08-24 21:23:44'),
(750, 751, 11, '242510058', 0.00, '2025-08-24 21:23:44', '2025-08-24 21:23:44'),
(751, 752, 11, '242510059', 0.00, '2025-08-24 21:23:44', '2025-08-24 21:23:44'),
(752, 753, 11, '242510060', 0.00, '2025-08-24 21:23:45', '2025-08-24 21:23:45'),
(753, 754, 11, '242510061', 0.00, '2025-08-24 21:23:45', '2025-08-24 21:23:45'),
(754, 755, 11, '242510062', 0.00, '2025-08-24 21:23:45', '2025-08-24 21:23:45'),
(755, 756, 11, '242510063', 0.00, '2025-08-24 21:23:45', '2025-08-24 21:23:45'),
(756, 757, 11, '242510064', 0.00, '2025-08-24 21:23:46', '2025-08-24 21:23:46'),
(757, 758, 12, '242510065', 0.00, '2025-08-24 21:23:46', '2025-08-24 21:23:46'),
(758, 759, 12, '242510066', 0.00, '2025-08-24 21:23:46', '2025-08-24 21:23:46'),
(759, 760, 12, '242510067', 0.00, '2025-08-24 21:23:46', '2025-08-24 21:23:46'),
(760, 761, 12, '242510068', 0.00, '2025-08-24 21:23:47', '2025-08-24 21:23:47'),
(761, 762, 12, '242510069', 0.00, '2025-08-24 21:23:47', '2025-08-24 21:23:47'),
(762, 763, 12, '242510070', 0.00, '2025-08-24 21:23:47', '2025-08-24 21:23:47'),
(763, 764, 12, '242510071', 0.00, '2025-08-24 21:23:47', '2025-08-24 21:23:47'),
(764, 765, 12, '242510072', 0.00, '2025-08-24 21:23:48', '2025-08-24 21:23:48'),
(765, 766, 12, '242510073', 0.00, '2025-08-24 21:23:48', '2025-08-24 21:23:48'),
(766, 767, 12, '242510074', 0.00, '2025-08-24 21:23:48', '2025-08-24 21:23:48'),
(767, 768, 12, '242510075', 0.00, '2025-08-24 21:23:48', '2025-08-24 21:23:48'),
(768, 769, 12, '242510076', 0.00, '2025-08-24 21:23:49', '2025-08-24 21:23:49'),
(769, 770, 12, '242510077', 0.00, '2025-08-24 21:23:49', '2025-08-24 21:23:49'),
(770, 771, 12, '242510078', 0.00, '2025-08-24 21:23:49', '2025-08-24 21:23:49'),
(771, 772, 12, '242510079', 0.00, '2025-08-24 21:23:49', '2025-08-24 21:23:49'),
(772, 773, 12, '242510080', 0.00, '2025-08-24 21:23:50', '2025-08-24 21:23:50'),
(773, 774, 12, '242510081', 0.00, '2025-08-24 21:23:50', '2025-08-24 21:23:50'),
(774, 775, 12, '242510082', 0.00, '2025-08-24 21:23:50', '2025-08-24 21:23:50'),
(775, 776, 12, '242510083', 0.00, '2025-08-24 21:23:50', '2025-08-24 21:23:50'),
(776, 777, 12, '242510084', 0.00, '2025-08-24 21:23:51', '2025-08-24 21:23:51'),
(777, 778, 12, '242510085', 0.00, '2025-08-24 21:23:51', '2025-08-24 21:23:51'),
(778, 779, 12, '242510086', 0.00, '2025-08-24 21:23:51', '2025-08-24 21:23:51'),
(779, 780, 12, '242510087', 0.00, '2025-08-24 21:23:51', '2025-08-24 21:23:51'),
(780, 781, 12, '242510088', 0.00, '2025-08-24 21:23:52', '2025-08-24 21:23:52'),
(781, 782, 12, '242510089', 0.00, '2025-08-24 21:23:52', '2025-08-24 21:23:52'),
(782, 783, 12, '242510090', 0.00, '2025-08-24 21:23:52', '2025-08-24 21:23:52'),
(783, 784, 12, '242510091', 0.00, '2025-08-24 21:23:53', '2025-08-24 21:23:53'),
(784, 785, 12, '242510092', 0.00, '2025-08-24 21:23:53', '2025-08-24 21:23:53'),
(785, 786, 12, '242510093', 0.00, '2025-08-24 21:23:53', '2025-08-24 21:23:53'),
(786, 787, 12, '242510094', 0.00, '2025-08-24 21:23:53', '2025-08-24 21:23:53'),
(787, 788, 12, '242510095', 0.00, '2025-08-24 21:23:54', '2025-08-24 21:23:54'),
(788, 789, 12, '242510096', 0.00, '2025-08-24 21:23:54', '2025-08-24 21:23:54'),
(789, 790, 13, '242510097', 0.00, '2025-08-24 21:23:54', '2025-08-24 21:23:54'),
(790, 791, 13, '242510098', 0.00, '2025-08-24 21:23:54', '2025-08-24 21:23:54'),
(791, 792, 13, '242510099', 0.00, '2025-08-24 21:23:55', '2025-08-24 21:23:55'),
(792, 793, 13, '242510100', 0.00, '2025-08-24 21:23:55', '2025-08-24 21:23:55'),
(793, 794, 13, '242510101', 0.00, '2025-08-24 21:23:55', '2025-08-24 21:23:55'),
(794, 795, 13, '242510102', 0.00, '2025-08-24 21:23:55', '2025-08-24 21:23:55'),
(795, 796, 13, '242510103', 0.00, '2025-08-24 21:23:56', '2025-08-24 21:23:56'),
(796, 797, 13, '242510104', 0.00, '2025-08-24 21:23:56', '2025-08-24 21:23:56'),
(797, 798, 13, '242510105', 0.00, '2025-08-24 21:23:56', '2025-08-24 21:23:56'),
(798, 799, 13, '242510106', 0.00, '2025-08-24 21:23:56', '2025-08-24 21:23:56'),
(799, 800, 13, '242510107', 0.00, '2025-08-24 21:23:57', '2025-08-24 21:23:57'),
(800, 801, 13, '242510108', 0.00, '2025-08-24 21:23:57', '2025-08-24 21:23:57'),
(801, 802, 13, '242510109', 0.00, '2025-08-24 21:23:57', '2025-08-24 21:23:57'),
(802, 803, 13, '242510110', 0.00, '2025-08-24 21:23:57', '2025-08-24 21:23:57'),
(803, 804, 13, '242510111', 0.00, '2025-08-24 21:23:58', '2025-08-24 21:23:58'),
(804, 805, 13, '242510112', 0.00, '2025-08-24 21:23:58', '2025-08-24 21:23:58'),
(805, 806, 13, '242510113', 0.00, '2025-08-24 21:23:58', '2025-08-24 21:23:58'),
(806, 807, 13, '242510114', 0.00, '2025-08-24 21:23:58', '2025-08-24 21:23:58'),
(807, 808, 13, '242510115', 0.00, '2025-08-24 21:23:59', '2025-08-24 21:23:59'),
(808, 809, 13, '242510116', 0.00, '2025-08-24 21:23:59', '2025-08-24 21:23:59'),
(809, 810, 13, '242510117', 0.00, '2025-08-24 21:23:59', '2025-08-24 21:23:59'),
(810, 811, 13, '242510118', 0.00, '2025-08-24 21:24:00', '2025-08-24 21:24:00'),
(811, 812, 13, '242510119', 0.00, '2025-08-24 21:24:00', '2025-08-24 21:24:00'),
(812, 813, 13, '242510120', 0.00, '2025-08-24 21:24:00', '2025-08-24 21:24:00'),
(813, 814, 13, '242510121', 0.00, '2025-08-24 21:24:00', '2025-08-24 21:24:00'),
(814, 815, 13, '242510122', 0.00, '2025-08-24 21:24:01', '2025-08-24 21:24:01'),
(815, 816, 13, '242510123', 0.00, '2025-08-24 21:24:01', '2025-08-24 21:24:01'),
(816, 817, 13, '242510124', 0.00, '2025-08-24 21:24:01', '2025-08-24 21:24:01'),
(817, 818, 14, '242510125', 0.00, '2025-08-24 21:24:01', '2025-08-24 21:24:01'),
(818, 819, 14, '242510126', 0.00, '2025-08-24 21:24:02', '2025-08-24 21:24:02'),
(819, 820, 14, '242510127', 0.00, '2025-08-24 21:24:02', '2025-08-24 21:24:02'),
(820, 821, 14, '242510128', 0.00, '2025-08-24 21:24:02', '2025-08-24 21:24:02'),
(821, 822, 14, '242510129', 0.00, '2025-08-24 21:24:02', '2025-08-24 21:24:02'),
(822, 823, 14, '242510130', 0.00, '2025-08-24 21:24:03', '2025-08-24 21:24:03'),
(823, 824, 14, '242510131', 0.00, '2025-08-24 21:24:03', '2025-08-24 21:24:03'),
(824, 825, 14, '242510132', 0.00, '2025-08-24 21:24:03', '2025-08-24 21:24:03'),
(825, 826, 14, '242510133', 0.00, '2025-08-24 21:24:03', '2025-08-24 21:24:03'),
(826, 827, 14, '242510134', 0.00, '2025-08-24 21:24:04', '2025-08-24 21:24:04'),
(827, 828, 14, '242510135', 0.00, '2025-08-24 21:24:04', '2025-08-24 21:24:04'),
(828, 829, 14, '242510136', 0.00, '2025-08-24 21:24:04', '2025-08-24 21:24:04'),
(829, 830, 14, '242510137', 0.00, '2025-08-24 21:24:04', '2025-08-24 21:24:04'),
(830, 831, 14, '242510138', 0.00, '2025-08-24 21:24:05', '2025-08-24 21:24:05'),
(831, 832, 14, '242510139', 0.00, '2025-08-24 21:24:05', '2025-08-24 21:24:05'),
(832, 833, 14, '242510140', 0.00, '2025-08-24 21:24:05', '2025-08-24 21:24:05'),
(833, 834, 14, '242510141', 0.00, '2025-08-24 21:24:05', '2025-08-24 21:24:05'),
(834, 835, 14, '242510142', 0.00, '2025-08-24 21:24:06', '2025-08-24 21:24:06'),
(835, 836, 14, '242510143', 0.00, '2025-08-24 21:24:06', '2025-08-24 21:24:06'),
(836, 837, 14, '242510144', 0.00, '2025-08-24 21:24:06', '2025-08-24 21:24:06'),
(837, 838, 14, '242510145', 0.00, '2025-08-24 21:24:07', '2025-08-24 21:24:07'),
(838, 839, 14, '242510146', 0.00, '2025-08-24 21:24:07', '2025-08-24 21:24:07'),
(839, 840, 14, '242510147', 0.00, '2025-08-24 21:24:07', '2025-08-24 21:24:07'),
(840, 841, 14, '242510148', 0.00, '2025-08-24 21:24:07', '2025-08-24 21:24:07'),
(841, 842, 14, '242510149', 0.00, '2025-08-24 21:24:08', '2025-08-24 21:24:08'),
(842, 843, 14, '242510150', 0.00, '2025-08-24 21:24:08', '2025-08-24 21:24:08'),
(843, 844, 14, '242510151', 0.00, '2025-08-24 21:24:08', '2025-08-24 21:24:08'),
(844, 845, 14, '242510152', 0.00, '2025-08-24 21:24:08', '2025-08-24 21:24:08'),
(845, 846, 15, '242510153', 0.00, '2025-08-24 21:24:09', '2025-08-24 21:24:09'),
(846, 847, 15, '242510154', 0.00, '2025-08-24 21:24:09', '2025-08-24 21:24:09'),
(847, 848, 15, '242510155', 0.00, '2025-08-24 21:24:09', '2025-08-24 21:24:09'),
(848, 849, 15, '242510156', 0.00, '2025-08-24 21:24:09', '2025-08-24 21:24:09'),
(849, 850, 15, '242510157', 0.00, '2025-08-24 21:24:10', '2025-08-24 21:24:10'),
(850, 851, 15, '242510158', 0.00, '2025-08-24 21:24:10', '2025-08-24 21:24:10'),
(851, 852, 15, '242510159', 0.00, '2025-08-24 21:24:10', '2025-08-24 21:24:10'),
(852, 853, 15, '242510160', 0.00, '2025-08-24 21:24:10', '2025-08-24 21:24:10'),
(853, 854, 15, '242510161', 0.00, '2025-08-24 21:24:11', '2025-08-24 21:24:11'),
(854, 855, 15, '242510162', 0.00, '2025-08-24 21:24:11', '2025-08-24 21:24:11'),
(855, 856, 15, '242510163', 0.00, '2025-08-24 21:24:11', '2025-08-24 21:24:11'),
(856, 857, 15, '242510164', 0.00, '2025-08-24 21:24:12', '2025-08-24 21:24:12'),
(857, 858, 15, '242510165', 0.00, '2025-08-24 21:24:12', '2025-08-24 21:24:12'),
(858, 859, 15, '242510166', 0.00, '2025-08-24 21:24:12', '2025-08-24 21:24:12'),
(859, 860, 15, '242510167', 0.00, '2025-08-24 21:24:12', '2025-08-24 21:24:12'),
(860, 861, 15, '242510168', 0.00, '2025-08-24 21:24:13', '2025-08-24 21:24:13'),
(861, 862, 15, '242510169', 0.00, '2025-08-24 21:24:13', '2025-08-24 21:24:13'),
(862, 863, 15, '242510170', 0.00, '2025-08-24 21:24:13', '2025-08-24 21:24:13'),
(863, 864, 15, '242510171', 0.00, '2025-08-24 21:24:13', '2025-08-24 21:24:13'),
(864, 865, 15, '242510172', 0.00, '2025-08-24 21:24:14', '2025-08-24 21:24:14'),
(865, 866, 15, '242510173', 0.00, '2025-08-24 21:24:14', '2025-08-24 21:24:14'),
(866, 867, 15, '242510174', 0.00, '2025-08-24 21:24:14', '2025-08-24 21:24:14'),
(867, 868, 15, '242510175', 0.00, '2025-08-24 21:24:15', '2025-08-24 21:24:15'),
(868, 869, 15, '242510176', 0.00, '2025-08-24 21:24:15', '2025-08-24 21:24:15'),
(869, 870, 15, '242510177', 0.00, '2025-08-24 21:24:15', '2025-08-24 21:24:15'),
(870, 871, 15, '242510178', 0.00, '2025-08-24 21:24:15', '2025-08-24 21:24:15'),
(871, 872, 16, '242510179', 0.00, '2025-08-24 21:24:16', '2025-08-24 21:24:16'),
(872, 873, 16, '242510180', 0.00, '2025-08-24 21:24:16', '2025-08-24 21:24:16'),
(873, 874, 16, '242510181', 0.00, '2025-08-24 21:24:16', '2025-08-24 21:24:16'),
(874, 875, 16, '242510182', 0.00, '2025-08-24 21:24:16', '2025-08-24 21:24:16'),
(875, 876, 16, '242510183', 0.00, '2025-08-24 21:24:17', '2025-08-24 21:24:17'),
(876, 877, 16, '242510184', 0.00, '2025-08-24 21:24:17', '2025-08-24 21:24:17'),
(877, 878, 16, '242510185', 0.00, '2025-08-24 21:24:17', '2025-08-24 21:24:17'),
(878, 879, 16, '242510186', 0.00, '2025-08-24 21:24:17', '2025-08-24 21:24:17'),
(879, 880, 16, '242510187', 0.00, '2025-08-24 21:24:18', '2025-08-24 21:24:18'),
(880, 881, 16, '242510188', 0.00, '2025-08-24 21:24:18', '2025-08-24 21:24:18'),
(881, 882, 16, '242510189', 0.00, '2025-08-24 21:24:18', '2025-08-24 21:24:18'),
(882, 883, 16, '242510190', 0.00, '2025-08-24 21:24:19', '2025-08-24 21:24:19'),
(883, 884, 16, '242510191', 0.00, '2025-08-24 21:24:19', '2025-08-24 21:24:19'),
(884, 885, 16, '242510192', 0.00, '2025-08-24 21:24:19', '2025-08-24 21:24:19'),
(885, 886, 16, '242510193', 0.00, '2025-08-24 21:24:19', '2025-08-24 21:24:19'),
(886, 887, 16, '242510194', 0.00, '2025-08-24 21:24:20', '2025-08-24 21:24:20'),
(887, 888, 16, '242510195', 0.00, '2025-08-24 21:24:20', '2025-08-24 21:24:20'),
(888, 889, 16, '242510196', 0.00, '2025-08-24 21:24:20', '2025-08-24 21:24:20'),
(889, 890, 16, '242510197', 0.00, '2025-08-24 21:24:20', '2025-08-24 21:24:20'),
(890, 891, 16, '242510198', 0.00, '2025-08-24 21:24:21', '2025-08-24 21:24:21'),
(891, 892, 16, '242510199', 0.00, '2025-08-24 21:24:21', '2025-08-24 21:24:21'),
(892, 893, 16, '242510200', 0.00, '2025-08-24 21:24:21', '2025-08-24 21:24:21'),
(893, 894, 16, '242510201', 0.00, '2025-08-24 21:24:22', '2025-08-24 21:24:22'),
(894, 895, 16, '242510202', 0.00, '2025-08-24 21:24:22', '2025-08-24 21:24:22'),
(895, 896, 16, '242510203', 0.00, '2025-08-24 21:24:22', '2025-08-24 21:24:22'),
(896, 897, 16, '242510204', 0.00, '2025-08-24 21:24:22', '2025-08-24 21:24:22'),
(897, 898, 16, '242510205', 0.00, '2025-08-24 21:24:23', '2025-08-24 21:24:23'),
(898, 899, 16, '242510206', 0.00, '2025-08-24 21:24:23', '2025-08-24 21:24:23'),
(899, 900, 16, '242510207', 0.00, '2025-08-24 21:24:23', '2025-08-24 21:24:23'),
(900, 901, 16, '242510208', 0.00, '2025-08-24 21:24:23', '2025-08-24 21:24:23'),
(901, 902, 16, '242510209', 0.00, '2025-08-24 21:24:24', '2025-08-24 21:24:24'),
(902, 903, 16, '242510210', 0.00, '2025-08-24 21:24:24', '2025-08-24 21:24:24'),
(903, 904, 17, '242510211', 0.00, '2025-08-24 21:24:24', '2025-08-24 21:24:24'),
(904, 905, 17, '242510212', 0.00, '2025-08-24 21:24:24', '2025-08-24 21:24:24'),
(905, 906, 17, '242510213', 0.00, '2025-08-24 21:24:25', '2025-08-24 21:24:25'),
(906, 907, 17, '242510214', 0.00, '2025-08-24 21:24:25', '2025-08-24 21:24:25'),
(907, 908, 17, '242510215', 0.00, '2025-08-24 21:24:25', '2025-08-24 21:24:25'),
(908, 909, 17, '242510216', 0.00, '2025-08-24 21:24:26', '2025-08-24 21:24:26'),
(909, 910, 17, '242510217', 0.00, '2025-08-24 21:24:26', '2025-08-24 21:24:26'),
(910, 911, 17, '242510218', 0.00, '2025-08-24 21:24:26', '2025-08-24 21:24:26'),
(911, 912, 17, '242510219', 0.00, '2025-08-24 21:24:26', '2025-08-24 21:24:26'),
(912, 913, 17, '242510220', 0.00, '2025-08-24 21:24:27', '2025-08-24 21:24:27'),
(913, 914, 17, '242510221', 0.00, '2025-08-24 21:24:27', '2025-08-24 21:24:27'),
(914, 915, 17, '242510222', 0.00, '2025-08-24 21:24:27', '2025-08-24 21:24:27'),
(915, 916, 17, '242510223', 0.00, '2025-08-24 21:24:27', '2025-08-24 21:24:27'),
(916, 917, 17, '242510224', 0.00, '2025-08-24 21:24:28', '2025-08-24 21:24:28'),
(917, 918, 17, '242510225', 0.00, '2025-08-24 21:24:28', '2025-08-24 21:24:28'),
(918, 919, 17, '242510226', 0.00, '2025-08-24 21:24:28', '2025-08-24 21:24:28'),
(919, 920, 17, '242510227', 0.00, '2025-08-24 21:24:28', '2025-08-24 21:24:28'),
(920, 921, 17, '242510228', 0.00, '2025-08-24 21:24:29', '2025-08-24 21:24:29'),
(921, 922, 17, '242510229', 0.00, '2025-08-24 21:24:29', '2025-08-24 21:24:29'),
(922, 923, 17, '242510230', 0.00, '2025-08-24 21:24:29', '2025-08-24 21:24:29'),
(923, 924, 17, '242510231', 0.00, '2025-08-24 21:24:30', '2025-08-24 21:24:30'),
(924, 925, 17, '242510232', 0.00, '2025-08-24 21:24:30', '2025-08-24 21:24:30'),
(925, 926, 17, '242510233', 0.00, '2025-08-24 21:24:30', '2025-08-24 21:24:30'),
(926, 927, 17, '242510234', 0.00, '2025-08-24 21:24:30', '2025-08-24 21:24:30'),
(927, 928, 17, '242510235', 0.00, '2025-08-24 21:24:31', '2025-08-24 21:24:31'),
(928, 929, 17, '242510236', 0.00, '2025-08-24 21:24:31', '2025-08-24 21:24:31'),
(929, 930, 18, '242510237', 0.00, '2025-08-24 21:24:31', '2025-08-24 21:24:31'),
(930, 931, 18, '242510238', 0.00, '2025-08-24 21:24:31', '2025-08-24 21:24:31'),
(931, 932, 18, '242510239', 0.00, '2025-08-24 21:24:32', '2025-08-24 21:24:32'),
(932, 933, 18, '242510240', 0.00, '2025-08-24 21:24:32', '2025-08-24 21:24:32'),
(933, 934, 18, '242510241', 0.00, '2025-08-24 21:24:32', '2025-08-24 21:24:32'),
(934, 935, 18, '242510242', 0.00, '2025-08-24 21:24:32', '2025-08-24 21:24:32'),
(935, 936, 18, '242510243', 0.00, '2025-08-24 21:24:33', '2025-08-24 21:24:33'),
(936, 937, 18, '242510244', 0.00, '2025-08-24 21:24:33', '2025-08-24 21:24:33'),
(937, 938, 18, '242510245', 0.00, '2025-08-24 21:24:33', '2025-08-24 21:24:33'),
(938, 939, 18, '242510246', 0.00, '2025-08-24 21:24:34', '2025-08-24 21:24:34'),
(939, 940, 18, '242510247', 0.00, '2025-08-24 21:24:34', '2025-08-24 21:24:34'),
(940, 941, 18, '242510248', 0.00, '2025-08-24 21:24:34', '2025-08-24 21:24:34'),
(941, 942, 18, '242510249', 0.00, '2025-08-24 21:24:34', '2025-08-24 21:24:34'),
(942, 943, 18, '242510250', 0.00, '2025-08-24 21:24:35', '2025-08-24 21:24:35'),
(943, 944, 18, '242510251', 0.00, '2025-08-24 21:24:35', '2025-08-24 21:24:35'),
(944, 945, 18, '242510252', 0.00, '2025-08-24 21:24:35', '2025-08-24 21:24:35'),
(945, 946, 18, '242510253', 0.00, '2025-08-24 21:24:35', '2025-08-24 21:24:35'),
(946, 947, 18, '242510254', 0.00, '2025-08-24 21:24:36', '2025-08-24 21:24:36'),
(947, 948, 18, '242510255', 0.00, '2025-08-24 21:24:36', '2025-08-24 21:24:36'),
(948, 949, 18, '242510256', 0.00, '2025-08-24 21:24:36', '2025-08-24 21:24:36'),
(949, 950, 18, '242510257', 0.00, '2025-08-24 21:24:36', '2025-08-24 21:24:36'),
(950, 951, 18, '242510258', 0.00, '2025-08-24 21:24:37', '2025-08-24 21:24:37'),
(951, 952, 18, '242510259', 0.00, '2025-08-24 21:24:37', '2025-08-24 21:24:37'),
(952, 953, 18, '242510260', 0.00, '2025-08-24 21:24:37', '2025-08-24 21:24:37'),
(953, 954, 18, '242510261', 0.00, '2025-08-24 21:24:37', '2025-08-24 21:24:37'),
(954, 955, 18, '242510262', 0.00, '2025-08-24 21:24:38', '2025-08-24 21:24:38'),
(955, 956, 18, '242510263', 0.00, '2025-08-24 21:24:38', '2025-08-24 21:24:38'),
(956, 957, 18, '242510264', 0.00, '2025-08-24 21:24:38', '2025-08-24 21:24:38'),
(957, 958, 1, '232410001', 2000.00, '2025-08-24 21:47:44', '2025-08-25 02:19:20'),
(958, 959, 1, '232410002', 0.00, '2025-08-24 21:47:45', '2025-08-24 21:47:45'),
(959, 960, 1, '232410003', 0.00, '2025-08-24 21:47:45', '2025-08-24 21:47:45'),
(960, 961, 1, '232410004', 0.00, '2025-08-24 21:47:45', '2025-08-24 21:47:45'),
(961, 962, 1, '232410005', 0.00, '2025-08-24 21:47:45', '2025-08-24 21:47:45'),
(962, 963, 1, '232410006', 0.00, '2025-08-24 21:47:46', '2025-08-24 21:47:46'),
(963, 964, 1, '232410007', 0.00, '2025-08-24 21:47:46', '2025-08-24 21:47:46'),
(964, 965, 1, '232410008', 0.00, '2025-08-24 21:47:46', '2025-08-24 21:47:46'),
(965, 966, 1, '232410009', 0.00, '2025-08-24 21:47:46', '2025-08-24 21:47:46'),
(966, 967, 1, '232410010', 0.00, '2025-08-24 21:47:47', '2025-08-24 21:47:47'),
(967, 968, 1, '232410011', 0.00, '2025-08-24 21:47:47', '2025-08-24 21:47:47'),
(968, 969, 1, '232410012', 0.00, '2025-08-24 21:47:47', '2025-08-24 21:47:47'),
(969, 970, 1, '232410013', 0.00, '2025-08-24 21:47:47', '2025-08-24 21:47:47'),
(970, 971, 1, '232410014', 0.00, '2025-08-24 21:47:48', '2025-08-24 21:47:48'),
(971, 972, 1, '232410015', 0.00, '2025-08-24 21:47:48', '2025-08-24 21:47:48'),
(972, 973, 1, '232410016', 0.00, '2025-08-24 21:47:48', '2025-08-24 21:47:48'),
(973, 974, 1, '232410017', 0.00, '2025-08-24 21:47:48', '2025-08-24 21:47:48'),
(974, 975, 1, '232410018', 0.00, '2025-08-24 21:47:49', '2025-08-24 21:47:49'),
(975, 976, 1, '232410019', 0.00, '2025-08-24 21:47:49', '2025-08-24 21:47:49'),
(976, 977, 1, '232410020', 0.00, '2025-08-24 21:47:49', '2025-08-24 21:47:49'),
(977, 978, 1, '232410021', 0.00, '2025-08-24 21:47:50', '2025-08-24 21:47:50'),
(978, 979, 1, '232410022', 0.00, '2025-08-24 21:47:50', '2025-08-24 21:47:50'),
(979, 980, 1, '232410023', 0.00, '2025-08-24 21:47:50', '2025-08-24 21:47:50'),
(980, 981, 1, '232410024', 0.00, '2025-08-24 21:47:50', '2025-08-24 21:47:50'),
(981, 982, 1, '232410025', 0.00, '2025-08-24 21:47:51', '2025-08-24 21:47:51'),
(982, 983, 1, '232410026', 0.00, '2025-08-24 21:47:51', '2025-08-24 21:47:51'),
(983, 984, 2, '232410027', 0.00, '2025-08-24 21:47:51', '2025-08-24 21:47:51'),
(984, 985, 2, '232410028', 0.00, '2025-08-24 21:47:51', '2025-08-24 21:47:51'),
(985, 986, 2, '232410029', 0.00, '2025-08-24 21:47:52', '2025-08-24 21:47:52'),
(986, 987, 2, '232410030', 0.00, '2025-08-24 21:47:52', '2025-08-24 21:47:52'),
(987, 988, 2, '232410031', 0.00, '2025-08-24 21:47:52', '2025-08-24 21:47:52'),
(988, 989, 2, '232410032', 0.00, '2025-08-24 21:47:52', '2025-08-24 21:47:52'),
(989, 990, 2, '232410033', 0.00, '2025-08-24 21:47:53', '2025-08-24 21:47:53'),
(990, 991, 2, '232410034', 0.00, '2025-08-24 21:47:53', '2025-08-24 21:47:53'),
(991, 992, 2, '232410035', 0.00, '2025-08-24 21:47:53', '2025-08-24 21:47:53'),
(992, 993, 2, '232410036', 0.00, '2025-08-24 21:47:53', '2025-08-24 21:47:53'),
(993, 994, 2, '232410037', 0.00, '2025-08-24 21:47:54', '2025-08-24 21:47:54'),
(994, 995, 2, '232410038', 0.00, '2025-08-24 21:47:54', '2025-08-24 21:47:54'),
(995, 996, 2, '232410039', 0.00, '2025-08-24 21:47:54', '2025-08-24 21:47:54'),
(996, 997, 2, '232410040', 0.00, '2025-08-24 21:47:55', '2025-08-24 21:47:55'),
(997, 998, 2, '232410041', 0.00, '2025-08-24 21:47:55', '2025-08-24 21:47:55'),
(998, 999, 2, '232410042', 0.00, '2025-08-24 21:47:55', '2025-08-24 21:47:55'),
(999, 1000, 2, '232410043', 0.00, '2025-08-24 21:47:56', '2025-08-24 21:47:56'),
(1000, 1001, 2, '232410044', 0.00, '2025-08-24 21:47:56', '2025-08-24 21:47:56'),
(1001, 1002, 2, '232410045', 0.00, '2025-08-24 21:47:56', '2025-08-24 21:47:56'),
(1002, 1003, 2, '232410046', 0.00, '2025-08-24 21:47:56', '2025-08-24 21:47:56'),
(1003, 1004, 2, '232410047', 0.00, '2025-08-24 21:47:57', '2025-08-24 21:47:57'),
(1004, 1005, 2, '232410048', 0.00, '2025-08-24 21:47:57', '2025-08-24 21:47:57'),
(1005, 1006, 2, '232410049', 0.00, '2025-08-24 21:47:57', '2025-08-24 21:47:57'),
(1006, 1007, 2, '232410050', 0.00, '2025-08-24 21:47:57', '2025-08-24 21:47:57'),
(1007, 1008, 2, '232410051', 0.00, '2025-08-24 21:47:58', '2025-08-24 21:47:58'),
(1008, 1009, 3, '232410052', 0.00, '2025-08-24 21:47:58', '2025-08-24 21:47:58'),
(1009, 1010, 3, '232410053', 0.00, '2025-08-24 21:47:58', '2025-08-24 21:47:58'),
(1010, 1011, 3, '232410054', 0.00, '2025-08-24 21:47:58', '2025-08-24 21:47:58'),
(1011, 1012, 3, '232410055', 0.00, '2025-08-24 21:47:59', '2025-08-24 21:47:59'),
(1012, 1013, 3, '232410056', 0.00, '2025-08-24 21:47:59', '2025-08-24 21:47:59'),
(1013, 1014, 3, '232410057', 0.00, '2025-08-24 21:47:59', '2025-08-24 21:47:59'),
(1014, 1015, 3, '232410058', 0.00, '2025-08-24 21:48:00', '2025-08-24 21:48:00'),
(1015, 1016, 3, '232410059', 0.00, '2025-08-24 21:48:00', '2025-08-24 21:48:00'),
(1016, 1017, 3, '232410060', 0.00, '2025-08-24 21:48:00', '2025-08-24 21:48:00'),
(1017, 1018, 3, '232410061', 0.00, '2025-08-24 21:48:00', '2025-08-24 21:48:00'),
(1018, 1019, 3, '232410062', 0.00, '2025-08-24 21:48:01', '2025-08-24 21:48:01'),
(1019, 1020, 3, '232410063', 0.00, '2025-08-24 21:48:01', '2025-08-24 21:48:01'),
(1020, 1021, 3, '232410064', 0.00, '2025-08-24 21:48:01', '2025-08-24 21:48:01'),
(1021, 1022, 3, '232410065', 0.00, '2025-08-24 21:48:01', '2025-08-24 21:48:01'),
(1022, 1023, 3, '232410066', 0.00, '2025-08-24 21:48:02', '2025-08-24 21:48:02'),
(1023, 1024, 3, '232410067', 0.00, '2025-08-24 21:48:02', '2025-08-24 21:48:02'),
(1024, 1025, 3, '232410068', 0.00, '2025-08-24 21:48:02', '2025-08-24 21:48:02'),
(1025, 1026, 3, '232410069', 0.00, '2025-08-24 21:48:02', '2025-08-24 21:48:02'),
(1026, 1027, 3, '232410070', 0.00, '2025-08-24 21:48:03', '2025-08-24 21:48:03'),
(1027, 1028, 3, '232410071', 0.00, '2025-08-24 21:48:03', '2025-08-24 21:48:03'),
(1028, 1029, 3, '232410072', 0.00, '2025-08-24 21:48:03', '2025-08-24 21:48:03'),
(1029, 1030, 3, '232410073', 0.00, '2025-08-24 21:48:03', '2025-08-24 21:48:03'),
(1030, 1031, 3, '232410074', 0.00, '2025-08-24 21:48:04', '2025-08-24 21:48:04'),
(1031, 1032, 3, '232410075', 0.00, '2025-08-24 21:48:04', '2025-08-24 21:48:04'),
(1032, 1033, 3, '232410076', 0.00, '2025-08-24 21:48:04', '2025-08-24 21:48:04'),
(1033, 1034, 3, '232410077', 0.00, '2025-08-24 21:48:04', '2025-08-24 21:48:04'),
(1034, 1035, 3, '232410078', 0.00, '2025-08-24 21:48:05', '2025-08-24 21:48:05'),
(1035, 1036, 3, '232410079', 0.00, '2025-08-24 21:48:05', '2025-08-24 21:48:05'),
(1036, 1037, 3, '232410080', 0.00, '2025-08-24 21:48:05', '2025-08-24 21:48:05'),
(1037, 1038, 3, '232410081', 0.00, '2025-08-24 21:48:05', '2025-08-24 21:48:05'),
(1038, 1039, 3, '232410082', 0.00, '2025-08-24 21:48:06', '2025-08-24 21:48:06'),
(1039, 1040, 3, '232410083', 0.00, '2025-08-24 21:48:06', '2025-08-24 21:48:06'),
(1040, 1041, 3, '232410084', 0.00, '2025-08-24 21:48:06', '2025-08-24 21:48:06'),
(1041, 1042, 4, '232410085', 0.00, '2025-08-24 21:48:07', '2025-08-24 21:48:07'),
(1042, 1043, 4, '232410086', 0.00, '2025-08-24 21:48:07', '2025-08-24 21:48:07'),
(1043, 1044, 4, '232410087', 0.00, '2025-08-24 21:48:07', '2025-08-24 21:48:07'),
(1044, 1045, 4, '232410088', 0.00, '2025-08-24 21:48:07', '2025-08-24 21:48:07'),
(1045, 1046, 4, '232410089', 0.00, '2025-08-24 21:48:08', '2025-08-24 21:48:08'),
(1046, 1047, 4, '232410090', 0.00, '2025-08-24 21:48:08', '2025-08-24 21:48:08'),
(1047, 1048, 4, '232410091', 0.00, '2025-08-24 21:48:08', '2025-08-24 21:48:08'),
(1048, 1049, 4, '232410092', 0.00, '2025-08-24 21:48:08', '2025-08-24 21:48:08'),
(1049, 1050, 4, '232410093', 0.00, '2025-08-24 21:48:09', '2025-08-24 21:48:09'),
(1050, 1051, 4, '232410094', 0.00, '2025-08-24 21:48:09', '2025-08-24 21:48:09'),
(1051, 1052, 4, '232410095', 0.00, '2025-08-24 21:48:09', '2025-08-24 21:48:09'),
(1052, 1053, 4, '232410096', 0.00, '2025-08-24 21:48:09', '2025-08-24 21:48:09'),
(1053, 1054, 4, '232410097', 0.00, '2025-08-24 21:48:10', '2025-08-24 21:48:10'),
(1054, 1055, 4, '232410098', 0.00, '2025-08-24 21:48:10', '2025-08-24 21:48:10'),
(1055, 1056, 4, '232410099', 0.00, '2025-08-24 21:48:10', '2025-08-24 21:48:10'),
(1056, 1057, 4, '232410100', 0.00, '2025-08-24 21:48:10', '2025-08-24 21:48:10'),
(1057, 1058, 4, '232410101', 0.00, '2025-08-24 21:48:11', '2025-08-24 21:48:11'),
(1058, 1059, 4, '232410102', 0.00, '2025-08-24 21:48:11', '2025-08-24 21:48:11'),
(1059, 1060, 4, '232410103', 0.00, '2025-08-24 21:48:11', '2025-08-24 21:48:11'),
(1060, 1061, 4, '232410104', 0.00, '2025-08-24 21:48:11', '2025-08-24 21:48:11'),
(1061, 1062, 4, '232410105', 0.00, '2025-08-24 21:48:12', '2025-08-24 21:48:12');
INSERT INTO `siswa` (`id`, `id_pengguna`, `id_kelas`, `nis`, `saldo`, `created_at`, `updated_at`) VALUES
(1062, 1063, 4, '232410106', 0.00, '2025-08-24 21:48:12', '2025-08-24 21:48:12'),
(1063, 1064, 4, '232410107', 0.00, '2025-08-24 21:48:12', '2025-08-24 21:48:12'),
(1064, 1065, 4, '232410108', 0.00, '2025-08-24 21:48:13', '2025-08-24 21:48:13'),
(1065, 1066, 4, '232410109', 0.00, '2025-08-24 21:48:13', '2025-08-24 21:48:13'),
(1066, 1067, 4, '232410110', 0.00, '2025-08-24 21:48:13', '2025-08-24 21:48:13'),
(1067, 1068, 4, '232410111', 0.00, '2025-08-24 21:48:13', '2025-08-24 21:48:13'),
(1068, 1069, 4, '232410112', 0.00, '2025-08-24 21:48:14', '2025-08-24 21:48:14'),
(1069, 1070, 4, '232410113', 0.00, '2025-08-24 21:48:14', '2025-08-24 21:48:14'),
(1070, 1071, 4, '232410114', 0.00, '2025-08-24 21:48:14', '2025-08-24 21:48:14'),
(1071, 1072, 4, '232410115', 0.00, '2025-08-24 21:48:14', '2025-08-24 21:48:14'),
(1072, 1073, 4, '232410116', 0.00, '2025-08-24 21:48:15', '2025-08-24 21:48:15'),
(1073, 1074, 4, '232410117', 0.00, '2025-08-24 21:48:15', '2025-08-24 21:48:15'),
(1074, 1075, 4, '232410118', 0.00, '2025-08-24 21:48:15', '2025-08-24 21:48:15'),
(1075, 1076, 5, '232410119', 0.00, '2025-08-24 21:48:15', '2025-08-24 21:48:15'),
(1076, 1077, 5, '232410120', 0.00, '2025-08-24 21:48:16', '2025-08-24 21:48:16'),
(1077, 1078, 5, '232410121', 0.00, '2025-08-24 21:48:16', '2025-08-24 21:48:16'),
(1078, 1079, 5, '232410122', 0.00, '2025-08-24 21:48:16', '2025-08-24 21:48:16'),
(1079, 1080, 5, '232410123', 0.00, '2025-08-24 21:48:16', '2025-08-24 21:48:16'),
(1080, 1081, 5, '232410124', 0.00, '2025-08-24 21:48:17', '2025-08-24 21:48:17'),
(1081, 1082, 5, '232410125', 0.00, '2025-08-24 21:48:17', '2025-08-24 21:48:17'),
(1082, 1083, 5, '232410126', 0.00, '2025-08-24 21:48:17', '2025-08-24 21:48:17'),
(1083, 1084, 5, '232410127', 0.00, '2025-08-24 21:48:17', '2025-08-24 21:48:17'),
(1084, 1085, 5, '232410128', 0.00, '2025-08-24 21:48:18', '2025-08-24 21:48:18'),
(1085, 1086, 5, '232410129', 0.00, '2025-08-24 21:48:18', '2025-08-24 21:48:18'),
(1086, 1087, 5, '232410130', 0.00, '2025-08-24 21:48:18', '2025-08-24 21:48:18'),
(1087, 1088, 5, '232410131', 0.00, '2025-08-24 21:48:18', '2025-08-24 21:48:18'),
(1088, 1089, 5, '232410132', 0.00, '2025-08-24 21:48:19', '2025-08-24 21:48:19'),
(1089, 1090, 5, '232410133', 0.00, '2025-08-24 21:48:19', '2025-08-24 21:48:19'),
(1090, 1091, 5, '232410134', 0.00, '2025-08-24 21:48:19', '2025-08-24 21:48:19'),
(1091, 1092, 5, '232410135', 0.00, '2025-08-24 21:48:20', '2025-08-24 21:48:20'),
(1092, 1093, 5, '232410136', 0.00, '2025-08-24 21:48:20', '2025-08-24 21:48:20'),
(1093, 1094, 5, '232410137', 0.00, '2025-08-24 21:48:20', '2025-08-24 21:48:20'),
(1094, 1095, 5, '232410138', 0.00, '2025-08-24 21:48:20', '2025-08-24 21:48:20'),
(1095, 1096, 5, '232410139', 0.00, '2025-08-24 21:48:21', '2025-08-24 21:48:21'),
(1096, 1097, 5, '232410140', 0.00, '2025-08-24 21:48:21', '2025-08-24 21:48:21'),
(1097, 1098, 5, '232410141', 0.00, '2025-08-24 21:48:21', '2025-08-24 21:48:21'),
(1098, 1099, 5, '232410142', 0.00, '2025-08-24 21:48:21', '2025-08-24 21:48:21'),
(1099, 1100, 5, '232410143', 0.00, '2025-08-24 21:48:22', '2025-08-24 21:48:22'),
(1100, 1101, 5, '232410144', 0.00, '2025-08-24 21:48:22', '2025-08-24 21:48:22'),
(1101, 1102, 5, '232410145', 0.00, '2025-08-24 21:48:22', '2025-08-24 21:48:22'),
(1102, 1103, 5, '232410146', 0.00, '2025-08-24 21:48:22', '2025-08-24 21:48:22'),
(1103, 1104, 5, '232410147', 0.00, '2025-08-24 21:48:23', '2025-08-24 21:48:23'),
(1104, 1105, 5, '232410148', 0.00, '2025-08-24 21:48:23', '2025-08-24 21:48:23'),
(1105, 1106, 5, '232410149', 0.00, '2025-08-24 21:48:23', '2025-08-24 21:48:23'),
(1106, 1107, 5, '232410150', 0.00, '2025-08-24 21:48:23', '2025-08-24 21:48:23'),
(1107, 1108, 5, '232410151', 0.00, '2025-08-24 21:48:24', '2025-08-24 21:48:24'),
(1108, 1109, 5, '232410152', 0.00, '2025-08-24 21:48:24', '2025-08-24 21:48:24'),
(1109, 1110, 5, '232410153', 0.00, '2025-08-24 21:48:24', '2025-08-24 21:48:24'),
(1110, 1111, 6, '232410154', 0.00, '2025-08-24 21:48:24', '2025-08-24 21:48:24'),
(1111, 1112, 6, '232410155', 0.00, '2025-08-24 21:48:25', '2025-08-24 21:48:25'),
(1112, 1113, 6, '232410156', 0.00, '2025-08-24 21:48:25', '2025-08-24 21:48:25'),
(1113, 1114, 6, '232410157', 0.00, '2025-08-24 21:48:25', '2025-08-24 21:48:25'),
(1114, 1115, 6, '232410158', 0.00, '2025-08-24 21:48:25', '2025-08-24 21:48:25'),
(1115, 1116, 6, '232410159', 0.00, '2025-08-24 21:48:26', '2025-08-24 21:48:26'),
(1116, 1117, 6, '232410160', 0.00, '2025-08-24 21:48:26', '2025-08-24 21:48:26'),
(1117, 1118, 6, '232410161', 0.00, '2025-08-24 21:48:26', '2025-08-24 21:48:26'),
(1118, 1119, 6, '232410162', 0.00, '2025-08-24 21:48:26', '2025-08-24 21:48:26'),
(1119, 1120, 6, '232410163', 0.00, '2025-08-24 21:48:27', '2025-08-24 21:48:27'),
(1120, 1121, 6, '232410164', 0.00, '2025-08-24 21:48:27', '2025-08-24 21:48:27'),
(1121, 1122, 6, '232410165', 0.00, '2025-08-24 21:48:27', '2025-08-24 21:48:27'),
(1122, 1123, 6, '232410166', 0.00, '2025-08-24 21:48:28', '2025-08-24 21:48:28'),
(1123, 1124, 6, '232410167', 0.00, '2025-08-24 21:48:28', '2025-08-24 21:48:28'),
(1124, 1125, 6, '232410168', 0.00, '2025-08-24 21:48:28', '2025-08-24 21:48:28'),
(1125, 1126, 6, '232410169', 0.00, '2025-08-24 21:48:28', '2025-08-24 21:48:28'),
(1126, 1127, 6, '232410170', 0.00, '2025-08-24 21:48:29', '2025-08-24 21:48:29'),
(1127, 1128, 6, '232410171', 0.00, '2025-08-24 21:48:29', '2025-08-24 21:48:29'),
(1128, 1129, 6, '232410172', 0.00, '2025-08-24 21:48:29', '2025-08-24 21:48:29'),
(1129, 1130, 6, '232410173', 0.00, '2025-08-24 21:48:29', '2025-08-24 21:48:29'),
(1130, 1131, 6, '232410174', 0.00, '2025-08-24 21:48:30', '2025-08-24 21:48:30'),
(1131, 1132, 6, '232410175', 0.00, '2025-08-24 21:48:30', '2025-08-24 21:48:30'),
(1132, 1133, 6, '232410176', 0.00, '2025-08-24 21:48:30', '2025-08-24 21:48:30'),
(1133, 1134, 6, '232410177', 0.00, '2025-08-24 21:48:30', '2025-08-24 21:48:30'),
(1134, 1135, 6, '232410178', 0.00, '2025-08-24 21:48:31', '2025-08-24 21:48:31'),
(1135, 1136, 6, '232410179', 0.00, '2025-08-24 21:48:31', '2025-08-24 21:48:31'),
(1136, 1137, 6, '232410180', 0.00, '2025-08-24 21:48:31', '2025-08-24 21:48:31'),
(1137, 1138, 6, '232410181', 0.00, '2025-08-24 21:48:31', '2025-08-24 21:48:31'),
(1138, 1139, 6, '232410182', 0.00, '2025-08-24 21:48:32', '2025-08-24 21:48:32'),
(1139, 1140, 6, '232410183', 0.00, '2025-08-24 21:48:32', '2025-08-24 21:48:32'),
(1140, 1141, 6, '232410184', 0.00, '2025-08-24 21:48:32', '2025-08-24 21:48:32'),
(1141, 1142, 6, '232410185', 0.00, '2025-08-24 21:48:32', '2025-08-24 21:48:32'),
(1142, 1143, 6, '232410186', 0.00, '2025-08-24 21:48:33', '2025-08-24 21:48:33'),
(1143, 1144, 6, '232410187', 0.00, '2025-08-24 21:48:33', '2025-08-24 21:48:33'),
(1144, 1145, 7, '232410188', 0.00, '2025-08-24 21:48:33', '2025-08-24 21:48:33'),
(1145, 1146, 7, '232410189', 0.00, '2025-08-24 21:48:34', '2025-08-24 21:48:34'),
(1146, 1147, 7, '232410190', 0.00, '2025-08-24 21:48:34', '2025-08-24 21:48:34'),
(1147, 1148, 7, '232410191', 0.00, '2025-08-24 21:48:34', '2025-08-24 21:48:34'),
(1148, 1149, 7, '232410192', 0.00, '2025-08-24 21:48:34', '2025-08-24 21:48:34'),
(1149, 1150, 7, '232410193', 0.00, '2025-08-24 21:48:35', '2025-08-24 21:48:35'),
(1150, 1151, 7, '232410194', 0.00, '2025-08-24 21:48:35', '2025-08-24 21:48:35'),
(1151, 1152, 7, '232410195', 0.00, '2025-08-24 21:48:35', '2025-08-24 21:48:35'),
(1152, 1153, 7, '232410196', 0.00, '2025-08-24 21:48:36', '2025-08-24 21:48:36'),
(1153, 1154, 7, '232410197', 0.00, '2025-08-24 21:48:36', '2025-08-24 21:48:36'),
(1154, 1155, 7, '232410198', 0.00, '2025-08-24 21:48:36', '2025-08-24 21:48:36'),
(1155, 1156, 7, '232410199', 0.00, '2025-08-24 21:48:36', '2025-08-24 21:48:36'),
(1156, 1157, 7, '232410200', 0.00, '2025-08-24 21:48:37', '2025-08-24 21:48:37'),
(1157, 1158, 7, '232410201', 0.00, '2025-08-24 21:48:37', '2025-08-24 21:48:37'),
(1158, 1159, 7, '232410202', 0.00, '2025-08-24 21:48:37', '2025-08-24 21:48:37'),
(1159, 1160, 7, '232410203', 0.00, '2025-08-24 21:48:37', '2025-08-24 21:48:37'),
(1160, 1161, 7, '232410204', 0.00, '2025-08-24 21:48:38', '2025-08-24 21:48:38'),
(1161, 1162, 7, '232410205', 0.00, '2025-08-24 21:48:38', '2025-08-24 21:48:38'),
(1162, 1163, 7, '232410206', 0.00, '2025-08-24 21:48:38', '2025-08-24 21:48:38'),
(1163, 1164, 7, '232410207', 0.00, '2025-08-24 21:48:38', '2025-08-24 21:48:38'),
(1164, 1165, 7, '232410208', 0.00, '2025-08-24 21:48:39', '2025-08-24 21:48:39'),
(1165, 1166, 7, '232410209', 0.00, '2025-08-24 21:48:39', '2025-08-24 21:48:39'),
(1166, 1167, 7, '232410210', 0.00, '2025-08-24 21:48:39', '2025-08-24 21:48:39'),
(1167, 1168, 7, '232410211', 0.00, '2025-08-24 21:48:40', '2025-08-24 21:48:40'),
(1168, 1169, 7, '232410212', 0.00, '2025-08-24 21:48:40', '2025-08-24 21:48:40'),
(1169, 1170, 7, '232410213', 0.00, '2025-08-24 21:48:40', '2025-08-24 21:48:40'),
(1170, 1171, 7, '232410214', 0.00, '2025-08-24 21:48:40', '2025-08-24 21:48:40'),
(1171, 1172, 7, '232410215', 0.00, '2025-08-24 21:48:41', '2025-08-24 21:48:41'),
(1172, 1173, 7, '232410216', 0.00, '2025-08-24 21:48:41', '2025-08-24 21:48:41'),
(1173, 1174, 7, '232410217', 0.00, '2025-08-24 21:48:41', '2025-08-24 21:48:41'),
(1174, 1175, 7, '232410218', 0.00, '2025-08-24 21:48:41', '2025-08-24 21:48:41'),
(1175, 1176, 7, '232410219', 0.00, '2025-08-24 21:48:42', '2025-08-24 21:48:42'),
(1176, 1177, 8, '232410220', 0.00, '2025-08-24 21:48:42', '2025-08-24 21:48:42'),
(1177, 1178, 8, '232410221', 0.00, '2025-08-24 21:48:42', '2025-08-24 21:48:42'),
(1178, 1179, 8, '232410222', 0.00, '2025-08-24 21:48:42', '2025-08-24 21:48:42'),
(1179, 1180, 8, '232410223', 0.00, '2025-08-24 21:48:43', '2025-08-24 21:48:43'),
(1180, 1181, 8, '232410224', 0.00, '2025-08-24 21:48:43', '2025-08-24 21:48:43'),
(1181, 1182, 8, '232410225', 0.00, '2025-08-24 21:48:43', '2025-08-24 21:48:43'),
(1182, 1183, 8, '232410226', 0.00, '2025-08-24 21:48:43', '2025-08-24 21:48:43'),
(1183, 1184, 8, '232410227', 0.00, '2025-08-24 21:48:44', '2025-08-24 21:48:44'),
(1184, 1185, 8, '232410228', 0.00, '2025-08-24 21:48:44', '2025-08-24 21:48:44'),
(1185, 1186, 8, '232410229', 0.00, '2025-08-24 21:48:44', '2025-08-24 21:48:44'),
(1186, 1187, 8, '232410230', 0.00, '2025-08-24 21:48:44', '2025-08-24 21:48:44'),
(1187, 1188, 8, '232410231', 0.00, '2025-08-24 21:48:45', '2025-08-24 21:48:45'),
(1188, 1189, 8, '232410232', 0.00, '2025-08-24 21:48:45', '2025-08-24 21:48:45'),
(1189, 1190, 8, '232410233', 0.00, '2025-08-24 21:48:45', '2025-08-24 21:48:45'),
(1190, 1191, 8, '232410234', 0.00, '2025-08-24 21:48:45', '2025-08-24 21:48:45'),
(1191, 1192, 8, '232410235', 0.00, '2025-08-24 21:48:46', '2025-08-24 21:48:46'),
(1192, 1193, 8, '232410236', 0.00, '2025-08-24 21:48:46', '2025-08-24 21:48:46'),
(1193, 1194, 8, '232410237', 0.00, '2025-08-24 21:48:46', '2025-08-24 21:48:46'),
(1194, 1195, 8, '232410238', 0.00, '2025-08-24 21:48:46', '2025-08-24 21:48:46'),
(1195, 1196, 8, '232410239', 0.00, '2025-08-24 21:48:47', '2025-08-24 21:48:47'),
(1196, 1197, 8, '232410240', 0.00, '2025-08-24 21:48:47', '2025-08-24 21:48:47'),
(1197, 1198, 8, '232410241', 0.00, '2025-08-24 21:48:47', '2025-08-24 21:48:47'),
(1198, 1199, 8, '232410242', 0.00, '2025-08-24 21:48:47', '2025-08-24 21:48:47'),
(1199, 1200, 8, '232410243', 0.00, '2025-08-24 21:48:48', '2025-08-24 21:48:48'),
(1200, 1201, 8, '232410244', 0.00, '2025-08-24 21:48:48', '2025-08-24 21:48:48'),
(1201, 1202, 8, '232410245', 0.00, '2025-08-24 21:48:48', '2025-08-24 21:48:48'),
(1202, 1203, 8, '232410246', 0.00, '2025-08-24 21:48:49', '2025-08-24 21:48:49'),
(1203, 1204, 8, '232410247', 0.00, '2025-08-24 21:48:49', '2025-08-24 21:48:49'),
(1204, 1205, 8, '232410248', 0.00, '2025-08-24 21:48:49', '2025-08-24 21:48:49'),
(1205, 1206, 8, '232410249', 0.00, '2025-08-24 21:48:49', '2025-08-24 21:48:49'),
(1206, 1207, 8, '232410250', 0.00, '2025-08-24 21:48:50', '2025-08-24 21:48:50'),
(1207, 1208, 8, '232410251', 0.00, '2025-08-24 21:48:50', '2025-08-24 21:48:50'),
(1208, 1209, 8, '232410252', 0.00, '2025-08-24 21:48:50', '2025-08-24 21:48:50'),
(1209, 1210, 9, '232410253', 0.00, '2025-08-24 21:48:50', '2025-08-24 21:48:50'),
(1210, 1211, 9, '232410254', 0.00, '2025-08-24 21:48:51', '2025-08-24 21:48:51'),
(1211, 1212, 9, '232410255', 0.00, '2025-08-24 21:48:51', '2025-08-24 21:48:51'),
(1212, 1213, 9, '232410256', 0.00, '2025-08-24 21:48:51', '2025-08-24 21:48:51'),
(1213, 1214, 9, '232410257', 0.00, '2025-08-24 21:48:51', '2025-08-24 21:48:51'),
(1214, 1215, 9, '232410258', 0.00, '2025-08-24 21:48:52', '2025-08-24 21:48:52'),
(1215, 1216, 9, '232410259', 0.00, '2025-08-24 21:48:52', '2025-08-24 21:48:52'),
(1216, 1217, 9, '232410260', 0.00, '2025-08-24 21:48:52', '2025-08-24 21:48:52'),
(1217, 1218, 9, '232410261', 0.00, '2025-08-24 21:48:52', '2025-08-24 21:48:52'),
(1218, 1219, 9, '232410262', 0.00, '2025-08-24 21:48:53', '2025-08-24 21:48:53'),
(1219, 1220, 9, '232410263', 0.00, '2025-08-24 21:48:53', '2025-08-24 21:48:53'),
(1220, 1221, 9, '232410264', 0.00, '2025-08-24 21:48:53', '2025-08-24 21:48:53'),
(1221, 1222, 9, '232410265', 0.00, '2025-08-24 21:48:53', '2025-08-24 21:48:53'),
(1222, 1223, 9, '232410266', 0.00, '2025-08-24 21:48:54', '2025-08-24 21:48:54'),
(1223, 1224, 9, '232410267', 0.00, '2025-08-24 21:48:54', '2025-08-24 21:48:54'),
(1224, 1225, 9, '232410268', 0.00, '2025-08-24 21:48:54', '2025-08-24 21:48:54'),
(1225, 1226, 9, '232410269', 0.00, '2025-08-24 21:48:54', '2025-08-24 21:48:54'),
(1226, 1227, 9, '232410270', 0.00, '2025-08-24 21:48:55', '2025-08-24 21:48:55'),
(1227, 1228, 9, '232410271', 0.00, '2025-08-24 21:48:55', '2025-08-24 21:48:55'),
(1228, 1229, 9, '232410272', 0.00, '2025-08-24 21:48:55', '2025-08-24 21:48:55'),
(1229, 1230, 9, '232410273', 0.00, '2025-08-24 21:48:55', '2025-08-24 21:48:55'),
(1230, 1231, 9, '232410274', 0.00, '2025-08-24 21:48:56', '2025-08-24 21:48:56'),
(1231, 1232, 9, '232410275', 0.00, '2025-08-24 21:48:56', '2025-08-24 21:48:56'),
(1232, 1233, 9, '232410276', 0.00, '2025-08-24 21:48:56', '2025-08-24 21:48:56'),
(1233, 1234, 9, '232410277', 0.00, '2025-08-24 21:48:56', '2025-08-24 21:48:56'),
(1234, 1235, 9, '232410278', 0.00, '2025-08-24 21:48:57', '2025-08-24 21:48:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku_kas`
--
ALTER TABLE `buku_kas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buku_kas_id_admin_foreign` (`id_admin`);

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
  ADD KEY `penarikan_id_siswa_foreign` (`id_siswa`),
  ADD KEY `penarikan_id_admin_foreign` (`id_admin`),
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
  ADD KEY `setoran_id_siswa_foreign` (`id_siswa`),
  ADD KEY `setoran_id_jenis_sampah_foreign` (`id_jenis_sampah`),
  ADD KEY `setoran_id_admin_foreign` (`id_admin`);

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
-- AUTO_INCREMENT for table `buku_kas`
--
ALTER TABLE `buku_kas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `penarikan`
--
ALTER TABLE `penarikan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1236;

--
-- AUTO_INCREMENT for table `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `setoran`
--
ALTER TABLE `setoran`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1235;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buku_kas`
--
ALTER TABLE `buku_kas`
  ADD CONSTRAINT `buku_kas_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`);

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
  ADD CONSTRAINT `penarikan_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`),
  ADD CONSTRAINT `penarikan_id_kelas_foreign` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id`),
  ADD CONSTRAINT `penarikan_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`);

--
-- Constraints for table `setoran`
--
ALTER TABLE `setoran`
  ADD CONSTRAINT `setoran_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`),
  ADD CONSTRAINT `setoran_id_jenis_sampah_foreign` FOREIGN KEY (`id_jenis_sampah`) REFERENCES `jenis_sampah` (`id`),
  ADD CONSTRAINT `setoran_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id`) ON DELETE CASCADE;

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
