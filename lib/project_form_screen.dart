import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'models.dart';
import 'project_image.dart';
import 'project_store.dart';

class ProjectFormScreen extends StatefulWidget {
  final Project? project; 

  const ProjectFormScreen({super.key, this.project});

  @override
  State<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _year = TextEditingController();
  final _tech = TextEditingController();
  final _desc = TextEditingController();
  String _category = kCategories.first;
  String _image = '';
  Uint8List? _previewBytes;
  bool _saving = false;

  bool get _isEdit => widget.project != null;

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    if (p != null) {
      _title.text = p.title;
      _year.text = p.year;
      _tech.text = p.tech;
      _desc.text = p.description;
      _category = kCategories.contains(p.category) ? p.category : 'Lainnya';
      _image = p.image;
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _year.dispose();
    _tech.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      imageQuality: 70,
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    setState(() {
      _previewBytes = bytes;
    });
  }

  void _removeImage() {
    setState(() {
      _previewBytes = null;
      _image = '';
    });
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _title.clear();
    _year.clear();
    _tech.clear();
    _desc.clear();
    setState(() {
      _category = kCategories.first;
      _image = '';
      _previewBytes = null;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      var imagePath = _image;
      if (_previewBytes != null) {
        imagePath = 'b64:${base64Encode(_previewBytes!)}';
      }
      final p = Project(
        id: widget.project?.id,
        title: _title.text.trim(),
        year: _year.text.trim(),
        tech: _tech.text.trim(),
        category: _category,
        description: _desc.text.trim(),
        image: imagePath,
      );
      if (_isEdit) {
        await ProjectStore.instance.update(p);
      } else {
        await ProjectStore.instance.add(p);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan: $e')),
      );
      return;
    }
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(_isEdit
              ? 'Perubahan berhasil disimpan'
              : 'Portofolio berhasil ditambahkan')),
    );
    Navigator.pop(context);
  }

  Widget _imageSection() {
    Widget preview;
    if (_previewBytes != null) {
      preview = SizedBox(
        height: 160,
        width: double.infinity,
        child: Image.memory(_previewBytes!, fit: BoxFit.cover),
      );
    } else {
      preview = ProjectImage(path: _image, height: 160);
    }
    final hasImage = _previewBytes != null || _image.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Gambar', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ClipRRect(borderRadius: BorderRadius.circular(12), child: preview),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _saving ? null : _pickImage,
                icon: const Icon(Icons.photo_library),
                label:
                    Text(hasImage ? 'Ganti dari Galeri' : 'Pilih dari Galeri'),
              ),
            ),
            if (hasImage) ...[
              const SizedBox(width: 8),
              IconButton(
                onPressed: _saving ? null : _removeImage,
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Hapus gambar',
              ),
            ],
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Portofolio' : 'Tambah Portofolio'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Judul Karya',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Judul minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _year,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(
                labelText: 'Tahun',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final t = v?.trim() ?? '';
                if (t.isEmpty) return 'Tahun wajib diisi';
                final y = int.tryParse(t);
                if (y == null || t.length != 4) {
                  return 'Tahun harus 4 digit angka';
                }
                if (y < 2000 || y > DateTime.now().year + 1) {
                  return 'Tahun tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 2),
            TextFormField(
              controller: _tech,
              decoration: const InputDecoration(
                labelText: 'Teknologi (pisahkan dengan koma)',
                prefixIcon: Icon(Icons.memory),
                border: OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Teknologi wajib diisi'
                  : null,
            ),
            const SizedBox(height: 14),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _category,
                  isExpanded: true,
                  items: kCategories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _category = v);
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),
            _imageSection(),
            const SizedBox(height: 14),
            TextFormField(
              controller: _desc,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                alignLabelWithHint: true,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 56),
                  child: Icon(Icons.description),
                ),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Deskripsi wajib diisi';
                }
                if (v.trim().length < 10) {
                  return 'Deskripsi minimal 10 karakter';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: const Icon(Icons.save),
              label: Text(_isEdit ? 'Simpan Perubahan' : 'Simpan Portofolio'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            if (!_isEdit) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _saving ? null : _resetForm,
                icon: const Icon(Icons.clear),
                label: const Text('Bersihkan Form'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}