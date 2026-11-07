import 'package:flutter/material.dart';

import 'project_store.dart';
import 'theme_notifier.dart';

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {
  bool _notifications = true;

  Future<void> _confirmReset() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Data?'),
        content: const Text(
            'Semua data portofolio akan dikembalikan ke 5 contoh awal.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Reset')),
        ],
      ),
    );
    if (ok != true) return;
    await ProjectStore.instance.resetToSeed();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data dikembalikan ke contoh awal')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const label =
        TextStyle(fontWeight: FontWeight.bold, color: Colors.grey);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setelan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Tampilan & Tema', style: label),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) => SwitchListTile(
              title: const Text('Mode Gelap (Dark Mode)'),
              value: mode == ThemeMode.dark,
              onChanged: (val) {
                themeModeNotifier.value =
                    val ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ),
          const Divider(),
          const Text('Notifikasi', style: label),
          SwitchListTile(
            title: const Text('Izinkan Notifikasi App'),
            value: _notifications,
            onChanged: (val) => setState(() => _notifications = val),
          ),
          const Divider(),
          const Text('Data', style: label),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Reset data portofolio'),
            subtitle: const Text('Kembalikan ke 5 contoh awal'),
            onTap: _confirmReset,
          ),
          const Divider(),
          const Text('Tentang Aplikasi', style: label),
          const ListTile(
            title: Text('Versi Aplikasi'),
            subtitle: Text('v2.0.0'),
            trailing: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }
}
