import '../config/config.dart';

class Event {
  final String id;
  final String title;
  final String thumbnail;
  final String description; // Properti baru untuk deskripsi

  Event({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final rawThumbnail = json['thumbnail']?.toString() ?? '';
    print('Raw thumbnail from API: $rawThumbnail'); // Debug log

    String thumbnailUrl;
    if (rawThumbnail.startsWith('http')) {
      thumbnailUrl = rawThumbnail;
    } else if (rawThumbnail.isNotEmpty) {
      thumbnailUrl = '${Config.baseStorageUrl}/event/thumbnails/$rawThumbnail';
      print('Attempting to load: $thumbnailUrl'); // Debug log
    } else {
      thumbnailUrl = '';
    }
    print('Constructed thumbnail URL: $thumbnailUrl'); // Debug log

    return Event(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? 'Event Tanpa Judul',
      thumbnail: thumbnailUrl,
      description: json['description']?.toString() ?? 'Tidak ada deskripsi', // Ambil deskripsi dari JSON
    );
  }
}