import 'package:flutter/material.dart';

class Sektor {
  final String name;
  final String imagePath;
  final VoidCallback? onTap;

  Sektor({
    required this.name,
    required this.imagePath,
    this.onTap,
  });
}