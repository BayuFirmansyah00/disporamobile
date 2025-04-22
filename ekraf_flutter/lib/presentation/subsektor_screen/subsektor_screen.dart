import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'widgets/subsektorlist_item_widget.dart';
import '../../services/api_service.dart';
import '../pelaku_usaha_screen/pelaku_usaha_screen.dart';

// ignore_for_file: must_be_immutable
class SubsektorScreen extends StatefulWidget {
  const SubsektorScreen({Key? key, required this.sector}) : super(key: key);

  final Map<String, String> sector;

  @override
  _SubsektorScreenState createState() => _SubsektorScreenState();
}

class _SubsektorScreenState extends State<SubsektorScreen> {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> subsektorList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubsektorData();
  }

  Future<void> fetchSubsektorData() async {
    try {
      final sektorId = widget.sector['id'];
      print("SEKTOR ID YANG DIKIRIM: $sektorId");

      final response = await ApiService.get('subsektor?sektor_id=$sektorId');
      print("RESPONS API: $response");

      setState(() {
        subsektorList = response;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching subsektor: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.h),
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
              SizedBox(height: 16.h),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _buildSubsektorList(context),
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
        imagePath: ImageConstant.arrowleft,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarSubtitle(
        text: "Sub Sektor ${widget.sector['name'] ?? ''}",
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
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemCount: subsektorList.length,
          itemBuilder: (context, index) {
            final subsektor = subsektorList[index];
            return SubsektorlistItemWidget(
              title: subsektor['nama'],
              imageUrl: subsektor['gambar_url'],
              description: subsektor['keterangan'],
              jumlahUsaha: subsektor['jumlah_pengusaha'].toString(),
              onTapRowsunglasses:
                  () => onTapRowsunglasses(context, subsektor['id']),
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
  void onTapRowsunglasses(BuildContext context, int subsektorId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PelakuUsahaScreen(subsektorId: subsektorId),
    ),
  );
}
}
