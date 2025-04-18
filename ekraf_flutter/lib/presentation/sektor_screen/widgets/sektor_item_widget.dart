import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../sektor_screen.dart'; // Pastikan path ini benar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690), // Sesuaikan dengan ukuran desain Anda
      builder: (context, child) {
        return MaterialApp(
          title: 'Aplikasi Sektor',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SektorScreen(), // Ganti dengan widget utama Anda
        );
      },
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final Widget child;

  const CustomIconButton({
    Key? key,
    required this.height,
    required this.width,
    required this.padding,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h, // Menggunakan ScreenUtil untuk tinggi
      width: width.w, // Menggunakan ScreenUtil untuk lebar
      padding: padding,
      child: child,
    );
  }
}

class CustomImageView extends StatelessWidget {
  final String imagePath;

  const CustomImageView({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath); // Menampilkan gambar dengan path yang diberikan
  }
}

class CustomTextStyles {
  static TextStyle bodySmallGray900_1 = TextStyle(
    fontSize: 14.sp, // Gunakan flutter_screenutil jika ingin responsif
    color: Colors.grey[900],
  );
}

class SektorItemWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  const SektorItemWidget({
    Key? key,
    required this.title,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {}, // Menyediakan fungsi default jika onTap null
      child: Column(
        children: [
          CustomIconButton(
            height: 40.h,
            width: 40.h,
            padding: EdgeInsets.all(8.h),
            child: CustomImageView(imagePath: imagePath),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: CustomTextStyles.bodySmallGray900_1,
          ),
        ],
      ),
    );
  }
}