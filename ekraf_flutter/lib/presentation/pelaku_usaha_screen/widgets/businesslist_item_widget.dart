import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class BusinesslistItemWidget extends StatelessWidget {
  BusinesslistItemWidget({Key? key, this.onTapColumnlineone}) : super(key: key);

  VoidCallback? onTapColumnlineone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapColumnlineone?.call();
      },
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          spacing: 24,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Divider(),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgImage87,
                    height: 36.h,
                    width: 36.h,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Persegi Art",
                              style: CustomTextStyles.titleSmallInter,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Seni kriya berbahan dasar kayu",
                              style: theme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 4.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: AppDecoration.fillIndigo.copyWith(
                                      borderRadius: BorderRadiusStyle.roundedBorder10,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 20.h,
                                          width: 20.h,
                                          decoration: BoxDecoration(
                                            color: appTheme.gray400,
                                            borderRadius: BorderRadius.circular(10.h),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 6.h),
                                      child: Text(
                                        "Yona Persegi",
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _buildProfileButton(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProfileButton(BuildContext context) {
    return CustomElevatedButton(
      width: 72.h,
      text: "Lihat Profil",
      onPressed: () {
        // Add your onPressed logic here
      },
    );
  }
}