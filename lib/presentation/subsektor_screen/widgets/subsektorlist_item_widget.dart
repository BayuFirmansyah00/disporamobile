import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

// // ignore_for_file: must_be_immutable
// class SubsektorlistItemWidget extends StatelessWidget {
//   SubsektorlistItemWidget({Key? key, this.onTapRowsunglasses}) : super(key: key);

//   final VoidCallback? onTapRowsunglasses;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(12.h),
//       decoration: AppDecoration.outlineGray.copyWith(
//         borderRadius: BorderRadiusStyle.roundedBorder6,
//       ),
//       child: Row(
//         children: [
//           Container(
//             height: 96.h,
//             width: 96.h,
//             decoration: AppDecoration.fillGray.copyWith(
//               borderRadius: BorderRadiusStyle.roundedBorder6,
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 CustomImageView(
//                   imagePath: ImageConstant.imgCb599183a00463c,
//                   height: 96.h,
//                   width: 96.h,
//                   radius: BorderRadius.circular(6.h),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Bahan Dasar Kayu",
//                     style: theme.textTheme.titleSmall,
//                   ),
//                   SizedBox(
//                     width: 174.h,
//                     child: Text(
//                       "Seniman kriya memiliki banyak berbagai kerajinan tangan....",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: theme.textTheme.bodySmall!.copyWith(
//                         height: 1.25,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20.h),
//                   Container(
//                     width: double.maxFinite,
//                     margin: EdgeInsets.only(left: 4.h),
//                     child: Row(
//                       children: [
//                         CustomImageView(
//                           imagePath: ImageConstant.imgUsers,
//                           height: 20.h,
//                           width: 22.h,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 6.h),
//                           child: Text(
//                             "11 Pengusaha",
//                             style: theme.textTheme.bodySmall,
//                           ),
//                         ),
//                         Spacer(),
//                         GestureDetector(
//                           onTap: () {
//                             onTapRowsunglasses?.call();
//                           },
//                           child: Container(
//                             decoration: AppDecoration.outlinePrimary.copyWith(
//                               borderRadius: BorderRadiusStyle.roundedBorder6,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   "Selengkapnya",
//                                   style: CustomTextStyles.interPrimary,
//                                 ),
//                                 CustomImageView(
//                                   imagePath: ImageConstant.imgCircleArrowRightPrimary,
//                                   height: 8.h,
//                                   width: 8.h,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SubsektorlistItemWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String jumlahUsaha;
  final VoidCallback? onTapRowsunglasses;

  const SubsektorlistItemWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.jumlahUsaha,
    this.onTapRowsunglasses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Row(
        children: [
          Container(
            height: 96.h,
            width: 96.h,
            decoration: AppDecoration.fillGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder6,
            ),
            child: CustomImageView(
              imagePath: imageUrl, // ← dari parameter
              height: 96.h,
              width: 96.h,
              radius: BorderRadius.circular(6.h),
            ),
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall),
                SizedBox(height: 4.h),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall!.copyWith(height: 1.25),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.pengusaha,
                      height: 20.h,
                      width: 22.h,
                    ),
                    SizedBox(width: 6.h),
                    Text(jumlahUsaha, style: theme.textTheme.bodySmall),
                    Spacer(),
                    GestureDetector(
                      onTap: () => onTapRowsunglasses?.call(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.h,
                          vertical: 4.h,
                        ),
                        decoration: AppDecoration.outlinePrimary.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Selengkapnya",
                              style: CustomTextStyles.interPrimary.copyWith(
                                fontSize: 10.h, // Sesuaikan ukuran font
                                fontWeight:
                                    FontWeight.normal, // Optional: Untuk mempertegas teks
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
