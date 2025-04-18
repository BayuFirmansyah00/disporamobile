import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// ignore_for_file: must_be_immutable
class NotificationlistItemWidget extends StatelessWidget {
  NotificationlistItemWidget({Key? key, this.onTapContainer}) : super(key: key);

  VoidCallback? onTapContainer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapContainer?.call();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 60.h,
              width: 60.h,
              decoration: AppDecoration.fillGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder6,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle4,
                    height: 60.h,
                    width: 60.h,
                    radius: BorderRadius.circular(6.h),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Informasi Event",
                  style: CustomTextStyles.titleMediumInterMedium,
                ),
                Text(
                  "Pentas pantonim tingkat kabupaten Nganjuk....",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(height: 1.25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}