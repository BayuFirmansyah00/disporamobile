import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../models/Sector.dart';

class SectorsGrid extends StatelessWidget {
  final Sector sector;
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
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(6),
            child: sector.isAsset == true && sector.iconUrl.isNotEmpty
                ? ClipOval(
                    child: Image.asset(
                      sector.iconUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.broken_image,
                            size: 20,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  )
                : sector.iconUrl.isEmpty
                    ? ClipOval(
                        child: Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.broken_image,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: sector.iconUrl,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 50,
                          width: 50,
                          color: Colors.grey[300],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) {
                          print('Error loading sector icon: $error, URL: $url');
                          return Container(
                            height: 50,
                            width: 50,
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.broken_image,
                              size: 20,
                              color: Colors.white,
                            ),
                          );
                        },
                        cacheManager: CacheManager(
                          Config(
                            'sectorCacheKey',
                            stalePeriod: const Duration(days: 7),
                            maxNrOfCacheObjects: 100,
                          ),
                        ),
                      ),
          ),
          const SizedBox(height: 6),
          Text(
            sector.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}