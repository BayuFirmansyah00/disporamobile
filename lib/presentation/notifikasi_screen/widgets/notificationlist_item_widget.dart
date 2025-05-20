import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../core/app_export.dart';
import '../../../services/api_service.dart';

// ignore_for_file: must_be_immutable
class NotificationlistItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String? date;
  final VoidCallback? onTapContainer;

  const NotificationlistItemWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.date,
    this.onTapContainer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapContainer?.call();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 60.h,
              width: 60.h,
              decoration: AppDecoration.fillGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder6,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.h),
                child: CachedNetworkImage(
                  imageUrl: imageUrl.isNotEmpty ? imageUrl : 'https://via.placeholder.com/150',
                  height: 60.h,
                  width: 60.h,
                  fit: BoxFit.cover,
                  httpHeaders: ApiService.getImageHeaders(),
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) {
                    print('Error loading image: $error, URL: $imageUrl');
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 30, color: Colors.white),
                    );
                  },
                  cacheManager: CacheManager(
                    Config(
                      'notificationCacheKey',
                      stalePeriod: const Duration(days: 7),
                      maxNrOfCacheObjects: 100,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomTextStyles.titleMediumInterMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(height: 1.25),
                ),
                if (date != null && date!.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    date!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}