import 'package:ekraf_kuy/presentation/chat_screen/ChatScreen.dart';
import 'package:ekraf_kuy/presentation/home_screen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';
import 'routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          scaffoldMessengerKey: globalMessengerKey, // Gunakan global key untuk snackbar
          theme: theme,
          title: 'ekrafky',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
          navigatorObservers: [routeObserver],
          onGenerateRoute: (settings) {
            debugPrint('Attempting to navigate to: ${settings.name}');
            if (settings.name == AppRoutes.chatScreen) {
              debugPrint('Route matched: ${AppRoutes.chatScreen}');
              return MaterialPageRoute(builder: (context) => ChatScreen());
            }
            debugPrint('No matching route found for: ${settings.name}');
            return null;
          },
          onUnknownRoute: (settings) {
            debugPrint('Unknown route: ${settings.name}');
            return MaterialPageRoute(builder: (context) => HomePage());
          },
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    );
  }
}