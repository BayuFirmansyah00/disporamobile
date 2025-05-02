import 'package:flutter/material.dart';
import 'widgets/sektor_grid.dart';
import '../../models/sektor_sektor_model.dart';

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
              Sektor(id: 9, name: "Fotografi", imagePath: 'assets/images/fotografi.png'),
              Sektor(id: 16, name: "Seni Rupa", imagePath: 'assets/images/seni_rupa.png'),
              Sektor(id: 1, name: "Desain Interior", imagePath: 'assets/images/desain_interior.png'),
              Sektor(id: 2, name: "Desain Komunikasi Visual", imagePath: 'assets/images/dkv.png'),
              Sektor(id: 17, name: "Desain Produk", imagePath: 'assets/images/desain_produk.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Media dan Hiburan", [
              Sektor(id: 8, name: "Film, Animasi, Video", imagePath: 'assets/images/film.png'),
              Sektor(id: 11, name: "TV & Radio", imagePath: 'assets/images/tvradio.png'),
              Sektor(id: 14, name: "Seni Pertunjukan", imagePath: 'assets/images/seni_pertunjukkan.png'),
              Sektor(id: 7, name: "Musik", imagePath: 'assets/images/musik.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Produk Kreatif dan Industri", [
              Sektor(id: 13, name: "Pengembangan Permainan", imagePath: 'assets/images/game.png'),
              Sektor(id: 12, name: "Aplikasi", imagePath: 'assets/images/aplikasi.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Arsitektur dan Kriya", [
              Sektor(id: 5, name: "Arsitektur", imagePath: 'assets/images/arsitektur.png'),
              Sektor(id: 4, name: "Kriya", imagePath: 'assets/images/kriya.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Fashion dan Kuliner", [
              Sektor(id: 10, name: "Fashion", imagePath: 'assets/images/fashion.png'),
              Sektor(id: 6, name: "Kuliner", imagePath: 'assets/images/kuliner.png'),
            ]),
            SizedBox(height: 20),
            buildKategori("Periklanan dan Penerbitan", [
              Sektor(id: 3, name: "Periklanan", imagePath: 'assets/images/periklanan.png'),
              Sektor(id: 15, name: "Penerbitan", imagePath: 'assets/images/penerbitan.png'),
              
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