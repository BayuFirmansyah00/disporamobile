import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../overlay_filter_bottomsheet/overlay_filter_bottomsheet.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Text(
                        "App Navigation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 20.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.h),
                      child: Text(
                        "Check your app's UI from the below demo screens of your app.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 16.fSize,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: Color(0xFF000000),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        buildScreenTitle(
                          context,
                          screenTitle: "Splash One",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.splashScreen),
                        ),
                        // buildScreenTitle(
                        //   context,
                        //   screenTitle: "Splash Two",
                        //   onTapScreenTitle: () =>
                        //       onTapScreenTitle(context, AppRoutes.splashTwoScreen),
                        // ),
                        buildScreenTitle(
                          context,
                          screenTitle: "Notifikasi",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.notifikasiScreen),
                        ),
                        buildScreenTitle(
                          context,
                          screenTitle: "Home",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.homeScreen),
                        ),
                        buildScreenTitle(
                          context,
                          screenTitle: "Informasi Event",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.informasiEventScreen),
                        ),
                        buildScreenTitle(
                          context,
                          screenTitle: "Sektor",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.sektorScreen),
                        ),
                        buildScreenTitle(
                          context,
                          screenTitle: "Subsektor",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.subsektorScreen),
                        ),
                        buildScreenTitle(
                          context,
                          screenTitle: "Pelaku Usaha",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.pelakuUsahaScreen),
                        ),
                        buildScreenTitle(
                          context,
                          screenTitle: "Informasi Usaha",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.informasiUsahaScreen),
                        ),
                        buildScreenTitle(
                          context,
                          screenTitle: "Overlay Filter BottomSheet",
                          onTapScreenTitle: () =>
                              onTapBottomSheetTitle(context, OverlayFilterBottomsheet()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Common click event for bottomsheet
  void onTapBottomSheetTitle(BuildContext context, Widget className) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return className;
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Common widget for screen title
  Widget buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 5.h),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: Color(0xFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event for navigation
  void onTapScreenTitle(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}