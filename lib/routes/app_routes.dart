import 'package:ekraf_kuy/presentation/event_page/event_page.dart';
import 'package:ekraf_kuy/presentation/home_screen/HomePage.dart';
import 'package:flutter/material.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/home_screen/HomeScreen.dart';
import '../presentation/informasi_usaha_screen/informasi_usaha_screen.dart';
import '../presentation/notifikasi_screen/notifikasi_screen.dart';
import '../presentation/pelaku_usaha_screen/pelaku_usaha_screen.dart';
import '../presentation/sektor_screen/sektor_screen.dart';
import '../presentation/splash_screen/splash.dart';
import '../presentation/article_page/article_page.dart';
import '../presentation/informasi_event_screen/informasi_event_screen.dart';
import '../presentation/pengaturan_page/pengaturan_page.dart';
import '../presentation/chat_screen/ChatScreen.dart';
import '../presentation/visitor_screen/visitor_screen.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String splashScreen = '/splash';
  static const String notifikasiScreen = '/notifikasi';
  static const String homeScreen = '/home';
  static const String homePage = '/homepage'; // Pastikan ini konsisten dengan HomePage
  static const String eventPage = '/event';
  static const String pengaturanPage = '/pengaturan';
  static const String informasiEventScreen = '/informasi_event';
  static const String sektorScreen = '/sektor';
  static const String subsektorScreen = '/subsektor';
  static const String pelakuUsahaScreen = '/pelaku_usaha';
  static const String visitorScreen = '/visitor';
  static const String chatScreen = '/chat';
  static const String informasiUsahaScreen = '/informasi_usaha';
  static const String appNavigationScreen = '/app_navigation';
  static const String articlePage = '/article';
  static const String initialRoute = splashScreen;

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    notifikasiScreen: (context) => NotifikasiScreen(),
    homeScreen: (context) => HomeScreen(),
    homePage: (context) => HomePage(), // Pastikan ini mengarah ke HomePage yang benar
    eventPage: (context) => EventPage(),
    pengaturanPage: (context) => PengaturanPage(),
    sektorScreen: (context) => SektorScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    articlePage: (context) => ArticlePage(),
    pelakuUsahaScreen: (context) => PelakuUsahaScreen(sectorId: 0),
    visitorScreen: (context) => VisitorScreen(),
    chatScreen: (context) => ChatScreen(), // Pastikan ChatScreen diimpor dan didefinisikan
  };
}