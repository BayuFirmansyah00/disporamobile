import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../core/app_export.dart';

class AppbarLeadingImage extends StatelessWidget{
  AppbarLeadingImage(
    {Key? Key,
    this.imagePath,
    this.height,
    this.width,
    this.onTap,
    this.margin})
    : super(key: Key,
    );

  final double? height;

  final double? width;

  final String? imagePath;

  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: CustomImageView(
          imagePath: imagePath!,
          height: height ?? 20.h,
          width: width ?? 20.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}