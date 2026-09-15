import 'package:flutter/material.dart';

/// A&A's brand colors, sampled from the real logo
/// (`assets/branding/logo.png`): a saturated gold "A" and a warm cream
/// "&A"/tagline, both designed to glow against a near-black surface.
abstract final class AppColors {
  static const gold = Color(0xFFF5B800);
  static const cream = Color(0xFFF6EED9);
  static const ink = Color(0xFF16130F);
}

abstract final class AppTheme {
  static ThemeData get light => _themeFor(Brightness.light);

  static ThemeData get dark => _themeFor(Brightness.dark);

  static ThemeData _themeFor(Brightness brightness) {
    final isLight = brightness == Brightness.light;

    // The logo's native habitat is gold+cream glowing on near-black, so the
    // app bar and brand-colored buttons stay gold-on-ink in both modes
    // rather than flipping with the theme -- what actually changes between
    // light/dark is the page background and body text color.
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.gold,
      brightness: brightness,
    ).copyWith(
      primary: AppColors.gold,
      onPrimary: AppColors.ink,
      surface: isLight ? const Color(0xFFFFFBF2) : const Color(0xFF211C15),
      onSurface: isLight ? AppColors.ink : AppColors.cream,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.ink,
        foregroundColor: AppColors.gold,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.ink,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.ink,
        ),
      ),
    );
  }
}
