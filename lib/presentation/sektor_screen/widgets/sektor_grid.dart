import 'package:ekraf_kuy/models/Sector.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'sektor_item_widget.dart';
import '../../pelaku_usaha_screen/pelaku_usaha_screen.dart';
import '../../../models/sektor_sektor_model.dart';

class SektorGrid extends StatelessWidget {
  final List<Sector> sectorList;

  const SektorGrid({Key? key, required this.sectorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: sectorList.length,
      itemBuilder: (context, index) {
        final sector = sectorList[index];
        return SektorItemWidget(
          sector: sector,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PelakuUsahaScreen(sectorId: int.parse(sector.id)),
              ),
            );
          },
        );
      },
    );
  }
}