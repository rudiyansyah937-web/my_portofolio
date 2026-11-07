import 'package:flutter/material.dart';

import 'project_store.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang! 👋',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'POLIJE Student Portofolio: aplikasi portofolio digital interaktif untuk menampilkan karya dan profil mahasiswa.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: ProjectStore.instance,
              builder: (context, _) {
                final items = ProjectStore.instance.items;
                final kategori = items.map((e) => e.category).toSet().length;
                return Row(
                  children: [
                    Expanded(
                      child: _statCard(context, Icons.folder_special,
                          '${items.length}', 'Total Karya'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statCard(context, Icons.category, '$kategori',
                          'Kategori'),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Aktivitas Terbaru',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildActivityTile(
              icon: Icons.code,
              title: 'Memperbarui struk',
              subtitle:
                  'Memperbarui fitur simpan struk yang otomatis menyimpan ke galeri.',
            ),
            _buildActivityTile(
              icon: Icons.design_services,
              title: 'Desain UI/UX Mobile',
              subtitle: 'Selesai memperbaiki UI/UX dan kustomisasi warna.',
            ),
            _buildActivityTile(
              icon: Icons.school,
              title: 'Merancang requirement aplikasi',
              subtitle:
                  'Merancang requirement aplikasi berbasis Flutter untuk mitra selanjutnya.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(
      BuildContext context, IconData icon, String value, String label) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple, size: 28),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(label, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple.shade50,
          child: Icon(icon, color: Colors.deepPurple),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
