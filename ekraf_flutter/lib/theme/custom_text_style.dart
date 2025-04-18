import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// Extension to easily apply specific font families to text.
extension on TextStyle {
  TextStyle get archivo {
    return copyWith(fontFamily: 'Archivo');
  }

  TextStyle get inter {
    return copyWith(fontFamily: 'Inter');
  }

  TextStyle get montserrat {
    return copyWith(fontFamily: 'Montserrat');
  }
}

/// A collection of pre-defined text styles for customizing text appearance.
class CustomTextStyles {
  // Body text styles
  static TextStyle get bodyLargeInterBluegray200 =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: appTheme.blueGray200,
      );

  static TextStyle get bodyMedium13 =>
      theme.textTheme.bodyMedium!.copyWith(fontSize: 13.fSize);

  static TextStyle get bodySmall10 =>
      theme.textTheme.bodySmall!.copyWith(fontSize: 10.fSize);

  static TextStyle get bodySmall10_1 =>
      theme.textTheme.bodySmall!.copyWith(fontSize: 10.fSize);

  static TextStyle get bodySmallArchivoGray70001 =>
      theme.textTheme.bodySmall!.archivo.copyWith(
        color: appTheme.gray70001,
      );

  static TextStyle get bodySmallDeepPurple400 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.deepPurple400,
        fontSize: 11.fSize,
      );

  static TextStyle get bodySmallGray900 =>
      theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray900,
        fontSize: 11.fSize,
      );

  static TextStyle get bodySmallGray900_1 =>
      theme.textTheme.bodySmall!.copyWith(color: appTheme.gray900);

  static TextStyle get bodySmallOnPrimary =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 10.fSize,
      );

  // Inter text styles
  static TextStyle get interPrimary => TextStyle(
        color: theme.colorScheme.primary,
        fontSize: 7.fSize,
        fontWeight: FontWeight.w400,
      ).inter;

  // Montserrat text styles
  static TextStyle get montserratOnPrimary => TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 6.fSize,
        fontWeight: FontWeight.w400,
      ).montserrat;

  // Title text styles
  static TextStyle get titleMediumInter =>
      theme.textTheme.titleMedium!.inter.copyWith(fontSize: 16.fSize);

  static TextStyle get titleMediumInterMedium =>
      theme.textTheme.titleMedium!.inter.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleMediumSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get titleSmallBluegray900 =>
      theme.textTheme.titleSmall!.copyWith(color: appTheme.blueGray900);

  static TextStyle get titleSmallBluegray900Medium =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleSmallBluegray900SemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w600,
      );

  static get titleSmallInter => theme.textTheme.titleSmall!.inter;

  static TextStyle get titleSmallMontserratOnPrimary =>
      theme.textTheme.titleSmall!.montserrat.copyWith(
        color: theme.colorScheme.onPrimary,
      );
}
