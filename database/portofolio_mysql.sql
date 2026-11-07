-- POLIJE Student Portofolio - versi MySQL / MariaDB (phpMyAdmin, XAMPP)
-- Struktur sama dengan portfolio.db (SQLite) yang dipakai aplikasi Flutter.

CREATE DATABASE IF NOT EXISTS db_portofolio
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE db_portofolio;

DROP TABLE IF EXISTS projects;

CREATE TABLE projects (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  title       VARCHAR(150) NOT NULL,
  year        CHAR(4)      NOT NULL,
  tech        VARCHAR(255) NOT NULL,
  category    VARCHAR(30)  NOT NULL,
  description TEXT         NOT NULL,
  image       VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY idx_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO projects (title, year, tech, category, description, image) VALUES
('Requirement Aplikasi Mitra','2026','Analisis Kebutuhan, Dokumentasi, Flutter','Flutter','Merancang requirement aplikasi berbasis Flutter untuk mitra selanjutnya.',''),
('Aplikasi Struk Digital','2026','Flutter, Dart, SQLite','Flutter','Aplikasi pencatatan transaksi dengan fitur simpan struk yang otomatis menyimpan ke galeri.',''),
('Design UI/UX Mobile','2026','Figma, UI/UX Design, Wireframing','UI/UX','Rancangan antarmuka aplikasi UMKM modern yang fokus pada kustomisasi dashboard dan kemudahan pemesanan digital.','img/uiux.png'),
('Membuat aplikasi UMKM toko pertanian Mbah Meth','2026','Laravel, PHP, MySQL, Bootstrap','Laravel','Aplikasi untuk memantau ketersediaan dan order sebuah produk yang ada pada UMKM toko pertanian Mbah Meth.','img/mbahmeth.png'),
('Membuat Website UMKM Djawara Dawet','2025','Flutter, Dart, Firebase, REST API','Flutter','Website untuk pengguna memantau produk dan harga dari sebuah produk.','img/djawara.png');

-- CRUD
-- SELECT * FROM projects ORDER BY id DESC;
-- SELECT * FROM projects WHERE category = 'Flutter' ORDER BY id DESC;
-- INSERT INTO projects (title,year,tech,category,description,image) VALUES ('Judul','2026','Flutter','Flutter','Deskripsi minimal 10 karakter','');
-- UPDATE projects SET title = 'Judul Baru' WHERE id = 1;
-- DELETE FROM projects WHERE id = 1;
