import 'dart:convert';

import 'package:flutter/material.dart';

import 'api_service.dart';

class ProjectImage extends StatelessWidget {
  final String path;
  final double height;

  const ProjectImage({super.key, required this.path, this.height = 130});

  Widget _placeholder() => Container(
        color: const Color(0xFFE9E0FF),
        child: const Center(
          child: Icon(Icons.image, size: 60, color: Colors.deepPurple),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (path.isEmpty) {
      child = _placeholder();
    } else if (path.startsWith('b64:')) {
      try {
        child = Image.memory(
          base64Decode(path.substring(4)),
          fit: BoxFit.cover,
          gaplessPlayback: true,
          errorBuilder: (context, error, stack) => _placeholder(),
        );
      } catch (_) {
        child = _placeholder();
      }
    } else if (path.startsWith('uploads/')) {
      child = Image.network(
        ApiService.imageUrl(path),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => _placeholder(),
      );
    } else {
      child = Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) => _placeholder(),
      );
    }
    return SizedBox(height: height, width: double.infinity, child: child);
  }
}