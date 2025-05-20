import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../core/app_export.dart';
import '../event_page/event_page.dart';
import '../article_page/article_page.dart';
import '../pengaturan_page/pengaturan_page.dart';
import 'Homepage.dart';

// ignore_for_file: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homePage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      height: 100,
      child: GNav(
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: Color.fromARGB(255, 0, 162, 255),
        color: Color.fromARGB(255, 0, 0, 0),
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Color(0xFFF1EFEC).withOpacity(0.1),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Beranda',
            onPressed: () {
              navigatorKey.currentState?.pushReplacementNamed(AppRoutes.homePage);
            },
          ),
          GButton(
            icon: Icons.event,
            text: 'Event',
            onPressed: () {
              navigatorKey.currentState?.pushReplacementNamed(AppRoutes.eventPage);
            },
          ),
          GButton(
            icon: Icons.article,
            text: 'Artikel',
            onPressed: () {
              navigatorKey.currentState?.pushReplacementNamed(AppRoutes.articlePage);
            },
          ),
          GButton(
            icon: Icons.settings,
            text: 'Pengaturan',
            onPressed: () {
              navigatorKey.currentState?.pushReplacementNamed(AppRoutes.pengaturanPage);
            },
          ),
        ],
      ),
    );
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.eventPage:
        return EventPage();
      case AppRoutes.articlePage:
        return ArticlePage();
      case AppRoutes.pengaturanPage:
        return PengaturanPage();
      default:
        return HomePage();
    }
  }
}