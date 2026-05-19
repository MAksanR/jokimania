Aplikasi ini dibuat menggunakan Flutter sebagai tugas mata kuliah Kriptografi. Pada project ini, sistem login dan registrasi sudah menerapkan keamanan password menggunakan algoritma hash SHA-256 sehingga password tidak disimpan dalam bentuk asli.

Tujuan Project:
  Project ini dibuat untuk memahami bagaimana proses hashing password bekerja pada sistem autentikasi user.

Fitur yang Dibuat Registrasi user Login user Hash password menggunakan SHA-256 Penyimpanan username/email dan hash password ke Firebase Firestore Verifikasi password saat login Menampilkan status login berhasil atau gagal Login menggunakan Google Cara Kerja Sistem Saat Registrasi

Password yang dimasukkan user akan diubah terlebih dahulu menjadi hash SHA-256 sebelum disimpan ke database.

Alur:

Password Asli → SHA-256 → Disimpan ke Firestore

Contoh:

123456 ↓ 8d969eef6ecad3c29a3a629280e686cff8fab... Saat Login

User memasukkan password asli, kemudian sistem melakukan hash ulang terhadap password tersebut. Hasil hash kemudian dibandingkan dengan hash yang ada di database.

Alur:

Input Password → SHA-256 → Bandingkan dengan Database

Jika hash cocok:

Login Berhasil

Jika hash berbeda:

Password Salah Teknologi yang Digunakan Flutter Dart Firebase Authentication Cloud Firestore Crypto Package (SHA-256) Package Utama crypto: cloud_firestore: firebase_auth: google_sign_in: Contoh Fungsi Hash Password import 'dart:convert'; import 'package:crypto/crypto.dart';

class HashService { static String hashPassword(String password) { final bytes = utf8.encode(password); final digest = sha256.convert(bytes);

return digest.toString();
} } Hasil Implementasi

Password user berhasil diamankan menggunakan metode hashing SHA-256 sehingga data lebih aman dan tidak tersimpan dalam bentuk plaintext.

Author

Nama: Husain Project: Lokalin Flutter App Mata Kuliah: Kriptografi
