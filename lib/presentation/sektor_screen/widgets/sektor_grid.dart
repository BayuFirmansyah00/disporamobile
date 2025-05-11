import 'package:flutter/material.dart';
import 'sektor_item_widget.dart';
import '../../pelaku_usaha_screen/pelaku_usaha_screen.dart';
import '../../../models/sektor_sektor_model.dart';

class SektorGrid extends StatelessWidget {
  final List<Sektor> sectorList;

  const SektorGrid({Key? key, required this.sectorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Mengubah ke 3 kolom untuk lebih mirip desain
        crossAxisSpacing: 8, // Mengurangi jarak horizontal
        mainAxisSpacing: 8, // Mengurangi jarak vertikal
        childAspectRatio: 0.9, // Menyesuaikan rasio untuk kompak
      ),
      itemCount: sectorList.length,
      itemBuilder: (context, index) {
        final sektor = sectorList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PelakuUsahaScreen(
                  sectorId: sektor.id,
                ),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50, // Mengurangi ukuran menjadi 50x50 seperti desain
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    sektor.imagePath,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              SizedBox(height: 4), // Mengurangi jarak teks
              Text(
                sektor.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), // Ukuran teks lebih kecil
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}