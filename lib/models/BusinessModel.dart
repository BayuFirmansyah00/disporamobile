import 'package:flutter/material.dart';
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
  final double? longitude; // Tambahkan untuk maps

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
    this.longitude,
  });

  static Future<BusinessModel> fromJson(
    Map<String, dynamic> json, {
    String sectorName = '',
    required int sectorId,
  }) async {
    print('JSON Response: $json');
    final profile = json['profile'] as String? ?? '';
    final logoUrl = profile.isNotEmpty && profile.startsWith('http')
        ? profile
        : '${Config.baseStorageUrl}/pelaku_usaha/$profile';
    final fotoPemilik = profile.isNotEmpty && profile.startsWith('http')
        ? profile
        : '${Config.baseStorageUrl}/pelaku_usaha/$profile';

    // Ambil produk dari API
    final productResponse = await http.get(
      Uri.parse('${Config.baseApiUrl}/products/${json['id']}'),
    );
    List<ProdukModel> produkList = [];
    if (productResponse.statusCode == 200) {
      final data = jsonDecode(productResponse.body);
      final productsJson = data['data'] ?? [];
      produkList = (productsJson as List)
          .map((productJson) => ProdukModel.fromJson(productJson))
          .toList();
      print('Produk ditemukan: $produkList'); // Debug
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
      noHp: json['phone'] ?? null, // Tambahkan jika ada field phone
      alamat: json['location'] ?? null,
      modePemesanan: null,
      daftarProduk: produkList,
      sectorId: sectorId,
      id: json['id'] ?? 0,
      latitude: json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
    );
  }
}