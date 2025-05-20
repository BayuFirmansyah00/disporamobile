import 'package:intl/intl.dart';

import '../config/config.dart';

class Event {
  final String id;
  final String title;
  final String thumbnail;
  final String? description;
  final String? location;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
    this.location,
    this.note,
    this.createdAt,
    this.updatedAt,
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

    DateTime? createdAt;
    DateTime? updatedAt;
    if (json['created_at'] != null) {
      createdAt = DateTime.tryParse(json['created_at']);
      print('Parsed created_at: $createdAt'); // Debug log
    }
    if (json['updated_at'] != null) {
      updatedAt = DateTime.tryParse(json['updated_at']);
      print('Parsed updated_at: $updatedAt'); // Debug log
    }

    return Event(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? 'Event Tanpa Judul',
      thumbnail: thumbnailUrl,
      description: json['description']?.toString() ?? 'Tidak ada deskripsi',
      location: json['location']?.toString(),
      note: json['note']?.toString(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

String? get formattedCreatedAt {
    if (createdAt == null) return null;
    try {
      return DateFormat('dd MMM yyyy, HH:mm').format(createdAt!);
    } catch (e) {
      print('Error formatting createdAt: $e'); // Debug log
      return null;
    }
  }
}