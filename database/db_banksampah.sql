-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 23 Agu 2025 pada 19.10
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

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
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_sampah`
--

CREATE TABLE `jenis_sampah` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_sampah` varchar(50) NOT NULL,
  `harga_per_satuan` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jenis_sampah`
--

INSERT INTO `jenis_sampah` (`id`, `nama_sampah`, `harga_per_satuan`, `created_at`, `updated_at`) VALUES
(2, 'botol', 35.00, '2025-08-23 05:04:09', '2025-08-23 05:04:09');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kelas`
--

CREATE TABLE `kelas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kelas` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `kelas`
--

INSERT INTO `kelas` (`id`, `nama_kelas`, `created_at`, `updated_at`) VALUES
(2, 'x', '2025-08-23 04:44:49', '2025-08-23 04:44:49'),
(3, 'z', '2025-08-23 09:25:55', '2025-08-23 09:25:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_08_23_090825_create_kelas_table', 1),
(2, '2025_08_23_091448_create_sessions_table', 2),
(3, '2025_08_23_092449_create_jenis_sampah_table', 3),
(4, '2025_08_23_092451_create_pengguna_table', 3),
(5, '2025_08_23_092452_create_siswa_table', 3),
(6, '2025_08_23_092454_create_setoran_table', 3),
(7, '2025_08_23_092455_create_penarikan_table', 3),
(8, '2025_08_23_103533_create_personal_access_tokens_table', 4),
(9, '2025_08_23_114250_add_timestamps_to_kelas_table', 5),
(10, '2025_08_23_125708_create_cache_table', 6);

-- --------------------------------------------------------

--
-- Struktur dari tabel `penarikan`
--

CREATE TABLE `penarikan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_siswa` bigint(20) UNSIGNED NOT NULL,
  `jumlah_penarikan` decimal(10,2) NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `penarikan`
--

