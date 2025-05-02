import '../config/config.dart';

class Event {
  final String id;
  final String title;
  final String thumbnail;

  Event({required this.id, required this.title, required this.thumbnail});

  factory Event.fromJson(Map<String, dynamic> json) {
    final rawThumbnail = json['thumbnail']?.toString() ?? '';

    final fileName = Uri.parse(rawThumbnail).pathSegments.last;
    final thumbnailUrl = '${Config.baseStorageUrl}/events/$fileName';

    return Event(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? 'Event Tanpa Judul',
      thumbnail: thumbnailUrl,
    );
  }
}