import 'package:flutter/material.dart';
import '../../core/app_export.dart'; // ignore_for_file: must_be_immutable

class OverlayFilterBottomsheet extends StatelessWidget {
  const OverlayFilterBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildFilterControls(context);
  }

  /// Section Widget
  Widget _buildFilterControls(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 12.h),
      decoration: AppDecoration.outlineGray300.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL20,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 160.h),
            child: Text(
              "Filter",
              style: CustomTextStyles.titleSmallBluegray900SemiBold,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgERemove4,
            height: 24.h,
            width: 26.h,
            onTap: () {
              onTapImgEremovefourone(context);
            },
          ),
        ],
      ),
    );
  }

  /// Navigates to the pelakuUsahaScreen when the action is triggered.
  onTapImgEremovefourone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pelakuUsahaScreen);
  }
}