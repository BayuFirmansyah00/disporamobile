import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../config/Config.dart';

class InformasiUsahaItemWidget extends StatelessWidget {
  final String namaProduk;
  final String informasiProduk;
  final String hargaProduk;
  final String photo;

  const InformasiUsahaItemWidget({
    Key? key,
    required this.namaProduk,
    required this.informasiProduk,
    required this.hargaProduk,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = photo.isNotEmpty && !photo.startsWith('http')
        ? '${Config.baseStorageUrl}/pelaku_usaha/$photo'
        : photo.isNotEmpty
            ? photo
            : '${Config.baseStorageUrl}/pelaku_usaha/contohproduk.png'; // Fallback ke contohproduk.png

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: AppDecoration.outlineGray1001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100.h,
            width: 96.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(6.h),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {
                  debugPrint('Gagal load gambar produk: $error - $imageUrl');
                },
              ),
            ),
            child: imageUrl.isEmpty || imageUrl == '${Config.baseStorageUrl}/pelaku_usaha/'
                ? Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.grey,
                  )
                : null,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaProduk,
                    style: CustomTextStyles.titleSmallBluegray900?.copyWith(
                      fontSize: 14.fSize,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    informasiProduk,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmall10.copyWith(
                      height: 1.60,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Harga: Rp $hargaProduk",
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}