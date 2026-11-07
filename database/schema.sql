-- Database: portfolio.db (SQLite)  |  POLIJE Student Portofolio
-- Dibuat otomatis oleh aplikasi (lib/db_helper.dart) saat pertama dijalankan.
-- File ini untuk dokumentasi / dibuka manual di DB Browser for SQLite.

DROP TABLE IF EXISTS projects;

CREATE TABLE projects(
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  title       TEXT NOT NULL,
  year        TEXT NOT NULL,
  tech        TEXT NOT NULL,
  category    TEXT NOT NULL,
  description TEXT NOT NULL,
  image       TEXT NOT NULL DEFAULT ''
);

-- Data awal (5 karya). Urutan id terbalik agar tampil sama dengan aplikasi (id terbesar = paling atas).
INSERT INTO projects(title,year,tech,category,description,image) VALUES
('Requirement Aplikasi Mitra','2026','Analisis Kebutuhan, Dokumentasi, Flutter','Flutter','Merancang requirement aplikasi berbasis Flutter untuk mitra selanjutnya.',''),
('Aplikasi Struk Digital','2026','Flutter, Dart, SQLite','Flutter','Aplikasi pencatatan transaksi dengan fitur simpan struk yang otomatis menyimpan ke galeri.',''),
('Design UI/UX Mobile','2026','Figma, UI/UX Design, Wireframing','UI/UX','Rancangan antarmuka aplikasi UMKM modern yang fokus pada kustomisasi dashboard dan kemudahan pemesanan digital.','img/uiux.png'),
('Membuat aplikasi UMKM toko pertanian Mbah Meth','2026','Laravel, PHP, MySQL, Bootstrap','Laravel','Aplikasi untuk memantau ketersediaan dan order sebuah produk yang ada pada UMKM toko pertanian Mbah Meth.','img/mbahmeth.png'),
('Membuat Website UMKM Djawara Dawet','2025','Flutter, Dart, Firebase, REST API','Flutter','Website untuk pengguna memantau produk dan harga dari sebuah produk.','img/djawara.png');

-- ===== Contoh query CRUD (sama dengan yang dijalankan aplikasi) =====
-- READ   : SELECT * FROM projects ORDER BY id DESC;
-- FILTER : SELECT * FROM projects WHERE category = 'Flutter' ORDER BY id DESC;
-- CREATE : INSERT INTO projects(title,year,tech,category,description,image)
--          VALUES('Judul','2026','Flutter','Flutter','Deskripsi minimal 10 karakter','');
-- UPDATE : UPDATE projects SET title='Judul Baru' WHERE id = 1;
-- DELETE : DELETE FROM projects WHERE id = 1;
