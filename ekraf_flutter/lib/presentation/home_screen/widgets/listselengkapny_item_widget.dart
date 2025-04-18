import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';

class ListselengkapnyItemWidget extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTapRowsunglasses;

  const ListselengkapnyItemWidget({
    Key? key,
    required this.imageUrl,
    this.onTapRowsunglasses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 152.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.h),
            child: Image.network(
              imageUrl,
              height: 130.h,
              width: double.maxFinite,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 6.h),
          GestureDetector(
            onTap: onTapRowsunglasses,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 2.h),
              decoration: AppDecoration.outlineOnPrimary.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Selengkapnya",
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallOnPrimary,
                  ),
                  SizedBox(width: 4.h),
                  CustomImageView(
                    imagePath: ImageConstant.arrow,
                    height: 12.h,
                    width: 12.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}