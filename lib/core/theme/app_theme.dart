import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0B1B4A),
    onPrimary: Colors.white,
    secondary: Color(0xFF5B7CFA),
    onSecondary: Colors.white,
    error: Color(0xFFB3261E),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF0E1630),
    outline: Color(0xFF8D97B5),
  );

  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA9BCFF),
    onPrimary: Color(0xFF0B1B4A),
    secondary: Color(0xFF8EA8FF),
    onSecondary: Color(0xFF0B1B4A),
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    surface: Color(0xFF111F52),
    onSurface: Color(0xFFEEF2FF),
    outline: Color(0xFF7A86AD),
  );

  static ThemeData get light => _build(_lightScheme, const Color(0xFFF3F6FF));

  static ThemeData get dark => _build(_darkScheme, const Color(0xFF081038));

  static ThemeData _build(ColorScheme scheme, Color background) {
    final radius = BorderRadius.circular(16);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: 'Poppins',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.outline.withAlpha(90)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.outline.withAlpha(90)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error, width: 2),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}