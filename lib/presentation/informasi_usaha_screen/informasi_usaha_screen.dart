import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import for CameraPosition
import '../../core/app_export.dart';
import 'widgets/informasi_usaha_item_widget.dart';
import '../../models/BusinessModel.dart';
import '../../models/ProdukModel.dart';
import '../../config/Config.dart';

class InformasiUsahaScreen extends StatefulWidget {
  final BusinessModel dataUsaha;
  const InformasiUsahaScreen({Key? key, required this.dataUsaha}) : super(key: key);

  @override
  _InformasiUsahaScreenState createState() => _InformasiUsahaScreenState();
}

class _InformasiUsahaScreenState extends State<InformasiUsahaScreen> {
  List<ProdukModel> daftarProduk = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      daftarProduk = widget.dataUsaha.daftarProduk;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataUsaha.namaUsaha.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Data usaha tidak tersedia")),
      );
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNavigationRow(context),
                SizedBox(height: 16.h),
                _buildBusinessInfoRow(context),
                SizedBox(height: 24.h),
                _buildMapSection(context),
                SizedBox(height: 24.h),
                _buildGallerySection(context),
                SizedBox(height: 24.h),
                _buildProductInformationColumn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRow(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: ImageConstant.arrowleft,
          height: 24.h,
          width: 24.h,
          onTap: () => Navigator.pop(context),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.h),
          child: Text(
            "Informasi Usaha",
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 18.fSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessInfoRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60.h,
          width: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.h),
            color: Colors.grey[200],
            image: widget.dataUsaha.logoUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(widget.dataUsaha.logoUrl),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      debugPrint('Gagal load logo: $error');
                    },
                  )
                : null,
          ),
          child: widget.dataUsaha.logoUrl.isEmpty
              ? Icon(Icons.image_not_supported, size: 40, color: Colors.grey)
              : null,
        ),
        SizedBox(width: 16.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.dataUsaha.namaUsaha,
                style: CustomTextStyles.titleSmallBluegray900?.copyWith(
                  fontSize: 16.fSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.dataUsaha.sektor,
                style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.dataUsaha.namaPemilik,
                style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 4.h),
              if (widget.dataUsaha.noHp?.isNotEmpty == true)
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgCall,
                      height: 16.h,
                      width: 16.h,
                    ),
                    SizedBox(width: 8.h),
                    Text(
                      widget.dataUsaha.noHp!,
                      style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              SizedBox(height: 4.h),
              if (widget.dataUsaha.alamat?.isNotEmpty == true)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath:'assets/images/Location.png',
                      height: 16.h,
                      width: 16.h,
                    ),
                    SizedBox(width: 8.h),
                    Expanded(
                      child: Text(
                        widget.dataUsaha.alamat!,
                        style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

Widget _buildMapSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Lokasi Usaha",
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 16.fSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 8.h),
      Container(
        height: 150.h,
        child: gmaps.GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.dataUsaha.latitude != null && widget.dataUsaha.longitude != null
                ? LatLng(widget.dataUsaha.latitude!, widget.dataUsaha.longitude!)
                : const LatLng(-6.914744, 107.60981),
            zoom: 13.0,
          ),
          markers: {
            if (widget.dataUsaha.latitude != null && widget.dataUsaha.longitude != null)
              gmaps.Marker(
                markerId: const gmaps.MarkerId('business_location'),
                position: gmaps.LatLng(widget.dataUsaha.latitude!, widget.dataUsaha.longitude!),
              ),
          },
        ),
      ),
    ],
  );
}

  Widget _buildGallerySection(BuildContext context) {
    final List<String> galleryImages = [
      '${Config.baseStorageUrl}/pelaku_usaha/contohproduk.png',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gallery Usaha",
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Berikut beberapa foto mengenai usaha kami",
          style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: galleryImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 8.h),
                width: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.h),
                  image: DecorationImage(
                    image: NetworkImage(galleryImages[index]),
                    fit: BoxFit.cover,
                    onError: (error, stackTrace) {
                      debugPrint('Gagal load gallery: $error - ${galleryImages[index]}');
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductInformationColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Informasi Produk",
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 16.fSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Berikut beberapa contoh produk dari usaha kami",
          style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 12.h),
        isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(child: CircularProgressIndicator()),
              )
            : daftarProduk.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: Text(
                        "Belum ada produk tersedia",
                        style: CustomTextStyles.bodySmall10?.copyWith(color: Colors.grey[600]),
                      ),
                    ),
                  )
                : Column(
                    children: daftarProduk.map((produk) {
                      return InformasiUsahaItemWidget(
                        namaProduk: produk.nama,
                        hargaProduk: produk.harga,
                        informasiProduk: produk.informasi,
                        photo: produk.photo,
                      );
                    }).toList(),
                  ),
      ],
    );
  }
}