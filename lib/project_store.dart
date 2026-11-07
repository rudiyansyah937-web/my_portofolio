import 'package:flutter/foundation.dart';

import 'api_service.dart';
import 'models.dart';

class ProjectStore extends ChangeNotifier {
  ProjectStore._();
  static final ProjectStore instance = ProjectStore._();

  List<Project> items = [];
  bool loading = true;
  String? error;
  int addCount = 0;

  Future<void> load() async {
    try {
      items = await ApiService.instance.getAll();
      error = null;
    } catch (e) {
      error =
          'Tidak dapat terhubung ke server.\nPastikan Apache & MySQL di XAMPP aktif dan database db_portofolio sudah diimpor.\n($e)';
    }
    loading = false;
    notifyListeners();
  }

  Future<void> add(Project p) async {
    await ApiService.instance.insert(p);
    addCount++;
    await load();
  }

  Future<void> update(Project p) async {
    await ApiService.instance.update(p);
    await load();
  }

  Future<void> remove(int id) async {
    await ApiService.instance.delete(id);
    await load();
  }

  Future<void> resetToSeed() async {
    await ApiService.instance.resetToSeed();
    await load();
  }
}