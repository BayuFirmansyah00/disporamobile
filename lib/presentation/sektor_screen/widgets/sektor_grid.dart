import 'package:flutter/material.dart';
import '../../../models/sektor_sektor_model.dart';
import 'sektor_item_widget.dart';
import '../../subsektor_screen/subsektor_screen.dart'; // Import screen tujuan

class SektorGrid extends StatelessWidget {
  final List<Sektor> sektorList;

  const SektorGrid({
    Key? key,
    required this.sektorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: sektorList.map((sektor) {
        return SizedBox(
          width: 80,
          child: SektorItemWidget(
            title: sektor.name,
            imagePath: sektor.imagePath,
            // Menambahkan navigasi saat item di-tap
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubsektorScreen(
                    sector: {
                      'id': sektor.id.toString(),
                      'name': sektor.name, 
                      'imagePath': sektor.imagePath},
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}