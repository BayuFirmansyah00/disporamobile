import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'widgets/subsektorlist_item_widget.dart';

// ignore_for_file: must_be_immutable
class SubsektorScreen extends StatelessWidget {
  SubsektorScreen({Key? key, required this.sector}) : super(key: key);

  final TextEditingController searchController = TextEditingController();
  final Map<String, String> sector;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 28.h),
          child: Column(
            spacing: 26,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.h),
                child: CustomSearchView(
                  controller: searchController,
                  hintText: "Cari",
                  contentPadding: EdgeInsets.fromLTRB(16.h, 10.h, 10.h, 10.h),
                ),
              ),
              _buildSubsektorList(context),
            ],
          ),
        ),
      ),
    );
  }

  /// App Bar Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 36.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarSubtitle(
        text: "Sub Sektor Kriya",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  /// Sub Sektor List Widget
  Widget _buildSubsektorList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 10.h),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 12.h);
          },
          itemCount: 6,
          itemBuilder: (context, index) {
            return SubsektorlistItemWidget(
              onTapRowsunglasses: () {
                onTapRowsunglasses(context);
              },
            );
          },
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  void onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the pelakuUsahaScreen when the action is triggered.
  void onTapRowsunglasses(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pelakuUsahaScreen);
  }
}