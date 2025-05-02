import '../config/config.dart'; // Pastikan import config

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
    
    // Gunakan baseStorageUrl dari Config
    final fileName = Uri.parse(rawIcon).pathSegments.last;
    final fullUrl = '${Config.baseStorageUrl}/sectors/$fileName';

    // Debug
    print('Original Icon: $rawIcon');
    print('Processed URL: $fullUrl');

    return Sector(
      id: json['id'].toString(),
      name: json['name'] as String? ?? 'Sector Tanpa Nama',
      iconUrl: fullUrl,
      isAsset: false,
    );
  }
}