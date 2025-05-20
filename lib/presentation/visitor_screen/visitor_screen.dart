import 'package:flutter/material.dart';

class VisitorScreen extends StatelessWidget {
  const VisitorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pengunjung'),
      ),
      body: const Center(
        child: Text('Selamat datang, Pengunjung!'),
      ),
    );
  }
}