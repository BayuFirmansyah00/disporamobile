class SectorModel {
  final String name;
  final String image;
  final int id;

  SectorModel({required this.name, required this.image, required this.id});

  factory SectorModel.fromJson(Map<String, dynamic> json) {
    return SectorModel(
      name: json['nama'],
      image: json['icon_url'],
      id: json['id'],
    );
  }
}