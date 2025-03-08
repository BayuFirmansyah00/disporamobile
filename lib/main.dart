import 'package:flutter/material.dart';
import 'screen/dashboard.dart'; // Impor dashboard.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ekonomi Kreatif Nganjuk',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Dashboard(), // Menampilkan Dashboard sebagai halaman utama
    );
  }
}
