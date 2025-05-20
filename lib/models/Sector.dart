import '../config/config.dart';

class Sector {
  final String id;
  final String name;
  final String iconUrl;
  final bool isAsset;

  Sector({
    required this.id,
    required this.name,
    required this.iconUrl,
    this.isAsset = false,
  });

  factory Sector.fromJson(Map<String, dynamic> json) {
    final rawIcon = json['icon_url'] as String? ?? '';
    String iconUrl = rawIcon; // Gunakan URL asli tanpa modifikasi kecuali diperlukan

    // Hanya tambahkan /sectors/ jika URL sudah mengandung base storage URL
    if (rawIcon.isNotEmpty && rawIcon.startsWith(Config.baseStorageUrl)) {
      iconUrl = rawIcon.replaceFirst(Config.baseStorageUrl, '${Config.baseStorageUrl}/sectors/');
    }

    // Debugging
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