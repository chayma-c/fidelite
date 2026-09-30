import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Returns the caller's own app-owned profile row. Not load-bearing for
/// routing/authorization -- the client already has its own id/roles from
/// the auth session -- this is only for screens that want to display
/// account details (see meProvider on the Flutter side).
class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AppUserRecord> getMe(Session session) async {
    final userId = UuidValue.fromString(
      session.authenticated!.userIdentifier,
    );
    final user = await AppUserRecord.db.findById(session, userId);
    if (user == null) {
      throw StateError('Authenticated user has no AppUserRecord.');
    }
    return user;
  }
}
