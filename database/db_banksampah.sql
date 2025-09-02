-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 02, 2025 at 03:04 AM
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

--
-- Dumping data for table `insentifs`
--

INSERT INTO `insentifs` (`id`, `setoran_id`, `kelas_id`, `jumlah_insentif`, `status_pembayaran`, `created_at`, `updated_at`, `pembayaran_insentif_id`) VALUES
(1, 1, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(2, 2, 24, 77.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(3, 3, 24, 35.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(4, 4, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(5, 5, 24, 49.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(6, 6, 24, 49.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(7, 7, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(8, 8, 24, 21.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(9, 9, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(10, 10, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(11, 11, 24, 42.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(12, 12, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(13, 13, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(14, 14, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(15, 15, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(16, 16, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(17, 17, 24, 77.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(18, 18, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(19, 19, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(20, 20, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(21, 21, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(22, 22, 24, 35.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(23, 23, 24, 70.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(24, 24, 24, 105.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(25, 25, 24, 35.00, 'belum dibayar', '2025-09-01 06:11:20', '2025-09-01 06:11:20', NULL),
(26, 26, 24, 10.00, 'belum dibayar', '2025-09-01 06:12:28', '2025-09-01 06:12:28', NULL),
(27, 27, 24, 14.00, 'belum dibayar', '2025-09-01 06:12:28', '2025-09-01 06:12:28', NULL),
(28, 28, 24, 20.00, 'belum dibayar', '2025-09-01 06:12:28', '2025-09-01 06:12:28', NULL),
(29, 29, 24, 20.00, 'belum dibayar', '2025-09-01 06:12:28', '2025-09-01 06:12:28', NULL),
(30, 30, 24, 10.00, 'belum dibayar', '2025-09-01 06:12:28', '2025-09-01 06:12:28', NULL),
(31, 31, 24, 20.00, 'belum dibayar', '2025-09-01 06:12:28', '2025-09-01 06:12:28', NULL),
(32, 32, 24, 20.00, 'belum dibayar', '2025-09-01 06:12:28', '2025-09-01 06:12:28', NULL),
(33, 33, 25, 70.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(34, 34, 25, 70.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(35, 35, 25, 77.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(36, 36, 25, 70.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(37, 37, 25, 56.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(38, 38, 25, 28.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(39, 39, 25, 98.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(40, 40, 25, 28.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(41, 41, 25, 28.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(42, 42, 25, 28.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(43, 43, 25, 70.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(44, 44, 25, 28.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(45, 45, 25, 35.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(46, 46, 25, 49.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(47, 47, 25, 56.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(48, 48, 25, 49.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(49, 49, 25, 49.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(50, 50, 25, 70.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(51, 51, 25, 70.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(52, 52, 25, 42.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(53, 53, 25, 35.00, 'belum dibayar', '2025-09-01 07:36:38', '2025-09-01 07:36:38', NULL),
(54, 54, 25, 8.00, 'belum dibayar', '2025-09-01 07:37:48', '2025-09-01 07:37:48', NULL),
(55, 55, 25, 12.00, 'belum dibayar', '2025-09-01 07:37:48', '2025-09-01 07:37:48', NULL),
(56, 56, 25, 12.00, 'belum dibayar', '2025-09-01 07:37:48', '2025-09-01 07:37:48', NULL),
(57, 57, 25, 8.00, 'belum dibayar', '2025-09-01 07:37:48', '2025-09-01 07:37:48', NULL),
(58, 58, 25, 24.00, 'belum dibayar', '2025-09-01 07:37:48', '2025-09-01 07:37:48', NULL),
(59, 59, 25, 2.00, 'belum dibayar', '2025-09-01 07:37:48', '2025-09-01 07:37:48', NULL),
(60, 60, 25, 20.00, 'belum dibayar', '2025-09-01 07:37:48', '2025-09-01 07:37:48', NULL),
(61, 61, 25, 10.00, 'belum dibayar', '2025-09-01 07:37:48', '2025-09-01 07:37:48', NULL),
(62, 62, 26, 7.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(63, 63, 26, 28.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(64, 64, 26, 70.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(65, 65, 26, 70.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(66, 66, 26, 14.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(67, 67, 26, 70.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(68, 68, 26, 42.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(69, 69, 26, 63.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(70, 70, 26, 49.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(71, 71, 26, 42.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(72, 72, 26, 7.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(73, 73, 26, 91.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(74, 74, 26, 42.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(75, 75, 26, 49.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(76, 76, 26, 70.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(77, 77, 26, 70.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(78, 78, 26, 7.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(79, 79, 26, 35.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(80, 80, 26, 70.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(81, 81, 26, 63.00, 'belum dibayar', '2025-09-01 07:40:06', '2025-09-01 07:40:06', NULL),
(82, 82, 26, 18.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(83, 83, 26, 22.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(84, 84, 26, 4.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(85, 85, 26, 16.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(86, 86, 26, 20.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(87, 87, 26, 10.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(88, 88, 26, 2.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(89, 89, 26, 20.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(90, 90, 26, 20.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(91, 91, 26, 20.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(92, 92, 26, 6.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(93, 93, 26, 8.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(94, 94, 26, 20.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(95, 95, 26, 8.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(96, 96, 26, 18.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(97, 97, 26, 24.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(98, 98, 26, 20.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(99, 99, 26, 10.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(100, 100, 26, 20.00, 'belum dibayar', '2025-09-01 07:41:28', '2025-09-01 07:41:28', NULL),
(101, 101, 21, 63.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(102, 102, 21, 7.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(103, 103, 21, 35.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(104, 104, 21, 133.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(105, 105, 21, 7.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(106, 106, 21, 182.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(107, 107, 21, 147.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(108, 108, 21, 98.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(109, 109, 21, 7.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(110, 110, 21, 105.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(111, 111, 21, 35.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(112, 112, 21, 70.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(113, 113, 21, 7.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(114, 114, 21, 70.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(115, 115, 21, 140.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(116, 116, 21, 7.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(117, 117, 21, 133.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(118, 118, 21, 77.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(119, 119, 21, 63.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(120, 120, 21, 70.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(121, 121, 21, 7.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(122, 122, 21, 70.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(123, 123, 21, 42.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(124, 124, 21, 49.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(125, 125, 21, 84.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(126, 126, 21, 21.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(127, 127, 21, 140.00, 'belum dibayar', '2025-09-01 08:58:08', '2025-09-01 08:58:08', NULL),
(128, 128, 21, 40.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(129, 129, 21, 18.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(130, 130, 21, 14.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(131, 131, 21, 26.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(132, 132, 21, 22.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(133, 133, 21, 22.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(134, 134, 21, 12.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(135, 135, 21, 42.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(136, 136, 21, 30.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(137, 137, 21, 22.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(138, 138, 21, 20.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(139, 139, 21, 18.00, 'belum dibayar', '2025-09-01 09:00:34', '2025-09-01 09:00:34', NULL),
(140, 140, 22, 70.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(141, 141, 22, 35.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(142, 142, 22, 70.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(143, 143, 22, 14.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(144, 144, 22, 49.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(145, 145, 22, 70.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(146, 146, 22, 35.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(147, 147, 22, 35.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(148, 148, 22, 14.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(149, 149, 22, 42.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(150, 150, 22, 35.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(151, 151, 22, 35.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(152, 152, 22, 28.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(153, 153, 22, 70.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(154, 154, 22, 35.00, 'belum dibayar', '2025-09-01 09:07:03', '2025-09-01 09:07:03', NULL),
(155, 155, 22, 12.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL),
(156, 156, 22, 10.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL),
(157, 157, 22, 2.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL),
(158, 158, 22, 16.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL),
(159, 159, 22, 20.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL),
(160, 160, 22, 14.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL),
(161, 161, 22, 6.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL),
(162, 162, 22, 10.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL),
(163, 163, 22, 30.00, 'belum dibayar', '2025-09-01 09:08:03', '2025-09-01 09:08:03', NULL);

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
(1, 'Botol Plastik', 'aktif', 'pcs', 35.00, 878, '2025-09-01 04:23:07', '2025-09-01 09:07:03'),
(2, 'Gelas Plastik', 'aktif', 'pcs', 10.00, 451, '2025-09-01 04:23:07', '2025-09-01 09:08:03'),
(3, 'Kardus', 'aktif', 'kg', 1500.00, 0, '2025-09-01 04:23:07', '2025-09-01 06:00:58'),
(4, 'Botol Plastik Guru', 'aktif', 'pcs', 42.00, 138, '2025-09-01 13:59:40', '2025-09-01 14:02:35'),
(5, 'Gelas Plastik Guru', 'aktif', 'pcs', 15.00, 23, '2025-09-01 13:59:51', '2025-09-01 14:02:35');

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
(1, 'Transportasi', 'pengeluaran', '2025-09-01 04:28:56', '2025-09-01 04:28:56'),
(2, 'Operasional', 'pengeluaran', '2025-09-01 04:29:00', '2025-09-01 04:29:00'),
(3, 'Hasil Penjualan', 'pemasukan', '2025-09-01 04:29:04', '2025-09-01 04:29:04'),
(4, 'Saldo Awal', 'pemasukan', '2025-09-01 04:29:09', '2025-09-01 04:29:09');

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
(1, 'Guru', '2025-09-01 04:23:07', '2025-09-01 04:23:07', NULL),
(2, 'X MPLB 1', '2025-09-01 04:23:07', '2025-09-01 04:42:52', 806),
(3, 'X MPLB 2', '2025-09-01 04:23:07', '2025-09-01 04:43:03', 807),
(4, 'X TM 1', '2025-09-01 04:23:07', '2025-09-01 04:43:16', 808),
(5, 'X TM 2', '2025-09-01 04:23:07', '2025-09-01 04:43:23', 809),
(6, 'X TM 3', '2025-09-01 04:23:07', '2025-09-01 04:43:30', 810),
(7, 'X TM 4', '2025-09-01 04:23:07', '2025-09-01 04:43:36', 811),
(8, 'X TM 5', '2025-09-01 04:23:07', '2025-09-01 04:43:43', 812),
(9, 'X TM 6', '2025-09-01 04:23:07', '2025-09-01 04:43:52', 813),
(10, 'XI MPLB 1', '2025-09-01 04:23:07', '2025-09-01 04:44:00', 814),
(11, 'XI MPLB 2', '2025-09-01 04:23:07', '2025-09-01 04:44:14', 815),
(12, 'XI TM 1', '2025-09-01 04:23:07', '2025-09-01 04:44:24', 816),
(13, 'XI TM 2', '2025-09-01 04:23:07', '2025-09-01 04:42:45', 817),
(14, 'XI TM 3', '2025-09-01 04:23:07', '2025-09-01 04:42:32', 818),
(15, 'XI TM 4', '2025-09-01 04:23:07', '2025-09-01 04:42:15', 819),
(16, 'XI TM 5', '2025-09-01 04:23:07', '2025-09-01 04:40:00', 820),
(17, 'XI TM 6', '2025-09-01 04:23:07', '2025-09-01 04:40:08', 821),
(18, 'XI TM 7', '2025-09-01 04:23:07', '2025-09-01 04:40:16', 822),
(19, 'XII MPLB 1', '2025-09-01 04:23:07', '2025-09-01 04:40:28', 823),
(20, 'XII MPLB 2', '2025-09-01 04:23:07', '2025-09-01 04:40:44', 824),
(21, 'XII TM 1', '2025-09-01 04:23:07', '2025-09-01 04:41:03', 825),
(22, 'XII TM 2', '2025-09-01 04:23:07', '2025-09-01 04:41:10', 826),
(23, 'XII TM 3', '2025-09-01 04:23:07', '2025-09-01 04:41:19', 827),
(24, 'XII TM 4', '2025-09-01 04:23:07', '2025-09-01 04:41:31', 828),
(25, 'XII TM 5', '2025-09-01 04:23:07', '2025-09-01 04:41:39', 829),
(26, 'XII TM 6', '2025-09-01 04:23:07', '2025-09-01 04:42:02', 830),
(27, 'XII TM 7', '2025-09-01 04:23:07', '2025-09-01 04:44:29', 831);

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
(26, '2025_09_01_115843_create_pembayaran_insentifs_table', 2),
(27, '2025_09_01_115855_add_status_pembayaran_to_insentifs_table', 2),
(28, '2025_09_02_072425_add_status_to_setoran_table', 3),
(29, '2025_09_02_075146_add_id_wali_kelas_to_pembayaran_insentifs_table', 4),
(30, '2025_09_02_075314_add_jumlah_pembayaran_to_pembayaran_insentifs_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_insentifs`
--

CREATE TABLE `pembayaran_insentifs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `tanggal_pembayaran` date NOT NULL,
  `jumlah_pembayaran` decimal(15,2) NOT NULL,
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
(1, 'Administrator', 'admin', '$2y$12$Th1r9uio/30nSGLM5JpXcephqoBh0F12liLSllsZW2bk6R5tyR0R.', 'admin', '2025-09-01 04:23:06', '2025-09-01 04:23:06'),
(2, 'ADILAH', '252610001', '$2y$12$V6.CgO8WgegiNvgdxfReHOeSCbJiGoWydGW7uZ4I/0K7RIzAtKO8O', 'siswa', '2025-09-01 04:23:42', '2025-09-01 04:23:42'),
(3, 'ADINDA OKTAVIANA', '252610002', '$2y$12$ISnnzWh2fG8CzVzLXmIYPebgr//M05kTSjjBaiyhSeGBxBp4uEkPG', 'siswa', '2025-09-01 04:23:43', '2025-09-01 04:23:43'),
(4, 'ATIK CANTIKA', '252610003', '$2y$12$8Kr7vA7bLMVLlvl4ZKTDYefpNcJ8QFNXTNzWGVHCgx79hrUXMcOn2', 'siswa', '2025-09-01 04:23:43', '2025-09-01 04:23:43'),
(5, 'AYU FADILLAH', '252610004', '$2y$12$g7NuBrd608L01taBgnE57.i5u4iYhs5SD6x6rWtoY0g5IwiJC1Kg2', 'siswa', '2025-09-01 04:23:43', '2025-09-01 04:23:43'),
(6, 'BINTANG SAMUDRA SATYABUDIE', '252610005', '$2y$12$kA3LLLwhee7wufQPMXvqjuBQSUlLP84zKmlGBjAROjRwdDjan0HS.', 'siswa', '2025-09-01 04:23:44', '2025-09-01 04:23:44'),
(7, 'DESFA NAILATUL NAFISA', '252610006', '$2y$12$qHSu0o2La9fRotDCNBQQZOFkI6tcjJI0wyhLqBBAYvlBFunc11C66', 'siswa', '2025-09-01 04:23:44', '2025-09-01 04:23:44'),
(8, 'DONI RAMADHANI', '252610007', '$2y$12$k/ZJF.4C88XgwNFvkgCqGeFvfgaJu.kCrS76ql93EghFesLneueoG', 'siswa', '2025-09-01 04:23:44', '2025-09-01 04:23:44'),
(9, 'FITRIA ZAHRATUNNAJA', '252610008', '$2y$12$GK.Y2lIaJIqP/WDBHfhGl.C2fLtLv6CC5j3FP8ufRaITwU0PwbQOO', 'siswa', '2025-09-01 04:23:44', '2025-09-01 04:23:44'),
(10, 'INDAH AFIFA', '252610009', '$2y$12$uazmWu0sOJ7OKHSaYUv.SO3Qd/iSdXoPtchfm0hABiQXxnasu3mhO', 'siswa', '2025-09-01 04:23:45', '2025-09-01 04:23:45'),
(11, 'INDAH LISNAWATI', '252610010', '$2y$12$bxecrd0LppbcongVo54qrueBWxmSaaXqAXBxciqA9b8n8fg11lYrW', 'siswa', '2025-09-01 04:23:45', '2025-09-01 04:23:45'),
(12, 'INDRI PUSPITASARI', '252610011', '$2y$12$CvZgbyl20G1fzNtWvxHzmu.e8w2jrXniYhzRz02OBFNAW7Fw5xwDO', 'siswa', '2025-09-01 04:23:45', '2025-09-01 04:23:45'),
(13, 'IQBAL MAULANA', '252610012', '$2y$12$LOPv6BC1WisLMUG.FTRTeuE8jZfLSjbFkN5YSkumwMOGUqVZ/.Bpm', 'siswa', '2025-09-01 04:23:45', '2025-09-01 04:23:45'),
(14, 'JIHAN KHOLILAH', '252610013', '$2y$12$Pw3Ti5PGgCgmwU.JD/Xr3Oj6yjakNJCnxoobR4bylim7Bvi7vKsCW', 'siswa', '2025-09-01 04:23:46', '2025-09-01 04:23:46'),
(15, 'KARLINA', '252610014', '$2y$12$QXq.f7L2mF4S19Fl2aa0IeyZwJBWcRQ/.DRUy9iwDBTOjphs7pjUS', 'siswa', '2025-09-01 04:23:46', '2025-09-01 04:23:46'),
(16, 'KHOLIFAH RIZKA NURSAADAH', '252610015', '$2y$12$Re.SYEE2Gf3TagKTe6lv9.kXgQQ4VbHwhWZ6gthNEaq6FllBu6yjS', 'siswa', '2025-09-01 04:23:46', '2025-09-01 04:23:46'),
(17, 'KOMARIAH', '252610016', '$2y$12$4m7bQxrPVWNfGPv9OITMW.lJ/HDBc7SbO408w49qwLjuANdF4biFu', 'siswa', '2025-09-01 04:23:46', '2025-09-01 04:23:46'),
(18, 'NURUL HABIBAH', '252610017', '$2y$12$uiipqsigaS3Ragmh0oto2u.vguByJA4QnIlIX5dE6cG3a7taMkra.', 'siswa', '2025-09-01 04:23:47', '2025-09-01 04:23:47'),
(19, 'RISMA NURMALA', '252610018', '$2y$12$tTIFVg4tEt4Sp//guLcb5e24MpD0hOFTkIpcOdOR543JCvstDLqBO', 'siswa', '2025-09-01 04:23:47', '2025-09-01 04:23:47'),
(20, 'SALWA ANUROH', '252610019', '$2y$12$lTHnjbJ9.tgGuxuCQ9GVkuoitB974KFqdOjqOzkP/5l2sK5WezrLa', 'siswa', '2025-09-01 04:23:47', '2025-09-01 04:23:47'),
(21, 'SHIPA', '252610020', '$2y$12$AsNgZbmxYT6Rmngcgz00T.W8Zk7x/UuawiF6uGbvuoceR4eSwgYF.', 'siswa', '2025-09-01 04:23:47', '2025-09-01 04:23:47'),
(22, 'SHOFIA AISYAH MUSAFAAH', '252610021', '$2y$12$yqvTQPncyk.rrQavdxwUFe3v9FLjcj0OJt4FhB6hP/69Ga4nqHqtW', 'siswa', '2025-09-01 04:23:48', '2025-09-01 04:23:48'),
(23, 'SITI ALISA', '252610022', '$2y$12$MqQLucbP2TKv0JioTcFNvuUL8gOjSO2bpnzIZ4hY3cFzDW3tzKrq2', 'siswa', '2025-09-01 04:23:48', '2025-09-01 04:23:48'),
(24, 'SITI AMINAH', '252610023', '$2y$12$BMlq7xJ14B40l3dOA0bGueSmOec2xhRqecPsJk.K//oONKwGCMDWy', 'siswa', '2025-09-01 04:23:48', '2025-09-01 04:23:48'),
(25, 'SITI FATIMAH', '252610024', '$2y$12$nZlLw0.gSN7OgyGznaPEu.VQMMLGE/f5hkW621CSSKYS2Tuow.xR2', 'siswa', '2025-09-01 04:23:48', '2025-09-01 04:23:48'),
(26, 'WARNIH MELINDA', '252610025', '$2y$12$yfRb5IxOLsPPYcDMs7uBa.YtFsTsygGcky0IgI7xipFiisTIlkq6S', 'siswa', '2025-09-01 04:23:49', '2025-09-01 04:23:49'),
(27, 'WINA', '252610026', '$2y$12$QgyfHih7r/2yNk16rVbiWe8pVmhippUueV5DEHb7KHRuM8eH9VxtS', 'siswa', '2025-09-01 04:23:49', '2025-09-01 04:23:49'),
(28, 'ZASKIA PUTRI', '252610027', '$2y$12$ct/FN4E.I4.1nTWtS1OpqOTXU5h8Ojpk5dj3roIX4Y4BBxYXw0jeO', 'siswa', '2025-09-01 04:23:49', '2025-09-01 04:23:49'),
(29, 'ALLEEISYA DAVINA KAMANDHANIKA', '252610028', '$2y$12$4xO0Cj0xvvXdh.Wejr2SKeSK0wny6.MjZPqwREx.oD.Fm4e6IUIm6', 'siswa', '2025-09-01 04:23:50', '2025-09-01 04:23:50'),
(30, 'ALYA HANDAYANI', '252610029', '$2y$12$o2Zq7tnUTSAyAv4weFT.3.WQjOG4l.7Os2ebJnTbTUZr4jJAlTMbC', 'siswa', '2025-09-01 04:23:50', '2025-09-01 04:23:50'),
(31, 'ANI SUHAENI', '252610030', '$2y$12$3.QAQ75SVO552h0yNNejCuiLaLJc.WFToMwqlESj0Mq1IdZyOLNt.', 'siswa', '2025-09-01 04:23:50', '2025-09-01 04:23:50'),
(32, 'ANITA', '252610031', '$2y$12$y8hTcqBch8nWf.wgp/ZJweAV1o2AvPaXbWpQKQ3nnDLLNLUs5W6eu', 'siswa', '2025-09-01 04:23:50', '2025-09-01 04:23:50'),
(33, 'APRILLIA ANATASYA', '252610032', '$2y$12$dA2styUa6QAg8ccXApkK.OgJeJoxdRLUNLMiPKsgsdhWF70.1YoWa', 'siswa', '2025-09-01 04:23:51', '2025-09-01 04:23:51'),
(34, 'AULIA ISHAQUE', '252610033', '$2y$12$R7C1HfVPbqjfW.iNdScZl.Tpo5rJvPnUo8f/yUBshhRwKKbUB4blm', 'siswa', '2025-09-01 04:23:51', '2025-09-01 04:23:51'),
(35, 'AVRIL AVPRIDA HARIYANA', '252610034', '$2y$12$PiYHmq3h.P8GMU7LrS1uuu77vNwOFMePqhqPkDjtAxdjJOOOZ/XnO', 'siswa', '2025-09-01 04:23:51', '2025-09-01 04:23:51'),
(36, 'CITRA LESTARI ROHIMAH', '252610035', '$2y$12$JQY3w/R3gs8W3LyEgx9LKuAkkJLU7J54QD70cERC3AwG7DN4Z26Ku', 'siswa', '2025-09-01 04:23:51', '2025-09-01 04:23:51'),
(37, 'DINA', '252610036', '$2y$12$UYq3Wq.cdqlx9pUE8Z3KXuZtZQau5Uxs4vtS6UckI1uUiF0jcJLki', 'siswa', '2025-09-01 04:23:52', '2025-09-01 04:23:52'),
(38, 'ENENG JUMARIYAH', '252610037', '$2y$12$VLE/Mm3KeHIOkzFt9dINM.TipJKVHCJr49y3B88nKbLKQoXF8IMhC', 'siswa', '2025-09-01 04:23:52', '2025-09-01 04:23:52'),
(39, 'ENGKOM KOMARIAH', '252610038', '$2y$12$wvMHW1wL.s/dcZF1.CmK/OXDeiiI8y.rJhaF6UhKcFeR6x7IfFFvi', 'siswa', '2025-09-01 04:23:52', '2025-09-01 04:23:52'),
(40, 'HENA ALI', '252610039', '$2y$12$uHd13nwrK5GdKDsVnjtJ1uFFASYs8b0dp1CCOxW/q3XtZdM93h/.i', 'siswa', '2025-09-01 04:23:52', '2025-09-01 04:23:52'),
(41, 'JIHAN ANNASTASYA', '252610040', '$2y$12$0OXDaljghyoYqXfqvuTWS.dVo2hVHr5Kphz9/o0JBC/ASZ5/Ovbse', 'siswa', '2025-09-01 04:23:53', '2025-09-01 04:23:53'),
(42, 'KURNIA HANAPIAH ISWANDI', '252610041', '$2y$12$Oql0dtBXprO52ialHW4fROyatX2GsMGi0RzDgLPa8A2mwzXc.uMPa', 'siswa', '2025-09-01 04:23:53', '2025-09-01 04:23:53'),
(43, 'LATIFAH', '252610042', '$2y$12$dd1jIGd1NmGRcOQl69Drauei60y06gm/aGBXhzVZ6Bn7QJ6ePImKO', 'siswa', '2025-09-01 04:23:53', '2025-09-01 04:23:53'),
(44, 'NASYA MAHARANI', '252610043', '$2y$12$L3Knsabe0Qd4D3svt60ixeo9cQyGVlweVtvrqVOQyORC8Fl2QMl0i', 'siswa', '2025-09-01 04:23:54', '2025-09-01 04:23:54'),
(45, 'NUR ALBIAH SALWA', '252610044', '$2y$12$yWI1hvSaL2/M5E5PPyHKUO0aLK5NGj2iyf0fyhjGKoOA8tvxMYhwG', 'siswa', '2025-09-01 04:23:54', '2025-09-01 04:23:54'),
(46, 'NUR SIFA ANGGAENI', '252610045', '$2y$12$h6gY3MngvEbMIJOtMx/I5uS4bzI/y3uDfLKphKyWpnf6afK7EqNSO', 'siswa', '2025-09-01 04:23:54', '2025-09-01 04:23:54'),
(47, 'PUTRI SASKIA', '252610046', '$2y$12$lMFwqO6rLSuEhHjjyWrsxuPvaFcVU0jg5sOUmFEWOQXEt0C1SQ0EG', 'siswa', '2025-09-01 04:23:54', '2025-09-01 04:23:54'),
(48, 'RAHMA YANTI', '252610047', '$2y$12$/BAgOXhBSSX9lrNnLmBDIuwtEAQ4OYcKmLb4JOUd/9j0f.SDoEJ6a', 'siswa', '2025-09-01 04:23:55', '2025-09-01 04:23:55'),
(49, 'RANI AMELIA', '252610048', '$2y$12$YY7OVCTeMQjkz9TQkHdiSucvlmx8wn6/mBDzn1m2rgMefBo50wrji', 'siswa', '2025-09-01 04:23:55', '2025-09-01 04:23:55'),
(50, 'SAHAR SYAFITRI', '252610049', '$2y$12$Go02JmE3eyXIhEwC73Can.ffgDejU4YcGi6zEcoFHj1hzWgoS4Hgu', 'siswa', '2025-09-01 04:23:55', '2025-09-01 04:23:55'),
(51, 'SALSA BILA AZZAHRA', '252610050', '$2y$12$5qWoXKr0Ytx/KAVUjBdKqudrGZ/axxPHQBN.vsliGJmglJonfCTuG', 'siswa', '2025-09-01 04:23:55', '2025-09-01 04:23:55'),
(52, 'SHIFA ADELIA MAWAR', '252610051', '$2y$12$VzF3NEejIxvTgjAHx9WuieAfGLwTGHO2a/xPupMH8AZb1EDMnQtlS', 'siswa', '2025-09-01 04:23:56', '2025-09-01 04:23:56'),
(53, 'SINTA SUTIA', '252610052', '$2y$12$19qSEj8sPhSwPlsHZM4sk.SlX1eplwKv8AWOx2OXCCcQw.RtGsThy', 'siswa', '2025-09-01 04:23:56', '2025-09-01 04:23:56'),
(54, 'SITI NURZAHRA', '252610053', '$2y$12$3WDCwxumK11oaXfn9xyIYu5N82PEoI5rbtepYvu4c6N8lGQI7GPHW', 'siswa', '2025-09-01 04:23:56', '2025-09-01 04:23:56'),
(55, 'SITI ROMLAH', '252610054', '$2y$12$04NzOVfZ1cLaMSy5bbfnPe/Fe6BkYDW2oXYiPfarNrVvoFRWd7bmi', 'siswa', '2025-09-01 04:23:56', '2025-09-01 04:23:56'),
(56, 'TANIA OKTAVIANI', '252610055', '$2y$12$pjF7FJUvkKQbm6iU4VQtlegd0ga3imQ1RIn6ATGJw6tT5ICjNSY/e', 'siswa', '2025-09-01 04:23:57', '2025-09-01 04:23:57'),
(57, 'WINDI ALTIYAH', '252610056', '$2y$12$.TzWfmeHhDaVFhbnf/wRSuLskWWCzsyZlRpIfy.DkdLZdq/WWIcCy', 'siswa', '2025-09-01 04:23:57', '2025-09-01 04:23:57'),
(58, 'ABU HAMAD MASKURI', '252610057', '$2y$12$LvsT.OFRpIpXR0HjmCwK0OcbglBfWHrbkuQXjbuG2seYfUDLteOBe', 'siswa', '2025-09-01 04:23:57', '2025-09-01 04:23:57'),
(59, 'ADE IRWANSYAH', '252610058', '$2y$12$HKYMTDdF1UUfLPyLkJqIkOcaOKDmncawk3zXpZQaChlN/AmLcD9Ya', 'siswa', '2025-09-01 04:23:58', '2025-09-01 04:23:58'),
(60, 'ALDO SUTISNA', '252610059', '$2y$12$.URv27K.IdM3v.SuRA5hHej0qJH5iltRkVvxPz2swSIIZk8oHpRCm', 'siswa', '2025-09-01 04:23:58', '2025-09-01 04:23:58'),
(61, 'ANDIKA PAJAR MAHDI', '252610060', '$2y$12$/be2BZIIIXW0gAbBoL3/JebeVyqOxDFUrUYpKMEaN1RBbhe.HN98q', 'siswa', '2025-09-01 04:23:58', '2025-09-01 04:23:58'),
(62, 'ANDINI ANGGRAENI', '252610061', '$2y$12$nLcZ286Ip7jIAUy7qlahbekYo8BNQ.xFAOLQfmvHRnQUp.1XUXxAa', 'siswa', '2025-09-01 04:23:58', '2025-09-01 04:23:58'),
(63, 'BAGAS ARDIWINATA', '252610062', '$2y$12$rI2oH3ejNAnwXCWRiMhTZ.YOSmkeubKJi9VORdljz.m6JT24AoELi', 'siswa', '2025-09-01 04:23:59', '2025-09-01 04:23:59'),
(64, 'CHIKA SIPA ANGGITA', '252610063', '$2y$12$WqNbb4RIqbBPOndyA1GqMeMQz9t4jFapAYcYWDMERKiKQaRBEKvZC', 'siswa', '2025-09-01 04:23:59', '2025-09-01 04:23:59'),
(65, 'DANI SETIAWAN', '252610064', '$2y$12$z3Wp3WbDxlOMV75bBSANouv.47EcFq8na1q.oyS6UpdOMO8AhN9lq', 'siswa', '2025-09-01 04:23:59', '2025-09-01 04:23:59'),
(66, 'DANI SUTISNA', '252610065', '$2y$12$E0nBU2C2EvoTHeWJdmrUfuyCf..ZBnN09RdAxwNpTqr2kO9az3Ypa', 'siswa', '2025-09-01 04:24:00', '2025-09-01 04:24:00'),
(67, 'DANIA OKTAVIA', '252610066', '$2y$12$B97/vtrunFAbFpIclZMKQuBgiFgBYb16LrOYq.CeVi0XBSqHMzIMm', 'siswa', '2025-09-01 04:24:00', '2025-09-01 04:24:00'),
(68, 'DIMAS AHMAD RAMADAN', '252610067', '$2y$12$RHi2ZW5ocvsQZEzDd6CaXObKihFfQcHuvJOSyaTZdEFsRIM12hyiq', 'siswa', '2025-09-01 04:24:00', '2025-09-01 04:24:00'),
(69, 'DIRLY ANGGADITA', '252610068', '$2y$12$e/we6kGwEwps0C8Q74RxfOQ4Nz2Nkotk4Rr91AUDCP5tG4MJ31sG.', 'siswa', '2025-09-01 04:24:00', '2025-09-01 04:24:00'),
(70, 'EDI SETIA GUNAWAN', '252610069', '$2y$12$lm8nvDh9hnW1DUcZGu3AiOLu.XQZgS4A15exPHwGFHYB1lnpYh1mO', 'siswa', '2025-09-01 04:24:01', '2025-09-01 04:24:01'),
(71, 'EKA BAMBANG SAPUTRA', '252610070', '$2y$12$vG4f0kkSxf27QMbfJDpCMegRnhZBYR6u16V4rt33t80sGeX0v2Dx2', 'siswa', '2025-09-01 04:24:01', '2025-09-01 04:24:01'),
(72, 'ENDRIK PURNAMA', '252610071', '$2y$12$nM8wSApMU2efwPpIaAspRuKTPtarkhbF4SMY9KG.zuavTSA0flFte', 'siswa', '2025-09-01 04:24:01', '2025-09-01 04:24:01'),
(73, 'HERMANSYAH', '252610072', '$2y$12$GsHN7jfMHjKpxJn/LJ9F.u8VA07ZI.KaNK/Zwo3Ti9EtArjwKgaCu', 'siswa', '2025-09-01 04:24:01', '2025-09-01 04:24:01'),
(74, 'HIDAYATULLAH', '252610073', '$2y$12$VERGEB0gVKkO4jRGpbSZtu7gaaU84mYLCUaa2KHaHZzu1sBX2Bk8O', 'siswa', '2025-09-01 04:24:02', '2025-09-01 04:24:02'),
(75, 'JAEN', '252610074', '$2y$12$Lvy5e5dqAab/nZzeO.OWj.zKjTsbqaJUaC0MORzMSbJOuRKkgSMIO', 'siswa', '2025-09-01 04:24:02', '2025-09-01 04:24:02'),
(76, 'JULIYANTO', '252610075', '$2y$12$N9Lr32Q1uA5rhogs3PHb3OmayIFMAej1AFe9R2RiDQaXugDdFylQu', 'siswa', '2025-09-01 04:24:02', '2025-09-01 04:24:02'),
(77, 'MIFTAHUL ARIFIN', '252610076', '$2y$12$D9VIibROzIS9V4MO/r5UO.iM12Hx53874UYwYPoPTxFHnLtv3SUAS', 'siswa', '2025-09-01 04:24:02', '2025-09-01 04:24:02'),
(78, 'MIT F FELIX GUSNA', '252610077', '$2y$12$dQ7H1XEcDY118n0FKK0XJOSlIObvKW7BJbzFC3.GCCB3wITyITFPa', 'siswa', '2025-09-01 04:24:03', '2025-09-01 04:24:03'),
(79, 'MUHAMAD MUHIBIN', '252610078', '$2y$12$ChE38xmz/I9Aqys.XemyG.16tdLZA4028IMrejpAwhCEeqGYS3lo6', 'siswa', '2025-09-01 04:24:03', '2025-09-01 04:24:03'),
(80, 'MUHAMAD RADITIYA', '252610079', '$2y$12$5x2YO46CUpvFDJgk165PBOUurLhpMeDTbyOWgUGSUQ5r2n.eBdZ5e', 'siswa', '2025-09-01 04:24:03', '2025-09-01 04:24:03'),
(81, 'MUHAMAD RIZKI BAEHAKI', '252610080', '$2y$12$3q5BI/TFj8layqCezlsO9.aawZhI4cZoTh7l5ZTZFLo0dGDn0/C.C', 'siswa', '2025-09-01 04:24:03', '2025-09-01 04:24:03'),
(82, 'MUHAMAD RIZKY HABIBI', '252610081', '$2y$12$m7vQtqUtCJrKoCg3D.HUsOzitS8FcxkSv5ycQtz1ul3OCGz.1wNGi', 'siswa', '2025-09-01 04:24:04', '2025-09-01 04:24:04'),
(83, 'MUHAMMAD AL ISRA FIRMANSYAH', '252610082', '$2y$12$ONct5I3CTtDU8qMsv.jjweigPK91jsVZpfldpB3GH8ynVr7LZu2qC', 'siswa', '2025-09-01 04:24:04', '2025-09-01 04:24:04'),
(84, 'MUHAMMAD FARHAN ADI PUTRA', '252610083', '$2y$12$xtk0lpXoKgn9cQTj0iRyfeKga4gmpCgicIlYp0WQF7mJwsbkU/yru', 'siswa', '2025-09-01 04:24:04', '2025-09-01 04:24:04'),
(85, 'RIFALDI JULIANSYAH', '252610084', '$2y$12$KrGtAEIkaxOqKgfoLB4xvODGPedH6ISOYjgA28o7FJIz7wsly.H1m', 'siswa', '2025-09-01 04:24:05', '2025-09-01 04:24:05'),
(86, 'RINDI', '252610085', '$2y$12$Qpw3gzTj9A7HW3fQ2Xpb..07sIHIcUY8YbScKlOsIi09kpuAKyAEq', 'siswa', '2025-09-01 04:24:05', '2025-09-01 04:24:05'),
(87, 'RISFI HIDAYAT', '252610086', '$2y$12$/AueXSU3W5U9/5xAj..WvOnV1cdbVGmDsZfBFeuzlXLxINHRmg.Ca', 'siswa', '2025-09-01 04:24:05', '2025-09-01 04:24:05'),
(88, 'TAOPIK HIDAYAH', '252610087', '$2y$12$mbsN9zWokn.QIVUnpU7OEOKWfQuZ2hr4MTeTmDJ28IlMV4LcVAW0S', 'siswa', '2025-09-01 04:24:05', '2025-09-01 04:24:05'),
(89, 'WISNU HASLAN FARID', '252610088', '$2y$12$v.8ztDX8PuXp2G.PVhmf1ewhR9kANluMFwaCEpt15YpFPcJsYExW.', 'siswa', '2025-09-01 04:24:06', '2025-09-01 04:24:06'),
(90, 'YOMI ABDUL MANAH', '252610089', '$2y$12$aUNaz5td3NfQ5VDT0.VPT.1NxKyuh.22XIdGVSOy3LFjQoseQWtym', 'siswa', '2025-09-01 04:24:06', '2025-09-01 04:24:06'),
(91, 'ZAKI IBNU KHAIRI', '252610090', '$2y$12$8rN7eAANPK.CWhK4H/nvbut8bJ4SJX4wBKTl8Pzly3YO27xbs.3U.', 'siswa', '2025-09-01 04:24:06', '2025-09-01 04:24:06'),
(92, 'ABDUL LATIF', '252610091', '$2y$12$EGKO6Z9Z3KFGDf05TCnoIum4xvARLZqifVuK3IO1r9BO1jjwHO0hi', 'siswa', '2025-09-01 04:24:06', '2025-09-01 04:24:06'),
(93, 'ADE IRFAN', '252610092', '$2y$12$4qf/OqHvf5vqbXYkLe.eueuz5k66v6.3OHmKPEgmuKSZ.8coD0CH2', 'siswa', '2025-09-01 04:24:07', '2025-09-01 04:24:07'),
(94, 'ADE KRISYANTO', '252610093', '$2y$12$l.naECIIBaEgMh6UvvkIVOAuZaKxlx2AMm3BTr2gygxZxPEK6h7Ee', 'siswa', '2025-09-01 04:24:07', '2025-09-01 04:24:07'),
(95, 'ADITIA SIMATUPANG', '252610094', '$2y$12$WLUGKOZRnmQDgMfb5oqLUOQeuvXacv0kj4QirYvgOgpJaPUSajnKO', 'siswa', '2025-09-01 04:24:07', '2025-09-01 04:24:07'),
(96, 'AHMAD FAUZAN', '252610095', '$2y$12$j7pckUh2YUy1wjPz6tPDVetTWCvoecfNim7nMEYt4oD6IV5a9SkCi', 'siswa', '2025-09-01 04:24:08', '2025-09-01 04:24:08'),
(97, 'AHMAD FAUZI', '252610096', '$2y$12$laX/nqOnw0mmNveRZCr0hefvje9ldQMb.otin2o/4wqinpTLmSXMW', 'siswa', '2025-09-01 04:24:08', '2025-09-01 04:24:08'),
(98, 'AKBAR JUNIARDI', '252610097', '$2y$12$brycUxd4AYABFI548BF.duxhh16Prakf7UGlxmVdaCLLose0UaDc2', 'siswa', '2025-09-01 04:24:08', '2025-09-01 04:24:08'),
(99, 'ALDI', '252610098', '$2y$12$vjqCUWbdQFVUP6e3tc4w4uC6DXDgquujPvx3Fa5vnpnOezXgHNiUq', 'siswa', '2025-09-01 04:24:08', '2025-09-01 04:24:08'),
(100, 'BUNGA IRMA REFALIA', '252610099', '$2y$12$cUQuA2bQwl0bS0EoiwxRBewJfu66dyBNbSKR8JhHxLk5WhjQ85FKa', 'siswa', '2025-09-01 04:24:09', '2025-09-01 04:24:09'),
(101, 'DENIS', '252610100', '$2y$12$Jco28tUwDOcmiPocLBDZfeO4q8TYG.XYTtU7hP7n/kb2U1VoOFcim', 'siswa', '2025-09-01 04:24:09', '2025-09-01 04:24:09'),
(102, 'DIDI FIRJATULLOH FADIB', '252610101', '$2y$12$tuu0eEARO42PL87eUrhnEOWOMZSSohYYOOUWhHLDlGUAMcRQALPCO', 'siswa', '2025-09-01 04:24:09', '2025-09-01 04:24:09'),
(103, 'DIMAS HAFIDDUDIN', '252610102', '$2y$12$WHlJxv8vIraLgZ9fNmXiPOMeMt8sxWDGpR.bc0IhbOdj.lFvPvF4q', 'siswa', '2025-09-01 04:24:10', '2025-09-01 04:24:10'),
(104, 'DINI AMELIA PUTRI', '252610103', '$2y$12$V6bC9av7oK4jW5qA4sLGPu/tVCKbNytRo8zWqp3eWZFpi0E10ck3u', 'siswa', '2025-09-01 04:24:10', '2025-09-01 04:24:10'),
(105, 'ENJELIKA APRIDA', '252610104', '$2y$12$3mipXPNiryMqxKPvthIE9u18tKFiWsOV4.2V8fd6igJ4LecRqXPqm', 'siswa', '2025-09-01 04:24:10', '2025-09-01 04:24:10'),
(106, 'FAISAL AKBAR', '252610105', '$2y$12$y4u1Z3jK78Pr0NIvq7Ark.e0asBU5eahsV7W1ec2E23KXAoQLmE4K', 'siswa', '2025-09-01 04:24:11', '2025-09-01 04:24:11'),
(107, 'GIAN JANU PANDU SAPUTRA', '252610106', '$2y$12$9M0WyG0RVzgg.4id346QKOQnMC4T2tSoKxyB7CEfl4.4c7iEb1Bji', 'siswa', '2025-09-01 04:24:11', '2025-09-01 04:24:11'),
(108, 'HAFID JULIANA', '252610107', '$2y$12$Kyc3orj/Ahth06Ir8ymNZe4myae15Oh.N4hkTevAMsIVDDbfs/jgm', 'siswa', '2025-09-01 04:24:11', '2025-09-01 04:24:11'),
(109, 'IQBAL ALBIANSYAH', '252610108', '$2y$12$D17slgmtcQ/lho6l3xbANOOKV84NUTrjDdGWAalSChSZ1hEEXgchi', 'siswa', '2025-09-01 04:24:11', '2025-09-01 04:24:11'),
(110, 'IRWAN SAPUTRA', '252610109', '$2y$12$8JbgOqQMiwaZD1fujvvEqul3.juXU8gnOR2HsQf9sykeBJOh0kPJi', 'siswa', '2025-09-01 04:24:12', '2025-09-01 04:24:12'),
(111, 'MUHAMAD FAZRI', '252610110', '$2y$12$Q5CgaueExfQ5zh5d7izFju8XqYB.RnsL40CmlF6pTI21hkmsl68n6', 'siswa', '2025-09-01 04:24:12', '2025-09-01 04:24:12'),
(112, 'MUHAMAD HUSAIN HAFIZHULLAH', '252610111', '$2y$12$W16rpGwyjjK2uQsaayvSq.yDjhgNVeURDdtG7fWz5jxyS5jy1Jk9C', 'siswa', '2025-09-01 04:24:12', '2025-09-01 04:24:12'),
(113, 'MUHAMAD SOLEH ALFIKRI', '252610112', '$2y$12$p69zpsahzH.Aha/JcjZH8OCn29ONbPA08/FXCRC/j3iL1TDiNszU.', 'siswa', '2025-09-01 04:24:13', '2025-09-01 04:24:13'),
(114, 'MUHAMMAD REFAN REPIS', '252610113', '$2y$12$UqEyVXfzjcmWslq47V8uNepcANCQ43gVXazBGymkmQYEZkoF1oQ.S', 'siswa', '2025-09-01 04:24:13', '2025-09-01 04:24:13'),
(115, 'NIZAR NASIHUDIN', '252610114', '$2y$12$A4sLmEHv5QuFmI71dv1CjOfA5DMJ3WCZmZ2LF39K8gTygOpnYoORC', 'siswa', '2025-09-01 04:24:13', '2025-09-01 04:24:13'),
(116, 'RAHMAT MURTI UMAY PUTRA', '252610115', '$2y$12$kO6kf.ETRBcrn.500D.7lOcyWlwvXxKoZkYAavzO1MWGiIzSJBA6i', 'siswa', '2025-09-01 04:24:14', '2025-09-01 04:24:14'),
(117, 'REYHAN ABIDIN', '252610116', '$2y$12$eaHUN0dAu4Hkn3vprKmeG.1vAMgqkPPg6CkTheNxeSqRWUEi2pWbO', 'siswa', '2025-09-01 04:24:14', '2025-09-01 04:24:14'),
(118, 'REZA ARDIANSAH', '252610117', '$2y$12$oxGaVk4qBVM1dL140xYMtufA9zS2Y98X.9cx02zHPgYgN1ewPWHGe', 'siswa', '2025-09-01 04:24:14', '2025-09-01 04:24:14'),
(119, 'RHEDY AFRILIANS NUGRAHA', '252610118', '$2y$12$vURSnucFbG5zda3xJWmjzu40sQ1a.Ljq5F7pGQ6MTrric1kPOovl6', 'siswa', '2025-09-01 04:24:14', '2025-09-01 04:24:14'),
(120, 'ROSALINDA', '252610119', '$2y$12$lkqVTHyuZWr4rhx5KMYk0emrl7i3qPxUimI/1psrplKY.Y1FbQX5e', 'siswa', '2025-09-01 04:24:15', '2025-09-01 04:24:15'),
(121, 'SITI MARYAM', '252610120', '$2y$12$Ku01dgfl1WIBOPTG1HpHPO1xo6mYKwONLPezP2LjQLKrnzJT6Pwc6', 'siswa', '2025-09-01 04:24:15', '2025-09-01 04:24:15'),
(122, 'SITI PAIDAH', '252610121', '$2y$12$Hp3gcRBwoLHYFpro.w2IreyGX8y9vf6jm/JL7dc6o0tjqMJH6LhVS', 'siswa', '2025-09-01 04:24:15', '2025-09-01 04:24:15'),
(123, 'SRI LESTARI', '252610122', '$2y$12$sQoRd0xIhmR7uz3IaHomB.FPGLFBL0YEhket7I6sxYieLWiBtYiIG', 'siswa', '2025-09-01 04:24:16', '2025-09-01 04:24:16'),
(124, 'TRYO ABDULGONI', '252610123', '$2y$12$PPIUWVwx30hLV7GQg//ukORyRtwFhmgsAVzN.hG3s0ZcFyoJZ4YA2', 'siswa', '2025-09-01 04:24:16', '2025-09-01 04:24:16'),
(125, 'TUBAGUS NAWAWI', '252610124', '$2y$12$AeuJ3Zxw9NSpYsv4ranNAOYHoCuVVBooSjVYQ26.0aWxpQVmfsBr6', 'siswa', '2025-09-01 04:24:16', '2025-09-01 04:24:16'),
(126, 'AHLIS ARFA NAOZA', '252610125', '$2y$12$VoN2eCrYEDxCzRkjOwQxU.YjmCv.CoMsQoN7QSg.n1a/F9ybA7JXy', 'siswa', '2025-09-01 04:24:16', '2025-09-01 04:24:16'),
(127, 'AHMAD FAUZI', '252610126', '$2y$12$p3HkDud/eF3EkrEv9Tlcje7juc808vSv38IwbQilxvq9nsoju2ML2', 'siswa', '2025-09-01 04:24:17', '2025-09-01 04:24:17'),
(128, 'AHMAD RIDWAN', '252610127', '$2y$12$BDNF4Vsyy9g31wf4kAHJueMRw2MYstu.STNt/KbtFvebdELjI7ZgS', 'siswa', '2025-09-01 04:24:17', '2025-09-01 04:24:17'),
(129, 'AHMAD RIFAI', '252610128', '$2y$12$wUeX3xFoSAJdD/K7UzDtn.gzqSJsZ8EC4GSh0t.2RwhJ/JeQLItVm', 'siswa', '2025-09-01 04:24:17', '2025-09-01 04:24:17'),
(130, 'AKBAR MAULIANSYACH', '252610129', '$2y$12$BDYCaeuKYBM/VUImgVYQ/umY7Oqgxc2uwRAVUHXk/I97oOqQjfFJa', 'siswa', '2025-09-01 04:24:17', '2025-09-01 04:24:17'),
(131, 'ANDINI', '252610130', '$2y$12$g0XE0oEAbssPtSzzVm.iCueoZBYREhVFk.H7t8HhHK3EBqqnD76ny', 'siswa', '2025-09-01 04:24:18', '2025-09-01 04:24:18'),
(132, 'AYU ADIRA', '252610131', '$2y$12$unevR3zhXNH4Xv1Zi8uhGO3hso2FECaYaIKJzUgTPoMcnER/Ssw2m', 'siswa', '2025-09-01 04:24:18', '2025-09-01 04:24:18'),
(133, 'CANDRA MAULANA', '252610132', '$2y$12$L2My6UE2/.QNO.zD0Xra5OHZ.WLsmJju1tOQx.Id1gKTfM.voYjbS', 'siswa', '2025-09-01 04:24:18', '2025-09-01 04:24:18'),
(134, 'CIKAL ERLANGGA', '252610133', '$2y$12$aS8BXCLzfrRbmtnQtn1jC.VQBNQaEj2J7aLaQB0cSCf8Lo.Ot38cK', 'siswa', '2025-09-01 04:24:18', '2025-09-01 04:24:18'),
(135, 'DENI RIZKY PRATAMA', '252610134', '$2y$12$qDfRgX4bIPq5sMU1jLzIvOYJ4SbqIMMPtdZ6JFVpLcOI5GjBxfK9q', 'siswa', '2025-09-01 04:24:19', '2025-09-01 04:24:19'),
(136, 'FAHRI ALIF FADILLAH', '252610135', '$2y$12$lIXcMhyR0PD56sj7Cz5UyuHtUhrCvGz4azvS6x/vGYT9fwZH7ZuKi', 'siswa', '2025-09-01 04:24:19', '2025-09-01 04:24:19'),
(137, 'GALANG RAMDANI', '252610136', '$2y$12$mt8ij4Vaz/Wx3eV5xbkoIOg9DwfBMCnLzwHm8Ygnhq0QPjiGAuF4y', 'siswa', '2025-09-01 04:24:19', '2025-09-01 04:24:19'),
(138, 'HADID SWARA GUMILANG', '252610137', '$2y$12$akVfaF0Clv4UArBO.dm9wOlD6jk/pKBJFvKzC5nf.eLHszV/pgGUa', 'siswa', '2025-09-01 04:24:20', '2025-09-01 04:24:20'),
(139, 'KARTIKA SARI', '252610138', '$2y$12$0lVwy6FtC8WndGhpVi3ljubrd0XtV.5lA.579qFAgvNm34rx3S5bW', 'siswa', '2025-09-01 04:24:20', '2025-09-01 04:24:20'),
(140, 'MARSHALL MILANIZT STILL Z', '252610139', '$2y$12$DzLXLNEd7AxoGlqE7.GG7ewYYXhF9.FtdCRrWzPp3jNnAmtUuiBsK', 'siswa', '2025-09-01 04:24:20', '2025-09-01 04:24:20'),
(141, 'MEISYA EUIS SADIAH', '252610140', '$2y$12$/qGXrUT/evj10tOWEo.uI.LAxp.Ao/CztTVYV9KHbOgmwcDYPeT36', 'siswa', '2025-09-01 04:24:20', '2025-09-01 04:24:20'),
(142, 'MOHAMMAD ZEYAD', '252610141', '$2y$12$BPgAPyOrKKUsuqKF.U6R3.SbrUPqaCul2iQ8hyPmtNL3e7rH92/fq', 'siswa', '2025-09-01 04:24:21', '2025-09-01 04:24:21'),
(143, 'MUHAMAD FARHAN', '252610142', '$2y$12$wMx.hCpCgP3V4FhAEq3TJu1egvnwGDRSTjRTKKP7mbmxrl1uil/VW', 'siswa', '2025-09-01 04:24:21', '2025-09-01 04:24:21'),
(144, 'MUHAMAD IRFAN MAULANA', '252610143', '$2y$12$aztX6MhYY48mQPf60qV9muzE.nBj3Umlu9DsiGb3gmNmfayS8Nva2', 'siswa', '2025-09-01 04:24:21', '2025-09-01 04:24:21'),
(145, 'MUHAMAD JIHAD ILMA ATTAMIMI', '252610144', '$2y$12$cJyeRcawgIqfXqUfISvsuOjb65NGKaEbj/i7UhfL48KHEgE7f5Pqy', 'siswa', '2025-09-01 04:24:21', '2025-09-01 04:24:21'),
(146, 'MUHAMAD RIZKI', '252610145', '$2y$12$MKbJnkNTpZTew93Q/jg38eWHQZTpy4mdqus5A6DJ7MgRJGG16PdOO', 'siswa', '2025-09-01 04:24:22', '2025-09-01 04:24:22'),
(147, 'MUHAMMAD ZAELANI', '252610146', '$2y$12$H9PXmB6ruE1iusC/xPSXcuRoKsDhA17FC0jCO5pnR7n88.yuSjiUm', 'siswa', '2025-09-01 04:24:22', '2025-09-01 04:24:22'),
(148, 'NURJATI', '252610147', '$2y$12$VOKbq6HRVhzV9Ql4dKb6CuOcdtSAMFblqB92PnT.g6DJhTM2bdzEm', 'siswa', '2025-09-01 04:24:22', '2025-09-01 04:24:22'),
(149, 'RAMADAN', '252610148', '$2y$12$.Z52haVp.BqLUz1qcMA7rOD/JWbRYvSNZxCK15DJKGwmj5EoPB8LC', 'siswa', '2025-09-01 04:24:23', '2025-09-01 04:24:23'),
(150, 'RIFQI QHAIRUL HASAN', '252610149', '$2y$12$ft51f.via7TxaQF.wNKh7OP8H5gffdo0E2xtViM3G4tlX9hnJ1MNG', 'siswa', '2025-09-01 04:24:23', '2025-09-01 04:24:23'),
(151, 'RIZKI NUR AL FAHRI', '252610150', '$2y$12$uSXoiR0HS4e2v2o6s8bep.YQW2kR.QHY1qgPNEgKBvclj/xyZ/9tq', 'siswa', '2025-09-01 04:24:23', '2025-09-01 04:24:23'),
(152, 'SALSA NABILA', '252610151', '$2y$12$tjjwGlm00mlRo5Ww2dKLT.NI7MV/2OLK5iAxaKpP.iE/DJvRsOfGW', 'siswa', '2025-09-01 04:24:23', '2025-09-01 04:24:23'),
(153, 'SITI HASANAH', '252610152', '$2y$12$.zAEeaI5pBA4oQTQ6hxRduFJEjPbRZWeI9awobK3/ComMavj.Iw8i', 'siswa', '2025-09-01 04:24:24', '2025-09-01 04:24:24'),
(154, 'SUHENDRA', '252610153', '$2y$12$2FNS2ifWFXOoKjcZ6Ijoeeq5Gz1pygNAIbUTEKVPnl57JT4mawn6u', 'siswa', '2025-09-01 04:24:24', '2025-09-01 04:24:24'),
(155, 'SUTISNA PRATAMA', '252610154', '$2y$12$q4AzpB9lJp7JRDAtF5FnceJ.lUWWWlEjqqZUOEFVA1Zc0OQLKrRTW', 'siswa', '2025-09-01 04:24:24', '2025-09-01 04:24:24'),
(156, 'TEDI MAULANA', '252610155', '$2y$12$c/hIS9lkPBEn1DlX4FYQhupzyhslVfCOXDhZNcURPMAmRw4VylONG', 'siswa', '2025-09-01 04:24:24', '2025-09-01 04:24:24'),
(157, 'WAHYU SUPRIATNA', '252610156', '$2y$12$aNRLmEYM5cNPj0oeM27Gsev2lzDvgWU02YpVd4n1ojN8fg6tMMfQC', 'siswa', '2025-09-01 04:24:25', '2025-09-01 04:24:25'),
(158, 'WALID FAJAR RAMADHAN', '252610157', '$2y$12$EkXZJkhJunGCu43.WzpdZuWJAxLu9QG09/AmRWqZdiYxJxUE62QVe', 'siswa', '2025-09-01 04:24:25', '2025-09-01 04:24:25'),
(159, 'YUSUP', '252610158', '$2y$12$4SVWNTATB.k7nt5TStaizecGtwNb20DS6U7ERQJsc40QGS6RaEtJK', 'siswa', '2025-09-01 04:24:25', '2025-09-01 04:24:25'),
(160, 'ABDUL FIKRI', '252610159', '$2y$12$0rbyQ4sbdqkOga5NLXU2/ub2y4CBtnFOOpR1Cec94XiUzdag9/qye', 'siswa', '2025-09-01 04:24:25', '2025-09-01 04:24:25'),
(161, 'ADIL ALZULFA', '252610160', '$2y$12$V28pdfgtfwyIkUskFLr9WeFO1Oo75saD2YdckgiyEdd1uJLiSXXJ.', 'siswa', '2025-09-01 04:24:26', '2025-09-01 04:24:26'),
(162, 'AGAM MADANI', '252610161', '$2y$12$TqqO47.tmITj76zlYsIqO.qZ4ZQpMUloNPI1oDJOfKIQu6UUuGtju', 'siswa', '2025-09-01 04:24:26', '2025-09-01 04:24:26'),
(163, 'AGUS SAPUTRA', '252610162', '$2y$12$JG1MY9y7JMAPjrOCepIdu.hX7OcB1yGzoYOu.BRUoObjBYSAGxc5K', 'siswa', '2025-09-01 04:24:26', '2025-09-01 04:24:26'),
(164, 'AHMAD AZMI KHOERUNNIZAR', '252610163', '$2y$12$Y8JpwKyWdm0n/N5ELOhcheimMC1cdDar2V5QeO85njKqeSkOvQIR6', 'siswa', '2025-09-01 04:24:27', '2025-09-01 04:24:27'),
(165, 'AHMAD RIZKY KURNIAWAN', '252610164', '$2y$12$.3slMQL6dfi6UZHksOCT5.loAdr6llquSTTgne5cZAmvOJodqWece', 'siswa', '2025-09-01 04:24:27', '2025-09-01 04:24:27'),
(166, 'AHMAD SYAFIQ', '252610165', '$2y$12$EdX.qm1jzwtBmEmCI1XJ9utsZMM00UyoGkEhE.p/NH5v8rZxPGz4u', 'siswa', '2025-09-01 04:24:27', '2025-09-01 04:24:27'),
(167, 'ANGGA MAULANA', '252610166', '$2y$12$vkbWyyjRcYjxiVO3nMQTwuVfdFkEIfnWhLXqq7tkt6zxdF263hIX2', 'siswa', '2025-09-01 04:24:27', '2025-09-01 04:24:27'),
(168, 'DENI KUSMANA', '252610167', '$2y$12$sWCU8JW2w5z.p4VAXFRsMeZy2/ZtCeiPwhHlUERMxQBXb09hEA0zG', 'siswa', '2025-09-01 04:24:28', '2025-09-01 04:24:28'),
(169, 'DIANA RAHAYU', '252610168', '$2y$12$5RU/9tk0tPnyvyrKv4r9zejq830XW1pB4R/5yQo6VuZTKf.ow6tCS', 'siswa', '2025-09-01 04:24:28', '2025-09-01 04:24:28'),
(170, 'EPITASARI', '252610169', '$2y$12$OGOY3sxooYu8IuAyl5rah.LnebrqvdlzXP1ET0wGzJU7iYdjVz9vO', 'siswa', '2025-09-01 04:24:28', '2025-09-01 04:24:28'),
(171, 'FARHANNABIL', '252610170', '$2y$12$EHn8IuphkBC8HP7DcsCyyeHg8q9ztsQPT9NElu6/t8v41jSqi1dxm', 'siswa', '2025-09-01 04:24:28', '2025-09-01 04:24:28'),
(172, 'HABIL NUR ALDIN', '252610171', '$2y$12$xKnfMFyw8OFzhUrA4NzbNOFzAOvbP.GnHjNsxHLwCeW5F4AlQmP0W', 'siswa', '2025-09-01 04:24:29', '2025-09-01 04:24:29'),
(173, 'KARDA PUTRA ADIANSYAH', '252610172', '$2y$12$ePtrl2cIZHKJ5sq.PDQVjOVgsckk9Tu1Hasv.J9ZWXGUPBLLY.MYS', 'siswa', '2025-09-01 04:24:29', '2025-09-01 04:24:29'),
(174, 'MARYONO', '252610173', '$2y$12$BwyLC3pviGR68m5Uu9WsBOxI7XVhC6WdhjgM48bcXk4qAU.X0BfQ2', 'siswa', '2025-09-01 04:24:29', '2025-09-01 04:24:29'),
(175, 'MASITOH NURUL SYIFA', '252610174', '$2y$12$lpAvWXt5EWEcUfCB5KNQ/eQPZLHX2TlN1B1tRU9gPkIrI80LUQRGK', 'siswa', '2025-09-01 04:24:30', '2025-09-01 04:24:30'),
(176, 'MOHAMAD FAJAR ALFAZRY', '252610175', '$2y$12$iPeYWDwkAKWrcNqZuayO8u2ySbAv11Wo7291kmTXrTO7aCg/dnsQS', 'siswa', '2025-09-01 04:24:30', '2025-09-01 04:24:30'),
(177, 'MUHAMAD KHOLBY SAHIH', '252610176', '$2y$12$m1VW6irSRXMp/sNoXQfpTObdZ4XjfmDxFqYr0QffPux.fkrmZaLtS', 'siswa', '2025-09-01 04:24:30', '2025-09-01 04:24:30'),
(178, 'MUHAMAD RIDWAN SAPII', '252610177', '$2y$12$77kv4yGfYLJgtCqe/ZV6r.6tyMBdl3nC4RRMSM24uH7LIl6ARxbI2', 'siswa', '2025-09-01 04:24:30', '2025-09-01 04:24:30'),
(179, 'MUHAMMAD ALDIANSYAH', '252610178', '$2y$12$zkiyeu.kOqo3KGc87G99De3txKQUG5CUOSiWU/36wcgNe5RFUYJ72', 'siswa', '2025-09-01 04:24:31', '2025-09-01 04:24:31'),
(180, 'MUHAMMAD RIDWAN AL KHADAFI', '252610179', '$2y$12$45kpLVAK22ScfQE.OO659uOswJuNgzceJVPPBarDABQaH/sWAbBCW', 'siswa', '2025-09-01 04:24:31', '2025-09-01 04:24:31'),
(181, 'NOVAL MALIKI', '252610180', '$2y$12$8dziNeIZ634vhpN2Au5F6uIgACJ6WwVTAbyvxlZzOyw5IEIQYst/2', 'siswa', '2025-09-01 04:24:31', '2025-09-01 04:24:31'),
(182, 'NURWULAN', '252610181', '$2y$12$vDS6PSneB2Aq6MfjKSDsGOkOwGqDUY2piws0RJwmiUtJlGr85BvrC', 'siswa', '2025-09-01 04:24:31', '2025-09-01 04:24:31'),
(183, 'OBAY SOBARNA', '252610182', '$2y$12$mMJkV1L9BsZFUmujE99zaO/4NTfh5eOvEcFXshOHv0XmPXjJcSZIi', 'siswa', '2025-09-01 04:24:32', '2025-09-01 04:24:32'),
(184, 'PATONAH', '252610183', '$2y$12$t3Nm2b1VynOJ2InouFhB0.MqPAJ5zGB5VUSRLCxZCfYW.aWe1XDhW', 'siswa', '2025-09-01 04:24:32', '2025-09-01 04:24:32'),
(185, 'RAGIL GOJALI', '252610184', '$2y$12$Dnke6RzhqL34wP6BWvunvOAT.3.KUQSxqEz.rv3ev.5ZyWwhHfxy6', 'siswa', '2025-09-01 04:24:32', '2025-09-01 04:24:32'),
(186, 'RAJIF JULIAWAN', '252610185', '$2y$12$NnPsRCAn21f.Su5lnUTxCe0lxwi7PTN18afvejt/mM8vv.Xvbhvlq', 'siswa', '2025-09-01 04:24:32', '2025-09-01 04:24:32'),
(187, 'RIO SUSANTO', '252610186', '$2y$12$jgdJ6uONBYHPdurUxjLekOnn17tzV27FAOr1E/mVMhBeJlRCdgFr2', 'siswa', '2025-09-01 04:24:33', '2025-09-01 04:24:33'),
(188, 'RIZKY RAMDANI', '252610187', '$2y$12$8vy5GEPkxg/8VmmEBvOHje.sQVSZcBz3TJoZWerNGovanfkk1hP3u', 'siswa', '2025-09-01 04:24:33', '2025-09-01 04:24:33'),
(189, 'RUSLAN', '252610188', '$2y$12$b5yiSNdXZ4efZLD6AZIZTe16E3XU.mJAy6XZHe36B0XWeOsyD1Nx6', 'siswa', '2025-09-01 04:24:33', '2025-09-01 04:24:33'),
(190, 'RYAN HIDAYAT', '252610189', '$2y$12$qtBzcgvjGbWSml40je/.rOnzkMH8xFYEJA3bgYqR1tRVGW4s6tAxi', 'siswa', '2025-09-01 04:24:34', '2025-09-01 04:24:34'),
(191, 'TAUPIK UROHMAN', '252610190', '$2y$12$qyeH./NgC/FqebH.THwG3euG2UkgTdOWBsrlm/fA94NmwiPmLkPDW', 'siswa', '2025-09-01 04:24:34', '2025-09-01 04:24:34'),
(192, 'WILLIYANA ADISTIA', '252610191', '$2y$12$8unHQacKB.JHJTZUMCKW3uI5gftTaGYN1yreJh8Zx36qGuAYDOLNe', 'siswa', '2025-09-01 04:24:34', '2025-09-01 04:24:34'),
(193, 'YUSUF RAMADAN', '252610192', '$2y$12$HB03dHxwOxjyQ9kJP5fu/./UEswGmg0xcWmR6.hZ//ov/RC6OZdzK', 'siswa', '2025-09-01 04:24:34', '2025-09-01 04:24:34'),
(194, 'AHMAD GUNAWAN', '252610193', '$2y$12$4V9sPwRxjKlTxf4y99uTxeMFSrjBIctFIcxTw19I6G2S.f0Awo5S6', 'siswa', '2025-09-01 04:24:35', '2025-09-01 04:24:35'),
(195, 'AKBAR ALVIAN', '252610194', '$2y$12$9E18Tc9YPgAWAMBKbUFk8OeUP.2pwszQCQiX551n8CtCVOHm5LvIC', 'siswa', '2025-09-01 04:24:35', '2025-09-01 04:24:35'),
(196, 'AL AZIS MUBAROK', '252610195', '$2y$12$r7Qtz8AkPA7ovwLP3WIdFe9aLq1/N8ue0KjUriCHz4Wk5lonN9oUq', 'siswa', '2025-09-01 04:24:35', '2025-09-01 04:24:35'),
(197, 'ALIF QIZWINI', '252610196', '$2y$12$Y70J1eGiOn6KtXeewU.hJ.UvVjxMdIRsQFOKjRzntpOdkxd1bXgvO', 'siswa', '2025-09-01 04:24:35', '2025-09-01 04:24:35'),
(198, 'CARSADI', '252610197', '$2y$12$znJVVQMWRqzLCHrEkoh9PexpPcy3FKXRfJASf973vGgYAdq02ku3i', 'siswa', '2025-09-01 04:24:36', '2025-09-01 04:24:36'),
(199, 'CHIKA RAHMAWATI', '252610198', '$2y$12$ms9W22dBwZ.T1q2mju8yI.JvtOzQRtX75dRO3k6v9VZi/ie6Rwqau', 'siswa', '2025-09-01 04:24:36', '2025-09-01 04:24:36'),
(200, 'DEFNE MAULLANA EL SYARIF', '252610199', '$2y$12$0UOByEMzkCIw2MZOCgwYKuTS9sPANYnJWMV31ZqNGPIWAimWqXMWW', 'siswa', '2025-09-01 04:24:36', '2025-09-01 04:24:36'),
(201, 'DEVI DESVITASARI', '252610200', '$2y$12$zgY2a/kwuSgHH7nulCSjc.s.SEfh97wK8Vv6ujKtTvvPJdf60hEp2', 'siswa', '2025-09-01 04:24:46', '2025-09-01 04:24:46'),
(202, 'DIKA NANDA', '252610201', '$2y$12$XvL14HqZYmmhpx38HM1Wh.D7rnKj9F.7a6Hz.fcEu1qiVF4knxMHS', 'siswa', '2025-09-01 04:24:46', '2025-09-01 04:24:46'),
(203, 'EKA FEBRIANA', '252610202', '$2y$12$2qIPm5RGgE.HoVMrBhACfuNSW3PV6r22qluJ9xk8dwOhZps.aErWm', 'siswa', '2025-09-01 04:24:46', '2025-09-01 04:24:46'),
(204, 'GALANG FIRMANSYAH', '252610203', '$2y$12$1I/Us0GSGBgMsTaj1/O3TuwvS6yp.xNV9fCWSwBC92srdH3ey5zIW', 'siswa', '2025-09-01 04:24:47', '2025-09-01 04:24:47'),
(205, 'HALIMATU ZAHRA', '252610204', '$2y$12$R9dGVZf77ivWwb8TO1thYuPkVVghqrNvdqQ4SWwSUQlGpxONF1Q1C', 'siswa', '2025-09-01 04:24:47', '2025-09-01 04:24:47'),
(206, 'HASBI ASHIDIQI', '252610205', '$2y$12$XeX2GXsfvr53QUJYyvsQ7umRGiSVfVMNkKdwxJcmFq3dY1Yz0oXem', 'siswa', '2025-09-01 04:24:47', '2025-09-01 04:24:47'),
(207, 'HERDIYAN NUGRAHA', '252610206', '$2y$12$u.G6zonhU0ZBldkpF/EnQe2hTtbw7HAw1emAut6JqRTBKAyuO36Tu', 'siswa', '2025-09-01 04:24:47', '2025-09-01 04:24:47'),
(208, 'JEJE', '252610207', '$2y$12$0Ir9HRGMrOTS5oHijpL7SekRMWMsYHBdDTvPyby9S.0X2CC3.3Ira', 'siswa', '2025-09-01 04:24:48', '2025-09-01 04:24:48'),
(209, 'MARINA F SIMATUPANG', '252610208', '$2y$12$J1xBiNWaobj22XHXHBdp0OuToV5MujBCz2aJyC3CJycMouXHyh1Tq', 'siswa', '2025-09-01 04:24:48', '2025-09-01 04:24:48'),
(210, 'MUHAMAD IHSAN MUBAROK', '252610209', '$2y$12$sSMASt5Gy7chONUh7m/Ue.8GDmMThmPOSGQE92L9pARO92zLcPxVm', 'siswa', '2025-09-01 04:24:48', '2025-09-01 04:24:48'),
(211, 'MUHAMAD IQBAL ALFAQIH', '252610210', '$2y$12$OQIB1m1gw1QmKmLfC9O7MeQMHFKsJvhp33ugXwiTSnnDlIkh7gpt.', 'siswa', '2025-09-01 04:24:48', '2025-09-01 04:24:48'),
(212, 'MUHAMAD KAMAL', '252610211', '$2y$12$ZTiQtLYSWeFAlgmtixmRV.hyFNJl2W1fSBum7AEoxVWlIXUFWpRMq', 'siswa', '2025-09-01 04:24:49', '2025-09-01 04:24:49'),
(213, 'MUHAMAD REHAN', '252610212', '$2y$12$SCusBaFHHlPWusicD539u.btT6uE4/XLqJ6I/Lj5LJVCvhmGlJ3lG', 'siswa', '2025-09-01 04:24:49', '2025-09-01 04:24:49'),
(214, 'MUHAMMAD WAROSATUL AMBIYA', '252610213', '$2y$12$ym1A.cpWVjRxme/pqUdy7eeEQtLrCY1209LFovR8l/pDAQ60vFmem', 'siswa', '2025-09-01 04:24:49', '2025-09-01 04:24:49'),
(215, 'NURFRIAN SYAHRONY', '252610214', '$2y$12$zrMp2grDENwo472dfTSqVu23fq5mVSjwJmFkXfhz.BA6Repvth6ry', 'siswa', '2025-09-01 04:24:49', '2025-09-01 04:24:49'),
(216, 'RAELAN MUTABAROQ', '252610215', '$2y$12$9kGvU7VcFUyHOxuPFHJ25eUoFxKIaPQk68EjIzFLwW37WP2N5hoxe', 'siswa', '2025-09-01 04:24:50', '2025-09-01 04:24:50'),
(217, 'RAMLI', '252610216', '$2y$12$U/reJOiczkMBYu95pf/G7eoQEnlcCz8QfRPVWcjqK.TITaP9SeKA.', 'siswa', '2025-09-01 04:24:50', '2025-09-01 04:24:50'),
(218, 'RIFQIANSAH', '252610217', '$2y$12$pfSW2dFbq/OQkAUrzAN/U.QoVV4kKUxg4/KKitdOWWGxWEQK7ri7.', 'siswa', '2025-09-01 04:24:50', '2025-09-01 04:24:50'),
(219, 'RINTO', '252610218', '$2y$12$ZqKZLkrYu8EMHTBVZAWBceB/X8M/udSA5HUXrlZp/J4fA/S9Cb6ge', 'siswa', '2025-09-01 04:24:51', '2025-09-01 04:24:51'),
(220, 'RISMA', '252610219', '$2y$12$wrSeNkr5eegJJgq14d7lP.zuBqFQiP6mav8w5SMrsjTco87jc4bCO', 'siswa', '2025-09-01 04:24:51', '2025-09-01 04:24:51'),
(221, 'SIVA YULYANTI', '252610220', '$2y$12$rGbtW6cqRG6gZQLMxoIvB.EAXk3Ku8r8aHoO30kBBOPK0LlEV.4se', 'siswa', '2025-09-01 04:24:51', '2025-09-01 04:24:51'),
(222, 'SUHERMAN', '252610221', '$2y$12$8Mv0Sw8dgsEFTo3tUrxnAOGy6jOcUOrTkU2/PwMpLGcL2Usnjz2sK', 'siswa', '2025-09-01 04:24:51', '2025-09-01 04:24:51'),
(223, 'SUNANTA', '252610222', '$2y$12$WK8GmzAx9T3TwIQmvUNYNOdDzLH2uHVSCxbb43q1HcDnIp6PAYhRi', 'siswa', '2025-09-01 04:24:52', '2025-09-01 04:24:52'),
(224, 'SURYANI WIDYA PUTRI', '252610223', '$2y$12$GY2LqndrmVZBxwcnYRI.quwBPh//HORd1BcssPD3CvCZrIskSDjOu', 'siswa', '2025-09-01 04:24:52', '2025-09-01 04:24:52'),
(225, 'ULFIA ANGGIA PUTRI', '252610224', '$2y$12$wxfaqNH5PGO0PlAIvL8FEugJ80WYuW4YBEj80gwDHF8AdQcQ/TahK', 'siswa', '2025-09-01 04:24:52', '2025-09-01 04:24:52'),
(226, 'WARDI', '252610225', '$2y$12$47fzc/UbqpbheS7EFV0cduPbIixRIB.aNuAEw7erffS/Bdf6JmOMO', 'siswa', '2025-09-01 04:24:52', '2025-09-01 04:24:52'),
(227, 'WARDIMAN', '252610226', '$2y$12$C/ZKkenvZUlt2agnlPsrhO8s8IsIrdzSqiTLWqBQcetOT9RjDlePu', 'siswa', '2025-09-01 04:24:53', '2025-09-01 04:24:53'),
(228, 'ZAHRAN MAHESWARI', '252610227', '$2y$12$kNfSR8IeZj77MHX6aeoIGu6YTFiHv5dHYbuCOB7fNs3P21HYh0x86', 'siswa', '2025-09-01 04:24:53', '2025-09-01 04:24:53'),
(229, 'AHMAD RANDIKA', '252610228', '$2y$12$Fp1yg1B8/8V2To96/r6A3.6DlIWlyG6/L0rtCkiUUFFQKD1t2zx3K', 'siswa', '2025-09-01 04:24:53', '2025-09-01 04:24:53'),
(230, 'AHMAD SAEPUDIN', '252610229', '$2y$12$MlVOsxQ.gg.IudMkoJVO3upkmIbNJfpKMpzPA3xb4mdxvYN1S29de', 'siswa', '2025-09-01 04:24:53', '2025-09-01 04:24:53'),
(231, 'AHMAD SOFWAN ISMAIL', '252610230', '$2y$12$CMNW3BCJ9WXL9XhK6hwcBunsUpAKG4jL.CQfDc01wEQ28fgAbN1jK', 'siswa', '2025-09-01 04:24:54', '2025-09-01 04:24:54'),
(232, 'ANDHIKA RAMADHAN', '252610231', '$2y$12$CbaroWTfGFrKkLBHryh8MuneIWa4sKHNLKgll0L59QsSEPcX9StC6', 'siswa', '2025-09-01 04:24:54', '2025-09-01 04:24:54'),
(233, 'ANDIH SAEPUL BAHRI', '252610232', '$2y$12$0dSiZZkjtryZDbz34qMK/edU8nsq.ZTG5hi/TDs4aHQnpsuMbMd1i', 'siswa', '2025-09-01 04:24:54', '2025-09-01 04:24:54'),
(234, 'ANDIKA PRATAMA', '252610233', '$2y$12$fzzoPal5sNxcUg3LhBG5FeMAxNseFWj3nKOKL/LQuDgo3YWAeAyPq', 'siswa', '2025-09-01 04:24:55', '2025-09-01 04:24:55'),
(235, 'ARIYA DARMAWANSYAH', '252610234', '$2y$12$LPZRq/EoQO7mmxRen1dYgOQqgD8Z4aezRMjpgLacxm24tNIf1MhrG', 'siswa', '2025-09-01 04:24:55', '2025-09-01 04:24:55'),
(236, 'ARSYA NUR HARLY HASAN', '252610235', '$2y$12$2D.3Li.x7AlEwGyYq8kkX.ky8754svBzTMJFrEZPqrltWf4c8C7QK', 'siswa', '2025-09-01 04:24:55', '2025-09-01 04:24:55'),
(237, 'BENI KURNIA', '252610236', '$2y$12$ePk.usiDNP6ZMPQPFpmr3eWjyE.B5aPRxWPSV6MIfQa2Dy094pG5S', 'siswa', '2025-09-01 04:24:55', '2025-09-01 04:24:55'),
(238, 'CANDRA AKBAR', '252610237', '$2y$12$UG.R5SWy0WEhnJu7ZWZktuUiz6IYuW/4NgAsoBS5sHQ5lHddXAFgS', 'siswa', '2025-09-01 04:24:56', '2025-09-01 04:24:56'),
(239, 'CINTIA', '252610238', '$2y$12$F5tH5PAnh4QFQWhxdeTd..C7.4qrHXf7SRGSRudQMImbgGnJVZb3q', 'siswa', '2025-09-01 04:24:56', '2025-09-01 04:24:56'),
(240, 'DEWI CUT NADIN', '252610239', '$2y$12$h5TGGxzWLLtIdLP76mHQ..8sz13vfLbr3or1yQ2K5eFm31xuqmq3S', 'siswa', '2025-09-01 04:24:56', '2025-09-01 04:24:56'),
(241, 'DIKA BAEHAKI', '252610240', '$2y$12$hMwPJLX02pyFD1oq5IH6s.TEDwVcmcPOxIYjmKbhg8wqYa4pc5Y1e', 'siswa', '2025-09-01 04:24:56', '2025-09-01 04:24:56'),
(242, 'DIMAS SETO', '252610241', '$2y$12$3WImHQJfmYhUD1y07TpaxuLUztNPV1ELT5wCggnnda55khoq4zBai', 'siswa', '2025-09-01 04:24:57', '2025-09-01 04:24:57'),
(243, 'FAIQ SUGILAR', '252610242', '$2y$12$dizoxdjbKDF7qrdSmPT.O.c0GZLF1Jo/O1RsknoY6rQtyEInVm8Qi', 'siswa', '2025-09-01 04:24:57', '2025-09-01 04:24:57'),
(244, 'FAJRUL MA ANI', '252610243', '$2y$12$9Zi9poJfk2y.5oRzwy0rWuSqv.cRViunQ.9HFLSK12TFsbpvigvuy', 'siswa', '2025-09-01 04:24:57', '2025-09-01 04:24:57'),
(245, 'FUJA SAEPULLOH', '252610244', '$2y$12$Nb1Jb3RO4bJOYES8yRXyK.Xs5s/MIG8RWU6Wt1kqOejFtb54mCVGW', 'siswa', '2025-09-01 04:24:57', '2025-09-01 04:24:57'),
(246, 'HENDI SETIAWAN', '252610245', '$2y$12$3BWGyYgJ0JfRzhyg5TyuHOhweQiVuIdSM/zLmxv1/PCCGu3YwwKhq', 'siswa', '2025-09-01 04:24:58', '2025-09-01 04:24:58'),
(247, 'KARNATA JAYADI NINGRAT', '252610246', '$2y$12$Nn12G67tetH1FHuK5L25deMjZkkEKI4L4ZoxjnBPq2p8CQdDkQtAO', 'siswa', '2025-09-01 04:24:58', '2025-09-01 04:24:58'),
(248, 'MUHAMAD KHAIRUL INIESTA', '252610247', '$2y$12$GdMie34E4z8ZZOqVKKLkEOCvQFgusbHoTQFYPBaZpDBUX3TVK6KtW', 'siswa', '2025-09-01 04:24:58', '2025-09-01 04:24:58'),
(249, 'MUHAMMAD DANIAL ALPIKRI', '252610248', '$2y$12$oaT8bplHUUauLF4s41tOKuwX9oGhbke/QBVRDeDYTUzefFcT74OJO', 'siswa', '2025-09-01 04:24:58', '2025-09-01 04:24:58'),
(250, 'NENENG HABIBAH', '252610249', '$2y$12$vlDPPJFkBoKyZqxQ.QXEduTbCEexvmqyiAN0vOtVr3Xlp8p/Byt3y', 'siswa', '2025-09-01 04:24:59', '2025-09-01 04:24:59'),
(251, 'NOVAL JUNIAN SALEH', '252610250', '$2y$12$XIpfYYUOizMC3grxr.Zyd.NCeMbLy3wpf0L0APTYS7thXwo3FttDO', 'siswa', '2025-09-01 04:24:59', '2025-09-01 04:24:59'),
(252, 'NUAF DHANU WINATA', '252610251', '$2y$12$PPotkXijwyG0b2wwMvdFd.xBA/d06C/yjAz1edpkP0e54EF5arTe6', 'siswa', '2025-09-01 04:24:59', '2025-09-01 04:24:59'),
(253, 'RAIHAN ABDUL YAFIDZ', '252610252', '$2y$12$HlWUYWYbuEQRvh4G.bLNy.5edkJdttTGa.xtcF8GV7rFWz0kZ13T.', 'siswa', '2025-09-01 04:24:59', '2025-09-01 04:24:59'),
(254, 'REIHAN FIRMANSYAH', '252610253', '$2y$12$fAte6XuDSRJ9omNbonJ57.ag4AGghkVoMuSey419kveB9wuAl5Iim', 'siswa', '2025-09-01 04:25:00', '2025-09-01 04:25:00'),
(255, 'RIO RAMA', '252610254', '$2y$12$guvGLgIUUyS7z4wL8YKD8ebR1C5hlhjOPmoHIGONSvlqvZtlmvAL.', 'siswa', '2025-09-01 04:25:00', '2025-09-01 04:25:00'),
(256, 'RITA FITRIA', '252610255', '$2y$12$hkr5bW8pWJZYZRPjRRzoDODWRcn4wJnZjT4Vinlw5S3XW1TZOaNq2', 'siswa', '2025-09-01 04:25:00', '2025-09-01 04:25:00'),
(257, 'ROFIKOH ALIYATUL SUNIAH', '252610256', '$2y$12$mxCy80Z5iG3HLnveF9H//OMQEEfsNUppMxPIQY45sGoMUpkhwVAN6', 'siswa', '2025-09-01 04:25:01', '2025-09-01 04:25:01'),
(258, 'ROSAM CAKRA WINATA', '252610257', '$2y$12$uMo9to4HGLFqkFdYLIRFx.NeE/sOiVxIjh/YTJCRsfBxZ/p/JiOUW', 'siswa', '2025-09-01 04:25:01', '2025-09-01 04:25:01'),
(259, 'SAEFUL GOFAR', '252610258', '$2y$12$qW3on9r9sBtg2QgXyu/pVu37EqulnuWtNsazx1dZmCkrPgpym8vf2', 'siswa', '2025-09-01 04:25:01', '2025-09-01 04:25:01'),
(260, 'SAEPUL MAULANA', '252610259', '$2y$12$FzynSAFyWY.OOHVT7nyQfufG.T075ck.5J.S1xhH/a9iAXS/ZB6bK', 'siswa', '2025-09-01 04:25:01', '2025-09-01 04:25:01'),
(261, 'SETIYAJI AHMAD FAUZI', '252610260', '$2y$12$Q3TzdpYj8HPqAau4XwNoRekaexi4yg.lJX6Nq1Le5vbRPXypGDap6', 'siswa', '2025-09-01 04:25:02', '2025-09-01 04:25:02'),
(262, 'WINDY OCTOVIYA', '252610261', '$2y$12$08TE5dswBpyD5BDUMLHzpOuECAO7YFXLOjZD9Apia2ffp02ISdnoq', 'siswa', '2025-09-01 04:25:02', '2025-09-01 04:25:02'),
(263, 'YUDI ADITIA', '252610262', '$2y$12$ihnPCYUQc4C2eSPiZUYSju57qQfdaPO29Wjx997EV6ygUZCSGXv6u', 'siswa', '2025-09-01 04:25:02', '2025-09-01 04:25:02'),
(264, 'AMELIA', '242510001', '$2y$12$cAwJIcHwFN62YYgemwTEjuN38gbQ.qMz/qJWRzkQLU2a0grF8IjSC', 'siswa', '2025-09-01 04:25:38', '2025-09-01 04:25:38'),
(265, 'ANISA RHAMADANI', '242510002', '$2y$12$eE6Ww5lDf57xcT4hSCE1LOTIq9.ZgysIR0fxS8.pcogaYdcoBk8/u', 'siswa', '2025-09-01 04:25:38', '2025-09-01 04:25:38'),
(266, 'AYU NINGRAT', '242510003', '$2y$12$CBToJg5zOaRcPu5o2kXSFerp.hOPHKYY6soQxUDh1zWPHIypxRXdy', 'siswa', '2025-09-01 04:25:38', '2025-09-01 04:25:38'),
(267, 'CINDI LESTARI', '242510004', '$2y$12$Fs61DMBQO6dC7n/aJhsN5.fUWf1iMXVHvJQWgqo5dM2ncfGUSpBkW', 'siswa', '2025-09-01 04:25:38', '2025-09-01 04:25:38'),
(268, 'CITRA SHABILA IRAWAN', '242510005', '$2y$12$5nBa9SKBuVZpSjGCR.fyfukmWSzuEr9jq.8kkUWDUWjZo.2n94DE2', 'siswa', '2025-09-01 04:25:39', '2025-09-01 04:25:39'),
(269, 'DENITA SARI', '242510006', '$2y$12$GOJGr5lbZ4VdbRKFFJMgSO0pQFHx4mVRV9ZMkIvsksXSgMiw1wQqi', 'siswa', '2025-09-01 04:25:39', '2025-09-01 04:25:39'),
(270, 'EVI NURAENDI', '242510007', '$2y$12$Rmwyxd5D14u9HHleXVkJBOELzoOXRHgADT8hpC3HlQcg89OUaZoIa', 'siswa', '2025-09-01 04:25:39', '2025-09-01 04:25:39'),
(271, 'INTAN LESTARI', '242510008', '$2y$12$11ZYfkZEKSOOjpie4lj4ReNtALyf2Zy96FD.vy7NVN6VKFh13rk/O', 'siswa', '2025-09-01 04:25:39', '2025-09-01 04:25:39'),
(272, 'INTAN RASJI RAMADHANY', '242510009', '$2y$12$GTHaZRp89.b3aPwn4oo8H.PqBsYdeVsjeSIifAtt.CsdcG02lPfjq', 'siswa', '2025-09-01 04:25:40', '2025-09-01 04:25:40'),
(273, 'KARLINA', '242510010', '$2y$12$wwCNf/TIUzaMcH4u.wtL5udJK0jniEHQEnOBMqRZaCmthf9moVI16', 'siswa', '2025-09-01 04:25:40', '2025-09-01 04:25:40'),
(274, 'KURNIA', '242510011', '$2y$12$hC2Ep6VZE.5apUDevMc1qOgFGCNvyfjR6l0Ot5kgNnO5BiO/8c7.i', 'siswa', '2025-09-01 04:25:40', '2025-09-01 04:25:40'),
(275, 'MAHENDRA', '242510012', '$2y$12$DEU/cvGysLGaU4v45BZioO7nSd/TmTYLD2XFEbBNnQKkmSrC7Nwie', 'siswa', '2025-09-01 04:25:41', '2025-09-01 04:25:41'),
(276, 'MARPUAH', '242510013', '$2y$12$dZy7Sx6Iky6FgyiaNaEI2uy1IgWt9DHLOu7mKLv4bEs0HzUGghp32', 'siswa', '2025-09-01 04:25:41', '2025-09-01 04:25:41'),
(277, 'MAULANA ANSORI SURYANA', '242510014', '$2y$12$dt3rfYi7e3dURA2GBF/5F.Hh0IuRFnO/iz1f.FBb/YgMSpllWkFhe', 'siswa', '2025-09-01 04:25:41', '2025-09-01 04:25:41'),
(278, 'MAYLANI', '242510015', '$2y$12$iCRqVRWi7tbtQtgbMzLo5ulqO0gUVgVQk62PAwvKZG5QfdcTbq3le', 'siswa', '2025-09-01 04:25:41', '2025-09-01 04:25:41'),
(279, 'MUHAMAD ADHI SATRIO', '242510016', '$2y$12$svNiM.zw5yKUzTvQW5dBluWRTUCPqPSGtKqjjX0pEGuOczDd5Dnjy', 'siswa', '2025-09-01 04:25:42', '2025-09-01 04:25:42'),
(280, 'NUR SILVA OCTAVIA', '242510017', '$2y$12$dm4zAtOTKJKy9n76uanJW.KvnyDfwjQK2bkNRJ9BefuSYakZJtcUy', 'siswa', '2025-09-01 04:25:42', '2025-09-01 04:25:42'),
(281, 'NURMALA PUSPITASARI', '242510018', '$2y$12$vwQh7qmesHVdMwHbj0H1FuzZmO5lw6brJ8Igp.T7ozWuKHfrg7D3K', 'siswa', '2025-09-01 04:25:42', '2025-09-01 04:25:42'),
(282, 'QORIATUL FITRIYAH', '242510019', '$2y$12$FuPBA5R.rfvlIwRPKoJiJ.XEOfK5rEQ24uKZpV68be8QjYwPaeFgK', 'siswa', '2025-09-01 04:25:42', '2025-09-01 04:25:42'),
(283, 'RAHMA PUSPITASARI', '242510020', '$2y$12$QDHo7sqRAKC.TlOSuEqtw.mhNfP7P0xXqrXr4n1wJMbT5f6XO2cDy', 'siswa', '2025-09-01 04:25:43', '2025-09-01 04:25:43'),
(284, 'RISKA APRILIA', '242510021', '$2y$12$j4ryuuqzNN27F3XtseeB7.rAtuutSb8Firi41WNtUdRXvIdFRu7v2', 'siswa', '2025-09-01 04:25:43', '2025-09-01 04:25:43'),
(285, 'RISMAYANTI', '242510022', '$2y$12$MQtP2VCJAqDqoJmGGjq9C.6okcf83j8aaUJYvHt0pAOmrRtuzV7k.', 'siswa', '2025-09-01 04:25:43', '2025-09-01 04:25:43'),
(286, 'SARAH INDRIYANTI', '242510023', '$2y$12$tmYzHUVFfkSFe5YCBCX4KONxzMLsavXOppl6i6elHHALvYXNc0wE6', 'siswa', '2025-09-01 04:25:43', '2025-09-01 04:25:43'),
(287, 'SITI JAHROTULSYITTA', '242510024', '$2y$12$0Q5gWd5yF4SSKzOA86Rsp.ylUsoTpKL12BJMlQitf/7WQrQXT2ezO', 'siswa', '2025-09-01 04:25:44', '2025-09-01 04:25:44'),
(288, 'SITI NURHASANAH', '242510025', '$2y$12$r.pMZSkwMfbb6Q1qBs3jJOzwmQZ6BE8kgrMjSmy7DnAvsnVoUxsCS', 'siswa', '2025-09-01 04:25:44', '2025-09-01 04:25:44'),
(289, 'SITI NURPADILAH', '242510026', '$2y$12$Z1NHGhFV/EyEE/rDeRkAIO9NcgI209yd2Rp/rLBd4Dwf0wxLFx3Ja', 'siswa', '2025-09-01 04:25:44', '2025-09-01 04:25:44'),
(290, 'SITI SALAMAH', '242510027', '$2y$12$E5eeQtTgf2/PjBQD/tNUjO8GwmezMVG7dC8Gev6fu3LoO1N5ucmTG', 'siswa', '2025-09-01 04:25:45', '2025-09-01 04:25:45'),
(291, 'SITI ZENAB', '242510028', '$2y$12$XkNtXWPz1WbUZrZ5tdCA9OkxqIilOYnKHVxLL4vEWlXGsvaKwgyqq', 'siswa', '2025-09-01 04:25:45', '2025-09-01 04:25:45'),
(292, 'SYAVIRA DWI NOVIANTI', '242510029', '$2y$12$HDeKjSYY4y1XPsB5wcRzz.zjxt0XpTz2aeAL3ZNxrwMem3HKOSkXm', 'siswa', '2025-09-01 04:25:45', '2025-09-01 04:25:45'),
(293, 'SYIFAUDZIHNI', '242510030', '$2y$12$QTxylZTJrSnbcYstXjftK.nOT8JSelEiRXlZvlKBJdm0NDBGuffdK', 'siswa', '2025-09-01 04:25:45', '2025-09-01 04:25:45'),
(294, 'TASYA ANANDA', '242510031', '$2y$12$uNU5jhybMQD4RU.cx4lUbOwejN.l4BKsk1ofitDcQi1FFZqkdol7O', 'siswa', '2025-09-01 04:25:46', '2025-09-01 04:25:46'),
(295, 'TIKA DEWI', '242510032', '$2y$12$N5ibgulFC7hWBwY9fa92KOUeZDXW1zUOtIxDTWdD1.jEkk2kRdb0m', 'siswa', '2025-09-01 04:25:46', '2025-09-01 04:25:46'),
(296, 'WILDA CAHYANI', '242510033', '$2y$12$.4vSxoRYs4Z9fF5woRBZvekPSiQv/0gp9gpFQ48di6ViLcXoP6iki', 'siswa', '2025-09-01 04:25:46', '2025-09-01 04:25:46'),
(297, 'AISAH WALINAYAH', '242510034', '$2y$12$I6lJMdoz7CnVgcWXOInExObSb.7TivRA9WePu66HIkVxk8uxfrVGy', 'siswa', '2025-09-01 04:25:46', '2025-09-01 04:25:46'),
(298, 'ANGGUN DARA CANTIKA', '242510035', '$2y$12$WMR4UHRWiBJEVfw4YA9r1uB2chYsTEpyVBvMNr3mxM4b7E.X2iW.q', 'siswa', '2025-09-01 04:25:47', '2025-09-01 04:25:47'),
(299, 'APRILIANI', '242510036', '$2y$12$vmr4MOW3RD8n0yr1o3zXQuF3NSkU/JmHsCPIHuA7DjH10H2ivReFC', 'siswa', '2025-09-01 04:25:47', '2025-09-01 04:25:47'),
(300, 'ARUM', '242510037', '$2y$12$fElBbkAjpfVPpWUG.rMhpOL/Cu8ZT5Vc32NkmoIB0RVAdprBHIpfa', 'siswa', '2025-09-01 04:25:47', '2025-09-01 04:25:47'),
(301, 'CITRA NURY RAHMAN', '242510038', '$2y$12$J91X6U6G2NKz1WKwLsZMuOhneXymwOsvDxIN7a9Bn60a36UPCcuoW', 'siswa', '2025-09-01 04:25:47', '2025-09-01 04:25:47'),
(302, 'DEDEH FAUZIYAH', '242510039', '$2y$12$ZR2eA.VaD0bZj/GsINjkwOcE1bgpXYgq2CRJYsIVZPtKaKkb.nL4e', 'siswa', '2025-09-01 04:25:48', '2025-09-01 04:25:48'),
(303, 'DEVI YULIANI KUSMANTO', '242510040', '$2y$12$IQ22W5WHVwDkPb/alI14vOXOSB1yLtMlHtmNoZses/LOxD3TtX.IS', 'siswa', '2025-09-01 04:25:48', '2025-09-01 04:25:48'),
(304, 'DINDA LESTARI', '242510041', '$2y$12$4/kezOJtVOXjZbFpd52uQeObWesWJcUgctNT4gg07duCVSjufaBom', 'siswa', '2025-09-01 04:25:48', '2025-09-01 04:25:48'),
(305, 'ERNAWATI', '242510042', '$2y$12$VXLeo3mD37fY6MDQXGyInO.xMHB.LaY1cD.SpQ7ojnhxAym8ASslS', 'siswa', '2025-09-01 04:25:49', '2025-09-01 04:25:49'),
(306, 'INAYAH', '242510043', '$2y$12$aI6AoCJ/xpmDBUxprMjBqO.9NxQJDpaPWANYn9pYIaCyfPkKH0KDa', 'siswa', '2025-09-01 04:25:49', '2025-09-01 04:25:49'),
(307, 'LAILA', '242510044', '$2y$12$iPvxjonnxFENxxbZIt2BIOukB4Th0wE0vVGNGTZehCQ0MPilbUBHq', 'siswa', '2025-09-01 04:25:49', '2025-09-01 04:25:49'),
(308, 'LUTIKA SUNDAWA', '242510045', '$2y$12$xPACDkItzh/nJOjhadfzsusFl5PftqGAidPdZR3cXAyHhAT4GgEfi', 'siswa', '2025-09-01 04:25:49', '2025-09-01 04:25:49'),
(309, 'MAULIDDIVA NAWWAROH', '242510046', '$2y$12$IyoZ4D4KaAyrkAqPVHj64uk/bbjXDkEBjfCnTstVuIsnIrEXVmJ16', 'siswa', '2025-09-01 04:25:50', '2025-09-01 04:25:50'),
(310, 'MAYA MAESAROH', '242510047', '$2y$12$Q5W./ZAOy40MNM04vqYeKeU5pE9nej9fsfwJK8F4eudll4voSOBae', 'siswa', '2025-09-01 04:25:50', '2025-09-01 04:25:50'),
(311, 'MELYANI', '242510048', '$2y$12$9iLnx1WD3Jb85jFsZ5WT8OjuUbGrAoIyVwjgY6jWZCVqaghxqFday', 'siswa', '2025-09-01 04:25:50', '2025-09-01 04:25:50'),
(312, 'MIA BIATUL QOYA', '242510049', '$2y$12$hkofZMlm6nsNOOGWzfE1u.Z2fC9mZOwqxXIND9cIlWiAaGL6bMdDi', 'siswa', '2025-09-01 04:25:50', '2025-09-01 04:25:50'),
(313, 'MUHAMMAD RAFFA RODIYANA', '242510050', '$2y$12$cC1tSKts9VpzWsClUl0SLOdqpymoXmLhO70V54rKtic9HRoGAc3T6', 'siswa', '2025-09-01 04:25:51', '2025-09-01 04:25:51'),
(314, 'NAJWA FITRIA AZZAHRA', '242510051', '$2y$12$py9X7japKFw6EskB7Oit6ut91JbKBQGLS5l6d0zgP7FT7ZKaeJURS', 'siswa', '2025-09-01 04:25:51', '2025-09-01 04:25:51'),
(315, 'NINING NURFALAH', '242510052', '$2y$12$tTGl0VdD3LIakhEPI0TwfuPxaG7ebdKYzFfcRCEr912HCfcw41AMu', 'siswa', '2025-09-01 04:25:51', '2025-09-01 04:25:51'),
(316, 'NORMAN HIDAYATULLAH', '242510053', '$2y$12$7l5mTYN8YTo.IBlvI71e6u.FFpnHOPFjroBWmmm0flFMCRZtxWVNe', 'siswa', '2025-09-01 04:25:52', '2025-09-01 04:25:52'),
(317, 'NOVI SEPTIANA RAHMADANI', '242510054', '$2y$12$dxpWP.PztZJklp/K2Su26.8..phYWf/Vz/4oGXuFeijLOrl7/pxFK', 'siswa', '2025-09-01 04:25:52', '2025-09-01 04:25:52'),
(318, 'NURMALA', '242510055', '$2y$12$vYCsmNTDfsYzfGe1u8qIieU20jDQIDpPPGzSFPg00SZx2pWntNmpG', 'siswa', '2025-09-01 04:25:52', '2025-09-01 04:25:52'),
(319, 'PUTRI SALSABELA', '242510056', '$2y$12$7EJTJMozj8QWbMlX0Dbpc.x1BvVnJdIozHiuciZlvG4jYVCb4yLeG', 'siswa', '2025-09-01 04:25:52', '2025-09-01 04:25:52'),
(320, 'RANI', '242510057', '$2y$12$dyF2OALCUIeBSyq1Fk3ONOWgo08/TR3LD6C9qN6IJZ3G/RavgztK.', 'siswa', '2025-09-01 04:25:53', '2025-09-01 04:25:53'),
(321, 'RIRIN EKAWATI', '242510058', '$2y$12$U4WnmKDobdEWmD/19EFuZO8eQaooHK8uxR2dhXu7USFzORpVGeP2a', 'siswa', '2025-09-01 04:25:53', '2025-09-01 04:25:53'),
(322, 'SARASWATI', '242510059', '$2y$12$pqFul0xwZiin67yXqLI4fOj0tpuX2LW5PNDZ/nUemAWmLdIqD1Lc6', 'siswa', '2025-09-01 04:25:53', '2025-09-01 04:25:53');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(323, 'SITI NURJAMILAH', '242510060', '$2y$12$huZC23E/HeX/oV4HxRhbk.0LvH4YoyJuLFl2YZqM1gRCYZ6jeATgG', 'siswa', '2025-09-01 04:25:53', '2025-09-01 04:25:53'),
(324, 'WIWIN NURMAULIDA', '242510061', '$2y$12$0mfj1agIpjxZz2MHndwigOO/bUa5.0WZmb8DaFHGYjha25a5tGvYW', 'siswa', '2025-09-01 04:25:54', '2025-09-01 04:25:54'),
(325, 'WULAN SARI', '242510062', '$2y$12$az6BTEAPJl.Lqj2jZeTAaeHMz1ZhZzrz99y0xxh4ZIcWx66gB27me', 'siswa', '2025-09-01 04:25:54', '2025-09-01 04:25:54'),
(326, 'ZAHRA AYUMI', '242510063', '$2y$12$b.kVis0N8IesWEz0WZh8k.0rIiKbeI023YicP3j7ZhgXzXb7vO/1a', 'siswa', '2025-09-01 04:25:54', '2025-09-01 04:25:54'),
(327, 'ZAHWA AENURROHMAH', '242510064', '$2y$12$cbhAVYD2n2qOK3IJ3iOQZ.OdWoZrLrpJBC9u8ituLILOqKKUuhUNK', 'siswa', '2025-09-01 04:25:55', '2025-09-01 04:25:55'),
(328, 'ABDUL SODIK', '242510065', '$2y$12$EmItnLtsibJV9g0XasT9dOQ2MIXesf7Zwf3eDQAm47H/vgkBW/Uty', 'siswa', '2025-09-01 04:25:55', '2025-09-01 04:25:55'),
(329, 'AGNAN HAMBALI', '242510066', '$2y$12$HvPVGQSaYJRa7biDDHSISuuas8fhvxritqc903M5ZisyzGeP4I56e', 'siswa', '2025-09-01 04:25:55', '2025-09-01 04:25:55'),
(330, 'AGUS MULYANA', '242510067', '$2y$12$.GJWaSim5VfuUI2mmPhEfObA0CfCKxgVopY5l3/uERQ2Shd5SIDvi', 'siswa', '2025-09-01 04:25:55', '2025-09-01 04:25:55'),
(331, 'AKBAR DHANI', '242510068', '$2y$12$GDw5dQ0LrCkBgLhjIx9RduHQ27QEm0XLz7BtEmZzQF65hyrwRfjN6', 'siswa', '2025-09-01 04:25:56', '2025-09-01 04:25:56'),
(332, 'ALDI FAUZAN', '242510069', '$2y$12$txOM/MuqYdzarQI47ih0JOdK6AJoshjBJW9c.1b.ogYFSwupyrhZu', 'siswa', '2025-09-01 04:25:56', '2025-09-01 04:25:56'),
(333, 'ALDIEN AKBAR', '242510070', '$2y$12$NV77B1sCONAXxp6RZF2Z7uDb28jafe18mx66j5UBI6VgtM1bM7puC', 'siswa', '2025-09-01 04:25:56', '2025-09-01 04:25:56'),
(334, 'ALPI SAEPUL AKBAR', '242510071', '$2y$12$.uX0pKmJTF63BbQeQQKqEegu.OhRgjrGRzY2XXyxu.ejwv4rTpmQS', 'siswa', '2025-09-01 04:25:56', '2025-09-01 04:25:56'),
(335, 'ANDIKA SYAPUTRA', '242510072', '$2y$12$rvL0ofyh9Io8CW1n86kY4e50Qh98YZJGyOBTBNMvbpjXOHLM2RZnW', 'siswa', '2025-09-01 04:25:57', '2025-09-01 04:25:57'),
(336, 'AYOM PRAYOGA', '242510073', '$2y$12$56UcYNX6IXbO6MCY5.eAm.0yiitEWfiAuxH2/CdzH6imq0FEtFX6m', 'siswa', '2025-09-01 04:25:57', '2025-09-01 04:25:57'),
(337, 'CAHYONO MAULANA', '242510074', '$2y$12$hlyFLGqCXvz4Q55ehsFFSuVrLuvITsvmK23HdYzjY6Cb3XNzlr29y', 'siswa', '2025-09-01 04:25:57', '2025-09-01 04:25:57'),
(338, 'DIMAS PRADIPTA FUDHOLI', '242510075', '$2y$12$uSCzJtDKnXX.XXVHDw7MouxGSu2q1FuzzysC3xhHRaD4n9MVyHONC', 'siswa', '2025-09-01 04:25:58', '2025-09-01 04:25:58'),
(339, 'EKA RAMDANI JUNAEDI', '242510076', '$2y$12$2m0/WN7OfsRt.w.Bun38C.PkNtrxnsKN4UyZ9tGq0vHSTowAFlDbW', 'siswa', '2025-09-01 04:25:58', '2025-09-01 04:25:58'),
(340, 'EVA NURAENDI', '242510077', '$2y$12$xiQkcYaVI7QP6U17g5kOjOPGoi4AnIpuqzpptg4nMehLGicp04DlG', 'siswa', '2025-09-01 04:25:58', '2025-09-01 04:25:58'),
(341, 'GENTA TENGGARA BADAY', '242510078', '$2y$12$yzY.1gLcqpHOdcNiJCh0F.aI1mGRpmZtSYduH1.wd2tYLN4nEbCGC', 'siswa', '2025-09-01 04:25:58', '2025-09-01 04:25:58'),
(342, 'INTAN NURJANAH', '242510079', '$2y$12$DURzV0WLh476sKTcsUrjuOZH7lbaLFMlAd25OmOrspbgJ85KFYXH6', 'siswa', '2025-09-01 04:25:59', '2025-09-01 04:25:59'),
(343, 'IRPAN HERMAWAN', '242510080', '$2y$12$r/G1NjAEY/yZ/1FYasuU7upwnF4ypM2t/lndV9tCGB7wV8Rk5Uft6', 'siswa', '2025-09-01 04:25:59', '2025-09-01 04:25:59'),
(344, 'MUHAMAD YAHYA', '242510081', '$2y$12$CHbsxvILQXZI5/aQ9hF9AOJwyWSbGrZKQSvrflbBznWlX8PrJbfia', 'siswa', '2025-09-01 04:25:59', '2025-09-01 04:25:59'),
(345, 'NABILA JULIANY', '242510082', '$2y$12$U4PKpfNFHWrrAMMaGFVmvex9SnHc1YMPHHD4aFtSL33HtFivQ1rn6', 'siswa', '2025-09-01 04:25:59', '2025-09-01 04:25:59'),
(346, 'RAFI MAULANA LILAH', '242510083', '$2y$12$eNmxLueAJpXxsVcK/st9P.kTIsNVrGrNXRWEr0jzXTbLekvHxXXG2', 'siswa', '2025-09-01 04:26:00', '2025-09-01 04:26:00'),
(347, 'RAMA ALDIANSYAH', '242510084', '$2y$12$cypRoyaHJueRpJZ2INsmKOtMNdZtKFpOOTO1pkfWacnoon17Szwfi', 'siswa', '2025-09-01 04:26:00', '2025-09-01 04:26:00'),
(348, 'RAMA HERDIANSYAH', '242510085', '$2y$12$Q2DNs39vSmMW7r1WAbx2De2Rb3rUMIcFNrp7.BGMxp8ozR1hzUwie', 'siswa', '2025-09-01 04:26:00', '2025-09-01 04:26:00'),
(349, 'REDI', '242510086', '$2y$12$//Akw3jZ/e4.8Zz0pPaJzeY5SRG90rdynCHAQsVBBxLz78RKdBv7a', 'siswa', '2025-09-01 04:26:00', '2025-09-01 04:26:00'),
(350, 'REGIA NANDA FEBRIATAMA', '242510087', '$2y$12$qyMqxHvGwORSUbNZnKhKjOo.3qdM5hacMl9xkQItut18ntg0fXQBC', 'siswa', '2025-09-01 04:26:01', '2025-09-01 04:26:01'),
(351, 'RIFKI MULYANA', '242510088', '$2y$12$rmoJ1N27cHBw4MmZ0lPFH.bBJ1FZS75QkVV6xKTu7tJPPfhOToR4W', 'siswa', '2025-09-01 04:26:01', '2025-09-01 04:26:01'),
(352, 'RIZKY ADITIYA', '242510089', '$2y$12$NfFvutFRLRRRmYU056HIee9ef00LCfNxNGGGf0z1ifVUksxrd4cLG', 'siswa', '2025-09-01 04:26:01', '2025-09-01 04:26:01'),
(353, 'RIZKY AZIZ MAULANA', '242510090', '$2y$12$m.8Tv1j3ynp5/84vPOBsSOmN0PmehLLpfC.7rFqaKHX/Qtyy1qWPa', 'siswa', '2025-09-01 04:26:01', '2025-09-01 04:26:01'),
(354, 'SITI MARIYAM', '242510091', '$2y$12$tRdbOqBnZKTsVw1JEhjAXOC6./NsrHbjsVKW/1OHL3wmRUmDWdjuu', 'siswa', '2025-09-01 04:26:02', '2025-09-01 04:26:02'),
(355, 'SYAHRILLA PERMATA NUSANTARA', '242510092', '$2y$12$rG9Nfmu8oas4LW756J6o3ecvCQL1pEoCp32k/vji/JheEYgkEytDm', 'siswa', '2025-09-01 04:26:02', '2025-09-01 04:26:02'),
(356, 'WIBY KURNIAWAN', '242510093', '$2y$12$RF5t8NKHwS3CtnJM2P44EueslRcvMetDVWA9KcpllzZ5zLdLG1Z7u', 'siswa', '2025-09-01 04:26:02', '2025-09-01 04:26:02'),
(357, 'WIDIYA ANISA PUTRI', '242510094', '$2y$12$pCQAwcbobpR74xfXAw.30uqZ4AbV5s3u9FugnkUl.vQydjwx6z.gW', 'siswa', '2025-09-01 04:26:02', '2025-09-01 04:26:02'),
(358, 'WINDY DANUARTA', '242510095', '$2y$12$0OmtdCEQ3OxjTxj3.m3uW.kvidWSNRgb5GEkM7R31/NT4gotLeqc.', 'siswa', '2025-09-01 04:26:03', '2025-09-01 04:26:03'),
(359, 'YUDI MULYANA', '242510096', '$2y$12$hvVF9.yFeFQdb9fVVkJ9muc5XwrMGHmwjSb2LB7IspWFd9KH2Q.ae', 'siswa', '2025-09-01 04:26:03', '2025-09-01 04:26:03'),
(360, 'ADITTIYA SAPUTRA', '242510097', '$2y$12$7ejHXQKst1KLRg7CjW1nDeaQTCxvgvquEPCUH7dX2RIt64PMcqmwS', 'siswa', '2025-09-01 04:26:03', '2025-09-01 04:26:03'),
(361, 'AFDAL ZIQRI RAMADAN', '242510098', '$2y$12$CYCkpj9p4VTYa5plCndrUuI/4zP3DnVIuPIHk6Z7FUcDDVVzkJKse', 'siswa', '2025-09-01 04:26:04', '2025-09-01 04:26:04'),
(362, 'ANDIKA EKA SAPUTRA', '242510099', '$2y$12$CaDVrjLwk/r3FuF7wfN1ne3EdjnmEuHLgBAIcGThYxlX2EvxOlHLS', 'siswa', '2025-09-01 04:26:04', '2025-09-01 04:26:04'),
(363, 'ANGGUN RIANA PUTRI', '242510100', '$2y$12$jFQwBX5AGFkp4HM/bmbb3.f/B2XMPb6Q8mn6bI2G2nvUA6j.tJf5e', 'siswa', '2025-09-01 04:26:04', '2025-09-01 04:26:04'),
(364, 'APRIZAL SUGANDA', '242510101', '$2y$12$fjX/zzL0EUT7UsmSguY1eekTZQIandO37CTN1uCcHs8dkTiSWTWt2', 'siswa', '2025-09-01 04:26:04', '2025-09-01 04:26:04'),
(365, 'ARDIANSYAH', '242510102', '$2y$12$wPilar3hHvTYJ68mqI/PO.AfjWmkxbWYusnllzgX7eoHuuBtUMaqG', 'siswa', '2025-09-01 04:26:05', '2025-09-01 04:26:05'),
(366, 'ARIF JUNAEDI ABDILAH', '242510103', '$2y$12$vxHXhWu2z4UfWLep84hFouGOCcRmxZ7aIfcvNy2y0IFpp4t.e6O.u', 'siswa', '2025-09-01 04:26:05', '2025-09-01 04:26:05'),
(367, 'ASIAH NURAZIZAH', '242510104', '$2y$12$.oZ61LLErEKrYn38t24yvu60kIngfuCoNSEY3G0YHmq2qzNcpvBim', 'siswa', '2025-09-01 04:26:05', '2025-09-01 04:26:05'),
(368, 'DIMAS', '242510105', '$2y$12$DBRTZc1pfh64uNHJ8Q2.x.Pe4T2Cya3dBGM05W/4b.67Gx/TS.CGq', 'siswa', '2025-09-01 04:26:05', '2025-09-01 04:26:05'),
(369, 'DIO PRATAMA', '242510106', '$2y$12$livP5tSgdlZsIBBjlBbQO.8pObSL8L2y3OJWgQQQDTJxXENpzLcdq', 'siswa', '2025-09-01 04:26:06', '2025-09-01 04:26:06'),
(370, 'FACHRI MUHAMAD SOFYAN', '242510107', '$2y$12$C3RGrlDJYBZqeSO9mhsHeu/fmjYYiBvjp17aRlE0unxtWNw.uDrfq', 'siswa', '2025-09-01 04:26:06', '2025-09-01 04:26:06'),
(371, 'FAHRI HAMDANI', '242510108', '$2y$12$Z5aqRuShGuS8lMbeDnuuaeQKlpsOnj.MJuuTD2CA3edzRZCykXT5W', 'siswa', '2025-09-01 04:26:06', '2025-09-01 04:26:06'),
(372, 'FERRY SEM JULIANTO', '242510109', '$2y$12$kAQWZzCibhoP4DL.5e6f8.9MaoqoTuek6Rcr3LdO30uZS.3djN.fS', 'siswa', '2025-09-01 04:26:06', '2025-09-01 04:26:06'),
(373, 'GUNAWAN GUNTUR', '242510110', '$2y$12$hQ5Hx11Ja7o7/TBwFp8BUerW2xwW56vRQkpAKeYuI8cxaIsHbMfky', 'siswa', '2025-09-01 04:26:07', '2025-09-01 04:26:07'),
(374, 'IRMAWATI', '242510111', '$2y$12$fHHHDUZpD4nRINJzH98BROKOZppYd1zYHgPEFx9HBiQq1A./jZmdm', 'siswa', '2025-09-01 04:26:07', '2025-09-01 04:26:07'),
(375, 'ISMAIL NURJAYA', '242510112', '$2y$12$3hJ7pVkClfbjs6LTbBOX7uV1ak9LejVydowHYUrpqsc7xZyvPUKVe', 'siswa', '2025-09-01 04:26:07', '2025-09-01 04:26:07'),
(376, 'LUTPIAH', '242510113', '$2y$12$Of8Ygsp8lBF71CFskDLdoeudGWlUBw1Vwwd0DIvGj/7xAD5DmR9P6', 'siswa', '2025-09-01 04:26:08', '2025-09-01 04:26:08'),
(377, 'MUHAMAD FAIS', '242510114', '$2y$12$ikZ9hGZR1ptKPwHEy5tB9OYQEpWPmjvD8TaiJOSnAJjR3sHp3PtyW', 'siswa', '2025-09-01 04:26:08', '2025-09-01 04:26:08'),
(378, 'MUHAMAD MUMIN', '242510115', '$2y$12$ormsS72u4k/KVIiwoYP2puoqupYnqFRzQYxwQqKAh9TdjWYEKri.K', 'siswa', '2025-09-01 04:26:08', '2025-09-01 04:26:08'),
(379, 'MUHAMAD NUSHA BADARI', '242510116', '$2y$12$kj379GH5c2h4a/0mAu2Fpu4wBEtYKbBT2xdCohQsZ5ubxJ57yZxca', 'siswa', '2025-09-01 04:26:08', '2025-09-01 04:26:08'),
(380, 'MUHAMMAD PALESTIN', '242510117', '$2y$12$rbQAZr0S7KdBt4OT5NlKO.XFC/.ahBT.a17UjEnMPb4SzInKG6bVO', 'siswa', '2025-09-01 04:26:09', '2025-09-01 04:26:09'),
(381, 'MUHAMMAD RAFFI ALFARIS', '242510118', '$2y$12$w9Ixc4xizL.Zd1Cb02WlmuBqAa3W8NeiGlGXyLv.fxvgmlCv5W2dq', 'siswa', '2025-09-01 04:26:09', '2025-09-01 04:26:09'),
(382, 'MUHIDIN', '242510119', '$2y$12$PgfsBfw.SmA.dEJSHo28oeeEEZNS1LDjJxB20tmcIIgCJn9GSqABy', 'siswa', '2025-09-01 04:26:09', '2025-09-01 04:26:09'),
(383, 'NURHAYATI', '242510120', '$2y$12$lZtOvQ4eXu3ilncy5d/tt.YK2cR7lbxxSo.cfHGOedeUqD8v5Fgki', 'siswa', '2025-09-01 04:26:09', '2025-09-01 04:26:09'),
(384, 'NURSIAH', '242510121', '$2y$12$gsEpE5rTkyW.5ulqwHExZOKSP44nWfhl9864l6QwbPw.0Mrv22Ohy', 'siswa', '2025-09-01 04:26:10', '2025-09-01 04:26:10'),
(385, 'ROHMANA', '242510122', '$2y$12$tCYdfsmhKCv2wE6KjsEyEOTVX36dpeeKS5yS1gKxtQ5UQNOQN1e.q', 'siswa', '2025-09-01 04:26:10', '2025-09-01 04:26:10'),
(386, 'SYARIP NASRULLOH', '242510123', '$2y$12$g39SXKf9bfQc.NxOeNzVCuKcqed8qmbgmlfEZXfUDrXKXOMuc2w5q', 'siswa', '2025-09-01 04:26:10', '2025-09-01 04:26:10'),
(387, 'TAMAMI', '242510124', '$2y$12$FcYVpcxgMGpT0iMQySnhzOjuswnpQpk8J6JoSbrGJINFI7u.5wfv2', 'siswa', '2025-09-01 04:26:11', '2025-09-01 04:26:11'),
(388, 'ABDUL GANI', '242510125', '$2y$12$Q1/Jc2u.JZeP0vHetCa7huURPkrdldwsa/B7qeh3AvM/LcPF19daO', 'siswa', '2025-09-01 04:26:11', '2025-09-01 04:26:11'),
(389, 'AHMAD DANU', '242510126', '$2y$12$qgAWA5m6c/s2zg.ZYHDy8esX89s5AZMZvs0fv2JEqD1WGm5MppWHu', 'siswa', '2025-09-01 04:26:11', '2025-09-01 04:26:11'),
(390, 'ALMASUL ANAM', '242510127', '$2y$12$NndCwZlndM.Pe1xReKShKuSMUGlHak2qRRwH7b.AxOaxcnrPpw6YG', 'siswa', '2025-09-01 04:26:11', '2025-09-01 04:26:11'),
(391, 'APRIANSYAH KARIM', '242510128', '$2y$12$cwQUOxLJhhh25e9m/n3dYeWa3WuSYkOl0NbKEdZW5bbmh/xTRR5Re', 'siswa', '2025-09-01 04:26:12', '2025-09-01 04:26:12'),
(392, 'APRIYANSYAH', '242510129', '$2y$12$hjkStFEZWkp1TcYkp7/EDOl8hdVqcUTvPTQDMUSXPIo46w/KmP03m', 'siswa', '2025-09-01 04:26:12', '2025-09-01 04:26:12'),
(393, 'ARYO SAPUTRA', '242510130', '$2y$12$11NjdwIErtb5XOyNVk7DiO9Vjdas7/Lm2xLpwc0HxZVRZntLzwve.', 'siswa', '2025-09-01 04:26:12', '2025-09-01 04:26:12'),
(394, 'BELA CANTIKA', '242510131', '$2y$12$lwTKL96A7k/NjjGjA9H9hOsGtKD2KfP9PrZ8eZQLBGlxZpADQh7i2', 'siswa', '2025-09-01 04:26:12', '2025-09-01 04:26:12'),
(395, 'CASTIMAN', '242510132', '$2y$12$zZLBKIUzpApvkGj7oAWE4uk0cRUtn7vxPOUOEbHutWX9sL7I.0jSy', 'siswa', '2025-09-01 04:26:13', '2025-09-01 04:26:13'),
(396, 'DAVI BAHTIAR', '242510133', '$2y$12$/tdFFjgPYXj0XIYWMIloL.fptOhWuwfT.LORc1OpYMFP4UEkyn0Vm', 'siswa', '2025-09-01 04:26:13', '2025-09-01 04:26:13'),
(397, 'DELIMA', '242510134', '$2y$12$LBLJc3qDcYm7jmwM/Fxnj.jn9gKyg2dtShDm0gK1XFI0We02fHAmW', 'siswa', '2025-09-01 04:26:13', '2025-09-01 04:26:13'),
(398, 'EKO ADI SUCIPTO', '242510135', '$2y$12$N9IRFoTnx/4heukttkzP3uk4kNJGDtux4AZvRQ0fQ8Bx04WRECnju', 'siswa', '2025-09-01 04:26:13', '2025-09-01 04:26:13'),
(399, 'IBRAHIM SIDIK JAELANI', '242510136', '$2y$12$9ObqNaxbNzAn1RzNGUbnpOxx1zHQk1vmmCQhsig4TvJOtG4vlLo2a', 'siswa', '2025-09-01 04:26:14', '2025-09-01 04:26:14'),
(400, 'ICANA', '242510137', '$2y$12$UeNcZ7/ZFTce0NAouUQYMOt9.vPkjfwzhYSsYO2IDMbdvt.pEIqH6', 'siswa', '2025-09-01 04:26:14', '2025-09-01 04:26:14'),
(401, 'IRPAN', '242510138', '$2y$12$o/mozMOeENlVOJOMumqvbuINS0.Yqpty6QV0C5cuk7oebpcuDQaw6', 'siswa', '2025-09-01 04:26:14', '2025-09-01 04:26:14'),
(402, 'KHAILA SABINA', '242510139', '$2y$12$agmu33mNFz3po4CsQ5XcFOJJi04ZYuhQcw00CIxlayaUSdlxkpfEG', 'siswa', '2025-09-01 04:26:14', '2025-09-01 04:26:14'),
(403, 'MUHANAD ABDULHADI', '242510140', '$2y$12$b4QjCmeonSrs4d.TR5PMvOYGHbRRteCHEttnVgjE6qa/biC6mUaKy', 'siswa', '2025-09-01 04:26:15', '2025-09-01 04:26:15'),
(404, 'NURLELA APRIYANTI', '242510141', '$2y$12$f.dUeaVjE5M10dOdunI9..84BAIf6hr/yVKaSXtZhGv3AwcM5BMDe', 'siswa', '2025-09-01 04:26:15', '2025-09-01 04:26:15'),
(405, 'PARIDHAH', '242510142', '$2y$12$H/N3UL8cRT4FDKaRxEH/FO6RR0y7RL2Mxj0lw1bvPtUjMcAzbdkK2', 'siswa', '2025-09-01 04:26:15', '2025-09-01 04:26:15'),
(406, 'PASA NUR PADILAH', '242510143', '$2y$12$pdgX5VcdLnsTzLmin7/kL.NM/P5Kq9us2cFp1Wjj1a9QLJGzABL.y', 'siswa', '2025-09-01 04:26:16', '2025-09-01 04:26:16'),
(407, 'RAISYA ADITIA', '242510144', '$2y$12$bG44aphdK6NDz/tUo/9FIuLhedj93KSwdvpzn3zmHXxtBLnlobtWa', 'siswa', '2025-09-01 04:26:16', '2025-09-01 04:26:16'),
(408, 'RANATA', '242510145', '$2y$12$H9N9aFS.IZU.4wnNAZW5aOhwoPxb8M1Xx39q74UO171aJoZGssaz6', 'siswa', '2025-09-01 04:26:16', '2025-09-01 04:26:16'),
(409, 'RAPI RIPANSYAH', '242510146', '$2y$12$uZmw1k51ITQK3P3Ht9DlL.jHtRQe5XMpwSe8d6tF2mp4QEL6aC7US', 'siswa', '2025-09-01 04:26:16', '2025-09-01 04:26:16'),
(410, 'RIPAT', '242510147', '$2y$12$1IWRaYgSgA7cnt5Msgij0.1GUiTnXMqIE6M36punJ9oqUtl0b/Ha6', 'siswa', '2025-09-01 04:26:17', '2025-09-01 04:26:17'),
(411, 'RIZIQ ABDUL WAHID', '242510148', '$2y$12$a.O0ubVaSEb5T85.kY3SI.SyGF4stoDznz2qnWk763bjg/6AKX1Pe', 'siswa', '2025-09-01 04:26:17', '2025-09-01 04:26:17'),
(412, 'SUCIKOH MAHARANI', '242510149', '$2y$12$6ipdAOqdAOK6N8zfGCadY.o/9iE.jHd1tpFxIJhakjgxgPPNvzxBW', 'siswa', '2025-09-01 04:26:17', '2025-09-01 04:26:17'),
(413, 'SUKARDI', '242510150', '$2y$12$PuFCAoQtJ36eLGeLD/mF9upUQPfiqQ0eQCeafEAUydZjHTVqIBiN6', 'siswa', '2025-09-01 04:26:17', '2025-09-01 04:26:17'),
(414, 'TIANI', '242510151', '$2y$12$F8QqoImgOLNBr1RtcXB3m.DLvuLgD16Fl/tmloy3bw73O9DOoY8p.', 'siswa', '2025-09-01 04:26:18', '2025-09-01 04:26:18'),
(415, 'WAHAB TAJUDIN', '242510152', '$2y$12$KWlSHMV6GbZPyQpRIueSEuce/s//briYVDSRDuAznJUFShi9U5ZyS', 'siswa', '2025-09-01 04:26:18', '2025-09-01 04:26:18'),
(416, 'AHMAD RIFKI RIFAI', '242510153', '$2y$12$5VX7dtOT32HZJWfX0JCmkOKm4OgEs7bLn6jyfCqI0DTTXMEyGiHwy', 'siswa', '2025-09-01 04:26:18', '2025-09-01 04:26:18'),
(417, 'ALDO PRASETYO ADAM', '242510154', '$2y$12$PCYIBNqeqVQ4ZhGX9WTWUO/S2fq3VVVEmCOcoZDvPD6rpoL8mNM0i', 'siswa', '2025-09-01 04:26:18', '2025-09-01 04:26:18'),
(418, 'ARIS MUKTIA', '242510155', '$2y$12$eLF4s9Sj5ZUw7waNCobeAen8GAwF9y4PcOLtHARlZrxd.W2qygira', 'siswa', '2025-09-01 04:26:19', '2025-09-01 04:26:19'),
(419, 'ARMAN RAMADHAN', '242510156', '$2y$12$E13Sen6Ar4f82MjzTCxhweGETqb.S9d/o2HfUzzMptwcbY7lCQnDC', 'siswa', '2025-09-01 04:26:19', '2025-09-01 04:26:19'),
(420, 'DARMAWAN', '242510157', '$2y$12$tyGpf9cpgoGQifm.iTPxcupAC7Av9QvPbYXRElP.8kIeDC8MaDo5u', 'siswa', '2025-09-01 04:26:19', '2025-09-01 04:26:19'),
(421, 'DENI HARUN', '242510158', '$2y$12$FwwPxInmof4jma4nfr6.MuPFQfQ67IECjlzXsCxj4Vldf2tS09A.6', 'siswa', '2025-09-01 04:26:20', '2025-09-01 04:26:20'),
(422, 'DIMAS', '242510159', '$2y$12$Qk9mQDLdEv240IYUMWfi4eGVt9jkZCK2znLkiajLEzVWV2tqWf6Zq', 'siswa', '2025-09-01 04:26:20', '2025-09-01 04:26:20'),
(423, 'FAISAL ABDUL AZIS', '242510160', '$2y$12$Vsdrv5RCyaTselu/LmbeDO0vfQMHgq9vtOmKv0n.KE4Mzr19UlzIS', 'siswa', '2025-09-01 04:26:20', '2025-09-01 04:26:20'),
(424, 'GALIH WARDANA', '242510161', '$2y$12$wfKYOTja/Om2WEEIamXdGOXISJWW7E5UDm6aEUucXqDHdn87Y01he', 'siswa', '2025-09-01 04:26:20', '2025-09-01 04:26:20'),
(425, 'GILANG PERMANA', '242510162', '$2y$12$tFJVN52S2K9bCv6s/nljb.vsD6L0Etc9FdPoE4W5FmFvtraErQtn.', 'siswa', '2025-09-01 04:26:21', '2025-09-01 04:26:21'),
(426, 'HOTIMAH', '242510163', '$2y$12$f0uDzsoDJt2bfsVHblu23.M5AfJh1ZNqbDnuRlyp9hWMm6rJaR5DG', 'siswa', '2025-09-01 04:26:21', '2025-09-01 04:26:21'),
(427, 'ILYAS SUPANDI', '242510164', '$2y$12$.hAmCYCcOhqe/bl9W4Hv9.VwgNy2lm/.uKt1OJ5EoMIHCLnuSRZE2', 'siswa', '2025-09-01 04:26:21', '2025-09-01 04:26:21'),
(428, 'IRKI', '242510165', '$2y$12$VtrRwYslWDkw2VVyiuxmTujylg7xgdyN4EpX7ofCZaDKEYx4a86R2', 'siswa', '2025-09-01 04:26:21', '2025-09-01 04:26:21'),
(429, 'IRWAN', '242510166', '$2y$12$vLo0vFNICUaCEwv7UEf20uhau0LWV1oxfkjDvYZu0McyqgMe/z9pu', 'siswa', '2025-09-01 04:26:22', '2025-09-01 04:26:22'),
(430, 'KARDIANSYAH', '242510167', '$2y$12$dva.cXAAWkscuc03gRHZbevM14lGYDyAlWQrJ.3.dxFt1dcjcbEp6', 'siswa', '2025-09-01 04:26:22', '2025-09-01 04:26:22'),
(431, 'MEYFHA AKILAH', '242510168', '$2y$12$pIrp1vmBPRo82g6P60B0DeIN5E7lENj/07T5NxdHU.lG.T8JrlU5W', 'siswa', '2025-09-01 04:26:22', '2025-09-01 04:26:22'),
(432, 'MOHAMAD AKBAR', '242510169', '$2y$12$EtOkb.XFRumGmMksrUmgFe6Ac441Zomj8kUBWHJwJR5OjchjmjXMm', 'siswa', '2025-09-01 04:26:22', '2025-09-01 04:26:22'),
(433, 'MUTIARA', '242510170', '$2y$12$k5p0m/qsEVjF6kvuKcwj2.cSiz1yDvjMplfUORjdEAKCnWeGDYv0.', 'siswa', '2025-09-01 04:26:23', '2025-09-01 04:26:23'),
(434, 'NANANG ALDIANSYAH', '242510171', '$2y$12$agDaaSPwuRMPmirUO16WPODaGvpmy5zdetJrFz./NwHbb7kbLivwy', 'siswa', '2025-09-01 04:26:23', '2025-09-01 04:26:23'),
(435, 'PAHRUDIN', '242510172', '$2y$12$na.sDHY9dACwOfGF0C1pV.tno7PRRAgkRSRHUU8wa3XwUI9GsCRSm', 'siswa', '2025-09-01 04:26:23', '2025-09-01 04:26:23'),
(436, 'SAPRUDIN', '242510173', '$2y$12$USKpTGG52a/HsAeyNTIWQ.5C/uMnV9l876otpG1icenbeZq30nnI6', 'siswa', '2025-09-01 04:26:23', '2025-09-01 04:26:23'),
(437, 'SIFAH FAUZIAH', '242510174', '$2y$12$ImYgJoqdNbbr75Evf4HDSu429d/8NLQBcc2LvU2bQh4Cj2HMBZI2O', 'siswa', '2025-09-01 04:26:24', '2025-09-01 04:26:24'),
(438, 'TANIA LAURA', '242510175', '$2y$12$uaEe8BN.bT36wpnTIYX4QecS2liAn7wyX9BOO9ydyfGDits0te6Na', 'siswa', '2025-09-01 04:26:24', '2025-09-01 04:26:24'),
(439, 'TEGAR ANANDA PRATAMA', '242510176', '$2y$12$8Pzv7sAQPMROrFT7fV9fcez7965h5Up5M8d6K3VRuoXKn1/3X3IMO', 'siswa', '2025-09-01 04:26:24', '2025-09-01 04:26:24'),
(440, 'WIRANATA', '242510177', '$2y$12$dAbT.uonEBempdmi9rnGteP0H2iAZ7D7t0VF1NGaBK.4EpgoLd3zO', 'siswa', '2025-09-01 04:26:25', '2025-09-01 04:26:25'),
(441, 'YUSUP HABIBI', '242510178', '$2y$12$4UciIB5kiWShnjV6p3Je5.UveSCfbfVVqVljv4Fpb2mEK7gprvddm', 'siswa', '2025-09-01 04:26:25', '2025-09-01 04:26:25'),
(442, 'AHMAD NURACA', '242510179', '$2y$12$Qa1KHl47rQc7qo.mdWbaA.fwbBu8SBI24Q0EaoVWilCLms3Cknva.', 'siswa', '2025-09-01 04:26:25', '2025-09-01 04:26:25'),
(443, 'ALVIAN NURFADILAH AGUSTIN', '242510180', '$2y$12$om5pny/gjCuzpnEje20TIOPINvEQqbpDGjGrMP/2pNQYzI9p4GxCS', 'siswa', '2025-09-01 04:26:25', '2025-09-01 04:26:25'),
(444, 'CARTIKA AYU', '242510181', '$2y$12$8LD3eaz4X1dbtF8a4BWpC.mBGJtTtL4WRaWl0gKKPGz4rvCxKQwyu', 'siswa', '2025-09-01 04:26:26', '2025-09-01 04:26:26'),
(445, 'DIMAS', '242510182', '$2y$12$DGOpyGnJG/5irD.UFR8gb.6MrsFMfc2diicE94tyTtteb25HxSire', 'siswa', '2025-09-01 04:26:26', '2025-09-01 04:26:26'),
(446, 'DIRLY KUSUMAH', '242510183', '$2y$12$8z5j/EfY8i1o2l38SeAyuO1KwneKnWO4dGPFR4ApZBYGe97NuD7Ai', 'siswa', '2025-09-01 04:26:26', '2025-09-01 04:26:26'),
(447, 'FAISAL SETYO NUGROHO', '242510184', '$2y$12$KnNBNVVNyhz5KQnFfcPGX.DbahKGG/JV2H4zTG0rYkH.dGwqtD.Gi', 'siswa', '2025-09-01 04:26:26', '2025-09-01 04:26:26'),
(448, 'FARID RIZKY RAMDANI', '242510185', '$2y$12$TH25CmWAV.GasT6q4/BY9Ox4O7h7XsQYTTNXUM.QltL3Z.7a9o8Je', 'siswa', '2025-09-01 04:26:27', '2025-09-01 04:26:27'),
(449, 'IIN DWI DIKA', '242510186', '$2y$12$7GoHCy1/yoIoom4rQXPNrORFlz.ivoR2Z5sR6esZja5lbrCSMxtSC', 'siswa', '2025-09-01 04:26:27', '2025-09-01 04:26:27'),
(450, 'ILYAS EFENDI', '242510187', '$2y$12$eXkgFen2IKGsWOF9AvRUKe75LVL/3en.6i//IhPxVX9Dh5wdC.tUK', 'siswa', '2025-09-01 04:26:27', '2025-09-01 04:26:27'),
(451, 'IRWAN', '242510188', '$2y$12$XRJzd.4m0c7e2bTcOf6iiuHRpP0RBWJbxTv7DfoXuKNdP.HjUPMdW', 'siswa', '2025-09-01 04:26:27', '2025-09-01 04:26:27'),
(452, 'JAMAL MAULANA', '242510189', '$2y$12$HDSPM5DHVN./rQQxZvlKTuK5LQCMfX3sQziGrJqB6wG75gbnjXYIK', 'siswa', '2025-09-01 04:26:28', '2025-09-01 04:26:28'),
(453, 'LUTHFI YANSYAH', '242510190', '$2y$12$roX4fjr5rkRAObFsDGlO0.fybTRjv5mgh2evPVB5mUUn8TClr0Elu', 'siswa', '2025-09-01 04:26:28', '2025-09-01 04:26:28'),
(454, 'MUHAMAD ANDRE ALPHIANSYAH', '242510191', '$2y$12$pkkle1KsTFOVBnTQ8fijAu5FGEOyT//zbtnZ7UCmfOHYuCXjJoHN.', 'siswa', '2025-09-01 04:26:28', '2025-09-01 04:26:28'),
(455, 'MUHAMAD BOBY FRAYUDA', '242510192', '$2y$12$HCA1rVIzfRqCkmZH/V0uG.xDyY1QBta/Mex60Wv1yWpZJUJ4UMC6i', 'siswa', '2025-09-01 04:26:29', '2025-09-01 04:26:29'),
(456, 'MUHAMAD FAISAL', '242510193', '$2y$12$0vpAW2pRf9tGB7f1R9fQ0uALizgjvJ5Fhzw1fU53OBL5FW.fzgaAm', 'siswa', '2025-09-01 04:26:29', '2025-09-01 04:26:29'),
(457, 'MUHAMAD RAIHAN', '242510194', '$2y$12$j67jAjxcnHSQGZl1kWjnTuXmFE4On30kiLKE5kU5KyyjiL4RDdFgG', 'siswa', '2025-09-01 04:26:29', '2025-09-01 04:26:29'),
(458, 'MUHAMAD RIKI ALFATUR RIZKI', '242510195', '$2y$12$WLI1.pNPh5hHtfkNJLnB9ehCNt26FuGSa6qEfvLaTtLhIU6ZATQ.C', 'siswa', '2025-09-01 04:26:29', '2025-09-01 04:26:29'),
(459, 'MUHAMAD SAUD', '242510196', '$2y$12$L/PIUMqZsfGurpDIIJcTTeoZQ3LS9.Ad.Coyvn6fBKmJD6FFCwliC', 'siswa', '2025-09-01 04:26:30', '2025-09-01 04:26:30'),
(460, 'MUHAMAD TIRTA RUKMANA', '242510197', '$2y$12$r1miWOgsVleYthGXn.vnc.LTWWL.pjsYVb3Ley/eoI7jWyiP0mD6O', 'siswa', '2025-09-01 04:26:30', '2025-09-01 04:26:30'),
(461, 'MUHAMMAD FARHAN MIFTAHUL ROJAK', '242510198', '$2y$12$vam05/wYUwrCtHvEyUPmm.P9mwkDqoQBNk/aQJ5k1kQO7Or/9jfiy', 'siswa', '2025-09-01 04:26:30', '2025-09-01 04:26:30'),
(462, 'MUHAMMAD HASAN BASRI', '242510199', '$2y$12$gCx0fM.4vvmh1SGmWmdQLuffIQ5vygQ.rkYPjPqM5uFxE0FtEcTEe', 'siswa', '2025-09-01 04:26:30', '2025-09-01 04:26:30'),
(463, 'NAJRIL ILHAM', '242510200', '$2y$12$mfju.2IJAZW.QZMFhhv.WuNCH/F8msu0cqkw9roJ5l9jQ3XiiEPYO', 'siswa', '2025-09-01 04:26:53', '2025-09-01 04:26:53'),
(464, 'NANANG KOSIM', '242510201', '$2y$12$oOabCcp9FeElKDfN6RzqCO4nsAUEubNCBru07pvZiS3xrdsPBMJY6', 'siswa', '2025-09-01 04:26:53', '2025-09-01 04:26:53'),
(465, 'RIPA HAMDANI', '242510202', '$2y$12$YONDAMUs3tW6gtm80cjw4.85znCnlRQO4l5gef5iSs2sDNOv.wKf6', 'siswa', '2025-09-01 04:26:54', '2025-09-01 04:26:54'),
(466, 'RIZKI AHMAD HAMBALI', '242510203', '$2y$12$lt67gaQFHc6HyrhIB1SyCeILvxQaCXv13nH51N4TTljBJ0exkvC7y', 'siswa', '2025-09-01 04:26:54', '2025-09-01 04:26:54'),
(467, 'SAEPUDIN', '242510204', '$2y$12$h1mzF6iarjSQbdrS.o2qNO2msTOwa8Qa0mxoKy14GzooCIzpVkAWe', 'siswa', '2025-09-01 04:26:54', '2025-09-01 04:26:54'),
(468, 'SAKTI GENTA AIRLANGGA', '242510205', '$2y$12$8XBaoLl5YommArE2JC0F5ud9Jr6Xa5ivX7Z.CBgjBWCJ/oMof1aZG', 'siswa', '2025-09-01 04:26:54', '2025-09-01 04:26:54'),
(469, 'SASKIA MURNI ATI JUANDI', '242510206', '$2y$12$54KX5/29xXDnBhEo7znc1OqgrYTlRFSiRzvBwYVYLnBtCbYfmIRuW', 'siswa', '2025-09-01 04:26:55', '2025-09-01 04:26:55'),
(470, 'SITI HALIMAH SADIYAH', '242510207', '$2y$12$pF8mIFLBLgXMgsHJbmBznOz2jlE2BkBrMWGDCF/mID6rfw8WXNwRW', 'siswa', '2025-09-01 04:26:55', '2025-09-01 04:26:55'),
(471, 'SODIK RIFAI', '242510208', '$2y$12$X8gKp4txSWx4texxrPH6POfCO1iTrP41wmbM29CtJz4oG7NS/c3NC', 'siswa', '2025-09-01 04:26:55', '2025-09-01 04:26:55'),
(472, 'WIDIA RAHMA SARI', '242510209', '$2y$12$XrqguIFBk0WO2bmhMgQlEuGuTVtJxBmxx.ysGqX8kOLHCU/yJdkg.', 'siswa', '2025-09-01 04:26:55', '2025-09-01 04:26:55'),
(473, 'WILDATUL RAHMATUL UMMAH', '242510210', '$2y$12$2rbyUQ6/12GUdbBYPrSBxOHsEpQGWf./R6eNaUISWGvSALlO43OXe', 'siswa', '2025-09-01 04:26:56', '2025-09-01 04:26:56'),
(474, 'AGNA FATHURROHMAN', '242510211', '$2y$12$A7VX0ez93l27fBruczp2/ub6PzGhmQji.8oSsYhG7CSKmd1EdGKTK', 'siswa', '2025-09-01 04:26:56', '2025-09-01 04:26:56'),
(475, 'ALI AHMAD DINEZAD', '242510212', '$2y$12$sLMgD63M2meoBvsgi7QYkeUxI.0UyVU2HSbtHmsOOMf7h/3OzIxEO', 'siswa', '2025-09-01 04:26:56', '2025-09-01 04:26:56'),
(476, 'ALNAZRIL ANASSYAH', '242510213', '$2y$12$EGzfB3dYGyFW3Fkl4TTwP.lBsjjvxeruHvZ8omW3VM75iy/uCfePK', 'siswa', '2025-09-01 04:26:56', '2025-09-01 04:26:56'),
(477, 'ANGGA', '242510214', '$2y$12$6kQ0GRQM7zqibaQ2mSNYqO9BFjIqYvBOm1wFinQRCykqCp8FxL4My', 'siswa', '2025-09-01 04:26:57', '2025-09-01 04:26:57'),
(478, 'DERI SAEPUDIN', '242510215', '$2y$12$tOcOTVzsbEVATfrzTyihuuEVm.zTOhAawyTYEDwTimwp/vG4XEoo2', 'siswa', '2025-09-01 04:26:57', '2025-09-01 04:26:57'),
(479, 'DIKI PURNAMA', '242510216', '$2y$12$om7sI6nVC.XlGupBRsDeoeS2MwL6a9gqrWMjvyxg7ixLzxVGMuAFG', 'siswa', '2025-09-01 04:26:57', '2025-09-01 04:26:57'),
(480, 'FAUZI RIDWAN', '242510217', '$2y$12$soyEtRWJEb4p5hzIBBGS6uEJWOx60QTCOKYeKj05N08nu1OmbA/fa', 'siswa', '2025-09-01 04:26:57', '2025-09-01 04:26:57'),
(481, 'GILANG ANGGA KUSUMAH', '242510218', '$2y$12$Wau12tCcIEp5NFAXDMhmteOs6Y2qoOj1sxSxzFk.AtRJEGG7rb5Wm', 'siswa', '2025-09-01 04:26:58', '2025-09-01 04:26:58'),
(482, 'IMARRUL UMMARA', '242510219', '$2y$12$eEpjf3cqtkhld0g5TDDDz.ODH2vy1bhixYY6PM0fGXIevNSagOEoy', 'siswa', '2025-09-01 04:26:58', '2025-09-01 04:26:58'),
(483, 'KARTOBI', '242510220', '$2y$12$RWJ.DkyFvYZp7yqq5UGfzePhF8Gu4k8qGU4GwVQctD4Zg0.98VbcK', 'siswa', '2025-09-01 04:26:58', '2025-09-01 04:26:58'),
(484, 'MALIK IBRAHIM', '242510221', '$2y$12$mGz5Ve6pAA7h5LKJO4twruw6iyAg2gy5DBc1L0FdF9u6gBsvJHuga', 'siswa', '2025-09-01 04:26:59', '2025-09-01 04:26:59'),
(485, 'MARSELA', '242510222', '$2y$12$zheOSu.jShTA.OnK3rVriOOsIXX7wVs2bjG2fquatr/HV7HJdmpoC', 'siswa', '2025-09-01 04:26:59', '2025-09-01 04:26:59'),
(486, 'MUHAMAD FARIS DZULFIKAR', '242510223', '$2y$12$mOPPS9xOektvc1Gd0Y.4OeHabHCyCZQ3vsEv9DTMvgViCpop5djua', 'siswa', '2025-09-01 04:26:59', '2025-09-01 04:26:59'),
(487, 'MUHAMAD REHAN BAROKAH', '242510224', '$2y$12$RCGlymqQDD3hzESdiXtYQOeEIjXLa/qtLuthy4.2G.4mbAYZ4DLC.', 'siswa', '2025-09-01 04:26:59', '2025-09-01 04:26:59'),
(488, 'MUHAMMAD RAIHAN FEBRIAN', '242510225', '$2y$12$QzKabjDd2XSbP6kYbJW2y.8ZXlPS9b80U/ZC1Pu1gCFhwjBL.IdpS', 'siswa', '2025-09-01 04:27:00', '2025-09-01 04:27:00'),
(489, 'RADIT RAMDANI', '242510226', '$2y$12$3GiCnhoHsKvJrEcxJyBMYe8P0RusmGzQVn.aafKK5pgHYp0bFDWvq', 'siswa', '2025-09-01 04:27:00', '2025-09-01 04:27:00'),
(490, 'RAMDANI', '242510227', '$2y$12$DgcsMJhbc0Lv2yyaQjtPeOn.0RGP7cuGz0UVXHbaTfnoc2InwiEOq', 'siswa', '2025-09-01 04:27:00', '2025-09-01 04:27:00'),
(491, 'REHAN MAULANA RIZKY', '242510228', '$2y$12$blo.vmcdewHYwD.YmBpck.URqXIeyPI9aBnsKZDrFx7CXcdUA9Jb2', 'siswa', '2025-09-01 04:27:00', '2025-09-01 04:27:00'),
(492, 'RENO APRIAN', '242510229', '$2y$12$Ny1M2b6LkXJOBmOTSvGpZeW4PSm/UCjVZqbtOyrWo45qp8UhhZBVq', 'siswa', '2025-09-01 04:27:01', '2025-09-01 04:27:01'),
(493, 'REYSSA PRIYUNITHA IVANA', '242510230', '$2y$12$CBuVfLalBq85mIlVGqajBuciA9lDpuJB9XOfFoIn6vueqHmcG0xx6', 'siswa', '2025-09-01 04:27:01', '2025-09-01 04:27:01'),
(494, 'RIZKI', '242510231', '$2y$12$2BrkNKcxNY17jOyEDhmx1.ZjzMGdJCCVhv2ioLlMLyVhUI.u/6k.a', 'siswa', '2025-09-01 04:27:01', '2025-09-01 04:27:01'),
(495, 'SRI ANGGRAENI PEBRIANTI', '242510232', '$2y$12$RZBf65OoEUNsIba8q1tIbO3tOYISuCCUd2h8rbGBxdqN0PrbbmSf2', 'siswa', '2025-09-01 04:27:01', '2025-09-01 04:27:01'),
(496, 'TASYA', '242510233', '$2y$12$gugZZyYdmZieDNn3nBcKx.wlCT8h3ExrKzHr8sPumlg5oQ3rxrMIO', 'siswa', '2025-09-01 04:27:02', '2025-09-01 04:27:02'),
(497, 'TAUFIQ HIDAYATULAH', '242510234', '$2y$12$LuSFGo/3A0Ly.hN3fBSEXuQebssOizRG/wk4YF56qtumo5Hkr3qqm', 'siswa', '2025-09-01 04:27:02', '2025-09-01 04:27:02'),
(498, 'TRISTANTO', '242510235', '$2y$12$pxh9XYbcjRuMLzVZQkCgley2XCVBNpB5ixOk0v8vIXSMtJ68M2Zbq', 'siswa', '2025-09-01 04:27:02', '2025-09-01 04:27:02'),
(499, 'WHILDAN SYAHRIZAL WAHYUDI', '242510236', '$2y$12$EkkbE.Lg.uz7xUq79vwZL.ZAEfBJm3.erxCVH14XFai3jPtDVAkyW', 'siswa', '2025-09-01 04:27:02', '2025-09-01 04:27:02'),
(500, 'ABDUL AZIS', '242510237', '$2y$12$LA2.Q7dpYpFHVhiZ5oYL6eR/AQs2TYsL0qK9KwtGoU/9fsW5SGski', 'siswa', '2025-09-01 04:27:03', '2025-09-01 04:27:03'),
(501, 'ABDUL RAHMAN WAHYUDIN', '242510238', '$2y$12$UG5I/PqHhSM57mckX/Oqge3i21N.kSC0jGbeuB5uc7fjl1VWydqq.', 'siswa', '2025-09-01 04:27:03', '2025-09-01 04:27:03'),
(502, 'AHMAD FANANI', '242510239', '$2y$12$xE.t52YsoJ4oqu6r4hXEl.rz.WgbJIaeKTzHXKX4CTZYnZQrR7OWe', 'siswa', '2025-09-01 04:27:03', '2025-09-01 04:27:03'),
(503, 'ALFA NURHIKMAH', '242510240', '$2y$12$gQNsUyHyIs2vB9EjmbTRq.NjiXuldIz8RI.bPTwO67ws10r3EJglC', 'siswa', '2025-09-01 04:27:03', '2025-09-01 04:27:03'),
(504, 'ANDRA PURNAMA', '242510241', '$2y$12$IBZqwXgNxNMH4dv3zUAJWeE2tJ6WURfwVD8OM/2R2O0aiIxqPXoly', 'siswa', '2025-09-01 04:27:04', '2025-09-01 04:27:04'),
(505, 'ARINO ARDAN ARUBETH', '242510242', '$2y$12$vZljrKmoSH.lyTk5VjiRQePVonAHzJ.01zR.Ge3uxSYubpBcN22yS', 'siswa', '2025-09-01 04:27:04', '2025-09-01 04:27:04'),
(506, 'CARSIYAH', '242510243', '$2y$12$.7nepg.93LTcWQuMHISFh.fEfKWyTZYAot.q1lI3cs9ZDhqOCKHce', 'siswa', '2025-09-01 04:27:04', '2025-09-01 04:27:04'),
(507, 'CHICI NURSELA', '242510244', '$2y$12$rs18.dIDwH0ZauqM6BIv3OP7ROCYDfJytMYt1u9DBP89EH79tooqq', 'siswa', '2025-09-01 04:27:05', '2025-09-01 04:27:05'),
(508, 'DALAL IRWANSYAH', '242510245', '$2y$12$o/4574m3NG6bpEWCGTQ3R.iXtNXUOSOadeV2ZQux9OwMESPFAqlU2', 'siswa', '2025-09-01 04:27:05', '2025-09-01 04:27:05'),
(509, 'DODO WIJAYA', '242510246', '$2y$12$BrzTpG6TfFsWn6R7EvSkheeaZaoFNdrNQxByUV5sFRqSHrKIilOmG', 'siswa', '2025-09-01 04:27:05', '2025-09-01 04:27:05'),
(510, 'ELI HAYATI', '242510247', '$2y$12$s7rZXUraiPlqes0bJS5tjOLJliFQzbWQQRDMZ6mejj5UrZ3ye9a1i', 'siswa', '2025-09-01 04:27:05', '2025-09-01 04:27:05'),
(511, 'INDRA', '242510248', '$2y$12$cDq2oxhJQJJcv/rhwJo6Z.c1sAmTtM9ia6PC3a7fY1xk6kAyYbqOS', 'siswa', '2025-09-01 04:27:06', '2025-09-01 04:27:06'),
(512, 'LAILA SAFITRI', '242510249', '$2y$12$XDTMVT/s7gMUfm8kbeAAU.nbl6v9jk/do7nu6mOzg.l2lLa2i6I.a', 'siswa', '2025-09-01 04:27:06', '2025-09-01 04:27:06'),
(513, 'MAESAROH', '242510250', '$2y$12$T9B/teY5Z/MvEMYBlsiOperaPB4WRDqhLmedMJ3Va64X5JBf7pACK', 'siswa', '2025-09-01 04:27:06', '2025-09-01 04:27:06'),
(514, 'MUHAMAD RASYA RAMADHAN', '242510251', '$2y$12$uWflQpPsfp28dvSWnikyeO8bSWg3NzB4SVQRlAugSAwlc73vshQhe', 'siswa', '2025-09-01 04:27:06', '2025-09-01 04:27:06'),
(515, 'MUHAMAD WAKAB', '242510252', '$2y$12$BWLcqZrHB8PdC9YBQ2GB/.xDG1wxeZ6LBIXXOVAbEnrfx6wnJ5JGO', 'siswa', '2025-09-01 04:27:07', '2025-09-01 04:27:07'),
(516, 'MUHAMAD WAKUB', '242510253', '$2y$12$VmCOse6EjMEpHpEcb6RJ4.NbT33v02GCRL3tmBFb.JueTNy2nXUIy', 'siswa', '2025-09-01 04:27:07', '2025-09-01 04:27:07'),
(517, 'MUHAMMAD RIDO RIDWANULAH', '242510254', '$2y$12$dbt.RNw0eqbLRA9e80vbAuuRAOywHqutIfxLB6y5GMLA2qiuYt9tS', 'siswa', '2025-09-01 04:27:07', '2025-09-01 04:27:07'),
(518, 'NAJRIL ILHAM', '242510255', '$2y$12$ZpK1GY5qhhMheaTn7I0C5OxMhv6vg6tnhoAcJ7a5I37.4ogijyMea', 'siswa', '2025-09-01 04:27:07', '2025-09-01 04:27:07'),
(519, 'NIA RAMADHANI', '242510256', '$2y$12$6c73J3MBspuHdlPxydCJPuG/ntluCyUHpCRZ8fpat.BLfG9GhQbJa', 'siswa', '2025-09-01 04:27:08', '2025-09-01 04:27:08'),
(520, 'RANGGA ARDIAN', '242510257', '$2y$12$e5h2//0AsQbXR3A0CIarb.AOU/mfY.yNwbI3U0QKwkROUCLYMaXNq', 'siswa', '2025-09-01 04:27:08', '2025-09-01 04:27:08'),
(521, 'RIZKI MAULANA', '242510258', '$2y$12$9PUlby1Al48pasT5EbnosewlLD3Z7E5/azH81wAaff7Tm.vSF/x7G', 'siswa', '2025-09-01 04:27:08', '2025-09-01 04:27:08'),
(522, 'SOPIAN GUNAWAN', '242510259', '$2y$12$2ngGBcX.jCwt.G/P2BRZ6Oy.fhAu6fY5cCrOIeueDGbO/eXV7IviW', 'siswa', '2025-09-01 04:27:08', '2025-09-01 04:27:08'),
(523, 'SUPRIYATNA RAMADAN PRASTIYO', '242510260', '$2y$12$A2zNkrZKV8jjVfZPZ9BnF.5GlJWwKHwcETVLJX9sNsWApRjM9r7dK', 'siswa', '2025-09-01 04:27:09', '2025-09-01 04:27:09'),
(524, 'VICRY APRIANSYAH', '242510261', '$2y$12$IXmuV2SJDLOjrS//UddyKOwqUyI.A4AMReNrfl1me27NrFy/eMV8u', 'siswa', '2025-09-01 04:27:09', '2025-09-01 04:27:09'),
(525, 'WANA MAULANA', '242510262', '$2y$12$.knAxCZlc8lkYaMWhRGMNe89FxMKT89r4Hev4SEdIQbq3xadDanj.', 'siswa', '2025-09-01 04:27:09', '2025-09-01 04:27:09'),
(526, 'WIRA ATMAJA', '242510263', '$2y$12$cG72BSGrJVtUk/KhrYecuO8NR537JdlYq6u7q5HWG3elvqp639Jya', 'siswa', '2025-09-01 04:27:10', '2025-09-01 04:27:10'),
(527, 'YUDA PRATAMA', '242510264', '$2y$12$9e6m2LPesyqYefFtFQfBzOdyiCW72/opjWaSEi74tChDFgUQvzz42', 'siswa', '2025-09-01 04:27:10', '2025-09-01 04:27:10'),
(528, 'AISAH', '232410001', '$2y$12$gXHhvBgGaFg6ymMvZeYZPO86j0itGAKzXoJx49t3yjYZMMM2d21ei', 'siswa', '2025-09-01 04:27:16', '2025-09-01 04:27:16'),
(529, 'AISAH FITRIYAH', '232410002', '$2y$12$OKXpLb6YJ7BTZIKWJLyZPe9a2TS9b/YRft9VRUTgiUPTxXrxQH8cm', 'siswa', '2025-09-01 04:27:16', '2025-09-01 04:27:16'),
(530, 'ALDI REPALDI', '232410003', '$2y$12$c8ulvuuDxKpUy1yngT.fn.bYAqJVe56g84/Wg34q.GzpORwuw63bC', 'siswa', '2025-09-01 04:27:16', '2025-09-01 04:27:16'),
(531, 'ANISA TRI WAHYUNI', '232410004', '$2y$12$SDhmsFY6Q9dv3AxgIyoXJ.OsEaXNMI4ClV1LsErG6yEx1RgbyQnGi', 'siswa', '2025-09-01 04:27:17', '2025-09-01 04:27:17'),
(532, 'AYU ARISKA', '232410005', '$2y$12$WJMiCB9c/rqAoAztV.cOP.EDLDiw9QEVKAaVplLuASYgnWPePNuza', 'siswa', '2025-09-01 04:27:17', '2025-09-01 04:27:17'),
(533, 'DEA AULIYA', '232410006', '$2y$12$lV703kgLSUGFTKPfCbGAxuKHU1MsPfEhtxKL4oSy3eEW.hH4ztoBi', 'siswa', '2025-09-01 04:27:17', '2025-09-01 04:27:17'),
(534, 'Dedeh', '232410007', '$2y$12$KqSfvxR0mJ8FUACrFDxdXe16euftXYgDV5E/F4aRU3dHkZixzfJze', 'siswa', '2025-09-01 04:27:18', '2025-09-01 04:27:18'),
(535, 'Entin Julyani', '232410008', '$2y$12$LAx6lLkN.44UojwTKOTcBOg1DTB.YTT5wyjfbwgUvZvn7eAfqX0gi', 'siswa', '2025-09-01 04:27:18', '2025-09-01 04:27:18'),
(536, 'HALISA HUMAIRA', '232410009', '$2y$12$IIOGoaUhZGmOztgdEmQ.M.5SRD6nBIOYD3gE8tGP.8me06ZxbOT5O', 'siswa', '2025-09-01 04:27:18', '2025-09-01 04:27:18'),
(537, 'HANIPAH PAUJIAH', '232410010', '$2y$12$Bu.RPkOEDyEWikqkcYCAe.zZ6KcdLnKjX6HjRrdilwAvddJiVMzDW', 'siswa', '2025-09-01 04:27:18', '2025-09-01 04:27:18'),
(538, 'HASBY MAHEZA', '232410011', '$2y$12$61T1NLx6NcPJZftnxkyCo.XFXyqrCOkt3va3xTyMo2ROhNo7L/7xS', 'siswa', '2025-09-01 04:27:19', '2025-09-01 04:27:19'),
(539, 'INTAN AOLIA', '232410012', '$2y$12$TVQOBXPlSurFCrAi1RoZF.PAo00v1Uh748rSQMJfhvvfs2VIZzEBS', 'siswa', '2025-09-01 04:27:19', '2025-09-01 04:27:19'),
(540, 'INTAN NURAINI', '232410013', '$2y$12$LYkMja73kA1RzWNokWGOROMJvSfMH1VoaiQWEkSEBVwnxrCTi4BI2', 'siswa', '2025-09-01 04:27:19', '2025-09-01 04:27:19'),
(541, 'IRMA SULISTIA', '232410014', '$2y$12$KFix3mpWSjcxRfvMTZKA/.u4ZI1y1qDzafp2pWAyhpJpsJDxUmSvG', 'siswa', '2025-09-01 04:27:19', '2025-09-01 04:27:19'),
(542, 'JAHRATUSSYITA', '232410015', '$2y$12$S99kn31XqYPugktsZoFDIeuQpgqzzszSJQtR.3isGWVHfm2zKNgb.', 'siswa', '2025-09-01 04:27:20', '2025-09-01 04:27:20'),
(543, 'JIHAN', '232410016', '$2y$12$QcUVqLB4oz4..o7xIyqLGuBNA3GW6M0wfbgm6cOcjV0s8DzFPhfvG', 'siswa', '2025-09-01 04:27:20', '2025-09-01 04:27:20'),
(544, 'KURNIA FEBRIANTI', '232410017', '$2y$12$7mwpJ0ku0h7ubt.Dt3Cit.b5Wnfp5knqO87k3kT0ScG8lebQxcLWi', 'siswa', '2025-09-01 04:27:20', '2025-09-01 04:27:20'),
(545, 'LALA PADILAH', '232410018', '$2y$12$WFjhqiLE3zEtlhUW1hT4K.QxYaHuSsePJUBQLgCyJ0jDz/SSf.91a', 'siswa', '2025-09-01 04:27:20', '2025-09-01 04:27:20'),
(546, 'NOVITASARI', '232410019', '$2y$12$EUMtDizhDdrucku7IIn4F.wJDXLru1P/ofHWFYxyKNLwgdk9Qs/I.', 'siswa', '2025-09-01 04:27:21', '2025-09-01 04:27:21'),
(547, 'NURLELAH', '232410020', '$2y$12$k.oUAYykrpRv3T49UGkNhubFI4xjV7Y1vYjMuojyFJut8RZxA.IT6', 'siswa', '2025-09-01 04:27:21', '2025-09-01 04:27:21'),
(548, 'NURUL FARHAH', '232410021', '$2y$12$sxNGWl4BsRWsXm1UkNY1tu5poW/i4ko2LYTJwhpuww0Iz8DfMirLG', 'siswa', '2025-09-01 04:27:21', '2025-09-01 04:27:21'),
(549, 'RAHMA AULIA AGUSTIN', '232410022', '$2y$12$XsAUxOYfAb1ShEZzJt/v3egsQbVo8PnKkKT583hGlQPsV7rXxqRzy', 'siswa', '2025-09-01 04:27:21', '2025-09-01 04:27:21'),
(550, 'RIYAN', '232410023', '$2y$12$bVuirGrmaLo.M9kBJv7yd.ummExsQQc4aKlOXHx9wlBp8Z3XjGxRG', 'siswa', '2025-09-01 04:27:22', '2025-09-01 04:27:22'),
(551, 'SINDI ARISKA', '232410024', '$2y$12$fI1sVMNExdt5b.pZQ3SmvubbZvA5mJHPdGzwbfyAJOvmzLs9n.SEC', 'siswa', '2025-09-01 04:27:22', '2025-09-01 04:27:22'),
(552, 'SITI NURAENI', '232410025', '$2y$12$Q0jlSJIblxGFeOBzdUz5pe7mtvaGxN7wOMQCr.J/.aUwQamEpuKgG', 'siswa', '2025-09-01 04:27:22', '2025-09-01 04:27:22'),
(553, 'TRI NOVITA SARI', '232410026', '$2y$12$a5lby96Bt6ksW1MpFLct3OKUxiEv3QI7/PBP9XFmAYCbPU6fItXg6', 'siswa', '2025-09-01 04:27:23', '2025-09-01 04:27:23'),
(554, 'ALVIANI', '232410027', '$2y$12$rKqnethdxyr2ZipKaF4rbeauh3NunZAxFwVZjXonj1Gk5KoSEROke', 'siswa', '2025-09-01 04:27:23', '2025-09-01 04:27:23'),
(555, 'DECA LESMANASARI', '232410028', '$2y$12$4DClaqEsgz6.L9Iiq8OkkORNFsft00G2W09hyUgkholzC382qLGae', 'siswa', '2025-09-01 04:27:23', '2025-09-01 04:27:23'),
(556, 'GINA HERAWATI', '232410029', '$2y$12$rt3nobZblQsXi8gHcq7d.OAwFVxLlPAJpWExe4M9kbpgdZHG7Bsyu', 'siswa', '2025-09-01 04:27:23', '2025-09-01 04:27:23'),
(557, 'INDI LESTARI', '232410030', '$2y$12$9OhzYwF8CWAaZ4/uW.anI.8Ip4vWHXAYeKco7OiU/c34oW3k5cxue', 'siswa', '2025-09-01 04:27:24', '2025-09-01 04:27:24'),
(558, 'JENY SAFIRA', '232410031', '$2y$12$KRv1gYib6Ws9.lUKdl/zZO6GK/oIuv.S8yiS51KAjiWS85o/NkIf.', 'siswa', '2025-09-01 04:27:24', '2025-09-01 04:27:24'),
(559, 'KHILDA SYAFA`AH', '232410032', '$2y$12$UG22SMfdDuSNoxYLPxbw.e3rMI160JZuCovlQixov85yXAkRxlapK', 'siswa', '2025-09-01 04:27:24', '2025-09-01 04:27:24'),
(560, 'LAELA', '232410033', '$2y$12$cGBSmUIMz8ijdW1cJtFG..giTKf2Ix2kTSky9lhJUM73J/0tDOZzK', 'siswa', '2025-09-01 04:27:24', '2025-09-01 04:27:24'),
(561, 'NAILA ADZKYA MAULA', '232410034', '$2y$12$ckjI1IxFpawCSNZ1RjnOmuDZCZ/C5UFbyGJOK9cBzTK8MpcINkcw6', 'siswa', '2025-09-01 04:27:25', '2025-09-01 04:27:25'),
(562, 'NAJWA', '232410035', '$2y$12$lPiK1irfgu3B0Vl5B4SK9eu1OrsZIPxm5zC9M9talaIewlXyjIcCq', 'siswa', '2025-09-01 04:27:25', '2025-09-01 04:27:25'),
(563, 'NARSIH', '232410036', '$2y$12$SRJasax4oYlzARZRLkYSROu8tntbgNlgGFiyeGQTdwJJTb/w8TxVi', 'siswa', '2025-09-01 04:27:25', '2025-09-01 04:27:25'),
(564, 'NIKEN RIZKIA NINTIAS', '232410037', '$2y$12$XbVL0Z4ic3CoLvBMsGJ6tuJ51FPjXuhSQejPCt3YLXtOh465B2Bpy', 'siswa', '2025-09-01 04:27:25', '2025-09-01 04:27:25'),
(565, 'PUTRI JULIANTI LESTARI', '232410038', '$2y$12$zg20n8Ce05PkC8Ezbkt9qerw7AZcQfOlCXlKaaUM72JWkC3pcPt0K', 'siswa', '2025-09-01 04:27:26', '2025-09-01 04:27:26'),
(566, 'RAHMAWATI', '232410039', '$2y$12$Xv2q891SFuL1LVD4ZE/MYeasjvhESx37oHUEByl5KBpZ.PVOjLq.K', 'siswa', '2025-09-01 04:27:26', '2025-09-01 04:27:26'),
(567, 'RATNA DEWI WULAN SARI', '232410040', '$2y$12$qWb/r4kxJD0kzvgYTNWiD.dzVebIePM4fcRfXq5Ew4L1H16hrFq8m', 'siswa', '2025-09-01 04:27:26', '2025-09-01 04:27:26'),
(568, 'REFFA AMELIA', '232410041', '$2y$12$QAfdHYS3RqimAJ7rlMEfFuE/KlC.lsC8pXU.R2uyvUFuDABnH6Cke', 'siswa', '2025-09-01 04:27:27', '2025-09-01 04:27:27'),
(569, 'SAWI', '232410042', '$2y$12$8bEdao6jw7my7ILJo/VZVeMZcAroap7rO8f.eF2OTVdqr187DxMXS', 'siswa', '2025-09-01 04:27:27', '2025-09-01 04:27:27'),
(570, 'SEPTIANI', '232410043', '$2y$12$nkxIX79qCCo68081QjpJoOr3PPLs0bGi17.J53TH6Kzr2e75fMW5W', 'siswa', '2025-09-01 04:27:27', '2025-09-01 04:27:27'),
(571, 'SITI HILDA MAESAROH', '232410044', '$2y$12$IY6dyTvSRUVEKubhyCOHiOHnA0eaZrDoL1RB4lmh2x9gT.XMinAze', 'siswa', '2025-09-01 04:27:27', '2025-09-01 04:27:27'),
(572, 'SITI SOVIYAH', '232410045', '$2y$12$LJO9lqIrJqL7innWL3VWHOZRF.JQ27m5oslUptqA36kBEy30X1Fte', 'siswa', '2025-09-01 04:27:28', '2025-09-01 04:27:28'),
(573, 'SITRA ADILA', '232410046', '$2y$12$Duof27QizbyLIXoC1AYVMuyYnZf7.ziKSF4hLsdo9MHo.YfnUcD.q', 'siswa', '2025-09-01 04:27:28', '2025-09-01 04:27:28'),
(574, 'SRI NURHAYATI', '232410047', '$2y$12$HLVo9FLVi2yxCndb7hzySu5Fl1SOr.FiwQuZAg5W/nst7MG4FvhqO', 'siswa', '2025-09-01 04:27:28', '2025-09-01 04:27:28'),
(575, 'WARI', '232410048', '$2y$12$V0lv9TXFIgMSTQksOQYXZekizJEmZoLlUwZNA6dPnh6QXyoVTZ58a', 'siswa', '2025-09-01 04:27:28', '2025-09-01 04:27:28'),
(576, 'WULAN NURUL ARIFAH', '232410049', '$2y$12$5RBOeR7lTAR5OHaAf2QsJ.Volf7Hq0kMs139wrMqIAPdTvKV4bvrK', 'siswa', '2025-09-01 04:27:29', '2025-09-01 04:27:29'),
(577, 'YUSTIKA DEWI', '232410050', '$2y$12$MfYuYhE/8AaNpXLVgJgYmuDbZzbqSyveI8TgfvAblgGrErvt5j4W2', 'siswa', '2025-09-01 04:27:29', '2025-09-01 04:27:29'),
(578, 'ZAHRA NURI SURYA', '232410051', '$2y$12$vB3HyxEMxPp7JlnVhV4fieQDzubY5ks37DJ7bEsrNn2pwBCs4Vqiu', 'siswa', '2025-09-01 04:27:29', '2025-09-01 04:27:29'),
(579, 'ADAM PRIAMUGA', '232410052', '$2y$12$929obwbh2FTJzgdwqmYmB.giEmyX3nD3V.3Pv/9QxQLBGmfKxh5Qu', 'siswa', '2025-09-01 04:27:29', '2025-09-01 04:27:29'),
(580, 'ADARSONO', '232410053', '$2y$12$0KW7SvSXia8VqRs5w4tBaOtIZ.tHymjG68PRPAZVzwI.dN5BEFbW2', 'siswa', '2025-09-01 04:27:30', '2025-09-01 04:27:30'),
(581, 'AFAHRI SATYA ABDUL', '232410054', '$2y$12$KmA6ziIDxeAryMMu.Hzh.uU7XSOK.RfpGVaUgmT7Swp36OGHLDy/i', 'siswa', '2025-09-01 04:27:30', '2025-09-01 04:27:30'),
(582, 'AHMAD RIZKI ADITIA', '232410055', '$2y$12$EB/Eu.RAZXm3Iz56kY136edOn9EgqQpqX2NQpG474kBHIcABfPeWm', 'siswa', '2025-09-01 04:27:30', '2025-09-01 04:27:30'),
(583, 'AHMAD RIZKY AL MAHMOD', '232410056', '$2y$12$IrFddvxq4c1WCAiwk9E.2eUQthI69dGEE/5F.V1IFZ5ydGPtJ0cJO', 'siswa', '2025-09-01 04:27:31', '2025-09-01 04:27:31'),
(584, 'AJI PANGESTU', '232410057', '$2y$12$5bKfvCkwppy5doxmrzXFd./jQOPIV0iVPRI.nQ8AJgUD.Z6FG8Duq', 'siswa', '2025-09-01 04:27:31', '2025-09-01 04:27:31'),
(585, 'AKMAL KUSRORI', '232410058', '$2y$12$Pg887ZNPpfVguXO9KHY3tusAHLOvH5j5O8x9elpEUBC7b2YskoQEm', 'siswa', '2025-09-01 04:27:31', '2025-09-01 04:27:31'),
(586, 'ANGGA ADITIA', '232410059', '$2y$12$MK7agwJfuCZrbkAiKd6fGOggASVFys0LxtgvjkR8jQZn6Yx9A3mTm', 'siswa', '2025-09-01 04:27:31', '2025-09-01 04:27:31'),
(587, 'ANNISA TUL AULIA', '232410060', '$2y$12$J9NZf729wfRWjYPdkROtR.kr4RqLJjs24m0znCM9.8W0OJ5enk43G', 'siswa', '2025-09-01 04:27:32', '2025-09-01 04:27:32'),
(588, 'AYAN SUPRIATNA', '232410061', '$2y$12$gZQaiw16tPxSpyu4cV9Aq.kFUqel1qaMx4jSdS7BCVgFFgHuygbhm', 'siswa', '2025-09-01 04:27:32', '2025-09-01 04:27:32'),
(589, 'CACA AULIANA', '232410062', '$2y$12$vn5PZae5806HnxpmQlXoOOleqs66q7F9Mj0Psjxx/6P.tGoc6YbqG', 'siswa', '2025-09-01 04:27:32', '2025-09-01 04:27:32'),
(590, 'DIKI SOMANTRI', '232410063', '$2y$12$YE1cH4lWRZq8XZZOW/DZmONBA44kwF2U64Z/3DttPrYf6YKgB2xxq', 'siswa', '2025-09-01 04:27:32', '2025-09-01 04:27:32'),
(591, 'DIRGA RAGIL PUTRA RUKMANA', '232410064', '$2y$12$PulTO0S3dW1IOxE6cHoUJuJAWmwjP8Vuo8LrxZI7CPFEDIf971UTa', 'siswa', '2025-09-01 04:27:33', '2025-09-01 04:27:33'),
(592, 'EVA ALEXA', '232410065', '$2y$12$FWBKTY4GAJPxA1IZpZfL2..jqmFAzzidyc6vU.UUQ.3FzDOYbep1O', 'siswa', '2025-09-01 04:27:33', '2025-09-01 04:27:33'),
(593, 'FAIRUZ FIKHAR FUADI', '232410066', '$2y$12$KckhhJQWzJt0LFvYx9fH2.cvg9SdnVEXEZLeXTXgasWadaCDP7FHu', 'siswa', '2025-09-01 04:27:33', '2025-09-01 04:27:33'),
(594, 'FITRIYANI', '232410067', '$2y$12$W906h5nONJbw6/Hs163SKu3/3x37wxtVMW2vmYpIhcys8oSNiqgCW', 'siswa', '2025-09-01 04:27:33', '2025-09-01 04:27:33'),
(595, 'HIDAYAT AHMAD SIDIK', '232410068', '$2y$12$xzIFs7BWfJCNE2eyycm03uvqpoCuSkXfNHkyEXSq.cMqWF.3cyiwG', 'siswa', '2025-09-01 04:27:34', '2025-09-01 04:27:34'),
(596, 'IRWAN ISKANDAR', '232410069', '$2y$12$QhHsfC2GcD43TWBO2maCxe5nq2uRvAxWzuduC9pq8RHqq2COh3j1O', 'siswa', '2025-09-01 04:27:34', '2025-09-01 04:27:34'),
(597, 'KHOERUL APANDI', '232410070', '$2y$12$QRdhHKmg/wRSqGFOEZOGZ.qKh4VDOdqcmP4xfMCinKF/f7a6xdIYK', 'siswa', '2025-09-01 04:27:34', '2025-09-01 04:27:34'),
(598, 'KUSNATA', '232410071', '$2y$12$GPZlGMmGfz9tQymMk1P4VuaQtdXgKJn6ADyb52FD29hiKnXCrkXrC', 'siswa', '2025-09-01 04:27:34', '2025-09-01 04:27:34'),
(599, 'MUHAMAD EGA OKTAVIAN', '232410072', '$2y$12$8IJ15TBG7zk/pQfLmQTQX.jX5BDlZu9Xb43sqpdmgwgEET8IV.W4C', 'siswa', '2025-09-01 04:27:35', '2025-09-01 04:27:35'),
(600, 'MUHAMAD YUNUS', '232410073', '$2y$12$egstGqZYrR870JDu4mTeCuXCgCz.gCUQwaI2qbcKdmqrZ18mxxH.S', 'siswa', '2025-09-01 04:27:35', '2025-09-01 04:27:35'),
(601, 'MUHAMMAD RAMDANI', '232410074', '$2y$12$C6d6c293SXgV5WrEjFJXa.n2V27NlgRiG5/qWOfr2ETwSvVdkShFa', 'siswa', '2025-09-01 04:27:35', '2025-09-01 04:27:35'),
(602, 'MUHAMMAD RAYHAN RAMDHAN', '232410075', '$2y$12$ffsiV/CW81622LhK.CITsONm0bCnK8tyMBX0h/D8Dlrmz9O9qQX8i', 'siswa', '2025-09-01 04:27:36', '2025-09-01 04:27:36'),
(603, 'RANIA NURDIAN', '232410076', '$2y$12$L8o.6iIg8AWoQe5nfYvWpuI8H1WU3NMTNvuSZaCN1Fp1hcFDsf8Wi', 'siswa', '2025-09-01 04:27:36', '2025-09-01 04:27:36'),
(604, 'ROMLAH', '232410077', '$2y$12$mzY/w56Gtp8oqFnFusmys.8J8EVn8pZJzwn74OjPxM57ODo8FFeAa', 'siswa', '2025-09-01 04:27:36', '2025-09-01 04:27:36'),
(605, 'SAAD APRIANSYAH', '232410078', '$2y$12$tqJ1SnKH16D4E/YlaeznLOkJEF8ha4o4.EplCfP3A1fCM/gG3eReW', 'siswa', '2025-09-01 04:27:36', '2025-09-01 04:27:36'),
(606, 'SANTANA WIDI BAHARI', '232410079', '$2y$12$yDEUqkLJ22DZSnolYSbDR.lnAKwCkkVQf2Qve7m06vkW3dkWOYFSa', 'siswa', '2025-09-01 04:27:37', '2025-09-01 04:27:37'),
(607, 'SANTI', '232410080', '$2y$12$e2l/M/d6gELvyWUpEdQNYuTyp/Q9tZHwBHqC1mF.DxweMYnFtyqti', 'siswa', '2025-09-01 04:27:37', '2025-09-01 04:27:37'),
(608, 'SITI PATIMAH', '232410081', '$2y$12$GPA6Hq0jAkpc7mDs0nJrVO7hEJRUwNLCma0ks9tZp5iuHONnU4gHe', 'siswa', '2025-09-01 04:27:37', '2025-09-01 04:27:37'),
(609, 'TAHRI RAHMADANI', '232410082', '$2y$12$Btr9P0j1GVDSKAPd.dl5POvW7U5vAkUNDc5UmzSx6x2NLbY4QhXOq', 'siswa', '2025-09-01 04:27:37', '2025-09-01 04:27:37'),
(610, 'TANGGUH AZIZI', '232410083', '$2y$12$QIGOXbCJxaBP/..5SPNrwOJ.3AMgWAGrvk8vRTIlqhahOSIRv6wKK', 'siswa', '2025-09-01 04:27:38', '2025-09-01 04:27:38'),
(611, 'TARVIN', '232410084', '$2y$12$HQ8y3/3Yt25ocsyDNgpWXOIFNcJZj5fnAXXZK4D.s0KP1OWs1j7RW', 'siswa', '2025-09-01 04:27:38', '2025-09-01 04:27:38'),
(612, 'AGUSTIAN ABDUR ROFIQ', '232410085', '$2y$12$HDpO8nM/E1hXX9pavhTNa.kRDACqHIEpUBhqo63B6ibKTvNu6HLYS', 'siswa', '2025-09-01 04:27:38', '2025-09-01 04:27:38'),
(613, 'AHMAD REKSA', '232410086', '$2y$12$Ihj7MMupHQB4IiUMpI8XZeMVwdUAk2Nx8muiUXK5X9MgbVOjJOdGa', 'siswa', '2025-09-01 04:27:38', '2025-09-01 04:27:38'),
(614, 'AKBAR RAMADANI', '232410087', '$2y$12$dtFyCHStRsZf3ciZdauKaOl15.4.DEJZ6ol3kVtUuSCPtI5oztdFC', 'siswa', '2025-09-01 04:27:39', '2025-09-01 04:27:39'),
(615, 'ANDREYAN SURYANA SAPUTRA', '232410088', '$2y$12$u/HK/HSlVpTHjO16TicyJ.vMyXp3k2EvHAwnkWcE./e/NlbFBHpE.', 'siswa', '2025-09-01 04:27:39', '2025-09-01 04:27:39'),
(616, 'ARIF PERMANA SIDIK', '232410089', '$2y$12$rg6NYtterV.YtaDgMcoKFur3MttP9x4EsRckLJsOV5Lu2Kum4YFwG', 'siswa', '2025-09-01 04:27:39', '2025-09-01 04:27:39'),
(617, 'AYU ARYANAH', '232410090', '$2y$12$NLFxMDkfoRUvyDhPAnDSGeddxQBVAg6QgQbg8Ao5zP0upp1jZKaAS', 'siswa', '2025-09-01 04:27:39', '2025-09-01 04:27:39'),
(618, 'BUSYAERI MAJID', '232410091', '$2y$12$XnfAmv3lHM9l2K3.iofT..EvfJBrsc9H7I9T2IrKMe9wPrPG5WVN.', 'siswa', '2025-09-01 04:27:40', '2025-09-01 04:27:40'),
(619, 'CARTIWAN', '232410092', '$2y$12$LLMS74Sv7b223W1Smn.PS.IgISo7cJSuZLpTdeJuqGFVswMm.7PnG', 'siswa', '2025-09-01 04:27:40', '2025-09-01 04:27:40'),
(620, 'DAHLIA SRI RAHAYU', '232410093', '$2y$12$6yX9wxhIhOltMGBBSK2yI./o9Vgh8Lvs6vWvstWmqaYdctHjXD9ta', 'siswa', '2025-09-01 04:27:40', '2025-09-01 04:27:40'),
(621, 'DERLY PRASETYO', '232410094', '$2y$12$NnPp5MmEgU54IfhvMINeC.gd4GOiij743Np.2gmIaCFF4Umblm/8.', 'siswa', '2025-09-01 04:27:41', '2025-09-01 04:27:41'),
(622, 'DETIYA KUSMAYADI', '232410095', '$2y$12$rOKOrsp37I4/DHBm2EKMAOISfQasEzM1U4ohtsqkD2I2M8Xz//ir2', 'siswa', '2025-09-01 04:27:41', '2025-09-01 04:27:41'),
(623, 'DIMAS ROHMAN SAPUTRA', '232410096', '$2y$12$8ouveH5crWm/jzWsdw2mgeoHIWn96YgWmKWmL5l3aBOwpUs7mFIOW', 'siswa', '2025-09-01 04:27:41', '2025-09-01 04:27:41'),
(624, 'FAJAR FADILLAH', '232410097', '$2y$12$.IRBz.tV5vfv1H4l6JxVjOjJZyWV9lvixhntfDk8J5P/WM4CiiDJO', 'siswa', '2025-09-01 04:27:41', '2025-09-01 04:27:41'),
(625, 'FIKRI AHMAD MUBAROK', '232410098', '$2y$12$UzyxfPtguWj1Z8imEN8ju.7PNoopcLl1pxZhvK1l1zppmWCCdgKBi', 'siswa', '2025-09-01 04:27:42', '2025-09-01 04:27:42'),
(626, 'GUNAWAN', '232410099', '$2y$12$jB1/E4OuODNoCXj3KeSsD.tlKq9jJqmHhHb3nii7LwnRTP9qIawbu', 'siswa', '2025-09-01 04:27:42', '2025-09-01 04:27:42'),
(627, 'HADI HOERUDIN', '232410100', '$2y$12$.m26eA7.WCK0UfT8jPJR5OMEG9FElfDnrLtnGEe1UpUIHGVafJMFi', 'siswa', '2025-09-01 04:27:42', '2025-09-01 04:27:42'),
(628, 'IBNU QODA', '232410101', '$2y$12$CY3dn8wQqvdUJpWrjorR.uJuAZ6C5kkmAegwdLYGscBE5abyci9B.', 'siswa', '2025-09-01 04:27:42', '2025-09-01 04:27:42'),
(629, 'IHYA ULUMUDIN', '232410102', '$2y$12$xL2II5L9JpV1OPTJDAh.f.Q7VqGpSTufL6IANCRtbYzUBJKxpjz7O', 'siswa', '2025-09-01 04:27:43', '2025-09-01 04:27:43'),
(630, 'INTAN DAHLIA', '232410103', '$2y$12$u6R85ddjkTGB9LZ6O1ZVVO5BNPBTEgVkxFapPp1pNYFtvpDR0uq.W', 'siswa', '2025-09-01 04:27:43', '2025-09-01 04:27:43'),
(631, 'INTAN NURAENI', '232410104', '$2y$12$zFFKD171reN2jHtxWlXHFOZV3tsBZi6SH.hEYiVpg1rHeGgx6vfZy', 'siswa', '2025-09-01 04:27:43', '2025-09-01 04:27:43'),
(632, 'LISNAWATI', '232410105', '$2y$12$VAqxjlbKs.svAH2L.SXMW.zcxhllmJafY4HsGIpMgztId2NmynQiq', 'siswa', '2025-09-01 04:27:43', '2025-09-01 04:27:43'),
(633, 'MAMAN ABDUL RAHMAN', '232410106', '$2y$12$poLvs/fAhCmDLg4ZPmynmO.IUUhh3Oiwxm5QZRlBpvHaeY1EgKCKa', 'siswa', '2025-09-01 04:27:44', '2025-09-01 04:27:44'),
(634, 'MEILANI PUSPITA SARI', '232410107', '$2y$12$DXou84NfS8ciEvEYEgWWlezCVUAcu9CL3z0oKE0xdhm.eSJolB94u', 'siswa', '2025-09-01 04:27:44', '2025-09-01 04:27:44'),
(635, 'MUHAMAD AL NAZIB', '232410108', '$2y$12$3Og6.A/C/kIF8cZS3ZMan.1vu3feiGFl60bAvi6uI7ntgvi8fCgeW', 'siswa', '2025-09-01 04:27:44', '2025-09-01 04:27:44'),
(636, 'NADIA ASMIRANDAH', '232410109', '$2y$12$1Ga5812582Q7DLdmGA5uFe1RO1EDNWD1.H7MvP2.PfdPVqq96GUzm', 'siswa', '2025-09-01 04:27:45', '2025-09-01 04:27:45'),
(637, 'NATA ADITIYA', '232410110', '$2y$12$XtKujAcXVkcMwsAQuq/ADeQK./pHrLnYCXF2hrD1At5HwDKfmYgEy', 'siswa', '2025-09-01 04:27:45', '2025-09-01 04:27:45'),
(638, 'NOFITA DEWAN TARI', '232410111', '$2y$12$SSrKh.EOdP/7uaHSPsnnw.NhR7sjGpvB34RiEB7odweCjLYKnSQIe', 'siswa', '2025-09-01 04:27:45', '2025-09-01 04:27:45'),
(639, 'NOPAL BUKHORI', '232410112', '$2y$12$vEK3310IjulhWNqAFY300Oe.NZQiNkzyHlnkP6HScmkMygg78KHn.', 'siswa', '2025-09-01 04:27:45', '2025-09-01 04:27:45'),
(640, 'NOVIANTI', '232410113', '$2y$12$5ztt6RMLArqJSLTY4A3RCO79RIx1gcsak3YZEAAos.M0.7uDQmZCG', 'siswa', '2025-09-01 04:27:46', '2025-09-01 04:27:46'),
(641, 'RIDWAN FADILAH', '232410114', '$2y$12$/EgGEnqMVVBe/ki7RVY5/uYhsneTx2lCu1vj8PFEGQSCgEWrwNxlK', 'siswa', '2025-09-01 04:27:46', '2025-09-01 04:27:46'),
(642, 'SISKA AULIA', '232410115', '$2y$12$t3Vrp6wm6ZmBRa9BY28scu5vtWxUSuNQtSnMoGaxGezT0H2bMgY9y', 'siswa', '2025-09-01 04:27:46', '2025-09-01 04:27:46'),
(643, 'SUHENDAR', '232410116', '$2y$12$a2eZnYvmQWRrLVhPX1SifuujNIolZvrZihVrn7jgHKs5aCe60Bn26', 'siswa', '2025-09-01 04:27:46', '2025-09-01 04:27:46'),
(644, 'TOMI', '232410117', '$2y$12$8ERKdcWsgnk2lSH1SoDh7uSqGjfCLg/La3eYnZFHapFI587KsnskC', 'siswa', '2025-09-01 04:27:47', '2025-09-01 04:27:47');
INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(645, 'WARTA', '232410118', '$2y$12$KXMBMO5g8GUfs7Fo7PSdROv/DIGCx91PWAX5qxMvQYv1jMW9N8yby', 'siswa', '2025-09-01 04:27:47', '2025-09-01 04:27:47'),
(646, 'ADAM MARIANSYAH', '232410119', '$2y$12$0uDxUNhs3X8ju.UIVD/Y5uMXPXTMYpG.1W0ht/pp63Zw2FgRO7Twa', 'siswa', '2025-09-01 04:27:47', '2025-09-01 04:27:47'),
(647, 'AJIJAH LESTARI', '232410120', '$2y$12$S6PT3mcEJh8e.45crBmIz.NyO.ELCpFLV21vDbHNvuctlAwttGzDy', 'siswa', '2025-09-01 04:27:47', '2025-09-01 04:27:47'),
(648, 'ANDRIAN', '232410121', '$2y$12$Y0yRIZviQg6kSpKM6cZLN.1ouRzwrozkQ8kjZ/BIKUIPODs/KV12m', 'siswa', '2025-09-01 04:27:48', '2025-09-01 04:27:48'),
(649, 'DENDI PRASETYO', '232410122', '$2y$12$ZR9F38A5KTRyfoZ5IpVs7OSSBP1lbPdiH4/WtAJnH945FiCLIdgmW', 'siswa', '2025-09-01 04:27:48', '2025-09-01 04:27:48'),
(650, 'DIANA PUTRI AWALIAYAH', '232410123', '$2y$12$7C.Qd6PdC.DYAxu8J/rmu.iLa5r/lcWEG8S65kkDqpyd4p74l9Wwy', 'siswa', '2025-09-01 04:27:48', '2025-09-01 04:27:48'),
(651, 'DIFA HARIKURNIA', '232410124', '$2y$12$.hxe/GbYlINbzsezRN0Gjejh6Mt1z2TKC5G5p/v1q8iI.zxA8ujoa', 'siswa', '2025-09-01 04:27:48', '2025-09-01 04:27:48'),
(652, 'ENAH MAEMUNAH', '232410125', '$2y$12$xY6IuMMvWVLlRdDcHUOckewY91VNVyHhETOHhqVOcC9Mr2I0fS/iO', 'siswa', '2025-09-01 04:27:49', '2025-09-01 04:27:49'),
(653, 'FAIQ AHMAD NAUFAL', '232410126', '$2y$12$m5fYUcjSoxa73qB/gcXJuOChJjZ5ajU8sZgMmsAhTFfmK0BboL8cW', 'siswa', '2025-09-01 04:27:49', '2025-09-01 04:27:49'),
(654, 'FERI SOPANDI', '232410127', '$2y$12$zWPazpWqV4ny9pZlNFSTz.UfWSw9xWo7n5NcNm5uBbYM94GXbfwpC', 'siswa', '2025-09-01 04:27:49', '2025-09-01 04:27:49'),
(655, 'IKBAL MAULANA IBROHIM', '232410128', '$2y$12$oLT8VSYSeZ/YZMK/VAilV.QezukqMufYe1ta7sVhUssvv478jK7qy', 'siswa', '2025-09-01 04:27:50', '2025-09-01 04:27:50'),
(656, 'KASMINAH', '232410129', '$2y$12$EDJj4hPWqJ9un.RiT2Wy9.0VFNMdu3Yc9WB2I0Wk/ONWba3FsaQaG', 'siswa', '2025-09-01 04:27:50', '2025-09-01 04:27:50'),
(657, 'KATIMAH', '232410130', '$2y$12$klwQvtwCwc63b.7cjS6FheWWXK28YFT5IWhnrqSyMad4rkJLBwM2G', 'siswa', '2025-09-01 04:27:50', '2025-09-01 04:27:50'),
(658, 'LIGAR', '232410131', '$2y$12$f8INiTRAmfTA7wiTk8YuJOcGdmTojmUrQPHYynuCVg5MsUCtFK7bC', 'siswa', '2025-09-01 04:27:50', '2025-09-01 04:27:50'),
(659, 'MAYA', '232410132', '$2y$12$GqxxfrvGv.52oKxBc1DJV.R.AXMOwoxQ8adTPLzfHrZvQ0iEF6e0a', 'siswa', '2025-09-01 04:27:51', '2025-09-01 04:27:51'),
(660, 'MOH THOLIB RIVKI', '232410133', '$2y$12$Q2Ab84QkQl5ne/oAbSEo8Oy5tj1OL.fcyxhVs0qzNv8d798CJFTQG', 'siswa', '2025-09-01 04:27:51', '2025-09-01 04:27:51'),
(661, 'MOHAMAD FEBRY AULIA', '232410134', '$2y$12$p3/JzAyDsrpP1jY69DRYnO87tmQoOe16mcphjYrkSkNVwcMnzNkBG', 'siswa', '2025-09-01 04:27:51', '2025-09-01 04:27:51'),
(662, 'MOHAMAD RIDWAN', '232410135', '$2y$12$WrjmI56WM4YA2mBWUunk/udGqJ62mOgv4SQ1EKKXoZt7oCMmWPqbO', 'siswa', '2025-09-01 04:27:51', '2025-09-01 04:27:51'),
(663, 'MUHAMAD HAIDAR RIFAI', '232410136', '$2y$12$X4c0TpFTkVL.d8rQ5WnU0Oc.jm4am21tpE9ZeCTkJxvxDvadRLUa2', 'siswa', '2025-09-01 04:27:52', '2025-09-01 04:27:52'),
(664, 'MUHAMMAD WAHYUDI', '232410137', '$2y$12$2AfUunF7B30Rd6F4Xr7w8udTqPLfBsB0hPANX3JNZLo16C4zO8giu', 'siswa', '2025-09-01 04:27:52', '2025-09-01 04:27:52'),
(665, 'NADILA LIESHARTANTI', '232410138', '$2y$12$q.ZjeTrA2y0UASjmUAV3uOtKv.HJhQqZi4HxnHvUA3OqvdzMFK7sW', 'siswa', '2025-09-01 04:27:52', '2025-09-01 04:27:52'),
(666, 'NARMAN', '232410139', '$2y$12$aSIA1pl.pMPQLlONW8ENUupjgo3jMZmaV/tyPUzwmti7CDUfmTes2', 'siswa', '2025-09-01 04:27:52', '2025-09-01 04:27:52'),
(667, 'NOVA YANTO', '232410140', '$2y$12$QX9ha5dKXfrJGQgcXPBL7etT8n7VIZeqKaknJf9J31/o0tUo.4ccG', 'siswa', '2025-09-01 04:27:53', '2025-09-01 04:27:53'),
(668, 'OGI WIRAGUNA NAMRAIH', '232410141', '$2y$12$T7lezcf0GZfgJAlnNqx.kemHhTVoeKZKqobLS6OL24s15IH5uazb2', 'siswa', '2025-09-01 04:27:53', '2025-09-01 04:27:53'),
(669, 'PEPEN FAISAL AGUSTIAN', '232410142', '$2y$12$47Pe0JiOjBeNwGPoIB8jEudfHzVdXp/TT3XJX8mf8TUvy6Tk0V5PG', 'siswa', '2025-09-01 04:27:53', '2025-09-01 04:27:53'),
(670, 'RAHIL TRISNA', '232410143', '$2y$12$8.EC/nPFg3vlP5re4VkGj.bLzqikcXDjc9.9C0lskmC.U.2yYfGXO', 'siswa', '2025-09-01 04:27:53', '2025-09-01 04:27:53'),
(671, 'RAMDANI', '232410144', '$2y$12$gRiN85GBfknWi/U6MK1Gw.4zbZmWcAQ0zunPUfybOvPBWszvmssGO', 'siswa', '2025-09-01 04:27:54', '2025-09-01 04:27:54'),
(672, 'RANGGA MUHAMAD FARHAN', '232410145', '$2y$12$MV4m8hZekWkeGkq24RDoGOXlC6P0ARvpg3WZ1dZzkUJKWVbmKR4Qm', 'siswa', '2025-09-01 04:27:54', '2025-09-01 04:27:54'),
(673, 'RATU AYU SARI', '232410146', '$2y$12$cRgyHG2YBUQlCHM8Uaz52uDrGh9Hs8E92T8BQduLmC7zpJ8XMDlGi', 'siswa', '2025-09-01 04:27:54', '2025-09-01 04:27:54'),
(674, 'RENDI SUJAYA', '232410147', '$2y$12$3W2djMwuX2f.RQMMX4dKL./PCRLJUZq3W9yuyaLD.q7xmn8f2dahG', 'siswa', '2025-09-01 04:27:55', '2025-09-01 04:27:55'),
(675, 'RENO AL FAUZI', '232410148', '$2y$12$9KkCwOGqVb9kOZ9zWgH0iuapNviU5NDqwST8DSBGf3QZ47HZcPqYC', 'siswa', '2025-09-01 04:27:55', '2025-09-01 04:27:55'),
(676, 'RIDWAN IBNU AL FARIJI', '232410149', '$2y$12$1nNlkvuSMkSqbjr98GCTku2kwyHB8Rlt0heuU.XK4JDF6YCMFCM6a', 'siswa', '2025-09-01 04:27:55', '2025-09-01 04:27:55'),
(677, 'RIFA AHMAD SOFYAN', '232410150', '$2y$12$FJZfVZfZi.V16KGuS5TJ7OqYfyXfOX94EY9UZbiyEhs9E7pUJX4Wq', 'siswa', '2025-09-01 04:27:55', '2025-09-01 04:27:55'),
(678, 'SULTAN PERMANA PUTRA', '232410151', '$2y$12$Xq7/UdkBF/NaXVJ6l.fS6uwtR9ksIaeMdmfCfwL58XbRQrsMFIHry', 'siswa', '2025-09-01 04:27:56', '2025-09-01 04:27:56'),
(679, 'SUPARDI', '232410152', '$2y$12$z1js5c6xD9425cI4zF3b0OeSeNczui/ifZc81SLyk.99S2HOFQ1Ry', 'siswa', '2025-09-01 04:27:56', '2025-09-01 04:27:56'),
(680, 'WIDIA', '232410153', '$2y$12$Kr/2Mp/bprd7Ts8TG09HYOyvLG5ubhTUZ1m4j1ZqOYVuTK5egfPyu', 'siswa', '2025-09-01 04:27:56', '2025-09-01 04:27:56'),
(681, 'ABDUL ROSID', '232410154', '$2y$12$GAJCG/VFfc2ec.PwgEFVH.Km2HX.StK/S0o1Gjp6aJk1bus.Ln8dG', 'siswa', '2025-09-01 04:27:57', '2025-09-01 04:27:57'),
(682, 'AGUS', '232410155', '$2y$12$B7w143xOusSpk9.stSAb4u6rmGE2IE1lnoJ4TJWhSopH7PZ3TmMLa', 'siswa', '2025-09-01 04:27:57', '2025-09-01 04:27:57'),
(683, 'AHMAD BAGIR', '232410156', '$2y$12$.WaVhzQaN6nhafLKliSaQuPkfunAgS203lTiRDVvcBIG076EB27.6', 'siswa', '2025-09-01 04:27:57', '2025-09-01 04:27:57'),
(684, 'AKBAR BAIDILLAH SATORIK', '232410157', '$2y$12$.svPNlWpCCF0JE5pdhGdoerjVH8oxviMqBPW5LHnei1TvCk2zWmFq', 'siswa', '2025-09-01 04:27:57', '2025-09-01 04:27:57'),
(685, 'AMIRAH YULYANTI', '232410158', '$2y$12$Wr6Yv7MPRakB8/dj/nQx2e.UFoARYiDSvGaIe4r0gOUc9RVkvNfHS', 'siswa', '2025-09-01 04:27:58', '2025-09-01 04:27:58'),
(686, 'ANGGUN LESTARI', '232410159', '$2y$12$Kw2.R3WYsNCiKeldPgOsl.GBq25ib9yoh9U/7Eru7OB33MPmLM9Je', 'siswa', '2025-09-01 04:27:58', '2025-09-01 04:27:58'),
(687, 'DAHVA DERIANSAH', '232410160', '$2y$12$uPtj4yI6bbI1gd/7GJuAHu2Vgp2Zw48BeBVNVeQ0p51eesFf/WEn.', 'siswa', '2025-09-01 04:27:58', '2025-09-01 04:27:58'),
(688, 'DANA MAULANA', '232410161', '$2y$12$GtREnWQyVjy6EvkD3ZoXN.3y7mWELhhNhiV7vv7PHdEn3HEUhCjAa', 'siswa', '2025-09-01 04:27:58', '2025-09-01 04:27:58'),
(689, 'DEA NOVITA', '232410162', '$2y$12$ahiiJUs/Jc8ijkqJkQsbyOM3EfgRfD/.O12uI.NMyt6gUO656PSaC', 'siswa', '2025-09-01 04:27:59', '2025-09-01 04:27:59'),
(690, 'ELVIRA SELOMITHA ALENA', '232410163', '$2y$12$EhmhtUwF55h/VCXtSSdHrOVvvKMpiahNuzGAgEOCHUs/m6wbWzfP.', 'siswa', '2025-09-01 04:27:59', '2025-09-01 04:27:59'),
(691, 'FACHRY HABIBURROHMAN', '232410164', '$2y$12$h6P8SbcK6yu3rtXpFnT3EuoSvElrinrzrHQgwigOWLPQeIW720mVy', 'siswa', '2025-09-01 04:27:59', '2025-09-01 04:27:59'),
(692, 'FEBRIAN', '232410165', '$2y$12$zen5RfPfUBQ3L.huX1XdPebkO86b.fRFAu5vLNLYieVKyzsO1VMmy', 'siswa', '2025-09-01 04:28:00', '2025-09-01 04:28:00'),
(693, 'JANE DIKE PUTRI ARIAWAN', '232410166', '$2y$12$XEspvlsQIprKYJn77i4zeumhwnEFCWI372.Xms6716NR1bXQ/oNAm', 'siswa', '2025-09-01 04:28:00', '2025-09-01 04:28:00'),
(694, 'KOMALASARI', '232410167', '$2y$12$5Q/DIULZzuh6EoVq9wvN..Wihtbt./z/8iZszL/cc78aK1qJTJ5o.', 'siswa', '2025-09-01 04:28:00', '2025-09-01 04:28:00'),
(695, 'LUVITA RAHMA SARI', '232410168', '$2y$12$fYA0anK/HpiidFPkGEhICO9CM0rU9ANGu7KxcQo52lAP.h60tlyGq', 'siswa', '2025-09-01 04:28:00', '2025-09-01 04:28:00'),
(696, 'MAHMUD MUNANDAR', '232410169', '$2y$12$xwUjLT53ojTT/1QDta7o3Om89tFE8FZjsEUnfaE4ONAXacVUDThYC', 'siswa', '2025-09-01 04:28:01', '2025-09-01 04:28:01'),
(697, 'MARISA LINDA LESTARI', '232410170', '$2y$12$sz/L0SiRbdNsViVUtkuQ1uYEeoARTGf9jior7/YkTOZo1sU/dihe.', 'siswa', '2025-09-01 04:28:01', '2025-09-01 04:28:01'),
(698, 'MILA SARI', '232410171', '$2y$12$BFzIBZqeGq0.aVyhSLfdkOhzdR3MnY9pUZxTyD2UL8kf/7Y/.2e/O', 'siswa', '2025-09-01 04:28:01', '2025-09-01 04:28:01'),
(699, 'MUHAMAD RAIHAN GUMILAR', '232410172', '$2y$12$Ezx2tnW09JAZo8gmLaLml.WaBcGiSI8yndxjes0PhG.yg/bHZsOzi', 'siswa', '2025-09-01 04:28:01', '2025-09-01 04:28:01'),
(700, 'MUHAMAD YUGA', '232410173', '$2y$12$XSRBbJIoZ/9pYN0nS.p.ZuQaK4cgmqr6m7l6gn5/MDaWekVZZNfni', 'siswa', '2025-09-01 04:28:02', '2025-09-01 04:28:02'),
(701, 'RAFI ALHABSY', '232410174', '$2y$12$Zj8uFHmUUB45iI4Xd9lqyeLrr2t3Ylb2YnelymRbWnq6T28rSnOFG', 'siswa', '2025-09-01 04:28:02', '2025-09-01 04:28:02'),
(702, 'RAHMAN', '232410175', '$2y$12$RpoiNVOt8MTwvYvl2dfzw.7RB0dUGF4i17jYl4LP9XH2MtSg/ERRG', 'siswa', '2025-09-01 04:28:02', '2025-09-01 04:28:02'),
(703, 'RAZAN MUHAMMAD IHSAN', '232410176', '$2y$12$5RGTqFLc3A9zvZVcXpVAmupdisvRwHEDIvEcGDGy8hzgGP6Uo33LO', 'siswa', '2025-09-01 04:28:03', '2025-09-01 04:28:03'),
(704, 'RIAN ADRIANSYAH', '232410177', '$2y$12$V.tiwYdEH2jMsjmnJnvOVeVFktaOcqBj9LUF8d7LD./R.lRsgEuOW', 'siswa', '2025-09-01 04:28:03', '2025-09-01 04:28:03'),
(705, 'RIAN FIKRIANSAH', '232410178', '$2y$12$G.8B9E/IowAPBYjMpYKKgOduN2nF.ceXk8DEnvViHvOREZ9byK5py', 'siswa', '2025-09-01 04:28:03', '2025-09-01 04:28:03'),
(706, 'RIF AN RIZIQ', '232410179', '$2y$12$NRcmiBJdPIsqe0psO8MWoenDwbE38Lsj.UClLo2cfzYaNxsu0hKHa', 'siswa', '2025-09-01 04:28:03', '2025-09-01 04:28:03'),
(707, 'ROHMAT HIDAYAT', '232410180', '$2y$12$ZKQUFBZHq0Dn1D..pM2cNeXl2IiwAMTITw28g3Sl6tVLYNRAHcd4C', 'siswa', '2025-09-01 04:28:04', '2025-09-01 04:28:04'),
(708, 'RUDITA PRATAMA', '232410181', '$2y$12$xVGvVKi6sn.Dq1cGap4FKumACUnu/AEQHH6umLo8581EgWCtC/1H.', 'siswa', '2025-09-01 04:28:04', '2025-09-01 04:28:04'),
(709, 'SOPAN SOPIAN', '232410182', '$2y$12$H7tVoINTxSxIOlvDeQIAme6VQZJmLXAlYK.PrZbzMKm9ioDkLKcXO', 'siswa', '2025-09-01 04:28:04', '2025-09-01 04:28:04'),
(710, 'SRI WULANDARI', '232410183', '$2y$12$UbICpE1ra0GE4t85B9OyYeYpGWZnx/k/AUosU5HBoongkCLnXNqPK', 'siswa', '2025-09-01 04:28:04', '2025-09-01 04:28:04'),
(711, 'TONI JAYA SAPUTRA', '232410184', '$2y$12$ZlLigC5YHDmzzndZ90I.q.7E62LzbwqCsKpoYQVMHfEdP5SyrqwT2', 'siswa', '2025-09-01 04:28:05', '2025-09-01 04:28:05'),
(712, 'USUP', '232410185', '$2y$12$IW8BOpNLpD38CJBRIFkT1.Aqzcy0hkJC5lBzYxdVlybBGpcX.JLbq', 'siswa', '2025-09-01 04:28:05', '2025-09-01 04:28:05'),
(713, 'WAHYU REKSA DIFA', '232410186', '$2y$12$2BNJhSLV9os9IFjEFGNa7O7q5YF3vZjD6VRfvDIziFN7lKG0TXi32', 'siswa', '2025-09-01 04:28:05', '2025-09-01 04:28:05'),
(714, 'YAYAN HERMANTO', '232410187', '$2y$12$Sjjb6I1P1gjjipjVdc9x7ei48ygo4pfYMA43.s32y3J/LF31SRd.u', 'siswa', '2025-09-01 04:28:05', '2025-09-01 04:28:05'),
(715, 'AHMAD FAUZAN', '232410188', '$2y$12$WEj0flZGTP6tsD2syOYYieCFA6OuL/QLXHgeX4UXg7EX0aHNEM4A6', 'siswa', '2025-09-01 04:28:06', '2025-09-01 04:28:06'),
(716, 'AKBAR NANDA RUKMANA', '232410189', '$2y$12$tuFOC08Fep1f/Mrwp4KF9O9p56pVTmc9THhsRd1HcO/VJ4YXbsZ8i', 'siswa', '2025-09-01 04:28:06', '2025-09-01 04:28:06'),
(717, 'ANGELLYA', '232410190', '$2y$12$3qjtNHubKsXMecVqbxFJPu1hbOxKwASpXJbZh/aaKghX5YRucumCW', 'siswa', '2025-09-01 04:28:06', '2025-09-01 04:28:06'),
(718, 'APID', '232410191', '$2y$12$pdVn3SdkQs4R1uSrvIGhROs/bUWR2WPljaH0eAWk7ZPqym4acgc1q', 'siswa', '2025-09-01 04:28:06', '2025-09-01 04:28:06'),
(719, 'DIAN MUHLISOTUL ULFIAH', '232410192', '$2y$12$K..gxhfx85fgcdS0tFNEGeeTGvKYh6cSuFJjiHK9scsTXorPKXAha', 'siswa', '2025-09-01 04:28:07', '2025-09-01 04:28:07'),
(720, 'DIAN PERMATASARI', '232410193', '$2y$12$og.Xv3/NOR2cdoDqPyIuG.HcuJhG2FM..RXtIwpToISorbAiX65r2', 'siswa', '2025-09-01 04:28:07', '2025-09-01 04:28:07'),
(721, 'EKA PURWANA', '232410194', '$2y$12$JNRE78/RuU2Mlkz0ZhTuXu8fc.LWh3uET4BQQs4nQomHxqEcAqopK', 'siswa', '2025-09-01 04:28:07', '2025-09-01 04:28:07'),
(722, 'FAISHAL FAKHRI', '232410195', '$2y$12$7ueulu57cU0c5mSz3vJJrOPOLFOpdVL6mr94P7JnGUK3OARw/jvVW', 'siswa', '2025-09-01 04:28:07', '2025-09-01 04:28:07'),
(723, 'HADI RAHMAN', '232410196', '$2y$12$acJpfgtRubTAK0qJGhC1z.KRczzkq.gcgV4v/T13IwVq9Au4heNKe', 'siswa', '2025-09-01 04:28:08', '2025-09-01 04:28:08'),
(724, 'INTAN', '232410197', '$2y$12$hn7AsigBrFuQywBLz9.9hex7RpcqASzpkOxI8nttb8Q0Zh8asG3uG', 'siswa', '2025-09-01 04:28:08', '2025-09-01 04:28:08'),
(725, 'IRSAN TICKNO', '232410198', '$2y$12$W5oKy.duo5fhjJc2G9UzOunnNk5h1Zp1HfEOa2SzXK7mGEPRTS09O', 'siswa', '2025-09-01 04:28:08', '2025-09-01 04:28:08'),
(726, 'JAJANG KOSWARA', '232410199', '$2y$12$Th4fXax8/7aF/AwCTCAFUetADmPz2SOAXKw.4xotog5MP3I2PeHIm', 'siswa', '2025-09-01 04:28:09', '2025-09-01 04:28:09'),
(727, 'JIHAN HOLIYANA', '232410200', '$2y$12$ak4iI3KyD3wVdlxqL.DURuFreega657R4w9dD3TJHcaO2xHVZIO8G', 'siswa', '2025-09-01 04:28:15', '2025-09-01 04:28:15'),
(728, 'MARYADI', '232410201', '$2y$12$ZsZEO2FqV026ssmwWxkObeT4XlecLwwsga21zKfBt8kqYYwodJx.m', 'siswa', '2025-09-01 04:28:15', '2025-09-01 04:28:15'),
(729, 'MUHAMAD ALIN', '232410202', '$2y$12$H0k/8S63rUOwjNLJBFKgyeoSQ5YSbtErjGDr9l77YIW0rDq6LoDim', 'siswa', '2025-09-01 04:28:16', '2025-09-01 04:28:16'),
(730, 'MUHAMAD RONI ADITIA', '232410203', '$2y$12$ChtyspiQYGsCP.PrayzFyuztprV3RbWHvIWcfKyqLEas2XS7Aq3hy', 'siswa', '2025-09-01 04:28:16', '2025-09-01 04:28:16'),
(731, 'MUHAMMAD REIVANDI', '232410204', '$2y$12$GukEv5dLDjOokxyp06i4Qu.lRVn1iyt/boPrYrCwz6U/uQI8cEaYa', 'siswa', '2025-09-01 04:28:16', '2025-09-01 04:28:16'),
(732, 'MUKHAMAD MARUF', '232410205', '$2y$12$2Yu6.kY8JlATkKfw8VpPe.i3O1kl4bKdU5TFLFtFDGg4PW9R8rGvS', 'siswa', '2025-09-01 04:28:16', '2025-09-01 04:28:16'),
(733, 'NURI AGUSTINA', '232410206', '$2y$12$dGN73z9XW2.gDZbcjZIYXuPchwWG8wpXjiNwUjDAeHHYcBmvJrnbu', 'siswa', '2025-09-01 04:28:17', '2025-09-01 04:28:17'),
(734, 'RAHMAT HIDAYAT', '232410207', '$2y$12$OY2h/V5D9EWi0k36.ivL0ufsYgaMl98vq8y5sUmhjPGFgrMiVu0wm', 'siswa', '2025-09-01 04:28:17', '2025-09-01 04:28:17'),
(735, 'RAMDANI', '232410208', '$2y$12$9R1yuwn8WMJek5Vi5yXF4u5zwhBigdsRyJv9.HrO0Ju14jdm/Qchm', 'siswa', '2025-09-01 04:28:17', '2025-09-01 04:28:17'),
(736, 'REYJA', '232410209', '$2y$12$KoBn4rvXASF8lklqzB/x6unwRRS/ToSPdchmbSXBLCaacQ4bWz1hC', 'siswa', '2025-09-01 04:28:18', '2025-09-01 04:28:18'),
(737, 'RIYAN ARYANTO', '232410210', '$2y$12$tFe6Tp3bJ3Kdqk3UtOuN9OhOfE4z.wGh7tBI7UZSj2ikrOgf3oYe2', 'siswa', '2025-09-01 04:28:18', '2025-09-01 04:28:18'),
(738, 'RIZZKI AKBAR ALFATIRI', '232410211', '$2y$12$ASSUG0Yb45nyNsJPsn7USuAKtnJVaqZne7HFydzkT5A4lBYYYclC.', 'siswa', '2025-09-01 04:28:18', '2025-09-01 04:28:18'),
(739, 'ROPI LORO SOPANJI', '232410212', '$2y$12$us9ttYeyq6sWnvYM.eQa0.GdO6lFP8DV0/t/q1crpWPFi./Amsog2', 'siswa', '2025-09-01 04:28:18', '2025-09-01 04:28:18'),
(740, 'SUYUTI AHMAD BUSAERI', '232410213', '$2y$12$tibtkaGUiZiyeMQti6HnrOYA67FZ1bNoNLUl87eOtUya.PYp/aveG', 'siswa', '2025-09-01 04:28:19', '2025-09-01 04:28:19'),
(741, 'TITI NURJANAH', '232410214', '$2y$12$zIm12uYTxzZja01NIMICi.GnQ84zd.X32b.4RvCJdUy2ehBjoJpHK', 'siswa', '2025-09-01 04:28:19', '2025-09-01 04:28:19'),
(742, 'WIRANATA', '232410215', '$2y$12$rB5L/EyT9cGLz1N5p/nZ9eQm8nCw25lIvr58tiEmU/ccja4PG0ZIq', 'siswa', '2025-09-01 04:28:19', '2025-09-01 04:28:19'),
(743, 'YAZID RAHMAT HIDAYAT', '232410216', '$2y$12$X//GxHxUEdoWaHj5GbmYFe4dwOLdFvdDxok.1ZvHA6nrBQFbtAk.y', 'siswa', '2025-09-01 04:28:19', '2025-09-01 04:28:19'),
(744, 'YUDIS TIRA ROMANSAH', '232410217', '$2y$12$GfneSb6bO7pGKCB8uk5f0.RVMBDdedxn/Si.JVtAJIBfq5ZlB5tiG', 'siswa', '2025-09-01 04:28:20', '2025-09-01 04:28:20'),
(745, 'YULI DEWIYANTI', '232410218', '$2y$12$mA2W2tVa1xlZTUMFYEltReiuDVsgTNwu9O./UpVWQLwLYboU0NKX6', 'siswa', '2025-09-01 04:28:20', '2025-09-01 04:28:20'),
(746, 'YULITA', '232410219', '$2y$12$d4.JYfRt2BdqWfcyHX4KB.C34mk.wj/IvHN3jjEXEBt5121yNSoni', 'siswa', '2025-09-01 04:28:20', '2025-09-01 04:28:20'),
(747, 'ABDUL RONI', '232410220', '$2y$12$IkKORePgZQOBtV97hFaccefG.05fDJHCRiU/RfAQ8v1DhzzDbjFNW', 'siswa', '2025-09-01 04:28:20', '2025-09-01 04:28:20'),
(748, 'ABDUL SIDIK', '232410221', '$2y$12$XwIC1Km9JURrjtjJLdXuSu5PvRYmJSGEFPzNSqVQBsjBF06Y3sBQu', 'siswa', '2025-09-01 04:28:21', '2025-09-01 04:28:21'),
(749, 'AEL GHAZALI', '232410222', '$2y$12$a3d60QMbjrZMhnzc6uwNDOX2KHoUC3A4xJjSTQnuiBn4Vm1V8Zri2', 'siswa', '2025-09-01 04:28:21', '2025-09-01 04:28:21'),
(750, 'AHMAD FAHRI YUNMAR', '232410223', '$2y$12$3DGWpG4WuHsmgKtOAwidsu6wWdCe/d44mkjfgxtiHPyMjDjHK0Nu6', 'siswa', '2025-09-01 04:28:21', '2025-09-01 04:28:21'),
(751, 'AHMAD ZAKKY JAELANI', '232410224', '$2y$12$yaeErELUkLk7aQIepXusLe43holFRY45uby3OZJ.rFAoNUO2wzEn2', 'siswa', '2025-09-01 04:28:22', '2025-09-01 04:28:22'),
(752, 'AHMAL', '232410225', '$2y$12$fAsvMOXkwPeZqsh4q.nRuukv.5uhTxEpddHZzGiBh0jJSSmNRYZBO', 'siswa', '2025-09-01 04:28:22', '2025-09-01 04:28:22'),
(753, 'AKBAR SUGIHARTONO', '232410226', '$2y$12$u4kgqqg4xHXyWcDhC9Ii2OGCbSPqmNm3BqS1e.FLmDT7egKQOWiWe', 'siswa', '2025-09-01 04:28:22', '2025-09-01 04:28:22'),
(754, 'AMELDA FIKRIA', '232410227', '$2y$12$1QkJmWEiEc0uZ4b119vtROvYzPJ4g9Pw1pjOGmHkawlXTNEf4XOE2', 'siswa', '2025-09-01 04:28:22', '2025-09-01 04:28:22'),
(755, 'ARHAM SODIK', '232410228', '$2y$12$DGtrU0yT0sj9.fj95qVnlezSSZCsLJdRWz9IX2hh22Z10WWSZ4bF6', 'siswa', '2025-09-01 04:28:23', '2025-09-01 04:28:23'),
(756, 'ATISAH', '232410229', '$2y$12$6QBFEE9I/p8SywjfIO0BB.F1wQNNR93rh3LclKrKiky2t43i13W/m', 'siswa', '2025-09-01 04:28:23', '2025-09-01 04:28:23'),
(757, 'CAHYA KOMARA', '232410230', '$2y$12$ixW8LT4kCCBcfI9Q1SHkEu3ydY9ZibSkTWPxz//Plb/V9Euh6szU.', 'siswa', '2025-09-01 04:28:23', '2025-09-01 04:28:23'),
(758, 'DEDEN', '232410231', '$2y$12$BZbRNNq2mdK3dEn6/kvhx.3W6b4uhHMfU.3uk3o6KHZOYFHnsmfJm', 'siswa', '2025-09-01 04:28:23', '2025-09-01 04:28:23'),
(759, 'FITRIA ANGGRAENI', '232410232', '$2y$12$uk8ccgDbf4VLRd25ixTRUuuze6eG8Hjm6x3btx2.onbG.joZ1BHbW', 'siswa', '2025-09-01 04:28:24', '2025-09-01 04:28:24'),
(760, 'FITRIA RAMADANI', '232410233', '$2y$12$TpdTmklCOfvK3tJNYTBwNuyNwteAbjblh3hX9bSCYcu.0wZVwx/nW', 'siswa', '2025-09-01 04:28:24', '2025-09-01 04:28:24'),
(761, 'GITA MELINDA SARI', '232410234', '$2y$12$KxhvxBaDRKedPMBZekRnfenH3lQZvY4t7sLyaW7O3aGb/JFuQxBkC', 'siswa', '2025-09-01 04:28:24', '2025-09-01 04:28:24'),
(762, 'IBNU HASAN', '232410235', '$2y$12$FhUnIQu2ZU7HfPMn0OLrMOPu7LJdgYxW3TMKijVcpH/i0JAzw/JvK', 'siswa', '2025-09-01 04:28:24', '2025-09-01 04:28:24'),
(763, 'JAJANG SUTEJA', '232410236', '$2y$12$1i2Om8bMHJ86DqF2T9GZdudJpswH2sFkTyEAzHwrGTQa61HXYuc6K', 'siswa', '2025-09-01 04:28:25', '2025-09-01 04:28:25'),
(764, 'KARNOM', '232410237', '$2y$12$4IGgqhSsHawVlC9ahhYdves63OrMBFqdEduyd8Vm8I4WdQ4bcodY.', 'siswa', '2025-09-01 04:28:25', '2025-09-01 04:28:25'),
(765, 'KARYA MULYANA', '232410238', '$2y$12$sTp15UIjNm6.sJS1TgEfWuFEM3uZPD/y5IZVxNQkQsFvjoi4leLZW', 'siswa', '2025-09-01 04:28:25', '2025-09-01 04:28:25'),
(766, 'KHAIRUL IKHWAN ABBASY', '232410239', '$2y$12$T7oyJVQlULvaVgRpVtMMSOetpRCLA8o25Pw1Hw/7iza2CDWg97hSe', 'siswa', '2025-09-01 04:28:25', '2025-09-01 04:28:25'),
(767, 'MAULIDDANI AHMAD NURHANDIKA', '232410240', '$2y$12$Hj9LQjVfSXpTpzr1leuo9e00tSssKYPG6uSIAi6bOopFDIkO/mJCS', 'siswa', '2025-09-01 04:28:26', '2025-09-01 04:28:26'),
(768, 'MELI IMELDA', '232410241', '$2y$12$XaG15AhD9tSOYS74EAG.oeCTS11I70aJOscde2MWU0lJuJXXMZpc2', 'siswa', '2025-09-01 04:28:26', '2025-09-01 04:28:26'),
(769, 'MUHAMAD ROSANDI', '232410242', '$2y$12$x5ZWU3CfTG/TTp4RXsh6ke6SddTFncMtC6yEDc3AMW6wejL9zhEkS', 'siswa', '2025-09-01 04:28:26', '2025-09-01 04:28:26'),
(770, 'MUHAMMAD RAFA FAUZAN', '232410243', '$2y$12$Oax0SocT6/GhWQwK5cWrOO4YFN2kvx7hFUy9nXejPGU4ejHV3SOiy', 'siswa', '2025-09-01 04:28:27', '2025-09-01 04:28:27'),
(771, 'MUHAMMAD RAIHAN', '232410244', '$2y$12$FRNasvsGiDlxYwJ.beeJo.xqoKlaHRzZRiiDkfjEyjoucpvd3DAwi', 'siswa', '2025-09-01 04:28:27', '2025-09-01 04:28:27'),
(772, 'NOVIANI', '232410245', '$2y$12$YmKaN8p1qC5zV2DXP7hqZ.KiyQUdyr/X62AISTO2o41GzAyjrELUe', 'siswa', '2025-09-01 04:28:27', '2025-09-01 04:28:27'),
(773, 'PIRMANSAH', '232410246', '$2y$12$V.O/AbkFikT4o.PkGzfsSu6gjbM28GpH/zVPWbOVrMYduGKN2.Dtq', 'siswa', '2025-09-01 04:28:27', '2025-09-01 04:28:27'),
(774, 'RADO SAPERO', '232410247', '$2y$12$hDILyzNXH8RnP.bkyFGaZeOiSsMsbVwFfmMX9x5ORt4xS4Tyqn80S', 'siswa', '2025-09-01 04:28:28', '2025-09-01 04:28:28'),
(775, 'SAEPUL PIRDAUS', '232410248', '$2y$12$zxUUkVanr8sVxxVOevC65eV1IaqAJgIhHX6i4pS3mfrpvYrhRe/ei', 'siswa', '2025-09-01 04:28:28', '2025-09-01 04:28:28'),
(776, 'SUHENDAR', '232410249', '$2y$12$Ktyj/rAUzIksLz9tbAdpk.W0UyiM7pNg1J4vAGhN1oMM10iMFdVxW', 'siswa', '2025-09-01 04:28:28', '2025-09-01 04:28:28'),
(777, 'WIDHI BAGASKORO', '232410250', '$2y$12$3nckNxbul26BgaZ5m6flSOUyM6xD15BCinW4oFHneoaLMp3vAsLna', 'siswa', '2025-09-01 04:28:28', '2025-09-01 04:28:28'),
(778, 'YULI', '232410251', '$2y$12$Y35xgjnXfZaSqOWR7e7ga.1w8lNW/07H9M2vo/HajxbMPRdJkEO.S', 'siswa', '2025-09-01 04:28:29', '2025-09-01 04:28:29'),
(779, 'ZEN ANFASA HIDAYAT', '232410252', '$2y$12$dTCdm8r/i5R9TLISfWRUeObvspfVaikyVaZl61iipQm15Ar92p2I6', 'siswa', '2025-09-01 04:28:29', '2025-09-01 04:28:29'),
(780, 'ABDUL ROHMAN', '232410253', '$2y$12$Th/Md/EggwnNgt1klRUru.X2vDbEsEMpF7Mr3RmLqDehdEnclV/rm', 'siswa', '2025-09-01 04:28:29', '2025-09-01 04:28:29'),
(781, 'ASEP SUJANA', '232410254', '$2y$12$LnUbxO4rDYaWnta.EGHm9eDUSr1XJMOnFoCXES6x1ViYBZP5Ct4wS', 'siswa', '2025-09-01 04:28:29', '2025-09-01 04:28:29'),
(782, 'DEDE RAFII', '232410255', '$2y$12$GkFVs41gnNqnyQqv8uAeNeFW3V6GoLECDrsChtfqOwKX5uyTBYal2', 'siswa', '2025-09-01 04:28:30', '2025-09-01 04:28:30'),
(783, 'DEDI WAHIDIN', '232410256', '$2y$12$Px/GA.2LZfqQtVqgbYAQ3OJg6pQtTOpShPTLLjKPm9.AOIIlHdZRK', 'siswa', '2025-09-01 04:28:30', '2025-09-01 04:28:30'),
(784, 'DETI DIAN TINI', '232410257', '$2y$12$yD43yAy4BGu7nXFTLlNNTeRIawkdmhHCTimwVKBhLZVb5y1ALvosC', 'siswa', '2025-09-01 04:28:30', '2025-09-01 04:28:30'),
(785, 'ERNA WIDIAWATI S', '232410258', '$2y$12$upyuB8e1VuvTyPYONJPYoe5wIOZo.oSHjO2X9mLVvDM0LNvAC/V7K', 'siswa', '2025-09-01 04:28:31', '2025-09-01 04:28:31'),
(786, 'ERNI WIDIAWATI S', '232410259', '$2y$12$EhAnuQQjyyo0YnL3ZS4Wh.SDTuZvKI08rDZ7zasCNWBxAX2Gv1V..', 'siswa', '2025-09-01 04:28:31', '2025-09-01 04:28:31'),
(787, 'HUSEN SOBARNA', '232410260', '$2y$12$o2wvED4Arle5jjRdnSmazuxA6pv0H6v2HQdxOXj3JBYYNJSouZjz2', 'siswa', '2025-09-01 04:28:31', '2025-09-01 04:28:31'),
(788, 'IBNI MUHAJIR', '232410261', '$2y$12$vKCNi75EeL/VSIgFaONHteddEdFRD.mcnkVTieuuStJnglpUZ36pi', 'siswa', '2025-09-01 04:28:31', '2025-09-01 04:28:31'),
(789, 'IIP IVANKA', '232410262', '$2y$12$QeqdrZ.bkY/iQFDWaByZ6ObDZev7N8j7L5lVqI/wwErrkFvmbiAgm', 'siswa', '2025-09-01 04:28:32', '2025-09-01 04:28:32'),
(790, 'IRFAN HIDAYAT', '232410263', '$2y$12$JUEGED8DCo0sq5xQGvKqBeHIOnj1u.7QIHABNdGwGHmMzMPycD8zi', 'siswa', '2025-09-01 04:28:32', '2025-09-01 04:28:32'),
(791, 'KARDIANTO', '232410264', '$2y$12$2EEMDxJYuNBPDTcLKdtGNusygjan/gba0wZCuz.Ku7N8I6QI2Ogu6', 'siswa', '2025-09-01 04:28:32', '2025-09-01 04:28:32'),
(792, 'KISAR', '232410265', '$2y$12$MqE0iO83ZIKhNAMihqAdNuJtqOZAOVbCZVLWPGNmfnVgD1flSVd4e', 'siswa', '2025-09-01 04:28:32', '2025-09-01 04:28:32'),
(793, 'KORIYAH', '232410266', '$2y$12$NQy81A0GZzx3zxPqUpHMru8nIJY2b4Zp41y36e5/VuSxmSc2CSdee', 'siswa', '2025-09-01 04:28:33', '2025-09-01 04:28:33'),
(794, 'LINDA', '232410267', '$2y$12$A/8xB1by/7hpTLTfF15eSev4aOknr5pyLoUts230Gs.egLjSLxXQO', 'siswa', '2025-09-01 04:28:33', '2025-09-01 04:28:33'),
(795, 'MAYA ANJELINA FRATAMA', '232410268', '$2y$12$4rxqktpormnL9EXLAyn7aOCpppMCibFEe2d1ioa6gRnkgJCBo4bVi', 'siswa', '2025-09-01 04:28:33', '2025-09-01 04:28:33'),
(796, 'MUHAMMAD ABDUL FAQIH', '232410269', '$2y$12$/MQjDlOiekhMA.U4TIJuP.MeY2HElSOnmyCPY5627/PglnhEllIM2', 'siswa', '2025-09-01 04:28:33', '2025-09-01 04:28:33'),
(797, 'MUHAMMAD AHDA AL MUSYAROF', '232410270', '$2y$12$H2UV/OcoF9CS41DrJkpfpOMLttNmqjR/jticNLYl7JsJnvRsbKEpG', 'siswa', '2025-09-01 04:28:34', '2025-09-01 04:28:34'),
(798, 'MUHAMMAD FADLAN', '232410271', '$2y$12$wNbpC8YimFctLr4spQnTeuCXxP1pDfGb3nlgvNTKbAj5lK6dkiDVG', 'siswa', '2025-09-01 04:28:34', '2025-09-01 04:28:34'),
(799, 'MUTIARA AZIZAH', '232410272', '$2y$12$Tund3TtiDItJoj5X35qxMuqpIce/PSa21CiiSo6D.B9Yr08hCmkqm', 'siswa', '2025-09-01 04:28:34', '2025-09-01 04:28:34'),
(800, 'NURAENI', '232410273', '$2y$12$UA7aKHmuC0LktaPpax8ZE.iIwO1Ca0QiuZ2gJ.Lh21wZPfnzZhKtO', 'siswa', '2025-09-01 04:28:35', '2025-09-01 04:28:35'),
(801, 'RAKA', '232410274', '$2y$12$xN5fqSXHcrN1BSnNjbb2meU42Wc9MePtBCebx0W.m.fywWyMVW//O', 'siswa', '2025-09-01 04:28:35', '2025-09-01 04:28:35'),
(802, 'RIKI', '232410275', '$2y$12$5Iy13TlJT/F4XMd47MJJQ.ZNzo1Gp36T0oOPJAc3s4kZ1cE83WEBu', 'siswa', '2025-09-01 04:28:35', '2025-09-01 04:28:35'),
(803, 'SAEPUL ANWAR', '232410276', '$2y$12$/ARPZEdg2eAFmA0kBTqo7e4X24E03XHcpZe5qmhDz9z608U9OpZhe', 'siswa', '2025-09-01 04:28:35', '2025-09-01 04:28:35'),
(804, 'WARMAN', '232410277', '$2y$12$jMjGLqVH.MAKJa7.0rf/i.KFAaRmGXXozf5IcX5EJpfArbnLdgU7G', 'siswa', '2025-09-01 04:28:36', '2025-09-01 04:28:36'),
(805, 'YASMIN', '232410278', '$2y$12$PP.YF14AawNfY5o4IbAQoenx.f21kv48UVcYA73XZ0iuKz98jH6rS', 'siswa', '2025-09-01 04:28:36', '2025-09-01 09:35:03'),
(806, 'IIM FAUZIAH, S.Ag', 'iim', '$2y$12$8kn0lic.Oa8TTCpFTvk0mOuNkgGNFYm5ljr.QMe5EQ0uf4bpQX0BK', 'wali', '2025-09-01 04:30:01', '2025-09-01 04:30:01'),
(807, 'VIONA FARA NABILA, S.Pd', 'viona', '$2y$12$TG0ESHSfr17nnFFX.R3fWuVEJrfaOnZB.rJTigdv4J1hDoT9zLxVy', 'wali', '2025-09-01 04:30:25', '2025-09-01 04:30:25'),
(808, 'SITI INA ROSTIANA, S.Pd', 'siti', '$2y$12$R6WRfXB74pcllMg046bjS.M6dyygoH5TigyRO6rTnhcg7pW81z6OS', 'wali', '2025-09-01 04:30:47', '2025-09-01 04:30:47'),
(809, 'MOERDIONO. S.H, Gr', 'moerdiono', '$2y$12$ccAw6yyIFmGsi3hrFh3SOu4vzwt2Xgq2cYzPfWJY87dN/YVvJRinq', 'wali', '2025-09-01 04:31:07', '2025-09-01 04:31:07'),
(810, 'BUDI AZANI, S.Pd', 'budi', '$2y$12$8Yon137Ze4WRfjdsZUT6ie70oB5WVpy4ZYgCnn5K6qni7h4zYRMVG', 'wali', '2025-09-01 04:31:24', '2025-09-01 04:31:24'),
(811, 'AYU WULANDARI, S.Tr. Kes', 'ayu', '$2y$12$723LY3K2WOGzfVFUlB9awusTqD1V6wyROlKr2eBCNSiMjG7FSeaNW', 'wali', '2025-09-01 04:31:42', '2025-09-01 04:31:42'),
(812, 'SOPIAN HADI, A.Md', 'sopian', '$2y$12$Zf1xa63t0r6QkvBStU5UJOKfT53iZ8vtE5wzakopppMONjadAmO52', 'wali', '2025-09-01 04:32:00', '2025-09-01 04:32:00'),
(813, 'RUSDIANTO, S.T', 'rusdianto', '$2y$12$R9s7oLxFJNQSudTj9Iu9kOIp75XuEOZFFISYtjFdlTMgJuYZs5Fue', 'wali', '2025-09-01 04:32:23', '2025-09-01 04:32:23'),
(814, 'RITA KHOERUNNISA, S.S', 'rita', '$2y$12$BTzAKEuCGgTU7jSYEz9EzuqbMWVoi/tWov5ghSS5RucWgsHmZUwE.', 'wali', '2025-09-01 04:32:38', '2025-09-01 04:32:38'),
(815, 'TRI AYUNI BILA KARTIKA, S.Pd', 'tri', '$2y$12$HklaE37mhIWoskMgZqb80OPcR38LNcxb4XzaweLzEtwnq8arSWoNy', 'wali', '2025-09-01 04:32:55', '2025-09-01 04:32:55'),
(816, 'MOHAMMAD ALWI, S.Pd', 'alwi', '$2y$12$cGOUwQtYzjBHGJVbrvQcBugMv12CKlqP3Hwmm1ZCDr45YCmza4Yty', 'wali', '2025-09-01 04:33:13', '2025-09-01 04:33:13'),
(817, 'AHMAD MUHIBBAN, S.Ag', 'iben', '$2y$12$imN5M8pEmZxlYJAtpuK1xOweY6rgmUDLzZsyzSIL/jOaU6wULNt0W', 'wali', '2025-09-01 04:33:28', '2025-09-01 04:33:28'),
(818, 'TRI ZULFAN PURNAMA PUTRA, S.Pd', 'zulfan', '$2y$12$2hNC6RcprnaIuBGtDOj17OwLrGfNflEa8AyrxG/UGJK2uCwHSZ6AO', 'wali', '2025-09-01 04:33:44', '2025-09-01 04:33:44'),
(819, 'RIFKI NUR HIDAYAT, S.T', 'rifki', '$2y$12$8E/dUkwgi/w76UQSYvw4LurMPE7Xt4oVTHTUC59ixTsCBGFhz1Kne', 'wali', '2025-09-01 04:34:02', '2025-09-01 04:34:02'),
(820, 'FADIA ULFA ANGELINA, A.Md', 'fadia', '$2y$12$Iq542rknExZOXLmASbxNoOGRBpW2EC/QPCajXTNg3Owp/Py3qU6DK', 'wali', '2025-09-01 04:34:22', '2025-09-01 04:34:22'),
(821, 'MUMUN MUNAWAROH, S.Kom', 'mumun', '$2y$12$HzQQxp3OQNmeH4kBnF1TU.W0vnWXXdoknEmgPI/qZdmtqgk3Gah6q', 'wali', '2025-09-01 04:34:38', '2025-09-01 04:34:38'),
(822, 'DEWI DAMAYANTI, S.Pd', 'dewi', '$2y$12$Qm0P3UhSPZABUKxaPZdRq.3031zpLAmNUEeuQ3hAX4t5uyN4wjVUy', 'wali', '2025-09-01 04:34:54', '2025-09-01 04:34:54'),
(823, 'EUIS NANI, S.E', 'euis', '$2y$12$/qpknZcF8aGbRg45s.d5OuzxRgLJBoDIIHagwIs.FFLSn8fFeqhUW', 'wali', '2025-09-01 04:35:12', '2025-09-01 04:35:12'),
(824, 'DINI DIMYATI, S.Pd', 'dini', '$2y$12$mDI.6.598QNojmrJYxGh..upSEXnsxvJVo.f.rGmjWNQJ651YMtrG', 'wali', '2025-09-01 04:35:29', '2025-09-01 04:35:29'),
(825, 'SUKATMO, S.Pd', 'sukatmo', '$2y$12$wTw70VRlCEJ8p1C87pPV.eG5WygmFYshoPM2oSH8H1Bj3tyXoD19K', 'wali', '2025-09-01 04:35:56', '2025-09-01 04:35:56'),
(826, 'YATI NURHAYATI, S.Pd', 'yati', '$2y$12$9OyqvNV3KnPeQ7WLiQQqWemk8wRSZ1Oge7TIAJAHZ3vVaKJCTxEGG', 'wali', '2025-09-01 04:36:12', '2025-09-01 04:36:12'),
(827, 'RENALDI FERDIANSAH, S.Pd', 'renaldi', '$2y$12$xTuF9xIGZusDRf1svG/vteEbZB3X.OIxJ.zVCVmupAp2VOvcU7Mo.', 'wali', '2025-09-01 04:37:10', '2025-09-01 04:37:10'),
(828, 'AGUNG ISLAHUDIN, S.Pd', 'agung', '$2y$12$6lngPaBCgYt4c6sqSSUBleJeJlaZxz0.CA.hGz5KtsEKV6JslpSMK', 'wali', '2025-09-01 04:37:26', '2025-09-01 04:37:26'),
(829, 'ABDUL AZIS, A.Md', 'azis', '$2y$12$P06jc.bmkKDRKiVivHYD/uQU3HIu1Jbvw4DFNj0cXEaZK7HZK46Xa', 'wali', '2025-09-01 04:37:44', '2025-09-01 04:37:44'),
(830, 'NAUPAL IRSYAD, S.Pd', 'naupal', '$2y$12$dsqpc7XPT6pQup6.ab/aEuPMuutIaih8Old9ELu6V3oHcEW1YyHRa', 'wali', '2025-09-01 04:38:02', '2025-09-01 04:38:02'),
(831, 'WAHYU RUSDIANSYAH, S.Kom', 'wahyu', '$2y$12$iunWtyTsUoskX8gX92w7nevAZKk2MlkmKfaW1RQVP7ETFTH896d3O', 'wali', '2025-09-01 04:38:19', '2025-09-01 04:38:19'),
(833, 'ASIM AZHARI, A.Md', 'asim', '$2y$12$WiZVNbqOT34AwzUgQdYym.E5Vwwaq6nWRG7VA49l1H2J8Ic3mTUOq', 'siswa', '2025-09-01 13:52:01', '2025-09-01 13:52:01'),
(834, 'BINTANG KUSUMA WARDHANA, S.Si., M.Or', 'bintang', '$2y$12$cRIao3P/UUU4P7F5//lokezmkxnjmhPrei5dPoJChjnEzhWbwRBXG', 'siswa', '2025-09-01 13:52:02', '2025-09-01 13:52:02'),
(835, 'DIYAH RATNASARI INDAH, S.Pd', 'diyah', '$2y$12$dFqeoVuDJxTEWPfCcYkmKu0NceFopYQU8xeUJf9DlCSW2LDLxhU2q', 'siswa', '2025-09-01 13:52:03', '2025-09-01 13:52:03'),
(836, 'Drs. DANA SUTISNA', 'dana', '$2y$12$z1VHAQQoGlpQsaTFQUKO2uxEdmU6qy/Mon.6q0vI..zhW7L4WN9TG', 'siswa', '2025-09-01 13:52:04', '2025-09-01 13:52:04'),
(837, 'EKA SUPRIADI, S.Kom', 'eka', '$2y$12$vKPNVS2NeIRGVuuj3d1s3eenOvaSivLYuvrHLXAaStHzflc0Wmy5a', 'siswa', '2025-09-01 13:52:04', '2025-09-01 13:52:04'),
(838, 'ICIH KURNIANENGSIH, S.Pd', 'icih', '$2y$12$o010yPzfKLTc5TREi3cASOM.TYPLvlcCyGFjvY0JLCzQ7JyGxJhQq', 'siswa', '2025-09-01 13:52:05', '2025-09-01 13:52:05'),
(839, 'JONI ABDUL KHALID', 'joni', '$2y$12$zDdn2p4Mib1EdJhn4V.Cn.NtX1/ORKIWln3V./ZQZ4ZiBqTqm0SCO', 'siswa', '2025-09-01 13:52:06', '2025-09-01 13:52:06'),
(840, 'KARYATI, S.Pd', 'karyati', '$2y$12$F7BmGiq92ThHaMGIFeXYi.MV34LAXLiPw0iJAyuDN2fPMScLSmDNe', 'siswa', '2025-09-01 13:52:06', '2025-09-01 13:52:06'),
(841, 'SAEPUDIN LUBIS, S.Pd, MM', 'lubis', '$2y$12$Wvo3yhR8qybfeKBY5Gnb4.rn2ZDAK/y.XgpzqO0YlN/jIo0VIRt2y', 'siswa', '2025-09-01 13:52:10', '2025-09-01 13:52:10'),
(842, 'TIO IRVAN MULYADI, S.Pd', 'tio', '$2y$12$2nTUoq7fu1R4/e0CEEScj.s/EE2Gc/dej2dxr4Mt57j6ZO2C8aLLa', 'siswa', '2025-09-01 13:52:11', '2025-09-01 13:52:11');

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
('6SdOYCrBy1ZneFH2mi5WCHaYZCmJRhCPKShIduIf', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidGxpcnJkRWg3QjhUcnJFdEUwZE9QRXJhaUVyblp1V2tiYTN6OWk1ZyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQxOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvaW5zZW50aWYvcGVtYmF5YXJhbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1756775027);

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

--
-- Dumping data for table `setoran`
--

INSERT INTO `setoran` (`id`, `siswa_id`, `jenis_sampah_id`, `jumlah`, `total_harga`, `created_at`, `updated_at`, `status`) VALUES
(1, 680, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(2, 683, 1, 11.00, 385.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(3, 684, 1, 5.00, 175.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(4, 685, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(5, 686, 1, 7.00, 245.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(6, 687, 1, 7.00, 245.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(7, 689, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(8, 690, 1, 3.00, 105.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(9, 691, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(10, 693, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(11, 694, 1, 6.00, 210.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(12, 697, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(13, 698, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(14, 699, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(15, 700, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(16, 702, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(17, 703, 1, 11.00, 385.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(18, 704, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(19, 706, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(20, 707, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(21, 708, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(22, 709, 1, 5.00, 175.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(23, 710, 1, 10.00, 350.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(24, 712, 1, 15.00, 525.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(25, 713, 1, 5.00, 175.00, '2025-09-01 06:11:20', '2025-09-01 06:11:20', 'normal'),
(26, 684, 2, 5.00, 50.00, '2025-09-01 06:12:28', '2025-09-01 06:12:28', 'normal'),
(27, 690, 2, 7.00, 70.00, '2025-09-01 06:12:28', '2025-09-01 06:12:28', 'normal'),
(28, 694, 2, 10.00, 100.00, '2025-09-01 06:12:28', '2025-09-01 06:12:28', 'normal'),
(29, 695, 2, 10.00, 100.00, '2025-09-01 06:12:28', '2025-09-01 06:12:28', 'normal'),
(30, 698, 2, 5.00, 50.00, '2025-09-01 06:12:28', '2025-09-01 06:12:28', 'normal'),
(31, 711, 2, 10.00, 100.00, '2025-09-01 06:12:28', '2025-09-01 06:12:28', 'normal'),
(32, 713, 2, 10.00, 100.00, '2025-09-01 06:12:28', '2025-09-01 06:12:28', 'normal'),
(33, 714, 1, 10.00, 350.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(34, 715, 1, 10.00, 350.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(35, 716, 1, 11.00, 385.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(36, 717, 1, 10.00, 350.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(37, 718, 1, 8.00, 280.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(38, 719, 1, 4.00, 140.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(39, 720, 1, 14.00, 490.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(40, 724, 1, 4.00, 140.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(41, 725, 1, 4.00, 140.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(42, 728, 1, 4.00, 140.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(43, 729, 1, 10.00, 350.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(44, 730, 1, 4.00, 140.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(45, 731, 1, 5.00, 175.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(46, 733, 1, 7.00, 245.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(47, 734, 1, 8.00, 280.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(48, 735, 1, 7.00, 245.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(49, 736, 1, 7.00, 245.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(50, 738, 1, 10.00, 350.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(51, 740, 1, 10.00, 350.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(52, 741, 1, 6.00, 210.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(53, 744, 1, 5.00, 175.00, '2025-09-01 07:36:38', '2025-09-01 07:36:38', 'normal'),
(54, 724, 2, 4.00, 40.00, '2025-09-01 07:37:48', '2025-09-01 07:37:48', 'normal'),
(55, 725, 2, 6.00, 60.00, '2025-09-01 07:37:48', '2025-09-01 07:37:48', 'normal'),
(56, 728, 2, 6.00, 60.00, '2025-09-01 07:37:48', '2025-09-01 07:37:48', 'normal'),
(57, 733, 2, 4.00, 40.00, '2025-09-01 07:37:48', '2025-09-01 07:37:48', 'normal'),
(58, 737, 2, 12.00, 120.00, '2025-09-01 07:37:48', '2025-09-01 07:37:48', 'normal'),
(59, 741, 2, 1.00, 10.00, '2025-09-01 07:37:48', '2025-09-01 07:37:48', 'normal'),
(60, 743, 2, 10.00, 100.00, '2025-09-01 07:37:48', '2025-09-01 07:37:48', 'normal'),
(61, 744, 2, 5.00, 50.00, '2025-09-01 07:37:48', '2025-09-01 07:37:48', 'normal'),
(62, 746, 1, 1.00, 35.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(63, 747, 1, 4.00, 140.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(64, 748, 1, 10.00, 350.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(65, 749, 1, 10.00, 350.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(66, 750, 1, 2.00, 70.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(67, 752, 1, 10.00, 350.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(68, 755, 1, 6.00, 210.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(69, 756, 1, 9.00, 315.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(70, 763, 1, 7.00, 245.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(71, 764, 1, 6.00, 210.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(72, 765, 1, 1.00, 35.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(73, 766, 1, 13.00, 455.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(74, 768, 1, 6.00, 210.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(75, 769, 1, 7.00, 245.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(76, 770, 1, 10.00, 350.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(77, 771, 1, 10.00, 350.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(78, 772, 1, 1.00, 35.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(79, 775, 1, 5.00, 175.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(80, 776, 1, 10.00, 350.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(81, 778, 1, 9.00, 315.00, '2025-09-01 07:40:06', '2025-09-01 07:40:06', 'normal'),
(82, 746, 2, 9.00, 90.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(83, 747, 2, 11.00, 110.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(84, 748, 2, 2.00, 20.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(85, 750, 2, 8.00, 80.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(86, 754, 2, 10.00, 100.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(87, 755, 2, 5.00, 50.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(88, 756, 2, 1.00, 10.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(89, 757, 2, 10.00, 100.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(90, 761, 2, 10.00, 100.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(91, 762, 2, 10.00, 100.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(92, 763, 2, 3.00, 30.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(93, 764, 2, 4.00, 40.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(94, 765, 2, 10.00, 100.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(95, 768, 2, 4.00, 40.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(96, 769, 2, 9.00, 90.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(97, 772, 2, 12.00, 120.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(98, 774, 2, 10.00, 100.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(99, 775, 2, 5.00, 50.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(100, 776, 2, 10.00, 100.00, '2025-09-01 07:41:28', '2025-09-01 07:41:28', 'normal'),
(101, 578, 1, 9.00, 315.00, '2025-09-01 08:58:07', '2025-09-01 08:58:07', 'normal'),
(102, 579, 1, 1.00, 35.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(103, 580, 1, 5.00, 175.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(104, 581, 1, 19.00, 665.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(105, 582, 1, 1.00, 35.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(106, 583, 1, 26.00, 910.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(107, 585, 1, 21.00, 735.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(108, 589, 1, 14.00, 490.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(109, 591, 1, 1.00, 35.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(110, 592, 1, 15.00, 525.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(111, 593, 1, 5.00, 175.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(112, 594, 1, 10.00, 350.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(113, 595, 1, 1.00, 35.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(114, 596, 1, 10.00, 350.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(115, 597, 1, 20.00, 700.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(116, 598, 1, 1.00, 35.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(117, 599, 1, 19.00, 665.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(118, 601, 1, 11.00, 385.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(119, 602, 1, 9.00, 315.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(120, 603, 1, 10.00, 350.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(121, 604, 1, 1.00, 35.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(122, 605, 1, 10.00, 350.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(123, 606, 1, 6.00, 210.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(124, 607, 1, 7.00, 245.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(125, 608, 1, 12.00, 420.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(126, 609, 1, 3.00, 105.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(127, 610, 1, 20.00, 700.00, '2025-09-01 08:58:08', '2025-09-01 08:58:08', 'normal'),
(128, 579, 2, 20.00, 200.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(129, 582, 2, 9.00, 90.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(130, 584, 2, 7.00, 70.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(131, 586, 2, 13.00, 130.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(132, 591, 2, 11.00, 110.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(133, 595, 2, 11.00, 110.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(134, 598, 2, 6.00, 60.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(135, 600, 2, 21.00, 210.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(136, 604, 2, 15.00, 150.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(137, 606, 2, 11.00, 110.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(138, 607, 2, 10.00, 100.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(139, 609, 2, 9.00, 90.00, '2025-09-01 09:00:34', '2025-09-01 09:00:34', 'normal'),
(140, 611, 1, 10.00, 350.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(141, 614, 1, 5.00, 175.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(142, 615, 1, 10.00, 350.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(143, 619, 1, 2.00, 70.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(144, 621, 1, 7.00, 245.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(145, 622, 1, 10.00, 350.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(146, 625, 1, 5.00, 175.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(147, 627, 1, 5.00, 175.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(148, 630, 1, 2.00, 70.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(149, 631, 1, 6.00, 210.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(150, 635, 1, 5.00, 175.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(151, 636, 1, 5.00, 175.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(152, 637, 1, 4.00, 140.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(153, 640, 1, 10.00, 350.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(154, 643, 1, 5.00, 175.00, '2025-09-01 09:07:03', '2025-09-01 09:07:03', 'normal'),
(155, 612, 2, 6.00, 60.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(156, 619, 2, 5.00, 50.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(157, 621, 2, 1.00, 10.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(158, 630, 2, 8.00, 80.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(159, 632, 2, 10.00, 100.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(160, 634, 2, 7.00, 70.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(161, 637, 2, 3.00, 30.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(162, 643, 2, 5.00, 50.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(163, 644, 2, 15.00, 150.00, '2025-09-01 09:08:03', '2025-09-01 09:08:03', 'normal'),
(164, 817, 4, 29.00, 1218.00, '2025-09-01 14:02:35', '2025-09-01 14:02:35', 'normal'),
(165, 818, 4, 7.00, 294.00, '2025-09-01 14:02:35', '2025-09-01 14:02:35', 'normal'),
(166, 818, 5, 5.00, 75.00, '2025-09-01 14:02:35', '2025-09-01 14:02:35', 'normal'),
(167, 822, 4, 102.00, 4284.00, '2025-09-01 14:02:35', '2025-09-01 14:02:35', 'normal'),
(168, 822, 5, 18.00, 270.00, '2025-09-01 14:02:35', '2025-09-01 14:02:35', 'normal');

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
(1, 'site_title', 'Bank Sampah TKM', '2025-09-01 06:07:20', '2025-09-01 14:21:42'),
(2, 'persentase_pengelola', '0', '2025-09-01 06:07:20', '2025-09-01 06:07:20'),
(3, 'persentase_wali_kelas', '20', '2025-09-01 06:07:20', '2025-09-01 06:07:20'),
(4, 'persentase_sekolah', '5', '2025-09-01 06:07:20', '2025-09-01 06:07:20');

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
(1, 2, 2, '252610001', 0.00, 0, '2025-09-01 04:23:42', '2025-09-01 04:23:42'),
(2, 3, 2, '252610002', 0.00, 0, '2025-09-01 04:23:43', '2025-09-01 04:23:43'),
(3, 4, 2, '252610003', 0.00, 0, '2025-09-01 04:23:43', '2025-09-01 04:23:43'),
(4, 5, 2, '252610004', 0.00, 0, '2025-09-01 04:23:43', '2025-09-01 04:23:43'),
(5, 6, 2, '252610005', 0.00, 0, '2025-09-01 04:23:44', '2025-09-01 04:23:44'),
(6, 7, 2, '252610006', 0.00, 0, '2025-09-01 04:23:44', '2025-09-01 04:23:44'),
(7, 8, 2, '252610007', 0.00, 0, '2025-09-01 04:23:44', '2025-09-01 04:23:44'),
(8, 9, 2, '252610008', 0.00, 0, '2025-09-01 04:23:44', '2025-09-01 04:23:44'),
(9, 10, 2, '252610009', 0.00, 0, '2025-09-01 04:23:45', '2025-09-01 04:23:45'),
(10, 11, 2, '252610010', 0.00, 0, '2025-09-01 04:23:45', '2025-09-01 04:23:45'),
(11, 12, 2, '252610011', 0.00, 0, '2025-09-01 04:23:45', '2025-09-01 04:23:45'),
(12, 13, 2, '252610012', 0.00, 0, '2025-09-01 04:23:45', '2025-09-01 04:23:45'),
(13, 14, 2, '252610013', 0.00, 0, '2025-09-01 04:23:46', '2025-09-01 04:23:46'),
(14, 15, 2, '252610014', 0.00, 0, '2025-09-01 04:23:46', '2025-09-01 04:23:46'),
(15, 16, 2, '252610015', 0.00, 0, '2025-09-01 04:23:46', '2025-09-01 04:23:46'),
(16, 17, 2, '252610016', 0.00, 0, '2025-09-01 04:23:46', '2025-09-01 04:23:46'),
(17, 18, 2, '252610017', 0.00, 0, '2025-09-01 04:23:47', '2025-09-01 04:23:47'),
(18, 19, 2, '252610018', 0.00, 0, '2025-09-01 04:23:47', '2025-09-01 04:23:47'),
(19, 20, 2, '252610019', 0.00, 0, '2025-09-01 04:23:47', '2025-09-01 04:23:47'),
(20, 21, 2, '252610020', 0.00, 0, '2025-09-01 04:23:47', '2025-09-01 04:23:47'),
(21, 22, 2, '252610021', 0.00, 0, '2025-09-01 04:23:48', '2025-09-01 04:23:48'),
(22, 23, 2, '252610022', 0.00, 0, '2025-09-01 04:23:48', '2025-09-01 04:23:48'),
(23, 24, 2, '252610023', 0.00, 0, '2025-09-01 04:23:48', '2025-09-01 04:23:48'),
(24, 25, 2, '252610024', 0.00, 0, '2025-09-01 04:23:48', '2025-09-01 04:23:48'),
(25, 26, 2, '252610025', 0.00, 0, '2025-09-01 04:23:49', '2025-09-01 04:23:49'),
(26, 27, 2, '252610026', 0.00, 0, '2025-09-01 04:23:49', '2025-09-01 04:23:49'),
(27, 28, 2, '252610027', 0.00, 0, '2025-09-01 04:23:49', '2025-09-01 04:23:49'),
(28, 29, 3, '252610028', 0.00, 0, '2025-09-01 04:23:50', '2025-09-01 04:23:50'),
(29, 30, 3, '252610029', 0.00, 0, '2025-09-01 04:23:50', '2025-09-01 04:23:50'),
(30, 31, 3, '252610030', 0.00, 0, '2025-09-01 04:23:50', '2025-09-01 04:23:50'),
(31, 32, 3, '252610031', 0.00, 0, '2025-09-01 04:23:50', '2025-09-01 04:23:50'),
(32, 33, 3, '252610032', 0.00, 0, '2025-09-01 04:23:51', '2025-09-01 04:23:51'),
(33, 34, 3, '252610033', 0.00, 0, '2025-09-01 04:23:51', '2025-09-01 04:23:51'),
(34, 35, 3, '252610034', 0.00, 0, '2025-09-01 04:23:51', '2025-09-01 04:23:51'),
(35, 36, 3, '252610035', 0.00, 0, '2025-09-01 04:23:51', '2025-09-01 04:23:51'),
(36, 37, 3, '252610036', 0.00, 0, '2025-09-01 04:23:52', '2025-09-01 04:23:52'),
(37, 38, 3, '252610037', 0.00, 0, '2025-09-01 04:23:52', '2025-09-01 04:23:52'),
(38, 39, 3, '252610038', 0.00, 0, '2025-09-01 04:23:52', '2025-09-01 04:23:52'),
(39, 40, 3, '252610039', 0.00, 0, '2025-09-01 04:23:52', '2025-09-01 04:23:52'),
(40, 41, 3, '252610040', 0.00, 0, '2025-09-01 04:23:53', '2025-09-01 04:23:53'),
(41, 42, 3, '252610041', 0.00, 0, '2025-09-01 04:23:53', '2025-09-01 04:23:53'),
(42, 43, 3, '252610042', 0.00, 0, '2025-09-01 04:23:53', '2025-09-01 04:23:53'),
(43, 44, 3, '252610043', 0.00, 0, '2025-09-01 04:23:54', '2025-09-01 04:23:54'),
(44, 45, 3, '252610044', 0.00, 0, '2025-09-01 04:23:54', '2025-09-01 04:23:54'),
(45, 46, 3, '252610045', 0.00, 0, '2025-09-01 04:23:54', '2025-09-01 04:23:54'),
(46, 47, 3, '252610046', 0.00, 0, '2025-09-01 04:23:54', '2025-09-01 04:23:54'),
(47, 48, 3, '252610047', 0.00, 0, '2025-09-01 04:23:55', '2025-09-01 04:23:55'),
(48, 49, 3, '252610048', 0.00, 0, '2025-09-01 04:23:55', '2025-09-01 04:23:55'),
(49, 50, 3, '252610049', 0.00, 0, '2025-09-01 04:23:55', '2025-09-01 04:23:55'),
(50, 51, 3, '252610050', 0.00, 0, '2025-09-01 04:23:55', '2025-09-01 04:23:55'),
(51, 52, 3, '252610051', 0.00, 0, '2025-09-01 04:23:56', '2025-09-01 04:23:56'),
(52, 53, 3, '252610052', 0.00, 0, '2025-09-01 04:23:56', '2025-09-01 04:23:56'),
(53, 54, 3, '252610053', 0.00, 0, '2025-09-01 04:23:56', '2025-09-01 04:23:56'),
(54, 55, 3, '252610054', 0.00, 0, '2025-09-01 04:23:56', '2025-09-01 04:23:56'),
(55, 56, 3, '252610055', 0.00, 0, '2025-09-01 04:23:57', '2025-09-01 04:23:57'),
(56, 57, 3, '252610056', 0.00, 0, '2025-09-01 04:23:57', '2025-09-01 04:23:57'),
(57, 58, 4, '252610057', 0.00, 0, '2025-09-01 04:23:57', '2025-09-01 04:23:57'),
(58, 59, 4, '252610058', 0.00, 0, '2025-09-01 04:23:58', '2025-09-01 04:23:58'),
(59, 60, 4, '252610059', 0.00, 0, '2025-09-01 04:23:58', '2025-09-01 04:23:58'),
(60, 61, 4, '252610060', 0.00, 0, '2025-09-01 04:23:58', '2025-09-01 04:23:58'),
(61, 62, 4, '252610061', 0.00, 0, '2025-09-01 04:23:58', '2025-09-01 04:23:58'),
(62, 63, 4, '252610062', 0.00, 0, '2025-09-01 04:23:59', '2025-09-01 04:23:59'),
(63, 64, 4, '252610063', 0.00, 0, '2025-09-01 04:23:59', '2025-09-01 04:23:59'),
(64, 65, 4, '252610064', 0.00, 0, '2025-09-01 04:23:59', '2025-09-01 04:23:59'),
(65, 66, 4, '252610065', 0.00, 0, '2025-09-01 04:24:00', '2025-09-01 04:24:00'),
(66, 67, 4, '252610066', 0.00, 0, '2025-09-01 04:24:00', '2025-09-01 04:24:00'),
(67, 68, 4, '252610067', 0.00, 0, '2025-09-01 04:24:00', '2025-09-01 04:24:00'),
(68, 69, 4, '252610068', 0.00, 0, '2025-09-01 04:24:00', '2025-09-01 04:24:00'),
(69, 70, 4, '252610069', 0.00, 0, '2025-09-01 04:24:01', '2025-09-01 04:24:01'),
(70, 71, 4, '252610070', 0.00, 0, '2025-09-01 04:24:01', '2025-09-01 04:24:01'),
(71, 72, 4, '252610071', 0.00, 0, '2025-09-01 04:24:01', '2025-09-01 04:24:01'),
(72, 73, 4, '252610072', 0.00, 0, '2025-09-01 04:24:01', '2025-09-01 04:24:01'),
(73, 74, 4, '252610073', 0.00, 0, '2025-09-01 04:24:02', '2025-09-01 04:24:02'),
(74, 75, 4, '252610074', 0.00, 0, '2025-09-01 04:24:02', '2025-09-01 04:24:02'),
(75, 76, 4, '252610075', 0.00, 0, '2025-09-01 04:24:02', '2025-09-01 04:24:02'),
(76, 77, 4, '252610076', 0.00, 0, '2025-09-01 04:24:02', '2025-09-01 04:24:02'),
(77, 78, 4, '252610077', 0.00, 0, '2025-09-01 04:24:03', '2025-09-01 04:24:03'),
(78, 79, 4, '252610078', 0.00, 0, '2025-09-01 04:24:03', '2025-09-01 04:24:03'),
(79, 80, 4, '252610079', 0.00, 0, '2025-09-01 04:24:03', '2025-09-01 04:24:03'),
(80, 81, 4, '252610080', 0.00, 0, '2025-09-01 04:24:03', '2025-09-01 04:24:03'),
(81, 82, 4, '252610081', 0.00, 0, '2025-09-01 04:24:04', '2025-09-01 04:24:04'),
(82, 83, 4, '252610082', 0.00, 0, '2025-09-01 04:24:04', '2025-09-01 04:24:04'),
(83, 84, 4, '252610083', 0.00, 0, '2025-09-01 04:24:04', '2025-09-01 04:24:04'),
(84, 85, 4, '252610084', 0.00, 0, '2025-09-01 04:24:05', '2025-09-01 04:24:05'),
(85, 86, 4, '252610085', 0.00, 0, '2025-09-01 04:24:05', '2025-09-01 04:24:05'),
(86, 87, 4, '252610086', 0.00, 0, '2025-09-01 04:24:05', '2025-09-01 04:24:05'),
(87, 88, 4, '252610087', 0.00, 0, '2025-09-01 04:24:05', '2025-09-01 04:24:05'),
(88, 89, 4, '252610088', 0.00, 0, '2025-09-01 04:24:06', '2025-09-01 04:24:06'),
(89, 90, 4, '252610089', 0.00, 0, '2025-09-01 04:24:06', '2025-09-01 04:24:06'),
(90, 91, 4, '252610090', 0.00, 0, '2025-09-01 04:24:06', '2025-09-01 04:24:06'),
(91, 92, 5, '252610091', 0.00, 0, '2025-09-01 04:24:06', '2025-09-01 04:24:06'),
(92, 93, 5, '252610092', 0.00, 0, '2025-09-01 04:24:07', '2025-09-01 04:24:07'),
(93, 94, 5, '252610093', 0.00, 0, '2025-09-01 04:24:07', '2025-09-01 04:24:07'),
(94, 95, 5, '252610094', 0.00, 0, '2025-09-01 04:24:07', '2025-09-01 04:24:07'),
(95, 96, 5, '252610095', 0.00, 0, '2025-09-01 04:24:08', '2025-09-01 04:24:08'),
(96, 97, 5, '252610096', 0.00, 0, '2025-09-01 04:24:08', '2025-09-01 04:24:08'),
(97, 98, 5, '252610097', 0.00, 0, '2025-09-01 04:24:08', '2025-09-01 04:24:08'),
(98, 99, 5, '252610098', 0.00, 0, '2025-09-01 04:24:08', '2025-09-01 04:24:08'),
(99, 100, 5, '252610099', 0.00, 0, '2025-09-01 04:24:09', '2025-09-01 04:24:09'),
(100, 101, 5, '252610100', 0.00, 0, '2025-09-01 04:24:09', '2025-09-01 04:24:09'),
(101, 102, 5, '252610101', 0.00, 0, '2025-09-01 04:24:09', '2025-09-01 04:24:09'),
(102, 103, 5, '252610102', 0.00, 0, '2025-09-01 04:24:10', '2025-09-01 04:24:10'),
(103, 104, 5, '252610103', 0.00, 0, '2025-09-01 04:24:10', '2025-09-01 04:24:10'),
(104, 105, 5, '252610104', 0.00, 0, '2025-09-01 04:24:10', '2025-09-01 04:24:10'),
(105, 106, 5, '252610105', 0.00, 0, '2025-09-01 04:24:11', '2025-09-01 04:24:11'),
(106, 107, 5, '252610106', 0.00, 0, '2025-09-01 04:24:11', '2025-09-01 04:24:11'),
(107, 108, 5, '252610107', 0.00, 0, '2025-09-01 04:24:11', '2025-09-01 04:24:11'),
(108, 109, 5, '252610108', 0.00, 0, '2025-09-01 04:24:11', '2025-09-01 04:24:11'),
(109, 110, 5, '252610109', 0.00, 0, '2025-09-01 04:24:12', '2025-09-01 04:24:12'),
(110, 111, 5, '252610110', 0.00, 0, '2025-09-01 04:24:12', '2025-09-01 04:24:12'),
(111, 112, 5, '252610111', 0.00, 0, '2025-09-01 04:24:12', '2025-09-01 04:24:12'),
(112, 113, 5, '252610112', 0.00, 0, '2025-09-01 04:24:13', '2025-09-01 04:24:13'),
(113, 114, 5, '252610113', 0.00, 0, '2025-09-01 04:24:13', '2025-09-01 04:24:13'),
(114, 115, 5, '252610114', 0.00, 0, '2025-09-01 04:24:13', '2025-09-01 04:24:13'),
(115, 116, 5, '252610115', 0.00, 0, '2025-09-01 04:24:14', '2025-09-01 04:24:14'),
(116, 117, 5, '252610116', 0.00, 0, '2025-09-01 04:24:14', '2025-09-01 04:24:14'),
(117, 118, 5, '252610117', 0.00, 0, '2025-09-01 04:24:14', '2025-09-01 04:24:14'),
(118, 119, 5, '252610118', 0.00, 0, '2025-09-01 04:24:14', '2025-09-01 04:24:14'),
(119, 120, 5, '252610119', 0.00, 0, '2025-09-01 04:24:15', '2025-09-01 04:24:15'),
(120, 121, 5, '252610120', 0.00, 0, '2025-09-01 04:24:15', '2025-09-01 04:24:15'),
(121, 122, 5, '252610121', 0.00, 0, '2025-09-01 04:24:15', '2025-09-01 04:24:15'),
(122, 123, 5, '252610122', 0.00, 0, '2025-09-01 04:24:16', '2025-09-01 04:24:16'),
(123, 124, 5, '252610123', 0.00, 0, '2025-09-01 04:24:16', '2025-09-01 04:24:16'),
(124, 125, 5, '252610124', 0.00, 0, '2025-09-01 04:24:16', '2025-09-01 04:24:16'),
(125, 126, 6, '252610125', 0.00, 0, '2025-09-01 04:24:16', '2025-09-01 04:24:16'),
(126, 127, 6, '252610126', 0.00, 0, '2025-09-01 04:24:17', '2025-09-01 04:24:17'),
(127, 128, 6, '252610127', 0.00, 0, '2025-09-01 04:24:17', '2025-09-01 04:24:17'),
(128, 129, 6, '252610128', 0.00, 0, '2025-09-01 04:24:17', '2025-09-01 04:24:17'),
(129, 130, 6, '252610129', 0.00, 0, '2025-09-01 04:24:17', '2025-09-01 04:24:17'),
(130, 131, 6, '252610130', 0.00, 0, '2025-09-01 04:24:18', '2025-09-01 04:24:18'),
(131, 132, 6, '252610131', 0.00, 0, '2025-09-01 04:24:18', '2025-09-01 04:24:18'),
(132, 133, 6, '252610132', 0.00, 0, '2025-09-01 04:24:18', '2025-09-01 04:24:18'),
(133, 134, 6, '252610133', 0.00, 0, '2025-09-01 04:24:18', '2025-09-01 04:24:18'),
(134, 135, 6, '252610134', 0.00, 0, '2025-09-01 04:24:19', '2025-09-01 04:24:19'),
(135, 136, 6, '252610135', 0.00, 0, '2025-09-01 04:24:19', '2025-09-01 04:24:19'),
(136, 137, 6, '252610136', 0.00, 0, '2025-09-01 04:24:19', '2025-09-01 04:24:19'),
(137, 138, 6, '252610137', 0.00, 0, '2025-09-01 04:24:20', '2025-09-01 04:24:20'),
(138, 139, 6, '252610138', 0.00, 0, '2025-09-01 04:24:20', '2025-09-01 04:24:20'),
(139, 140, 6, '252610139', 0.00, 0, '2025-09-01 04:24:20', '2025-09-01 04:24:20'),
(140, 141, 6, '252610140', 0.00, 0, '2025-09-01 04:24:20', '2025-09-01 04:24:20'),
(141, 142, 6, '252610141', 0.00, 0, '2025-09-01 04:24:21', '2025-09-01 04:24:21'),
(142, 143, 6, '252610142', 0.00, 0, '2025-09-01 04:24:21', '2025-09-01 04:24:21'),
(143, 144, 6, '252610143', 0.00, 0, '2025-09-01 04:24:21', '2025-09-01 04:24:21'),
(144, 145, 6, '252610144', 0.00, 0, '2025-09-01 04:24:21', '2025-09-01 04:24:21'),
(145, 146, 6, '252610145', 0.00, 0, '2025-09-01 04:24:22', '2025-09-01 04:24:22'),
(146, 147, 6, '252610146', 0.00, 0, '2025-09-01 04:24:22', '2025-09-01 04:24:22'),
(147, 148, 6, '252610147', 0.00, 0, '2025-09-01 04:24:22', '2025-09-01 04:24:22'),
(148, 149, 6, '252610148', 0.00, 0, '2025-09-01 04:24:23', '2025-09-01 04:24:23'),
(149, 150, 6, '252610149', 0.00, 0, '2025-09-01 04:24:23', '2025-09-01 04:24:23'),
(150, 151, 6, '252610150', 0.00, 0, '2025-09-01 04:24:23', '2025-09-01 04:24:23'),
(151, 152, 6, '252610151', 0.00, 0, '2025-09-01 04:24:23', '2025-09-01 04:24:23'),
(152, 153, 6, '252610152', 0.00, 0, '2025-09-01 04:24:24', '2025-09-01 04:24:24'),
(153, 154, 6, '252610153', 0.00, 0, '2025-09-01 04:24:24', '2025-09-01 04:24:24'),
(154, 155, 6, '252610154', 0.00, 0, '2025-09-01 04:24:24', '2025-09-01 04:24:24'),
(155, 156, 6, '252610155', 0.00, 0, '2025-09-01 04:24:24', '2025-09-01 04:24:24'),
(156, 157, 6, '252610156', 0.00, 0, '2025-09-01 04:24:25', '2025-09-01 04:24:25'),
(157, 158, 6, '252610157', 0.00, 0, '2025-09-01 04:24:25', '2025-09-01 04:24:25'),
(158, 159, 6, '252610158', 0.00, 0, '2025-09-01 04:24:25', '2025-09-01 04:24:25'),
(159, 160, 7, '252610159', 0.00, 0, '2025-09-01 04:24:25', '2025-09-01 04:24:25'),
(160, 161, 7, '252610160', 0.00, 0, '2025-09-01 04:24:26', '2025-09-01 04:24:26'),
(161, 162, 7, '252610161', 0.00, 0, '2025-09-01 04:24:26', '2025-09-01 04:24:26'),
(162, 163, 7, '252610162', 0.00, 0, '2025-09-01 04:24:26', '2025-09-01 04:24:26'),
(163, 164, 7, '252610163', 0.00, 0, '2025-09-01 04:24:27', '2025-09-01 04:24:27'),
(164, 165, 7, '252610164', 0.00, 0, '2025-09-01 04:24:27', '2025-09-01 04:24:27'),
(165, 166, 7, '252610165', 0.00, 0, '2025-09-01 04:24:27', '2025-09-01 04:24:27'),
(166, 167, 7, '252610166', 0.00, 0, '2025-09-01 04:24:27', '2025-09-01 04:24:27'),
(167, 168, 7, '252610167', 0.00, 0, '2025-09-01 04:24:28', '2025-09-01 04:24:28'),
(168, 169, 7, '252610168', 0.00, 0, '2025-09-01 04:24:28', '2025-09-01 04:24:28'),
(169, 170, 7, '252610169', 0.00, 0, '2025-09-01 04:24:28', '2025-09-01 04:24:28'),
(170, 171, 7, '252610170', 0.00, 0, '2025-09-01 04:24:28', '2025-09-01 04:24:28'),
(171, 172, 7, '252610171', 0.00, 0, '2025-09-01 04:24:29', '2025-09-01 04:24:29'),
(172, 173, 7, '252610172', 0.00, 0, '2025-09-01 04:24:29', '2025-09-01 04:24:29'),
(173, 174, 7, '252610173', 0.00, 0, '2025-09-01 04:24:29', '2025-09-01 04:24:29'),
(174, 175, 7, '252610174', 0.00, 0, '2025-09-01 04:24:30', '2025-09-01 04:24:30'),
(175, 176, 7, '252610175', 0.00, 0, '2025-09-01 04:24:30', '2025-09-01 04:24:30'),
(176, 177, 7, '252610176', 0.00, 0, '2025-09-01 04:24:30', '2025-09-01 04:24:30'),
(177, 178, 7, '252610177', 0.00, 0, '2025-09-01 04:24:30', '2025-09-01 04:24:30'),
(178, 179, 7, '252610178', 0.00, 0, '2025-09-01 04:24:31', '2025-09-01 04:24:31'),
(179, 180, 7, '252610179', 0.00, 0, '2025-09-01 04:24:31', '2025-09-01 04:24:31'),
(180, 181, 7, '252610180', 0.00, 0, '2025-09-01 04:24:31', '2025-09-01 04:24:31'),
(181, 182, 7, '252610181', 0.00, 0, '2025-09-01 04:24:31', '2025-09-01 04:24:31'),
(182, 183, 7, '252610182', 0.00, 0, '2025-09-01 04:24:32', '2025-09-01 04:24:32'),
(183, 184, 7, '252610183', 0.00, 0, '2025-09-01 04:24:32', '2025-09-01 04:24:32'),
(184, 185, 7, '252610184', 0.00, 0, '2025-09-01 04:24:32', '2025-09-01 04:24:32'),
(185, 186, 7, '252610185', 0.00, 0, '2025-09-01 04:24:32', '2025-09-01 04:24:32'),
(186, 187, 7, '252610186', 0.00, 0, '2025-09-01 04:24:33', '2025-09-01 04:24:33'),
(187, 188, 7, '252610187', 0.00, 0, '2025-09-01 04:24:33', '2025-09-01 04:24:33'),
(188, 189, 7, '252610188', 0.00, 0, '2025-09-01 04:24:33', '2025-09-01 04:24:33'),
(189, 190, 7, '252610189', 0.00, 0, '2025-09-01 04:24:34', '2025-09-01 04:24:34'),
(190, 191, 7, '252610190', 0.00, 0, '2025-09-01 04:24:34', '2025-09-01 04:24:34'),
(191, 192, 7, '252610191', 0.00, 0, '2025-09-01 04:24:34', '2025-09-01 04:24:34'),
(192, 193, 7, '252610192', 0.00, 0, '2025-09-01 04:24:34', '2025-09-01 04:24:34'),
(193, 194, 8, '252610193', 0.00, 0, '2025-09-01 04:24:35', '2025-09-01 04:24:35'),
(194, 195, 8, '252610194', 0.00, 0, '2025-09-01 04:24:35', '2025-09-01 04:24:35'),
(195, 196, 8, '252610195', 0.00, 0, '2025-09-01 04:24:35', '2025-09-01 04:24:35'),
(196, 197, 8, '252610196', 0.00, 0, '2025-09-01 04:24:35', '2025-09-01 04:24:35'),
(197, 198, 8, '252610197', 0.00, 0, '2025-09-01 04:24:36', '2025-09-01 04:24:36'),
(198, 199, 8, '252610198', 0.00, 0, '2025-09-01 04:24:36', '2025-09-01 04:24:36'),
(199, 200, 8, '252610199', 0.00, 0, '2025-09-01 04:24:36', '2025-09-01 04:24:36'),
(200, 201, 8, '252610200', 0.00, 0, '2025-09-01 04:24:46', '2025-09-01 04:24:46'),
(201, 202, 8, '252610201', 0.00, 0, '2025-09-01 04:24:46', '2025-09-01 04:24:46'),
(202, 203, 8, '252610202', 0.00, 0, '2025-09-01 04:24:46', '2025-09-01 04:24:46'),
(203, 204, 8, '252610203', 0.00, 0, '2025-09-01 04:24:47', '2025-09-01 04:24:47'),
(204, 205, 8, '252610204', 0.00, 0, '2025-09-01 04:24:47', '2025-09-01 04:24:47'),
(205, 206, 8, '252610205', 0.00, 0, '2025-09-01 04:24:47', '2025-09-01 04:24:47'),
(206, 207, 8, '252610206', 0.00, 0, '2025-09-01 04:24:47', '2025-09-01 04:24:47'),
(207, 208, 8, '252610207', 0.00, 0, '2025-09-01 04:24:48', '2025-09-01 04:24:48'),
(208, 209, 8, '252610208', 0.00, 0, '2025-09-01 04:24:48', '2025-09-01 04:24:48'),
(209, 210, 8, '252610209', 0.00, 0, '2025-09-01 04:24:48', '2025-09-01 04:24:48'),
(210, 211, 8, '252610210', 0.00, 0, '2025-09-01 04:24:48', '2025-09-01 04:24:48'),
(211, 212, 8, '252610211', 0.00, 0, '2025-09-01 04:24:49', '2025-09-01 04:24:49'),
(212, 213, 8, '252610212', 0.00, 0, '2025-09-01 04:24:49', '2025-09-01 04:24:49'),
(213, 214, 8, '252610213', 0.00, 0, '2025-09-01 04:24:49', '2025-09-01 04:24:49'),
(214, 215, 8, '252610214', 0.00, 0, '2025-09-01 04:24:49', '2025-09-01 04:24:49'),
(215, 216, 8, '252610215', 0.00, 0, '2025-09-01 04:24:50', '2025-09-01 04:24:50'),
(216, 217, 8, '252610216', 0.00, 0, '2025-09-01 04:24:50', '2025-09-01 04:24:50'),
(217, 218, 8, '252610217', 0.00, 0, '2025-09-01 04:24:50', '2025-09-01 04:24:50'),
(218, 219, 8, '252610218', 0.00, 0, '2025-09-01 04:24:51', '2025-09-01 04:24:51'),
(219, 220, 8, '252610219', 0.00, 0, '2025-09-01 04:24:51', '2025-09-01 04:24:51'),
(220, 221, 8, '252610220', 0.00, 0, '2025-09-01 04:24:51', '2025-09-01 04:24:51'),
(221, 222, 8, '252610221', 0.00, 0, '2025-09-01 04:24:51', '2025-09-01 04:24:51'),
(222, 223, 8, '252610222', 0.00, 0, '2025-09-01 04:24:52', '2025-09-01 04:24:52'),
(223, 224, 8, '252610223', 0.00, 0, '2025-09-01 04:24:52', '2025-09-01 04:24:52'),
(224, 225, 8, '252610224', 0.00, 0, '2025-09-01 04:24:52', '2025-09-01 04:24:52'),
(225, 226, 8, '252610225', 0.00, 0, '2025-09-01 04:24:52', '2025-09-01 04:24:52'),
(226, 227, 8, '252610226', 0.00, 0, '2025-09-01 04:24:53', '2025-09-01 04:24:53'),
(227, 228, 8, '252610227', 0.00, 0, '2025-09-01 04:24:53', '2025-09-01 04:24:53'),
(228, 229, 9, '252610228', 0.00, 0, '2025-09-01 04:24:53', '2025-09-01 04:24:53'),
(229, 230, 9, '252610229', 0.00, 0, '2025-09-01 04:24:53', '2025-09-01 04:24:53'),
(230, 231, 9, '252610230', 0.00, 0, '2025-09-01 04:24:54', '2025-09-01 04:24:54'),
(231, 232, 9, '252610231', 0.00, 0, '2025-09-01 04:24:54', '2025-09-01 04:24:54'),
(232, 233, 9, '252610232', 0.00, 0, '2025-09-01 04:24:54', '2025-09-01 04:24:54'),
(233, 234, 9, '252610233', 0.00, 0, '2025-09-01 04:24:55', '2025-09-01 04:24:55'),
(234, 235, 9, '252610234', 0.00, 0, '2025-09-01 04:24:55', '2025-09-01 04:24:55'),
(235, 236, 9, '252610235', 0.00, 0, '2025-09-01 04:24:55', '2025-09-01 04:24:55'),
(236, 237, 9, '252610236', 0.00, 0, '2025-09-01 04:24:55', '2025-09-01 04:24:55'),
(237, 238, 9, '252610237', 0.00, 0, '2025-09-01 04:24:56', '2025-09-01 04:24:56'),
(238, 239, 9, '252610238', 0.00, 0, '2025-09-01 04:24:56', '2025-09-01 04:24:56'),
(239, 240, 9, '252610239', 0.00, 0, '2025-09-01 04:24:56', '2025-09-01 04:24:56'),
(240, 241, 9, '252610240', 0.00, 0, '2025-09-01 04:24:56', '2025-09-01 04:24:56'),
(241, 242, 9, '252610241', 0.00, 0, '2025-09-01 04:24:57', '2025-09-01 04:24:57'),
(242, 243, 9, '252610242', 0.00, 0, '2025-09-01 04:24:57', '2025-09-01 04:24:57'),
(243, 244, 9, '252610243', 0.00, 0, '2025-09-01 04:24:57', '2025-09-01 04:24:57'),
(244, 245, 9, '252610244', 0.00, 0, '2025-09-01 04:24:57', '2025-09-01 04:24:57'),
(245, 246, 9, '252610245', 0.00, 0, '2025-09-01 04:24:58', '2025-09-01 04:24:58'),
(246, 247, 9, '252610246', 0.00, 0, '2025-09-01 04:24:58', '2025-09-01 04:24:58'),
(247, 248, 9, '252610247', 0.00, 0, '2025-09-01 04:24:58', '2025-09-01 04:24:58'),
(248, 249, 9, '252610248', 0.00, 0, '2025-09-01 04:24:58', '2025-09-01 04:24:58'),
(249, 250, 9, '252610249', 0.00, 0, '2025-09-01 04:24:59', '2025-09-01 04:24:59'),
(250, 251, 9, '252610250', 0.00, 0, '2025-09-01 04:24:59', '2025-09-01 04:24:59'),
(251, 252, 9, '252610251', 0.00, 0, '2025-09-01 04:24:59', '2025-09-01 04:24:59'),
(252, 253, 9, '252610252', 0.00, 0, '2025-09-01 04:24:59', '2025-09-01 04:24:59'),
(253, 254, 9, '252610253', 0.00, 0, '2025-09-01 04:25:00', '2025-09-01 04:25:00'),
(254, 255, 9, '252610254', 0.00, 0, '2025-09-01 04:25:00', '2025-09-01 04:25:00'),
(255, 256, 9, '252610255', 0.00, 0, '2025-09-01 04:25:00', '2025-09-01 04:25:00'),
(256, 257, 9, '252610256', 0.00, 0, '2025-09-01 04:25:01', '2025-09-01 04:25:01'),
(257, 258, 9, '252610257', 0.00, 0, '2025-09-01 04:25:01', '2025-09-01 04:25:01'),
(258, 259, 9, '252610258', 0.00, 0, '2025-09-01 04:25:01', '2025-09-01 04:25:01'),
(259, 260, 9, '252610259', 0.00, 0, '2025-09-01 04:25:01', '2025-09-01 04:25:01'),
(260, 261, 9, '252610260', 0.00, 0, '2025-09-01 04:25:02', '2025-09-01 04:25:02'),
(261, 262, 9, '252610261', 0.00, 0, '2025-09-01 04:25:02', '2025-09-01 04:25:02'),
(262, 263, 9, '252610262', 0.00, 0, '2025-09-01 04:25:02', '2025-09-01 04:25:02'),
(263, 264, 10, '242510001', 0.00, 0, '2025-09-01 04:25:38', '2025-09-01 04:25:38'),
(264, 265, 10, '242510002', 0.00, 0, '2025-09-01 04:25:38', '2025-09-01 04:25:38'),
(265, 266, 10, '242510003', 0.00, 0, '2025-09-01 04:25:38', '2025-09-01 04:25:38'),
(266, 267, 10, '242510004', 0.00, 0, '2025-09-01 04:25:38', '2025-09-01 04:25:38'),
(267, 268, 10, '242510005', 0.00, 0, '2025-09-01 04:25:39', '2025-09-01 04:25:39'),
(268, 269, 10, '242510006', 0.00, 0, '2025-09-01 04:25:39', '2025-09-01 04:25:39'),
(269, 270, 10, '242510007', 0.00, 0, '2025-09-01 04:25:39', '2025-09-01 04:25:39'),
(270, 271, 10, '242510008', 0.00, 0, '2025-09-01 04:25:39', '2025-09-01 04:25:39'),
(271, 272, 10, '242510009', 0.00, 0, '2025-09-01 04:25:40', '2025-09-01 04:25:40'),
(272, 273, 10, '242510010', 0.00, 0, '2025-09-01 04:25:40', '2025-09-01 04:25:40'),
(273, 274, 10, '242510011', 0.00, 0, '2025-09-01 04:25:40', '2025-09-01 04:25:40'),
(274, 275, 10, '242510012', 0.00, 0, '2025-09-01 04:25:41', '2025-09-01 04:25:41'),
(275, 276, 10, '242510013', 0.00, 0, '2025-09-01 04:25:41', '2025-09-01 04:25:41'),
(276, 277, 10, '242510014', 0.00, 0, '2025-09-01 04:25:41', '2025-09-01 04:25:41'),
(277, 278, 10, '242510015', 0.00, 0, '2025-09-01 04:25:41', '2025-09-01 04:25:41'),
(278, 279, 10, '242510016', 0.00, 0, '2025-09-01 04:25:42', '2025-09-01 04:25:42'),
(279, 280, 10, '242510017', 0.00, 0, '2025-09-01 04:25:42', '2025-09-01 04:25:42'),
(280, 281, 10, '242510018', 0.00, 0, '2025-09-01 04:25:42', '2025-09-01 04:25:42'),
(281, 282, 10, '242510019', 0.00, 0, '2025-09-01 04:25:42', '2025-09-01 04:25:42'),
(282, 283, 10, '242510020', 0.00, 0, '2025-09-01 04:25:43', '2025-09-01 04:25:43'),
(283, 284, 10, '242510021', 0.00, 0, '2025-09-01 04:25:43', '2025-09-01 04:25:43'),
(284, 285, 10, '242510022', 0.00, 0, '2025-09-01 04:25:43', '2025-09-01 04:25:43'),
(285, 286, 10, '242510023', 0.00, 0, '2025-09-01 04:25:43', '2025-09-01 04:25:43'),
(286, 287, 10, '242510024', 0.00, 0, '2025-09-01 04:25:44', '2025-09-01 04:25:44'),
(287, 288, 10, '242510025', 0.00, 0, '2025-09-01 04:25:44', '2025-09-01 04:25:44'),
(288, 289, 10, '242510026', 0.00, 0, '2025-09-01 04:25:44', '2025-09-01 04:25:44'),
(289, 290, 10, '242510027', 0.00, 0, '2025-09-01 04:25:45', '2025-09-01 04:25:45'),
(290, 291, 10, '242510028', 0.00, 0, '2025-09-01 04:25:45', '2025-09-01 04:25:45'),
(291, 292, 10, '242510029', 0.00, 0, '2025-09-01 04:25:45', '2025-09-01 04:25:45'),
(292, 293, 10, '242510030', 0.00, 0, '2025-09-01 04:25:45', '2025-09-01 04:25:45'),
(293, 294, 10, '242510031', 0.00, 0, '2025-09-01 04:25:46', '2025-09-01 04:25:46'),
(294, 295, 10, '242510032', 0.00, 0, '2025-09-01 04:25:46', '2025-09-01 04:25:46'),
(295, 296, 10, '242510033', 0.00, 0, '2025-09-01 04:25:46', '2025-09-01 04:25:46'),
(296, 297, 11, '242510034', 0.00, 0, '2025-09-01 04:25:46', '2025-09-01 04:25:46'),
(297, 298, 11, '242510035', 0.00, 0, '2025-09-01 04:25:47', '2025-09-01 04:25:47'),
(298, 299, 11, '242510036', 0.00, 0, '2025-09-01 04:25:47', '2025-09-01 04:25:47'),
(299, 300, 11, '242510037', 0.00, 0, '2025-09-01 04:25:47', '2025-09-01 04:25:47'),
(300, 301, 11, '242510038', 0.00, 0, '2025-09-01 04:25:47', '2025-09-01 04:25:47'),
(301, 302, 11, '242510039', 0.00, 0, '2025-09-01 04:25:48', '2025-09-01 04:25:48'),
(302, 303, 11, '242510040', 0.00, 0, '2025-09-01 04:25:48', '2025-09-01 04:25:48'),
(303, 304, 11, '242510041', 0.00, 0, '2025-09-01 04:25:48', '2025-09-01 04:25:48'),
(304, 305, 11, '242510042', 0.00, 0, '2025-09-01 04:25:49', '2025-09-01 04:25:49'),
(305, 306, 11, '242510043', 0.00, 0, '2025-09-01 04:25:49', '2025-09-01 04:25:49'),
(306, 307, 11, '242510044', 0.00, 0, '2025-09-01 04:25:49', '2025-09-01 04:25:49'),
(307, 308, 11, '242510045', 0.00, 0, '2025-09-01 04:25:49', '2025-09-01 04:25:49'),
(308, 309, 11, '242510046', 0.00, 0, '2025-09-01 04:25:50', '2025-09-01 04:25:50'),
(309, 310, 11, '242510047', 0.00, 0, '2025-09-01 04:25:50', '2025-09-01 04:25:50'),
(310, 311, 11, '242510048', 0.00, 0, '2025-09-01 04:25:50', '2025-09-01 04:25:50'),
(311, 312, 11, '242510049', 0.00, 0, '2025-09-01 04:25:50', '2025-09-01 04:25:50'),
(312, 313, 11, '242510050', 0.00, 0, '2025-09-01 04:25:51', '2025-09-01 04:25:51'),
(313, 314, 11, '242510051', 0.00, 0, '2025-09-01 04:25:51', '2025-09-01 04:25:51'),
(314, 315, 11, '242510052', 0.00, 0, '2025-09-01 04:25:51', '2025-09-01 04:25:51'),
(315, 316, 11, '242510053', 0.00, 0, '2025-09-01 04:25:52', '2025-09-01 04:25:52'),
(316, 317, 11, '242510054', 0.00, 0, '2025-09-01 04:25:52', '2025-09-01 04:25:52'),
(317, 318, 11, '242510055', 0.00, 0, '2025-09-01 04:25:52', '2025-09-01 04:25:52'),
(318, 319, 11, '242510056', 0.00, 0, '2025-09-01 04:25:52', '2025-09-01 04:25:52'),
(319, 320, 11, '242510057', 0.00, 0, '2025-09-01 04:25:53', '2025-09-01 04:25:53'),
(320, 321, 11, '242510058', 0.00, 0, '2025-09-01 04:25:53', '2025-09-01 04:25:53'),
(321, 322, 11, '242510059', 0.00, 0, '2025-09-01 04:25:53', '2025-09-01 04:25:53'),
(322, 323, 11, '242510060', 0.00, 0, '2025-09-01 04:25:53', '2025-09-01 04:25:53'),
(323, 324, 11, '242510061', 0.00, 0, '2025-09-01 04:25:54', '2025-09-01 04:25:54'),
(324, 325, 11, '242510062', 0.00, 0, '2025-09-01 04:25:54', '2025-09-01 04:25:54'),
(325, 326, 11, '242510063', 0.00, 0, '2025-09-01 04:25:54', '2025-09-01 04:25:54'),
(326, 327, 11, '242510064', 0.00, 0, '2025-09-01 04:25:55', '2025-09-01 04:25:55'),
(327, 328, 12, '242510065', 0.00, 0, '2025-09-01 04:25:55', '2025-09-01 04:25:55'),
(328, 329, 12, '242510066', 0.00, 0, '2025-09-01 04:25:55', '2025-09-01 04:25:55'),
(329, 330, 12, '242510067', 0.00, 0, '2025-09-01 04:25:55', '2025-09-01 04:25:55'),
(330, 331, 12, '242510068', 0.00, 0, '2025-09-01 04:25:56', '2025-09-01 04:25:56'),
(331, 332, 12, '242510069', 0.00, 0, '2025-09-01 04:25:56', '2025-09-01 04:25:56'),
(332, 333, 12, '242510070', 0.00, 0, '2025-09-01 04:25:56', '2025-09-01 04:25:56'),
(333, 334, 12, '242510071', 0.00, 0, '2025-09-01 04:25:56', '2025-09-01 04:25:56'),
(334, 335, 12, '242510072', 0.00, 0, '2025-09-01 04:25:57', '2025-09-01 04:25:57'),
(335, 336, 12, '242510073', 0.00, 0, '2025-09-01 04:25:57', '2025-09-01 04:25:57'),
(336, 337, 12, '242510074', 0.00, 0, '2025-09-01 04:25:57', '2025-09-01 04:25:57'),
(337, 338, 12, '242510075', 0.00, 0, '2025-09-01 04:25:58', '2025-09-01 04:25:58'),
(338, 339, 12, '242510076', 0.00, 0, '2025-09-01 04:25:58', '2025-09-01 04:25:58'),
(339, 340, 12, '242510077', 0.00, 0, '2025-09-01 04:25:58', '2025-09-01 04:25:58'),
(340, 341, 12, '242510078', 0.00, 0, '2025-09-01 04:25:58', '2025-09-01 04:25:58'),
(341, 342, 12, '242510079', 0.00, 0, '2025-09-01 04:25:59', '2025-09-01 04:25:59'),
(342, 343, 12, '242510080', 0.00, 0, '2025-09-01 04:25:59', '2025-09-01 04:25:59'),
(343, 344, 12, '242510081', 0.00, 0, '2025-09-01 04:25:59', '2025-09-01 04:25:59'),
(344, 345, 12, '242510082', 0.00, 0, '2025-09-01 04:25:59', '2025-09-01 04:25:59'),
(345, 346, 12, '242510083', 0.00, 0, '2025-09-01 04:26:00', '2025-09-01 04:26:00'),
(346, 347, 12, '242510084', 0.00, 0, '2025-09-01 04:26:00', '2025-09-01 04:26:00'),
(347, 348, 12, '242510085', 0.00, 0, '2025-09-01 04:26:00', '2025-09-01 04:26:00'),
(348, 349, 12, '242510086', 0.00, 0, '2025-09-01 04:26:00', '2025-09-01 04:26:00'),
(349, 350, 12, '242510087', 0.00, 0, '2025-09-01 04:26:01', '2025-09-01 04:26:01'),
(350, 351, 12, '242510088', 0.00, 0, '2025-09-01 04:26:01', '2025-09-01 04:26:01'),
(351, 352, 12, '242510089', 0.00, 0, '2025-09-01 04:26:01', '2025-09-01 04:26:01'),
(352, 353, 12, '242510090', 0.00, 0, '2025-09-01 04:26:01', '2025-09-01 04:26:01'),
(353, 354, 12, '242510091', 0.00, 0, '2025-09-01 04:26:02', '2025-09-01 04:26:02'),
(354, 355, 12, '242510092', 0.00, 0, '2025-09-01 04:26:02', '2025-09-01 04:26:02'),
(355, 356, 12, '242510093', 0.00, 0, '2025-09-01 04:26:02', '2025-09-01 04:26:02'),
(356, 357, 12, '242510094', 0.00, 0, '2025-09-01 04:26:02', '2025-09-01 04:26:02'),
(357, 358, 12, '242510095', 0.00, 0, '2025-09-01 04:26:03', '2025-09-01 04:26:03'),
(358, 359, 12, '242510096', 0.00, 0, '2025-09-01 04:26:03', '2025-09-01 04:26:03'),
(359, 360, 13, '242510097', 0.00, 0, '2025-09-01 04:26:03', '2025-09-01 04:26:03'),
(360, 361, 13, '242510098', 0.00, 0, '2025-09-01 04:26:04', '2025-09-01 04:26:04'),
(361, 362, 13, '242510099', 0.00, 0, '2025-09-01 04:26:04', '2025-09-01 04:26:04'),
(362, 363, 13, '242510100', 0.00, 0, '2025-09-01 04:26:04', '2025-09-01 04:26:04'),
(363, 364, 13, '242510101', 0.00, 0, '2025-09-01 04:26:04', '2025-09-01 04:26:04'),
(364, 365, 13, '242510102', 0.00, 0, '2025-09-01 04:26:05', '2025-09-01 04:26:05'),
(365, 366, 13, '242510103', 0.00, 0, '2025-09-01 04:26:05', '2025-09-01 04:26:05'),
(366, 367, 13, '242510104', 0.00, 0, '2025-09-01 04:26:05', '2025-09-01 04:26:05'),
(367, 368, 13, '242510105', 0.00, 0, '2025-09-01 04:26:05', '2025-09-01 04:26:05'),
(368, 369, 13, '242510106', 0.00, 0, '2025-09-01 04:26:06', '2025-09-01 04:26:06'),
(369, 370, 13, '242510107', 0.00, 0, '2025-09-01 04:26:06', '2025-09-01 04:26:06'),
(370, 371, 13, '242510108', 0.00, 0, '2025-09-01 04:26:06', '2025-09-01 04:26:06'),
(371, 372, 13, '242510109', 0.00, 0, '2025-09-01 04:26:06', '2025-09-01 04:26:06'),
(372, 373, 13, '242510110', 0.00, 0, '2025-09-01 04:26:07', '2025-09-01 04:26:07'),
(373, 374, 13, '242510111', 0.00, 0, '2025-09-01 04:26:07', '2025-09-01 04:26:07'),
(374, 375, 13, '242510112', 0.00, 0, '2025-09-01 04:26:07', '2025-09-01 04:26:07'),
(375, 376, 13, '242510113', 0.00, 0, '2025-09-01 04:26:08', '2025-09-01 04:26:08'),
(376, 377, 13, '242510114', 0.00, 0, '2025-09-01 04:26:08', '2025-09-01 04:26:08'),
(377, 378, 13, '242510115', 0.00, 0, '2025-09-01 04:26:08', '2025-09-01 04:26:08'),
(378, 379, 13, '242510116', 0.00, 0, '2025-09-01 04:26:08', '2025-09-01 04:26:08'),
(379, 380, 13, '242510117', 0.00, 0, '2025-09-01 04:26:09', '2025-09-01 04:26:09'),
(380, 381, 13, '242510118', 0.00, 0, '2025-09-01 04:26:09', '2025-09-01 04:26:09'),
(381, 382, 13, '242510119', 0.00, 0, '2025-09-01 04:26:09', '2025-09-01 04:26:09'),
(382, 383, 13, '242510120', 0.00, 0, '2025-09-01 04:26:09', '2025-09-01 04:26:09'),
(383, 384, 13, '242510121', 0.00, 0, '2025-09-01 04:26:10', '2025-09-01 04:26:10'),
(384, 385, 13, '242510122', 0.00, 0, '2025-09-01 04:26:10', '2025-09-01 04:26:10'),
(385, 386, 13, '242510123', 0.00, 0, '2025-09-01 04:26:10', '2025-09-01 04:26:10'),
(386, 387, 13, '242510124', 0.00, 0, '2025-09-01 04:26:11', '2025-09-01 04:26:11'),
(387, 388, 14, '242510125', 0.00, 0, '2025-09-01 04:26:11', '2025-09-01 04:26:11'),
(388, 389, 14, '242510126', 0.00, 0, '2025-09-01 04:26:11', '2025-09-01 04:26:11'),
(389, 390, 14, '242510127', 0.00, 0, '2025-09-01 04:26:11', '2025-09-01 04:26:11'),
(390, 391, 14, '242510128', 0.00, 0, '2025-09-01 04:26:12', '2025-09-01 04:26:12'),
(391, 392, 14, '242510129', 0.00, 0, '2025-09-01 04:26:12', '2025-09-01 04:26:12'),
(392, 393, 14, '242510130', 0.00, 0, '2025-09-01 04:26:12', '2025-09-01 04:26:12'),
(393, 394, 14, '242510131', 0.00, 0, '2025-09-01 04:26:12', '2025-09-01 04:26:12'),
(394, 395, 14, '242510132', 0.00, 0, '2025-09-01 04:26:13', '2025-09-01 04:26:13'),
(395, 396, 14, '242510133', 0.00, 0, '2025-09-01 04:26:13', '2025-09-01 04:26:13'),
(396, 397, 14, '242510134', 0.00, 0, '2025-09-01 04:26:13', '2025-09-01 04:26:13'),
(397, 398, 14, '242510135', 0.00, 0, '2025-09-01 04:26:13', '2025-09-01 04:26:13'),
(398, 399, 14, '242510136', 0.00, 0, '2025-09-01 04:26:14', '2025-09-01 04:26:14'),
(399, 400, 14, '242510137', 0.00, 0, '2025-09-01 04:26:14', '2025-09-01 04:26:14'),
(400, 401, 14, '242510138', 0.00, 0, '2025-09-01 04:26:14', '2025-09-01 04:26:14'),
(401, 402, 14, '242510139', 0.00, 0, '2025-09-01 04:26:14', '2025-09-01 04:26:14'),
(402, 403, 14, '242510140', 0.00, 0, '2025-09-01 04:26:15', '2025-09-01 04:26:15'),
(403, 404, 14, '242510141', 0.00, 0, '2025-09-01 04:26:15', '2025-09-01 04:26:15'),
(404, 405, 14, '242510142', 0.00, 0, '2025-09-01 04:26:15', '2025-09-01 04:26:15'),
(405, 406, 14, '242510143', 0.00, 0, '2025-09-01 04:26:16', '2025-09-01 04:26:16'),
(406, 407, 14, '242510144', 0.00, 0, '2025-09-01 04:26:16', '2025-09-01 04:26:16'),
(407, 408, 14, '242510145', 0.00, 0, '2025-09-01 04:26:16', '2025-09-01 04:26:16'),
(408, 409, 14, '242510146', 0.00, 0, '2025-09-01 04:26:16', '2025-09-01 04:26:16'),
(409, 410, 14, '242510147', 0.00, 0, '2025-09-01 04:26:17', '2025-09-01 04:26:17'),
(410, 411, 14, '242510148', 0.00, 0, '2025-09-01 04:26:17', '2025-09-01 04:26:17'),
(411, 412, 14, '242510149', 0.00, 0, '2025-09-01 04:26:17', '2025-09-01 04:26:17'),
(412, 413, 14, '242510150', 0.00, 0, '2025-09-01 04:26:17', '2025-09-01 04:26:17'),
(413, 414, 14, '242510151', 0.00, 0, '2025-09-01 04:26:18', '2025-09-01 04:26:18'),
(414, 415, 14, '242510152', 0.00, 0, '2025-09-01 04:26:18', '2025-09-01 04:26:18'),
(415, 416, 15, '242510153', 0.00, 0, '2025-09-01 04:26:18', '2025-09-01 04:26:18'),
(416, 417, 15, '242510154', 0.00, 0, '2025-09-01 04:26:18', '2025-09-01 04:26:18'),
(417, 418, 15, '242510155', 0.00, 0, '2025-09-01 04:26:19', '2025-09-01 04:26:19'),
(418, 419, 15, '242510156', 0.00, 0, '2025-09-01 04:26:19', '2025-09-01 04:26:19'),
(419, 420, 15, '242510157', 0.00, 0, '2025-09-01 04:26:19', '2025-09-01 04:26:19'),
(420, 421, 15, '242510158', 0.00, 0, '2025-09-01 04:26:20', '2025-09-01 04:26:20'),
(421, 422, 15, '242510159', 0.00, 0, '2025-09-01 04:26:20', '2025-09-01 04:26:20'),
(422, 423, 15, '242510160', 0.00, 0, '2025-09-01 04:26:20', '2025-09-01 04:26:20'),
(423, 424, 15, '242510161', 0.00, 0, '2025-09-01 04:26:20', '2025-09-01 04:26:20'),
(424, 425, 15, '242510162', 0.00, 0, '2025-09-01 04:26:21', '2025-09-01 04:26:21'),
(425, 426, 15, '242510163', 0.00, 0, '2025-09-01 04:26:21', '2025-09-01 04:26:21'),
(426, 427, 15, '242510164', 0.00, 0, '2025-09-01 04:26:21', '2025-09-01 04:26:21'),
(427, 428, 15, '242510165', 0.00, 0, '2025-09-01 04:26:21', '2025-09-01 04:26:21'),
(428, 429, 15, '242510166', 0.00, 0, '2025-09-01 04:26:22', '2025-09-01 04:26:22'),
(429, 430, 15, '242510167', 0.00, 0, '2025-09-01 04:26:22', '2025-09-01 04:26:22'),
(430, 431, 15, '242510168', 0.00, 0, '2025-09-01 04:26:22', '2025-09-01 04:26:22'),
(431, 432, 15, '242510169', 0.00, 0, '2025-09-01 04:26:22', '2025-09-01 04:26:22'),
(432, 433, 15, '242510170', 0.00, 0, '2025-09-01 04:26:23', '2025-09-01 04:26:23'),
(433, 434, 15, '242510171', 0.00, 0, '2025-09-01 04:26:23', '2025-09-01 04:26:23'),
(434, 435, 15, '242510172', 0.00, 0, '2025-09-01 04:26:23', '2025-09-01 04:26:23'),
(435, 436, 15, '242510173', 0.00, 0, '2025-09-01 04:26:23', '2025-09-01 04:26:23'),
(436, 437, 15, '242510174', 0.00, 0, '2025-09-01 04:26:24', '2025-09-01 04:26:24'),
(437, 438, 15, '242510175', 0.00, 0, '2025-09-01 04:26:24', '2025-09-01 04:26:24'),
(438, 439, 15, '242510176', 0.00, 0, '2025-09-01 04:26:24', '2025-09-01 04:26:24'),
(439, 440, 15, '242510177', 0.00, 0, '2025-09-01 04:26:25', '2025-09-01 04:26:25'),
(440, 441, 15, '242510178', 0.00, 0, '2025-09-01 04:26:25', '2025-09-01 04:26:25'),
(441, 442, 16, '242510179', 0.00, 0, '2025-09-01 04:26:25', '2025-09-01 04:26:25'),
(442, 443, 16, '242510180', 0.00, 0, '2025-09-01 04:26:25', '2025-09-01 04:26:25'),
(443, 444, 16, '242510181', 0.00, 0, '2025-09-01 04:26:26', '2025-09-01 04:26:26'),
(444, 445, 16, '242510182', 0.00, 0, '2025-09-01 04:26:26', '2025-09-01 04:26:26'),
(445, 446, 16, '242510183', 0.00, 0, '2025-09-01 04:26:26', '2025-09-01 04:26:26'),
(446, 447, 16, '242510184', 0.00, 0, '2025-09-01 04:26:26', '2025-09-01 04:26:26'),
(447, 448, 16, '242510185', 0.00, 0, '2025-09-01 04:26:27', '2025-09-01 04:26:27'),
(448, 449, 16, '242510186', 0.00, 0, '2025-09-01 04:26:27', '2025-09-01 04:26:27'),
(449, 450, 16, '242510187', 0.00, 0, '2025-09-01 04:26:27', '2025-09-01 04:26:27'),
(450, 451, 16, '242510188', 0.00, 0, '2025-09-01 04:26:27', '2025-09-01 04:26:27'),
(451, 452, 16, '242510189', 0.00, 0, '2025-09-01 04:26:28', '2025-09-01 04:26:28'),
(452, 453, 16, '242510190', 0.00, 0, '2025-09-01 04:26:28', '2025-09-01 04:26:28'),
(453, 454, 16, '242510191', 0.00, 0, '2025-09-01 04:26:28', '2025-09-01 04:26:28'),
(454, 455, 16, '242510192', 0.00, 0, '2025-09-01 04:26:29', '2025-09-01 04:26:29'),
(455, 456, 16, '242510193', 0.00, 0, '2025-09-01 04:26:29', '2025-09-01 04:26:29'),
(456, 457, 16, '242510194', 0.00, 0, '2025-09-01 04:26:29', '2025-09-01 04:26:29'),
(457, 458, 16, '242510195', 0.00, 0, '2025-09-01 04:26:29', '2025-09-01 04:26:29'),
(458, 459, 16, '242510196', 0.00, 0, '2025-09-01 04:26:30', '2025-09-01 04:26:30'),
(459, 460, 16, '242510197', 0.00, 0, '2025-09-01 04:26:30', '2025-09-01 04:26:30'),
(460, 461, 16, '242510198', 0.00, 0, '2025-09-01 04:26:30', '2025-09-01 04:26:30'),
(461, 462, 16, '242510199', 0.00, 0, '2025-09-01 04:26:30', '2025-09-01 04:26:30'),
(462, 463, 16, '242510200', 0.00, 0, '2025-09-01 04:26:53', '2025-09-01 04:26:53'),
(463, 464, 16, '242510201', 0.00, 0, '2025-09-01 04:26:53', '2025-09-01 04:26:53'),
(464, 465, 16, '242510202', 0.00, 0, '2025-09-01 04:26:54', '2025-09-01 04:26:54'),
(465, 466, 16, '242510203', 0.00, 0, '2025-09-01 04:26:54', '2025-09-01 04:26:54'),
(466, 467, 16, '242510204', 0.00, 0, '2025-09-01 04:26:54', '2025-09-01 04:26:54'),
(467, 468, 16, '242510205', 0.00, 0, '2025-09-01 04:26:54', '2025-09-01 04:26:54'),
(468, 469, 16, '242510206', 0.00, 0, '2025-09-01 04:26:55', '2025-09-01 04:26:55'),
(469, 470, 16, '242510207', 0.00, 0, '2025-09-01 04:26:55', '2025-09-01 04:26:55'),
(470, 471, 16, '242510208', 0.00, 0, '2025-09-01 04:26:55', '2025-09-01 04:26:55'),
(471, 472, 16, '242510209', 0.00, 0, '2025-09-01 04:26:55', '2025-09-01 04:26:55'),
(472, 473, 16, '242510210', 0.00, 0, '2025-09-01 04:26:56', '2025-09-01 04:26:56'),
(473, 474, 17, '242510211', 0.00, 0, '2025-09-01 04:26:56', '2025-09-01 04:26:56'),
(474, 475, 17, '242510212', 0.00, 0, '2025-09-01 04:26:56', '2025-09-01 04:26:56'),
(475, 476, 17, '242510213', 0.00, 0, '2025-09-01 04:26:56', '2025-09-01 04:26:56'),
(476, 477, 17, '242510214', 0.00, 0, '2025-09-01 04:26:57', '2025-09-01 04:26:57'),
(477, 478, 17, '242510215', 0.00, 0, '2025-09-01 04:26:57', '2025-09-01 04:26:57'),
(478, 479, 17, '242510216', 0.00, 0, '2025-09-01 04:26:57', '2025-09-01 04:26:57'),
(479, 480, 17, '242510217', 0.00, 0, '2025-09-01 04:26:57', '2025-09-01 04:26:57'),
(480, 481, 17, '242510218', 0.00, 0, '2025-09-01 04:26:58', '2025-09-01 04:26:58'),
(481, 482, 17, '242510219', 0.00, 0, '2025-09-01 04:26:58', '2025-09-01 04:26:58'),
(482, 483, 17, '242510220', 0.00, 0, '2025-09-01 04:26:58', '2025-09-01 04:26:58'),
(483, 484, 17, '242510221', 0.00, 0, '2025-09-01 04:26:59', '2025-09-01 04:26:59'),
(484, 485, 17, '242510222', 0.00, 0, '2025-09-01 04:26:59', '2025-09-01 04:26:59'),
(485, 486, 17, '242510223', 0.00, 0, '2025-09-01 04:26:59', '2025-09-01 04:26:59'),
(486, 487, 17, '242510224', 0.00, 0, '2025-09-01 04:26:59', '2025-09-01 04:26:59'),
(487, 488, 17, '242510225', 0.00, 0, '2025-09-01 04:27:00', '2025-09-01 04:27:00'),
(488, 489, 17, '242510226', 0.00, 0, '2025-09-01 04:27:00', '2025-09-01 04:27:00'),
(489, 490, 17, '242510227', 0.00, 0, '2025-09-01 04:27:00', '2025-09-01 04:27:00'),
(490, 491, 17, '242510228', 0.00, 0, '2025-09-01 04:27:00', '2025-09-01 04:27:00'),
(491, 492, 17, '242510229', 0.00, 0, '2025-09-01 04:27:01', '2025-09-01 04:27:01'),
(492, 493, 17, '242510230', 0.00, 0, '2025-09-01 04:27:01', '2025-09-01 04:27:01'),
(493, 494, 17, '242510231', 0.00, 0, '2025-09-01 04:27:01', '2025-09-01 04:27:01'),
(494, 495, 17, '242510232', 0.00, 0, '2025-09-01 04:27:01', '2025-09-01 04:27:01'),
(495, 496, 17, '242510233', 0.00, 0, '2025-09-01 04:27:02', '2025-09-01 04:27:02'),
(496, 497, 17, '242510234', 0.00, 0, '2025-09-01 04:27:02', '2025-09-01 04:27:02'),
(497, 498, 17, '242510235', 0.00, 0, '2025-09-01 04:27:02', '2025-09-01 04:27:02'),
(498, 499, 17, '242510236', 0.00, 0, '2025-09-01 04:27:02', '2025-09-01 04:27:02'),
(499, 500, 18, '242510237', 0.00, 0, '2025-09-01 04:27:03', '2025-09-01 04:27:03'),
(500, 501, 18, '242510238', 0.00, 0, '2025-09-01 04:27:03', '2025-09-01 04:27:03'),
(501, 502, 18, '242510239', 0.00, 0, '2025-09-01 04:27:03', '2025-09-01 04:27:03'),
(502, 503, 18, '242510240', 0.00, 0, '2025-09-01 04:27:03', '2025-09-01 04:27:03'),
(503, 504, 18, '242510241', 0.00, 0, '2025-09-01 04:27:04', '2025-09-01 04:27:04'),
(504, 505, 18, '242510242', 0.00, 0, '2025-09-01 04:27:04', '2025-09-01 04:27:04'),
(505, 506, 18, '242510243', 0.00, 0, '2025-09-01 04:27:04', '2025-09-01 04:27:04'),
(506, 507, 18, '242510244', 0.00, 0, '2025-09-01 04:27:05', '2025-09-01 04:27:05'),
(507, 508, 18, '242510245', 0.00, 0, '2025-09-01 04:27:05', '2025-09-01 04:27:05'),
(508, 509, 18, '242510246', 0.00, 0, '2025-09-01 04:27:05', '2025-09-01 04:27:05'),
(509, 510, 18, '242510247', 0.00, 0, '2025-09-01 04:27:05', '2025-09-01 04:27:05'),
(510, 511, 18, '242510248', 0.00, 0, '2025-09-01 04:27:06', '2025-09-01 04:27:06'),
(511, 512, 18, '242510249', 0.00, 0, '2025-09-01 04:27:06', '2025-09-01 04:27:06'),
(512, 513, 18, '242510250', 0.00, 0, '2025-09-01 04:27:06', '2025-09-01 04:27:06'),
(513, 514, 18, '242510251', 0.00, 0, '2025-09-01 04:27:06', '2025-09-01 04:27:06'),
(514, 515, 18, '242510252', 0.00, 0, '2025-09-01 04:27:07', '2025-09-01 04:27:07'),
(515, 516, 18, '242510253', 0.00, 0, '2025-09-01 04:27:07', '2025-09-01 04:27:07'),
(516, 517, 18, '242510254', 0.00, 0, '2025-09-01 04:27:07', '2025-09-01 04:27:07'),
(517, 518, 18, '242510255', 0.00, 0, '2025-09-01 04:27:07', '2025-09-01 04:27:07'),
(518, 519, 18, '242510256', 0.00, 0, '2025-09-01 04:27:08', '2025-09-01 04:27:08'),
(519, 520, 18, '242510257', 0.00, 0, '2025-09-01 04:27:08', '2025-09-01 04:27:08'),
(520, 521, 18, '242510258', 0.00, 0, '2025-09-01 04:27:08', '2025-09-01 04:27:08'),
(521, 522, 18, '242510259', 0.00, 0, '2025-09-01 04:27:08', '2025-09-01 04:27:08'),
(522, 523, 18, '242510260', 0.00, 0, '2025-09-01 04:27:09', '2025-09-01 04:27:09'),
(523, 524, 18, '242510261', 0.00, 0, '2025-09-01 04:27:09', '2025-09-01 04:27:09'),
(524, 525, 18, '242510262', 0.00, 0, '2025-09-01 04:27:09', '2025-09-01 04:27:09'),
(525, 526, 18, '242510263', 0.00, 0, '2025-09-01 04:27:10', '2025-09-01 04:27:10'),
(526, 527, 18, '242510264', 0.00, 0, '2025-09-01 04:27:10', '2025-09-01 04:27:10'),
(527, 528, 19, '232410001', 0.00, 0, '2025-09-01 04:27:16', '2025-09-01 04:27:16'),
(528, 529, 19, '232410002', 0.00, 0, '2025-09-01 04:27:16', '2025-09-01 04:27:16'),
(529, 530, 19, '232410003', 0.00, 0, '2025-09-01 04:27:16', '2025-09-01 04:27:16'),
(530, 531, 19, '232410004', 0.00, 0, '2025-09-01 04:27:17', '2025-09-01 04:27:17'),
(531, 532, 19, '232410005', 0.00, 0, '2025-09-01 04:27:17', '2025-09-01 04:27:17'),
(532, 533, 19, '232410006', 0.00, 0, '2025-09-01 04:27:17', '2025-09-01 04:27:17'),
(533, 534, 19, '232410007', 0.00, 0, '2025-09-01 04:27:18', '2025-09-01 04:27:18'),
(534, 535, 19, '232410008', 0.00, 0, '2025-09-01 04:27:18', '2025-09-01 04:27:18'),
(535, 536, 19, '232410009', 0.00, 0, '2025-09-01 04:27:18', '2025-09-01 04:27:18'),
(536, 537, 19, '232410010', 0.00, 0, '2025-09-01 04:27:18', '2025-09-01 04:27:18'),
(537, 538, 19, '232410011', 0.00, 0, '2025-09-01 04:27:19', '2025-09-01 04:27:19'),
(538, 539, 19, '232410012', 0.00, 0, '2025-09-01 04:27:19', '2025-09-01 04:27:19'),
(539, 540, 19, '232410013', 0.00, 0, '2025-09-01 04:27:19', '2025-09-01 04:27:19'),
(540, 541, 19, '232410014', 0.00, 0, '2025-09-01 04:27:19', '2025-09-01 04:27:19'),
(541, 542, 19, '232410015', 0.00, 0, '2025-09-01 04:27:20', '2025-09-01 04:27:20'),
(542, 543, 19, '232410016', 0.00, 0, '2025-09-01 04:27:20', '2025-09-01 04:27:20'),
(543, 544, 19, '232410017', 0.00, 0, '2025-09-01 04:27:20', '2025-09-01 04:27:20'),
(544, 545, 19, '232410018', 0.00, 0, '2025-09-01 04:27:20', '2025-09-01 04:27:20'),
(545, 546, 19, '232410019', 0.00, 0, '2025-09-01 04:27:21', '2025-09-01 04:27:21'),
(546, 547, 19, '232410020', 0.00, 0, '2025-09-01 04:27:21', '2025-09-01 04:27:21'),
(547, 548, 19, '232410021', 0.00, 0, '2025-09-01 04:27:21', '2025-09-01 04:27:21'),
(548, 549, 19, '232410022', 0.00, 0, '2025-09-01 04:27:21', '2025-09-01 04:27:21'),
(549, 550, 19, '232410023', 0.00, 0, '2025-09-01 04:27:22', '2025-09-01 04:27:22'),
(550, 551, 19, '232410024', 0.00, 0, '2025-09-01 04:27:22', '2025-09-01 04:27:22'),
(551, 552, 19, '232410025', 0.00, 0, '2025-09-01 04:27:22', '2025-09-01 04:27:22'),
(552, 553, 19, '232410026', 0.00, 0, '2025-09-01 04:27:23', '2025-09-01 04:27:23'),
(553, 554, 20, '232410027', 0.00, 0, '2025-09-01 04:27:23', '2025-09-01 04:27:23'),
(554, 555, 20, '232410028', 0.00, 0, '2025-09-01 04:27:23', '2025-09-01 04:27:23'),
(555, 556, 20, '232410029', 0.00, 0, '2025-09-01 04:27:23', '2025-09-01 04:27:23'),
(556, 557, 20, '232410030', 0.00, 0, '2025-09-01 04:27:24', '2025-09-01 04:27:24'),
(557, 558, 20, '232410031', 0.00, 0, '2025-09-01 04:27:24', '2025-09-01 04:27:24'),
(558, 559, 20, '232410032', 0.00, 0, '2025-09-01 04:27:24', '2025-09-01 04:27:24'),
(559, 560, 20, '232410033', 0.00, 0, '2025-09-01 04:27:24', '2025-09-01 04:27:24'),
(560, 561, 20, '232410034', 0.00, 0, '2025-09-01 04:27:25', '2025-09-01 04:27:25'),
(561, 562, 20, '232410035', 0.00, 0, '2025-09-01 04:27:25', '2025-09-01 04:27:25'),
(562, 563, 20, '232410036', 0.00, 0, '2025-09-01 04:27:25', '2025-09-01 04:27:25'),
(563, 564, 20, '232410037', 0.00, 0, '2025-09-01 04:27:25', '2025-09-01 04:27:25'),
(564, 565, 20, '232410038', 0.00, 0, '2025-09-01 04:27:26', '2025-09-01 04:27:26'),
(565, 566, 20, '232410039', 0.00, 0, '2025-09-01 04:27:26', '2025-09-01 04:27:26'),
(566, 567, 20, '232410040', 0.00, 0, '2025-09-01 04:27:26', '2025-09-01 04:27:26'),
(567, 568, 20, '232410041', 0.00, 0, '2025-09-01 04:27:27', '2025-09-01 04:27:27'),
(568, 569, 20, '232410042', 0.00, 0, '2025-09-01 04:27:27', '2025-09-01 04:27:27'),
(569, 570, 20, '232410043', 0.00, 0, '2025-09-01 04:27:27', '2025-09-01 04:27:27'),
(570, 571, 20, '232410044', 0.00, 0, '2025-09-01 04:27:27', '2025-09-01 04:27:27'),
(571, 572, 20, '232410045', 0.00, 0, '2025-09-01 04:27:28', '2025-09-01 04:27:28'),
(572, 573, 20, '232410046', 0.00, 0, '2025-09-01 04:27:28', '2025-09-01 04:27:28'),
(573, 574, 20, '232410047', 0.00, 0, '2025-09-01 04:27:28', '2025-09-01 04:27:28'),
(574, 575, 20, '232410048', 0.00, 0, '2025-09-01 04:27:28', '2025-09-01 04:27:28'),
(575, 576, 20, '232410049', 0.00, 0, '2025-09-01 04:27:29', '2025-09-01 04:27:29'),
(576, 577, 20, '232410050', 0.00, 0, '2025-09-01 04:27:29', '2025-09-01 04:27:29'),
(577, 578, 20, '232410051', 0.00, 0, '2025-09-01 04:27:29', '2025-09-01 04:27:29'),
(578, 579, 21, '232410052', 315.00, 0, '2025-09-01 04:27:29', '2025-09-01 08:58:07'),
(579, 580, 21, '232410053', 235.00, 0, '2025-09-01 04:27:30', '2025-09-01 09:00:34'),
(580, 581, 21, '232410054', 175.00, 0, '2025-09-01 04:27:30', '2025-09-01 08:58:08'),
(581, 582, 21, '232410055', 665.00, 0, '2025-09-01 04:27:30', '2025-09-01 08:58:08'),
(582, 583, 21, '232410056', 125.00, 0, '2025-09-01 04:27:31', '2025-09-01 09:00:34'),
(583, 584, 21, '232410057', 910.00, 0, '2025-09-01 04:27:31', '2025-09-01 08:58:08'),
(584, 585, 21, '232410058', 70.00, 0, '2025-09-01 04:27:31', '2025-09-01 09:00:34'),
(585, 586, 21, '232410059', 735.00, 0, '2025-09-01 04:27:31', '2025-09-01 08:58:08'),
(586, 587, 21, '232410060', 130.00, 0, '2025-09-01 04:27:32', '2025-09-01 09:00:34'),
(587, 588, 21, '232410061', 0.00, 0, '2025-09-01 04:27:32', '2025-09-01 04:27:32'),
(588, 589, 21, '232410062', 0.00, 0, '2025-09-01 04:27:32', '2025-09-01 04:27:32'),
(589, 590, 21, '232410063', 490.00, 0, '2025-09-01 04:27:32', '2025-09-01 08:58:08'),
(590, 591, 21, '232410064', 0.00, 0, '2025-09-01 04:27:33', '2025-09-01 04:27:33'),
(591, 592, 21, '232410065', 145.00, 0, '2025-09-01 04:27:33', '2025-09-01 09:00:34'),
(592, 593, 21, '232410066', 525.00, 0, '2025-09-01 04:27:33', '2025-09-01 08:58:08'),
(593, 594, 21, '232410067', 175.00, 0, '2025-09-01 04:27:33', '2025-09-01 08:58:08'),
(594, 595, 21, '232410068', 350.00, 0, '2025-09-01 04:27:34', '2025-09-01 08:58:08'),
(595, 596, 21, '232410069', 145.00, 0, '2025-09-01 04:27:34', '2025-09-01 09:00:34'),
(596, 597, 21, '232410070', 350.00, 0, '2025-09-01 04:27:34', '2025-09-01 08:58:08'),
(597, 598, 21, '232410071', 700.00, 0, '2025-09-01 04:27:34', '2025-09-01 08:58:08'),
(598, 599, 21, '232410072', 95.00, 0, '2025-09-01 04:27:35', '2025-09-01 09:00:34'),
(599, 600, 21, '232410073', 665.00, 0, '2025-09-01 04:27:35', '2025-09-01 08:58:08'),
(600, 601, 21, '232410074', 210.00, 0, '2025-09-01 04:27:35', '2025-09-01 09:00:34'),
(601, 602, 21, '232410075', 385.00, 0, '2025-09-01 04:27:36', '2025-09-01 08:58:08'),
(602, 603, 21, '232410076', 315.00, 0, '2025-09-01 04:27:36', '2025-09-01 08:58:08'),
(603, 604, 21, '232410077', 350.00, 0, '2025-09-01 04:27:36', '2025-09-01 08:58:08'),
(604, 605, 21, '232410078', 185.00, 0, '2025-09-01 04:27:36', '2025-09-01 09:00:34'),
(605, 606, 21, '232410079', 350.00, 0, '2025-09-01 04:27:37', '2025-09-01 08:58:08'),
(606, 607, 21, '232410080', 320.00, 0, '2025-09-01 04:27:37', '2025-09-01 09:00:34'),
(607, 608, 21, '232410081', 345.00, 0, '2025-09-01 04:27:37', '2025-09-01 09:00:34'),
(608, 609, 21, '232410082', 420.00, 0, '2025-09-01 04:27:37', '2025-09-01 08:58:08'),
(609, 610, 21, '232410083', 195.00, 0, '2025-09-01 04:27:38', '2025-09-01 09:00:34'),
(610, 611, 21, '232410084', 700.00, 0, '2025-09-01 04:27:38', '2025-09-01 08:58:08'),
(611, 612, 22, '232410085', 350.00, 0, '2025-09-01 04:27:38', '2025-09-01 09:07:03'),
(612, 613, 22, '232410086', 60.00, 0, '2025-09-01 04:27:38', '2025-09-01 09:08:03'),
(613, 614, 22, '232410087', 0.00, 0, '2025-09-01 04:27:39', '2025-09-01 04:27:39');
INSERT INTO `siswa` (`id`, `id_pengguna`, `id_kelas`, `nis`, `saldo`, `points`, `created_at`, `updated_at`) VALUES
(614, 615, 22, '232410088', 175.00, 0, '2025-09-01 04:27:39', '2025-09-01 09:07:03'),
(615, 616, 22, '232410089', 350.00, 0, '2025-09-01 04:27:39', '2025-09-01 09:07:03'),
(616, 617, 22, '232410090', 0.00, 0, '2025-09-01 04:27:39', '2025-09-01 04:27:39'),
(617, 618, 22, '232410091', 0.00, 0, '2025-09-01 04:27:40', '2025-09-01 04:27:40'),
(618, 619, 22, '232410092', 0.00, 0, '2025-09-01 04:27:40', '2025-09-01 04:27:40'),
(619, 620, 22, '232410093', 120.00, 0, '2025-09-01 04:27:40', '2025-09-01 09:08:03'),
(620, 621, 22, '232410094', 0.00, 0, '2025-09-01 04:27:41', '2025-09-01 04:27:41'),
(621, 622, 22, '232410095', 255.00, 0, '2025-09-01 04:27:41', '2025-09-01 09:08:03'),
(622, 623, 22, '232410096', 350.00, 0, '2025-09-01 04:27:41', '2025-09-01 09:07:03'),
(623, 624, 22, '232410097', 0.00, 0, '2025-09-01 04:27:41', '2025-09-01 04:27:41'),
(624, 625, 22, '232410098', 0.00, 0, '2025-09-01 04:27:42', '2025-09-01 04:27:42'),
(625, 626, 22, '232410099', 175.00, 0, '2025-09-01 04:27:42', '2025-09-01 09:07:03'),
(626, 627, 22, '232410100', 0.00, 0, '2025-09-01 04:27:42', '2025-09-01 04:27:42'),
(627, 628, 22, '232410101', 175.00, 0, '2025-09-01 04:27:42', '2025-09-01 09:07:03'),
(628, 629, 22, '232410102', 0.00, 0, '2025-09-01 04:27:43', '2025-09-01 04:27:43'),
(629, 630, 22, '232410103', 0.00, 0, '2025-09-01 04:27:43', '2025-09-01 04:27:43'),
(630, 631, 22, '232410104', 150.00, 0, '2025-09-01 04:27:43', '2025-09-01 09:08:03'),
(631, 632, 22, '232410105', 210.00, 0, '2025-09-01 04:27:43', '2025-09-01 09:07:03'),
(632, 633, 22, '232410106', 100.00, 0, '2025-09-01 04:27:44', '2025-09-01 09:08:03'),
(633, 634, 22, '232410107', 0.00, 0, '2025-09-01 04:27:44', '2025-09-01 04:27:44'),
(634, 635, 22, '232410108', 70.00, 0, '2025-09-01 04:27:44', '2025-09-01 09:08:03'),
(635, 636, 22, '232410109', 175.00, 0, '2025-09-01 04:27:45', '2025-09-01 09:07:03'),
(636, 637, 22, '232410110', 175.00, 0, '2025-09-01 04:27:45', '2025-09-01 09:07:03'),
(637, 638, 22, '232410111', 170.00, 0, '2025-09-01 04:27:45', '2025-09-01 09:08:03'),
(638, 639, 22, '232410112', 0.00, 0, '2025-09-01 04:27:45', '2025-09-01 04:27:45'),
(639, 640, 22, '232410113', 0.00, 0, '2025-09-01 04:27:46', '2025-09-01 04:27:46'),
(640, 641, 22, '232410114', 350.00, 0, '2025-09-01 04:27:46', '2025-09-01 09:07:03'),
(641, 642, 22, '232410115', 0.00, 0, '2025-09-01 04:27:46', '2025-09-01 04:27:46'),
(642, 643, 22, '232410116', 0.00, 0, '2025-09-01 04:27:46', '2025-09-01 04:27:46'),
(643, 644, 22, '232410117', 225.00, 0, '2025-09-01 04:27:47', '2025-09-01 09:08:03'),
(644, 645, 22, '232410118', 150.00, 0, '2025-09-01 04:27:47', '2025-09-01 09:08:03'),
(645, 646, 23, '232410119', 0.00, 0, '2025-09-01 04:27:47', '2025-09-01 04:27:47'),
(646, 647, 23, '232410120', 0.00, 0, '2025-09-01 04:27:47', '2025-09-01 04:27:47'),
(647, 648, 23, '232410121', 0.00, 0, '2025-09-01 04:27:48', '2025-09-01 04:27:48'),
(648, 649, 23, '232410122', 0.00, 0, '2025-09-01 04:27:48', '2025-09-01 04:27:48'),
(649, 650, 23, '232410123', 0.00, 0, '2025-09-01 04:27:48', '2025-09-01 04:27:48'),
(650, 651, 23, '232410124', 0.00, 0, '2025-09-01 04:27:48', '2025-09-01 04:27:48'),
(651, 652, 23, '232410125', 0.00, 0, '2025-09-01 04:27:49', '2025-09-01 04:27:49'),
(652, 653, 23, '232410126', 0.00, 0, '2025-09-01 04:27:49', '2025-09-01 04:27:49'),
(653, 654, 23, '232410127', 0.00, 0, '2025-09-01 04:27:49', '2025-09-01 04:27:49'),
(654, 655, 23, '232410128', 0.00, 0, '2025-09-01 04:27:50', '2025-09-01 04:27:50'),
(655, 656, 23, '232410129', 0.00, 0, '2025-09-01 04:27:50', '2025-09-01 04:27:50'),
(656, 657, 23, '232410130', 0.00, 0, '2025-09-01 04:27:50', '2025-09-01 04:27:50'),
(657, 658, 23, '232410131', 0.00, 0, '2025-09-01 04:27:50', '2025-09-01 04:27:50'),
(658, 659, 23, '232410132', 0.00, 0, '2025-09-01 04:27:51', '2025-09-01 04:27:51'),
(659, 660, 23, '232410133', 0.00, 0, '2025-09-01 04:27:51', '2025-09-01 04:27:51'),
(660, 661, 23, '232410134', 0.00, 0, '2025-09-01 04:27:51', '2025-09-01 04:27:51'),
(661, 662, 23, '232410135', 0.00, 0, '2025-09-01 04:27:51', '2025-09-01 04:27:51'),
(662, 663, 23, '232410136', 0.00, 0, '2025-09-01 04:27:52', '2025-09-01 04:27:52'),
(663, 664, 23, '232410137', 0.00, 0, '2025-09-01 04:27:52', '2025-09-01 04:27:52'),
(664, 665, 23, '232410138', 0.00, 0, '2025-09-01 04:27:52', '2025-09-01 04:27:52'),
(665, 666, 23, '232410139', 0.00, 0, '2025-09-01 04:27:52', '2025-09-01 04:27:52'),
(666, 667, 23, '232410140', 0.00, 0, '2025-09-01 04:27:53', '2025-09-01 04:27:53'),
(667, 668, 23, '232410141', 0.00, 0, '2025-09-01 04:27:53', '2025-09-01 04:27:53'),
(668, 669, 23, '232410142', 0.00, 0, '2025-09-01 04:27:53', '2025-09-01 04:27:53'),
(669, 670, 23, '232410143', 0.00, 0, '2025-09-01 04:27:53', '2025-09-01 04:27:53'),
(670, 671, 23, '232410144', 0.00, 0, '2025-09-01 04:27:54', '2025-09-01 04:27:54'),
(671, 672, 23, '232410145', 0.00, 0, '2025-09-01 04:27:54', '2025-09-01 04:27:54'),
(672, 673, 23, '232410146', 0.00, 0, '2025-09-01 04:27:54', '2025-09-01 04:27:54'),
(673, 674, 23, '232410147', 0.00, 0, '2025-09-01 04:27:55', '2025-09-01 04:27:55'),
(674, 675, 23, '232410148', 0.00, 0, '2025-09-01 04:27:55', '2025-09-01 04:27:55'),
(675, 676, 23, '232410149', 0.00, 0, '2025-09-01 04:27:55', '2025-09-01 04:27:55'),
(676, 677, 23, '232410150', 0.00, 0, '2025-09-01 04:27:55', '2025-09-01 04:27:55'),
(677, 678, 23, '232410151', 0.00, 0, '2025-09-01 04:27:56', '2025-09-01 04:27:56'),
(678, 679, 23, '232410152', 0.00, 0, '2025-09-01 04:27:56', '2025-09-01 04:27:56'),
(679, 680, 23, '232410153', 0.00, 0, '2025-09-01 04:27:56', '2025-09-01 04:27:56'),
(680, 681, 24, '232410154', 350.00, 0, '2025-09-01 04:27:57', '2025-09-01 06:11:20'),
(681, 682, 24, '232410155', 0.00, 0, '2025-09-01 04:27:57', '2025-09-01 04:27:57'),
(682, 683, 24, '232410156', 0.00, 0, '2025-09-01 04:27:57', '2025-09-01 04:27:57'),
(683, 684, 24, '232410157', 385.00, 0, '2025-09-01 04:27:57', '2025-09-01 06:11:20'),
(684, 685, 24, '232410158', 225.00, 0, '2025-09-01 04:27:58', '2025-09-01 06:12:28'),
(685, 686, 24, '232410159', 350.00, 0, '2025-09-01 04:27:58', '2025-09-01 06:11:20'),
(686, 687, 24, '232410160', 245.00, 0, '2025-09-01 04:27:58', '2025-09-01 06:11:20'),
(687, 688, 24, '232410161', 245.00, 0, '2025-09-01 04:27:58', '2025-09-01 06:11:20'),
(688, 689, 24, '232410162', 0.00, 0, '2025-09-01 04:27:59', '2025-09-01 04:27:59'),
(689, 690, 24, '232410163', 350.00, 0, '2025-09-01 04:27:59', '2025-09-01 06:11:20'),
(690, 691, 24, '232410164', 175.00, 0, '2025-09-01 04:27:59', '2025-09-01 06:12:28'),
(691, 692, 24, '232410165', 350.00, 0, '2025-09-01 04:28:00', '2025-09-01 06:11:20'),
(692, 693, 24, '232410166', 0.00, 0, '2025-09-01 04:28:00', '2025-09-01 04:28:00'),
(693, 694, 24, '232410167', 350.00, 0, '2025-09-01 04:28:00', '2025-09-01 06:11:20'),
(694, 695, 24, '232410168', 310.00, 0, '2025-09-01 04:28:00', '2025-09-01 06:12:28'),
(695, 696, 24, '232410169', 100.00, 0, '2025-09-01 04:28:01', '2025-09-01 06:12:28'),
(696, 697, 24, '232410170', 0.00, 0, '2025-09-01 04:28:01', '2025-09-01 04:28:01'),
(697, 698, 24, '232410171', 350.00, 0, '2025-09-01 04:28:01', '2025-09-01 06:11:20'),
(698, 699, 24, '232410172', 400.00, 0, '2025-09-01 04:28:01', '2025-09-01 06:12:28'),
(699, 700, 24, '232410173', 350.00, 0, '2025-09-01 04:28:02', '2025-09-01 06:11:20'),
(700, 701, 24, '232410174', 350.00, 0, '2025-09-01 04:28:02', '2025-09-01 06:11:20'),
(701, 702, 24, '232410175', 0.00, 0, '2025-09-01 04:28:02', '2025-09-01 04:28:02'),
(702, 703, 24, '232410176', 350.00, 0, '2025-09-01 04:28:03', '2025-09-01 06:11:20'),
(703, 704, 24, '232410177', 385.00, 0, '2025-09-01 04:28:03', '2025-09-01 06:11:20'),
(704, 705, 24, '232410178', 350.00, 0, '2025-09-01 04:28:03', '2025-09-01 06:11:20'),
(705, 706, 24, '232410179', 0.00, 0, '2025-09-01 04:28:03', '2025-09-01 04:28:03'),
(706, 707, 24, '232410180', 350.00, 0, '2025-09-01 04:28:04', '2025-09-01 06:11:20'),
(707, 708, 24, '232410181', 350.00, 0, '2025-09-01 04:28:04', '2025-09-01 06:11:20'),
(708, 709, 24, '232410182', 350.00, 0, '2025-09-01 04:28:04', '2025-09-01 06:11:20'),
(709, 710, 24, '232410183', 175.00, 0, '2025-09-01 04:28:04', '2025-09-01 06:11:20'),
(710, 711, 24, '232410184', 350.00, 0, '2025-09-01 04:28:05', '2025-09-01 06:11:20'),
(711, 712, 24, '232410185', 100.00, 0, '2025-09-01 04:28:05', '2025-09-01 06:12:28'),
(712, 713, 24, '232410186', 525.00, 0, '2025-09-01 04:28:05', '2025-09-01 06:11:20'),
(713, 714, 24, '232410187', 275.00, 0, '2025-09-01 04:28:05', '2025-09-01 06:12:28'),
(714, 715, 25, '232410188', 350.00, 0, '2025-09-01 04:28:06', '2025-09-01 07:36:38'),
(715, 716, 25, '232410189', 350.00, 0, '2025-09-01 04:28:06', '2025-09-01 07:36:38'),
(716, 717, 25, '232410190', 385.00, 0, '2025-09-01 04:28:06', '2025-09-01 07:36:38'),
(717, 718, 25, '232410191', 350.00, 0, '2025-09-01 04:28:06', '2025-09-01 07:36:38'),
(718, 719, 25, '232410192', 280.00, 0, '2025-09-01 04:28:07', '2025-09-01 07:36:38'),
(719, 720, 25, '232410193', 140.00, 0, '2025-09-01 04:28:07', '2025-09-01 07:36:38'),
(720, 721, 25, '232410194', 490.00, 0, '2025-09-01 04:28:07', '2025-09-01 07:36:38'),
(721, 722, 25, '232410195', 0.00, 0, '2025-09-01 04:28:07', '2025-09-01 04:28:07'),
(722, 723, 25, '232410196', 0.00, 0, '2025-09-01 04:28:08', '2025-09-01 04:28:08'),
(723, 724, 25, '232410197', 0.00, 0, '2025-09-01 04:28:08', '2025-09-01 04:28:08'),
(724, 725, 25, '232410198', 180.00, 0, '2025-09-01 04:28:08', '2025-09-01 07:37:48'),
(725, 726, 25, '232410199', 200.00, 0, '2025-09-01 04:28:09', '2025-09-01 07:37:48'),
(726, 727, 25, '232410200', 0.00, 0, '2025-09-01 04:28:15', '2025-09-01 04:28:15'),
(727, 728, 25, '232410201', 0.00, 0, '2025-09-01 04:28:15', '2025-09-01 04:28:15'),
(728, 729, 25, '232410202', 200.00, 0, '2025-09-01 04:28:16', '2025-09-01 07:37:48'),
(729, 730, 25, '232410203', 350.00, 0, '2025-09-01 04:28:16', '2025-09-01 07:36:38'),
(730, 731, 25, '232410204', 140.00, 0, '2025-09-01 04:28:16', '2025-09-01 07:36:38'),
(731, 732, 25, '232410205', 175.00, 0, '2025-09-01 04:28:16', '2025-09-01 07:36:38'),
(732, 733, 25, '232410206', 0.00, 0, '2025-09-01 04:28:17', '2025-09-01 04:28:17'),
(733, 734, 25, '232410207', 285.00, 0, '2025-09-01 04:28:17', '2025-09-01 07:37:48'),
(734, 735, 25, '232410208', 280.00, 0, '2025-09-01 04:28:17', '2025-09-01 07:36:38'),
(735, 736, 25, '232410209', 245.00, 0, '2025-09-01 04:28:18', '2025-09-01 07:36:38'),
(736, 737, 25, '232410210', 245.00, 0, '2025-09-01 04:28:18', '2025-09-01 07:36:38'),
(737, 738, 25, '232410211', 120.00, 0, '2025-09-01 04:28:18', '2025-09-01 07:37:48'),
(738, 739, 25, '232410212', 350.00, 0, '2025-09-01 04:28:18', '2025-09-01 07:36:38'),
(739, 740, 25, '232410213', 0.00, 0, '2025-09-01 04:28:19', '2025-09-01 04:28:19'),
(740, 741, 25, '232410214', 350.00, 0, '2025-09-01 04:28:19', '2025-09-01 07:36:38'),
(741, 742, 25, '232410215', 220.00, 0, '2025-09-01 04:28:19', '2025-09-01 07:37:48'),
(742, 743, 25, '232410216', 0.00, 0, '2025-09-01 04:28:19', '2025-09-01 04:28:19'),
(743, 744, 25, '232410217', 100.00, 0, '2025-09-01 04:28:20', '2025-09-01 07:37:48'),
(744, 745, 25, '232410218', 225.00, 0, '2025-09-01 04:28:20', '2025-09-01 07:37:48'),
(745, 746, 25, '232410219', 0.00, 0, '2025-09-01 04:28:20', '2025-09-01 04:28:20'),
(746, 747, 26, '232410220', 125.00, 0, '2025-09-01 04:28:20', '2025-09-01 07:41:28'),
(747, 748, 26, '232410221', 250.00, 0, '2025-09-01 04:28:21', '2025-09-01 07:41:28'),
(748, 749, 26, '232410222', 370.00, 0, '2025-09-01 04:28:21', '2025-09-01 07:41:28'),
(749, 750, 26, '232410223', 350.00, 0, '2025-09-01 04:28:21', '2025-09-01 07:40:06'),
(750, 751, 26, '232410224', 150.00, 0, '2025-09-01 04:28:22', '2025-09-01 07:41:28'),
(751, 752, 26, '232410225', 0.00, 0, '2025-09-01 04:28:22', '2025-09-01 04:28:22'),
(752, 753, 26, '232410226', 350.00, 0, '2025-09-01 04:28:22', '2025-09-01 07:40:06'),
(753, 754, 26, '232410227', 0.00, 0, '2025-09-01 04:28:22', '2025-09-01 04:28:22'),
(754, 755, 26, '232410228', 100.00, 0, '2025-09-01 04:28:23', '2025-09-01 07:41:28'),
(755, 756, 26, '232410229', 260.00, 0, '2025-09-01 04:28:23', '2025-09-01 07:41:28'),
(756, 757, 26, '232410230', 325.00, 0, '2025-09-01 04:28:23', '2025-09-01 07:41:28'),
(757, 758, 26, '232410231', 100.00, 0, '2025-09-01 04:28:23', '2025-09-01 07:41:28'),
(758, 759, 26, '232410232', 0.00, 0, '2025-09-01 04:28:24', '2025-09-01 04:28:24'),
(759, 760, 26, '232410233', 0.00, 0, '2025-09-01 04:28:24', '2025-09-01 04:28:24'),
(760, 761, 26, '232410234', 0.00, 0, '2025-09-01 04:28:24', '2025-09-01 04:28:24'),
(761, 762, 26, '232410235', 100.00, 0, '2025-09-01 04:28:24', '2025-09-01 07:41:28'),
(762, 763, 26, '232410236', 100.00, 0, '2025-09-01 04:28:25', '2025-09-01 07:41:28'),
(763, 764, 26, '232410237', 275.00, 0, '2025-09-01 04:28:25', '2025-09-01 07:41:28'),
(764, 765, 26, '232410238', 250.00, 0, '2025-09-01 04:28:25', '2025-09-01 07:41:28'),
(765, 766, 26, '232410239', 135.00, 0, '2025-09-01 04:28:25', '2025-09-01 07:41:28'),
(766, 767, 26, '232410240', 455.00, 0, '2025-09-01 04:28:26', '2025-09-01 07:40:06'),
(767, 768, 26, '232410241', 0.00, 0, '2025-09-01 04:28:26', '2025-09-01 04:28:26'),
(768, 769, 26, '232410242', 250.00, 0, '2025-09-01 04:28:26', '2025-09-01 07:41:28'),
(769, 770, 26, '232410243', 335.00, 0, '2025-09-01 04:28:27', '2025-09-01 07:41:28'),
(770, 771, 26, '232410244', 350.00, 0, '2025-09-01 04:28:27', '2025-09-01 07:40:06'),
(771, 772, 26, '232410245', 350.00, 0, '2025-09-01 04:28:27', '2025-09-01 07:40:06'),
(772, 773, 26, '232410246', 155.00, 0, '2025-09-01 04:28:27', '2025-09-01 07:41:28'),
(773, 774, 26, '232410247', 0.00, 0, '2025-09-01 04:28:28', '2025-09-01 04:28:28'),
(774, 775, 26, '232410248', 100.00, 0, '2025-09-01 04:28:28', '2025-09-01 07:41:28'),
(775, 776, 26, '232410249', 225.00, 0, '2025-09-01 04:28:28', '2025-09-01 07:41:28'),
(776, 777, 26, '232410250', 450.00, 0, '2025-09-01 04:28:28', '2025-09-01 07:41:28'),
(777, 778, 26, '232410251', 0.00, 0, '2025-09-01 04:28:29', '2025-09-01 04:28:29'),
(778, 779, 26, '232410252', 315.00, 0, '2025-09-01 04:28:29', '2025-09-01 07:40:06'),
(779, 780, 27, '232410253', 0.00, 0, '2025-09-01 04:28:29', '2025-09-01 04:28:29'),
(780, 781, 27, '232410254', 0.00, 0, '2025-09-01 04:28:29', '2025-09-01 04:28:29'),
(781, 782, 27, '232410255', 0.00, 0, '2025-09-01 04:28:30', '2025-09-01 04:28:30'),
(782, 783, 27, '232410256', 0.00, 0, '2025-09-01 04:28:30', '2025-09-01 04:28:30'),
(783, 784, 27, '232410257', 0.00, 0, '2025-09-01 04:28:30', '2025-09-01 04:28:30'),
(784, 785, 27, '232410258', 0.00, 0, '2025-09-01 04:28:31', '2025-09-01 04:28:31'),
(785, 786, 27, '232410259', 0.00, 0, '2025-09-01 04:28:31', '2025-09-01 04:28:31'),
(786, 787, 27, '232410260', 0.00, 0, '2025-09-01 04:28:31', '2025-09-01 04:28:31'),
(787, 788, 27, '232410261', 0.00, 0, '2025-09-01 04:28:31', '2025-09-01 04:28:31'),
(788, 789, 27, '232410262', 0.00, 0, '2025-09-01 04:28:32', '2025-09-01 04:28:32'),
(789, 790, 27, '232410263', 0.00, 0, '2025-09-01 04:28:32', '2025-09-01 04:28:32'),
(790, 791, 27, '232410264', 0.00, 0, '2025-09-01 04:28:32', '2025-09-01 04:28:32'),
(791, 792, 27, '232410265', 0.00, 0, '2025-09-01 04:28:32', '2025-09-01 04:28:32'),
(792, 793, 27, '232410266', 0.00, 0, '2025-09-01 04:28:33', '2025-09-01 04:28:33'),
(793, 794, 27, '232410267', 0.00, 0, '2025-09-01 04:28:33', '2025-09-01 04:28:33'),
(794, 795, 27, '232410268', 0.00, 0, '2025-09-01 04:28:33', '2025-09-01 04:28:33'),
(795, 796, 27, '232410269', 0.00, 0, '2025-09-01 04:28:33', '2025-09-01 04:28:33'),
(796, 797, 27, '232410270', 0.00, 0, '2025-09-01 04:28:34', '2025-09-01 04:28:34'),
(797, 798, 27, '232410271', 0.00, 0, '2025-09-01 04:28:34', '2025-09-01 04:28:34'),
(798, 799, 27, '232410272', 0.00, 0, '2025-09-01 04:28:34', '2025-09-01 04:28:34'),
(799, 800, 27, '232410273', 0.00, 0, '2025-09-01 04:28:35', '2025-09-01 04:28:35'),
(800, 801, 27, '232410274', 0.00, 0, '2025-09-01 04:28:35', '2025-09-01 04:28:35'),
(801, 802, 27, '232410275', 0.00, 0, '2025-09-01 04:28:35', '2025-09-01 04:28:35'),
(802, 803, 27, '232410276', 0.00, 0, '2025-09-01 04:28:35', '2025-09-01 04:28:35'),
(803, 804, 27, '232410277', 0.00, 0, '2025-09-01 04:28:36', '2025-09-01 04:28:36'),
(804, 805, 27, '232410278', 0.00, 0, '2025-09-01 04:28:36', '2025-09-01 04:28:36'),
(805, 829, 1, '1', 0.00, 0, '2025-09-01 13:52:00', '2025-09-01 13:52:00'),
(806, 828, 1, '2', 0.00, 0, '2025-09-01 13:52:01', '2025-09-01 13:52:01'),
(807, 817, 1, '3', 0.00, 0, '2025-09-01 13:52:01', '2025-09-01 13:52:01'),
(808, 833, 1, '4', 0.00, 0, '2025-09-01 13:52:01', '2025-09-01 13:52:01'),
(809, 811, 1, '5', 0.00, 0, '2025-09-01 13:52:02', '2025-09-01 13:52:02'),
(810, 834, 1, '6', 0.00, 0, '2025-09-01 13:52:02', '2025-09-01 13:52:02'),
(811, 810, 1, '7', 0.00, 0, '2025-09-01 13:52:02', '2025-09-01 13:52:02'),
(812, 822, 1, '8', 0.00, 0, '2025-09-01 13:52:03', '2025-09-01 13:52:03'),
(813, 824, 1, '9', 0.00, 0, '2025-09-01 13:52:03', '2025-09-01 13:52:03'),
(814, 835, 1, '10', 0.00, 0, '2025-09-01 13:52:03', '2025-09-01 13:52:03'),
(815, 836, 1, '11', 0.00, 0, '2025-09-01 13:52:04', '2025-09-01 13:52:04'),
(816, 837, 1, '12', 0.00, 0, '2025-09-01 13:52:04', '2025-09-01 13:52:04'),
(817, 823, 1, '13', 1218.00, 1, '2025-09-01 13:52:05', '2025-09-01 14:02:35'),
(818, 820, 1, '14', 369.00, 0, '2025-09-01 13:52:05', '2025-09-01 14:02:35'),
(819, 838, 1, '15', 0.00, 0, '2025-09-01 13:52:05', '2025-09-01 13:52:05'),
(820, 806, 1, '16', 0.00, 0, '2025-09-01 13:52:06', '2025-09-01 13:52:06'),
(821, 839, 1, '17', 0.00, 0, '2025-09-01 13:52:06', '2025-09-01 13:52:06'),
(822, 840, 1, '18', 4554.00, 4, '2025-09-01 13:52:06', '2025-09-01 14:02:35'),
(823, 809, 1, '19', 0.00, 0, '2025-09-01 13:52:07', '2025-09-01 13:52:07'),
(824, 816, 1, '20', 0.00, 0, '2025-09-01 13:52:07', '2025-09-01 13:52:07'),
(825, 821, 1, '21', 0.00, 0, '2025-09-01 13:52:07', '2025-09-01 13:52:07'),
(826, 830, 1, '22', 0.00, 0, '2025-09-01 13:52:08', '2025-09-01 13:52:08'),
(827, 827, 1, '23', 0.00, 0, '2025-09-01 13:52:08', '2025-09-01 13:52:08'),
(828, 819, 1, '24', 0.00, 0, '2025-09-01 13:52:09', '2025-09-01 13:52:09'),
(829, 814, 1, '25', 0.00, 0, '2025-09-01 13:52:09', '2025-09-01 13:52:09'),
(830, 813, 1, '26', 0.00, 0, '2025-09-01 13:52:09', '2025-09-01 13:52:09'),
(831, 841, 1, '27', 0.00, 0, '2025-09-01 13:52:10', '2025-09-01 13:52:10'),
(832, 808, 1, '28', 0.00, 0, '2025-09-01 13:52:10', '2025-09-01 13:52:10'),
(833, 812, 1, '29', 0.00, 0, '2025-09-01 13:52:10', '2025-09-01 13:52:10'),
(834, 825, 1, '30', 0.00, 0, '2025-09-01 13:52:11', '2025-09-01 13:52:11'),
(835, 842, 1, '31', 0.00, 0, '2025-09-01 13:52:11', '2025-09-01 13:52:11'),
(836, 815, 1, '32', 0.00, 0, '2025-09-01 13:52:12', '2025-09-01 13:52:12'),
(837, 818, 1, '33', 0.00, 0, '2025-09-01 13:52:12', '2025-09-01 13:52:12'),
(838, 807, 1, '34', 0.00, 0, '2025-09-01 13:52:12', '2025-09-01 13:52:12'),
(839, 831, 1, '35', 0.00, 0, '2025-09-01 13:52:13', '2025-09-01 13:52:13'),
(840, 826, 1, '36', 0.00, 0, '2025-09-01 13:52:13', '2025-09-01 13:52:13');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT for table `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=843;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=841;

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
