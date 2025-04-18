import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/informasi_usaha_item_widget.dart';

class InformasiUsahaScreen extends StatelessWidget {
  const InformasiUsahaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 18.h, top: 66.h, right: 18.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNavigationRow(context),
              SizedBox(height: 12.h),
              _buildBusinessInfoRow(context),
              SizedBox(height: 52.h),
              _buildProductInformationColumn(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNavigationRow(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgArrowLeft,
            height: 20.h,
            width: 20.h,
            onTap: () {
              onTapImgArrowLeft(context);
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text("Informasi Usaha", style: theme.textTheme.titleMedium),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBusinessInfoRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 26.h),
      decoration: AppDecoration.outlineGray100.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          Container(
            height: 150.h,
            width: 102.h,
            decoration: BoxDecoration(
              color: appTheme.blueGray200,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(6.h)),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Persegi Art",
                    style: CustomTextStyles.titleSmallBluegray900,
                  ),
                ),
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Seni Kriya",
                    style: CustomTextStyles.bodySmall10,
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 14.h),
                  child: _buildContactInfoRow(
                    context,
                    callImage: ImageConstant.imgUser,
                    phoneNumber: 'Yona Persegi',
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 14.h),
                  child: _buildContactInfoRow(
                    context,
                    callImage: ImageConstant.imgCall,
                    phoneNumber: '08966423175',
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 14.h, right: 24.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgLinkedin,
                        height: 16.h,
                        width: 16.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 156.h,
                          child: Text(
                            "JL. merdeka No. 2 Mangudikaran, Nganjuk",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.bodySmall10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProductInformationColumn(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Informasi Produk", style: theme.textTheme.titleMedium),
            Text(
              "Berikut beberapa contoh produk dari usaha kami",
              style: theme.textTheme.bodyMedium,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 26.h),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return InformasiUsahaItemWidget();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildContactInfoRow(
    BuildContext context, {
    required String callImage,
    required String phoneNumber,
  }) {
    return Row(
      children: [
        CustomImageView(imagePath: callImage, height: 16.h, width: 16.h),
        Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(
            phoneNumber,
            style: CustomTextStyles.bodySmall10.copyWith(
              color: appTheme.gray500,
            ),
          ),
        ),
      ],
    );
  }

  /// Navigates back to the previous screen.
  void onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}