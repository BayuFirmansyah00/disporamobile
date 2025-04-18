import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class HomeOneItemWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? onTapKategori; //onTapColumcontainer;

  const HomeOneItemWidget({
    Key? key,
    required this.imagePath,
    required this.title,
    this.onTapKategori, //onTapColumcontainer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapKategori, //onTapColumcontainer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconButton(
            height: 60.h,
            width: 60.h,
            padding: EdgeInsets.all(8.h),
            decoration: IconButtonStyleHelper.none,
            child: CustomImageView(imagePath: imagePath),
          ),
          SizedBox(height: 6.h),
          Flexible(
            child: Text(
              title,
              style: CustomTextStyles.bodySmallGray900_1,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: GridView.builder(
          itemCount: sectors.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 kolom per baris
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.h,
            childAspectRatio: 1.3, // Lebih lebar agar teks tidak turun
          ),
          itemBuilder: (context, index) {
            return HomeOneItemWidget(
              imagePath: sectors[index]["image"] ?? '',
              title: sectors[index]["title"] ?? '',
              onTapKategori: () { //onTapColumcontainer: () {
                print("Klik ${sectors[index]["title"] ?? 'Unknown'}");
              },
            );
          },
        ),
      ),
    );
  }
}
