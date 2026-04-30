import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF0D631B);
  static const primaryContainer = Color(0xFF2E7D32);
  static const onPrimary = Color(0xFFFFFFFF);
  static const background = Color(0xFFF7FBF0);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFE0E4DA);
  static const surfaceContainer = Color(0xFFEBEFE5);
  static const surfaceContainerHigh = Color(0xFFE5EADF);
  static const onSurface = Color(0xFF181D17);
  static const onSurfaceVariant = Color(0xFF40493D);
  static const outline = Color(0xFF707A6C);
  static const outlineVariant = Color(0xFFBFCABA);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onError = Color(0xFFFFFFFF);
  static const secondaryFixed = Color(0xFFD9E6DA);
  static const onSecondaryFixed = Color(0xFF131E17);
  static const onPrimaryContainer = Color(0xFFCBFFC2);
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double gutter = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

class AppRadius {
  static const double small = 4;
  static const double lg = 8;
  static const double xl = 12;
  static const double full = 999;
}

class AppTextStyles {
  static TextStyle h1 = GoogleFonts.epilogue(
    fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 1.2,
    color: AppColors.onSurface,
  );
  static TextStyle h2 = GoogleFonts.epilogue(
    fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.9,
    color: AppColors.onSurface,
  );
  static TextStyle labelBold = GoogleFonts.epilogue(
    fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.96,
    color: AppColors.onSurface,
  );
  static TextStyle buttonText = GoogleFonts.epilogue(
    fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7,
    color: AppColors.onPrimary,
  );
  static TextStyle bodyMd = GoogleFonts.workSans(
    fontSize: 14, fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
  static TextStyle bodyLg = GoogleFonts.workSans(
    fontSize: 16, fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );
}

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.error,
    ),
    textTheme: GoogleFonts.workSansTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: const BorderSide(color: AppColors.surfaceVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: const BorderSide(color: AppColors.surfaceVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        borderSide: const BorderSide(color: AppColors.primaryContainer, width: 1.5),
      ),
      hintStyle: TextStyle(color: AppColors.outline),
    ),
  );
}