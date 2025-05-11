import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../../core/app_export.dart';
import '../../../services/api_service.dart';
import '../../informasi_article.dart/informasi_article_screen.dart';
import '../../../models/Article.dart';

class RecentArticles extends StatelessWidget {
  final Article article;

  const RecentArticles({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Attempting to load article image: ${article.thumbnail}');
    return SizedBox(
      width: 152,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: article.thumbnail.isEmpty
                ? Container(
                    height: 100,
                    width: 152,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 50, color: Colors.white),
                  )
                : CachedNetworkImage(
                    imageUrl: article.thumbnail,
                    height: 100,
                    width: 152,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 100,
                      width: 152,
                      color: Colors.grey[300],
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) {
                      print('Error loading article image: $error, URL: $url');
                      return Container(
                        height: 100,
                        width: 152,
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
                    memCacheWidth: 152,
                    memCacheHeight: 100,
                    fadeInDuration: Duration.zero,
                  ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformasiArticleScreen(article: article),
                ),
              );
            },
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
                      article.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
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