import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/home_sector_model.dart';
import '../../../models/event_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../notifikasi_screen/notifikasi_screen.dart';
import '../../services/api_service.dart';
import '../sektor_screen/sektor_screen.dart';
import '../subsektor_screen/subsektor_screen.dart';
import '../informasi_event_screen/informasi_event_screen.dart';
import '../../../models/Event.dart';
import '../../../models/Article.dart';
import '../../../models/Sector.dart';
import '../home_screen/widgets/RecentArticles.dart';
import '../home_screen/widgets/RecentEvents.dart';
import '../home_screen/widgets/SectorsGrid.dart';
import '../../../config/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.h,
      decoration: AppDecoration.fillOnPrimary,
      child: Column(
        children: [
          // AppBar tetap di atas
          CustomAppBar(
            height: 60.h,
            title: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: AppbarTitle(text: 'EkrafKüy'),
            ),
            actions: [
              AppbarTrailingIconButton(
                imagePath: ImageConstant.notif,
                margin: EdgeInsets.only(right: 17.h, bottom: 2.h),
                onTap: () {
                  onTapBellone(context);
                },
                width: 60,
                height: 60,
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  _buildCreativeEconomySection(context),
                  SizedBox(height: 10.h),
                  _buildCreativeCategories(context),
                  SizedBox(height: 10.h),
                  _buildLatestEvents(context),
                  SizedBox(height: 12.h),
                  _buildLatestArticels(context),
                  SizedBox(height: 10.h),
                  // SizedBox(height: 54.h),
                  // _buildHighlightedArticles(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal membuka tautan')));
    }
  }

  Widget _buildCreativeEconomySection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 18.h),
      decoration: AppDecoration.gradientOnPrimaryContainerToBlue.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Stack(
        children: [
          // Teks dan tombol di kiri
          Padding(
            padding: EdgeInsets.only(left: 20.h, top: 20.h, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.h, // Lebih lebar agar teks tidak terpotong
                  child: Text(
                    'EKONOMI KREATIF KABUPATEN NGANJUK IKI WOOO',
                    maxLines: 3,
                    style: CustomTextStyles.titleSmallMontserratOnPrimary
                        .copyWith(height: 1.3),
                  ),
                ),
                SizedBox(height: 10.h),
                CustomOutlinedButton(
                  height: 30.h, // Ukuran tombol lebih besar
                  width: 160.h,
                  text: 'Kunjungi situs website kami',
                  buttonStyle: CustomButtonStyles.outlineOnPrimary,
                  buttonTextStyle: CustomTextStyles.montserratOnPrimary
                      .copyWith(fontSize: 9),
                  onPressed: () {
                    _launchURL('https://github.com/ainsley215');
                  },
                ),
              ],
            ),
          ),
          // Gambar di kanan
          Positioned(
            right: -20.h,
            bottom: -30,
            child: CustomImageView(
              imagePath: ImageConstant.nganjuk,
              height: 180.h, // Sesuaikan ukuran dengan desain
              width: 200.h,
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Sector>> fetchSectors() async {
    try {
      // Gunakan endpoint dari Config
      final response = await ApiService.get(Config.sectorsEndpoint);

      final jsonMap = response as Map<String, dynamic>;
      print('Response API: $jsonMap');

      // Asumsikan response format: { "sectors": [...] }
      final List<dynamic> rawList = (jsonMap['sectors'] ?? []) as List<dynamic>;

      return rawList
          .map<Sector>((item) => Sector.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching sectors: $e');
      throw Exception('Gagal memuat data sektor: ${e.toString()}');
    }
  }

  Widget _buildCreativeCategories(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 22.h, right: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text('Sektor', style: CustomTextStyles.titleMediumSemiBold),
          ),
          SizedBox(height: 20.h),

          FutureBuilder<List<Sector>>(
            future: fetchSectors(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("Tidak ada kategori tersedia."));
              } else {
                final sectors = snapshot.data!;
                final displayedSectors = sectors.take(9).toList();
                displayedSectors.add(
                  Sector(
                    id: 'lainnya',
                    name: 'Lainnya',
                    iconUrl: 'assets/images/lainnya.png',
                    isAsset: true,
                  ),
                );

                return Wrap(
                  spacing: 22.h,
                  runSpacing: 20.h,
                  children:
                      displayedSectors.map((sector) {
                        return GestureDetector(
                          onTap: () {
                            if (sector.name == "Lainnya") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SektorScreen(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => SubsektorScreen(
                                        sector: {
                                          'id': sector.id.toString(),
                                          'name': sector.name,
                                          'imagePath': sector.iconUrl,
                                        },
                                      ),
                                ),
                              );
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 50.h,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child:
                                      sector.isAsset
                                          ? Image.asset(
                                            sector.iconUrl,
                                            fit: BoxFit.contain,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              print(
                                                'Error loading asset image: ${sector.iconUrl}',
                                              );
                                              return Icon(
                                                Icons.category,
                                                color: Colors.grey,
                                              );
                                            },
                                          )
                                          : Image.network(
                                            sector.iconUrl,
                                            fit: BoxFit.contain,
                                            headers: {
                                              "Accept": "image/*",
                                            }, // Tambahkan headers jika perlu
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              print(
                                                'Error loading network image: ${sector.iconUrl}',
                                              );
                                              print('Error details: $error');
                                              return Icon(
                                                Icons.image_not_supported,
                                                color: Colors.grey,
                                              );
                                            },
                                            loadingBuilder: (
                                              context,
                                              child,
                                              loadingProgress,
                                            ) {
                                              if (loadingProgress == null)
                                                return child;
                                              return CircularProgressIndicator();
                                            },
                                          ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                sector.name,
                                style: TextStyle(fontSize: 12.h),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  //ini bagian event
  Future<List<Event>> fetchEvents() async {
    try {
      // Menggunakan endpoint dari Config
      final result = await ApiService.get(Config.eventsEndpoint);
      print('Raw API Response: ${jsonEncode(result)}');

      List<dynamic> rawList = [];

      // Handle berbagai struktur response
      if (result is Map<String, dynamic>) {
        if (result['data'] is Map && result['data']['data'] is List) {
          rawList = result['data']['data'] as List<dynamic>;
        } else if (result['events'] is List) {
          rawList = result['events'] as List<dynamic>;
        }
      } else if (result is List) {
        rawList = result;
      }

      return rawList.map((item) {
        return Event.fromJson(item as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error fetching events: $e');
      throw Exception('Gagal memuat event: ${e.toString()}');
    }
  }

  //event terbaru
  Widget _buildLatestEvents(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 22.h, right: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              'Event Terbaru',
              style: CustomTextStyles.titleMediumSemiBold,
            ),
          ),
          SizedBox(height: 20.h),
          FutureBuilder<List<Event>>(
            future: fetchEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoading();
              }

              if (snapshot.hasError) {
                return _buildError(snapshot.error.toString());
              }

              final events = snapshot.data ?? [];
              if (events.isEmpty) {
                return _buildEmpty();
              }

              return _buildEventList(events);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildError(String error) => Column(
    children: [
      Icon(Icons.error_outline, color: Colors.red),
      SizedBox(height: 8),
      Text('Gagal memuat event: $error', style: TextStyle(color: Colors.red)),
    ],
  );

  Widget _buildEmpty() => Column(
    children: [
      Icon(Icons.event_busy, color: Colors.grey),
      SizedBox(height: 8),
      Text('Belum ada event saat ini', style: TextStyle(color: Colors.grey)),
    ],
  );

  Widget _buildEventList(List<Event> events) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children:
          events
              .map(
                (event) => Padding(
                  padding: EdgeInsets.only(right: 16.h),
                  child: RecentEvents(
                    imageUrl: event.thumbnail,
                    title: event.title,
                    onTapRowsunglasses: () => _onEventTap(context, event),
                  ),
                ),
              )
              .toList(),
    ),
  );

  Future<List<Article>> fetchArticles() async {
    try {
      // Gunakan endpoint dari Config
      final result = await ApiService.get(Config.articlesEndpoint);
      print('Raw API Response: ${jsonEncode(result)}');

      List<dynamic> rawList = [];

      // Validasi struktur response
      if (result is Map<String, dynamic>) {
        if (result['data'] is Map && result['data']['data'] is List) {
          rawList = result['data']['data'] as List<dynamic>;
        } else if (result['events'] is List) {
          rawList = result['events'] as List<dynamic>;
        }
      } else if (result is List) {
        rawList = result;
      }

      return rawList.map((item) {
          return Article.fromJson(item as Map<String, dynamic>);
      }).toList();
        } catch (e) {
        print('Error fetching articles: $e');
        throw Exception('Gagal memuat artikel: ${e.toString()}');
        }
  }
  //artikel terbaru
  Widget _buildLatestArticels(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 22.h, right: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              'Artikel Terbaru',
              style: CustomTextStyles.titleMediumSemiBold,
            ),
          ),
          SizedBox(height: 20.h),
          FutureBuilder<List<Article>>(
            future: fetchArticles(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingArticle();
              }

              if (snapshot.hasError) {
                return _buildErrorArticle(snapshot.error.toString());
              }

              final articles = snapshot.data ?? [];
              if (articles.isEmpty) {
                return _buildEmptyArticle();
              }

              return _buildArticleList(articles);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArticleList(List<Article> articles) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children:
          articles
              .map(
                (article) => Padding(
                  padding: EdgeInsets.only(right: 16.h),
                  child: RecentArticles(
                    imageUrl: article.thumbnail,
                    title: article.title,
                    onTapSektorunggulan: () => _onArticleTap(context, article),
                  ),
                ),
              )
              .toList(),
    ),
  );

  // Reuse existing helper widgets dari event
  Widget _buildLoadingArticle() => Center(child: CircularProgressIndicator());

  Widget _buildErrorArticle(String error) => Column(
    children: [
      Icon(Icons.error_outline, color: Colors.red),
      SizedBox(height: 8),
      Text('Gagal memuat artikel: $error', style: TextStyle(color: Colors.red)),
    ],
  );

  Widget _buildEmptyArticle() => Column(
    children: [
      Icon(Icons.article_outlined, color: Colors.grey),
      SizedBox(height: 8),
      Text('Belum ada artikel terbaru', style: TextStyle(color: Colors.grey)),
    ],
  );

  //Navigation to the notfikasiScreen when the action is triggered
  void onTapBellone(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotifikasiScreen()),
    );
    // Navigator.pushNamed(context, AppRoutes.notifikasiScreen);
  }

  //Navigation to the infoEventScreen when the action is triggered
  void _onEventTap(BuildContext context, Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InformasiEventScreen(event: event)),
    );
  }

  void _onArticleTap(BuildContext context, Article article) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => InformasiArticleScreen(article: article)),
    // );
  }

  void onTapKategori(BuildContext context, Map<String, String> sector) {
    final title = sector["title"];

    if (title == "Lainnya") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SektorScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubsektorScreen(sector: sector),
        ),
      );
    }
  }
}
