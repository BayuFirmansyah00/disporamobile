import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../core/app_export.dart';
import '../../../services/api_service.dart';

class ArticlelistItemWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String? description;
  final VoidCallback? onTapColumnSelengkap;

  const ArticlelistItemWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.description,
    this.onTapColumnSelengkap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapColumnSelengkap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xFF123458),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 168,
                width: double.maxFinite,
                fit: BoxFit.cover,
                httpHeaders: ApiService.getImageHeaders(),
                placeholder: (context, url) => Container(
                  height: 168,
                  width: double.maxFinite,
                  color: Colors.grey[300],
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) {
                  print('Error loading image: $error, URL: $imageUrl');
                  return Container(
                    height: 168,
                    width: double.maxFinite,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 50, color: Colors.white),
                  );
                },
                cacheManager: CacheManager(
                  Config(
                    'articleCacheKey',
                    stalePeriod: const Duration(days: 7),
                    maxNrOfCacheObjects: 100,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          "Selengkapnya",
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmallOnPrimary,
                        ),
                      ),
                      SizedBox(width: 4),
                      CustomImageView(
                        imagePath: ImageConstant.arrow,
                        height: 12,
                        width: 12,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}