import '../config/config.dart';

class EventModel {
  final int id;
  final String title;
  final String image;
  final String? waktu;
  final String? description;

  EventModel({
    required this.id,
    required this.title,
    required this.image,
    this.waktu,
    this.description,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['thumbnail']?.toString() ?? '';
    String imageUrl;
    if (rawImage.startsWith('http')) {
      imageUrl = rawImage;
    } else if (rawImage.isNotEmpty) {
      imageUrl = '${Config.baseStorageUrl}/event/thumbnails/$rawImage';
      print('Attempting to load: $imageUrl'); // Debug log
    } else {
      imageUrl = '';
    }
    print('Raw image from API: $rawImage');
    print('Constructed image URL: $imageUrl');

    return EventModel(
      id: json['id'] as int? ?? 0,
      title: json['title']?.toString() ?? 'Event Tanpa Judul',
      image: imageUrl,
      waktu: json['event_date']?.toString(),
      description: json['description']?.toString(),
    );
  }
}