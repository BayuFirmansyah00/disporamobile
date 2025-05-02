import 'package:flutter/material.dart';
import '../../../models/Sector.dart';

class SectorsGrid extends StatelessWidget {
  final Sector sector; // Terima objek Sector
  final VoidCallback onTapKategori;

  const SectorsGrid({
    Key? key,
    required this.sector,
    required this.onTapKategori,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapKategori,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            sector.iconUrl,
            height: 40,
            width: 40,
            errorBuilder:
                (context, error, stackTrace) => Icon(Icons.image_not_supported),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CircularProgressIndicator();
            },
          ),
          SizedBox(height: 8),
          Text(
            sector.name, // Gunakan nama sektor
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
