import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class AppbarSubtitle extends StatelessWidget{
  AppbarSubtitle({Key? Key, required this.text, this.onTap, this.margin})
      : super(
        key: Key,
        );

  final String text;

  final Function? onTap;

  final EdgeInsetsGeometry? margin;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Text(
          text,
          style: theme.textTheme.titleMedium!.copyWith(
            color: appTheme.gray900,
          ),
        ),
      ),
    );
  }
}