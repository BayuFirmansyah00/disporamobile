import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/Event.dart';
import '../../../models/Article.dart';
import '../../../models/Sector.dart';
import '../home_screen/widgets/RecentArticles.dart';
import '../home_screen/widgets/RecentEvents.dart';
import '../home_screen/widgets/SectorsGrid.dart';
import '../../../config/config.dart';
import '../login_screen/login_page.dart';
import '../../services/api_service.dart';
import '../notifikasi_screen/notifikasi_screen.dart';
import '../sektor_screen/sektor_screen.dart';
import '../pelaku_usaha_screen/pelaku_usaha_screen.dart';
import '../informasi_event_screen/informasi_event_screen.dart';
import '../chat_screen/ChatScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<Event>> _eventsFuture;
  bool _isLoggedIn = false;
  String? _userRole;

  @override
  void initState() {
    super.initState();
    _eventsFuture = fetchEvents();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userRole = prefs.getString('user_role');
    setState(() {
      _isLoggedIn = token != null && token.isNotEmpty;
      _userRole = userRole;
    });
  }

  // Fungsi navigasi ke ChatScreen dengan pengecekan autentikasi lebih lengkap dan debugPrint
  void onTapChat(BuildContext context) async {
    if (_isLoggedIn) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final userRole = prefs.getString('user_role');
      final userId = prefs.getInt('user_id');
      debugPrint('Navigating to ChatScreen: token=$token, role=$userRole, userId=$userId');
      if (token == null || userRole == null || userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data autentikasi tidak lengkap. Silakan login ulang.')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan login untuk mengakses chat')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.h,
      decoration: AppDecoration.fillOnPrimary,
      child: Column(
        children: [
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
                width: 36.h,
                height: 36.h,
              ),
              AppbarTrailingIconButton(
                imagePath: ImageConstant.chat,
                margin: EdgeInsets.only(right: 17.h, bottom: 2.h),
                onTap: () {
                  debugPrint('Chat icon clicked');
                  onTapChat(context);
                },
                width: 36.h,
                height: 36.h,
              ),
              AppbarTrailingIconButton(
                imagePath: _isLoggedIn ? ImageConstant.logout : ImageConstant.login,
                margin: EdgeInsets.only(right: 17.h, bottom: 2.h),
                onTap: () {
                  _handleLoginOrLogout(context);
                },
                width: 36.h,
                height: 36.h,
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membuka tautan')),
      );
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
          Padding(
            padding: EdgeInsets.only(left: 20.h, top: 20.h, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.h,
                  child: Text(
                    'EKONOMI KREATIF KABUPATEN NGANJUK IKI WOOO',
                    maxLines: 3,
                    style: CustomTextStyles.titleSmallMontserratOnPrimary
                        .copyWith(height: 1.3),
                  ),
                ),
                SizedBox(height: 10.h),
                CustomOutlinedButton(
                  height: 30.h,
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
          Positioned(
            right: -20.h,
            bottom: -30,
            child: CustomImageView(
              imagePath: ImageConstant.nganjuk,
              height: 180.h,
              width: 200.h,
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Sector>> fetchSectors() async {
    try {
      final response = await ApiService.get(Config.sectorsEndpoint);

      if (response is! Map<String, dynamic>) {
        throw Exception('Invalid response format: Expected a Map<String, dynamic>');
      }

      final jsonMap = response;
      print('Response API: $jsonMap');

      final List<dynamic> rawList = (jsonMap['sectors'] ?? []) as List<dynamic>;

      List<Sector> sectors = rawList
          .map<Sector>((item) {
            if (item is! Map<String, dynamic>) {
              throw Exception('Invalid sector item format: Expected a Map<String, dynamic>');
            }
            return Sector.fromJson(item);
          })
          .toList();

      bool hasMusik = sectors.any((sector) => sector.name.toLowerCase() == "musik");
      if (!hasMusik) {
        sectors.add(Sector(
          id: '7',
          name: 'Musik',
          iconUrl: '',
          isAsset: false,
        ));
      }

      return sectors;
    } catch (e, stackTrace) {
      print('Error fetching sectors: $e');
      print('StackTrace: $stackTrace');
      throw Exception('Gagal memuat data sektor: ${e.toString()}');
    }
  }

  Widget _buildCreativeCategories(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 16),
            child: Text(
              'Sektor Ekonomi Kreatif',
              style: CustomTextStyles.titleMediumSemiBold,
            ),
          ),
          FutureBuilder<List<Sector>>(
            future: fetchSectors(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("Tidak ada kategori tersedia."));
              } else {
                final sectors = snapshot.data!;
                final selectedSectorIds = ['14', '6', '11', '8', '4', '17', '1', '5', '3',];
                final displayedSectors = sectors
                    .where((sector) => selectedSectorIds.contains(sector.id))
                    .toList()
                  ..sort((a, b) => selectedSectorIds.indexOf(a.id).compareTo(selectedSectorIds.indexOf(b.id)));

                displayedSectors.add(
                  Sector(
                    id: 'lainnya',
                    name: 'Lainnya',
                    iconUrl: 'assets/images/lainnya.png',
                    isAsset: true,
                  ),
                );

                return Wrap(
                  spacing: 16,
                  runSpacing: 28,
                  children: displayedSectors.map((sector) {
                    return GestureDetector(
                      onTap: () {
                        if (sector.name == "Lainnya") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SektorScreen()),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PelakuUsahaScreen(
                                sectorId: int.parse(sector.id),
                              ),
                            ),
                          );
                        }
                      },
                      child: SectorsGrid(
                        sector: sector,
                        onTapKategori: () {
                          if (sector.name == "Lainnya") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SektorScreen()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PelakuUsahaScreen(
                                  sectorId: int.parse(sector.id),
                                ),
                              ),
                            );
                          }
                        },
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

  Future<List<Event>> fetchEvents() async {
    try {
      final result = await ApiService.get(Config.eventsEndpoint);
      print('Raw API Response: ${jsonEncode(result)}');

      List<dynamic> rawList = [];

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
            future: _eventsFuture,
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
              return SizedBox(
                height: 150.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 16.h),
                      child: RecentEvents(
                        imageUrl: event.thumbnail,
                        title: event.title,
                        onTapRowsunglasses: () => _onEventTap(context, event),
                      ),
                    );
                  },
                ),
              );
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

  Future<List<Article>> fetchArticles() async {
    try {
      final result = await ApiService.get(Config.articlesEndpoint);
      print('Raw API Response for articles: ${jsonEncode(result)}');

      List<dynamic> rawList = [];

      if (result is Map<String, dynamic>) {
        if (result['data'] is Map && result['data']['data'] is List) {
          rawList = result['data']['data'] as List<dynamic>;
        } else if (result['articles'] is List) {
          rawList = result['articles'] as List<dynamic>;
        } else {
          throw Exception('Unexpected API response structure: $result');
        }
      } else if (result is List) {
        rawList = result;
      } else {
        throw Exception('Unexpected API response structure: $result');
      }

      print('Raw list before mapping: $rawList');
      final articles = rawList.map((item) {
        print('Mapping item: $item');
        return Article.fromJson(item as Map<String, dynamic>);
      }).toList();
      print('Parsed articles: ${articles.map((a) => a.thumbnail).toList()}');
      return articles;
    } catch (e) {
      print('Error fetching articles: $e');
      throw Exception('Gagal memuat artikel: ${e.toString()}');
    }
  }

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
              print('Rendering articles: ${articles.map((a) => a.thumbnail).toList()}');
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: articles.map((article) => Padding(
                    padding: EdgeInsets.only(right: 16.h),
                    child: RecentArticles(
                      article: article,
                    ),
                  )).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

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

  void onTapBellone(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotifikasiScreen()),
    );
  }

  void _onEventTap(BuildContext context, Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InformasiEventScreen(data: event)),
    );
  }

  Future<void> _handleLoginOrLogout(BuildContext context) async {
    if (_isLoggedIn) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_role');
      setState(() {
        _isLoggedIn = false;
        _userRole = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anda telah logout')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      ).then((_) {
        _checkLoginStatus();
      });
    }
  }
}