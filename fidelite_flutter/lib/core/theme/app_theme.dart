import 'package:flutter/material.dart';

/// A&A's brand colors, extracted from the logo (mustard-amber "A" + dark
/// charcoal "&A"). Provisional exact hex values pending the source design
/// file -- easy to swap here once available, nothing else references raw
/// color literals.
abstract final class AppColors {
  static const mustard = Color(0xFFF2A729);
  static const charcoal = Color(0xFF221F1B);
}

abstract final class AppTheme {
  static ThemeData get light => _themeFor(Brightness.light);

  static ThemeData get dark => _themeFor(Brightness.dark);

  static ThemeData _themeFor(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.mustard,
      brightness: brightness,
    ).copyWith(primary: AppColors.mustard, onPrimary: AppColors.charcoal);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.charcoal,
        foregroundColor: AppColors.mustard,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.mustard,
        foregroundColor: AppColors.charcoal,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.mustard,
          foregroundColor: AppColors.charcoal,
        ),
      ),
      scaffoldBackgroundColor: isLight ? Colors.white : AppColors.charcoal,
    );
  }
}
