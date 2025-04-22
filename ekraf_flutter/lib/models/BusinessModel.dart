// class BusinessModel {
//   final String namaUsaha;
//   final String logoUrl;
//   final String sektor;
//   final String subsektor;
//   final String namaPemilik;

//   BusinessModel({
//     required this.namaUsaha,
//     required this.logoUrl,
//     required this.sektor,
//     required this.subsektor,
//     required this.namaPemilik,
//   });

//   factory BusinessModel.fromJson(Map<String, dynamic> json) {
//     return BusinessModel(
//       namaUsaha: json['nama_toko'],
//       logoUrl: json['logo_url'],
//       sektor: json['sektor'] ?? '',
//       subsektor: json['subsektor'] ?? '',
//       namaPemilik: (json['pengusaha'] != null && json['pengusaha'].isNotEmpty)
//           ? json['pengusaha'][0]['nama']
//           : 'Tidak diketahui',
//     );
//   }
// }

// class BusinessModel {
//   final String namaUsaha;
//   final String logoUrl;
//   final String sektor;
//   final String subsektor;
//   final String namaPemilik;
//   final String fotoPemilik; // <-- tambahkan ini

//   BusinessModel({
//     required this.namaUsaha,
//     required this.logoUrl,
//     required this.sektor,
//     required this.subsektor,
//     required this.namaPemilik,
//     required this.fotoPemilik, // <-- tambahkan ini
//   });

//   factory BusinessModel.fromJson(Map<String, dynamic> json) {
//     final pengusaha = (json['pengusaha'] != null &&
//             json['pengusaha'] is List &&
//             json['pengusaha'].isNotEmpty)
//         ? json['pengusaha'][0]
//         : null;

//     return BusinessModel(
//       namaUsaha: json['nama_toko'] ?? 'Tidak diketahui',
//       logoUrl: json['logo_url'] ?? '',
//       sektor: json['sektor'] ?? '',
//       subsektor: json['subsektor'] ?? '',
//       namaPemilik: pengusaha?['nama'] ?? 'Tidak diketahui',
//       fotoPemilik: pengusaha?['foto_url'] ?? '', // <-- ambil foto_url
//     );
//   }
// }

class BusinessModel {
  final String namaUsaha;
  final String logoUrl;
  final String sektor;
  final String subsektor;
  final String namaPemilik;
  final String? fotoPemilik;
  final String? noHp;
  final String? alamat;
  final String? modePemesanan;
  final String? namaProduk;
  final String? hargaProduk;
  final String? informasiProduk;

  BusinessModel({
    required this.namaUsaha,
    required this.logoUrl,
    required this.sektor,
    required this.subsektor,
    required this.namaPemilik,
    this.fotoPemilik,
    this.noHp,
    this.alamat,
    this.modePemesanan,
    this.namaProduk,
    this.hargaProduk,
    this.informasiProduk,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      namaUsaha: json['nama_toko'],
      logoUrl: json['logo_url'] ?? '',
      sektor: json['sektor'] ?? '',
      subsektor: json['subsektor'] ?? '',
      namaPemilik: json['pengusaha'] != null && json['pengusaha'].isNotEmpty
          ? json['pengusaha'][0]['nama']
          : 'Tidak diketahui',
      fotoPemilik: json['pengusaha'] != null && json['pengusaha'].isNotEmpty
          ? json['pengusaha'][0]['foto_url']
          : null,
      noHp: json['no_hp'],
      alamat: json['alamat'],
      modePemesanan: json['mode_pemesanan'],
      namaProduk: json['produk'] != null && json['produk'].isNotEmpty
          ? json['produk'][0]['nama']
          : null,
      hargaProduk: json['produk'] != null && json['produk'].isNotEmpty
          ? json['produk'][0]['harga'].toString()
          : null,
      informasiProduk: json['produk'] != null && json['produk'].isNotEmpty
          ? json['produk'][0]['informasi']
          : null,
    );
  }
}