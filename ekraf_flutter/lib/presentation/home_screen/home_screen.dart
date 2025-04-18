import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart'; // Import package google_nav_bar
import '../../../core/app_export.dart';
import '../event_page/event_page.dart';
import '../pengaturan_page/pengaturan_page.dart';
import 'home_initial_page.dart';

//ignore_for_file: must_be_immutable
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
          initialRoute: AppRoutes.homeInitialPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  //section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      color: Color(0xFF030303), // Background color of the navbar
      height: 100,
      child: GNav(
        rippleColor: Colors.grey[300]!, // Color of the ripple effect when tapped
        hoverColor: Colors.grey[100]!, // Hover color
        gap: 8, // Space between icons
        activeColor: Color(0xFFD4C9BE), // Color of the icon when selected
        color: Color(0xFFD4C9BE), // Color of the icon when not selected (inactive)
        iconSize: 24, // Size of the icons
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20), // Padding around icons
        duration: Duration(milliseconds: 400), // Animation duration when switching between tabs
        tabBackgroundColor: Color(0xFFF1EFEC).withOpacity(0.1), // Background color when tab is selected
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Beranda',
            onPressed: () {
              navigatorKey.currentState?.pushNamed(AppRoutes.homeInitialPage);
            },
          ),
          GButton(
            icon: Icons.event,
            text: 'Event',
            onPressed: () {
              navigatorKey.currentState?.pushNamed(AppRoutes.eventPage);
            },
          ),
          GButton(
            icon: Icons.settings,
            text: 'Pengaturan',
            onPressed: () {
              navigatorKey.currentState?.pushNamed(AppRoutes.pengaturanPage);
            },
          ),
        ],
      ),
    );
  }

  //Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeInitialPage:
        return HomeInitialPage();
      case AppRoutes.eventPage:
        return EventPage();
      case AppRoutes.pengaturanPage:
        return PengaturanPage();
      default:
        return HomeInitialPage();
    }
  }
}