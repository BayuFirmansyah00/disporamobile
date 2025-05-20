import 'package:ekraf_kuy/models/Sector.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'widgets/sektor_grid.dart';
import '../../models/sektor_sektor_model.dart';
import '../pelaku_usaha_screen/pelaku_usaha_screen.dart';

class SektorScreen extends StatefulWidget {
  const SektorScreen({super.key});

  @override
  _SektorScreenState createState() => _SektorScreenState();
}

class _SektorScreenState extends State<SektorScreen> {
  List<Sector> sectors = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchSectors();
  }

  Future<void> fetchSectors() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/sectors'));
      if (response.statusCode == 200) {
        final dynamic decodedResponse = jsonDecode(response.body);
        List<dynamic> data;

        // Handle both list and map responses, prioritizing 'sectors' key
        if (decodedResponse is List) {
          data = decodedResponse;
        } else if (decodedResponse is Map && decodedResponse.containsKey('sectors')) {
          data = decodedResponse['sectors'];
        } else if (decodedResponse is Map && decodedResponse.containsKey('data')) {
          data = decodedResponse['data'];
        } else {
          throw Exception('Unexpected response format: $decodedResponse');
        }

        print('Fetched sectors: $data'); // Debugging
        setState(() {
          sectors = data.map((json) => Sector.fromJson(json)).toList();
          isLoading = false;
        });
        print('Sector names: ${sectors.map((s) => s.name).toList()}'); // Debugging
      } else {
        throw Exception('Failed to load sectors: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching sectors: $e');
      setState(() {
        isLoading = false;
        errorMessage = 'Gagal memuat data sektor: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Semua Sektor")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildKategori("Seni dan Desain Visual", sectors.where((s) => [
                            'fotografi',
                            'seni rupa',
                            'desain interior',
                            'dkv',
                            'produk',
                          ].map((e) => e.trim().toLowerCase()).contains(s.name.trim().toLowerCase())).toList()),
                      SizedBox(height: 16),
                      buildKategori("Media dan Hiburan", sectors.where((s) => [
                            'film',
                            'televisi dan radio',
                            'pertunjukan',
                            'musik',
                          ].map((e) => e.trim().toLowerCase()).contains(s.name.trim().toLowerCase())).toList()),
                      SizedBox(height: 16),
                      buildKategori("Produk Kreatif dan Industri", sectors.where((s) => [
                            'game',
                            'aplikasi',
                          ].map((e) => e.trim().toLowerCase()).contains(s.name.trim().toLowerCase())).toList()),
                      SizedBox(height: 16),
                      buildKategori("Arsitektur dan Kriya", sectors.where((s) => [
                            'arsitektur',
                            'kriya',
                          ].map((e) => e.trim().toLowerCase()).contains(s.name.trim().toLowerCase())).toList()),
                      SizedBox(height: 16),
                      buildKategori("Fashion dan Kuliner", sectors.where((s) => [
                            'fashion',
                            'kuliner',
                          ].map((e) => e.trim().toLowerCase()).contains(s.name.trim().toLowerCase())).toList()),
                      SizedBox(height: 16),
                      buildKategori("Periklanan dan Penerbitan", sectors.where((s) => [
                            'periklanan',
                            'penerbitan',
                          ].map((e) => e.trim().toLowerCase()).contains(s.name.trim().toLowerCase())).toList()),
                    ],
                  ),
                ),
    );
  }

  Widget buildKategori(String title, List<Sector> items) {
    print('Kategori $title - Items: ${items.map((s) => s.name).toList()}'); // Debugging
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        items.isEmpty
            ? Text(
                'Tidak ada data untuk kategori ini',
                style: TextStyle(color: Colors.grey),
              )
            : SektorGrid(sectorList: items),
      ],
    );
  }
}