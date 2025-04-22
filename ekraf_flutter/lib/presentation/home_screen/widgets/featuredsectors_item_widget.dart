import 'package:flutter/material.dart';
import '../../../models/home_sector_model.dart';

class FeaturedsectorsItemWidget extends StatelessWidget {
  final SectorModel sector;
  final VoidCallback onTapSektorunggulan;

  //const FeaturedsectorsItemWidget({Key? key, required this.sector}) : super(key: key);
  const FeaturedsectorsItemWidget({
    Key? key,
    required this.sector,
    required this.onTapSektorunggulan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapSektorunggulan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // optional
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              sector.image,
              height: 122,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(sector.name, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}