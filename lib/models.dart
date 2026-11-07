const List<String> kCategories = [
  'Flutter',
  'Laravel',
  'UI/UX',
  'React',
  'Python',
  'Java',
  'PHP',
  'Lainnya',
];

const Map<String, String> kImageOptions = {
  'Tanpa gambar': '',
  'Djawara Dawet': 'img/djawara.png',
  'Mbah Meth': 'img/mbahmeth.png',
  'UI/UX Mobile': 'img/uiux.png',
};

class Project {
  final int? id;
  final String title;
  final String year;
  final String tech;
  final String category;
  final String description;
  final String image;

  const Project({
    this.id,
    required this.title,
    required this.year,
    required this.tech,
    required this.category,
    required this.description,
    this.image = '',
  });

  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      'title': title,
      'year': year,
      'tech': tech,
      'category': category,
      'description': description,
      'image': image,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Project.fromMap(Map<String, Object?> map) {
    return Project(
      id: map['id'] as int?,
      title: map['title'] as String,
      year: map['year'] as String,
      tech: map['tech'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      image: (map['image'] as String?) ?? '',
    );
  }
}

const List<Project> seedProjects = [
  Project(
    title: 'Membuat Website UMKM Djawara Dawet',
    year: '2025',
    tech: 'Flutter, Dart, Firebase, REST API',
    category: 'Flutter',
    description:
        'Website untuk pengguna memantau produk dan harga dari sebuah produk.',
    image: 'img/djawara.png',
  ),
  Project(
    title: 'Membuat aplikasi UMKM toko pertanian Mbah Meth',
    year: '2026',
    tech: 'Laravel, PHP, MySQL, Bootstrap',
    category: 'Laravel',
    description:
        'Aplikasi untuk memantau ketersediaan dan order sebuah produk yang ada pada UMKM toko pertanian Mbah Meth.',
    image: 'img/mbahmeth.png',
  ),
  Project(
    title: 'Design UI/UX Mobile',
    year: '2026',
    tech: 'Figma, UI/UX Design, Wireframing',
    category: 'UI/UX',
    description:
        'Rancangan antarmuka aplikasi UMKM modern yang fokus pada kustomisasi dashboard dan kemudahan pemesanan digital.',
    image: 'img/uiux.png',
  ),
  Project(
    title: 'Aplikasi Struk Digital',
    year: '2026',
    tech: 'Flutter, Dart, SQLite',
    category: 'Flutter',
    description:
        'Aplikasi pencatatan transaksi dengan fitur simpan struk yang otomatis menyimpan ke galeri.',
  ),
  Project(
    title: 'Requirement Aplikasi Mitra',
    year: '2026',
    tech: 'Analisis Kebutuhan, Dokumentasi, Flutter',
    category: 'Flutter',
    description:
        'Merancang requirement aplikasi berbasis Flutter untuk mitra selanjutnya.',
  ),
];
