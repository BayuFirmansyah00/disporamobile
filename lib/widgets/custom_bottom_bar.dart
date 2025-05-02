import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import '../core/app_export.dart';

enum BottomBarEnum { Desainkomunikasi }

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      title: "Beranda",
      type: BottomBarEnum.Desainkomunikasi,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgComponent2,
      activeIcon: ImageConstant.imgComponent2,
      title: "Event",
      type: BottomBarEnum.Desainkomunikasi,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSearch,
      activeIcon: ImageConstant.imgSearch,
      title: "Pengaturan",
      type: BottomBarEnum.Desainkomunikasi,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(ImageConstant.imgGroup47277),
          fit: BoxFit.fill,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 34.h,
              width: 36.h,
              color: appTheme.gray700,
            ),
            activeIcon: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 34.h,
                  width: 34.h,
                  color: theme.colorScheme.onPrimary,
                ),
                SizedBox(height: 22.03003.h),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: TextStyle(
                    color: appTheme.blueGray900,
                    fontSize: 14,
                    fontFamily: 'Archivo',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            label: "",
          );
        }),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          widget.onChanged?.call(bottomMenuList[index].type);
        },
      ),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;
  String activeIcon;
  String? title;
  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}