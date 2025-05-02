import '../config/config.dart';

class Article {
  final String id;
  final String title;
  final String thumbnail;

  Article({required this.id, required this.title, required this.thumbnail,});

  factory Article.fromJson(Map<String, dynamic> json) {
    final rawThumbnail = json['thumbnail']?.toString() ?? '';

    final fileName = Uri.parse(rawThumbnail).pathSegments.last;
    final thumbnailUrl = '${Config.baseStorageUrl}/articles/$fileName';

    return Article(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? 'Artikel Tanpa Judul',
      thumbnail: thumbnailUrl,
    );
  }
}