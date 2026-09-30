import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin JSON read/write helper over `shared_preferences`, used to serve the
/// last-known menu/rewards/wallet data when a screen's live fetch fails --
/// see e.g. `menu_providers.dart` for the cache-through pattern this backs.
/// Not a secret store; `shared_preferences` is the same mechanism already
/// used for the theme preference.
class LocalCache {
  const LocalCache();

  Future<void> writeList<T>(
    String key,
    List<T> items,
    Map<String, dynamic> Function(T item) toJson,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(items.map(toJson).toList()));
  }

  /// Returns null if there's nothing cached yet, or the cached value is
  /// unreadable (e.g. a shape change across an app update) -- either way,
  /// callers should treat that the same as "no cache available".
  Future<List<T>?> readList<T>(
    String key,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> writeValue(String key, Object? jsonValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(jsonValue));
  }

  Future<T?> readValue<T>(String key, T Function(dynamic json) fromJson) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return null;
    try {
      return fromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }
}

final localCacheProvider = Provider<LocalCache>((ref) => const LocalCache());
