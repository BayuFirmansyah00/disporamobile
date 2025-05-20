import 'package:intl/intl.dart';
import '../config/config.dart';

class Article {
  final String id;
  final String title;
  final String thumbnail;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.thumbnail,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final rawThumbnail = json['thumbnail_url']?.toString() ?? '';
    String thumbnailUrl;

    if (rawThumbnail.isNotEmpty && rawThumbnail.startsWith('http')) {
      thumbnailUrl = rawThumbnail.replaceFirst(
        'http://10.0.2.2:8000/storage/',
        'http://10.0.2.2:8000/storage/article/thumbnails/',
      );
    } else {
      thumbnailUrl = 'https://via.placeholder.com/150';
    }

    print('Raw thumbnail from API: $rawThumbnail');
    print('Constructed thumbnail URL: $thumbnailUrl');

    DateTime? createdAt;
    DateTime? updatedAt;
    if (json['created_at'] != null) {
      createdAt = DateTime.tryParse(json['created_at'].toString());
      print('Parsed created_at: $createdAt');
    }
    if (json['updated_at'] != null) {
      updatedAt = DateTime.tryParse(json['updated_at'].toString());
      print('Parsed updated_at: $updatedAt');
    }

    return Article(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Artikel Tanpa Judul',
      thumbnail: thumbnailUrl,
      content: json['short_description']?.toString() ?? 'Tidak ada deskripsi tersedia',
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  String? get formattedCreatedAt {
    if (createdAt == null) {
      print('createdAt is null for formattedCreatedAt');
      return null;
    }
    try {
      return DateFormat('dd MMM yyyy, HH:mm').format(createdAt!);
    } catch (e) {
      print('Error formatting createdAt: $e');
      return null;
    }
  }

  String? get formattedUpdatedAt {
    if (updatedAt == null) {
      print('updatedAt is null for formattedUpdatedAt');
      return null;
    }
    try {
      return DateFormat('dd MMM yyyy, HH:mm').format(updatedAt!);
    } catch (e) {
      print('Error formatting updatedAt: $e');
      return null;
    }
  }
}