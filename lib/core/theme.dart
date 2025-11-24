import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized app theme and typography for HoopHub.
/// Uses two Google Fonts:
/// - Merriweather for headings (serif, strong presence)
/// - Poppins for body text (clean, geometric sans)

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF6F00); // energetic orange
  static const Color onPrimary = Colors.white;
  static const Color secondary = Color(0xFF0B3D91); // navy
  static const Color onSecondary = Colors.white;
  static const Color background = Color(0xFFF5F7FB);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);
  static const Color textPrimary = Color(0xFF0F1724);
  static const Color textSecondary = Color(0xFF52606D);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      background: AppColors.background,
      onBackground: AppColors.textPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: Colors.white,
    );

    return ThemeData(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: _heading1.copyWith(color: colorScheme.onPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: _button,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black87,
        contentTextStyle: _body.copyWith(color: Colors.white),
      ),
      // Typography
      textTheme: _appTextTheme,
    );
  }

  // Heading font: Merriweather (serif) — good presence for titles
  static final TextStyle _heading1 = GoogleFonts.merriweather(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle _heading2 = GoogleFonts.merriweather(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body font: Poppins (sans) — clean and legible for UI copy
  static final TextStyle _body = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static final TextStyle _bodySmall = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle _button = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static TextTheme get _appTextTheme => TextTheme(
        displayLarge: GoogleFonts.merriweather(fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        displayMedium: GoogleFonts.merriweather(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        displaySmall: GoogleFonts.merriweather(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        headlineLarge: _heading1,
        headlineMedium: _heading2,
        titleLarge: GoogleFonts.merriweather(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        titleMedium: GoogleFonts.merriweather(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        bodyLarge: _body,
        bodyMedium: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textPrimary),
        bodySmall: _bodySmall,
        labelLarge: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        labelSmall: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
      );
}
