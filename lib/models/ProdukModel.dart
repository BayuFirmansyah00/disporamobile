class ProdukModel {
  final String nama;
  final String harga;
  final String informasi;
  final String photo;

  ProdukModel({
    required this.nama,
    required this.harga,
    required this.informasi,
    required this.photo,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      nama: json['name'] ?? '',
      harga: json['price'].toString(),
      informasi: json['detail'] ?? '',
      photo: json['photo'] ?? 'contohproduk.png',
    );
  }
}