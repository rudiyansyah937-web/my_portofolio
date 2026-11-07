# POLIJE Student Portofolio (v2)

Rudiyansyah Mahendra Nur Rohman (E41250942)
Workshop Mobile Applications Advance (330806) - PSDKU Teknik Informatika Nganjuk, Polije.

## Fitur
- Beranda, Profil Saya, Portofolio, Tambah Portofolio, Tentang POLIJE, Setelan
- CRUD portofolio (Create, Read, Update, Delete) dengan database SQLite (sqflite)
- Gradient, PageView + indikator, Dropdown filter kategori, Card, Dark Mode berfungsi

## Cara menjalankan
1. `flutter create .`  (sekali saja)
2. Taruh gambar di folder `img/`: fotoku.jpg, djawara.png, mbahmeth.png, uiux.png
3. `flutter pub get`
4. Khusus Chrome/Web (sekali saja): `dart run sqflite_common_ffi_web:setup`
5. `flutter run -d chrome`  atau pilih emulator/HP Android.

Android/iOS memakai sqflite bawaan. Web memakai sqflite_common_ffi_web
(data tersimpan di browser). Windows desktop belum didukung.
