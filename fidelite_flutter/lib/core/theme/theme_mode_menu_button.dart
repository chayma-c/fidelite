import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_mode_controller.dart';

/// An app bar action letting the user pick light/dark/system, independent
/// of their OS setting. Shared by every screen with a theme toggle rather
/// than duplicated per page.
class ThemeModeMenuButton extends ConsumerWidget {
  const ThemeModeMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeControllerProvider);

    return PopupMenuButton<ThemeMode>(
      tooltip: 'Theme',
      icon: Icon(_iconFor(mode)),
      onSelected: (selected) =>
          ref.read(themeModeControllerProvider.notifier).setThemeMode(selected),
      itemBuilder: (context) => [
        _entry(ThemeMode.system, 'System', mode),
        _entry(ThemeMode.light, 'Light', mode),
        _entry(ThemeMode.dark, 'Dark', mode),
      ],
    );
  }

  PopupMenuItem<ThemeMode> _entry(ThemeMode value, String label, ThemeMode current) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(_iconFor(value), size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          if (value == current) const Icon(Icons.check, size: 18),
        ],
      ),
    );
  }

  IconData _iconFor(ThemeMode mode) => switch (mode) {
    ThemeMode.system => Icons.brightness_auto,
    ThemeMode.light => Icons.light_mode,
    ThemeMode.dark => Icons.dark_mode,
  };
}
