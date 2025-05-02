import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlack => BoxDecoration(color: appTheme.black900);
  static BoxDecoration get fillBlueGray => BoxDecoration(color: appTheme.blueGray100);
  static BoxDecoration get fillGray => BoxDecoration(color: appTheme.gray400);
  static BoxDecoration get fillGray100 => BoxDecoration(color: appTheme.gray100);
  static BoxDecoration get fillIndigo => BoxDecoration(color: appTheme.indigo100);
  static BoxDecoration get fillOnPrimary => BoxDecoration(color: theme.colorScheme.onPrimary);
  static BoxDecoration get fillRed => BoxDecoration(color: appTheme.red100);

  // Gradient decorations
  static BoxDecoration get gradientOnPrimaryContainerToBlue => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.77, 0.89),
          end: Alignment(-0.04, -0.18),
          colors: [theme.colorScheme.onPrimaryContainer, appTheme.blue800],
        ),
      );

  // Outline decorations
  static BoxDecoration get outlineGray => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: appTheme.gray900.withValues(alpha: 0.07),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 0),
          ),
        ],
      );

  static BoxDecoration get outlineGray100 => BoxDecoration(
        border: Border.all(
          color: appTheme.gray100,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineGray1001 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: Border.all(
          color: appTheme.gray100,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineGray300 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: Border.all(
          color: appTheme.gray300,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        border: Border.all(
          color: theme.colorScheme.onPrimary,
          width: 1.h,
        ),
      );

  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );

  // Column decorations
  static BoxDecoration get column5 => BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(ImageConstant.imgGroup47277),
          fit: BoxFit.fill,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder20 => BorderRadius.circular(20.h);

  // Custom borders
  static BorderRadius get customBorderTL16 => BorderRadius.vertical(top: Radius.circular(16.h));
  static BorderRadius get customBorderTL20 => BorderRadius.vertical(top: Radius.circular(20.h));
  static BorderRadius get customBorderTL6 => BorderRadius.horizontal(left: Radius.circular(6.h));

  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(10.h);
  static BorderRadius get roundedBorder16 => BorderRadius.circular(16.h);
  static BorderRadius get roundedBorder6 => BorderRadius.circular(6.h);
}