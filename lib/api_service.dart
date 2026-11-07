import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'models.dart';

class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  static String get baseUrl {
    final android =
        !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    return android
        ? 'http://10.0.2.2/portofolio_api/api.php'
        : 'http://localhost/portofolio_api/api.php';
  }

  static String get baseHost => baseUrl.replaceFirst('api.php', '');
  static String imageUrl(String path) => '$baseHost$path';

  static const _headers = {'Content-Type': 'application/json'};
  static const _timeout = Duration(seconds: 10);

  void _check(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) return;
    var msg = 'Server error (${res.statusCode})';
    try {
      msg = (jsonDecode(res.body) as Map)['error'].toString();
    } catch (_) {}
    throw Exception(msg);
  }

  Future<List<Project>> getAll() async {
    final res = await http.get(Uri.parse(baseUrl)).timeout(_timeout);
    _check(res);
    final list = jsonDecode(res.body) as List;
    return list.map((e) {
      final m = Map<String, Object?>.from(e as Map);
      m['id'] = int.parse(m['id'].toString());
      return Project.fromMap(m);
    }).toList();
  }

  Future<void> insert(Project p) async {
    final res = await http
        .post(Uri.parse(baseUrl), headers: _headers, body: jsonEncode(p.toMap()))
        .timeout(_timeout);
    _check(res);
  }

  Future<void> update(Project p) async {
    final res = await http
        .put(Uri.parse('$baseUrl?id=${p.id}'),
            headers: _headers, body: jsonEncode(p.toMap()))
        .timeout(_timeout);
    _check(res);
  }

  Future<void> delete(int id) async {
    final res =
        await http.delete(Uri.parse('$baseUrl?id=$id')).timeout(_timeout);
    _check(res);
  }

  Future<void> resetToSeed() async {
    final res =
        await http.post(Uri.parse('$baseUrl?action=reset')).timeout(_timeout);
    _check(res);
  }

  Future<String> uploadImage(XFile file) async {
    final req =
        http.MultipartRequest('POST', Uri.parse('$baseUrl?action=upload'));
    req.files.add(http.MultipartFile.fromBytes(
      'image',
      await file.readAsBytes(),
      filename: file.name.isEmpty ? 'foto.jpg' : file.name,
    ));
    final streamed = await req.send().timeout(const Duration(seconds: 30));
    final res = await http.Response.fromStream(streamed);
    _check(res);
    return (jsonDecode(res.body) as Map)['path'].toString();
  }
}