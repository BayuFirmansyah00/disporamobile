import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../models/Event.dart';

class InformasiEventScreen extends StatelessWidget {
  final Event event;

  const InformasiEventScreen({
    Key? key,
    required this.event, // <-- Constructor dengan required parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 44.h, top: 4.h, right: 44.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle4130x152,
                height: 242.h,
                width: double.maxFinite,
                radius: BorderRadius.circular(16.h),
                margin: EdgeInsets.only(right: 12.h),
              ),
              Text(
                "MIME ON THE STREET BERSAMA KAK YUDHA BAYU MIME",
                style: CustomTextStyles.titleMediumInter,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.bodyMedium13.copyWith(height: 1.38),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 20.h),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarSubtitle(
        text: "Informasi Event",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  /// Navigates back to the previous screen.
  void onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}