INSERT INTO `penarikan` (`id`, `id_siswa`, `jumlah_penarikan`, `id_admin`, `created_at`, `updated_at`) VALUES
(1, 2, 321.00, 1, '2025-08-23 05:14:28', '2025-08-23 05:14:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengguna`
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
-- Dumping data untuk tabel `pengguna`
--

INSERT INTO `pengguna` (`id`, `nama_lengkap`, `username`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'test', 'test', '$2y$12$qT0cPyJvYG2y3XAeDLPdHOquy6A8J/Sg2IVOPp6BSwEgO9XM4YKXW', 'admin', '2025-08-23 03:36:20', '2025-08-23 03:36:20'),
(3, 'w', 'w', '$2y$12$GZVANeaHnd1WjFlfvYx96uUf4oor./WE22w3FztHetJffKG8Lpmk6', 'siswa', '2025-08-23 05:03:47', '2025-08-23 05:03:47'),
(4, 'bambang', 'bambangbung', '$2y$12$i7R5eVQj7EkxxzaclRQTtuoXNKyGGOvVmpq2rld42Sk3Hg7mU2wZy', 'siswa', '2025-08-23 08:30:46', '2025-08-23 08:30:46'),
(5, 'a', 'a', '$2y$12$F5EjXAwyeUIVUs61VuFpxOxY8vh8hbmQ8DRAGOXZtjXeoA5gWyUZu', 'siswa', '2025-08-23 08:30:46', '2025-08-23 08:30:46'),
(6, 'j', 'r', '$2y$12$EBzwyYHNv8X/de1KIDH1webYWmJXpA7vSaC.yXsjSznLavPfmfhlO', 'siswa', '2025-08-23 09:02:26', '2025-08-23 09:02:26'),
(7, 'g', 'y', '$2y$12$KSPrGNWRNrPeKQL5fBr2yu5BEdScwCYnMXlasRtMiBF.Z6URM8q5C', 'siswa', '2025-08-23 09:02:26', '2025-08-23 09:02:26'),
(8, 'aa', 'cc', '$2y$12$E0ulseJEojxhachRT3mJm.bSmOQKAYEsdJs3AJYSVSjcbuYzBv.22', 'siswa', '2025-08-23 09:03:26', '2025-08-23 09:03:26'),
(9, 'hh', 'vv', '$2y$12$yWjoc4XtmSdHkdN3gO3JtO5nY49nd8blEhiWji9Z.2NQKUYFnc7kW', 'siswa', '2025-08-23 09:03:27', '2025-08-23 09:03:27'),
(10, 'rt', 'rw', '$2y$12$8togW36JcRWyI6nHoLIh.OPIBH/lOFDzL6ajtMNweqcVfGgE/yNni', 'siswa', '2025-08-23 09:26:46', '2025-08-23 09:26:46'),
(11, 'rw', 'rt', '$2y$12$YimjU60/5fZuC2HUo7hIr.boFQnmyw6H.CITCsJ5WKDrqlK43y7li', 'siswa', '2025-08-23 09:26:46', '2025-08-23 09:26:46'),
(12, 'q', 'q', '$2y$12$.VgQWvJsawdkRoMS2xYHjeIZ6I8XBAFyF4.MygofeLI3jH.6BAl.W', 'siswa', '2025-08-23 09:42:51', '2025-08-23 09:42:51');

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
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
-- Struktur dari tabel `sessions`
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
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('ZczeEgsLj2pEi9yvTXL7akJGvV8uaaPZxsReNyXf', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQk1kYU41aURvYVdXTVpRNmtVTVBiNzFqQ0FqakVFaEJoTG13enRDOSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wZW5hcmlrYW4vY3JlYXRlIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1755968941);

-- --------------------------------------------------------

--
-- Struktur dari tabel `setoran`
--

CREATE TABLE `setoran` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_siswa` bigint(20) UNSIGNED NOT NULL,
  `id_jenis_sampah` bigint(20) UNSIGNED NOT NULL,
  `jumlah_satuan` int(11) NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `setoran`
--

INSERT INTO `setoran` (`id`, `id_siswa`, `id_jenis_sampah`, `jumlah_satuan`, `total_harga`, `id_admin`, `created_at`, `updated_at`) VALUES
(1, 2, 2, 40, 1400.00, 1, '2025-08-23 05:04:21', '2025-08-23 05:04:21'),
(2, 2, 2, 222, 7770.00, 1, '2025-08-23 05:07:52', '2025-08-23 05:07:52'),
(3, 2, 2, 21, 735.00, 1, '2025-08-23 05:08:22', '2025-08-23 05:08:22'),
(4, 2, 2, 123, 4305.00, 1, '2025-08-23 05:08:42', '2025-08-23 05:08:42'),
(5, 3, 2, 123, 0.00, 1, '2025-08-23 08:45:38', '2025-08-23 08:45:38'),
(6, 4, 2, 321, 0.00, 1, '2025-08-23 08:45:38', '2025-08-23 08:45:38'),
(7, 3, 2, 123, 4305.00, 1, '2025-08-23 09:16:55', '2025-08-23 09:16:55'),
(8, 4, 2, 321, 11235.00, 1, '2025-08-23 09:16:55', '2025-08-23 09:16:55'),
(9, 5, 2, 4444, 155540.00, 1, '2025-08-23 09:16:55', '2025-08-23 09:16:55'),
(10, 6, 2, 123, 4305.00, 1, '2025-08-23 09:17:36', '2025-08-23 09:17:36'),
(11, 7, 2, 321, 11235.00, 1, '2025-08-23 09:17:36', '2025-08-23 09:17:36'),
(12, 8, 2, 1233, 43155.00, 1, '2025-08-23 09:17:36', '2025-08-23 09:17:36'),
(13, 9, 2, 321, 11235.00, 1, '2025-08-23 09:31:00', '2025-08-23 09:31:00'),
(14, 10, 2, 123, 4305.00, 1, '2025-08-23 09:31:00', '2025-08-23 09:31:00'),
(15, 9, 2, 555, 19425.00, 1, '2025-08-23 09:42:19', '2025-08-23 09:42:19'),
(16, 10, 2, 888, 31080.00, 1, '2025-08-23 09:42:19', '2025-08-23 09:42:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswa`
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
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `siswa` (`id`, `id_pengguna`, `id_kelas`, `nis`, `saldo`, `created_at`, `updated_at`) VALUES
(2, 3, 2, NULL, 13889.00, '2025-08-23 05:03:47', '2025-08-23 05:14:28'),
(3, 4, 2, '11358', 4305.00, '2025-08-23 08:30:46', '2025-08-23 09:16:55'),
(4, 5, 2, '11322', 11235.00, '2025-08-23 08:30:47', '2025-08-23 09:16:55'),
(5, 6, 2, '11245', 155540.00, '2025-08-23 09:02:26', '2025-08-23 09:16:55'),
(6, 7, 2, '112378', 4305.00, '2025-08-23 09:02:26', '2025-08-23 09:17:36'),
(7, 8, 2, '987425', 11235.00, '2025-08-23 09:03:26', '2025-08-23 09:17:36'),
(8, 9, 2, '35987', 43155.00, '2025-08-23 09:03:27', '2025-08-23 09:17:36'),
(9, 10, 3, '321654', 30660.00, '2025-08-23 09:26:46', '2025-08-23 09:42:19'),
(10, 11, 3, '321987', 35385.00, '2025-08-23 09:26:46', '2025-08-23 09:42:19'),
(11, 12, 3, '65489', 0.00, '2025-08-23 09:42:51', '2025-08-23 09:42:51');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `penarikan`
--
ALTER TABLE `penarikan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `penarikan_id_siswa_foreign` (`id_siswa`),
  ADD KEY `penarikan_id_admin_foreign` (`id_admin`);

--
-- Indeks untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pengguna_username_unique` (`username`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `setoran`
--
ALTER TABLE `setoran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `setoran_id_siswa_foreign` (`id_siswa`),
  ADD KEY `setoran_id_jenis_sampah_foreign` (`id_jenis_sampah`),
  ADD KEY `setoran_id_admin_foreign` (`id_admin`);

--
-- Indeks untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `siswa_nis_unique` (`nis`),
  ADD KEY `siswa_id_pengguna_foreign` (`id_pengguna`),
  ADD KEY `siswa_id_kelas_foreign` (`id_kelas`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `jenis_sampah`
--
ALTER TABLE `jenis_sampah`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `penarikan`
--
ALTER TABLE `penarikan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `setoran`
--
ALTER TABLE `setoran`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `penarikan`
--
ALTER TABLE `penarikan`
  ADD CONSTRAINT `penarikan_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`),
  ADD CONSTRAINT `penarikan_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `setoran`
--
ALTER TABLE `setoran`
  ADD CONSTRAINT `setoran_id_admin_foreign` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id`),
  ADD CONSTRAINT `setoran_id_jenis_sampah_foreign` FOREIGN KEY (`id_jenis_sampah`) REFERENCES `jenis_sampah` (`id`),
  ADD CONSTRAINT `setoran_id_siswa_foreign` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `siswa_id_kelas_foreign` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `siswa_id_pengguna_foreign` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
