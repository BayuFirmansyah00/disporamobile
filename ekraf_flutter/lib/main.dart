// import 'package:flutter/material.dart';
// import 'presentation/splash_screen/splash.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cari Sektor App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Inter',
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: SplashScreen(),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'routes/app_routes.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'ekrafky',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
          navigatorObservers: [routeObserver],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart'; // Tambahkan ini
// import 'core/app_export.dart';
// import 'routes/app_routes.dart';

// var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
// final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812), // Sesuaikan dengan desain kamu
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (context, child) {
//         return MaterialApp(
//           theme: theme,
//           title: 'ekrafky',
//           debugShowCheckedModeBanner: false,
//           initialRoute: AppRoutes.initialRoute,
//           routes: AppRoutes.routes,
//           navigatorObservers: [routeObserver],
//           builder: (context, child) {
//             return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 textScaler: TextScaler.linear(1.0),
//               ),
//               child: child!,
//             );
//           },
//         );
//       },
//     );
//   }
// }