class SectorModel {
  final String name;
  final String image;

  SectorModel({required this.name, required this.image});

  factory SectorModel.fromJson(Map<String, dynamic> json) {
    return SectorModel(
      name: json['nama'],
      image: json['icon_url'],
    );
  }
}