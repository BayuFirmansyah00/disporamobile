import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../models/Article.dart';

class InformasiArticleScreen extends StatelessWidget {
  final Article article;

  const InformasiArticleScreen({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 44.h, top: 4.h, right: 44.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.h),
                child: article.thumbnail.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: article.thumbnail,
                        height: 242.h,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 242.h,
                          width: double.maxFinite,
                          color: Colors.grey[300],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) {
                          print('Error loading image: $error, URL: $url, Error type: ${error.runtimeType}');
                          return Container(
                            height: 242.h,
                            width: double.maxFinite,
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
                        cacheManager: CacheManager(
                          Config(
                            'articleCacheKey',
                            stalePeriod: Duration(days: 7),
                            maxNrOfCacheObjects: 100,
                          ),
                        ),
                      )
                    : Container(
                        height: 242.h,
                        width: double.maxFinite,
                        color: Colors.grey[300],
                        child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 50),
                      ),
              ),
              Text(
                article.title,
                style: CustomTextStyles.titleMediumInter,
              ),
              Text(
                article.description ?? 'Tidak ada deskripsi',
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodyMedium13.copyWith(height: 1.38),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 20.h),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarSubtitle(
        text: "Informasi Artikel",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  /// Navigates back to the previous screen.
  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}