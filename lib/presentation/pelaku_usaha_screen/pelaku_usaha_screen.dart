import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/businesslist_item_widget.dart';
import '../../models/BusinessModel.dart';
import '../../widgets/custom_search_view.dart'; // Ensure this is the correct path to CustomSearchView
import '../../services/api_service.dart';
import '../informasi_usaha_screen/informasi_usaha_screen.dart';

class PelakuUsahaScreen extends StatefulWidget {
  final int sectorId;

  const PelakuUsahaScreen({Key? key, required this.sectorId}) : super(key: key);

  @override
  State<PelakuUsahaScreen> createState() => _PelakuUsahaScreenState();
}

class _PelakuUsahaScreenState extends State<PelakuUsahaScreen> {
  final TextEditingController searchController = TextEditingController();
  List<BusinessModel> listUsaha = [];
  List<BusinessModel> filteredListUsaha = [];
  Map<int, Map<String, String>> sectorDetails = {};
  bool isLoading = false;
  bool isLoadingMore = false;
  String errorMessage = '';
  int currentPage = 1;
  int perPage = 10;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    fetchSectors();
    fetchData();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchSectors() async {
    try {
      final response = await ApiService.get("sectors");
      if (response is Map<String, dynamic> && response.containsKey('sectors')) {
        final sectors = response['sectors'] as List;
        setState(() {
          sectorDetails = {
            for (var sector in sectors)
              sector['id']: {
                'name': sector['name'] as String,
                'description': sector['description'] as String,
              }
          };
          print('Sector Details: $sectorDetails');
        });
      }
    } catch (e) {
      print('Gagal memuat data sektor: $e');
    }
  }

  void _onSearchChanged() {
    setState(() {
      filteredListUsaha = listUsaha
          .where((usaha) => usaha.namaUsaha
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchData({bool isLoadMore = false}) async {
    if (isLoading || (isLoadMore && !hasMoreData)) return;

    setState(() {
      if (isLoadMore) {
        isLoadingMore = true;
      } else {
        isLoading = true;
      }
    });

    try {
      final response = await ApiService.get(
        "business?sector=${widget.sectorId}&page=$currentPage&per_page=$perPage${searchController.text.isNotEmpty ? '&search=${searchController.text}' : ''}",
      );
      print('Response: $response');

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final data = response['data'] as List;
        if (data.isEmpty && response['total'] > 0) {
          print('Data kosong tetapi total: ${response['total']}');
        }
        // Ubah ke async karena BusinessModel.fromJson adalah Future
        final newData = <BusinessModel>[];
        for (var e in data) {
          final sectorDesc = sectorDetails[widget.sectorId]?['description'] ??
              'Sektor ID: ${widget.sectorId}';
          final business = await BusinessModel.fromJson(
            e,
            sectorName: sectorDesc,
            sectorId: widget.sectorId,
          );
          newData.add(business);
        }

        setState(() {
          if (isLoadMore) {
            listUsaha.addAll(newData);
          } else {
            listUsaha = newData;
          }
          filteredListUsaha = listUsaha
              .where((usaha) => usaha.namaUsaha
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
              .toList();
          hasMoreData = data.length == perPage;
          currentPage++;
          isLoading = false;
          isLoadingMore = false;
          errorMessage = filteredListUsaha.isEmpty
              ? 'Tidak ada data untuk sektor ${widget.sectorId}.'
              : '';
        });
      } else {
        setState(() {
          listUsaha = [];
          filteredListUsaha = [];
          isLoading = false;
          isLoadingMore = false;
          errorMessage = 'Respons API tidak sesuai format yang diharapkan.';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isLoadingMore = false;
        errorMessage = 'Gagal memuat data: $e';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        title: const Text("Pelaku Usaha"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: CustomSearchView(
                  controller: searchController,
                  hintText: "Cari nama usaha",
                  contentPadding: const EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 10.0),
                  prefix: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.search, size: 24.0),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredListUsaha.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  errorMessage.isNotEmpty
                                      ? errorMessage
                                      : "Tidak ada data.",
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    currentPage = 1;
                                    hasMoreData = true;
                                    fetchData();
                                  },
                                  child: const Text('Refresh'),
                                ),
                              ],
                            ),
                          )
                        : NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (!isLoadingMore &&
                                  hasMoreData &&
                                  scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                fetchData(isLoadMore: true);
                              }
                              return false;
                            },
                            child: ListView.separated(
                              itemCount:
                                  filteredListUsaha.length + (isLoadingMore ? 1 : 0),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 18.0),
                              itemBuilder: (context, index) {
                                if (index == filteredListUsaha.length) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return BusinesslistItemWidget(
                                  bisnis: filteredListUsaha[index],
                                  onTapColumnlineone: () {
                                    onTapColumnLineone(
                                        context, filteredListUsaha[index]);
                                  },
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapColumnLineone(BuildContext context, BusinessModel dataUsaha) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InformasiUsahaScreen(dataUsaha: dataUsaha),
      ),
    );
  }
}