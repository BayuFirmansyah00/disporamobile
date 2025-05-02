class ProdukModel {
  final String nama;
  final String harga;
  final String informasi;

  ProdukModel({
    required this.nama,
    required this.harga,
    required this.informasi,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      nama: json['nama'] ?? '',
      harga: json['harga'].toString(),
      informasi: json['informasi'] ?? '',
    );
  }
}