import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../models/sektor_sektor_model.dart';

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

class CustomTextStyles {
  static TextStyle bodySmallGray900_1 = TextStyle(
    fontSize: 13.h,
    color: Colors.grey[900],
  );
}

class SektorItemWidget extends StatelessWidget {
  final Sektor sektor;
  final VoidCallback? onTap;

  const SektorItemWidget({
    Key? key,
    required this.sektor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            child: CustomImageView(imagePath: sektor.imagePath),
          ),
          SizedBox(height: 6.h),
          Text(
            sektor.name,
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