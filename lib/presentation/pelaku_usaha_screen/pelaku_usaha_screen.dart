// import 'package:flutter/material.dart';
// import '../../core/app_export.dart';
// import '../../widgets/app_bar/appbar_leading_image.dart';
// import '../../widgets/app_bar/appbar_subtitle.dart';
// import '../../widgets/app_bar/custom_app_bar.dart';
// import '../../widgets/custom_search_view.dart';
// import 'widgets/businesslist_item_widget.dart';

// // ignore_for_file: must_be_immutable
// class PelakuUsahaScreen extends StatelessWidget {
//   final int subsektorId;

//   PelakuUsahaScreen({Key? key, required this.subsektorId}) : super(key: key);

//   final TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {

//     final subsektorId = ModalRoute.of(context)?.settings.arguments as int?;

//     return Scaffold(
//       backgroundColor: theme.colorScheme.onPrimary,
//       resizeToAvoidBottomInset: false,
//       appBar: _buildAppBar(context),
//       body: SafeArea(
//         top: false,
//         child: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.only(left: 20.h, top: 12.h, right: 20.h,),
//           child: Column(
//             spacing: 26,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 22.h),
//                 child: CustomSearchView(
//                   controller: searchController,
//                   hintText: "Cari",
//                   contentPadding: EdgeInsets.fromLTRB(16.h, 10.h, 10.h, 10.h),
//                 ),
//               ),
//               _buildBusinessList(context)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// AppBar Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       leadingWidth: 40.h,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgArrowLeft,
//         margin: EdgeInsets.only(left: 20.h),
//         onTap: () {
//           onTapArrowLeftone(context);
//         },
//       ),
//       title: AppbarSubtitle(
//         text: "Pelaku Usaha",
//         margin: EdgeInsets.only(left: 12.h),
//       ),
//     );
//   }

//   /// Business List Widget
//   Widget _buildBusinessList(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.only(right: 12.h),
//         child: ListView.separated(
//           padding: EdgeInsets.zero,
//           physics: BouncingScrollPhysics(),
//           shrinkWrap: true,
//           separatorBuilder: (context, index) {
//             return SizedBox(
//               height: 18.h,
//             );
//           },
//           itemCount: 4,
//           itemBuilder: (context, index) {
//             return BusinesslistItemWidget(
//               onTapColumnlineone: () {
//                 onTapColumnLineone(context);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// Navigates back to the previous screen.
//   void onTapArrowLeftone(BuildContext context) {
//     Navigator.pop(context);
//   }

//   /// Navigates to the informasiUsahaScreen when the action is triggered.
//   void onTapColumnLineone(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.informasiUsahaScreen);
//   }
// }

import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'widgets/businesslist_item_widget.dart';
import '../../models/BusinessModel.dart';
import '../../services/api_service.dart';
import '../informasi_usaha_screen/informasi_usaha_screen.dart';

class PelakuUsahaScreen extends StatefulWidget {
  final int subsektorId;

  const PelakuUsahaScreen({Key? key, required this.subsektorId})
    : super(key: key);

  @override
  State<PelakuUsahaScreen> createState() => _PelakuUsahaScreenState();
}

class _PelakuUsahaScreenState extends State<PelakuUsahaScreen> {
  final TextEditingController searchController = TextEditingController();
  List<BusinessModel> listUsaha = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // final response = await ApiService.get("usaha?subsektor_id=${widget.subsektorId}");

      final response = await ApiService.get(
        "usaha-by-subsektor?subsektor_id=${widget.subsektorId}",
      );

      // setState(() {
      //   listUsaha =
      //       response
      //           .map((e) => BusinessModel.fromJson(e))
      //           .toList()
      //           .cast<BusinessModel>();
      //   isLoading = false;
      // });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.h),
                child: CustomSearchView(
                  controller: searchController,
                  hintText: "Cari",
                  contentPadding: EdgeInsets.fromLTRB(16.h, 10.h, 10.h, 10.h),
                  prefix: Padding(
                    padding: EdgeInsets.all(12),
                    child: CustomImageView(
                      imagePath: ImageConstant.search,
                      width: 24, // 40 terlalu besar, coba kecil dulu
                      height: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child:
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : listUsaha.isEmpty
                        ? Center(child: Text("Tidak ada data."))
                        : ListView.separated(
                          itemCount: listUsaha.length,
                          separatorBuilder:
                              (context, index) => SizedBox(height: 18.h),
                          itemBuilder: (context, index) {
                            return BusinesslistItemWidget(
                              bisnis: listUsaha[index],
                              onTapColumnlineone: () {
                                onTapColumnLineone(context, listUsaha[index]);
                              },
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.arrowleft,
        margin: EdgeInsets.only(left: 20.h),
        onTap: () => Navigator.pop(context),
      ),
      title: AppbarSubtitle(
        text: "Pelaku Usaha",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  void onTapColumnLineone(BuildContext context, BusinessModel dataUsaha) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InformasiUsahaScreen(dataUsaha: dataUsaha),
      ),
    );
  }
}
