import 'package:flutter/material.dart';

import 'models.dart';
import 'project_form_screen.dart';
import 'project_image.dart';
import 'project_store.dart';

class PortofolioScreen extends StatefulWidget {
  const PortofolioScreen({super.key});

  @override
  State<PortofolioScreen> createState() => _PortofolioScreenState();
}

class _PortofolioScreenState extends State<PortofolioScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedCategory = 'Semua';
  int _seenAdd = ProjectStore.instance.addCount;

  final List<String> _filters = ['Semua', ...kCategories];

  @override
  void initState() {
    super.initState();
    ProjectStore.instance.addListener(_onStore);
  }

  void _onStore() {
    final store = ProjectStore.instance;
    if (store.addCount != _seenAdd) {
      _seenAdd = store.addCount;
      setState(() {
        _selectedCategory = 'Semua';
        _resetPager();
      });
    }
  }

  @override
  void dispose() {
    ProjectStore.instance.removeListener(_onStore);
    _pageController.dispose();
    super.dispose();
  }

  List<Project> _filtered(List<Project> all) {
    if (_selectedCategory == 'Semua') return all;
    return all.where((p) => p.category == _selectedCategory).toList();
  }

  void _resetPager() {
    _currentPage = 0;
    if (_pageController.hasClients) _pageController.jumpToPage(0);
  }

  Future<void> _delete(Project p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Portofolio?'),
        content: Text('"${p.title}" akan dihapus permanen.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Hapus')),
        ],
      ),
    );
    if (ok != true) return;
    await ProjectStore.instance.remove(p.id!);
    if (!mounted) return;
    setState(_resetPager);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Portofolio berhasil dihapus')),
    );
  }

  void _edit(Project p) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProjectFormScreen(project: p)),
    );
  }

  void _add() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProjectFormScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = (MediaQuery.of(context).size.height * 0.5)
        .clamp(400.0, 500.0)
        .toDouble();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: ProjectStore.instance,
          builder: (context, _) {
            final store = ProjectStore.instance;
            final list = _filtered(store.items);
            final page = list.isEmpty
                ? 0
                : _currentPage.clamp(0, list.length - 1).toInt();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildDropdown(context),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('My Projects',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          'Menampilkan ${list.length} dari ${store.items.length} karya.',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        if (store.loading)
                          const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        else if (store.error != null)
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(store.error!,
                                style: const TextStyle(color: Colors.red)),
                          )
                        else if (list.isEmpty)
                          _buildEmpty()
                        else ...[
                          SizedBox(
                            height: cardHeight,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: list.length,
                              onPageChanged: (i) =>
                                  setState(() => _currentPage = i),
                              itemBuilder: (context, index) {
                                final project = list[index];
                                return _ProjectCard(
                                  project: project,
                                  onEdit: () => _edit(project),
                                  onDelete: () => _delete(project),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildIndicator(list.length, page),
                          const SizedBox(height: 12),
                          _buildNavButtons(list.length, page),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 38, color: Color(0xFF4A00E0)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rudiyansyah Mahendra Nur Rohman',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text('NIM: E41250942',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: _filters
              .map((c) => DropdownMenuItem<String>(
                    value: c,
                    child: Text('Kategori: $c'),
                  ))
              .toList(),
          onChanged: (String? v) {
            if (v == null) return;
            setState(() {
              _selectedCategory = v;
              _resetPager();
            });
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: const Column(
        children: [
          Icon(Icons.folder_off, size: 56, color: Colors.grey),
          SizedBox(height: 8),
          Text('Belum ada karya pada kategori ini.',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildIndicator(int count, int page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == page;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 22 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? Colors.deepPurple : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildNavButtons(int count, int page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: page > 0
              ? () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )
              : null,
          icon: const Icon(Icons.arrow_back_ios, size: 14),
          label: const Text('Sebelumnya'),
        ),
        ElevatedButton(
          onPressed: page < count - 1
              ? () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  )
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Berikutnya'),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, size: 14),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ProjectCard({
    required this.project,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ProjectImage(path: project.image),
          ),
          const SizedBox(height: 10),
          Text(project.title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.label, size: 14, color: Colors.deepPurple),
              const SizedBox(width: 4),
              Text(project.category,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600)),
              const SizedBox(width: 12),
              const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(project.year,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Teknologi: ${project.tech}',
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Expanded(
            child: SingleChildScrollView(
              child: Text(project.description,
                  style: const TextStyle(fontSize: 12)),
            ),
          ),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('Edit'),
              ),
              TextButton.icon(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                label:
                    const Text('Hapus', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}