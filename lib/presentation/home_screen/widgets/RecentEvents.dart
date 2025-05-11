import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class RecentEvents extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTapRowsunglasses;

  const RecentEvents({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.onTapRowsunglasses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 152,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 152,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 152,
                      height: 100,
                      color: Colors.grey[300],
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) {
                      print('Error loading image: $error, URL: $url, Error type: ${error.runtimeType}');
                      return Container(
                        width: 152,
                        height: 100,
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, color: Colors.grey[600], size: 50),
                            Text(
                              'Error: $error',
                              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      );
                    },
                    // Tambahkan opsi timeout
                    cacheManager: CacheManager(
                      Config(
                        'customCacheKey',
                        stalePeriod: Duration(days: 7),
                        maxNrOfCacheObjects: 100,
                        // Removed invalid timeout parameter
                      ),
                    ),
                  )
                : Container(
                    width: 152,
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 50),
                  ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onTapRowsunglasses,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}