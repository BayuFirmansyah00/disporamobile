// import 'package:flutter/material.dart';
// import '../../../core/app_export.dart';
// import '../../../theme/custom_button_style.dart';
// import '../../../widgets/custom_outlined_button.dart';

// class EventlistItemWidget extends StatelessWidget {
//   final String title;
//   final String imageUrl;
//   final VoidCallback? onTapColumnSelengkap;

//   const EventlistItemWidget({
//     Key? key,
//     required this.title,
//     required this.imageUrl,
//     this.onTapColumnSelengkap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTapColumnSelengkap,
//       child: Container(
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//           color: Color(0xFF123458),
//           borderRadius: BorderRadiusStyle.roundedBorder16,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16.h)),
//               child: Image.network(
//                 imageUrl,
//                 height: 168.h,
//                 width: double.maxFinite,
//                 fit: BoxFit.cover,
//                 errorBuilder:
//                     (context, error, stackTrace) =>
//                         Icon(Icons.error, size: 100),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.h),
//               child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//             ),
//             CustomOutlinedButton(
//               height: 28.h,
//               width: 124.h,
//               text: "Selengkapnya",
//               margin: EdgeInsets.only(right: 4.h),
//               rightIcon: Container(
//                 margin: EdgeInsets.only(left: 2.h),
//                 child: CustomImageView(
//                   imagePath: ImageConstant.arrow,
//                   height: 12.h,
//                   width: 12.h,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               buttonTextStyle: CustomTextStyles.bodySmallOnPrimary,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class EventlistItemWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String? waktu;
  final VoidCallback? onTapColumnSelengkap;

  const EventlistItemWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.waktu,
    this.onTapColumnSelengkap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapColumnSelengkap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color(0xFF123458),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 168,
                width: double.maxFinite,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, size: 100, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  if (waktu != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        waktu!,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Menempatkan tombol "Selengkapnya" di kanan bawah
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.bottomRight, // Menempatkan di kanan bawah
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1), // Garis putih
                    borderRadius: BorderRadius.circular(8), // Sudut melengkung
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Ukuran Row sesuai dengan konten
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Padding di dalam tombol
                        child: Text(
                          "Selengkapnya",
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.bodySmallOnPrimary, // Gaya teks
                        ),
                      ),
                      SizedBox(width: 4), // Jarak antara teks dan ikon
                      CustomImageView(
                        imagePath: ImageConstant.arrow,
                        height: 12, // Ukuran ikon
                        width: 12,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}