import 'package:ekraf_kuy/presentation/home_screen/HomePage.dart';
import 'package:flutter/material.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/home_screen/HomeScreen.dart';
// import '../presentation/informasi_event_screen/informasi_event_screen.dart';
import '../presentation/informasi_usaha_screen/informasi_usaha_screen.dart';
import '../presentation/notifikasi_screen/notifikasi_screen.dart';
import '../presentation/pelaku_usaha_screen/pelaku_usaha_screen.dart';
import '../presentation/sektor_screen/sektor_screen.dart';
import '../presentation/splash_screen/splash.dart';
// import '../presentation/home_screen/home_initial_page.dart';
// import '../presentation/splash_two_screen/splash_two_screen.dart';
import '../presentation/home_screen/HomePage.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String splashScreen = '/splash';
  
  // static const String splashTwoScreen = '/splash_two_screen';
  
  static const String notifikasiScreen = '/notifikasi_screen';
  
  static const String homeScreen = '/home_screen';
  
  static const String homeInitialPage = '/home_initial_page';
  
  static const String eventPage = '/event_page';
  
  static const String pengaturanPage = '/pengaturan_page';
  
  static const String informasiEventScreen = '/informasi_event_screen';
  
  static const String sektorScreen = '/sektor_screen';
  
  static const String subsektorScreen = '/subsektor_screen';
  
  static const String pelakuUsahaScreen = '/pelaku_usaha_screen';
  
  static const String informasiUsahaScreen = '/informasi_usaha_screen';
  
  static const String appNavigationScreen = '/app_navigation_screen';
  
  static const String homePage = '/home_page';
  
  static const String initialRoute = splashScreen;

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    // splashTwoScreen: (context) => SplashTwoScreen(),
    notifikasiScreen: (context) => NotifikasiScreen(),
    homeScreen: (context) => HomeScreen(),
    // homeInitialPage: (context) => HomeInitialPage(),
    homePage: (contex) => HomePage(),
    // informasiEventScreen: (context) => InformasiEventScreen(),
    sektorScreen: (context) => SektorScreen(),
    //subsektorScreen: (context) => SubsektorScreen(),
    // pelakuUsahaScreen: (context) => PelakuUsahaScreen(),
    //informasiUsahaScreen: (context) => InformasiUsahaScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
  };
}