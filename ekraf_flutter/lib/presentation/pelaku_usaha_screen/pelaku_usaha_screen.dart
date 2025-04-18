import 'package:flutter/material.dart'; 
import '../../core/app_export.dart'; 
import '../../widgets/app_bar/appbar_leading_image.dart'; 
import '../../widgets/app_bar/appbar_subtitle.dart'; 
import '../../widgets/app_bar/custom_app_bar.dart'; 
import '../../widgets/custom_search_view.dart'; 
import 'widgets/businesslist_item_widget.dart'; 

// ignore_for_file: must_be_immutable 
class PelakuUsahaScreen extends StatelessWidget { 
  PelakuUsahaScreen({Key? key}) : super(key: key); 

  final TextEditingController searchController = TextEditingController(); 

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
          padding: EdgeInsets.only(left: 20.h, top: 12.h, right: 20.h,), 
          child: Column( 
            spacing: 26,
            mainAxisSize: MainAxisSize.max,
            children: [ 
              Padding( 
                padding: EdgeInsets.symmetric(horizontal: 22.h), 
                child: CustomSearchView( 
                  controller: searchController, 
                  hintText: "Cari", 
                  contentPadding: EdgeInsets.fromLTRB(16.h, 10.h, 10.h, 10.h), 
                ), 
              ), 
              _buildBusinessList(context) 
            ], 
          ), 
        ), 
      ), 
    ); 
  } 

  /// AppBar Widget 
  PreferredSizeWidget _buildAppBar(BuildContext context) { 
    return CustomAppBar( 
      leadingWidth: 40.h, 
      leading: AppbarLeadingImage( 
        imagePath: ImageConstant.imgArrowLeft, 
        margin: EdgeInsets.only(left: 20.h), 
        onTap: () { 
          onTapArrowLeftone(context); 
        }, 
      ), 
      title: AppbarSubtitle( 
        text: "Pelaku Usaha", 
        margin: EdgeInsets.only(left: 12.h), 
      ), 
    ); 
  } 

  /// Business List Widget 
  Widget _buildBusinessList(BuildContext context) { 
    return Expanded( 
      child: Padding( 
        padding: EdgeInsets.only(right: 12.h), 
        child: ListView.separated( 
          padding: EdgeInsets.zero, 
          physics: BouncingScrollPhysics(), 
          shrinkWrap: true, 
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 18.h,
            );
          },
          itemCount: 4, 
          itemBuilder: (context, index) { 
            return BusinesslistItemWidget( 
              onTapColumnlineone: () { 
                onTapColumnLineone(context); 
              }, 
            ); 
          }, 
        ), 
      ), 
    ); 
  } 

  /// Navigates back to the previous screen. 
  void onTapArrowLeftone(BuildContext context) { 
    Navigator.pop(context); 
  } 

  /// Navigates to the informasiUsahaScreen when the action is triggered. 
  void onTapColumnLineone(BuildContext context) { 
    Navigator.pushNamed(context, AppRoutes.informasiUsahaScreen); 
  } 
}