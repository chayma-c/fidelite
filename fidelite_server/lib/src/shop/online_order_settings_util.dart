import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// The one-and-only [OnlineOrderSettingsRecord] row -- same lazy-create
/// pattern as currentShopStatusOrDefault, for the same reason: a fresh
/// deploy shouldn't error just because nobody has touched this setting yet.
Future<OnlineOrderSettingsRecord> currentOnlineOrderSettingsOrDefault(
  Session session,
) async {
  final existing = await OnlineOrderSettingsRecord.db.findFirstRow(session);
  if (existing != null) return existing;
  return OnlineOrderSettingsRecord.db.insertRow(
    session,
    OnlineOrderSettingsRecord(
      autoPrintEnabled: false,
      updatedAt: DateTime.now().toUtc(),
    ),
  );
}
