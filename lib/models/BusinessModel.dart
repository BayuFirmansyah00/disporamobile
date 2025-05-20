import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/ProdukModel.dart';
import '../../config/Config.dart';

class BusinessModel {
  final String namaUsaha;
  final String logoUrl;
  final String sektor;
  final String sectorName;
  final String subsektor;
  final String namaPemilik;
  final String? fotoPemilik;
  final String? noHp;
  final String? alamat;
  final String? modePemesanan;
  final List<ProdukModel> daftarProduk;
  final int sectorId;
  final int id;
  final double? latitude;
  final double? longitude;

  BusinessModel({
    required this.namaUsaha,
    required this.logoUrl,
    required this.sektor,
    required this.sectorName,
    required this.subsektor,
    required this.namaPemilik,
    this.fotoPemilik,
    this.noHp,
    this.alamat,
    this.modePemesanan,
    required this.daftarProduk,
    required this.sectorId,
    required this.id,
    this.latitude,
    this.longitude, required String description,
  });

  static Future<BusinessModel> fromJson(
    Map<String, dynamic> json, {
    String sectorName = '',
    required int sectorId,
  }) async {
    print('JSON Response untuk bisnis: $json');
    final businessId = json['id'] ?? 0;
    print('Business ID: $businessId');
    final profile = json['profile'] as String? ?? '';
    final logoUrl = profile.isNotEmpty && profile.startsWith('http')
        ? profile
        : '${Config.baseStorageUrl}/pelaku_usaha/$profile';
    final fotoPemilik = profile.isNotEmpty && profile.startsWith('http')
        ? profile
        : '${Config.baseStorageUrl}/pelaku_usaha/$profile';

    // Validasi latitude dan longitude
    double? latitude;
    double? longitude;
    if (json['latitude'] != null) {
      final lat = double.tryParse(json['latitude'].toString());
      if (lat != null && lat >= -90 && lat <= 90) {
        latitude = lat;
      }
    }
    if (json['longitude'] != null) {
      final lon = double.tryParse(json['longitude'].toString());
      if (lon != null && lon >= -180 && lon <= 180) {
        longitude = lon;
      }
    }

    // Ambil produk dari API
    final productUrl = '${Config.baseApiUrl}/business-products/$businessId';
    print('Mengambil produk dari: $productUrl');
    final productResponse = await http.get(
      Uri.parse(productUrl),
    );
    List<ProdukModel> produkList = [];
    if (productResponse.statusCode == 200) {
      final data = jsonDecode(productResponse.body);
      print('Respons produk: $data');
      final productsJson = data['data'] ?? [];
      produkList = (productsJson as List)
          .map((productJson) => ProdukModel.fromJson(productJson))
          .toList();
      print('Produk ditemukan: ${produkList.length} item');
      if (produkList.isNotEmpty) {
        print('Detail produk pertama: ${produkList[0].nama}');
      }
    } else {
      print('Gagal mengambil produk: ${productResponse.statusCode} - ${productResponse.body}');
    }

    return BusinessModel(
      namaUsaha: json['business_name'] ?? 'Tidak diketahui',
      logoUrl: logoUrl,
      sektor: sectorName.isNotEmpty ? sectorName : 'Sektor ID: $sectorId',
      sectorName: sectorName,
      subsektor: '',
      namaPemilik: json['owner_name'] ?? 'Tidak diketahui',
      fotoPemilik: fotoPemilik,
      noHp: json['phone'] ?? null,
      alamat: json['location'] ?? null,
      modePemesanan: null,
      daftarProduk: produkList,
      sectorId: sectorId,
      id: businessId,
      latitude: latitude,
      longitude: longitude,
      description: json['description'] ?? '',
    );
  }
}