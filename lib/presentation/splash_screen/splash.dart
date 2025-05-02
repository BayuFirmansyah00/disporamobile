import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF1EFEC), // Warna atas
              Color(0xFFD4C9BE), // Warna bawah
            ],
            stops: [0.6, 1.0], // Transisi mulai 60% dari atas ke bawah
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 250), // Geser logo lebih ke atas
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 122.5,
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Text(
                'EkrafKüy',
                style: GoogleFonts.permanentMarker(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF123458),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}