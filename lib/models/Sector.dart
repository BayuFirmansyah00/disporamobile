import '../config/config.dart'; // Pastikan import config

class Sector {
  final String id;
  final String name;
  final String iconUrl; // Ubah dari iconClass ke iconUrl
  final bool isAsset;

  Sector({
    required this.id,
    required this.name,
    required this.iconUrl,
    this.isAsset = false,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    final rawIcon = json['icon_url'] as String? ?? '';
    String iconUrl;

    if (rawIcon.isNotEmpty && rawIcon.startsWith('http')) {
      // Tambahkan /sectors/ ke URL
      iconUrl = rawIcon.replaceFirst(
          'http://10.0.2.2:8000/storage/',
          'http://10.0.2.2:8000/storage/sectors/'
      );
    } else {
      iconUrl = '';
    }

    // Debug
    print('Original Icon URL: $rawIcon');
    print('Constructed Icon URL: $iconUrl');

    return Sector(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Sector Tanpa Nama',
      iconUrl: iconUrl,
      isAsset: false,
    );
  }
}