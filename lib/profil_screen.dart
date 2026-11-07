import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'img/fotoku.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person,
                                  size: 56, color: Color(0xFF4A00E0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Rudiyansyah Mahendra Nur Rohman',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Mahasiswa Teknik Informatika',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'NIM: E41250942',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionCard(
                context,
                title: 'Tentang Saya',
                child: const Text(
                  'Saya adalah mahasiswa Teknik Informatika POLITEKNIK NEGERI JEMBER PSDKU NGANJUK yang memiliki ketertarikan di bidang pengembangan aplikasi, desain UI/UX, serta teknologi web dan mobile. Saya senang belajar hal baru, mengeksplorasi teknologi, dan selalu berusaha untuk menghasilkan karya yang bermanfaat.',
                  style: TextStyle(height: 1.5),
                ),
              ),
              const SizedBox(height: 16),
              _buildSectionCard(
                context,
                title: 'Kontak & Sosial Media',
                child: Column(
                  children: [
                    _buildContactTile(
                        context, Icons.email, 'rudiyansyah937@gmail.com'),
                    const Divider(),
                    _buildContactTile(context, Icons.phone, '+62 881 3552 084'),
                    const Divider(),
                    _buildContactTile(
                        context, Icons.code, 'github.com/rudiyansyah937'),
                    const Divider(),
                    _buildContactTile(context, Icons.link,
                        'linkedin.com/in/rudiyansyah937'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildContactTile(BuildContext context, IconData icon, String text) {
    return InkWell(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: text));
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Disalin: $text')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.deepPurple),
            const SizedBox(width: 12),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
            const Icon(Icons.copy, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
