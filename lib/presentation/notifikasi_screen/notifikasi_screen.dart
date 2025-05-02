import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/notificationlist_item_widget.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 26.h,
            top: 12.h,
            right: 26.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildNotificationList(context)],
          ),
        ),
      ),
    );
  }

  /// Section Widget - App Bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 27.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.arrowleft,
        margin: EdgeInsets.only(left: 7.h),
        onTap: () {
          onTapArrowLeftOne(context);
        },
      ),
      title: AppbarSubtitle(
        text: "Notifikasi",
        margin: EdgeInsets.only(left: 24.h),
      ),
    );
  }

  /// Section Widget - List Notifikasi
  Widget _buildNotificationList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 76.h),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
          itemCount: 6,
          itemBuilder: (context, index) {
            return NotificationlistItemWidget(
              onTapContainer: () {
                onTapContainer(context);
              },
            );
          },
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  void onTapArrowLeftOne(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the InformasiEventScreen when the action is triggered.
  void onTapContainer(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.informasiEventScreen);
  }
}