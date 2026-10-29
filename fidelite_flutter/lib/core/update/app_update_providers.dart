import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

/// The GitHub repo customers' APK is distributed from -- see SETUP.md's
/// "customer distribution" section.
const _repoOwner = 'chayma-c';
const _repoName = 'fidelite';
const _latestReleaseApiUrl =
    'https://api.github.com/repos/$_repoOwner/$_repoName/releases/latest';

/// The stable URL a customer re-downloads from -- always resolves to
/// whichever release is currently flagged "latest" on GitHub, so this
/// link (and the printed/QR one customers already use) never goes stale
/// regardless of how many versions get tagged after it.
const latestApkDownloadUrl =
    'https://github.com/$_repoOwner/$_repoName/releases/latest/download/fidelite.apk';

/// The version baked into this exact running build (from pubspec.yaml's
/// `version:` at build time) -- read from the platform's own package info
/// rather than duplicated as a --dart-define, so there's nothing to keep
/// in sync by hand on each release.
final currentAppVersionProvider = FutureProvider.autoDispose<String>((
  ref,
) async {
  final info = await PackageInfo.fromPlatform();
  return info.version;
});

/// The version tag of whatever's currently flagged "latest" on GitHub.
/// Null (not an error state) on any failure -- offline, GitHub
/// unreachable, rate-limited, whatever -- since "can't tell if there's an
/// update" should just mean no banner, not an error shown to the customer
/// over an otherwise perfectly working app.
final latestReleaseVersionProvider = FutureProvider.autoDispose<String?>((
  ref,
) async {
  try {
    final response = await http
        .get(Uri.parse(_latestReleaseApiUrl))
        .timeout(const Duration(seconds: 5));
    if (response.statusCode != 200) return null;
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return body['tag_name'] as String?;
  } catch (_) {
    return null;
  }
});

/// Whether a newer version than what's currently installed is available --
/// the one thing the update banner actually needs, combining
/// [currentAppVersionProvider] and [latestReleaseVersionProvider] so the
/// banner itself doesn't have to reason about either individually.
final updateAvailableProvider = FutureProvider.autoDispose<bool>((ref) async {
  // This update path is specifically "re-download and sideload a fresh
  // APK" -- meaningless on web (refreshing the page always serves
  // whatever's currently deployed, nothing to install) and not
  // applicable to any platform this isn't actually distributed on.
  if (kIsWeb || !Platform.isAndroid) return false;

  final latest = await ref.watch(latestReleaseVersionProvider.future);
  if (latest == null) return false;
  final current = await ref.watch(currentAppVersionProvider.future);
  return _isNewer(latest: latest, current: current);
});

/// Plain numeric version comparison (e.g. "1.10.0" > "1.9.0") -- both
/// GitHub's release tags and PackageInfo.version are plain `major.minor
/// .patch` strings with no `v` prefix or pre-release suffix (see
/// SETUP.md's customer-distribution section), so nothing fancier than
/// this is needed.
bool _isNewer({required String latest, required String current}) {
  final latestParts = _versionParts(latest);
  final currentParts = _versionParts(current);
  for (var i = 0; i < 3; i++) {
    if (latestParts[i] != currentParts[i]) {
      return latestParts[i] > currentParts[i];
    }
  }
  return false;
}

List<int> _versionParts(String version) {
  final parts = version.split('.').map((p) => int.tryParse(p) ?? 0).toList();
  return List.generate(3, (i) => i < parts.length ? parts[i] : 0);
}
