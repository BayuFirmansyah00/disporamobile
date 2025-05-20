import 'package:intl/intl.dart';
import '../config/config.dart';

class EventModel {
  final int id;
  final String title;
  final String image;
  final String? waktu;
  final String? description;
  final DateTime createdAt;

  EventModel({
    required this.id,
    required this.title,
    required this.image,
    this.waktu,
    this.description,
    required this.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['thumbnail']?.toString() ?? '';
    String imageUrl;

    if (rawImage.startsWith('http')) {
      imageUrl = rawImage;
    } else if (rawImage.isNotEmpty) {
      imageUrl = '${Config.baseStorageUrl}/event/thumbnails/$rawImage';
      print('Attempting to load event image: $imageUrl');
    } else {
      imageUrl = 'https://via.placeholder.com/150';
    }

    DateTime createdAt;
    try {
      createdAt = DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now();
    } catch (e) {
      print('Error parsing created_at: $e');
      createdAt = DateTime.now();
    }

    return EventModel(
      id: json['id'] as int? ?? 0,
      title: json['title']?.toString() ?? 'Event Tanpa Judul',
      image: imageUrl,
      waktu: json['event_date']?.toString(),
      description: json['description']?.toString() ?? 'Tidak ada deskripsi',
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'waktu': waktu,
      'description': description,
      'createdAt': createdAt.toString(),
    };
  }

  String? get formattedCreatedAt {
    try {
      return DateFormat('dd MMM yyyy, HH:mm').format(createdAt);
    } catch (e) {
      print('Error formatting createdAt: $e');
      return null;
    }
  }
}