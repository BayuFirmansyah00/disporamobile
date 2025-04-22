import 'package:flutter/material.dart'; // Pastikan kamu pakai screenutil
import '../../../../core/app_export.dart'; // Pastikan path ini benar
import '../../../../widgets/custom_icon_button.dart'; // Pastikan path ini benar

// Widget untuk menampilkan gambar dalam lingkaran
class CustomImageView extends StatelessWidget {
  final String imagePath;

  const CustomImageView({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

// Style untuk teks kecil warna abu-abu
class CustomTextStyles {
  static TextStyle bodySmallGray900_1 = TextStyle(
    fontSize: 13.h, // Ukuran teks responsif
    color: Colors.grey[900],
  );
}

// Widget utama item sektor
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
      onTap: onTap ?? () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50.h,
            width: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            padding: EdgeInsets.all(6.h),
            child: CustomImageView(imagePath: imagePath),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: CustomTextStyles.bodySmallGray900_1.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
