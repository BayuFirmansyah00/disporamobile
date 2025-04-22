import 'package:flutter/material.dart';

class Sektor {
  final int id;
  final String name;
  final String imagePath;
  final VoidCallback? onTap;

  Sektor({
    required this.id,
    required this.name,
    required this.imagePath,
    this.onTap,
  });
}