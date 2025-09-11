<?php
$zip = new ZipArchive;
$file_path = __DIR__ . '/backup.zip';

echo "Mencoba membuka file di: " . $file_path . "<br>";

if ($zip->open($file_path) === TRUE) {
    echo "<h2>BERHASIL!</h2>";
    echo "File backup.zip berhasil dibuka.<br>";
    echo "Jumlah file di dalamnya: " . $zip->numFiles;
    $zip->close();
} else {
    echo "<h2>GAGAL!</h2>";
    echo "PHP tidak dapat membuka file backup.zip. Ini mengonfirmasi ada masalah dengan konfigurasi ekstensi ZIP di server Anda.";
}