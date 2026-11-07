import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TentangPolijeScreen extends StatefulWidget {
  const TentangPolijeScreen({super.key});

  @override
  State<TentangPolijeScreen> createState() => _TentangPolijeScreenState();
}

class _TentangPolijeScreenState extends State<TentangPolijeScreen> {
  static const _gradient = LinearGradient(
    colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Map<String, List<String>> _jurusan = {
    'Teknologi Informasi': [
      'D3 Manajemen Informatika',
      'D3 Teknik Komputer',
      'D4 Teknik Informatika',
      'D4 Teknologi Rekayasa Komputer',
      'D4 Teknik Informatika - PSDKU Nganjuk',
      'D4 Teknik Informatika - PSDKU Sidoarjo',
    ],
    'Bahasa, Komunikasi dan Pariwisata': [
      'D3 Bahasa Inggris',
      'D4 Destinasi Pariwisata',
    ],
    'Manajemen Agribisnis': [
      'Manajemen Agribisnis',
      'D4 Manajemen Agroindustri',
    ],
    'Teknologi Pertanian': [
      'D3 Teknologi Industri Pangan',
      'Teknologi Rekayasa Pangan',
    ],
    'Produksi Pertanian': [
      'D3 Produksi Tanaman Hortikultura',
      'D4 Teknik Produksi Benih',
    ],
    'Peternakan': [
      'D3 Produksi Ternak',
      'D4 Manajemen Bisnis Unggas',
      'D4 Teknologi Pakan Ternak',
    ],
    'Kesehatan': [
      'D4 Gizi Klinik',
      'D4 Manajemen Informasi Kesehatan',
    ],
    'Teknik': [
      'D4 Mesin Otomotif',
      'D4 Teknologi Rekayasa Mekatronika',
      'D4 Teknik Energi Terbarukan',
    ],
    'Bisnis': [
      'D4 Akuntansi Sektor Publik',
    ],
  };

  static const List<_Info> _alasan = [
    _Info(
      Icons.handyman,
      '60% Praktik, 40% Teori',
      'Pembelajaran menitikberatkan keterampilan sehingga lulusan siap bersaing di dunia kerja.',
    ),
    _Info(
      Icons.factory,
      'Teaching Factory',
      'Belajar lewat produk dan jasa nyata yang menghadirkan suasana industri ke dalam kampus.',
    ),
    _Info(
      Icons.workspace_premium,
      'Jenjang Lengkap',
      'Tersedia Diploma III, Sarjana Terapan (D4), dan Magister Terapan.',
    ),
    _Info(
      Icons.business_center,
      'Magang Industri',
      'Magang menjadi bagian kurikulum untuk memberi pengalaman kerja nyata sebelum lulus.',
    ),
  ];

  static const List<_Info> _kegiatan = [
    _Info(
      Icons.factory,
      'Teaching Factory (TEFA)',
      'Pembelajaran berbasis produk dan jasa yang menghadirkan industri ke dalam kampus, melibatkan kerja sama dengan pihak industri.',
    ),
    _Info(
      Icons.local_drink,
      'TEFA Milk',
      'Unit TEFA Milk mengintegrasikan teknologi Ultra High Temperature (UHT) untuk mendukung praktik mahasiswa.',
    ),
    _Info(
      Icons.computer,
      'Laboratorium Jurusan TI',
      'Lab Arsitektur & Jaringan Komputer, Komputasi & Sistem Informasi, Rekayasa Sistem Informasi, serta Sistem Komputer & Kontrol.',
    ),
    _Info(
      Icons.eco,
      'Program GoGreen',
      'Kegiatan ramah lingkungan seperti car-free day setiap Jumat, penggunaan sepeda di area kampus, dan tiga jenis tempat sampah.',
    ),
    _Info(
      Icons.translate,
      'Program TOEIC 2025',
      'Polije menyelenggarakan program TOEIC untuk menyiapkan lulusan berdaya saing global.',
    ),
    _Info(
      Icons.handshake,
      'Kerja Sama Swisscontact SS4C',
      'Kerja sama pengembangan TEFA dalam kerangka Joint Activity Plan (JAP) 2026-2027.',
    ),
    _Info(
      Icons.public,
      'Praktik Mahasiswa Internasional',
      'Mahasiswa dari Jiangsu Agri-Animal Husbandry Vocational College (China) menjalani praktik lapangan di TEFA Milk Polije.',
    ),
    _Info(
      Icons.coffee,
      'Pelatihan Barista Kopi',
      'Pelatihan hasil kolaborasi Dinas Tenaga Kerja Kabupaten Jember dan Polije bagi masyarakat.',
    ),
    _Info(
      Icons.celebration,
      'HUT ke-37 Polije',
      'Perayaan dengan jalan sehat massal dan acara minum susu bersama yang memperkenalkan produk TEFA Milk.',
    ),
  ];

  final PageController _kegiatanController =
      PageController(viewportFraction: 0.9);
  int _kegiatanPage = 0;
  String _selectedJurusan = 'Teknologi Informasi';

  @override
  void dispose() {
    _kegiatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _statStrip(surface),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle(Icons.account_balance, '1. Profil POLIJE'),
                    _card(surface, _profil()),
                    const SizedBox(height: 20),
                    _sectionTitle(Icons.star, 'Mengapa Memilih POLIJE?'),
                    _card(surface, _alasanList()),
                    const SizedBox(height: 20),
                    _sectionTitle(Icons.menu_book, '2. Program Studi'),
                    _card(surface, _programStudi()),
                    const SizedBox(height: 20),
                    _sectionTitle(Icons.laptop_mac, '3. Program Studi Saya'),
                    _prodiSaya(),
                    const SizedBox(height: 20),
                    _sectionTitle(
                        Icons.celebration, '4. Fasilitas & Kegiatan Kampus'),
                  ],
                ),
              ),
              _kegiatanPager(surface),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: _ajakan(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: _card(surface, _sumber()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.school, color: Colors.white, size: 44),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tentang POLIJE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Politeknik Negeri Jember - Terampil, Adaptif, Kompetitif',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statStrip(Color surface) {
    return Row(
      children: [
        Expanded(child: _stat(surface, '60%', 'Porsi Praktik')),
        const SizedBox(width: 10),
        Expanded(child: _stat(surface, 'D3-S2', 'Jenjang Terapan')),
        const SizedBox(width: 10),
        Expanded(child: _stat(surface, '1987', 'Sejak Berdiri')),
      ],
    );
  }

  Widget _stat(Color surface, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple)),
          const SizedBox(height: 2),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _card(Color color, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profil() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row(Icons.badge, 'Nama Perguruan Tinggi',
            'Politeknik Negeri Jember (Polije)'),
        _row(Icons.location_on, 'Lokasi',
            'Jl. Mastrip PO BOX 164, Jember, Jawa Timur'),
        _row(Icons.history_edu, 'Awal Berdiri',
            '1987, dengan nama Politeknik Pertanian Universitas Jember'),
        _row(Icons.account_tree, 'Jenjang Pendidikan',
            'Diploma III, Sarjana Terapan (D4), dan Magister Terapan'),
        _row(Icons.verified, 'Status',
            'PTN BLU sejak 2022 dan ditetapkan sebagai calon PTN-BH pada 2023'),
        _row(Icons.apartment, 'Kampus Lain (PSDKU)',
            'Antara lain Bondowoso, Nganjuk, Sidoarjo, dan Ngawi'),
        const Divider(),
        const Text('Karakteristik Pendidikan Vokasi',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text(
          'Pendidikan vokasi mengarahkan pembelajaran pada tingkat keahlian dan standar kompetensi spesifik yang dibutuhkan sektor industri. Porsi pembelajaran di Polije menitikberatkan praktik (sekitar 60% praktik dan 40% teori) melalui konsep Teaching Factory, sehingga lulusan diharapkan terampil, adaptif, mampu berkompetisi di dunia kerja, dan berwirausaha mandiri.',
          style: TextStyle(height: 1.5, fontSize: 13),
        ),
      ],
    );
  }

  Widget _alasanList() {
    return Column(
      children: [
        for (int i = 0; i < _alasan.length; i++) ...[
          if (i > 0) const Divider(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.deepPurple.shade50,
                child: Icon(_alasan[i].icon, color: Colors.deepPurple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_alasan[i].title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(_alasan[i].text,
                        style: const TextStyle(fontSize: 12.5, height: 1.4)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _programStudi() {
    final prodi = _jurusan[_selectedJurusan]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Polije memiliki beberapa jurusan. Pilih jurusan untuk melihat contoh program studinya.',
          style: TextStyle(fontSize: 13),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedJurusan,
              isExpanded: true,
              items: _jurusan.keys
                  .map((j) => DropdownMenuItem(
                        value: j,
                        child: Text('Jurusan $j',
                            overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _selectedJurusan = v);
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        ...prodi.map(
          (p) => ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.school_outlined,
                color: Colors.deepPurple, size: 20),
            title: Text(p),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Daftar lengkap dan terbaru: polije.ac.id',
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _prodiSaya() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('D4 Teknik Informatika',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          const Text('Jurusan Teknologi Informasi - PSDKU Nganjuk',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 10),
          const Text(
            'Program studi ini membekali mahasiswa dengan kompetensi pengembangan website, aplikasi mobile, Internet of Things (IoT), dan kecerdasan buatan, serta dasar manajemen basis data, analisis sistem, dan pengembangan perangkat lunak. Pembelajaran memadukan teori di kelas dan praktik di laboratorium, dilanjutkan magang industri sebagai syarat kelulusan. Lulusan memperoleh gelar Sarjana Terapan (S.Tr.).',
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: const [
              'Web',
              'Mobile',
              'IoT',
              'AI',
              'Basis Data',
              'Analisis Sistem',
            ]
                .map((t) => Chip(
                      label: Text(t,
                          style: const TextStyle(
                              fontSize: 11, color: Colors.black87)),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: Colors.white,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _kegiatanPager(Color surface) {
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: _kegiatanController,
            itemCount: _kegiatan.length,
            onPageChanged: (i) => setState(() => _kegiatanPage = i),
            itemBuilder: (context, i) {
              final k = _kegiatan[i];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade50,
                      child: Icon(k.icon, color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 10),
                    Text(k.title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(k.text,
                            style:
                                const TextStyle(fontSize: 12.5, height: 1.4)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_kegiatan.length, (i) {
            final active = i == _kegiatanPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: active ? Colors.deepPurple : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _ajakan() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.rocket_launch, color: Colors.white, size: 36),
          const SizedBox(height: 8),
          const Text('Tertarik Kuliah di POLIJE?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text(
            'Wujudkan karier dengan keterampilan nyata. Informasi program studi dan pendaftaran terbaru tersedia di situs resmi.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () async {
              await Clipboard.setData(
                  const ClipboardData(text: 'https://polije.ac.id'));
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Disalin: https://polije.ac.id')),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF4A00E0),
            ),
            icon: const Icon(Icons.copy, size: 18),
            label: const Text('Salin alamat polije.ac.id'),
          ),
        ],
      ),
    );
  }

  Widget _sumber() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sumber Informasi',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text(
          '- polije.ac.id (berita resmi dan repositori SIPORA Polije)\n'
          '- jti.polije.ac.id (Jurusan Teknologi Informasi)\n'
          '- sinta.kemdiktisaintek.go.id (daftar program studi)\n'
          '- greenmetric.ui.ac.id (profil Polije)\n'
          'Diakses Oktober 2026. Informasi dapat berubah, cek situs resmi untuk data terbaru.',
          style: TextStyle(fontSize: 12, height: 1.5),
        ),
      ],
    );
  }
}

class _Info {
  final IconData icon;
  final String title;
  final String text;
  const _Info(this.icon, this.title, this.text);
}