import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Shown briefly while a persisted session is restored on app start.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.ink,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Image.asset('assets/branding/logo.png', width: 220),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(color: AppColors.gold),
          ],
        ),
      ),
    );
  }
}
