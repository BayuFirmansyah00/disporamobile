import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/appbar_trailing_iconbutton.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_outlined_button.dart';
import 'widgets/featuredsectors_item_widget.dart';
import 'widgets/home_one_item_widget.dart';
import 'widgets/listselengkapny_item_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/sector_model.dart';
import '../../../models/event_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../notifikasi_screen/notifikasi_screen.dart';
import '../../services/api_service.dart';
import '../sektor_screen/sektor_screen.dart';
import '../subsektor_screen/subsektor_screen.dart';
import '../informasi_event_screen/informasi_event_screen.dart';

class HomeInitialPage extends StatefulWidget {
  const HomeInitialPage({Key? key}) : super(key: key);

  @override
  HomeInitialPageState createState() => HomeInitialPageState();
}

class HomeInitialPageState extends State<HomeInitialPage> {
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
                  Padding(
                    padding: EdgeInsets.only(left: 26.h),
                    child: Text(
                      'Sektor Ungulan di Nganjuk',
                      style: CustomTextStyles.titleMediumSemiBold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _buildFeaturedSectors(context),
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

  Widget _buildCreativeCategories(BuildContext context) {
    final List<Map<String, String>> sectors = [
      {"image": ImageConstant.arsitektur, "title": "Arsitektur"},
      {"image": ImageConstant.fotografi, "title": "Fotografi"},
      {"image": ImageConstant.fesyen, "title": "Fesyen"},
      {"image": ImageConstant.kriya, "title": "Kriya"},
      {"image": ImageConstant.kuliner, "title": "Kuliner"},
      {"image": ImageConstant.musik, "title": "Musik"},
      {"image": ImageConstant.periklanan, "title": "Periklanan"},
      {"image": ImageConstant.aplikasi, "title": "Aplikasi"},
      {"image": ImageConstant.seniRupa, "title": "Seni Rupa"},
      {"image": ImageConstant.lainnya, "title": "Lainnya"},
    ];

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 18.h),
      decoration: AppDecoration.fillOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2.h, bottom: 12.h),
            child: Text(
              "Kategori",
              style: CustomTextStyles.titleMediumSemiBold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: ResponsiveGridListBuilder(
              minItemWidth: 1,
              minItemsPerRow: 5,
              maxItemsPerRow: 5,
              horizontalGridSpacing: 20.h,
              verticalGridSpacing: 20.h,
              builder:
                  (context, items) => ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: items,
                  ),
              gridItems: List.generate(sectors.length, (index) {
                final sector = sectors[index];
                final title = sector["title"] ?? "";

                return HomeOneItemWidget(
                  imagePath: sector["image"] ?? "",
                  title: title,
                  onTapKategori: () {
                    onTapKategori(context, sector);
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<EventModel>> fetchLatestEvents() async {
    final data = await ApiService.get('events');
    return data.map((e) => EventModel.fromJson(e)).toList();
  }

  //event terbaru
  Widget _buildLatestEvents(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 22.h, right: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul selalu tampil
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              'Event Terbaru',
              style: CustomTextStyles.titleMediumSemiBold,
            ),
          ),
          SizedBox(height: 20.h),

          // FutureBuilder hanya untuk isi konten
          FutureBuilder<List<EventModel>>(
            future: fetchLatestEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Tidak ada event terbaru.'));
              } else {
                final events = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 20.h,
                    children:
                        events.map((event) {
                          return ListselengkapnyItemWidget(
                            imageUrl: event.image,
                            onTapRowsunglasses: () {
                              onTapRowsunglasses(context);
                            },
                          );
                        }).toList(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // sektor ungulan di Nganjuk
  Future<List<SectorModel>> fetchSectors() async {
    final data = await ApiService.get('sectors');
    return data.map((item) => SectorModel.fromJson(item)).toList();
  }

  Widget _buildFeaturedSectors(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 22.h, right: 22.h), // Sama seperti event
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          FutureBuilder<List<SectorModel>>(
            future: fetchSectors(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Padding(
                  padding: EdgeInsets.only(left: 2.h), // agar rata dengan judul
                  child: Text("Error: ${snapshot.error}"),
                );
              }

              final sectors = snapshot.data ?? [];

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.15, //1.15
                ),
                itemCount: sectors.length,
                itemBuilder: (context, index) {
                  return FeaturedsectorsItemWidget(
                    sector: sectors[index],
                    onTapSektorunggulan: () {
                      print('Tapped on: ${sectors[index].name}');
                      onTapSektorunggulan(context, {
                        'name': sectors[index].name,
                        'image': sectors[index].image,
                      });
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  //Navigation to the notfikasiScreen when the action is triggered
  void onTapBellone(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotifikasiScreen()),
    );
    // Navigator.pushNamed(context, AppRoutes.notifikasiScreen);
  }

  //Navigation to the subsektorScreen when the action is triggered
  void onTapColumcontainer(BuildContext context, Map<String, String> sector) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubsektorScreen(sector: sector)),
    );
    // Navigator.pushNamed(context, AppRoutes.subsektorScreen);
  }

  //Navigation to the infoEventScreen when the action is triggered
  void onTapRowsunglasses(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InformasiEventScreen()),
    );
    // Navigator.pushNamed(context, AppRoutes.informasiEventScreen);
  }

  void onTapSektorunggulan(BuildContext context, Map<String, String> sector) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubsektorScreen(sector: sector)),
    );
    // Navigator.pushNamed(context, AppRoutes.subsektorScreen);
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
