import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class DeviceTokenEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {const Scope('role:staff')};

  /// Upserts this user's push token -- see DeviceTokenRecord for why
  /// "one row per user, last write wins" is the right model here.
  Future<void> registerToken(Session session, String fcmToken) async {
    final userId = UuidValue.fromString(session.authenticated!.userIdentifier);
    final now = DateTime.now().toUtc();

    final existing = await DeviceTokenRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );

    if (existing.isEmpty) {
      await DeviceTokenRecord.db.insertRow(
        session,
        DeviceTokenRecord(userId: userId, fcmToken: fcmToken, updatedAt: now),
      );
    } else {
      await DeviceTokenRecord.db.updateRow(
        session,
        existing.first.copyWith(fcmToken: fcmToken, updatedAt: now),
      );
    }
  }
}
