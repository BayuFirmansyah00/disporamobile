import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../models/Event.dart';

class InformasiEventScreen extends StatelessWidget {
  final Event data;

  const InformasiEventScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  // Fungsi untuk menampilkan gambar dalam ukuran asli saat diklik
  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFFF0F0F0),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error, size: 100, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // Formatter untuk updatedAt
  String? _formatUpdatedAt(Event data) {
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
    print('InformasiEventScreen data:');
    print('title: ${data.title}');
    print('thumbnail: ${data.thumbnail}');
    print('description: ${data.description}');
    print('location: ${data.location}');
    print('note: ${data.note}');
    print('createdAt: ${data.createdAt}');
    print('formattedCreatedAt: ${data.formattedCreatedAt}');
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
              const SizedBox(height: 16.0),
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
                      placeholder: (context, url) => Container(
                        height: 242.0,
                        width: double.maxFinite,
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) {
                        print('Error loading image: $error, URL: $url, Error type: ${error.runtimeType}');
                        return Container(
                          height: 242.0,
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
                          'customCacheKey',
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
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 50),
                ),
              const SizedBox(height: 16.0),
              // Judul
              Text(
                data.title,
                style: CustomTextStyles.titleMediumInter,
              ),
              const SizedBox(height: 8.0),
              // Tampilkan created_at
              Text(
                'Dibuat pada: ${data.formattedCreatedAt ?? 'Tanggal tidak tersedia'}',
                style: CustomTextStyles.bodyMedium13.copyWith(color: Colors.grey[600]),
              ),
              // Tampilkan updated_at
              Text(
                'Diperbarui pada: ${_formatUpdatedAt(data) ?? 'Tanggal tidak tersedia'}',
                style: CustomTextStyles.bodyMedium13.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16.0),
              // Tampilkan deskripsi
              if (data.description != null && data.description!.isNotEmpty)
                Text(
                  'Tentang acara ini: ${data.description}',
                  style: CustomTextStyles.bodyMedium13.copyWith(height: 1.38),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 16.0),
              // Tampilkan lokasi
              if (data.location != null && data.location!.isNotEmpty)
                Text(
                  'Berlangsung di: ${data.location}',
                  style: CustomTextStyles.bodyMedium13,
                ),
              const SizedBox(height: 16.0),
              // Tampilkan note
              if (data.note != null && data.note!.isNotEmpty)
                Text(
                  'Catatan: ${data.note}',
                  style: CustomTextStyles.bodyMedium13,
                ),
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
        onPressed: () => onTapArrowleftone(context),
      ),
      title: const Text(
        'INFORMASI EVENT',
        style: TextStyle(letterSpacing: 2.0),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    );
  }

  /// Navigates back to the previous screen.
  void onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}