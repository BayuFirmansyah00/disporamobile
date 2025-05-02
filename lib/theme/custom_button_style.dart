import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillBlueGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.blueGray100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
      );

  // Outline button style
  static ButtonStyle get outlineOnPrimary => OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: theme.colorScheme.onPrimary,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.h),
        ),
        padding: EdgeInsets.zero,
      );

  // Text button style
  static ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
    backgroundColor: theme.colorScheme.onPrimary,
    side: BorderSide(
      color: theme.colorScheme.primary,
      width: 1,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.h),
    ),
    padding: EdgeInsets.zero,
  );
  //text button style
  static ButtonStyle get non => ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
    elevation: WidgetStateProperty.all<double>(0),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
    side: WidgetStateProperty.all<BorderSide>(
      BorderSide(color:   Colors.transparent),
    )
  );
}