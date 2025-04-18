import 'package:flutter/material.dart';
import 'widgets/sektor_grid.dart';
import 'sektor_model.dart';

class SektorScreen extends StatelessWidget {
  const SektorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Semua Sektor")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildKategori("Seni dan Desain Visual", [
              Sektor(name: "Fotografi", imagePath: 'assets/images/fotografi.png'),
              Sektor(name: "Seni Rupa", imagePath: 'assets/images/seni_rupa.png'),
              Sektor(name: "Desain Interior", imagePath: 'assets/images/desain_interior.png'),
              Sektor(name: "Desain Komunikasi Visual", imagePath: 'assets/images/dkv.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Media dan Hiburan", [
              Sektor(name: "Film, Animasi, Video", imagePath: 'assets/images/film_animasi.png'),
              Sektor(name: "TV & Radio", imagePath: 'assets/images/tv_radio.png'),
              Sektor(name: "Seni Pertunjukan", imagePath: 'assets/images/seni_pertunjukan.png'),
              Sektor(name: "Musik", imagePath: 'assets/images/musik.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Produk Kreatif dan Industri", [
              Sektor(name: "Pengembangan Permainan", imagePath: 'assets/images/game_dev.png'),
              Sektor(name: "Aplikasi", imagePath: 'assets/images/apps.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Arsitektur dan Kriya", [
              Sektor(name: "Arsitektur", imagePath: 'assets/images/arsitektur.png'),
              Sektor(name: "Kriya", imagePath: 'assets/images/kriya.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Fashion dan Kuliner", [
              Sektor(name: "Fashion", imagePath: 'assets/images/fashion.png'),
              Sektor(name: "Kuliner", imagePath: 'assets/images/kuliner.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Periklanan dan Penerbitan", [
              Sektor(name: "Periklanan", imagePath: 'assets/images/periklanan.png'),
              Sektor(name: "Penerbitan", imagePath: 'assets/images/penerbitan.png'),
            ]),
            // Tambahkan kategori lainnya jika perlu
          ],
        ),
      ),
    );
  }

  Widget buildKategori(String title, List<Sektor> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        SektorGrid(sektorList: items),
      ],
    );
  }
}