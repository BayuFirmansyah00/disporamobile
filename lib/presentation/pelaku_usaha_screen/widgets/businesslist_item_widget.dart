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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      bisnis.logoUrl,
                      height: 60.0,
                      width: 60.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Gagal memuat logo: $error, URL: ${bisnis.logoUrl}');
                        return Container(
                          height: 60.0,
                          width: 60.0,
                          color: appTheme.gray400,
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bisnis.namaUsaha,
                            style: CustomTextStyles.titleSmallInter.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            bisnis.sektor,
                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 6.0),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  bisnis.fotoPemilik ?? 'https://via.placeholder.com/36',
                                  height: 36.0,
                                  width: 36.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Gagal memuat foto pemilik: $error, URL: ${bisnis.fotoPemilik}');
                                    return Container(
                                      height: 36.0,
                                      width: 36.0,
                                      color: appTheme.gray400,
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
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
                          const SizedBox(height: 12.0),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
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