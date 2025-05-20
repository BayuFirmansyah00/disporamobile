import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../models/Article.dart';

class InformasiArticleScreen extends StatelessWidget {
  final Article data;

  const InformasiArticleScreen({Key? key, required this.data})
    : super(key: key);

  // Fungsi untuk menampilkan gambar dalam ukuran asli saat diklik
  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: const Color(0xFFF0F0F0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget:
                    (context, url, error) =>
                        const Icon(Icons.error, size: 100, color: Colors.white),
              ),
            ),
          ),
    );
  }

  // Formatter untuk updatedAt
  String? _formatUpdatedAt(Article data) {
    if (data.updatedAt == null) {
      print('updatedAt is null'); // Debug log
      return null;
    }
    try {
      return DateFormat('dd MMM yyyy, HH:mm').format(data.updatedAt!);
    } catch (e) {
      print('Error formatting updatedAt: $e'); // Debug log
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Debug log untuk memeriksa data
    print('InformasiArticleScreen data:');
    print('title: ${data.title}');
    print('thumbnail: ${data.thumbnail}');
    print('content: ${data.content}');
    print('createdAt: ${data.createdAt}');
    // print('formattedCreatedAt: ${data.formattedCreatedAt}');
    print('updatedAt: ${data.updatedAt}');

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 44.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tampilkan gambar dengan CachedNetworkImage
              if (data.thumbnail.isNotEmpty)
                GestureDetector(
                  onTap: () => _showFullImage(context, data.thumbnail),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CachedNetworkImage(
                      imageUrl: data.thumbnail,
                      height: 242.0,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Container(
                            height: 242.0,
                            width: double.maxFinite,
                            color: const Color(
                              0xFFE0E0E0,
                            ), // Ganti Colors.grey[300]
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      errorWidget: (context, url, error) {
                        print(
                          'Error loading image: $error, URL: $url, Error type: ${error.runtimeType}',
                        );
                        return Container(
                          height: 242.0,
                          width: double.maxFinite,
                          color: const Color(
                            0xFFE0E0E0,
                          ), // Ganti Colors.grey[300]
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.broken_image,
                                color: Color(0xFF757575),
                                size: 50,
                              ), // Ganti Colors.grey[600]
                              Text(
                                'Error: $error',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF757575),
                                ), // Ganti Colors.grey[600]
                              ),
                            ],
                          ),
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
                )
              else
                Container(
                  height: 242.0,
                  width: double.maxFinite,
                  color: const Color(0xFFE0E0E0), // Ganti Colors.grey[300]
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Color(0xFF757575),
                    size: 50,
                  ), // Ganti Colors.grey[600]
                ),
              const SizedBox(height: 16.0),
              // Judul
              Text(data.title, style: CustomTextStyles.titleMediumInter),
              const SizedBox(height: 8.0),
              // Tampilkan created_at
              // Text(
              //   'Dibuat pada: ${data.formattedCreatedAt ?? 'Tanggal tidak tersedia'}',
              //   style: CustomTextStyles.bodyMedium13.copyWith(color: const Color(0xFF757575)), // Ganti Colors.grey[600]
              // ),
              // // Tampilkan updated_at
              // Text(
              //   'Diperbarui pada: ${_formatUpdatedAt(data) ?? 'Tanggal tidak tersedia'}',
              //   style: CustomTextStyles.bodyMedium13.copyWith(color: const Color(0xFF757575)), // Ganti Colors.grey[600]
              // ),
              const SizedBox(height: 16.0),
              // Tampilkan deskripsi
              if (data.content != null && data.content!.isNotEmpty)
                Text(
                  'Deskripsi: ${data.content}',
                  style: CustomTextStyles.bodyMedium13.copyWith(height: 1.38),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                )
              else
                Text(
                  'Deskripsi: Tidak ada deskripsi',
                  style: CustomTextStyles.bodyMedium13.copyWith(height: 1.38),
                ),
              const SizedBox(height: 16.0),
              // Tampilkan konten
              // Text(
              //   'Isi artikel: ${data.content?.isNotEmpty == true ? data.content : 'Belum ada konten'}',
              //   style: CustomTextStyles.bodyMedium13,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => onTapArrowLeft(context),
      ),
      title: const Text(
        'INFORMASI ARTIKEL',
        style: TextStyle(letterSpacing: 2.0),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    );
  }

  /// Navigates back to the previous screen.
  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}