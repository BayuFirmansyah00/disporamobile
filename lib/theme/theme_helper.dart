import 'package:flutter/material.dart';
import '../core/app_export.dart';

String _appTheme = "lightCode";

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors(),
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme,
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme = _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appTheme.gray10001,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: appTheme.indigo500,
          side: BorderSide(
            color: colorScheme.onPrimary,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray300,
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 16.0,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.gray500,
          fontSize: 14.0,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.gray500,
          fontSize: 12.0,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 24.0,
          fontFamily: 'KoHo',
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 10.0,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: appTheme.gray900,
          fontSize: 18.0,
          fontFamily: 'Archivo',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: appTheme.gray900,
          fontSize: 14.0,
          fontFamily: 'Archivo',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0xFF265780),
    onPrimary: Color(0xFFFFFFFF),
    onPrimaryContainer: Color(0xFF0C3555),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0xFF000000);
  // Blue
  Color get blue800 => Color(0xFF1A74BB);
  // BlueGray
  Color get blueGray100 => Color(0xFFD9D9D9);
  Color get blueGray200 => Color(0xFFBCC1CA);
  Color get blueGray900 => Color(0xFF323842);
  // DeepOrange
  Color get deepOrange300 => Color(0xFFFF7C63);
  // DeepPurple
  Color get deepPurple400 => Color(0xFF7F55E0);
  // Gray
  Color get gray100 => Color(0xFFF3F4F6);
  Color get gray10001 => Color(0xFFF5F2FD);
  Color get gray300 => Color(0xFFDEE1E6);
  Color get gray400 => Color(0xFFC4C4C4);
  Color get gray500 => Color(0xFF9095A0);
  Color get gray700 => Color(0xFF57585E);
  Color get gray70001 => Color(0xFF565E6C);
  Color get gray900 => Color(0xFF171A1F);
  // Indigo
  Color get indigo100 => Color(0xFFCED0F8);
  Color get indigo500 => Color(0xFF4639CE);
  // LightBlue
  Color get lightBlue800 => Color(0xFF087189);
  Color get lightBlue80001 => Color(0xFF0067B3);
  // Red
  Color get red100 => Color(0xFFF8CEDB);
  Color get red500 => Color(0xFFF95738);
}