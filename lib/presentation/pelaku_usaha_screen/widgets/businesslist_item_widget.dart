// import 'package:flutter/material.dart';
// import '../../../core/app_export.dart';
// import '../../../theme/custom_button_style.dart';
// import '../../../widgets/custom_elevated_button.dart';

// // ignore_for_file: must_be_immutable
// class BusinesslistItemWidget extends StatelessWidget {
//   BusinesslistItemWidget({Key? key, this.onTapColumnlineone}) : super(key: key);

//   VoidCallback? onTapColumnlineone;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTapColumnlineone?.call();
//       },
//       child: SizedBox(
//         width: double.maxFinite,
//         child: Column(
//           spacing: 24,
//           children: [
//             SizedBox(
//               width: double.maxFinite,
//               child: Divider(),
//             ),
//             SizedBox(
//               width: double.maxFinite,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomImageView(
//                     imagePath: ImageConstant.imgImage87,
//                     height: 36.h,
//                     width: 36.h,
//                   ),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 4.h),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Persegi Art",
//                               style: CustomTextStyles.titleSmallInter,
//                             ),
//                             SizedBox(height: 10.h),
//                             Text(
//                               "Seni kriya berbahan dasar kayu",
//                               style: theme.textTheme.bodyMedium,
//                             ),
//                             SizedBox(height: 4.h),
//                             SizedBox(
//                               width: double.maxFinite,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     decoration: AppDecoration.fillIndigo.copyWith(
//                                       borderRadius: BorderRadiusStyle.roundedBorder10,
//                                     ),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Container(
//                                           height: 20.h,
//                                           width: 20.h,
//                                           decoration: BoxDecoration(
//                                             color: appTheme.gray400,
//                                             borderRadius: BorderRadius.circular(10.h),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.bottomCenter,
//                                     child: Padding(
//                                       padding: EdgeInsets.only(left: 6.h),
//                                       child: Text(
//                                         "Yona Persegi",
//                                         style: theme.textTheme.bodySmall,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 12.h),
//                             _buildProfileButton(context),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildProfileButton(BuildContext context) {
//     return CustomElevatedButton(
//       width: 72.h,
//       text: "Lihat Profil",
//       onPressed: () {
//         // Add your onPressed logic here
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../models/BusinessModel.dart';

// ignore_for_file: must_be_immutable
class BusinesslistItemWidget extends StatelessWidget {
  final BusinessModel bisnis;
  final VoidCallback? onTapColumnlineone;

  const BusinesslistItemWidget({
    Key? key,
    required this.bisnis,
    this.onTapColumnlineone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapColumnlineone,
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar Logo dengan border yang lebih halus
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CustomImageView(
                      imagePath:
                          bisnis.logoUrl, // Mengambil URL gambar dari model
                      height: 60.h,
                      width: 60.h,
                    ),
                  ),
                  // Menambah Padding agar lebih seimbang
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.h, top: 4.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama Usaha
                          Text(
                            bisnis.namaUsaha,
                            style: CustomTextStyles.titleSmallInter.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 8.h),
                          // Sektor dan Sub-sektor
                          Text(
                            '${bisnis.sektor.isNotEmpty ? bisnis.sektor : 'Tidak diketahui'}   ${bisnis.subsektor.isNotEmpty ? bisnis.subsektor : 'Tidak diketahui'}',
                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(height: 6.h),
                          // Nama Pemilik
                          Row(
                            children: [
                              // Container(
                              //   decoration: AppDecoration.fillIndigo.copyWith(
                              //     borderRadius: BorderRadiusStyle.roundedBorder10,
                              //   ),
                              //   child: Container(
                              //     height: 20.h,
                              //     width: 20.h,
                              //     decoration: BoxDecoration(
                              //       color: appTheme.gray400,
                              //       borderRadius: BorderRadius.circular(10.h),
                              //     ),
                              //   ),
                              // ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.h),
                                child: Image.network(
                                  bisnis.fotoPemilik ?? 'https://via.placeholder.com/150',
                                  height: 36.h,
                                  width: 36.h,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) => Container(
                                        height: 36.h,
                                        width: 36.h,
                                        color: appTheme.gray400,
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.white,
                                        ),
                                      ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 8.h),
                                child: Text(
                                  bisnis.namaPemilik,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          // Tombol Lihat Profil
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width *
                                0.3, // Menyesuaikan lebar tombol
                            child: CustomElevatedButton(
                              text: "Lihat Profil",
                              onPressed: onTapColumnlineone,
                            ),
                          ),
                        ],
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
}