import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'widgets/informasi_usaha_item_widget.dart';
import '../../models/BusinessModel.dart';
import '../../models/ProdukModel.dart';

class InformasiUsahaScreen extends StatelessWidget {
  final BusinessModel dataUsaha;
  const InformasiUsahaScreen({Key? key, required this.dataUsaha})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final BusinessModel dataUsaha =
    //     ModalRoute.of(context)?.settings.arguments as BusinessModel;

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
              SizedBox(
                height: 24.h,
              ), // Perbaikan jarak antara konten dan produk
              _buildProductInformationColumn(context, dataUsaha.daftarProduk),
            ],
          ),
        ),
      ),
    );
  }
}

/// Section Widget: Navigation Row
Widget _buildNavigationRow(BuildContext context) {
  return SizedBox(
    width: double.maxFinite,
    child: Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.arrowleft,
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

/// Section Widget: Business Info Row
Widget _buildBusinessInfoRow(BuildContext context, BusinessModel dataUsaha) {
  return Padding(
    padding: EdgeInsets.only(
      top: 16.h,
    ), // Tambahkan padding untuk elemen ke atas
    child: Row(
      children: [
        // Bagian Logo
        Container(
          height: 150.h,
          width: 102.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(6.h)),
            color: Colors.grey[200], // warna background agar terlihat kotaknya
            image:
                dataUsaha.logoUrl.isNotEmpty
                    ? DecorationImage(
                      image: NetworkImage(dataUsaha.logoUrl),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) {
                        debugPrint('Gagal load logo: $error');
                      },
                    )
                    : null,
          ),
          child:
              dataUsaha.logoUrl.isEmpty
                  ? Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.grey,
                  )
                  : null,
        ),

        SizedBox(
          width: 12.h,
        ), // Memberikan jarak antara logo dan informasi usaha
        // Bagian Informasi Usaha
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama Usaha
              Text(
                dataUsaha.namaUsaha,
                style: CustomTextStyles.titleSmallBluegray900,
              ),
              SizedBox(
                height: 8.h,
              ), // Memberikan jarak antara Nama Usaha dan Sektor
              // Sektor Usaha
              Text(dataUsaha.sektor),
              SizedBox(
                height: 8.h,
              ), // Memberikan jarak antara Sektor dan kontak
              // Mode Pemesanan (tampilkan jika ada)
              if (dataUsaha.modePemesanan?.isNotEmpty == true)
                _buildContactInfoRow(
                  context,
                  callImage: Image.asset(ImageConstant.phone),
                  phoneNumber: dataUsaha.modePemesanan!,
                ),

              if (dataUsaha.noHp?.isNotEmpty == true)
                _buildContactInfoRow(
                  context,
                  callImage: Image.asset(ImageConstant.imgCall),
                  phoneNumber: dataUsaha.noHp!,
                ),

              if (dataUsaha.alamat?.isNotEmpty == true)
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLinkedin,
                      height: 16.h,
                      width: 16.h,
                    ),
                    SizedBox(width: 8.h),
                    Text(
                      dataUsaha.alamat!,
                      style: CustomTextStyles.bodySmall10,
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

/// Section Widget: Product Information Column
Widget _buildProductInformationColumn(
  BuildContext context,
  List<ProdukModel> daftarProduk,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
        daftarProduk.map((produk) {
          return InformasiUsahaItemWidget(
            namaProduk: produk.nama,
            hargaProduk: produk.harga,
            informasiProduk: produk.informasi,
          );
        }).toList(),
  );
}

/// Common widget: Contact Info Row
Widget _buildContactInfoRow(
  BuildContext context, {
  required Widget callImage, // changed to Widget type for flexibility
  required String phoneNumber,
}) {
  return Row(
    children: [
      callImage, // Use the callImage as a Widget
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
