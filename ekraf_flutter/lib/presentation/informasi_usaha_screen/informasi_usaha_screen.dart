import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/informasi_usaha_item_widget.dart';

class InformasiUsahaScreen extends StatelessWidget {
  const InformasiUsahaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> dataUsaha =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    if (dataUsaha == null) {
      return const Scaffold(
        body: Center(child: Text("Data usaha tidak tersedia")),
      );
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 18.h, top: 66.h, right: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNavigationRow(context),
              SizedBox(height: 12.h),
              _buildBusinessInfoRow(context, dataUsaha),
              SizedBox(height: 52.h),
              _buildProductInformationColumn(context, dataUsaha['produk']),
            ],
          ),
        ),
      ),
    );
  }
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
Widget _buildBusinessInfoRow(
  BuildContext context,
  Map<String, dynamic> dataUsaha,
) {
  return Row(
    children: [
      Container(
        height: 150.h,
        width: 102.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(dataUsaha['logo_url']),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.horizontal(left: Radius.circular(6.h)),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dataUsaha['nama_toko'],
              style: CustomTextStyles.titleSmallBluegray900,
            ),
            Text(
              dataUsaha['sektor_id'].toString(),
            ), // ubah jadi nama sektor kalau perlu
            _buildContactInfoRow(
              context,
              callImage: ImageConstant.imgUser,
              phoneNumber: dataUsaha['mode_pemesanan'],
            ),
            _buildContactInfoRow(
              context,
              callImage: ImageConstant.imgCall,
              phoneNumber: dataUsaha['no_hp'],
            ),
            Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLinkedin,
                  height: 16.h,
                  width: 16.h,
                ),
                Text(dataUsaha['alamat'], style: CustomTextStyles.bodySmall10),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

/// Section Widget
Widget _buildProductInformationColumn(BuildContext context, List produkList) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Informasi Produk", style: theme.textTheme.titleMedium),
        Expanded(
          child: ListView.builder(
            itemCount: produkList.length,
            itemBuilder: (context, index) {
              final produk = produkList[index];
              return ListTile(
                leading: Image.network(produk['foto_url']),
                title: Text(produk['nama']),
                subtitle: Text(produk['informasi']),
                trailing: Text("Rp${produk['harga']}"),
              );
            },
          ),
        ),
      ],
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
          style: CustomTextStyles.bodySmall10.copyWith(color: appTheme.gray500),
        ),
      ),
    ],
  );
}

/// Navigates back to the previous screen.
void onTapImgArrowLeft(BuildContext context) {
  Navigator.pop(context);
}
