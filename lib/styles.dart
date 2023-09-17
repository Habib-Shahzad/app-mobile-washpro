import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static ThemeData mainTheme = ThemeData(
    colorScheme: _colorScheme,
    textTheme: _textTheme,
    primaryColor: _colorScheme.primary,
  );

  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2FCCC0),
    primaryContainer: Color(0xFF0061FE),
    secondary: Color(0xFFDFEBFF),
    secondaryContainer: Color(0xFFCFE0FF),
    error: Color(0xFFFFEAEA),
    surface: Color(0xFFE7E7E7),
    background: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFF737478),
    onSurfaceVariant: Color(0xFF848484),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF0061FE),
    onSecondaryContainer: Color(0xFFF0FAFF),
    onError: Color(0xFFD53030),
    onSurface: Color(0xFFA6A6A6),
    onBackground: Color(0xFF081C43),
    tertiary: Color(0xFFD9FFE1),
    onTertiary: Color(0xFF00CB2D),
  );

  static final TextTheme _textTheme = TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 25,
      fontWeight: FontWeight.w300,
    ),
    titleMedium: GoogleFonts.poppins(),
    bodyMedium: GoogleFonts.poppins(),
    displaySmall: GoogleFonts.poppins(),
  );
}
