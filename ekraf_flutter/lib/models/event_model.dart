class EventModel {
  final int id;
  final String title;
  final String image;
  final String? waktu;

  EventModel({
    required this.id,
    required this.title,
    required this.image,
    this.waktu,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['judul'],
      image: json['poster_url'],
      waktu: json['waktu'],
    );
  }
}