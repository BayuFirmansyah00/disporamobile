import '../config/config.dart';

class Article {
  final String id;
  final String title;
  final String thumbnail;
  final String? description; // Tambah properti description

  Article({
    required this.id,
    required this.title,
    required this.thumbnail,
    this.description,
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
      thumbnailUrl = '';
    }

    print('Raw thumbnail from API: $rawThumbnail');
    print('Constructed thumbnail URL: $thumbnailUrl');

    return Article(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Artikel Tanpa Judul',
      thumbnail: thumbnailUrl,
      description: json['description']?.toString(),
    );
  }
}